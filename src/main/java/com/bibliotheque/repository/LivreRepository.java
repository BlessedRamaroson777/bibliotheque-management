package com.bibliotheque.repository;

import com.bibliotheque.model.Livre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface LivreRepository extends JpaRepository<Livre, Long> {

    @Query("SELECT l FROM Livre l WHERE (:titre IS NULL OR l.titre LIKE %:titre%) " +
        "AND (:dateEdition IS NULL OR l.dateEdition = :dateEdition) " +
        "AND (:nomAuteur IS NULL OR l.auteur.nom LIKE %:nomAuteur%) " +
        "AND (:typeAuteur IS NULL OR l.auteur.nomArtiste LIKE %:typeAuteur%) " +
        "AND (:typeLivre IS NULL OR l.genreLivre.nom LIKE %:typeLivre%)")
    List<Livre> rechercherLivres(@Param("titre") String titre,
                                @Param("dateEdition") LocalDate dateEdition,
                                @Param("nomAuteur") String nomAuteur,
                                @Param("typeAuteur") String typeAuteur,
                                @Param("typeLivre") String typeLivre);


    @Query("SELECT l FROM Livre l LEFT JOIN FETCH l.exemplaires WHERE l.id = :id")
    Livre findByIdWithExemplaires(@Param("id") Long id);
    
}    
