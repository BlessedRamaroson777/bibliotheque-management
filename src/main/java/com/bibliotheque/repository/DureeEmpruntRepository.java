package com.bibliotheque.repository;

import com.bibliotheque.model.DureeEmprunt;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface DureeEmpruntRepository extends JpaRepository<DureeEmprunt, Long> {
    Optional<DureeEmprunt> findByTypeMembreId(Long idTypeMembre);
}
