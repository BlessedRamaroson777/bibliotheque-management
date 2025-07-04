package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "demande_emprunt")
public class DemandeEmprunt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_membre", nullable = false)
    private Membre membre;

    @ManyToOne
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;

    @Column(name = "date_demande", nullable = false)
    private LocalDateTime dateDemande;

    @Column(name = "date_prevu", nullable = false)
    private LocalDateTime datePrevu;
    
    @Column(name = "statut", nullable = false)
    private String statut = "en_attente"; // 'en_attente', 'validee', 'refusee'

    @Column(name = "date_traitement")
    private LocalDateTime dateTraitement;

    @ManyToOne
    @JoinColumn(name = "id_bibliothecaire")
    private Bibliothecaire bibliothecaire;

    @ManyToOne
    @JoinColumn(name = "id_exemplaire")
    private Exemplaire exemplaire; // attribué si validé

    // Getters & Setters

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }

    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }

    public LocalDateTime getDateDemande() { return dateDemande; }
    public void setDateDemande(LocalDateTime dateDemande) { this.dateDemande = dateDemande; }

    public LocalDateTime getDatePrevu() { return datePrevu; }
    public void setDatePrevu(LocalDateTime datePrevu) { this.datePrevu = datePrevu; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public LocalDateTime getDateTraitement() { return dateTraitement; }
    public void setDateTraitement(LocalDateTime dateTraitement) { this.dateTraitement = dateTraitement; }

    public Bibliothecaire getBibliothecaire() { return bibliothecaire; }
    public void setBibliothecaire(Bibliothecaire bibliothecaire) { this.bibliothecaire = bibliothecaire; }

    public Exemplaire getExemplaire() { return exemplaire; }
    public void setExemplaire(Exemplaire exemplaire) { this.exemplaire = exemplaire; }
}
