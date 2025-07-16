package com.bibliotheque.controller;

import com.bibliotheque.model.Abonnement;
import com.bibliotheque.model.Penalite;
import com.bibliotheque.repository.AbonnementRepository;
import com.bibliotheque.repository.EmpruntRepository;
import com.bibliotheque.repository.PenaliteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/adherents")
public class AdherentRestController {

    @Autowired
    private AbonnementRepository abonnementRepository;

    @Autowired
    private PenaliteRepository penaliteRepository;

    @Autowired
    private EmpruntRepository empruntRepository;

    @GetMapping("/{id}")
    public Map<String, Object> getInfosAdherent(@PathVariable("id") Long idAdherent) {
        Map<String, Object> result = new HashMap<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

        // 1. Abonnement actuel
        Abonnement abonnement = abonnementRepository.findAbonnementActuel(idAdherent, LocalDateTime.now());
        if (abonnement != null) {
            Map<String, Object> aboMap = new HashMap<>();
            aboMap.put("date_debut", abonnement.getDebutAbonnement().format(formatter));
            aboMap.put("date_fin", abonnement.getFinAbonnement().format(formatter));
            aboMap.put("type_abonnement", abonnement.getTypeAbonnement().getNom());
            result.put("abonnement", aboMap);
        } else {
            result.put("abonnement", "Aucun abonnement actif");
        }

        // 2. Nombre d'emprunts en cours (non retournes, pas sur place)
        long nbEmpruntsEnCours = empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .count();
        result.put("quota emprunts", nbEmpruntsEnCours);

        // 3. Somme des jours de pénalité en cours
        LocalDateTime maintenant = LocalDateTime.now();

        long totalPenalite = penaliteRepository.findAll().stream()
            .filter(p -> p.getMembre().getId().equals(idAdherent)
                    && p.getDateRetour() != null
                    && p.getDuree() != null
                    && !maintenant.isBefore(p.getDateRetour())
                    && !maintenant.isAfter(p.getDateRetour().plusDays(p.getDuree())))
            .mapToLong(Penalite::getDuree)
            .sum();

        result.put("Somme penalite en cours", totalPenalite > 0 ? totalPenalite + " jour(s)" : "Non penalise");


        return result;
    }
}
