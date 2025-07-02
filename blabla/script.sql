CREATE DATABASE BibliothequeNaina;
USE BibliothequeNaina;

-- ================================
-- 📚 Table Categorie
-- ================================
CREATE TABLE Categorie (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

-- ================================
-- 📚 Table Public_cible
-- ================================
CREATE TABLE Public_cible (
    id_public_cible INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

-- ================================
-- 📚 Table Livre
-- ================================
CREATE TABLE Livre (
    id_livre INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    auteur VARCHAR(255) NOT NULL,
    id_categorie INT,
    id_public_cible INT,
    FOREIGN KEY (id_categorie) REFERENCES Categorie(id_categorie),
    FOREIGN KEY (id_public_cible) REFERENCES Public_cible(id_public_cible)
);

-- ================================
-- 📚 Table Historique_Livre
-- ================================
CREATE TABLE Historique_Livre (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_livre INT,
    etat BOOLEAN,
    date DATE
);

-- ================================
-- 📑 Table Exemplaire
-- ================================
CREATE TABLE Exemplaire (
    id_exemplaire INT AUTO_INCREMENT PRIMARY KEY,
    id_livre INT NOT NULL,
    etat VARCHAR(50) DEFAULT 'Disponible',
    FOREIGN KEY (id_livre) REFERENCES Livre(id_livre)
);

-- ================================
-- 👤 Table Adherent
-- ================================
CREATE TABLE Adherent (
    id_adherent INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    profil ENUM('Etudiant', 'Professionnel', 'Professeur'),
    date_inscription DATE NOT NULL,
    date_expiration DATE NOT NULL
);

-- ================================
-- 💳 Table Cotisation
-- ================================
CREATE TABLE Cotisation (
    id_cotisation INT AUTO_INCREMENT PRIMARY KEY,
    id_adherent INT NOT NULL,
    date_paiement DATE NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    duree_validite INT NOT NULL, -- en mois
    FOREIGN KEY (id_adherent) REFERENCES Adherent(id_adherent)
);

-- ================================
-- 📅 Table Pret
-- ================================
CREATE TABLE Pret (
    id_pret INT AUTO_INCREMENT PRIMARY KEY,
    id_exemplaire INT NOT NULL,
    id_adherent INT NOT NULL,
    date_pret DATE NOT NULL,
    date_retour_prevu DATE NOT NULL,
    date_retour_effectif DATE,
    type_pret ENUM('Emporter', 'Lecture sur place'),
    etat VARCHAR(50) DEFAULT 'En cours',
    FOREIGN KEY (id_exemplaire) REFERENCES Exemplaire(id_exemplaire),
    FOREIGN KEY (id_adherent) REFERENCES Adherent(id_adherent)
);

-- ================================
-- 🔖 Table Penalite
-- ================================
CREATE TABLE Penalite (
    id_penalite INT AUTO_INCREMENT PRIMARY KEY,
    id_pret INT NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    raison VARCHAR(255),
    paye BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_pret) REFERENCES Pret(id_pret)
);

-- ================================
-- 📌 Table Reservation
-- ================================
CREATE TABLE Reservation (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    id_exemplaire INT NOT NULL,
    id_adherent INT NOT NULL,
    date_reservation DATE NOT NULL,
    statut ENUM('Active', 'Annulée', 'Expirée', 'Validée') DEFAULT 'Active',
    FOREIGN KEY (id_exemplaire) REFERENCES Exemplaire(id_exemplaire),
    FOREIGN KEY (id_adherent) REFERENCES Adherent(id_adherent)
);

-- ================================
-- 🔄 Table Prolongement
-- ================================
CREATE TABLE Prolongement (
    id_prolongement INT AUTO_INCREMENT PRIMARY KEY,
    id_pret INT NOT NULL,
    date_prolongement DATE NOT NULL,
    nouvelle_date_retour DATE NOT NULL,
    FOREIGN KEY (id_pret) REFERENCES Pret(id_pret)
);

-- ================================
-- 🗓️ Table JourFerie
-- ================================
CREATE TABLE JourFerie (
    id_jour INT AUTO_INCREMENT PRIMARY KEY,
    date_jour DATE UNIQUE NOT NULL,
    description VARCHAR(255)
);
