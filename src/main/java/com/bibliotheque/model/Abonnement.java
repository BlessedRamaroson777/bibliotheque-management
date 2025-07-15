package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;
@Entity
public class Abonnement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_membre", nullable = false)
    private Membre membre;

    @ManyToOne
    @JoinColumn(name = "id_type_abonnement", nullable = false)
    private TypeAbonnement typeAbonnement;

    @ManyToOne
    @JoinColumn(name = "id_bibliothecaire", nullable = false)
    private Bibliothecaire bibliothecaire;

    @Column(name = "date_abonnement")
    private LocalDateTime dateAbonnement;

    @Column(name = "debut_abonnement")
    private LocalDateTime debutAbonnement;

    @Column(name = "fin_abonnement")
    private LocalDateTime finAbonnement;


    // === Getters & Setters ===

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Membre getMembre() {
        return membre;
    }

    public void setMembre(Membre membre) {
        this.membre = membre;
    }

    public TypeAbonnement getTypeAbonnement() {
        return typeAbonnement;
    }

    public void setTypeAbonnement(TypeAbonnement typeAbonnement) {
        this.typeAbonnement = typeAbonnement;
    }

    public Bibliothecaire getBibliothecaire() {
        return bibliothecaire;
    }

    public void setBibliothecaire(Bibliothecaire bibliothecaire) {
        this.bibliothecaire = bibliothecaire;
    }

    public LocalDateTime getDateAbonnement() {
        return dateAbonnement;
    }

    public void setDateAbonnement(LocalDateTime dateAbonnement) {
        this.dateAbonnement = dateAbonnement;
    }

    public LocalDateTime getDebutAbonnement() {
        return debutAbonnement;
    }

    public void setDebutAbonnement(LocalDateTime debutAbonnement) {
        this.debutAbonnement = debutAbonnement;
    }

    public LocalDateTime getFinAbonnement() {
        return finAbonnement;
    }

    public void setFinAbonnement(LocalDateTime finAbonnement) {
        this.finAbonnement = finAbonnement;
    }
}
