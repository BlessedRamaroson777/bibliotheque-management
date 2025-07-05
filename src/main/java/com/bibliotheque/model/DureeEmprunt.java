package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "duree_emprunt")
public class DureeEmprunt {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "duree", nullable = false)
    private Integer duree;

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getDuree() {
        return duree;
    }

    public void setDuree(Integer duree) {
        this.duree = duree;
    }
}
