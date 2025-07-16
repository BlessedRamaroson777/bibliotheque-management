package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class PretService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private AbonnementRepository abonnementRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private AutorisationRepository autorisationRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private DureeEmpruntRepository dureeEmpruntRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;
    @Autowired private JourFerieRepository jourFerieRepository;

    public String preterLivre(Long idAdherent, Long idLivre, LocalDateTime dateEmprunt, Long idBibliothecaire) {
        // 1. Verifier que l'adherent existe
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "Adherent inexistant.";
        
        boolean abonnementValide = abonnementRepository.estAbonnementValide(
            membre.getId(), dateEmprunt);

        if (!abonnementValide) {
            return "Adherent sans abonnement valide.";
        }

        
        // Verifier si l'adherent est en periode de penalite à la date de demande
        long totalPenalite = 0;

        for (Penalite p : penaliteRepository.findAll()) {
            if (p.getMembre().getId().equals(idAdherent)
                && p.getDateRetour() != null
                && p.getDuree() != null
                && !dateEmprunt.isBefore(p.getDateRetour())
                && !dateEmprunt.isAfter(p.getDateRetour().plusDays(p.getDuree()))) {

                totalPenalite += p.getDuree();
            }
        }

        if (totalPenalite > 0) {
            return "Adherent penalise. Total des jours de penalite en cours : " + totalPenalite + " jour(s)";
        } 

        // 4. Verifier que l'adherent n'a pas atteint son quota d'emprunt
        int quota = membre.getTypeMembre().getQuota();
        long empruntsEnCours = empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .count();
        if (empruntsEnCours >= quota) return "Quota d'emprunt atteint.";

        // 5. Verifier que le livre existe
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Livre inexistant.";

        // Verifier l'âge minimum requis
        if (livre.getAgeMinimum() != null && membre.getNaissance() != null) {
            int age = java.time.Period.between(membre.getNaissance().toLocalDate(), java.time.LocalDate.now()).getYears();
            if (age < livre.getAgeMinimum()) {
                return "Vous n'avez pas l'age minimum requis (" + livre.getAgeMinimum() + " ans) pour emprunter ce livre.";
            }
        }

        // 6. Verifier qu'il y a un exemplaire disponible
        List<Exemplaire> exemplaires = exemplaireRepository.findDisponibles(idLivre, dateEmprunt);
        if (exemplaires.isEmpty()) return "Aucun exemplaire disponible pour ce livre.";

        // 7. Verifier que le livre est compatible avec l'adherent (autorisation)
        boolean autorise = autorisationRepository.findAll().stream()
            .anyMatch(a -> a.getTypeMembre().getId().equals(membre.getTypeMembre().getId()) && a.getLivre().getId().equals(idLivre));
        if (!autorise) return "Ce livre n'est pas autorise pour ce type d'adherent.";

        // 8. Creer l'emprunt
        Exemplaire exemplaire = exemplaires.get(0);
        Bibliothecaire biblio = bibliothecaireRepository.findById(idBibliothecaire).orElse(null);
        if (biblio == null) return "Bibliothecaire inexistant.";

        Emprunt emprunt = new Emprunt();
        emprunt.setMembre(membre);
        emprunt.setExemplaire(exemplaire);
        emprunt.setDateEmprunt(dateEmprunt);
        emprunt.setDateDebut(dateEmprunt);
        // Calcul de la date d'echeance (exemple : +15 jours ouvres hors jours feries)
        emprunt.setDateEcheance(calculerDateEcheanceSansJoursFeries(dateEmprunt, membre.getTypeMembre().getId()));
        emprunt.setSurPlace(false);
        emprunt.setBiblioEmprunt(biblio);
        empruntRepository.save(emprunt);

        return "Exemplaire n " + exemplaire.getNumeroExemplaire() + " prete. Date de rendu prevue : " + emprunt.getDateEcheance();
    }

    LocalDateTime calculerDateEcheanceSansJoursFeries(LocalDateTime dateDebut, Long idTypeMembre) {
        Integer nbJours = dureeEmpruntRepository.findByTypeMembreId(idTypeMembre)
            .map(DureeEmprunt::getDuree)
            .orElse(15); // Valeur par défaut si pas de durée définie

        Set<LocalDate> joursFeries = jourFerieRepository.findAll().stream()
            .map(jf -> jf.getDateJour().toLocalDate())
            .collect(Collectors.toSet());

        LocalDateTime date = dateDebut;
        int joursAjoutes = 0;

        while (joursAjoutes < nbJours) {
            date = date.plusDays(1);
            DayOfWeek jour = date.getDayOfWeek();
            boolean estWeekend = (jour == DayOfWeek.SUNDAY);
            boolean estFerie = joursFeries.contains(date.toLocalDate());

            if (!estWeekend && !estFerie) {
                joursAjoutes++;
            }
        }

        return date;
    }



    public List<Emprunt> getPretsEnCours() {
        // Prêts classiques (pas sur place) et non rendus
        return empruntRepository.findAll().stream()
            .filter(e -> (e.getDateRetour() == null) && !Boolean.TRUE.equals(e.getSurPlace()))
            .toList();
    }
}