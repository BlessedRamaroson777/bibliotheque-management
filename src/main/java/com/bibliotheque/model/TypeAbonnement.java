package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "type_abonnement")
public class TypeAbonnement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;

    private Double cout;

    private Integer duree;

    // Getters & Setters

    public Long getId() { return id; }

    public String getNom() { return nom; }

    public void setId(Long id) { this.id = id; }

    public void setNom(String nom) { this.nom = nom; }

    public Double getCout() { return cout; }

    public void setCout(Double cout) { this.cout = cout; }

    public Integer getDuree() { return duree; }

    public void setDuree(Integer duree) { this.duree = duree; }
}
