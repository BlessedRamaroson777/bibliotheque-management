package com.bibliotheque.repository;

import com.bibliotheque.model.Penalite;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PenaliteRepository extends JpaRepository<Penalite, Long> {
}