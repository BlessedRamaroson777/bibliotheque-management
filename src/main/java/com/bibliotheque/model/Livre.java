package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "livre")
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titre;
    @Column(name = "date_edition")
    private LocalDate dateEdition;
    private Integer ageMinimum;

    @ManyToOne
    @JoinColumn(name = "id_auteur")
    private Auteur auteur;

    @ManyToOne
    @JoinColumn(name = "id_genre_livre")
    private GenreLivre genreLivre;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    public LocalDate getDateEdition() { return dateEdition; }
    public void setDateEdition(LocalDate dateEdition) { this.dateEdition = dateEdition; }
    public Integer getAgeMinimum() { return ageMinimum; }
    public void setAgeMinimum(Integer ageMinimum) { this.ageMinimum = ageMinimum; }
    public Auteur getAuteur() { return auteur; }
    public void setAuteur(Auteur auteur) { this.auteur = auteur; }
    public GenreLivre getGenreLivre() { return genreLivre; }
    public void setGenreLivre(GenreLivre genreLivre) { this.genreLivre = genreLivre; }
}
