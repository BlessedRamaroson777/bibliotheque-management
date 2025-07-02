package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "exemplaire")
public class Exemplaire {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_livre")
    private Livre livre;

    @Column(name = "numero_exemplaire")
    private Integer numeroExemplaire;
    
    @OneToMany(mappedBy = "exemplaire", fetch = FetchType.EAGER)
    private java.util.List<Emprunt> emprunts;

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }
    public Integer getNumeroExemplaire() { return numeroExemplaire; }
    public void setNumeroExemplaire(Integer numeroExemplaire) { this.numeroExemplaire = numeroExemplaire; }
    public java.util.List<Emprunt> getEmprunts() { return emprunts; }
    public void setEmprunts(java.util.List<Emprunt> emprunts) { this.emprunts = emprunts; }
}