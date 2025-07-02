package com.bibliotheque.controller;

import com.bibliotheque.service.DisponibiliteService;
import com.bibliotheque.service.DisponibiliteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;

@Controller
public class DisponibiliteController {
    @Autowired
    private DisponibiliteService disponibiliteService;
    
    @Autowired
    private com.bibliotheque.repository.LivreRepository livreRepository;

    @GetMapping("/form-disponibilite")
    public String formDisponibilite(Model model) {
        model.addAttribute("livres", livreRepository.findAll());
        return "form_disponibilite";
    }
    @GetMapping("/verifier-disponibilite")
    public String verifierDisponibilite(@RequestParam Long livreId,
                                        @RequestParam String dateDispo,
                                        Model model) {
        LocalDate date = LocalDate.parse(dateDispo);
        DisponibiliteResult result = disponibiliteService.verifierDisponibilite(livreId, date);
        model.addAttribute("result", result);
        return "resultat_disponibilite";
    }
}