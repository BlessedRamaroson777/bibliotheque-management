package com.bibliotheque.service;

import com.bibliotheque.model.Exemplaire;
import com.bibliotheque.repository.ExemplaireRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DisponibiliteService {
    @Autowired
    private ExemplaireRepository exemplaireRepository;

    public DisponibiliteResult verifierDisponibilite(Long livreId, LocalDateTime dateDispo) {
        List<Exemplaire> exemplaires = exemplaireRepository.findDisponibles(livreId, dateDispo);
        int nbDispo = exemplaires.size();
        LocalDateTime prochaineDate = exemplaireRepository.findProchaineDateDisponible(livreId, dateDispo);

        DisponibiliteResult result = new DisponibiliteResult();
        result.setDisponible(nbDispo > 0);
        result.setNbExemplaires(nbDispo);
        result.setIdExemplaires(exemplaires.stream().map(Exemplaire::getId).collect(Collectors.toList()));
        result.setProchaineDateDisponible(prochaineDate);
        return result;
    }
}