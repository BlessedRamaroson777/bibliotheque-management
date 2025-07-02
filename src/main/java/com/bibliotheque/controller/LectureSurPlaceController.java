package com.bibliotheque.controller;

import com.bibliotheque.service.LectureSurPlaceService;
import com.bibliotheque.repository.LivreRepository;
import com.bibliotheque.repository.MembreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LectureSurPlaceController {
    @Autowired private LectureSurPlaceService lectureSurPlaceService;
    @Autowired private LivreRepository livreRepository;
    @Autowired private MembreRepository membreRepository;

    @GetMapping("/form-lecture-sur-place")
    public String formLectureSurPlace(Model model) {
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("adherents", membreRepository.findAll());
        return "form_lecture_sur_place";
    }

    @PostMapping("/lire-sur-place")
    public String lireSurPlace(@RequestParam Long idAdherent, @RequestParam Long idLivre, Model model) {
        String resultat = lectureSurPlaceService.lireSurPlace(idAdherent, idLivre);
        model.addAttribute("resultat", resultat);
        return "resultat_lecture_sur_place";
    }
}