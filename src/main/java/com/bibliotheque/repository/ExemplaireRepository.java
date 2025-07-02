package com.bibliotheque.repository;

import com.bibliotheque.model.Exemplaire;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface ExemplaireRepository extends JpaRepository<Exemplaire, Long> {
    @Query("SELECT e FROM Exemplaire e WHERE e.livre.id = :livreId AND e.id NOT IN (" +
           "SELECT em.exemplaire.id FROM Emprunt em WHERE (em.dateRetour IS NULL OR em.dateRetour > :dateDispo)" +
           ")")
    List<Exemplaire> findDisponibles(@Param("livreId") Long livreId, @Param("dateDispo") LocalDate dateDispo);

    @Query("SELECT MIN(em.dateEcheance) FROM Emprunt em WHERE em.exemplaire.livre.id = :livreId AND (em.dateRetour IS NULL OR em.dateRetour > :dateDispo)")
    LocalDate findProchaineDateDisponible(@Param("livreId") Long livreId, @Param("dateDispo") LocalDate dateDispo);
}