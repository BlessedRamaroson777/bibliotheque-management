package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "quotas_emprunt_membre")
public class QuotaMembre {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="id_membre")
    private Membre membre;

    @Column(name="quota_emprunt")
    private Integer quota_emprunt;

    @Column(name="date_quota")
    private LocalDate date_quota;

    @Column(name="id_emprunt")
    private Long id_emprunt;

    // ...getters/setters...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }
    public Integer getQuotaEmprunt() { return quota_emprunt; }
    public void setQuotaEmprunt(Integer quota_emprunt) { this.quota_emprunt = quota_emprunt; }
    public LocalDate getDateQuota() { return date_quota; }
    public void setDateQuota(LocalDate date_quota) { this.date_quota = date_quota; }
    public Long getIdEmprunt() { return id_emprunt; }
    public void setIdEmprunt(Long id_emprunt) { this.id_emprunt = id_emprunt; }
}
