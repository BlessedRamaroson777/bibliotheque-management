package com.bibliotheque.service;

import com.bibliotheque.model.Emprunt;
import com.bibliotheque.repository.EmpruntRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class NotificationService {
    @Autowired
    private EmpruntRepository empruntRepository;

    // Pour l'adhérent : ses emprunts à rendre dans 2 jours
    public List<Emprunt> getEmpruntsARendreDans2Jours(Long idAdherent) {
        LocalDateTime now = LocalDateTime.now().truncatedTo(ChronoUnit.DAYS);
        LocalDateTime dans2Jours = now.plusDays(2);
        return empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getDateRetour() == null && e.getDateEcheance() != null)
            .filter(e -> e.getDateEcheance().truncatedTo(ChronoUnit.DAYS).equals(dans2Jours))
            .toList();
    }

    // Pour le bibliothécaire : tous les emprunts à rendre dans 2 jours
    public List<Emprunt> getEmpruntsTousAdherentsARendreDans2Jours() {
        LocalDateTime now = LocalDateTime.now().truncatedTo(ChronoUnit.DAYS);
        LocalDateTime dans2Jours = now.plusDays(2);
        return empruntRepository.findAll().stream()
            .filter(e -> e.getDateRetour() == null && e.getDateEcheance() != null)
            .filter(e -> e.getDateEcheance().truncatedTo(ChronoUnit.DAYS).equals(dans2Jours))
            .toList();
    }
}