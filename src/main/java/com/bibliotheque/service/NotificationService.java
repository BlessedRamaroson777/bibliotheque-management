package com.bibliotheque.service;

import com.bibliotheque.model.Emprunt;
import com.bibliotheque.repository.EmpruntRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.Duration;
import java.util.List;

@Service
public class NotificationService {
    @Autowired
    private EmpruntRepository empruntRepository;

    public List<Emprunt> getEmpruntsARendreDans2Jours(Long idAdherent) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime dans2Jours = now.plusDays(2);
        return empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getDateRetour() == null && e.getDateEcheance() != null)
            .filter(e -> {
                long joursRestant = Duration.between(now, e.getDateEcheance()).toDays();
                return joursRestant == 2;
            })
            .toList();
    }
}
