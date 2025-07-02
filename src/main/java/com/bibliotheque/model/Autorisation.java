package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "autorisation")
public class Autorisation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_type_membre")
    private TypeMembre typeMembre;

    @ManyToOne
    @JoinColumn(name = "id_livre")
    private Livre livre;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public TypeMembre getTypeMembre() { return typeMembre; }
    public void setTypeMembre(TypeMembre typeMembre) { this.typeMembre = typeMembre; }

    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }
}