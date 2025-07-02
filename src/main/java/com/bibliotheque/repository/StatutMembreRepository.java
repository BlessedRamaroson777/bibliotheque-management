package com.bibliotheque.repository;

import com.bibliotheque.model.StatutMembre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatutMembreRepository extends JpaRepository<StatutMembre, Long> {
}
