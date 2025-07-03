package com.bibliotheque.repository;

import com.bibliotheque.model.Cotisation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CotisationRepository extends JpaRepository<Cotisation, Long> {
    List<Cotisation> findByMembreId(Long idMembre);
}
