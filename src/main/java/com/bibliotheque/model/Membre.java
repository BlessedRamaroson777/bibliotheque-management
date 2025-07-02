package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "membre")
public class Membre {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name="nom_utilisateur", nullable = false)
    private String nomUtilisateur;

    @Column(name="mot_de_passe", nullable = false)
    private String motDePasse;

    @Column(name="date_inscription", nullable = false)
    private LocalDate dateInscription;

    @ManyToOne
    @JoinColumn(name="id_type_membre")
    private TypeMembre typeMembre;

    @Column(name="naissance", nullable = false)
    private LocalDate naissance;

    // ...getters/setters...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getNomUtilisateur() { return nomUtilisateur; }
    public void setNomUtilisateur(String nomUtilisateur) { this.nomUtilisateur = nomUtilisateur; }
    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }
    public LocalDate getDateInscription() { return dateInscription; }
    public void setDateInscription(LocalDate dateInscription) { this.dateInscription = dateInscription; }
    public TypeMembre getTypeMembre() { return typeMembre; }
    public void setTypeMembre(TypeMembre typeMembre) { this.typeMembre = typeMembre; }
    public LocalDate getNaissance() { return naissance; }
    public void setNaissance(LocalDate naissance) { this.naissance = naissance; }
}
