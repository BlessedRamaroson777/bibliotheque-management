package com.bibliotheque.controller;

import com.bibliotheque.service.ReservationService;
import com.bibliotheque.repository.LivreRepository;
import com.bibliotheque.repository.MembreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ReservationController {
    @Autowired private ReservationService reservationService;
    @Autowired private LivreRepository livreRepository;
    @Autowired private MembreRepository membreRepository;

    @GetMapping("/form-reserver-livre")
    public String formReserverLivre(Model model) {
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        return "form_reserver_livre";
    }

    @PostMapping("/reserver-livre")
    public String reserverLivre(@RequestParam Long idAdherent, @RequestParam Long idLivre, @RequestParam String dateReservation, Model model) {
        String resultat = reservationService.reserverLivre(idAdherent, idLivre, java.time.LocalDateTime.parse(dateReservation));
        model.addAttribute("resultat", resultat);
        return "resultat_reserver_livre";
    }
}