package com.bibliotheque.controller;

import com.bibliotheque.model.Membre;
import com.bibliotheque.model.Bibliothecaire;
import com.bibliotheque.repository.MembreRepository;
import com.bibliotheque.repository.BibliothecaireRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {
    @Autowired private MembreRepository membreRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;

    @GetMapping("/login-adherent")
    public String loginAdherentForm(HttpSession session) {
        if (session.getAttribute("role") != null) {
            // Redirige vers l'accueil si déjà connecté
            return "redirect:/index.jsp";
        }
        return "login_adherent";
    }

    @PostMapping("/login-adherent")
    public String loginAdherent(@RequestParam String email, @RequestParam String motDePasse, Model model, HttpSession session) {
        if (session.getAttribute("role") != null) {
            return "redirect:/index.jsp";
        }
        Membre membre = membreRepository.findByEmail(email).orElse(null);
        if (membre != null && membre.getMotDePasse().equals(motDePasse)) {
            session.setAttribute("adherent", membre);
            session.setAttribute("role", "adherent");
            session.setAttribute("idMembre", membre.getId()); // <-- Ajout ici
            model.addAttribute("adherent", membre);
            return "accueil_adherent";
        } else {
            model.addAttribute("error", "Identifiants invalides");
            return "login_adherent";
        }
    }

    @GetMapping("/login-bibliothecaire")
    public String loginBibliothecaireForm(HttpSession session) {
        if (session.getAttribute("role") != null) {
            return "redirect:/index.jsp";
        }
        return "login_bibliothecaire";
    }

    @PostMapping("/login-bibliothecaire")
    public String loginBibliothecaire(@RequestParam String nomUtilisateur, @RequestParam String motDePasse, Model model, HttpSession session) {
        if (session.getAttribute("role") != null) {
            return "redirect:/index.jsp";
        }
        Bibliothecaire biblio = bibliothecaireRepository.findAll().stream()
            .filter(b -> b.getNomUtilisateur().equals(nomUtilisateur) && b.getMotDePasse().equals(motDePasse))
            .findFirst().orElse(null);
        if (biblio != null) {
            session.setAttribute("bibliothecaire", biblio);
            session.setAttribute("role", "bibliothecaire");
            session.setAttribute("idBibliothecaire", biblio.getId()); // <-- Ajout ici
            model.addAttribute("bibliothecaire", biblio);
            return "accueil_bibliothecaire";
        } else {
            model.addAttribute("error", "Identifiants invalides");
            return "login_bibliothecaire";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/index.jsp";
    }
}
