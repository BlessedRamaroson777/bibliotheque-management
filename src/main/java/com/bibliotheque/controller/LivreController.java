package com.bibliotheque.controller;

import com.bibliotheque.repository.LivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
// Ajoute ces imports
import com.bibliotheque.repository.AuteurRepository;
import com.bibliotheque.repository.GenreLivreRepository;
@Controller
public class LivreController {
    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private AuteurRepository auteurRepository;
    @Autowired
    private GenreLivreRepository genreLivreRepository;

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

        titre = (titre != null && !titre.trim().isEmpty()) ? titre : null;
        nomAuteur = (nomAuteur != null && !nomAuteur.trim().isEmpty()) ? nomAuteur : null;
        typeAuteur = (typeAuteur != null && !typeAuteur.trim().isEmpty()) ? typeAuteur : null;
        typeLivre = (typeLivre != null && !typeLivre.trim().isEmpty()) ? typeLivre : null;

        if (titre == null && date == null && nomAuteur == null && typeAuteur == null && typeLivre == null) {
            model.addAttribute("livres", livreRepository.findAll());
        } else {
            model.addAttribute("livres", livreRepository.rechercherLivres(
                titre, date, nomAuteur, typeAuteur, typeLivre
            ));
        }
        return "liste_livres";
    }

    @GetMapping("/form-recherche-livre")
    public String afficherFormulaireRecherche(Model model) {
        model.addAttribute("auteurs", auteurRepository.findAll());
        model.addAttribute("genres", genreLivreRepository.findAll());
        return "form_recherche_livre";
    }
}
