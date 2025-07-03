package com.bibliotheque.controller;

import com.bibliotheque.model.Membre;
import com.bibliotheque.model.Bibliothecaire;
import com.bibliotheque.repository.MembreRepository;
import com.bibliotheque.repository.BibliothecaireRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {
    @Autowired private MembreRepository membreRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;

    @GetMapping("/login-adherent")
    public String loginAdherentForm() {
        return "login_adherent";
    }

    @PostMapping("/login-adherent")
    public String loginAdherent(@RequestParam String email, @RequestParam String motDePasse, Model model) {
        Membre membre = membreRepository.findByEmail(email).orElse(null);
        if (membre != null && membre.getMotDePasse().equals(motDePasse)) {
            model.addAttribute("adherent", membre);
            return "accueil_adherent";
        } else {
            model.addAttribute("error", "Identifiants invalides");
            return "login_adherent";
        }
    }

    @GetMapping("/login-bibliothecaire")
    public String loginBibliothecaireForm() {
        return "login_bibliothecaire";
    }

    @PostMapping("/login-bibliothecaire")
    public String loginBibliothecaire(@RequestParam String nomUtilisateur, @RequestParam String motDePasse, Model model) {
        Bibliothecaire biblio = bibliothecaireRepository.findAll().stream()
            .filter(b -> b.getNomUtilisateur().equals(nomUtilisateur) && b.getMotDePasse().equals(motDePasse))
            .findFirst().orElse(null);
        if (biblio != null) {
            model.addAttribute("bibliothecaire", biblio);
            return "accueil_bibliothecaire";
        } else {
            model.addAttribute("error", "Identifiants invalides");
            return "login_bibliothecaire";
        }
    }
}
