package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_membre")
    private Membre membre;

    @ManyToOne
    @JoinColumn(name = "id_livre")
    private Livre livre;

    @Column(name = "date_reservation")
    private LocalDateTime dateReservation;

    @Column(name = "date_debut")
    private LocalDateTime dateDebut;

    @ManyToOne
    @JoinColumn(name = "id_bibliothecaire")
    private Bibliothecaire bibliothecaire;

    @Column(name = "date_traitement")
    private LocalDateTime dateTraitement;

    @ManyToOne
    @JoinColumn(name = "id_emprunt")
    private Emprunt emprunt;

    @Column(name = "etat")
    private String etat = "en_cours";

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }

    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }

    public LocalDateTime getDateReservation() { return dateReservation; }
    public void setDateReservation(LocalDateTime dateReservation) { this.dateReservation = dateReservation; }

    public LocalDateTime getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDateTime dateDebut) { this.dateDebut = dateDebut; }

    public Bibliothecaire getBibliothecaire() { return bibliothecaire; }
    public void setBibliothecaire(Bibliothecaire bibliothecaire) { this.bibliothecaire = bibliothecaire; }

    public LocalDateTime getDateTraitement() { return dateTraitement; }
    public void setDateTraitement(LocalDateTime dateTraitement) { this.dateTraitement = dateTraitement; }

    public Emprunt getEmprunt() { return emprunt; }
    public void setEmprunt(Emprunt emprunt) { this.emprunt = emprunt; }

    public String getEtat() { return etat; }
    public void setEtat(String etat) { this.etat = etat; }
}