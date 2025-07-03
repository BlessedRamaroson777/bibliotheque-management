package com.bibliotheque.controller;

import com.bibliotheque.model.Emprunt;
import com.bibliotheque.service.EmpruntService;
import com.bibliotheque.repository.MembreRepository;
import com.bibliotheque.repository.EmpruntRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class EmpruntController {
    @Autowired private EmpruntService empruntService;
    @Autowired private MembreRepository membreRepository;
    @Autowired private EmpruntRepository empruntRepository;

    @GetMapping("/form-rendre-livre")
    public String formRendreLivre(@RequestParam(required = false) Long idAdherent, Model model) {
        model.addAttribute("adherents", membreRepository.findAll());
        if (idAdherent != null) {
            List<Emprunt> emprunts = empruntRepository.findByMembreId(idAdherent).stream()
                .filter(e -> e.getDateRetour() == null)
                .toList();
            model.addAttribute("emprunts", emprunts);
        }
        return "form_rendre_livre";
    }

    @PostMapping("/rendre-livre")
    public String rendreLivre(@RequestParam Long idAdherent, @RequestParam Long idExemplaire, @RequestParam String dateRendu, Model model) {
        String resultat = empruntService.rendreLivre(idAdherent, idExemplaire, java.time.LocalDateTime.parse(dateRendu));
        model.addAttribute("resultat", resultat);
        return "resultat_rendre_livre";
    }
}
