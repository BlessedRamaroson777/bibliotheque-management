<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Réserver un livre</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 2rem;
            color: #333;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h2, h3 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }
        form {
            margin-bottom: 2rem;
        }
        select, input[type="datetime-local"], input[type="submit"] {
            margin: 0.5rem 0 1rem 0;
            padding: 0.6rem 1rem;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            max-width: 300px;
        }
        input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #217dbb;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background: white;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 0.8rem;
            text-align: left;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .message {
            color: #0077cc;
            font-weight: bold;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        String resultat = (String) request.getAttribute("resultat");
        Long idAdherent = (Long) session.getAttribute("idMembre");
        if (resultat != null && !resultat.isEmpty()) {
    %>
        <div class="message"><%= resultat %></div>
    <% } %>

    <h2>Réserver un livre</h2>
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
        Date de réservation :
        <input type="datetime-local" name="dateReservation" value="<%= java.time.LocalDateTime.now().toString().substring(0,16) %>"/>
        <br/>
        Date de début (Retrait prévu) :
        <input type="datetime-local" name="dateDebut" required/>
        <br/>
        <input type="submit" value="Réserver"/>
    </form>

    <h3>Mes réservations</h3>
    <table>
        <tr>
            <th>Livre</th>
            <th>Date réservation</th>
            <th>Date début</th>
            <th>État</th>
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
</div>
</body>
</html>
