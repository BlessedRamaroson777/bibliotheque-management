package com.bibliotheque.repository;

import com.bibliotheque.model.QuotaMembre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuotaMembreRepository extends JpaRepository<QuotaMembre, Long> {
}
