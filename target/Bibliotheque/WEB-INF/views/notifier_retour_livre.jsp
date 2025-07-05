<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification retour livre</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 2rem;
            background-color: #f9f9f9;
            color: #333;
        }
        h2 {
            color: #2a5d9f;
            border-bottom: 2px solid #2a5d9f;
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
        }
        form {
            margin-bottom: 1.5rem;
        }
        input[type="submit"] {
            background-color: #2a5d9f;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
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
        td[colspan="3"] {
            text-align: center;
            font-style: italic;
            color: #666;
        }
    </style>
</head>
<body>

    <h2>Livres a rendre</h2>
    <%
        Long idAdherent = (Long) session.getAttribute("idMembre");
    %>
    <%-- <form method="post" action="notifier-retour-livre">
        <input type="hidden" name="idAdherent" value="<%= idAdherent %>"/>
        <label for="jour">Nombre de jours :</label>
        <input type="number" name="jour" id="jour" value="2" min="1"/>
        <input type="submit" value="Voir emprunts pour ce nombre de jours"/>
    </form> --%>
    <br/>
    <table border="1">
        <tr>
            <th>Id exemplaire</th>
            <th>Date de retour</th>
            <th>Duree restante (jours)</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Emprunt> emprunts = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("emprunts");
            if (emprunts != null && !emprunts.isEmpty()) {
                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                for (com.bibliotheque.model.Emprunt e : emprunts) {
                    long joursRestant = java.time.temporal.ChronoUnit.DAYS.between(now.toLocalDate(), e.getDateEcheance().toLocalDate());
        %>
        <tr>
            <td><%= e.getExemplaire().getId() %></td>
            <td><%= e.getDateEcheance() %></td>
            <td><%= joursRestant %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="3">Aucun emprunt trouve.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
