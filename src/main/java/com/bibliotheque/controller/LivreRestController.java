package com.bibliotheque.controller;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/livres")
public class LivreRestController {

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private ExemplaireRepository exemplaireRepository;

    @Autowired
    private EmpruntRepository empruntRepository;

    @GetMapping("/{id}")
    public Map<String, Object> getInfosLivre(@PathVariable("id") Long idLivre) {
        Map<String, Object> result = new HashMap<>();

        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) {
            result.put("erreur", "Livre inexistant");
            return result;
        }

        result.put("id", livre.getId());
        result.put("titre", livre.getTitre());
        result.put("date_edition", livre.getDateEdition());
        result.put("age_minimum", livre.getAgeMinimum());

        List<Exemplaire> exemplaires = exemplaireRepository.findByLivreId(idLivre);

        List<Map<String, Object>> listeExemplaires = exemplaires.stream().map(ex -> {
            boolean emprunte = empruntRepository.findByExemplaireId(ex.getId()).stream()
                .anyMatch(e -> e.getDateRetour() == null);
            Map<String, Object> map = new HashMap<>();
            // map.put("id", ex.getId());
            map.put("numero Exemplaire", ex.getNumeroExemplaire());
            map.put("disponible", !emprunte);
            return map;
        }).collect(Collectors.toList());

        result.put("exemplaires", listeExemplaires);
        return result;
    }
}
