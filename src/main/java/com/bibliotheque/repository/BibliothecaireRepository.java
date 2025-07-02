package com.bibliotheque.repository;

import com.bibliotheque.model.Bibliothecaire;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BibliothecaireRepository extends JpaRepository<Bibliothecaire, Long> {
}