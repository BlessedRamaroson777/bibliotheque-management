USE BibliothequeNaina;

-- ================================
-- 🔸 Categorie
-- ================================
INSERT INTO Categorie (nom) VALUES 
('Informatique'),
('Histoire'),
('Psychologie');

-- ================================
-- 🔸 Public Cible
-- ================================
INSERT INTO Public_cible (nom) VALUES
('Tout public'),
('Professeur'),
('18+');

-- ================================
-- 🔸 Livres
-- ================================
INSERT INTO Livre (titre, auteur, id_categorie, id_public_cible) VALUES
('Introduction a la Programmation', 'Jean Rakoto', 1, 1),
('Bases de Donnees Avancees', 'Naina Andrianina', 1, 2),
('Histoire de Madagascar', 'Rasoanaivo', 2, 1),
('Psychologie pour Adultes', 'Elena Raharijaona', 3, 3);

-- ================================
-- 🔸 Exemplaires
-- ================================
INSERT INTO Exemplaire (id_livre, etat) VALUES
(1, 'Disponible'),
(1, 'Disponible'),
(2, 'Disponible'),
(2, 'Disponible'),
(3, 'Disponible'),
(4, 'Disponible');

-- ================================
-- 🔸 Adherents
-- ================================
INSERT INTO Adherent (nom, prenom, profil, date_inscription, date_expiration) VALUES
('Rakoto', 'Jean', 'Etudiant', '2025-01-10', '2026-01-10'),
('Rabe', 'Nina', 'Professeur', '2025-03-15', '2026-03-15'),
('Randria', 'Marc', 'Professionnel', '2025-02-20', '2026-02-20');

-- ================================
-- 🔸 Cotisations
-- ================================
INSERT INTO Cotisation (id_adherent, date_paiement, montant, duree_validite) VALUES
(1, '2025-01-10', 10000, 12),
(2, '2025-03-15', 15000, 12),
(3, '2025-02-20', 12000, 12);

-- ================================
-- 🔸 Prêts
-- ================================
INSERT INTO Pret (id_exemplaire, id_adherent, date_pret, date_retour_prevu, type_pret, etat) VALUES
(1, 1, '2025-06-01', '2025-06-15', 'Emporter', 'En cours'),
(3, 2, '2025-06-05', '2025-07-05', 'Emporter', 'En cours');

-- ================================
-- 🔸 Reservations
-- ================================
INSERT INTO Reservation (id_exemplaire, id_adherent, date_reservation, statut) VALUES
(2, 1, '2025-06-10', 'Active'),
(4, 3, '2025-06-12', 'Active');

-- ================================
-- 🔸 Prolongements
-- ================================
INSERT INTO Prolongement (id_pret, date_prolongement, nouvelle_date_retour) VALUES
(1, '2025-06-13', '2025-06-29');

-- ================================
-- 🔸 Penalites
-- ================================
INSERT INTO Penalite (id_pret, montant, raison, paye) VALUES
(1, 500, 'Retard de retour', FALSE);

-- ================================
-- 🔸 Jours Feries
-- ================================
INSERT INTO JourFerie (date_jour, description) VALUES
('2025-06-26', 'Fête de l Independance'),
('2025-12-25', 'Noël');
