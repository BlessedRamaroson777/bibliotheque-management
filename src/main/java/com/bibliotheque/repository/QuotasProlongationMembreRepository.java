package com.bibliotheque.repository;

import com.bibliotheque.model.QuotasProlongationMembre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuotasProlongationMembreRepository extends JpaRepository<QuotasProlongationMembre, Long> {
    long countByIdMembre(Long idMembre);
}
