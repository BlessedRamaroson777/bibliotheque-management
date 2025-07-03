<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen reservation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <h2>Mes réservations</h2>
    <table border="1">
        <tr>
            <th>Livre</th>
            <th>Date reservation</th>
            <th>Etat</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Reservation> reservations = (java.util.List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
            if (reservations != null) {
                for (com.bibliotheque.model.Reservation r : reservations) {
                    String etat = "En cours de traitement";
                    if (r.getDateTraitement() != null && r.getEmprunt() != null) {
                        etat = "Validée";
                    } else if (r.getDateTraitement() != null) {
                        etat = "Refusée";
                    }
        %>
        <tr>
            <td><%= r.getLivre().getTitre() %></td>
            <td><%= r.getDateReservation() %></td>
            <td><%= etat %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
