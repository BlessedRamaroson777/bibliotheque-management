package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "quotas_prolongation_membre")
public class QuotasProlongationMembre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "id_membre", nullable = false)
    private Long idMembre;

    @Column(name = "quota_prolongation", nullable = false)
    private int quotaProlongation;

    @Column(name = "date_quota", nullable = false)
    private LocalDateTime dateQuota;

    @ManyToOne
    @JoinColumn(name = "id_prolongation", nullable = false)
    private Prolongation prolongation;

    // Getters & Setters

    public Long getId() {
        return id;
    }

    public Long getIdMembre() {
        return idMembre;
    }

    public void setIdMembre(Long idMembre) {
        this.idMembre = idMembre;
    }

    public int getQuotaProlongation() {
        return quotaProlongation;
    }

    public void setQuotaProlongation(int quotaProlongation) {
        this.quotaProlongation = quotaProlongation;
    }

    public LocalDateTime getDateQuota() {
        return dateQuota;
    }

    public void setDateQuota(LocalDateTime dateQuota) {
        this.dateQuota = dateQuota;
    }

    public Prolongation getProlongation() {
        return prolongation;
    }

    public void setProlongation(Prolongation prolongation) {
        this.prolongation = prolongation;
    }
}
