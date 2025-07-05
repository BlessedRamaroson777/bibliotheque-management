<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification retour livre (bibliothecaire)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 2rem;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
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
            margin-bottom: 2rem;
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Livres a rendre (tous adherents)</h2>
        <table>
            <tr>
                <th>Id exemplaire</th>
                <th>Date de retour</th>
                <th>Duree restante (jours)</th>
                <th>Date pret</th>
                <th>Id adherent</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Emprunt> emprunts = 
                    (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("emprunts");
                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                for (com.bibliotheque.model.Emprunt e : emprunts) {
                    long joursRestant = java.time.temporal.ChronoUnit.DAYS.between(
                        now.toLocalDate(), e.getDateEcheance().toLocalDate());
            %>
            <tr>
                <td><%= e.getExemplaire().getId() %></td>
                <td><%= e.getDateEcheance() %></td>
                <td><%= joursRestant %></td>
                <td><%= e.getDateEmprunt() %></td>
                <td><%= e.getMembre().getId() %></td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
