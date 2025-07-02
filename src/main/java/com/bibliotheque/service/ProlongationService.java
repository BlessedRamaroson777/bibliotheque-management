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

    public String demanderProlongation(Long idAdherent, Long idLivre, LocalDateTime dateProlongement) {
        // Vérifier que l'adhérent existe
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "Adhérent inexistant.";

        // Vérifier que le livre existe
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Livre inexistant.";

        // Trouver l'emprunt en cours pour ce livre et cet adhérent
        Emprunt emprunt = empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getExemplaire().getLivre().getId().equals(idLivre) && e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .findFirst().orElse(null);

        if (emprunt == null) return "Aucun emprunt en cours pour ce livre.";

        // Créer la demande de prolongation (accordée à false ou null)
        Prolongation prolongation = new Prolongation();
        prolongation.setEmprunt(emprunt);
        prolongation.setDateProlongation(LocalDateTime.now());
        prolongation.setAncienneEcheance(emprunt.getDateEcheance());
        prolongation.setNouvelleEcheance(dateProlongement);
        prolongation.setAccordee(null); // En attente de validation
        prolongationRepository.save(prolongation);

        // Ici, tu pourrais notifier le bibliothécaire (mail, notification, etc.)
        return "Demande de prolongation envoyée au bibliothécaire.";
    }
}