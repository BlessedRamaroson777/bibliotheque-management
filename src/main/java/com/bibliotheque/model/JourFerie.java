package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "jour_ferie")
public class JourFerie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom", nullable = false)
    private String nom;

    @Column(name = "date_jour", nullable = false)
    private LocalDateTime dateJour;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public LocalDateTime getDateJour() { return dateJour; }
    public void setDateJour(LocalDateTime dateJour) { this.dateJour = dateJour; }
}
