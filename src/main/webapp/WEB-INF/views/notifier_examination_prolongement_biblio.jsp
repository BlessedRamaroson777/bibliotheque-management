<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen prolongement</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    
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
            color: #1a252f; /* bleu nuit */
            border-bottom: 2px solid #7ec8e3; /* bleu ciel clair */
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
            background-color: #7ec8e3; /* bleu ciel clair */
            color: #1a252f; /* texte bleu nuit */
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }

        form {
            display: flex;
            gap: 0.5rem;
        }
        button {
            background-color: #7ec8e3; /* bleu ciel */
            color: #1a252f;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #5aa8c5; /* bleu ciel un peu plus foncé */
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
