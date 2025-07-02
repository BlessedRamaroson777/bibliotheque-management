<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reserver un livre</title>
</head>
<body>
    <h2>Reserver un livre</h2>
    <form action="reserver-livre" method="post">
        Adherent :
        <select name="idAdherent" required>
            <option value="">-- Choisir un adherent --</option>
            <%
                List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
                for (Membre m : adherents) {
            %>
                <option value="<%= m.getId() %>"><%= m.getNomUtilisateur() %></option>
            <%
                }
            %>
        </select>
        <br/>
        Livre :
        <select name="idLivre" required>
            <option value="">-- Choisir un livre --</option>
            <%
                List<Livre> livres = (List<Livre>) request.getAttribute("livres");
                for (Livre l : livres) {
            %>
                <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
            <%
                }
            %>
        </select>
        <br/>
        Date reservation :
        <input type="datetime-local" name="dateReservation" required/>
        <br/>
        <input type="submit" value="Reserver"/>
    </form>
    <h3>Reservations non recuperees</h3>
    <table border="1">
        <tr>
            <th>Adherent</th>
            <th>Livre</th>
            <th>Date reservation</th>
        </tr>
        <%
            List<com.bibliotheque.model.Reservation> reservations = (List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
            if (reservations != null) {
                for (com.bibliotheque.model.Reservation r : reservations) {
        %>
        <tr>
            <td><%= r.getMembre().getNomUtilisateur() %></td>
            <td><%= r.getLivre().getTitre() %></td>
            <td><%= r.getDateReservation() %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>