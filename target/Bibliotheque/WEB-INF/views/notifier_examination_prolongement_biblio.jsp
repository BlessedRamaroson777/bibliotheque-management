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
            color: #1a252f;
            border-bottom: 2px solid #1a252f;
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
            background-color: #1a252f;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        input[type="submit"] {
            background-color: #1a252f;
            color: white;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #121a22;
        }
        button {
            padding: 0.4rem 0.8rem;
            margin-right: 0.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        button[name="accorder"][value="true"] {
            background-color: #27ae60; /* vert agréable */
        }
        button[name="accorder"][value="false"] {
            background-color: #c0392b; /* rouge foncé */
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
                        <form method="post" action="examiner-prolongation">
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
