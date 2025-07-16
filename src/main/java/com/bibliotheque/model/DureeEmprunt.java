package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "duree_emprunt")
public class DureeEmprunt {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer duree;

    @ManyToOne
    @JoinColumn(name = "id_type_membre")
    private TypeMembre typeMembre;

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

    public TypeMembre getTypeMembre() {
        return typeMembre;
    }

    public void setTypeMembre(TypeMembre typeMembre) {
        this.typeMembre = typeMembre;
    }
}
