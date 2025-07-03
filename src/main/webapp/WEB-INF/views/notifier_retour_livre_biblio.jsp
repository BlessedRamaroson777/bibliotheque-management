<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification retour livre (bibliothecaire)</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Livres a rendre dans 2 jours (tous adherents)</h2>
    <table border="1">
        <tr>
            <th>Id exemplaire</th>
            <th>Date rendu</th>
            <th>Duree restante (jours)</th>
            <th>Date pret</th>
            <th>Id adherent</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Emprunt> emprunts = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("emprunts");
            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            for (com.bibliotheque.model.Emprunt e : emprunts) {
                long joursRestant = java.time.temporal.ChronoUnit.DAYS.between(now.toLocalDate(), e.getDateEcheance().toLocalDate());
        %>
        <tr>
            <td><%= e.getExemplaire().getId() %></td>
            <td><%= e.getDateEcheance() %></td>
            <td><%= joursRestant %></td>
            <td><%= e.getDateEmprunt() %></td>
            <td><%= e.getMembre().getId() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
