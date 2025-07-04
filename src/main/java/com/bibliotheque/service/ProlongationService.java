package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

@Service
public class ProlongationService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private ProlongationRepository prolongationRepository;
    @Autowired private StatutMembreRepository statutMembreRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private AutorisationRepository autorisationRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;

    public String demanderProlongation(Long idAdherent, Long idLivre, LocalDateTime dateProlongement) {
        // Verifier que l'adherent existe
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "Adherent inexistant.";

        // Verifier que le livre existe
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Livre inexistant.";

        // Trouver l'emprunt en cours pour ce livre et cet adherent
        Emprunt emprunt = empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getExemplaire().getLivre().getId().equals(idLivre) && e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .findFirst().orElse(null);

        if (emprunt == null) return "Aucun emprunt en cours pour ce livre.";

        // Creer la demande de prolongation (accordee à false ou null)
        Prolongation prolongation = new Prolongation();
        prolongation.setEmprunt(emprunt);
        prolongation.setDateProlongation(LocalDateTime.now());
        prolongation.setAncienneEcheance(emprunt.getDateEcheance());
        prolongation.setNouvelleEcheance(dateProlongement);
        prolongation.setAccordee(null); // En attente de validation
        prolongationRepository.save(prolongation);

        // Ici, tu pourrais notifier le bibliothecaire (mail, notification, etc.)
        return "Demande de prolongation envoyee au bibliothecaire.";
    }

    public java.util.List<Prolongation> getProlongationsEnCours() {
        // Accordee == null → en attente de validation
        return prolongationRepository.findAll().stream()
            .filter(p -> p.getAccordee() == null)
            .toList();
    }

    public String examinerProlongation(Long idProlongation, boolean accorder) {
        Prolongation prolongation = prolongationRepository.findById(idProlongation).orElse(null);
        if (prolongation == null) return "Erreur : demande de prolongation inexistante.";
        Emprunt emprunt = prolongation.getEmprunt();
        if (emprunt == null) return "Erreur : aucun emprunt lié à cette demande.";
        Membre membre = emprunt.getMembre();
        if (membre == null) return "Erreur : adherent inexistant.";
        Livre livre = emprunt.getExemplaire().getLivre();
        if (livre == null) return "Erreur : livre inexistant.";

        // Vérifier que l'adhérent est actif (avant et après)
        boolean actif = statutMembreRepository.findAll().stream()
            .anyMatch(s -> s.getMembre().getId().equals(membre.getId()) && s.getStatut().getValeur().equalsIgnoreCase("actif"));
        if (!actif) {
            prolongation.setAccordee(false);
            prolongationRepository.save(prolongation);
            return "Erreur : adherent inactif. Prolongation refusee.";
        }

        // Vérifier que l'adhérent n'est pas pénalisé
        boolean penalise = penaliteRepository.findAll().stream()
            .anyMatch(p -> p.getMembre().getId().equals(membre.getId()) && p.getDateRetour() == null);
        if (penalise) {
            prolongation.setAccordee(false);
            prolongationRepository.save(prolongation);
            return "Erreur : adherent penalise. Prolongation refusee.";
        }

        // Vérifier le quota à la date de prolongement
        int quota = membre.getTypeMembre().getQuota();
        long empruntsEnCours = empruntRepository.findByMembreId(membre.getId()).stream()
            .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .count();
        if (empruntsEnCours > quota) {
            prolongation.setAccordee(false);
            prolongationRepository.save(prolongation);
            return "Erreur : quota depasse a la date de prolongement. Prolongation refusee.";
        }

        // Vérifier qu'un exemplaire est disponible à la date de prolongement
        java.util.List<Exemplaire> exemplairesDispo = exemplaireRepository.findDisponibles(livre.getId(), prolongation.getNouvelleEcheance());
        boolean exemplairePropre = false;
        // Si l'exemplaire de l'emprunt actuel est celui du membre et il n'est pas rendu, il est "disponible" pour lui-même
        if (emprunt.getExemplaire() != null && emprunt.getDateRetour() == null) {
            exemplairePropre = true;
        }
        if (exemplairesDispo.isEmpty() && !exemplairePropre) {
            prolongation.setAccordee(false);
            prolongationRepository.save(prolongation);
            return "Aucun exemplaire disponible a la date demandee. Prolongation refusee.";
        }

        // Vérifier que le livre est compatible avec l'adhérent (autorisation)
        boolean autorise = autorisationRepository.findAll().stream()
            .anyMatch(a -> a.getTypeMembre().getId().equals(membre.getTypeMembre().getId()) && a.getLivre().getId().equals(livre.getId()));
        if (!autorise) {
            prolongation.setAccordee(false);
            prolongationRepository.save(prolongation);
            return "Ce livre n'est pas autorise pour ce type d'adherent. Prolongation refusee.";
        }

        // Si tout est OK et accorder == true
        if (accorder) {
            prolongation.setAccordee(true);
            emprunt.setDateEcheance(prolongation.getNouvelleEcheance());
            empruntRepository.save(emprunt);
            prolongationRepository.save(prolongation);
            return "Prolongation accordee. Nouvelle date d'echeance : " + prolongation.getNouvelleEcheance();
        } else {
            prolongation.setAccordee(false);
            prolongationRepository.save(prolongation);
            return "Prolongation refusee par le bibliothecaire.";
        }
    }
    
}