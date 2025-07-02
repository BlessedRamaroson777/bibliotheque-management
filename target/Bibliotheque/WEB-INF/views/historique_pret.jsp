<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Historique des prêts</title>
</head>
<body>
    <h2>Historique des prêts</h2>
    <h3>Prêts (avant, en cours, prolonges)</h3>
    <table border="1">
        <tr>
            <th>Membre</th>
            <th>Date emprunt</th>
            <th>Date debut</th>
            <th>Date echeance</th>
            <th>Date retour</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Emprunt> emprunts = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("emprunts");
            for (com.bibliotheque.model.Emprunt e : emprunts) {
        %>
        <tr>
            <td><%= e.getMembre().getNomUtilisateur() %></td>
            <td><%= e.getDateEmprunt() %></td>
            <td><%= e.getDateDebut() %></td>
            <td><%= e.getDateEcheance() %></td>
            <td><%= e.getDateRetour() %></td>
        </tr>
        <% } %>
    </table>
    <h3>Reservations</h3>
    <table border="1">
        <tr>
            <th>Membre</th>
            <th>Date reservation</th>
            <th>Date debut</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Reservation> reservations = (java.util.List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
            for (com.bibliotheque.model.Reservation r : reservations) {
        %>
        <tr>
            <td><%= r.getMembre().getNomUtilisateur() %></td>
            <td><%= r.getDateReservation() %></td>
            <td><%= r.getDateDebut() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>