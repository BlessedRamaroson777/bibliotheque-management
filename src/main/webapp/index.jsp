<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Accueil - Bibliothèque</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 2rem;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
        }

        .menu-section {
            margin-bottom: 2rem;
        }

        .section-title {
            color: #3498db;
            font-weight: 600;
            margin-bottom: 0.5rem;
            padding-bottom: 0.3rem;
            border-bottom: 1px solid #eee;
        }

        .menu-links {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1rem;
        }

        a {
            display: block;
            padding: 0.8rem 1rem;
            background-color: #f8f9fa;
            color: #2c3e50;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s ease;
            border-left: 4px solid #3498db;
        }

        a:hover {
            background-color: #3498db;
            color: white;
            transform: translateX(5px);
        }

        .auth-links {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .auth-links a {
            background-color: #2c3e50;
            color: white;
            border-left: 4px solid #3498db;
        }

        .auth-links a:hover {
            background-color: #3498db;
        }

        @media (max-width: 768px) {
            .menu-links {
                grid-template-columns: 1fr;
            }
            
            .auth-links {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bibliotheque - Accueil</h1>
        
        <% String role = (session.getAttribute("role") != null) ? session.getAttribute("role").toString() : ""; %>
        <div class="auth-links">
            <% if (!role.isEmpty()) { %>
                <a href="logout">Deconnexion</a>
            <% } else { %>
                <a href="login-adherent">Connexion Adherent</a>
                <a href="login-bibliothecaire">Connexion Bibliothecaire</a>
            <% } %>
        </div>

        <% if ("bibliothecaire".equals(role)) { %>
            <div class="menu-section">
                <h3 class="section-title">Espace Bibliothecaire</h3>
                <div class="menu-links">
                    <a href="membre/inscrire">Inscrire une personne</a>
                    <a href="form-lecture-sur-place">Lire un livre sur place</a>
                    <a href="lectures-sur-place">Lectures sur place en cours</a>
                    <a href="form-preter-livre">Prêter un livre</a>
                    <a href="form-historique-pret">Voir l'historique des prêts</a>
                    <a href="notifier-retour-livre-biblio">Notification retour livre (biblio)</a>
                    <a href="form-rendre-livre">Rendre un livre</a>
                    <a href="notifier-examination-prolongement-biblio">Examiner prolongement</a>
                    <a href="notifier-examination-reservation-biblio">Examiner reservation</a>
                    <a href="cotisations">Historique des cotisations</a>
                </div>
            </div>
        <% } %>

        <% if ("adherent".equals(role)) { 
            Long idAdherent = (Long) session.getAttribute("idMembre");
        %>
            <div class="menu-section">
                <h3 class="section-title">Espace Adherent</h3>
                <div class="menu-links">
                    <a href="form-prolonger-livre">Prolonger un livre</a>
                    <a href="form-reserver-livre">Reserver un livre</a>
                    <a href="notifier-retour-livre">Notifier retour livre</a>
                    <a href="notifier-examination-prolongement?idAdherent=<%= idAdherent %>">Notification examen prolongement</a>
                    <a href="notifier-examination-reservation?idAdherent=<%= idAdherent %>">Notification examen reservation</a>
                    <a href="cotiser">Cotiser</a>
                    <a href="cotisations">Mes cotisations</a>
                </div>
            </div>
        <% } %>

        <div class="menu-section">
            <h3 class="section-title">Services communs</h3>
            <div class="menu-links">
                <a href="rechercher-livres">Liste des livres</a>
                <a href="form-recherche-livre">Recherche avancee</a>
                <a href="form-disponibilite">Verifier disponibilite d'un exemplaire</a>
            </div>
        </div>
    </div>
</body>
</html>