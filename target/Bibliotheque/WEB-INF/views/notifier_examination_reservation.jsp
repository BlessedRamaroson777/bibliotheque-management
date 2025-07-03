<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen reservation</title>
</head>
<body>
    <h2>Resultat examen reservation</h2>
    <table border="1">
        <tr>
            <th>Id reservation</th>
            <th>Livre</th>
            <th>Date reservation</th>
            <th>Date debut</th>
            <th>Id exemplaire</th>
            <th>Date pret</th>
            <th>Date rendu</th>
            <th>Statut</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Reservation> reservations = (java.util.List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
            for (com.bibliotheque.model.Reservation r : reservations) {
                com.bibliotheque.model.Emprunt e = r.getEmprunt();
                if (r.getBibliothecaire() != null) {
                    boolean acceptee = (e != null);
        %>
        <tr<%= !acceptee ? " style=\"background-color:#f8d7da;\"" : "" %>>
            <td><%= r.getId() %></td>
            <td><%= r.getLivre() != null ? r.getLivre().getTitre() : "-" %></td>
            <td><%= r.getDateReservation() %></td>
            <td><%= r.getDateDebut() %></td>
            <td><%= acceptee && e.getExemplaire() != null ? e.getExemplaire().getId() : "-" %></td>
            <td><%= acceptee ? e.getDateEmprunt() : "-" %></td>
            <td><%= acceptee ? e.getDateRetour() : "-" %></td>
            <td><%= acceptee ? "Acceptee" : "Refusee" %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
