<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lectures sur place</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
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
            margin-bottom: 1rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }

        th, td {
            padding: 0.8rem;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Lectures sur place en cours</h2>
        <table>
            <tr>
                <th>Adhérent</th>
                <th>Livre</th>
                <th>Exemplaire</th>
                <th>Date début</th>
                <th>Action</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Emprunt> enCours = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("enCours");
                for (com.bibliotheque.model.Emprunt e : enCours) {
            %>
            <tr>
                <td><%= e.getMembre().getNomUtilisateur() %></td>
                <td><%= e.getExemplaire().getLivre().getTitre() %></td>
                <td><%= e.getExemplaire().getNumeroExemplaire() %></td>
                <td><%= e.getDateDebut() %></td>
                <td>
                    <form action="finir-lecture-sur-place" method="post" style="margin: 0;">
                        <input type="hidden" name="empruntId" value="<%= e.getId() %>"/>
                        <input type="submit" value="Finir"/>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>

        <h2>Lectures sur place terminées</h2>
        <table>
            <tr>
                <th>Adhérent</th>
                <th>Livre</th>
                <th>Exemplaire</th>
                <th>Date début</th>
                <th>Date retour</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Emprunt> terminees = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("terminees");
                for (com.bibliotheque.model.Emprunt e : terminees) {
            %>
            <tr>
                <td><%= e.getMembre().getNomUtilisateur() %></td>
                <td><%= e.getExemplaire().getLivre().getTitre() %></td>
                <td><%= e.getExemplaire().getNumeroExemplaire() %></td>
                <td><%= e.getDateDebut() %></td>
                <td><%= e.getDateRetour() %></td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
