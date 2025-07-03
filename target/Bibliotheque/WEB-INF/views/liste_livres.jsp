<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultats recherche livres</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Resultats de la recherche</h2>
    <table border="1">
        <tr>
            <th>Titre</th>
            <th>Date edition</th>
            <th>Auteur</th>
            <th>Nom artiste</th>
            <th>Genre</th>
        </tr>
        <% java.util.List<com.bibliotheque.model.Livre> Livres = (java.util.List<com.bibliotheque.model.Livre>) request.getAttribute("livres");
        for (com.bibliotheque.model.Livre c : Livres) { %>
            <tr>
                <td><%= c.getTitre() %></td>
                <td><%= c.getDateEdition() %></td>
                <td><%= (c.getAuteur() != null && c.getAuteur().getNom() != null) ? c.getAuteur().getNom() : "" %></td>
                <td><%= (c.getAuteur() != null && c.getAuteur().getNomArtiste() != null) ? c.getAuteur().getNomArtiste() : "" %></td>
                <td><%= (c.getGenreLivre() != null && c.getGenreLivre().getNom() != null) ? c.getGenreLivre().getNom() : "" %></td>
            </tr>
        <% } %>
    </table>
</body>
</html>
