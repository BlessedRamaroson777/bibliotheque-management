package com.bibliotheque.repository;

import com.bibliotheque.model.QuotaReservationMembre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;

public interface QuotaReservationMembreRepository extends JpaRepository<QuotaReservationMembre, Long> {
    
    @Query("SELECT COUNT(q) FROM QuotaReservationMembre q WHERE q.membre.id = :idMembre AND q.dateQuota = :date")
    int countByMembreAndDate(@Param("idMembre") Long idMembre, @Param("date") LocalDate date);
}
