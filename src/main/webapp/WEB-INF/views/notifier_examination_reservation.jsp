<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen reservation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <h2>Mes Réservations</h2>
    <table border="1">
        <tr>
            <th>Adherent</th>
            <th>Livre</th>
            <th>Date reservation</th>
            <th>Actions</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Reservation> reservations = (java.util.List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
            if (reservations != null) {
                for (com.bibliotheque.model.Reservation r : reservations) {
        %>
        <tr>
            <td><%= r.getMembre().getNomUtilisateur() %></td>
            <td><%= r.getLivre().getTitre() %></td>
            <td><%= r.getDateReservation() %></td>
            <td>
                <% if ("en_cours".equals(r.getEtat())) { %>
                <form action="examiner-reservation" method="post" style="display:inline;">
                    <input type="hidden" name="idReservation" value="<%= r.getId() %>"/>
                    <input type="hidden" name="idAdherent" value="<%= r.getMembre().getId() %>"/>
                    <button type="submit" name="accorder" value="true">Valider</button>
                    <button type="submit" name="accorder" value="false">Refuser</button>
                </form>
                <% } else { %>
                    <%= r.getEtat() %>
                <% } %>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>