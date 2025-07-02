package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "membre")
public class Membre {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name="nom_utilisateur", nullable = false)
    private String nom_utilisateur;

    @Column(name="mot_de_passe", nullable = false)
    private String mot_de_passe;

    @Column(name="date_inscription", nullable = false)
    private LocalDateTime date_inscription;

    @ManyToOne
    @JoinColumn(name="id_type_membre")
    private TypeMembre typeMembre;

    @Column(name="naissance", nullable = false)
    private LocalDateTime naissance;

    // ...getters/setters...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getNomUtilisateur() { return nom_utilisateur; }
    public void setNomUtilisateur(String nom_utilisateur) { this.nom_utilisateur = nom_utilisateur; }
    public String getMotDePasse() { return mot_de_passe; }
    public void setMotDePasse(String mot_de_passe) { this.mot_de_passe = mot_de_passe; }
    public LocalDateTime getDateInscription() { return date_inscription; }
    public void setDateInscription(LocalDateTime date_inscription) { this.date_inscription = date_inscription; }
    public TypeMembre getTypeMembre() { return typeMembre; }
    public void setTypeMembre(TypeMembre typeMembre) { this.typeMembre = typeMembre; }
    public LocalDateTime getNaissance() { return naissance; }
    public void setNaissance(LocalDateTime naissance) { this.naissance = naissance; }
}
