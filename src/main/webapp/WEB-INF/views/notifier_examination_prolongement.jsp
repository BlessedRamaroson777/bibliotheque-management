<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen prolongement</title>
    
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
    <h2>Resultat examen prolongement</h2>
    <table border="1">
        <tr>
            <th>Livre</th>
            <th>Id exemplaire</th>
            <th>Date rendu avant</th>
            <th>Date rendu après</th>
            <th>Prolongation</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Prolongation> prolongations =
                (java.util.List<com.bibliotheque.model.Prolongation>) request.getAttribute("prolongations");
            if (prolongations != null) {
                for (com.bibliotheque.model.Prolongation p : prolongations) {
                    if (p.getEmprunt().getMembre().getId().equals(idAdherent)) {
        %>
        <tr>
            <td><%= p.getEmprunt().getExemplaire().getLivre().getTitre() %></td>
            <td><%= p.getEmprunt().getExemplaire().getId() %></td>
            <td><%= p.getAncienneEcheance() %></td>
            <td><%= p.getNouvelleEcheance() %></td>
            <td><%= (p.getAccordee() != null && p.getAccordee()) ? "accordee" : "non accordee" %></td>
        </tr>
        <%
                    }
                }
            }
        %>
    </table>

</body>
</html>
