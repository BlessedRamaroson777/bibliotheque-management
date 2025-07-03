<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body>
    <% String role = (session.getAttribute("role") != null) ? session.getAttribute("role").toString() : ""; %>
    <% if (!role.isEmpty()) { %>
        <a href="logout">Deconnexion</a><br>
    <% } else { %>
        <a href="login-adherent">Connexion Adherent</a><br>
        <a href="login-bibliothecaire">Connexion Bibliothecaire</a><br>
    <% } %>
    <% if ("bibliothecaire".equals(role)) { %>
        <a href="membre/inscrire">Inscrire une personne</a><br>
        <a href="form-lecture-sur-place">Lire un livre sur place</a><br>
        <a href="lectures-sur-place">Lectures sur place en cours</a><br>
        <a href="form-preter-livre">Preter un livre</a><br>
        <a href="form-historique-pret">Voir l'historique des prets</a><br>
        <a href="notifier-retour-livre-biblio">Notification retour livre (biblio)</a><br>
        <a href="form-rendre-livre">Rendre un livre</a><br>
        <a href="notifier-examination-prolongement?idAdherent=1">Examiner prolongement</a><br>
        <a href="notifier-examination-reservation?idAdherent=1">Examiner reservation</a><br>
        <a href="cotisations">Historique des cotisations</a><br>
    <% } %>
    <% if ("adherent".equals(role)) { %>
        <a href="form-prolonger-livre">Prolonger un livre</a><br>
        <a href="form-reserver-livre">Reserver un livre</a><br>
        <a href="notifier-retour-livre">Notifier retour livre</a><br>
        <a href="notifier-examination-prolongement?idAdherent=1">Notification examen prolongement</a><br>
        <a href="notifier-examination-reservation?idAdherent=1">Notification examen reservation</a><br>
        <a href="cotiser">Cotiser</a><br>
        <a href="cotisations">Mes cotisations</a><br>
    <% } %>
    <!-- Accessible à tous (bibliothecaire et adherent) -->
    <a href="rechercher-livres">Rechercher livre</a><br>
    <a href="form-recherche-livre">Recherche avancee</a><br>
    <a href="form-disponibilite">Verifier disponibilite d'un exemplaire</a><br>
</body>
</html>