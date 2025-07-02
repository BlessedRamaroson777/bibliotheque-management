package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "statut_membre")
public class StatutMembre {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="id_membre")
    private Membre membre;

    @ManyToOne
    @JoinColumn(name="id_statut")
    private Statut statut;

    @Column(name="date_statut")
    private LocalDate dateStatut;

    // ...getters/setters...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }
    public Statut getStatut() { return statut; }
    public void setStatut(Statut statut) { this.statut = statut; }
    public LocalDate getDateStatut() { return dateStatut; }
    public void setDateStatut(LocalDate dateStatut) { this.dateStatut = dateStatut; }
}
