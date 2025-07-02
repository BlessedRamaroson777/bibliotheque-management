package com.bibliotheque.repository;

import com.bibliotheque.model.Emprunt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EmpruntRepository extends JpaRepository<Emprunt, Long> {
    @Query("SELECT e FROM Emprunt e WHERE e.exemplaire.livre.id = :livreId ORDER BY e.dateEmprunt DESC")
    List<Emprunt> findByLivreId(@Param("livreId") Long livreId);
}