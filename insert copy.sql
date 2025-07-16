\c "BibliothequeNaina";

-- Insertion des auteurs avec noms et noms d'artistes fictifs
INSERT INTO auteur (nom, nom_artiste) VALUES
  ('Victor Hugo', 'V. Hugo'),
  ('Albert Camus', 'A. Camus'),
  ('J.K. Rowling', 'Joanne Rowling'),
  ('Gabriel Garcia Marquez', 'G. G. Marquez'),
  ('George Orwell', 'Eric Arthur Blair');

-- 2. Insertion des genres
INSERT INTO genre_livre (nom)
VALUES
  ('Litterature classique'),
  ('Philosophie'),
  ('Jeunesse / Fantastique');

-- 3. Recuperation des ids auteurs et genres pour l'insertion des livres
-- (Si tu es dans psql, tu peux utiliser des variables; sinon il faut faire en deux etapes)

-- Exemple avec des sous-requêtes pour recuperer les ids :
INSERT INTO livre (titre, id_auteur, id_genre_livre, date_edition, age_minimum)
VALUES
  (
    'Les Miserables',
    (SELECT id FROM auteur WHERE nom = 'Victor Hugo'),
    (SELECT id FROM genre_livre WHERE nom = 'Litterature classique'),
    '1864-11-25',
    0
  ),
  (
    'L etranger',
    (SELECT id FROM auteur WHERE nom = 'Albert Camus'),
    (SELECT id FROM genre_livre WHERE nom = 'Philosophie'),
    '1864-11-25',
    0
  ),
  (
    'Harry Potter à l''ecole des sorciers',
    (SELECT id FROM auteur WHERE nom = 'J.K. Rowling'),
    (SELECT id FROM genre_livre WHERE nom = 'Jeunesse / Fantastique'),
    '1864-11-25',
    0
  );

-- 4. Insertion des exemplaires avec id_livre recupere via sous-requête

-- Les Miserables a 3 exemplaires :
INSERT INTO exemplaire (id_livre, numero_exemplaire)
VALUES
  ((SELECT id FROM livre WHERE titre = 'Les Miserables'), 1),
  ((SELECT id FROM livre WHERE titre = 'Les Miserables'), 2),
  ((SELECT id FROM livre WHERE titre = 'Les Miserables'), 3);

-- L'etranger a 2 exemplaires :
INSERT INTO exemplaire (id_livre, numero_exemplaire)
VALUES
  ((SELECT id FROM livre WHERE titre = 'L etranger'), 1),
  ((SELECT id FROM livre WHERE titre = 'L etranger'), 2);

-- Harry Potter a 1 exemplaire :
INSERT INTO exemplaire (id_livre, numero_exemplaire)
VALUES
  ((SELECT id FROM livre WHERE titre = 'Harry Potter à l''ecole des sorciers'), 1);


INSERT INTO type_membre (nom, quota, quota_prolongation, quota_reservation) VALUES 
('Etudiant', 2, 3, 1),
('Enseignant', 3, 5, 2),
('Professionnel', 4, 7, 3);
INSERT INTO bibliothecaire (nom_utilisateur, mot_de_passe) VALUES
('admin1', 'admin123'),

-- 2. Insertion des membres (adhérents)
INSERT INTO membre (email, id_type_membre, nom_utilisateur, mot_de_passe, date_inscription, naissance)
VALUES
  ('amine.bensaid@example.com', (SELECT id FROM type_membre WHERE nom = 'Etudiant'), 'ETU001', '123', '2024-01-15', '1998-05-20'),
  ('sarah.elkhattabi@example.com', (SELECT id FROM type_membre WHERE nom = 'Etudiant'), 'ETU002', '123', '2024-01-20', '1999-07-12'),
  ('youssef.moujahid@example.com', (SELECT id FROM type_membre WHERE nom = 'Etudiant'), 'ETU003', '123', '2024-02-01', '1997-11-30'),

  ('nadia.benali@example.com', (SELECT id FROM type_membre WHERE nom = 'Enseignant'), 'ENS001', '123', '2023-09-10', '1985-03-15'),
  ('karim.haddadi@example.com', (SELECT id FROM type_membre WHERE nom = 'Enseignant'), 'ENS002', '123', '2023-09-20', '1982-08-24'),
  ('salima.touhami@example.com', (SELECT id FROM type_membre WHERE nom = 'Enseignant'), 'ENS003', '123', '2023-10-01', '1988-12-10'),

  ('rachid.elmansouri@example.com', (SELECT id FROM type_membre WHERE nom = 'Professionnel'), 'PROF001', '123', '2023-05-15', '1975-06-05'),
  ('amina.zerouali@example.com', (SELECT id FROM type_membre WHERE nom = 'Professionnel'), 'PROF002', '123', '2023-07-22', '1980-04-17');


INSERT INTO type_abonnement (nom, cout, duree)
VALUES ('Standard', 0, 12);

-- Insertion des abonnements valides uniquement
INSERT INTO abonnement (id_membre, id_type_abonnement, id_bibliothecaire, date_abonnement, debut_abonnement, fin_abonnement)
VALUES
  (
    (SELECT id FROM membre WHERE nom_utilisateur = 'ETU001'),
    (SELECT id FROM type_abonnement WHERE nom = 'Standard'),
    1,
    '2025-02-01',
    '2025-02-01',
    '2025-07-24'
  ),
  (
    (SELECT id FROM membre WHERE nom_utilisateur = 'ETU003'),
    (SELECT id FROM type_abonnement WHERE nom = 'Standard'),
    1,
    '2025-04-01',
    '2025-04-01',
    '2025-12-01'
  ),
  (
    (SELECT id FROM membre WHERE nom_utilisateur = 'ENS001'),
    (SELECT id FROM type_abonnement WHERE nom = 'Standard'),
    1,
    '2025-07-01',
    '2025-07-01',
    '2026-07-01'
  ),
  (
    (SELECT id FROM membre WHERE nom_utilisateur = 'ENS003'),
    (SELECT id FROM type_abonnement WHERE nom = 'Standard'),
    1,
    '2025-07-01',
    '2025-07-01',
    '2026-06-01'
  ),
  (
    (SELECT id FROM membre WHERE nom_utilisateur = 'PROF001'),
    (SELECT id FROM type_abonnement WHERE nom = 'Standard'),
    1,
    '2025-06-01',
    '2025-06-01',
    '2025-12-01'
  );
INSERT INTO abonnement
    (id_membre, id_type_abonnement, id_bibliothecaire, date_abonnement, debut_abonnement, fin_abonnement)
VALUES
  (
    (SELECT id FROM membre WHERE nom_utilisateur = 'ETU002'),
    (SELECT id FROM type_abonnement WHERE nom = 'Standard'),
    1,
    '2025-02-01',
    '2025-02-01',
    '2025-07-01'
  ),
  (
    (SELECT id FROM membre WHERE nom_utilisateur = 'ENS002'),
    (SELECT id FROM type_abonnement WHERE nom = 'Standard'),
    1,
    '2025-08-01',
    '2025-08-01',
    '2026-05-01'
  ),
  (
    (SELECT id FROM membre WHERE nom_utilisateur = 'PROF002'),
    (SELECT id FROM type_abonnement WHERE nom = 'Standard'),
    1,
    '2024-10-01',
    '2024-10-01',
    '2025-06-01'
  );


INSERT INTO duree_emprunt (duree, id_type_membre) VALUES (7, 1);
INSERT INTO duree_emprunt (duree, id_type_membre) VALUES (9, 2);
INSERT INTO duree_emprunt (duree, id_type_membre) VALUES (12, 3);


INSERT INTO jour_ferie (nom, date_jour) VALUES
('Nouvel An', '2025-07-26'),
('Independance', '2025-07-19');

INSERT INTO duree_penalite (id_type_membre, nombre_jour)
VALUES
  ((SELECT id FROM type_membre WHERE nom = 'Etudiant'), 10),
  ((SELECT id FROM type_membre WHERE nom = 'Enseignant'), 9),
  ((SELECT id FROM type_membre WHERE nom = 'Professionnel'), 8);













-- Durees
INSERT INTO duree_emprunt (duree) VALUES (15);
INSERT INTO duree_prolongation (duree) VALUES (7);
INSERT INTO duree_notification (duree) VALUES (3);

-- Jour ferie


-- Statut (dejà insere normalement)
INSERT INTO statut (valeur) VALUES
('actif'),
('inactif');

-- Bibliothecaire
INSERT INTO bibliothecaire (nom_utilisateur, mot_de_passe) VALUES
('admin1', 'admin123'),
('admin2', 'admin456');

-- Type abonnement
INSERT INTO type_abonnement (nom, cout, duree) VALUES
('Mensuel', 10000, 30),
('Trimestriel', 25000, 90),
('Annuel', 80000, 365);

-- Genre livre
INSERT INTO genre_livre (nom) VALUES
('Roman'),
('Science-Fiction'),
('Fantastique');

-- Theme livre
INSERT INTO theme_livre (nom) VALUES
('Amitie'),
('Aventure'),
('Amour'),
('Horreur');

-- Auteur
INSERT INTO auteur (nom, nom_artiste) VALUES
('Jules Verne', NULL),
('J.K. Rowling', 'Jo'),
('Stephen King', NULL);

-- Livre
INSERT INTO livre (titre, id_auteur, id_genre_livre, date_edition, age_minimum) VALUES
('Voyage au centre de la Terre', 1, 2, '1864-11-25', 10),
('Harry Potter', 2, 3, '1997-06-26', 8),
('Shining', 3, 1, '1977-01-28', 16);

-- Details livre (thèmes)
INSERT INTO details_livre (id_livre, id_theme_livre) VALUES
(1, 2), -- Aventure
(2, 1), -- Amitie
(2, 3), -- Amour
(3, 4); -- Horreur

-- Exemplaire
INSERT INTO exemplaire (id_livre, numero_exemplaire) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1);

-- Autorisation
INSERT INTO autorisation (id_type_membre, id_livre) VALUES
(1, 1),
(1, 2),
(2, 3);

-- Membre
INSERT INTO membre (email, id_type_membre, nom_utilisateur, mot_de_passe, date_inscription, naissance) VALUES
('alice@mail.com', 1, 'Alice', 'passalice', '2025-06-01', '2000-05-20'),
('bob@mail.com', 2, 'Bob', 'passbob', '2025-06-02', '1995-09-15');

-- Statut membre
INSERT INTO statut_membre (id_membre, id_statut, date_statut) VALUES
(1, 2, '2025-06-01'),
(2, 2, '2025-06-02');

-- Abonnement
INSERT INTO abonnement (id_membre, id_type_abonnement, id_bibliothecaire, date_abonnement, debut_abonnement, fin_abonnement) VALUES
(1, 1, 1, '2025-06-01', '2025-06-01', '2025-07-01'),
(2, 2, 2, '2025-06-02', '2025-06-02', '2025-09-02');

-- Emprunt
INSERT INTO emprunt (id_membre, id_exemplaire, id_biblio_emprunt, date_emprunt, date_debut, date_echeance, id_biblio_retour, date_retour) VALUES
(1, 1, 1, '2025-06-05', '2025-06-05', '2025-06-20', NULL, NULL),
(2, 2, 2, '2025-06-10', '2025-06-10', '2025-06-25', NULL, NULL);

-- Reservation
INSERT INTO reservation (id_membre, id_livre, date_reservation, date_debut, id_bibliothecaire, date_traitement, id_emprunt) VALUES
(1, 3, '2025-06-12', '2025-06-13', 1, '2025-06-13', NULL);

-- Prolongation
INSERT INTO prolongation (id_emprunt, date_prolongation, ancienne_echeance, nouvelle_echeance, id_bibliothecaire, date_traitement, accordee) VALUES
(1, '2025-06-18', '2025-06-20', '2025-06-27', 1, '2025-06-18', TRUE);

-- Penalite
INSERT INTO penalite (id_emprunt, id_membre, date_echeance, date_retour) VALUES
(2, 2, '2025-06-25', '2025-06-28');

-- Quotas emprunt
INSERT INTO quotas_emprunt_membre (id_membre, quota_emprunt, date_quota, id_emprunt) VALUES
(1, 5, '2025-06-05', 1),
(2, 7, '2025-06-10', 2);

-- Quotas reservation
INSERT INTO quotas_reservation_membre (id_membre, quota_reservation, date_quota, id_reservation) VALUES
(1, 5, '2025-06-12', 1);

-- Quotas prolongation
INSERT INTO quotas_prolongation_membre (id_membre, quota_prolongation, date_quota, id_prolongation) VALUES
(1, 2, '2025-06-18', 1);

-- Ajoute un membre actif sans penalite, quota non atteint
WITH m1 AS (
  INSERT INTO membre (email, id_type_membre, nom_utilisateur, mot_de_passe, date_inscription, naissance)
  VALUES ('testuser@mail.com', 1, 'TestUser', 'passtest', '2025-06-15', '2002-01-01')
  RETURNING id
)
INSERT INTO statut_membre (id_membre, id_statut, date_statut)
SELECT id, 2, '2025-06-15' FROM m1; -- actif

-- Ajoute un livre et un exemplaire disponible
WITH l1 AS (
  INSERT INTO livre (titre, id_auteur, id_genre_livre, date_edition, age_minimum)
  VALUES ('Test Livre', 1, 1, '2025-01-01', 10)
  RETURNING id
)
INSERT INTO exemplaire (id_livre, numero_exemplaire)
SELECT id, 1 FROM l1;

-- Autorisation pour ce membre/livre
INSERT INTO autorisation (id_type_membre, id_livre)
VALUES (1, (SELECT id FROM livre WHERE titre='Test Livre'));

-- Reservation à examiner (date_debut à venir, exemplaire dispo)
INSERT INTO reservation (id_membre, id_livre, date_reservation, date_debut, id_bibliothecaire, date_traitement, id_emprunt)
VALUES (
  (SELECT id FROM membre WHERE email='testuser@mail.com'),
  (SELECT id FROM livre WHERE titre='Test Livre'),
  '2025-06-16 10:00:00', '2025-06-20 10:00:00', 1, NULL, NULL
);

-- Reservation à examiner (date_debut à venir, exemplaire NON dispo)
-- On emprunte l'exemplaire à la même date pour bloquer la dispo
INSERT INTO emprunt (id_membre, id_exemplaire, id_biblio_emprunt, date_emprunt, date_debut, date_echeance, id_biblio_retour, date_retour, sur_place)
VALUES (
  (SELECT id FROM membre WHERE email='testuser@mail.com'),
  (SELECT id FROM exemplaire WHERE id_livre=(SELECT id FROM livre WHERE titre='Test Livre')),
  1, '2025-06-19 09:00:00', '2025-06-19 09:00:00', '2025-06-25 09:00:00', NULL, NULL, FALSE
);
INSERT INTO reservation (id_membre, id_livre, date_reservation, date_debut, id_bibliothecaire, date_traitement, id_emprunt)
VALUES (
  (SELECT id FROM membre WHERE email='testuser@mail.com'),
  (SELECT id FROM livre WHERE titre='Test Livre'),
  '2025-06-18 10:00:00', '2025-06-22 10:00:00', 1, NULL, NULL
);

-- Reservation pour un membre penalise
WITH m2 AS (
  INSERT INTO membre (email, id_type_membre, nom_utilisateur, mot_de_passe, date_inscription, naissance)
  VALUES ('penalise@mail.com', 1, 'Penalise', 'passpen', '2025-06-17', '2001-02-02')
  RETURNING id
)
INSERT INTO statut_membre (id_membre, id_statut, date_statut)
SELECT id, 2, '2025-06-17' FROM m2; -- actif

-- Ajoute une penalite pour ce membre
INSERT INTO penalite (id_emprunt, id_membre, date_echeance, date_retour)
VALUES (
  1, -- adapte l'id_emprunt selon ce qui existe
  (SELECT id FROM membre WHERE email='penalise@mail.com'),
  '2025-06-25', NULL
);
INSERT INTO reservation (id_membre, id_livre, date_reservation, date_debut, id_bibliothecaire, date_traitement, id_emprunt)
VALUES (
  (SELECT id FROM membre WHERE email='penalise@mail.com'),
  (SELECT id FROM livre WHERE titre='Test Livre'),
  '2025-06-19 10:00:00', '2025-06-23 10:00:00', 1, NULL, NULL
);

-- Reservation pour un membre inactif
WITH m3 AS (
  INSERT INTO membre (email, id_type_membre, nom_utilisateur, mot_de_passe, date_inscription, naissance)
  VALUES ('inactif@mail.com', 1, 'Inactif', 'passinactif', '2025-06-18', '2000-03-03')
  RETURNING id
)
INSERT INTO statut_membre (id_membre, id_statut, date_statut)
SELECT id, 2, '2025-06-18' FROM m3; -- suspendu
INSERT INTO reservation (id_membre, id_livre, date_reservation, date_debut, id_bibliothecaire, date_traitement, id_emprunt)
VALUES (
  (SELECT id FROM membre WHERE email='inactif@mail.com'),
  (SELECT id FROM livre WHERE titre='Test Livre'),
  '2025-06-20 10:00:00', '2025-06-24 10:00:00', 1, NULL, NULL
);

-- Reservation pour un membre sans autorisation sur le livre
WITH m4 AS (
  INSERT INTO membre (email, id_type_membre, nom_utilisateur, mot_de_passe, date_inscription, naissance)
  VALUES ('noauth@mail.com', 2, 'NoAuth', 'passnoauth', '2025-06-19', '1999-04-04')
  RETURNING id
)
INSERT INTO statut_membre (id_membre, id_statut, date_statut)
SELECT id, 2, '2025-06-19' FROM m4; -- actif
-- PAS d'autorisation pour type_membre 2 sur livre 4
INSERT INTO reservation (id_membre, id_livre, date_reservation, date_debut, id_bibliothecaire, date_traitement, id_emprunt)
VALUES (
  (SELECT id FROM membre WHERE email='noauth@mail.com'),
  (SELECT id FROM livre WHERE titre='Test Livre'),
  '2025-06-21 10:00:00', '2025-06-25 10:00:00', 1, NULL, NULL
);

