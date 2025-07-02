package com.bibliotheque.repository;

import com.bibliotheque.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    @Query("SELECT r FROM Reservation r WHERE r.livre.id = :livreId ORDER BY r.dateReservation DESC")
    List<Reservation> findByLivreId(@Param("livreId") Long livreId);

    @Query("SELECT r FROM Reservation r WHERE r.emprunt IS NULL")
    List<Reservation> findNonReclamees();

    @Query("SELECT r FROM Reservation r WHERE r.emprunt IS NOT NULL")
    List<Reservation> findReclamees();
}