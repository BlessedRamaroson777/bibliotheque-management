package com.bibliotheque.controller;

import com.bibliotheque.service.ProlongationService;
import com.bibliotheque.model.Emprunt;
import com.bibliotheque.repository.LivreRepository;
import com.bibliotheque.repository.MembreRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ProlongationController {
    @Autowired private ProlongationService prolongationService;
    @Autowired private MembreRepository membreRepository;
    @Autowired private com.bibliotheque.repository.EmpruntRepository empruntRepository;

    @GetMapping("/form-prolonger-livre")
    public String formProlongerLivre(@RequestParam(required = false) Long idAdherent, Model model) {
        model.addAttribute("adherents", membreRepository.findAll());
        if (idAdherent != null) {
            // Liste des emprunts en cours pour cet adhérent
            List<Emprunt> emprunts = empruntRepository.findByMembreId(idAdherent).stream()
                .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
                .toList();
            model.addAttribute("emprunts", emprunts);
        }
        model.addAttribute("prolongations", prolongationService.getProlongationsEnCours());
        return "form_prolonger_livre";
    }
    @PostMapping("/prolonger-livre")
    public String prolongerLivre(@RequestParam Long idAdherent, @RequestParam Long idLivre, @RequestParam String dateProlongement, Model model) {
        String resultat = prolongationService.demanderProlongation(idAdherent, idLivre, java.time.LocalDateTime.parse(dateProlongement));
        model.addAttribute("resultat", resultat);
        return "resultat_prolonger_livre";
    }
}