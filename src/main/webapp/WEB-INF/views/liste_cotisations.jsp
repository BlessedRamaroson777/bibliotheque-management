<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long idBibliothecaire = (Long) session.getAttribute("idBibliothecaire");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Historique des cotisations</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <style>
    <% if (idBibliothecaire == null) { %>
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
    <% } else { %>
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
            border-bottom: 2px solid #1a252f;
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
            background-color: #1a252f;
            color: white;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
    <% } %>
    </style>
</head>
<body>
    <div class="container">
        <h2>Historique des cotisations</h2>
        <table>
            <tr>
                <th>Adhérent</th>
                <th>Date début</th>
                <th>Date fin</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Cotisation> cotisations =
                    (java.util.List<com.bibliotheque.model.Cotisation>) request.getAttribute("cotisations");
                if (cotisations != null) {
                    for (com.bibliotheque.model.Cotisation c : cotisations) {
            %>
            <tr>
                <td><%= c.getMembre().getNomUtilisateur() %></td>
                <td><%= c.getDateDebut() %></td>
                <td><%= c.getDateFin() %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
