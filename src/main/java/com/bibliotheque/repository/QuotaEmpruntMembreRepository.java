package com.bibliotheque.repository;

import com.bibliotheque.model.QuotaEmpruntMembre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface QuotaEmpruntMembreRepository extends JpaRepository<QuotaEmpruntMembre, Long> {
    @Query("SELECT q.quotaEmprunt FROM QuotaEmpruntMembre q WHERE q.membre.id = :idAdherent ORDER BY q.dateQuota DESC")
    Integer findDernierQuota(@Param("idAdherent") Long idAdherent);
}
