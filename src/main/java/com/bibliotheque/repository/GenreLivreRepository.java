package com.bibliotheque.repository;

import com.bibliotheque.model.GenreLivre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GenreLivreRepository extends JpaRepository<GenreLivre, Long> {
}
