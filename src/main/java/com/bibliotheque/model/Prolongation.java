package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "prolongation")
public class Prolongation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_emprunt")
    private Emprunt emprunt;

    @Column(name = "date_prolongation")
    private LocalDateTime dateProlongation;

    @Column(name = "ancienne_echeance")
    private LocalDateTime ancienneEcheance;

    @Column(name = "nouvelle_echeance")
    private LocalDateTime nouvelleEcheance;

    @Column(name = "accordee")
    private Boolean accordee; // null = en attente, true = accordée, false = refusée

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Emprunt getEmprunt() { return emprunt; }
    public void setEmprunt(Emprunt emprunt) { this.emprunt = emprunt; }

    public LocalDateTime getDateProlongation() { return dateProlongation; }
    public void setDateProlongation(LocalDateTime dateProlongation) { this.dateProlongation = dateProlongation; }

    public LocalDateTime getAncienneEcheance() { return ancienneEcheance; }
    public void setAncienneEcheance(LocalDateTime ancienneEcheance) { this.ancienneEcheance = ancienneEcheance; }

    public LocalDateTime getNouvelleEcheance() { return nouvelleEcheance; }
    public void setNouvelleEcheance(LocalDateTime nouvelleEcheance) { this.nouvelleEcheance = nouvelleEcheance; }

    public Boolean getAccordee() { return accordee; }
    public void setAccordee(Boolean accordee) { this.accordee = accordee; }
}