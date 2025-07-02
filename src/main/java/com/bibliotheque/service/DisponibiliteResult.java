package com.bibliotheque.service;

import java.time.LocalDateTime;
import java.util.List;

public class DisponibiliteResult {
    private boolean disponible;
    private int nbExemplaires;
    private List<Long> idExemplaires;
    private LocalDateTime prochaineDateDisponible;

    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }
    public int getNbExemplaires() { return nbExemplaires; }
    public void setNbExemplaires(int nbExemplaires) { this.nbExemplaires = nbExemplaires; }
    public List<Long> getIdExemplaires() { return idExemplaires; }
    public void setIdExemplaires(List<Long> idExemplaires) { this.idExemplaires = idExemplaires; }
    public LocalDateTime getProchaineDateDisponible() { return prochaineDateDisponible; }
    public void setProchaineDateDisponible(LocalDateTime prochaineDateDisponible) { this.prochaineDateDisponible = prochaineDateDisponible; }
}