package com.bibliotheque.repository;

import com.bibliotheque.model.Abonnement;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface AbonnementRepository extends JpaRepository<Abonnement, Long> {

    @Query("SELECT a FROM Abonnement a WHERE a.membre.id = :idMembre AND :now BETWEEN a.debutAbonnement AND a.finAbonnement")
    Abonnement findAbonnementActuel(@Param("idMembre") Long idMembre, @Param("now") LocalDateTime now);

    List<Abonnement> findAllByOrderByFinAbonnementDesc();

    @Query("SELECT CASE WHEN COUNT(a) > 0 THEN true ELSE false END " +
        "FROM Abonnement a WHERE a.membre.id = :idMembre " +
        "AND a.debutAbonnement <= :dateActuelle " +
        "AND a.finAbonnement >= :dateActuelle")
    boolean estAbonnementValide(@Param("idMembre") Long idMembre, @Param("dateActuelle") LocalDateTime dateActuelle);

}
