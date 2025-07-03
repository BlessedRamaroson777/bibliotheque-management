package com.bibliotheque.controller;

import com.bibliotheque.service.EmpruntService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class EmpruntController {
    @Autowired private EmpruntService empruntService;

    @PostMapping("/rendre-livre")
    public String rendreLivre(@RequestParam Long idAdherent, @RequestParam Long idExemplaire, @RequestParam String dateRendu, Model model) {
        String resultat = empruntService.rendreLivre(idAdherent, idExemplaire, java.time.LocalDateTime.parse(dateRendu));
        model.addAttribute("resultat", resultat);
        return "resultat_rendre_livre";
    }
}
