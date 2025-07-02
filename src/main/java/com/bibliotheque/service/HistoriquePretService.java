package com.bibliotheque.service;

import com.bibliotheque.model.Emprunt;
import com.bibliotheque.model.Reservation;
import com.bibliotheque.repository.EmpruntRepository;
import com.bibliotheque.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HistoriquePretService {
    @Autowired
    private EmpruntRepository empruntRepository;
    @Autowired
    private ReservationRepository reservationRepository;

    public List<Emprunt> getEmpruntsByLivre(Long livreId) {
        return empruntRepository.findByLivreId(livreId);
    }

    public List<Reservation> getReservationsByLivre(Long livreId) {
        return reservationRepository.findByLivreId(livreId);
    }
}