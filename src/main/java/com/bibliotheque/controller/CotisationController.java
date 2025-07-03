package com.bibliotheque.controller;

import com.bibliotheque.service.CotisationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;

@Controller
public class CotisationController {
    @Autowired private CotisationService cotisationService;

    @GetMapping("/cotiser")
    public String cotiserForm() {
        return "cotiser";
    }

    @PostMapping("/cotiser")
    public String cotiser(@RequestParam String dateDebut, @RequestParam String dateFin, HttpSession session, Model model) {
        Long idMembre = (Long) session.getAttribute("idMembre");
        cotisationService.cotiser(idMembre, LocalDateTime.parse(dateDebut), LocalDateTime.parse(dateFin));
        model.addAttribute("message", "Cotisation enregistree !");
        return "cotiser";
    }

    @GetMapping("/cotisations")
    public String listeCotisations(Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if ("bibliothecaire".equals(role)) {
            model.addAttribute("cotisations", cotisationService.getAllCotisations());
        } else if ("adherent".equals(role)) {
            Long idMembre = (Long) session.getAttribute("idMembre");
            model.addAttribute("cotisations", cotisationService.getCotisationsByMembre(idMembre));
        }
        return "liste_cotisations";
    }
}
