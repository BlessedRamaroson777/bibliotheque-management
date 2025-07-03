package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class EmpruntService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private QuotaEmpruntMembreRepository quotaEmpruntMembreRepository;

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

        // Gestion penalite si retard
        if (dateRendu.isAfter(emprunt.getDateEcheance())) {
            Penalite penalite = new Penalite();
            penalite.setEmprunt(emprunt);
            penalite.setMembre(membre);
            penalite.setDateEcheance(emprunt.getDateEcheance());
            penalite.setDateRetour(dateRendu);
            penaliteRepository.save(penalite);
        }

        // Gestion quota (+1)
        QuotaEmpruntMembre quota = new QuotaEmpruntMembre();
        quota.setMembre(membre);
        quota.setDateQuota(dateRendu);
        quota.setQuotaEmprunt(membre.getTypeMembre().getQuota());
        quota.setEmprunt(emprunt);
        quotaEmpruntMembreRepository.save(quota);

        return "Livre rendu. Quota +1. Exemplaire disponible." + (dateRendu.isAfter(emprunt.getDateEcheance()) ? " Penalite appliquee." : "");
    }
}
