package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "livre")
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titre;
    @Column(name = "date_edition")
    private LocalDateTime dateEdition;
    private Integer age_Minimum;

    @ManyToOne
    @JoinColumn(name = "id_auteur")
    private Auteur auteur;

    @ManyToOne
    @JoinColumn(name = "id_genre_livre")
    private GenreLivre genreLivre;

    @OneToMany(mappedBy = "livre", fetch = FetchType.EAGER)
    private java.util.List<Exemplaire> exemplaires;

    // Getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    public LocalDateTime getDateEdition() { return dateEdition; }
    public void setDateEdition(LocalDateTime dateEdition) { this.dateEdition = dateEdition; }
    public Integer getAgeMinimum() { return age_Minimum; }
    public void setAgeMinimum(Integer ageMinimum) { this.age_Minimum = ageMinimum; }
    public Auteur getAuteur() { return auteur; }
    public void setAuteur(Auteur auteur) { this.auteur = auteur; }
    public GenreLivre getGenreLivre() { return genreLivre; }
    public void setGenreLivre(GenreLivre genreLivre) { this.genreLivre = genreLivre; }
    public java.util.List<Exemplaire> getExemplaires() { return exemplaires; }
    public void setExemplaires(java.util.List<Exemplaire> exemplaires) { this.exemplaires = exemplaires; }
}
