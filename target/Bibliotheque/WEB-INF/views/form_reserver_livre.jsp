<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reserver un livre</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 2rem;
            color: #333;
        }
        h2, h3 {
            color: #2a5d9f;
        }
        form {
            background-color: white;
            padding: 1rem 1.5rem;
            border-radius: 6px;
            box-shadow: 0 0 6px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        select, input[type="datetime-local"], input[type="submit"] {
            margin: 0.5rem 0 1rem 0;
            padding: 0.4rem 0.6rem;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            max-width: 300px;
        }
        input[type="submit"] {
            background-color: #2a5d9f;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #1f4474;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background-color: white;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ccc;
            padding: 0.6rem 1rem;
            text-align: left;
        }
        th {
            background-color: #2a5d9f;
            color: white;
        }
        div.message {
            color: blue;
            margin-bottom: 1rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <% 
        String resultat = (String) request.getAttribute("resultat");
        Long idAdherent = (Long) session.getAttribute("idMembre");
        if (resultat != null && !resultat.isEmpty()) {
    %>
        <div class="message"><%= resultat %></div>
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
        Date debut (retrait prevu) :
        <input type="datetime-local" name="dateDebut" required/>
        <br/>
        <input type="submit" value="Reserver"/>
    </form>
    <h3>Mes reservations</h3>
    <table>
        <tr>
            <th>Livre</th>
            <th>Date reservation</th>
            <th>Date debut</th>
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
