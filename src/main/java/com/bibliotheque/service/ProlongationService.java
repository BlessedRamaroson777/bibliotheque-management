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
}