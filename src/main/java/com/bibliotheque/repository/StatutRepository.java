package com.bibliotheque.repository;

import com.bibliotheque.model.Statut;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StatutRepository extends JpaRepository<Statut, Long> {
    Optional<Statut> findByValeur(String valeur);
}
