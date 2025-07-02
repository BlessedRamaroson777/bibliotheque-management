package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class LectureSurPlaceService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private StatutMembreRepository statutMembreRepository;
    @Autowired private QuotaMembreRepository quotaMembreRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private AutorisationRepository autorisationRepository;

    public String lireSurPlace(Long idAdherent, Long idLivre) {
        // 1. Vérifier que l'adhérent existe
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "Adhérent inexistant.";

        // 2. Vérifier que l'adhérent est actif
        boolean actif = statutMembreRepository.findAll().stream()
            .anyMatch(s -> s.getMembre().getId().equals(idAdherent) && s.getStatut().getValeur().equalsIgnoreCase("actif"));
        if (!actif) return "Adhérent inactif.";

        // 3. Vérifier que l'adhérent n'est pas pénalisé
        boolean penalise = penaliteRepository.findAll().stream()
            .anyMatch(p -> p.getMembre().getId().equals(idAdherent) && p.getDateRetour() == null);
        if (penalise) return "Adhérent pénalisé.";

        // 4. Vérifier que le livre existe
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Livre inexistant.";

        // 5. Vérifier qu'il y a un exemplaire disponible
        List<Exemplaire> exemplaires = exemplaireRepository.findDisponibles(idLivre, LocalDate.now());
        if (exemplaires.isEmpty()) return "Aucun exemplaire disponible pour ce livre.";

        // 6. Vérifier que le livre est compatible avec l'adhérent (autorisation)
        boolean autorise = autorisationRepository.findAll().stream()
            .anyMatch(a -> a.getTypeMembre().getId().equals(membre.getTypeMembre().getId()) && a.getLivre().getId().equals(idLivre));
        if (!autorise) return "Ce livre n'est pas autorisé pour ce type d'adhérent.";

        // 7. Retourner l'exemplaire disponible (le premier)
        return "Exemplaire disponible pour lecture sur place : n°" + exemplaires.get(0).getNumeroExemplaire();
    }
}