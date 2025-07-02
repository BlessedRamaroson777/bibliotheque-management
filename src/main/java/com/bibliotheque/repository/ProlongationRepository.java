package com.bibliotheque.repository;

import com.bibliotheque.model.Prolongation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProlongationRepository extends JpaRepository<Prolongation, Long> {
}