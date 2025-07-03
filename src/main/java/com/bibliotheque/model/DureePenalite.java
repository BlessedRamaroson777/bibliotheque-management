package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "duree_penalite")
public class DureePenalite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_type_membre")
    private TypeMembre typeMembre;

    @Column(name = "nombre_jour")
    private Integer nombreJour;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public TypeMembre getTypeMembre() { return typeMembre; }
    public void setTypeMembre(TypeMembre typeMembre) { this.typeMembre = typeMembre; }

    public Integer getNombreJour() { return nombreJour; }
    public void setNombreJour(Integer nombreJour) { this.nombreJour = nombreJour; }
}
