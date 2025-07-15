package com.bibliotheque.controller;

import com.bibliotheque.model.Abonnement;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/abonnements")
public class AbonnementController {

    @Autowired
    private AbonnementRepository abonnementRepository;

    @Autowired
    private MembreRepository membreRepository;

    @Autowired
    private BibliothecaireRepository bibliothecaireRepository;

    @Autowired
    private TypeAbonnementRepository typeAbonnementRepository;

    @GetMapping("/form")
    public String afficherFormulaire(Model model) {
        model.addAttribute("membres", membreRepository.findAll());
        model.addAttribute("types", typeAbonnementRepository.findAll());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_abonnement";
    }

    @PostMapping("/ajouter")
    public String ajouterAbonnement(@RequestParam("idMembre") Long idMembre,
                                    @RequestParam("idType") Long idType,
                                    @RequestParam("debut") String debut,
                                    @RequestParam("idBibliothecaire") Long idBibliothecaire) {

        Abonnement a = new Abonnement();
        a.setMembre(membreRepository.findById(idMembre).orElse(null));
        a.setTypeAbonnement(typeAbonnementRepository.findById(idType).orElse(null));
        a.setBibliothecaire(bibliothecaireRepository.findById(idBibliothecaire).orElse(null));  

        LocalDate dateDebut = LocalDate.parse(debut);
        int duree = typeAbonnementRepository.findById(idType).map(t -> t.getDuree()).orElse(0);
        LocalDate dateFin = dateDebut.plusDays(duree);

        a.setDateAbonnement(LocalDateTime.now());
        a.setDebutAbonnement(dateDebut.atStartOfDay());
        a.setFinAbonnement(dateFin.atStartOfDay());

        abonnementRepository.save(a);
        return "redirect:/abonnements/liste";
    }



    @GetMapping("/liste")
    public String liste(Model model) {
        List<Abonnement> abonnements = abonnementRepository.findAll();
        model.addAttribute("abonnements", abonnements);
        model.addAttribute("now", LocalDateTime.now());
        return "liste_abonnement";
    }
}
