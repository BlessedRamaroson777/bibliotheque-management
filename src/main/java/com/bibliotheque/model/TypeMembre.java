package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "type_membre")
public class TypeMembre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private Integer quota;
    private Integer quota_reservation;
    private Integer quota_prolongation;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public Integer getQuota() { return quota; }
    public void setQuota(Integer quota) { this.quota = quota; }
    
    public Integer getQuotaReservation() { return quota_reservation; }
    public void setQuotaReservation(Integer quota_reservation) { this.quota_reservation = quota_reservation; }

    public Integer getQuotaProlongation() { return quota_prolongation; }
    public void setQuotaProlongation(Integer quota_prolongation) { this.quota_prolongation = quota_prolongation; }
}