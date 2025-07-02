package com.bibliotheque.service;

import java.time.LocalDate;
import java.util.List;

public class DisponibiliteResult {
    private boolean disponible;
    private int nbExemplaires;
    private List<Long> idExemplaires;
    private LocalDate prochaineDateDisponible;

    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }
    public int getNbExemplaires() { return nbExemplaires; }
    public void setNbExemplaires(int nbExemplaires) { this.nbExemplaires = nbExemplaires; }
    public List<Long> getIdExemplaires() { return idExemplaires; }
    public void setIdExemplaires(List<Long> idExemplaires) { this.idExemplaires = idExemplaires; }
    public LocalDate getProchaineDateDisponible() { return prochaineDateDisponible; }
    public void setProchaineDateDisponible(LocalDate prochaineDateDisponible) { this.prochaineDateDisponible = prochaineDateDisponible; }
}