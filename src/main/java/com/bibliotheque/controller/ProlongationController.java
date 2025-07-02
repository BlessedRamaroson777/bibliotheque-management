package com.bibliotheque.controller;

import com.bibliotheque.service.ProlongationService;
import com.bibliotheque.repository.LivreRepository;
import com.bibliotheque.repository.MembreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ProlongationController {
    @Autowired private ProlongationService prolongationService;
    @Autowired private LivreRepository livreRepository;
    @Autowired private MembreRepository membreRepository;

    @GetMapping("/form-prolonger-livre")
    public String formProlongerLivre(Model model) {
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        return "form_prolonger_livre";
    }

    @PostMapping("/prolonger-livre")
    public String prolongerLivre(@RequestParam Long idAdherent, @RequestParam Long idLivre, @RequestParam String dateProlongement, Model model) {
        String resultat = prolongationService.demanderProlongation(idAdherent, idLivre, java.time.LocalDateTime.parse(dateProlongement));
        model.addAttribute("resultat", resultat);
        return "resultat_prolonger_livre";
    }
}