package com.bibliotheque.service;

import com.bibliotheque.model.Cotisation;
import com.bibliotheque.model.Membre;
import com.bibliotheque.repository.CotisationRepository;
import com.bibliotheque.repository.MembreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CotisationService {
    @Autowired private CotisationRepository cotisationRepository;
    @Autowired private MembreRepository membreRepository;

    public void cotiser(Long idMembre, LocalDateTime dateDebut, LocalDateTime dateFin) {
        Membre membre = membreRepository.findById(idMembre).orElse(null);
        if (membre == null) throw new RuntimeException("Membre inexistant");
        Cotisation cotisation = new Cotisation();
        cotisation.setMembre(membre);
        cotisation.setDateDebut(dateDebut);
        cotisation.setDateFin(dateFin);
        cotisationRepository.save(cotisation);
    }

    public List<Cotisation> getAllCotisations() {
        return cotisationRepository.findAll();
    }

    public List<Cotisation> getCotisationsByMembre(Long idMembre) {
        return cotisationRepository.findByMembreId(idMembre);
    }
}
