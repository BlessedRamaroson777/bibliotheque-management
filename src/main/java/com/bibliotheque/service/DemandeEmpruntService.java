package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class DemandeEmpruntService {

    @Autowired private DemandeEmpruntRepository demandeEmpruntRepository;
    @Autowired private BibliothecaireRepository BibliothecaireRepository;
    @Autowired private MembreRepository membreRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private PretService pretService;
    @Autowired private StatutMembreRepository statutMembreRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private AbonnementRepository abonnementRepository;
    
    // Lister demandes en attente
    public List<DemandeEmprunt> findDemandesEnAttente() {
        return demandeEmpruntRepository.findByStatut("en_attente");
    }

    // Valider demande (prêter l'exemplaire)
    public String validerDemande(Long demandeId, Long idBibliothecaire) {
        Optional<DemandeEmprunt> demandeOpt = demandeEmpruntRepository.findById(demandeId);
        if (demandeOpt.isEmpty()) return "Demande non trouvee.";
        DemandeEmprunt demande = demandeOpt.get();
        if (!demande.getStatut().equals("en_attente"))
            return "Demande deja traitee.";

        Membre membre = demande.getMembre();
        Livre livre = demande.getLivre();
        if (membre == null) return "Erreur : adherent inexistant.";
        if (livre == null) return "Erreur : livre inexistant.";

        // Verifier que l'adherent est actif (avant et après)
        boolean actif = statutMembreRepository.findAll().stream()
            .anyMatch(s -> s.getMembre().getId().equals(membre.getId()) && s.getStatut().getValeur().equalsIgnoreCase("actif"));
        if (!actif) {
            return "Adherent inactif.";
        }
        boolean penalise = penaliteRepository.findAll().stream()
            .anyMatch(p -> p.getMembre().getId().equals(membre.getId()) && p.getDateRetour() == null);
        if (penalise) return "Adherent penalise.";
        
        int quota = membre.getTypeMembre().getQuota();
        long empruntsEnCours = empruntRepository.findByMembreId(membre.getId()).stream()
            .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .count();
        if (empruntsEnCours >= quota) return "Quota d'emprunt atteint.";
        
        if (livre.getAgeMinimum() != null && membre.getNaissance() != null) {
            int age = java.time.Period.between(membre.getNaissance().toLocalDate(), java.time.LocalDate.now()).getYears();
            if (age < livre.getAgeMinimum()) {
                return "Vous n'avez pas l'age minimum requis (" + livre.getAgeMinimum() + " ans) pour emprunter ce livre.";
            }
        }

        List<Exemplaire> exemplaires = exemplaireRepository.findDisponibles(livre.getId(), LocalDateTime.now());
        if (exemplaires.isEmpty()) return "Aucun exemplaire disponible pour ce livre.";
        
        Exemplaire exemplaire = exemplaires.get(0);

        // Attribuer exemplaire et mise a jour statut
        demande.setExemplaire(exemplaire);
        demande.setStatut("validee");
        demande.setDateTraitement(LocalDateTime.now());

        // Assignation bibliothecaire (simplifie)
        Bibliothecaire bibliothecaire = BibliothecaireRepository.findById(idBibliothecaire)
            .orElseThrow(() -> new IllegalArgumentException("Bibliothecaire non trouve"));
        demande.setBibliothecaire(bibliothecaire);

        exemplaireRepository.save(exemplaire);

        demandeEmpruntRepository.save(demande);

        return "Demande validee, exemplaire prête.";
    }

    // Refuser demande
    public String refuserDemande(Long demandeId, Long idBibliothecaire) {
        Optional<DemandeEmprunt> demandeOpt = demandeEmpruntRepository.findById(demandeId);
        if (demandeOpt.isEmpty()) return "Demande non trouvee.";
        DemandeEmprunt demande = demandeOpt.get();
        if (!demande.getStatut().equals("en_attente"))
            return "Demande deja traitee.";

        demande.setStatut("refusee");
        demande.setDateTraitement(LocalDateTime.now());

        Bibliothecaire bibliothecaire = new Bibliothecaire();
        bibliothecaire.setId(idBibliothecaire);
        demande.setBibliothecaire(bibliothecaire);

        demandeEmpruntRepository.save(demande);

        return "Demande refusee.";
    }
     
    public List<DemandeEmprunt> findDemandesNonEnAttente() {
        List<DemandeEmprunt> demandesValidees = demandeEmpruntRepository.findByStatut("validee");
        List<DemandeEmprunt> demandesRefusees = demandeEmpruntRepository.findByStatut("refusee");

        List<DemandeEmprunt> toutesDemandes = new ArrayList<>();
        toutesDemandes.addAll(demandesValidees);
        toutesDemandes.addAll(demandesRefusees);

        return toutesDemandes;
    }

    public String creerDemandeAvecDates(Long idAdherent, Long idLivre, String dateDemandeStr, String datePrevuStr) {
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "Erreur : adherent inexistant.";
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Erreur : livre inexistant.";

        // Convertir les dates reçues (format HTML5 datetime-local : "yyyy-MM-dd'T'HH:mm")
        LocalDateTime dateDemande;
        LocalDateTime datePrevu;
        try {
            dateDemande = LocalDateTime.parse(dateDemandeStr);
            datePrevu = LocalDateTime.parse(datePrevuStr);
        } catch (Exception e) {
            return "Erreur dans le format des dates. Utilisez le format 'yyyy-MM-ddTHH:mm'.";
        }        

        boolean abonnementValide = abonnementRepository.estAbonnementValide(
            membre.getId(), dateDemande);

        if (!abonnementValide) {
            return "Adherent sans abonnement valide.";
        }

        // Verifier quota
        int quota = membre.getTypeMembre().getQuota();
        long empruntsEnCours = empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .count();
        if (empruntsEnCours >= quota) return "Quota d'emprunt atteint.";

        // Verifier l'âge minimum
        if (livre.getAgeMinimum() != null && membre.getNaissance() != null) {
            int age = java.time.Period.between(membre.getNaissance().toLocalDate(), java.time.LocalDate.now()).getYears();
            if (age < livre.getAgeMinimum()) {
                return "Vous n'avez pas l'age minimum requis (" + livre.getAgeMinimum() + " ans) pour ce livre.";
            }
        }
        // Vérifier si l'adhérent est en période de pénalité à la date de demande
        LocalDateTime dateFinPenalite = null;

        for (Penalite p : penaliteRepository.findAll()) {
            if (p.getMembre().getId().equals(idAdherent)
                && p.getDateRetour() != null
                && p.getDuree() != null
                && !dateDemande.isBefore(p.getDateRetour())
                && !dateDemande.isAfter(p.getDateRetour().plusDays(p.getDuree()))) {

                dateFinPenalite = p.getDateRetour().plusDays(p.getDuree());
                break;
            }
        }

        if (dateFinPenalite != null) {
            return "Adherent penalise jusqu a la date " + dateFinPenalite.toLocalDate();
        }

        // Verifier disponibilite des exemplaires
        List<Exemplaire> exemplaires = exemplaireRepository.findDisponibles(idLivre, datePrevu);
        if (exemplaires.isEmpty()) return "Aucun exemplaire disponible pour ce livre.";


        // Creer la demande
        DemandeEmprunt demande = new DemandeEmprunt();
        demande.setMembre(membre);
        demande.setLivre(livre);
        demande.setDateDemande(dateDemande);
        demande.setDatePrevu(datePrevu); 
        demande.setStatut("en_attente");

        demandeEmpruntRepository.save(demande);
        return "Demande enregistree avec les dates specifiees.";
    }

    public List<DemandeEmprunt> findDemandesValideesParAdherent(Long idAdherent) {
        return demandeEmpruntRepository.findByStatutAndMembreId("validee", idAdherent);
    }

    public String creerEmpruntDepuisDemande(Long idDemande) {
        Optional<DemandeEmprunt> opt = demandeEmpruntRepository.findById(idDemande);
        if (!opt.isPresent()) return "Demande introuvable.";

        DemandeEmprunt demande = opt.get();

        if (!"validee".equalsIgnoreCase(demande.getStatut()))
            return "La demande n'est pas validee.";

        
        // 3. Vérifier si l'adhérent est en période de pénalité à la date d'emprunt
        LocalDateTime dateFinPenalite = null;

        for (Penalite p : penaliteRepository.findAll()) {
            if (p.getMembre().getId().equals(demande.getMembre().getId())
                && p.getDateRetour() != null
                && p.getDuree() != null
                && !demande.getDatePrevu().isBefore(p.getDateRetour())
                && !demande.getDatePrevu().isAfter(p.getDateRetour().plusDays(p.getDuree()))) {

                dateFinPenalite = p.getDateRetour().plusDays(p.getDuree());
                break;
            }
        }

        if (dateFinPenalite != null) {
            return "Adherent penalise jusqu a la date " + dateFinPenalite.toLocalDate() + ".";
        }    
        if (demande.getExemplaire() == null)
            return "Exemplaire manquant dans la demande.";
        LocalDateTime dateEcheance = pretService.calculerDateEcheanceSansJoursFeries(demande.getDatePrevu());
        Emprunt emprunt = new Emprunt();
        emprunt.setMembre(demande.getMembre());
        emprunt.setExemplaire(demande.getExemplaire());
        emprunt.setBiblioEmprunt(demande.getBibliothecaire());
        emprunt.setDateEmprunt(demande.getDateTraitement());
        emprunt.setDateDebut(demande.getDatePrevu());
        emprunt.setDateEcheance(dateEcheance);
        emprunt.setSurPlace(false); // selon ton besoin

        empruntRepository.save(emprunt);

        return "Emprunt cree avec succes.";
    }




}
