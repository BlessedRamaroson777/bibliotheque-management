package com.bibliotheque.repository;

import com.bibliotheque.model.QuotaEmpruntMembre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuotaEmpruntMembreRepository extends JpaRepository<QuotaEmpruntMembre, Long> {
}
