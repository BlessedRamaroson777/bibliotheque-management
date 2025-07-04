<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.DemandeEmprunt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mes demandes validées</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 2rem;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        form {
            display: inline;
        }

        input[type="submit"] {
            background-color: #2ecc71;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #27ae60;
        }

        a {
            display: block;
            margin-top: 1rem;
            color: #3498db;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Mes demandes validées</h2>

    <%
        List<DemandeEmprunt> demandesValidees = (List<DemandeEmprunt>) request.getAttribute("demandesValidees");
        Long idAdherent = (Long) request.getAttribute("idAdherent");
        if (demandesValidees != null && !demandesValidees.isEmpty()) {
    %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Livre</th>
            <th>Date Demande</th>
            <th>Date prévue</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (DemandeEmprunt d : demandesValidees) {
        %>
        <tr>
            <td><%= d.getId() %></td>
            <td><%= d.getLivre().getTitre() %></td>
            <td><%= d.getDateDemande() %></td>
            <td><%= d.getDatePrevu() %></td>
            <td>
                <form action="${pageContext.request.contextPath}/emprunter" method="post">
                    <input type="hidden" name="idDemande" value="<%= d.getId() %>" />
                    <input type="hidden" name="idAdherent" value="<%= idAdherent %>" />
                    <input type="submit" value="Emprunter" />
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <% } else { %>
        <p>Aucune demande validée pour le moment.</p>
    <% } %>

    <a href="${pageContext.request.contextPath}/">← Retour à l'accueil</a>
</div>
</body>
</html>
