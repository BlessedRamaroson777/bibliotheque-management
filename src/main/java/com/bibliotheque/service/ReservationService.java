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
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private ReservationAnnuleeRepository reservationAnnuleeRepository;
    @Autowired private StatutMembreRepository statutMembreRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private AutorisationRepository autorisationRepository;

    public String reserverLivre(Long idAdherent, Long idLivre, LocalDateTime dateReservation, LocalDateTime dateDebut) {
        // Verification existence adherent
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "Erreur : adherent inexistant.";
        // Verification existence livre
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Erreur : livre inexistant.";

        // Verifier que dateDebut >= dateReservation
        if (dateDebut.isBefore(dateReservation)) {
            return "Erreur : la date de debut doit être posterieure ou egale à la date de reservation.";
        }

        // Creation de la reservation
        Reservation reservation = new Reservation();
        reservation.setMembre(membre);
        reservation.setLivre(livre);
        reservation.setDateReservation(dateReservation);
        reservation.setDateDebut(dateDebut);
        reservationRepository.save(reservation);

        return "Demande de reservation envoyee au bibliothecaire.";
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

        LocalDateTime now = LocalDateTime.now();

        // Si la date de debut est depassee, annuler la reservation
        if (now.isAfter(reservation.getDateDebut())) {
            reservationRepository.delete(reservation);
            return "La reservation est expiree (date de retrait depassee) et a ete annulee automatiquement.";
        }

        // Verifier que la date de recuperation >= dateDebut
        if (now.isBefore(reservation.getDateDebut())) {
            return "Impossible de recuperer la reservation avant la date de debut prevue (" + reservation.getDateDebut() + ").";
        }

        // Chercher un exemplaire disponible à la date de recuperation
        Livre livre = livreRepository.findByIdWithExemplaires(reservation.getLivre().getId());
        Membre membre = reservation.getMembre();
        java.util.List<Exemplaire> exemplairesDispo = exemplaireRepository.findDisponibles(livre.getId(), now);
        Exemplaire exemplaire = exemplairesDispo.stream()
            .filter(e -> e.getEmprunts().stream().noneMatch(em -> em.getDateRetour() == null))
            .findFirst().orElse(null);
        if (exemplaire == null) return "Aucun exemplaire disponible pour ce livre à la date de recuperation.";

        // Creer l'emprunt
        Emprunt emprunt = new Emprunt();
        emprunt.setMembre(membre);
        emprunt.setExemplaire(exemplaire);
        emprunt.setDateEmprunt(now);
        emprunt.setDateDebut(reservation.getDateDebut()); // Utiliser la date de debut prevue
        emprunt.setDateEcheance(now.plusDays(15));
        emprunt.setSurPlace(false);
        Bibliothecaire biblio = bibliothecaireRepository.findById(idBibliothecaire).orElse(null);
        if (biblio == null) return "bibliothecaire inexistant";
        emprunt.setBiblioEmprunt(biblio);

        empruntRepository.save(emprunt);

        reservation.setEmprunt(emprunt);
        reservationRepository.save(reservation);

        return "reservation transformee en emprunt, exemplaire remis";
    }

    public String assignerBibliothecaire(Long idReservation, Long idBibliothecaire) {
        Reservation reservation = reservationRepository.findById(idReservation).orElse(null);
        if (reservation == null) return "Reservation inexistante.";
        if (reservation.getBibliothecaire() != null) return "Dejà assignee à un bibliothecaire.";
        Bibliothecaire biblio = bibliothecaireRepository.findById(idBibliothecaire).orElse(null);
        if (biblio == null) return "Bibliothecaire inexistant.";
        reservation.setBibliothecaire(biblio);
        reservation.setDateTraitement(java.time.LocalDateTime.now());
        reservationRepository.save(reservation);
        return "Bibliothecaire assigne à la reservation.";
    }

    public String annulerReservationParBibliothecaire(Long idReservation, Long idBibliothecaire) {
        Reservation reservation = reservationRepository.findById(idReservation).orElse(null);
        if (reservation == null) return "reservation inexistante";
        Bibliothecaire biblio = bibliothecaireRepository.findById(idBibliothecaire).orElse(null);
        if (biblio == null) return "bibliothecaire inexistant";
        // Vérifier si déjà annulée
        boolean dejaAnnulee = reservationAnnuleeRepository.findByReservationId(idReservation).size() > 0;
        if (dejaAnnulee) return "reservation deja annulee";
        ReservationAnnulee annulee = new ReservationAnnulee();
        annulee.setReservation(reservation);
        annulee.setBibliothecaire(biblio);
        annulee.setDateAnnulation(java.time.LocalDateTime.now());
        reservationAnnuleeRepository.save(annulee);
        return "reservation annulee par le bibliothecaire";
    }

    public String annulerReservationParMembre(Long idReservation, Long idMembre) {
        Reservation reservation = reservationRepository.findById(idReservation).orElse(null);
        if (reservation == null) return "reservation inexistante";
        Membre membre = membreRepository.findById(idMembre).orElse(null);
        if (membre == null) return "membre inexistant";
        boolean dejaAnnulee = reservationAnnuleeRepository.findByReservationId(idReservation).size() > 0;
        if (dejaAnnulee) return "reservation deja annulee";
        ReservationAnnulee annulee = new ReservationAnnulee();
        annulee.setReservation(reservation);
        annulee.setMembre(membre);
        annulee.setDateAnnulation(java.time.LocalDateTime.now());
        reservationAnnuleeRepository.save(annulee);
        return "reservation annulee par le membre";
    }

    public java.util.List<Reservation> getReservationsNonAnnulees() {
        java.util.List<Reservation> toutes = reservationRepository.findNonReclamees();
        java.util.List<Long> idsAnnulees = reservationAnnuleeRepository.findAll().stream()
            .map(a -> a.getReservation().getId()).toList();
        return toutes.stream()
            .filter(r -> !idsAnnulees.contains(r.getId()))
            .toList();
    }

    public String examinerReservation(Long idReservation, boolean accorder) {
        Reservation reservation = reservationRepository.findById(idReservation).orElse(null);
        if (reservation == null) return "Erreur : reservation inexistante.";
        Membre membre = reservation.getMembre();
        if (membre == null) return "Erreur : adherent inexistant.";
        Livre livre = reservation.getLivre();
        if (livre == null) return "Erreur : livre inexistant.";

        // Vérifier que l'adhérent est actif (avant et après)
        boolean actif = statutMembreRepository.findAll().stream()
            .anyMatch(s -> s.getMembre().getId().equals(membre.getId()) && s.getStatut().getValeur().equalsIgnoreCase("actif"));
        if (!actif) {
            return "Erreur : adherent inactif. Reservation refusee.";
        }

        // Vérifier que l'adhérent n'est pas pénalisé
        boolean penalise = penaliteRepository.findAll().stream()
            .anyMatch(p -> p.getMembre().getId().equals(membre.getId()) && p.getDateRetour() == null);
        if (penalise) {
            return "Erreur : adherent penalise. Reservation refusee.";
        }

        // Vérifier le quota à la date de reservation
        int quota = membre.getTypeMembre().getQuota();
        long empruntsEnCours = empruntRepository.findByMembreId(membre.getId()).stream()
            .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .count();
        if (empruntsEnCours >= quota) {
            return "Erreur : quota depasse a la date de reservation. Reservation refusee.";
        }

        // Vérifier qu'un exemplaire est disponible à la date de reservation
        java.util.List<Exemplaire> exemplairesDispo = exemplaireRepository.findDisponibles(livre.getId(), reservation.getDateDebut());
        if (exemplairesDispo.isEmpty()) {
            // Quota -1 (à implémenter selon ta logique de quota)
            // Message vers adherent
            return "Aucun exemplaire disponible a la date demandee. Reservation refusee et quota decrementé.";
        }

        // Vérifier que le livre est compatible avec l'adhérent (autorisation)
        boolean autorise = autorisationRepository.findAll().stream()
            .anyMatch(a -> a.getTypeMembre().getId().equals(membre.getTypeMembre().getId()) && a.getLivre().getId().equals(livre.getId()));
        if (!autorise) {
            return "Ce livre n'est pas autorise pour ce type d'adherent. Reservation refusee.";
        }

        if (accorder) {
            // Ici, tu pourrais marquer la reservation comme "validée" (par exemple, set un champ ou notifier l'adhérent)
            return "Reservation accordee. Exemplaire disponible a la date demandee.";
        } else {
            return "Reservation refusee par le bibliothecaire.";
        }
    }
}