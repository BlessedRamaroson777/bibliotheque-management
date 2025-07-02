package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

@Service
public class ReservationService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private ReservationRepository reservationRepository;

    public String reserverLivre(Long idAdherent, Long idLivre, LocalDateTime dateReservation) {
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "adherent inexistant";
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "livre inexistant";

        Reservation reservation = new Reservation();
        reservation.setMembre(membre);
        reservation.setLivre(livre);
        reservation.setDateReservation(dateReservation);
        reservationRepository.save(reservation);

        // Ici tu pourrais notifier le bibliothecaire
        return "demande de reservation envoyee au bibliothecaire";
    }
}