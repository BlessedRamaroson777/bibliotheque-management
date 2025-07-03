package com.bibliotheque.repository;

import com.bibliotheque.model.ReservationAnnulee;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ReservationAnnuleeRepository extends JpaRepository<ReservationAnnulee, Long> {
    List<ReservationAnnulee> findByReservationId(Long reservationId);
    List<ReservationAnnulee> findByReservationIdIn(java.util.List<Long> ids);
}
