<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen reservation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 2rem;
            background-color: #f4f6f8;
            color: #222;
        }
        h2 {
            color: #1a4d8f;
            border-bottom: 2px solid #1a4d8f;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            box-shadow: 0 0 6px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ccc;
            padding: 0.5rem 1rem;
            text-align: left;
        }
        th {
            background-color: #1a4d8f;
            color: white;
        }
        form button {
            background-color: #1a4d8f;
            color: white;
            border: none;
            padding: 0.3rem 0.6rem;
            margin-right: 0.3rem;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.9rem;
        }
        form button:hover {
            background-color: #163c6e;
        }
        form {
            margin: 0;
        }
    </style>
</head>
<body>
    <h2>Mes Reservations</h2>
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
