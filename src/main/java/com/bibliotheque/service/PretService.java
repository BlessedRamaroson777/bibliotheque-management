package com.bibliotheque.service;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class PretService {
    @Autowired private MembreRepository membreRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private StatutMembreRepository statutMembreRepository;
    @Autowired private PenaliteRepository penaliteRepository;
    @Autowired private AutorisationRepository autorisationRepository;
    @Autowired private EmpruntRepository empruntRepository;
    @Autowired private DureeEmpruntRepository dureeEmpruntRepository;
    @Autowired private BibliothecaireRepository bibliothecaireRepository;
    @Autowired private JourFerieRepository jourFerieRepository;

    public String preterLivre(Long idAdherent, Long idLivre, Long idBibliothecaire) {
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

        // 4. Verifier que l'adherent n'a pas atteint son quota d'emprunt
        int quota = membre.getTypeMembre().getQuota();
        long empruntsEnCours = empruntRepository.findByMembreId(idAdherent).stream()
            .filter(e -> e.getDateRetour() == null && !Boolean.TRUE.equals(e.getSurPlace()))
            .count();
        if (empruntsEnCours >= quota) return "Quota d'emprunt atteint.";

        // 5. Verifier que le livre existe
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Livre inexistant.";

        // Vérifier l'âge minimum requis
        if (livre.getAgeMinimum() != null && membre.getNaissance() != null) {
            int age = java.time.Period.between(membre.getNaissance().toLocalDate(), java.time.LocalDate.now()).getYears();
            if (age < livre.getAgeMinimum()) {
                return "Vous n'avez pas l'age minimum requis (" + livre.getAgeMinimum() + " ans) pour emprunter ce livre.";
            }
        }

        // 6. Verifier qu'il y a un exemplaire disponible
        List<Exemplaire> exemplaires = exemplaireRepository.findDisponibles(idLivre, LocalDateTime.now());
        if (exemplaires.isEmpty()) return "Aucun exemplaire disponible pour ce livre.";

        // 7. Verifier que le livre est compatible avec l'adherent (autorisation)
        boolean autorise = autorisationRepository.findAll().stream()
            .anyMatch(a -> a.getTypeMembre().getId().equals(membre.getTypeMembre().getId()) && a.getLivre().getId().equals(idLivre));
        if (!autorise) return "Ce livre n'est pas autorise pour ce type d'adherent.";

        // 8. Creer l'emprunt
        Exemplaire exemplaire = exemplaires.get(0);
        Bibliothecaire biblio = bibliothecaireRepository.findById(idBibliothecaire).orElse(null);
        if (biblio == null) return "Bibliothecaire inexistant.";

        Emprunt emprunt = new Emprunt();
        emprunt.setMembre(membre);
        emprunt.setExemplaire(exemplaire);
        emprunt.setDateEmprunt(LocalDateTime.now());
        emprunt.setDateDebut(LocalDateTime.now());
        // Calcul de la date d'echeance (exemple : +15 jours ouvrés hors jours fériés)
        emprunt.setDateEcheance(calculerDateEcheanceSansJoursFeries(LocalDateTime.now()));
        emprunt.setSurPlace(false);
        emprunt.setBiblioEmprunt(biblio);
        empruntRepository.save(emprunt);

        return "Exemplaire n " + exemplaire.getNumeroExemplaire() + " prete. Date de rendu prevue : " + emprunt.getDateEcheance();
    }

    LocalDateTime calculerDateEcheanceSansJoursFeries(LocalDateTime dateDebut) {
        Integer nbJours = dureeEmpruntRepository.findAll().stream()
            .map(d -> d.getDuree()) // getDuree() doit retourner un int ou Integer
            .findFirst()
            .orElse(15); // Valeur par défaut si vide
        Set<LocalDate> joursFeries = jourFerieRepository.findAll().stream()
            .map(jf -> jf.getDateJour().toLocalDate())
            .collect(Collectors.toSet());

        LocalDateTime date = dateDebut;
        int joursAjoutes = 0;

        while (joursAjoutes < nbJours) {
            date = date.plusDays(1);
            DayOfWeek jour = date.getDayOfWeek();
            boolean estWeekend = (jour == DayOfWeek.SATURDAY || jour == DayOfWeek.SUNDAY);
            boolean estFerie = joursFeries.contains(date.toLocalDate());

            if (!estWeekend && !estFerie) {
                joursAjoutes++;
            }
        }

        return date;
    }


    public List<Emprunt> getPretsEnCours() {
        // Prêts classiques (pas sur place) et non rendus
        return empruntRepository.findAll().stream()
            .filter(e -> (e.getDateRetour() == null) && !Boolean.TRUE.equals(e.getSurPlace()))
            .toList();
    }
}