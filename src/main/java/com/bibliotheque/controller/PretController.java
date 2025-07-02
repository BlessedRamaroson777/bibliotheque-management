package com.bibliotheque.controller;

import com.bibliotheque.service.PretService;
import com.bibliotheque.repository.LivreRepository;
import com.bibliotheque.repository.MembreRepository;
import com.bibliotheque.repository.BibliothecaireRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class PretController {
    @Autowired private PretService pretService;
    @Autowired private LivreRepository livreRepository;
    @Autowired private MembreRepository membreRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;

    @GetMapping("/form-preter-livre")
    public String formPreterLivre(Model model) {
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());

        // Ajoute la liste des prêts en cours (hors sur place)
        model.addAttribute("prets", pretService.getPretsEnCours());
        return "form_preter_livre";
    }

    @PostMapping("/preter-livre")
    public String preterLivre(@RequestParam Long idAdherent, @RequestParam Long idLivre, @RequestParam Long idBibliothecaire, Model model) {
        String resultat = pretService.preterLivre(idAdherent, idLivre, idBibliothecaire);
        model.addAttribute("resultat", resultat);
        return "resultat_preter_livre";
    }
}