package com.bibliotheque.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;

import com.bibliotheque.model.Membre;
import com.bibliotheque.repository.TypeMembreRepository;
import com.bibliotheque.service.MembreService;


@Controller
@RequestMapping("/membre")
public class MembreController {

    @Autowired
    private MembreService membreService;
    @Autowired
    private TypeMembreRepository typeMembreRepository;

    @PostMapping("/inscrire")
    public String inscrire(@RequestParam String nomUtilisateur,
                            @RequestParam String email,
                            @RequestParam String motDePasse,
                            @RequestParam String confirmationMotDePasse,
                            @RequestParam String dateInscription,
                            @RequestParam String dateNaissance,
                            @RequestParam int idTypeMembre,
                            Model model) {

        model.addAttribute("typesMembres", typeMembreRepository.findAll());
        try {
            Membre membre = membreService.inscrireMembre(
                    nomUtilisateur,
                    email,
                    motDePasse,
                    confirmationMotDePasse,
                    LocalDate.parse(dateInscription),
                    LocalDate.parse(dateNaissance),
                    idTypeMembre
            );
            model.addAttribute("message", "Membre inscrit avec succès. ID : " + membre.getId());
            return "form_inscription";
        } catch (Exception e) {
            model.addAttribute("typesMembres", typeMembreRepository.findAll());
            model.addAttribute("error", e.getMessage() + " - " + (e.getCause() != null ? e.getCause().getMessage() : ""));
            return "form_inscription";
        }
    }
    @GetMapping("/inscrire")
    public String afficherFormulaireInscription(Model model) {
        System.out.println("typesMembres = " + typeMembreRepository.findAll().get(0).getNom());
        model.addAttribute("typesMembres", typeMembreRepository.findAll());
        return "form_inscription";
    }
}
