<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen prolongement</title>
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
    </style>
</head>
<body>
    <h2>Resultat examen prolongement</h2>
    <form method="get" action="notifier-examination-prolongement">
        <%
            Long idAdherent = (Long) session.getAttribute("idMembre");
        %>
        <input type="hidden" name="idAdherent" value="<%= idAdherent %>"/>
        <input type="submit" value="Voir mes prolongations"/>
    </form>
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
