package com.bibliotheque.controller;

import com.bibliotheque.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NotificationController {
    @Autowired private NotificationService notificationService;
    @Autowired private com.bibliotheque.repository.MembreRepository membreRepository;

    @GetMapping("/notifier-retour-livre")
    public String notifierRetourLivre(@RequestParam(required = false) Long idAdherent, Model model) {
        model.addAttribute("adherents", membreRepository.findAll());
        if (idAdherent != null) {
            model.addAttribute("emprunts", notificationService.getEmpruntsARendreDans2Jours(idAdherent));
        }
        return "notifier_retour_livre";
    }

    @GetMapping("/notifier-retour-livre-biblio")
    public String notifierRetourLivreBiblio(Model model) {
        model.addAttribute("emprunts", notificationService.getEmpruntsTousAdherentsARendreDans2Jours());
        return "notifier_retour_livre_biblio";
    }

    @GetMapping("/notifier-examination-prolongement")
    public String notifierExaminationProlongement(@RequestParam Long idAdherent, Model model) {
        model.addAttribute("prolongations", notificationService.getProlongationsExaminees(idAdherent));
        return "notifier_examination_prolongement";
    }

    @GetMapping("/notifier-examination-reservation")
    public String notifierExaminationReservation(@RequestParam Long idAdherent, Model model) {
        model.addAttribute("reservations", notificationService.getReservationsExaminees(idAdherent));
        return "notifier_examination_reservation";
    }

    @GetMapping("/notifier-examination-prolongement-biblio")
    public String notifierExaminationProlongementBiblio(Model model) {
        // model.addAttribute("prolongations", notificationService.getProlongationsExamineesBiblio());
        model.addAttribute("prolongations", notificationService.getToutesLesProlongations());
        return "notifier_examination_prolongement_biblio";
    }

    @GetMapping("/notifier-examination-reservation-biblio")
    public String notifierExaminationReservationBiblio(Model model) {
        model.addAttribute("reservations", notificationService.getToutesLesReservations());
        // model.addAttribute("reservations", notificationService.getReservationsExamineesBiblio());
        return "notifier_examination_reservation_biblio";
    }
}