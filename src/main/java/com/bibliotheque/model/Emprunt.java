package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "emprunt")
public class Emprunt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

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
    private LocalDate dateEmprunt;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_echeance")
    private LocalDate dateEcheance;

    @ManyToOne
    @JoinColumn(name = "id_biblio_retour")
    private Bibliothecaire biblioRetour;

    @Column(name = "date_retour")
    private LocalDate dateRetour;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }
    public Exemplaire getExemplaire() { return exemplaire; }
    public void setExemplaire(Exemplaire exemplaire) { this.exemplaire = exemplaire; }
    public Bibliothecaire getBiblioEmprunt() { return biblioEmprunt; }
    public void setBiblioEmprunt(Bibliothecaire biblioEmprunt) { this.biblioEmprunt = biblioEmprunt; }
    public LocalDate getDateEmprunt() { return dateEmprunt; }
    public void setDateEmprunt(LocalDate dateEmprunt) { this.dateEmprunt = dateEmprunt; }
    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }
    public LocalDate getDateEcheance() { return dateEcheance; }
    public void setDateEcheance(LocalDate dateEcheance) { this.dateEcheance = dateEcheance; }
    public Bibliothecaire getBiblioRetour() { return biblioRetour; }
    public void setBiblioRetour(Bibliothecaire biblioRetour) { this.biblioRetour = biblioRetour; }
    public LocalDate getDateRetour() { return dateRetour; }
    public void setDateRetour(LocalDate dateRetour) { this.dateRetour = dateRetour; }
}