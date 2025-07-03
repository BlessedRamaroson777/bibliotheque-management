package com.bibliotheque.repository;

import com.bibliotheque.model.DureePenalite;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DureePenaliteRepository extends JpaRepository<DureePenalite, Long> {
    DureePenalite findByTypeMembreId(Long idTypeMembre);
}
