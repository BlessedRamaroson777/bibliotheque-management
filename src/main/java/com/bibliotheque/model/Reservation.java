package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

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
    private LocalDate dateReservation;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @ManyToOne
    @JoinColumn(name = "id_bibliothecaire")
    private Bibliothecaire bibliothecaire;

    @Column(name = "date_traitement")
    private LocalDate dateTraitement;

    @ManyToOne
    @JoinColumn(name = "id_emprunt")
    private Emprunt emprunt;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }

    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }

    public LocalDate getDateReservation() { return dateReservation; }
    public void setDateReservation(LocalDate dateReservation) { this.dateReservation = dateReservation; }

    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }

    public Bibliothecaire getBibliothecaire() { return bibliothecaire; }
    public void setBibliothecaire(Bibliothecaire bibliothecaire) { this.bibliothecaire = bibliothecaire; }

    public LocalDate getDateTraitement() { return dateTraitement; }
    public void setDateTraitement(LocalDate dateTraitement) { this.dateTraitement = dateTraitement; }

    public Emprunt getEmprunt() { return emprunt; }
    public void setEmprunt(Emprunt emprunt) { this.emprunt = emprunt; }
}