package com.bibliotheque.repository;

import com.bibliotheque.model.DemandeEmprunt;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DemandeEmpruntRepository extends JpaRepository<DemandeEmprunt, Long> {
    List<DemandeEmprunt> findByStatut(String statut);
    List<DemandeEmprunt> findByMembreId(Long idMembre);
    List<DemandeEmprunt> findByStatutAndMembreId(String statut, Long membreId);
}
