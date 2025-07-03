package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class LectureSurPlaceService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private StatutMembreRepository statutMembreRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private AutorisationRepository autorisationRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;

    public String lireSurPlace(Long idAdherent, Long idLivre, Long idBibliothecaire, LocalDateTime dateLecture) {
        // 1. Verifier que l'adherent existe
        Membre membre = membreRepository.findById(idAdherent).orElse(null);
        if (membre == null) return "Adherent inexistant.";

        // 2. Verifier que l'adherent est actif
        boolean actif = statutMembreRepository.findAll().stream()
            .anyMatch(s -> s.getMembre().getId().equals(idAdherent) && s.getStatut().getValeur().equalsIgnoreCase("actif"));
        if (!actif) return "Adherent inactif.";

        // 3. Verifier que l'adherent n'est pas penalise
        boolean penalise = penaliteRepository.findAll().stream()
            .anyMatch(p -> p.getMembre().getId().equals(idAdherent) && p.getDateRetour() == null);
        if (penalise) return "Adherent penalise.";

        // 4. Verifier que le livre existe
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Livre inexistant.";

        // 5. Verifier qu'il y a un exemplaire disponible à la date demandée
        List<Exemplaire> exemplaires = exemplaireRepository.findDisponibles(idLivre, dateLecture);
        if (exemplaires.isEmpty()) return "Aucun exemplaire disponible pour ce livre.";

        // 6. Verifier que le livre est compatible avec l'adherent (autorisation)
        boolean autorise = autorisationRepository.findAll().stream()
            .anyMatch(a -> a.getTypeMembre().getId().equals(membre.getTypeMembre().getId()) && a.getLivre().getId().equals(idLivre));
        if (!autorise) return "Ce livre n'est pas autorise pour ce type d'adherent.";

        // 7. Retourner l'exemplaire disponible (le premier)
        Exemplaire exemplaire = exemplaires.get(0);
        Bibliothecaire biblio = bibliothecaireRepository.findById(idBibliothecaire).orElse(null);
        if (biblio == null) return "Bibliothecaire inexistant.";

        Emprunt emprunt = new Emprunt();
        emprunt.setMembre(membre);
        emprunt.setExemplaire(exemplaire);
        emprunt.setDateEmprunt(dateLecture);
        emprunt.setDateDebut(dateLecture);
        emprunt.setDateEcheance(dateLecture);
        emprunt.setSurPlace(true);
        emprunt.setBiblioEmprunt(biblio); // <-- obligatoire !
        empruntRepository.save(emprunt);

        return "Exemplaire n " + exemplaire.getNumeroExemplaire() + " enregistre pour lecture sur place.";
    }

    // Utilise la même méthode de calcul si besoin pour la date d'échéance
    // private LocalDateTime calculerDateEcheanceSansWeekends(...) { ... } (voir EmpruntService)
}