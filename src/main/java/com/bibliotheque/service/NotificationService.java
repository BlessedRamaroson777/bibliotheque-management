package com.bibliotheque.service;

import com.bibliotheque.model.Emprunt;
import com.bibliotheque.model.Prolongation;
import com.bibliotheque.model.Reservation;
import com.bibliotheque.repository.EmpruntRepository;
import com.bibliotheque.repository.ProlongationRepository;
import com.bibliotheque.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class NotificationService {
    @Autowired
    private EmpruntRepository empruntRepository;
    @Autowired
    private ProlongationRepository prolongationRepository;
    @Autowired
    private ReservationRepository reservationRepository;

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

    // Prolongations examinées pour un adhérent
    public java.util.List<Prolongation> getProlongationsExaminees(Long idAdherent) {
        return prolongationRepository.findAll().stream()
            .filter(p -> p.getEmprunt().getMembre().getId().equals(idAdherent))
            .filter(p -> p.getAccordee() != null) // seulement celles déjà examinées
            .toList();
    }

    // Reservations examinées pour un adhérent (celles qui ont été transformées en emprunt ou refusées)
    public java.util.List<Reservation> getReservationsExaminees(Long idAdherent) {
        return reservationRepository.findAll().stream()
            .filter(r -> r.getMembre().getId().equals(idAdherent))
            .filter(r -> r.getEmprunt() != null || r.getBibliothecaire() != null) // examinées
            .toList();
    }
}