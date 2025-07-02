package com.bibliotheque.controller;

import com.bibliotheque.model.Livre;
import com.bibliotheque.repository.LivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;

@Controller
public class LivreController {
    @Autowired
    private LivreRepository livreRepository;

    @GetMapping("/rechercher-livres")
    public String rechercherLivres(@RequestParam(required = false) String titre,
                                   @RequestParam(required = false) String dateEdition,
                                   @RequestParam(required = false) String nomAuteur,
                                   @RequestParam(required = false) String typeAuteur,
                                   @RequestParam(required = false) String typeLivre,
                                   Model model) {
        LocalDate date = null;
        if (dateEdition != null && !dateEdition.isEmpty()) {
            date = LocalDate.parse(dateEdition);
        }
        List<Livre> livres;
        if (titre == null && date == null && nomAuteur == null && typeAuteur == null && typeLivre == null) {
            livres = livreRepository.findAll();
        } else {
            livres = livreRepository.rechercherLivres(
                titre, date, nomAuteur, typeAuteur, typeLivre
            );
        }
        model.addAttribute("livres", livres);
        return "liste_livres";
    }

    @GetMapping("/form-recherche-livre")
    public String afficherFormulaireRecherche() {
        return "form_recherche_livre";
    }
}
