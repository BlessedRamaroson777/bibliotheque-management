package com.bibliotheque.controller;

import com.bibliotheque.model.DemandeEmprunt;
import com.bibliotheque.repository.*;
import com.bibliotheque.model.Livre;
import com.bibliotheque.service.DemandeEmpruntService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/demandes")
public class DemandeEmpruntController {

    @Autowired private DemandeEmpruntService demandeEmpruntService;
    @Autowired private LivreRepository livreRepository;
    

    // Formulaire pour adhérent
    @GetMapping("/nouvelle")
    public String formulaireDemande(Model model) {
        List<Livre> livresDispos = livreRepository.findAll(); // à implémenter dans le service
        model.addAttribute("livres", livresDispos);
        return "formulaire_demande";
    }

    @PostMapping("/nouvelle")
    public String creerDemande(@RequestParam Long idMembre,
                            @RequestParam Long idLivre,
                            @RequestParam String dateDemande,
                            @RequestParam String datePrevu,
                            Model model) {
        String resultat = demandeEmpruntService.creerDemandeAvecDates(idMembre, idLivre, dateDemande, datePrevu);
        model.addAttribute("resultat", resultat);
        List<Livre> livresDispos = livreRepository.findAll(); // à implémenter dans le service
        model.addAttribute("livres", livresDispos);
        return "formulaire_demande";
    }


    // Page admin : liste des demandes en attente
    @GetMapping("/en-attente")
        public String listeDemandesAdmin(Model model) {
            List<DemandeEmprunt> demandesEnAttente = demandeEmpruntService.findDemandesEnAttente();
            List<DemandeEmprunt> demandesNonEnAttente = demandeEmpruntService.findDemandesNonEnAttente();

            model.addAttribute("demandesEnAttente", demandesEnAttente);
            model.addAttribute("demandesNonEnAttente", demandesNonEnAttente);
            return "liste_demandes_en_attente";
        }


    // Valider une demande (admin)
    @PostMapping("/{id}/valider")
    public String validerDemande(@PathVariable Long id, @RequestParam Long idBibliothecaire, Model model) {
        String resultat = demandeEmpruntService.validerDemande(id, idBibliothecaire);
        model.addAttribute("resultat", resultat);
        return "redirect:/demandes/en-attente";
    }

    // Refuser une demande (admin)
    @PostMapping("/{id}/refuser")
    public String refuserDemande(@PathVariable Long id, @RequestParam Long idBibliothecaire, Model model) {
        String resultat = demandeEmpruntService.refuserDemande(id, idBibliothecaire);
        model.addAttribute("resultat", resultat);
        return "redirect:/demandes/en-attente";
    }

    // Afficher les demandes validées pour un adhérent donné
    @GetMapping("/validees")
    public String listeDemandesValideesAdherent(@RequestParam Long idAdherent, Model model) {
        List<DemandeEmprunt> demandesValidees = demandeEmpruntService.findDemandesValideesParAdherent(idAdherent);
        model.addAttribute("demandesValidees", demandesValidees);
        model.addAttribute("idAdherent", idAdherent);
        return "liste_demandes_validees";
    }

}
