package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "quotas_emprunt_membre")
public class QuotaEmpruntMembre {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="id_membre")
    private Membre membre;

    @Column(name="quota_emprunt")
    private Integer quotaEmprunt;

    @Column(name="date_quota")
    private LocalDateTime dateQuota;

    @ManyToOne
    @JoinColumn(name="id_emprunt")
    private Emprunt emprunt;

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }
    public Integer getQuotaEmprunt() { return quotaEmprunt; }
    public void setQuotaEmprunt(Integer quotaEmprunt) { this.quotaEmprunt = quotaEmprunt; }
    public LocalDateTime getDateQuota() { return dateQuota; }
    public void setDateQuota(LocalDateTime dateQuota) { this.dateQuota = dateQuota; }
    public Emprunt getEmprunt() { return emprunt; }
    public void setEmprunt(Emprunt emprunt) { this.emprunt = emprunt; }
}
