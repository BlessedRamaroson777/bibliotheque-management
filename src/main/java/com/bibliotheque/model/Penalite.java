package com.bibliotheque.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "penalite")
public class Penalite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_emprunt")
    private Emprunt emprunt;

    @ManyToOne
    @JoinColumn(name = "id_membre")
    private Membre membre;

    @Column(name = "date_echeance")
    private LocalDateTime dateEcheance;

    @Column(name = "date_retour")
    private LocalDateTime dateRetour;

    @Column(name = "cout")
    private BigDecimal cout;

    @Column(name = "duree")
    private Integer duree;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Emprunt getEmprunt() { return emprunt; }
    public void setEmprunt(Emprunt emprunt) { this.emprunt = emprunt; }

    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }

    public LocalDateTime getDateEcheance() { return dateEcheance; }
    public void setDateEcheance(LocalDateTime dateEcheance) { this.dateEcheance = dateEcheance; }

    public LocalDateTime getDateRetour() { return dateRetour; }
    public void setDateRetour(LocalDateTime dateRetour) { this.dateRetour = dateRetour; }

    public BigDecimal getCout() { return cout; }
    public void setCout(BigDecimal cout) { this.cout = cout; }

    public Integer getDuree() { return duree; }
    public void setDuree(Integer duree) { this.duree = duree; }
}