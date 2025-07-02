-- DROP DATABASE IF EXISTS "BibliothequeNaina";
CREATE DATABASE "BibliothequeNaina";
\c "BibliothequeNaina";

-- Durees
CREATE TABLE duree_emprunt (
    id SERIAL PRIMARY KEY,
    duree INTEGER NOT NULL
);

CREATE TABLE duree_prolongation (
    id SERIAL PRIMARY KEY,
    duree INTEGER NOT NULL
);

CREATE TABLE duree_notification (
    id SERIAL PRIMARY KEY,
    duree INTEGER NOT NULL
);

-- Jour ferie
CREATE TABLE jour_ferie (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    date_jour DATE NOT NULL
);

-- Type membre
CREATE TABLE type_membre (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    quota INTEGER NOT NULL
);

-- Statut
CREATE TABLE statut (
    id SERIAL PRIMARY KEY,
    valeur TEXT NOT NULL
);

-- membre
CREATE TABLE membre (
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL,
    id_type_membre INTEGER NOT NULL,
    nom_utilisateur TEXT NOT NULL,
    mot_de_passe TEXT NOT NULL,
    date_inscription DATE NOT NULL,
    naissance DATE NOT NULL,
    FOREIGN KEY (id_type_membre) REFERENCES type_membre(id)
);

-- Statut membre
CREATE TABLE statut_membre (
    id SERIAL PRIMARY KEY,
    id_membre INTEGER NOT NULL,
    id_statut INTEGER NOT NULL,
    date_statut DATE NOT NULL,
    FOREIGN KEY (id_membre) REFERENCES membre(id),
    FOREIGN KEY (id_statut) REFERENCES statut(id)
);

-- Bibliothecaire
CREATE TABLE bibliothecaire (
    id SERIAL PRIMARY KEY,
    nom_utilisateur TEXT NOT NULL,
    mot_de_passe TEXT NOT NULL
);

-- Type abonnement
CREATE TABLE type_abonnement (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    cout DECIMAL(10,2) NOT NULL,
    duree INTEGER NOT NULL
);

-- Abonnement
CREATE TABLE abonnement (
    id SERIAL PRIMARY KEY,
    id_membre INTEGER NOT NULL,
    id_type_abonnement INTEGER NOT NULL,
    id_bibliothecaire INTEGER NOT NULL,
    date_abonnement DATE NOT NULL,
    debut_abonnement DATE NOT NULL,
    fin_abonnement DATE NOT NULL,
    FOREIGN KEY (id_membre) REFERENCES membre(id),
    FOREIGN KEY (id_type_abonnement) REFERENCES type_abonnement(id),
    FOREIGN KEY (id_bibliothecaire) REFERENCES bibliothecaire(id)
);

-- Livre
CREATE TABLE genre_livre (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL
);

CREATE TABLE theme_livre (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL
);

CREATE TABLE auteur (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    nom_artiste TEXT
);
CREATE TABLE livre (
    id SERIAL PRIMARY KEY,
    titre TEXT NOT NULL,
    id_auteur INTEGER NOT NULL,
    id_genre_livre INTEGER NOT NULL,
    date_edition DATE NOT NULL,
    age_minimum INTEGER NOT NULL,
    FOREIGN KEY (id_auteur) REFERENCES auteur(id),
    FOREIGN KEY (id_genre_livre) REFERENCES genre_livre(id)
);

CREATE TABLE details_livre (
    id SERIAL PRIMARY KEY,
    id_livre INTEGER NOT NULL,
    id_theme_livre INTEGER NOT NULL,
    FOREIGN KEY (id_livre) REFERENCES livre(id),
    FOREIGN KEY (id_theme_livre) REFERENCES theme_livre(id)
);

CREATE TABLE exemplaire (
    id SERIAL PRIMARY KEY,
    id_livre INTEGER NOT NULL,
    numero_exemplaire INTEGER NOT NULL,
    FOREIGN KEY (id_livre) REFERENCES livre(id)
);

CREATE TABLE autorisation (
    id SERIAL PRIMARY KEY,
    id_type_membre INTEGER NOT NULL,
    id_livre INTEGER NOT NULL,
    FOREIGN KEY (id_type_membre) REFERENCES type_membre(id),
    FOREIGN KEY (id_livre) REFERENCES livre(id)
);

-- Emprunt
CREATE TABLE emprunt (
    id SERIAL PRIMARY KEY,
    id_membre INTEGER NOT NULL,
    id_exemplaire INTEGER NOT NULL,
    id_biblio_emprunt INTEGER NOT NULL,
    date_emprunt DATE NOT NULL,
    date_debut DATE NOT NULL,
    date_echeance DATE NOT NULL,
    id_biblio_retour INTEGER,
    date_retour DATE,
    FOREIGN KEY (id_membre) REFERENCES membre(id),
    FOREIGN KEY (id_exemplaire) REFERENCES exemplaire(id),
    FOREIGN KEY (id_biblio_emprunt) REFERENCES bibliothecaire(id),
    FOREIGN KEY (id_biblio_retour) REFERENCES bibliothecaire(id)
);

-- Reservation
CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    id_membre INTEGER NOT NULL,
    id_livre INTEGER NOT NULL,
    date_reservation DATE NOT NULL,
    date_debut DATE NOT NULL,
    id_bibliothecaire INTEGER,
    date_traitement DATE,
    id_emprunt INTEGER,
    FOREIGN KEY (id_membre) REFERENCES membre(id),
    FOREIGN KEY (id_livre) REFERENCES livre(id),
    FOREIGN KEY (id_bibliothecaire) REFERENCES bibliothecaire(id),
    FOREIGN KEY (id_emprunt) REFERENCES emprunt(id)
);

-- Prolongation
CREATE TABLE prolongation (
    id SERIAL PRIMARY KEY,
    id_emprunt INTEGER NOT NULL,
    date_prolongation DATE NOT NULL,
    ancienne_echeance DATE NOT NULL,
    nouvelle_echeance DATE NOT NULL,
    id_bibliothecaire INTEGER,
    date_traitement DATE,
    accordee BOOLEAN,
    FOREIGN KEY (id_emprunt) REFERENCES emprunt(id),
    FOREIGN KEY (id_bibliothecaire) REFERENCES bibliothecaire(id)
);

-- Penalite
CREATE TABLE penalite (
    id SERIAL PRIMARY KEY,
    id_emprunt INTEGER NOT NULL,
    id_membre INTEGER NOT NULL,
    date_echeance DATE NOT NULL,
    date_retour DATE,
    cout DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_emprunt) REFERENCES emprunt(id),
    FOREIGN KEY (id_membre) REFERENCES membre(id)
);

-- Quotas : remplacement de quota_membre
CREATE TABLE quotas_emprunt_membre (
    id SERIAL PRIMARY KEY,
    id_membre INTEGER NOT NULL,
    quota_emprunt INTEGER NOT NULL,
    date_quota DATE NOT NULL,
    id_emprunt INTEGER NOT NULL,
    FOREIGN KEY (id_emprunt) REFERENCES emprunt(id),
    FOREIGN KEY (id_membre) REFERENCES membre(id)
);

CREATE TABLE quotas_reservation_membre (
    id SERIAL PRIMARY KEY,
    id_membre INTEGER NOT NULL,
    quota_reservation INTEGER NOT NULL,
    date_quota DATE NOT NULL,
    id_reservation INTEGER NOT NULL,
    FOREIGN KEY (id_reservation) REFERENCES reservation(id),
    FOREIGN KEY (id_membre) REFERENCES membre(id)
);

CREATE TABLE quotas_prolongation_membre (
    id SERIAL PRIMARY KEY,
    id_membre INTEGER NOT NULL,
    quota_prolongation INTEGER NOT NULL,
    date_quota DATE NOT NULL,
    id_prolongation INTEGER NOT NULL,
    FOREIGN KEY (id_prolongation) REFERENCES prolongation(id),
    FOREIGN KEY (id_membre) REFERENCES membre(id)
);