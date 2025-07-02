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
    private Integer quotaEmprunt;

    @Column(name="date_quota")
    private LocalDate dateQuota;

    @Column(name="id_emprunt")
    private Long idEmprunt;

    // ...getters/setters...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Membre getMembre() { return membre; }
    public void setMembre(Membre membre) { this.membre = membre; }
    public Integer getQuotaEmprunt() { return quotaEmprunt; }
    public void setQuotaEmprunt(Integer quotaEmprunt) { this.quotaEmprunt = quotaEmprunt; }
    public LocalDate getDateQuota() { return dateQuota; }
    public void setDateQuota(LocalDate dateQuota) { this.dateQuota = dateQuota; }
    public Long getIdEmprunt() { return idEmprunt; }
    public void setIdEmprunt(Long idEmprunt) { this.idEmprunt = idEmprunt; }
}
