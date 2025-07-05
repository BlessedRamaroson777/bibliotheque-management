<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen prolongement</title>
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

        button {
            padding: 0.4rem 0.8rem;
            margin-right: 0.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
        }

        button[name="accorder"][value="true"] {
            background-color: #2ecc71;
        }

        button[name="accorder"][value="false"] {
            background-color: #e74c3c;
        }

        button:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Liste prolongement</h2>
        <table>
            <tr>
                <th>Id exemplaire</th>
                <th>Date rendu avant</th>
                <th>Date rendu apres</th>
                <th>Accordee</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Prolongation> prolongations = 
                    (java.util.List<com.bibliotheque.model.Prolongation>) request.getAttribute("prolongations");
                if (prolongations != null) {
                    for (com.bibliotheque.model.Prolongation p : prolongations) {
            %>
            <tr>
                <td><%= p.getEmprunt().getExemplaire().getId() %></td>
                <td><%= p.getAncienneEcheance() %></td>
                <td><%= p.getNouvelleEcheance() %></td>
                <td>
                    <% if (p.getAccordee() == null) { %>
                        <form method="post" action="examiner-prolongation" style="display:flex; gap: 0.5rem;">
                            <input type="hidden" name="idProlongation" value="<%= p.getId() %>" />
                            <button type="submit" name="accorder" value="true">Accepter</button>
                            <button type="submit" name="accorder" value="false">Refuser</button>
                        </form>
                    <% } else { %>
                        <%= p.getAccordee() ? "Accordee" : "Non accordee" %>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
