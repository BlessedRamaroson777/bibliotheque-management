package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "emprunt")
public class Emprunt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "sur_place")
    private Boolean surPlace = false;

    @ManyToOne
    @JoinColumn(name = "id_membre")
    private Membre membre;

    @ManyToOne
    @JoinColumn(name = "id_exemplaire")
    private Exemplaire exemplaire;

    @ManyToOne
    @JoinColumn(name = "id_biblio_emprunt")
    private Bibliothecaire biblioEmprunt;

    @Column(name = "date_emprunt")
    private LocalDateTime dateEmprunt;

    @Column(name = "date_debut")
    private LocalDateTime dateDebut;

    @Column(name = "date_echeance")
    private LocalDateTime dateEcheance;

    @ManyToOne
    @JoinColumn(name = "id_biblio_retour")
    private Bibliothecaire biblioRetour;

    @Column(name = "date_retour")
    private LocalDateTime dateRetour;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Boolean getSurPlace() { return surPlace; }
    public void setSurPlace(Boolean surPlace) { this.surPlace = surPlace; }
    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }
    public Exemplaire getExemplaire() { return exemplaire; }
    public void setExemplaire(Exemplaire exemplaire) { this.exemplaire = exemplaire; }
    public Bibliothecaire getBiblioEmprunt() { return biblioEmprunt; }
    public void setBiblioEmprunt(Bibliothecaire biblioEmprunt) { this.biblioEmprunt = biblioEmprunt; }
    public LocalDateTime getDateEmprunt() { return dateEmprunt; }
    public void setDateEmprunt(LocalDateTime dateEmprunt) { this.dateEmprunt = dateEmprunt; }
    public LocalDateTime getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDateTime dateDebut) { this.dateDebut = dateDebut; }
    public LocalDateTime getDateEcheance() { return dateEcheance; }
    public void setDateEcheance(LocalDateTime dateEcheance) { this.dateEcheance = dateEcheance; }
    public Bibliothecaire getBiblioRetour() { return biblioRetour; }
    public void setBiblioRetour(Bibliothecaire biblioRetour) { this.biblioRetour = biblioRetour; }
    public LocalDateTime getDateRetour() { return dateRetour; }
    public void setDateRetour(LocalDateTime dateRetour) { this.dateRetour = dateRetour; }
}