package com.bibliotheque.repository;

import com.bibliotheque.model.DureeEmprunt;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DureeEmpruntRepository extends JpaRepository<DureeEmprunt, Long> {
}
