<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<%@ page import="com.bibliotheque.model.Emprunt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rendre un livre</title>
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

        h2, h3 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }

        select {
            padding: 0.6rem;
            font-size: 1rem;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
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

        input[type="submit"] {
            padding: 0.5rem 1rem;
            background-color: #3498db;
            color: white;
            border: none;
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
        <h2>Rendre un livre</h2>

        <form method="get" action="form-rendre-livre">
            Adherent :
            <select name="idAdherent" required onchange="this.form.submit()">
                <option value="">-- Choisir un adherent --</option>
                <%
                    List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
                    String selectedId = request.getParameter("idAdherent");
                    for (Membre m : adherents) {
                %>
                    <option value="<%= m.getId() %>" <%= (selectedId != null && selectedId.equals(m.getId().toString())) ? "selected" : "" %>>
                        <%= m.getNomUtilisateur() %>
                    </option>
                <%
                    }
                %>
            </select>
        </form>

        <%
            List<Emprunt> emprunts = (List<Emprunt>) request.getAttribute("emprunts");
            if (emprunts != null && !emprunts.isEmpty()) {
        %>
        <h3>Livres non rendus</h3>
        <table>
            <tr>
                <th>Id exemplaire</th>
                <th>Livre</th>
                <th>Date debut</th>
                <th>Date echeance</th>
                <th>Action</th>
            </tr>
            <%
                for (Emprunt e : emprunts) {
            %>
            <tr>
                <td><%= e.getExemplaire().getId() %></td>
                <td><%= e.getExemplaire().getLivre().getTitre() %></td>
                <td><%= e.getDateDebut() %></td>
                <td><%= e.getDateEcheance() %></td>
                <td>
                    <form action="rendre-livre" method="post" style="display:inline;">
                        <input type="hidden" name="idAdherent" value="<%= e.getMembre().getId() %>"/>
                        <input type="hidden" name="idExemplaire" value="<%= e.getExemplaire().getId() %>"/>
                        <input type="hidden" name="dateRendu" value="<%= java.time.LocalDateTime.now().toString().substring(0,16) %>"/>
                        <input type="submit" value="Rendre"/>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            }
        %>
    </div>
</body>
</html>
