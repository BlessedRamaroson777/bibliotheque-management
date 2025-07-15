package com.bibliotheque.repository;

import com.bibliotheque.model.Emprunt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EmpruntRepository extends JpaRepository<Emprunt, Long> {
    @Query("SELECT e FROM Emprunt e WHERE e.exemplaire.livre.id = :livreId ORDER BY e.dateEmprunt DESC")
    List<Emprunt> findByLivreId(@Param("livreId") Long livreId);

    @Query("SELECT e FROM Emprunt e WHERE e.surPlace = true AND e.dateRetour IS NULL")
    List<Emprunt> findLecturesSurPlaceEnCours();

    @Query("SELECT e FROM Emprunt e WHERE e.surPlace = true AND e.dateRetour IS NOT NULL")
    List<Emprunt> findLecturesSurPlaceTerminees();

    @Query("SELECT e FROM Emprunt e WHERE e.membre.id = :membreId AND e.surPlace = true")
    List<Emprunt> findLecturesSurPlaceByMembreId(@Param("membreId") Long membreId);

    @Query("SELECT e FROM Emprunt e WHERE e.membre.id = :membreId")
    List<Emprunt> findByMembreId(@Param("membreId") Long membreId);

    @Query("SELECT e FROM Emprunt e WHERE e.membre.id = :membreId AND (e.surPlace = false OR e.surPlace IS NULL)")
    List<Emprunt> findPretsByMembreId(@Param("membreId") Long membreId);
    
    @Query("SELECT e FROM Emprunt e WHERE e.exemplaire.id = :exemplaireId")
    List<Emprunt> findByExemplaireId(@Param("exemplaireId") Long exemplaireId);
}