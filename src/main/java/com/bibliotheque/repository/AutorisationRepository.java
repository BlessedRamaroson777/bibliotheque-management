package com.bibliotheque.repository;

import com.bibliotheque.model.Autorisation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AutorisationRepository extends JpaRepository<Autorisation, Long> {
}