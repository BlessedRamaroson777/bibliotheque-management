package com.bibliotheque.controller;

import com.bibliotheque.service.ReservationService;
import com.bibliotheque.repository.LivreRepository;
import com.bibliotheque.repository.MembreRepository;
import com.bibliotheque.repository.ReservationRepository;
import com.bibliotheque.repository.BibliothecaireRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ReservationController {
    @Autowired private ReservationService reservationService;
    @Autowired private LivreRepository livreRepository;
    @Autowired private MembreRepository membreRepository;
    @Autowired private ReservationRepository reservationRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;

    @PostMapping("/reserver-livre")
    public String reserverLivre(
        @RequestParam Long idAdherent,
        @RequestParam Long idLivre,
        @RequestParam String dateReservation,
        @RequestParam String dateDebut,
        Model model
    ) {
        String resultat = reservationService.reserverLivre(
            idAdherent,
            idLivre,
            java.time.LocalDateTime.parse(dateReservation),
            java.time.LocalDateTime.parse(dateDebut)
        );
        model.addAttribute("resultat", resultat);
        return "resultat_reserver_livre";
    }

    @PostMapping("/annuler-reservation")
    public String annulerReservation(@RequestParam Long idReservation, Model model) {
        String resultat = reservationService.annulerReservation(idReservation);
        model.addAttribute("resultat", resultat);
        // recharge la liste
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("reservations", reservationRepository.findNonReclamees());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_reserver_livre";
    }

    @PostMapping("/recuperer-reservation")
    public String recupererReservation(@RequestParam Long idReservation, @RequestParam Long idBibliothecaire, Model model) {
        String resultat = reservationService.recupererReservation(idReservation, idBibliothecaire);
        model.addAttribute("resultat", resultat);
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("reservations", reservationRepository.findNonReclamees());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_reserver_livre";
    }

    @PostMapping("/assigner-bibliothecaire-reservation")
    public String assignerBibliothecaireReservation(@RequestParam Long idReservation, @RequestParam Long idBibliothecaire, Model model) {
        String resultat = reservationService.assignerBibliothecaire(idReservation, idBibliothecaire);
        model.addAttribute("resultat", resultat);
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("reservations", reservationRepository.findNonReclamees());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_reserver_livre";
    }

    @PostMapping("/annuler-reservation-biblio")
    public String annulerReservationBiblio(@RequestParam Long idReservation, @RequestParam Long idBibliothecaire, Model model) {
        String resultat = reservationService.annulerReservationParBibliothecaire(idReservation, idBibliothecaire);
        model.addAttribute("resultat", resultat);
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("reservations", reservationService.getReservationsNonAnnulees());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_reserver_livre";
    }

    @PostMapping("/annuler-reservation-membre")
    public String annulerReservationMembre(@RequestParam Long idReservation, @RequestParam Long idMembre, Model model) {
        String resultat = reservationService.annulerReservationParMembre(idReservation, idMembre);
        model.addAttribute("resultat", resultat);
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("reservations", reservationService.getReservationsNonAnnulees());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_reserver_livre";
    }

    @PostMapping("/examiner-reservation")
    public String examinerReservation(@RequestParam Long idReservation, @RequestParam boolean accorder, Model model) {
        String resultat = reservationService.examinerReservation(idReservation, accorder);
        model.addAttribute("resultat", resultat);
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("reservations", reservationService.getReservationsNonAnnulees());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_reserver_livre";
    }

    @GetMapping("/form-reserver-livre")
    public String formReserverLivre(Model model) {
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("reservations", reservationService.getReservationsNonAnnulees());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_reserver_livre";
    }
}