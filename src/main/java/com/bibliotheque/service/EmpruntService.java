package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@Service
public class EmpruntService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private QuotaEmpruntMembreRepository quotaEmpruntMembreRepository;
    @Autowired private DureePenaliteRepository dureePenaliteRepository; 

    public String rendreLivre(Long idAdherent, Long idExemplaire, LocalDateTime dateRendu) {
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "Erreur : adherent inexistant.";
        
        Exemplaire exemplaire = exemplaireRepository.findById(idExemplaire).orElse(null);
        if (exemplaire == null) return "Erreur : exemplaire inexistant.";

        Emprunt emprunt = empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getExemplaire().getId().equals(idExemplaire) && e.getDateRetour() == null)
            .findFirst().orElse(null);
        if (emprunt == null) return "Erreur : cet exemplaire n'est pas actuellement emprunte par cet adherent.";

        emprunt.setDateRetour(dateRendu);
        empruntRepository.save(emprunt);

        // ⚠ Gestion penalite si retard
        if (dateRendu.isAfter(emprunt.getDateEcheance())) {
            long joursRetard = ChronoUnit.DAYS.between(emprunt.getDateEcheance().toLocalDate(), dateRendu.toLocalDate());

            Long idTypeMembre = membre.getTypeMembre().getId();
            DureePenalite regle = dureePenaliteRepository.findByTypeMembreId(idTypeMembre);
            int joursToleres = (regle != null) ? regle.getNombreJour() : 0;

            int dureePenalite = (int) Math.max(0, joursRetard - joursToleres);

            Penalite penalite = new Penalite();
            penalite.setEmprunt(emprunt);
            penalite.setMembre(membre);
            penalite.setDateEcheance(emprunt.getDateEcheance());
            penalite.setDateRetour(dateRendu);
            penalite.setDuree(dureePenalite);

            penaliteRepository.save(penalite);
        }

        // ✅ Gestion quota
        QuotaEmpruntMembre quota = new QuotaEmpruntMembre();
        quota.setMembre(membre);
        quota.setDateQuota(dateRendu);
        quota.setQuotaEmprunt(membre.getTypeMembre().getQuota());
        quota.setEmprunt(emprunt);
        quotaEmpruntMembreRepository.save(quota);

        return "Livre rendu. Quota +1. Exemplaire disponible." +
               (dateRendu.isAfter(emprunt.getDateEcheance()) ? " Penalite appliquee." : "");
    }
}
