<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification retour livre</title>
    
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
        h2 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
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
            background: #f9f9f9;
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
