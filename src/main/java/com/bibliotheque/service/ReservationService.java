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
    @Autowired private BibliothecaireRepository bibliothecaireRepository;

    public String reserverLivre(Long idAdherent, Long idLivre, LocalDateTime dateReservation) {
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "adherent inexistant";
        Livre livre = livreRepository.findByIdWithExemplaires(idLivre);
        if (livre == null) return "livre inexistant";

        Reservation reservation = new Reservation();
        reservation.setMembre(membre);
        reservation.setLivre(livre);
        reservation.setDateReservation(dateReservation);
        reservation.setDateDebut(dateReservation); // <-- AJOUT OBLIGATOIRE
        reservationRepository.save(reservation);

        return "demande de reservation envoyee au bibliothecaire";
    }

    public String annulerReservation(Long idReservation) {
        Reservation reservation = reservationRepository.findById(idReservation).orElse(null);
        if (reservation == null) return "reservation inexistante";
        if (reservation.getEmprunt() != null) return "reservation deja reclamee";

        reservationRepository.delete(reservation);
        return "reservation annulee";
    }

    public String recupererReservation(Long idReservation, Long idBibliothecaire) {
        Reservation reservation = reservationRepository.findById(idReservation).orElse(null);
        if (reservation == null) return "reservation inexistante";
        if (reservation.getEmprunt() != null) return "reservation deja transformee en emprunt";

        // Chercher un exemplaire disponible du livre
        Livre livre = livreRepository.findByIdWithExemplaires(reservation.getLivre().getId());
        Membre membre = reservation.getMembre();
        Exemplaire exemplaire = livre.getExemplaires().stream()
            .filter(e -> e.getEmprunts().stream().noneMatch(em -> em.getDateRetour() == null))
            .findFirst().orElse(null);

        if (exemplaire == null) return "aucun exemplaire disponible pour ce livre";

        // Créer l'emprunt
        Emprunt emprunt = new Emprunt();
        emprunt.setMembre(membre);
        emprunt.setExemplaire(exemplaire);
        emprunt.setDateEmprunt(LocalDateTime.now());
        emprunt.setDateDebut(LocalDateTime.now());
        emprunt.setDateEcheance(LocalDateTime.now().plusDays(15));
        emprunt.setSurPlace(false);
        // Renseigner le bibliothécaire
        Bibliothecaire biblio = bibliothecaireRepository.findById(idBibliothecaire).orElse(null);
        if (biblio == null) return "bibliothecaire inexistant";
        emprunt.setBiblioEmprunt(biblio);

        // Sauvegarder l'emprunt et lier à la réservation
        reservation.setEmprunt(emprunt);
        reservationRepository.save(reservation);

        return "reservation transformee en emprunt, exemplaire remis";
    }
}