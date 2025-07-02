package com.bibliotheque.controller;

import com.bibliotheque.service.HistoriquePretService;
import com.bibliotheque.repository.LivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HistoriquePretController {
    @Autowired
    private HistoriquePretService historiquePretService;
    @Autowired
    private LivreRepository livreRepository;

    @GetMapping("/form-historique-pret")
    public String formHistoriquePret(Model model) {
        model.addAttribute("livres", livreRepository.findAll());
        return "form_historique_pret";
    }
    @GetMapping("/historique-pret")
    public String historiquePret(@RequestParam Long livreId, Model model) {
        model.addAttribute("emprunts", historiquePretService.getEmpruntsByLivre(livreId));
        model.addAttribute("reservations", historiquePretService.getReservationsByLivre(livreId));
        return "historique_pret";
    }
}