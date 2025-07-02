package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "auteur")
public class Auteur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nom;
    private String nomArtiste;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getNomArtiste() { return nomArtiste; }
    public void setNomArtiste(String nomArtiste) { this.nomArtiste = nomArtiste; }
}
