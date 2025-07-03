<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reserver un livre</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <% 
        String resultat = (String) request.getAttribute("resultat");
        Long idAdherent = (Long) session.getAttribute("idMembre");
        if (resultat != null && !resultat.isEmpty()) {
    %>
        <div style="color:blue"><%= resultat %></div>
    <% } %>
    <h2>Reserver un livre</h2>
    <form action="reserver-livre" method="post">
        <input type="hidden" name="idAdherent" value="<%= idAdherent %>"/>
        Livre :
        <select name="idLivre" required>
            <option value="">-- Choisir un livre --</option>
            <%
                List<com.bibliotheque.model.Livre> livres = (List<com.bibliotheque.model.Livre>) request.getAttribute("livres");
                for (com.bibliotheque.model.Livre l : livres) {
            %>
                <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
            <%
                }
            %>
        </select>
        <br/>
        Date reservation :
        <input type="datetime-local" name="dateReservation" value="<%= java.time.LocalDateTime.now().toString().substring(0,16) %>"/>
        <br/>
        Date début (retrait prévu) :
        <input type="datetime-local" name="dateDebut" required/>
        <br/>
        <input type="submit" value="Reserver"/>
    </form>
    <h3>Mes réservations</h3>
    <table border="1">
        <tr>
            <th>Livre</th>
            <th>Date reservation</th>
            <th>Date début</th>
            <th>Etat</th>
        </tr>
        <%
            List<com.bibliotheque.model.Reservation> reservations = (List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
            if (reservations != null) {
                for (com.bibliotheque.model.Reservation r : reservations) {
                    if (r.getMembre().getId().equals(idAdherent)) {
        %>
        <tr>
            <td><%= r.getLivre().getTitre() %></td>
            <td><%= r.getDateReservation() %></td>
            <td><%= r.getDateDebut() %></td>
            <td><%= r.getEtat() %></td>
        </tr>
        <%
                    }
                }
            }
        %>
    </table>
</body>
</html>