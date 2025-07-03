<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>title</title>
    <link rel="stylesheet" href="css/style.css"/>
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
        <a href="membre/inscrire">Inscription</a><br>
        <a href="form-preter-livre">Preter un livre</a><br>
        <a href="form-lecture-sur-place">Lire un livre sur place</a><br>
        <a href="lectures-sur-place">Liste des lectures sur place</a><br>
        <a href="form-historique-pret">Voir l historique des prets</a><br>
        <a href="notifier-retour-livre-biblio">Notification retour livre (biblio)</a><br>
        <a href="form-rendre-livre">Rendre un livre</a><br>
        <a href="notifier-examination-prolongement?idAdherent=1">Notification examen prolongement</a><br>
        <a href="notifier-examination-reservation?idAdherent=1">Notification examen reservation</a><br>
    <% } %>
    <% if ("adherent".equals(role)) { %>
        <a href="form-prolonger-livre">Gestion prolongation</a><br>
        <a href="form-reserver-livre">Gestion reservation</a><br>
        <a href="notifier-retour-livre">Notifier retour livre</a><br>
        <a href="notifier-examination-prolongement?idAdherent=1">Notification examen prolongement</a><br>
        <a href="notifier-examination-reservation?idAdherent=1">Notification examen reservation</a><br>
    <% } %>
    <!-- Accessible à tous -->
    <a href="rechercher-livres">liste_livre</a><br>
    <a href="form-recherche-livre">rechercher</a><br>
    <a href="form-disponibilite">verifier disponibilite</a><br>
</body>
</html>