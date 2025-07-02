package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class PretService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private StatutMembreRepository statutMembreRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private AutorisationRepository autorisationRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private QuotaMembreRepository quotaMembreRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;

    public String preterLivre(Long idAdherent, Long idLivre, Long idBibliothecaire) {
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

        // 4. Vérifier que l'adhérent n'a pas atteint son quota d'emprunt
        int quota = membre.getTypeMembre().getQuota();
        long empruntsEnCours = empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .count();
        if (empruntsEnCours >= quota) return "Quota d'emprunt atteint.";

        // 5. Vérifier que le livre existe
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Livre inexistant.";

        // 6. Vérifier qu'il y a un exemplaire disponible
        List<Exemplaire> exemplaires = exemplaireRepository.findDisponibles(idLivre, LocalDateTime.now());
        if (exemplaires.isEmpty()) return "Aucun exemplaire disponible pour ce livre.";

        // 7. Vérifier que le livre est compatible avec l'adhérent (autorisation)
        boolean autorise = autorisationRepository.findAll().stream()
            .anyMatch(a -> a.getTypeMembre().getId().equals(membre.getTypeMembre().getId()) && a.getLivre().getId().equals(idLivre));
        if (!autorise) return "Ce livre n'est pas autorisé pour ce type d'adhérent.";

        // 8. Créer l'emprunt
        Exemplaire exemplaire = exemplaires.get(0);
        Bibliothecaire biblio = bibliothecaireRepository.findById(idBibliothecaire).orElse(null);
        if (biblio == null) return "Bibliothécaire inexistant.";

        Emprunt emprunt = new Emprunt();
        emprunt.setMembre(membre);
        emprunt.setExemplaire(exemplaire);
        emprunt.setDateEmprunt(LocalDateTime.now());
        emprunt.setDateDebut(LocalDateTime.now());
        // Calcul de la date d'échéance (exemple : +15 jours)
        emprunt.setDateEcheance(LocalDateTime.now().plusDays(15));
        emprunt.setSurPlace(false);
        emprunt.setBiblioEmprunt(biblio);
        empruntRepository.save(emprunt);

        return "Exemplaire n°" + exemplaire.getNumeroExemplaire() + " prêté. Date de rendu prévue : " + emprunt.getDateEcheance();
    }
}