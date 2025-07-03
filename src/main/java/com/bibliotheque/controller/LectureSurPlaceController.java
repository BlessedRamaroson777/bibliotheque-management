package com.bibliotheque.controller;

import com.bibliotheque.service.LectureSurPlaceService;
import com.bibliotheque.model.Emprunt;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LectureSurPlaceController {
    @Autowired private LectureSurPlaceService lectureSurPlaceService;
    @Autowired private LivreRepository livreRepository;
    @Autowired private MembreRepository membreRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;

    @GetMapping("/form-lecture-sur-place")
    public String formLectureSurPlace(Model model) {
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        model.addAttribute("bibliothecaires", bibliothecaireRepository.findAll());
        return "form_lecture_sur_place";
    }

    @PostMapping("/lire-sur-place")
    public String lireSurPlace(
        @RequestParam Long idAdherent,
        @RequestParam Long idLivre,
        @RequestParam Long idBibliothecaire,
        @RequestParam String dateLecture,
        Model model
    ) {
        String resultat = lectureSurPlaceService.lireSurPlace(idAdherent, idLivre, idBibliothecaire, java.time.LocalDateTime.parse(dateLecture));
        model.addAttribute("resultat", resultat);
        return "resultat_lecture_sur_place";
    }

    @GetMapping("/lectures-sur-place")
    public String listeLecturesSurPlace(Model model) {
        model.addAttribute("enCours", empruntRepository.findLecturesSurPlaceEnCours());
        model.addAttribute("terminees", empruntRepository.findLecturesSurPlaceTerminees());
        return "liste_lectures_sur_place";
    }

    @PostMapping("/finir-lecture-sur-place")
    public String finirLectureSurPlace(@RequestParam Long empruntId) {
        Emprunt emprunt = empruntRepository.findById(empruntId).orElse(null);
        if (emprunt != null && emprunt.getSurPlace() && emprunt.getDateRetour() == null) {
            emprunt.setDateRetour(java.time.LocalDateTime.now());
            empruntRepository.save(emprunt);
        }
        return "redirect:/lectures-sur-place";
    }
}