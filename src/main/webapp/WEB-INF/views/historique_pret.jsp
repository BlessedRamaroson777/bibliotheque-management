<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Historique des prets</title>
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
            border: 1px solid #ddd;
            padding: 0.8rem;
            text-align: left;
        }

        th {
            background-color: #1a252f;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>

</head>
<body>
    <div class="container">
        <h2>Historique des prets</h2>

        <h3>Prets (avant, en cours, prolonges)</h3>
        <table>
            <tr>
                <th>Membre</th>
                <th>Date emprunt</th>
                <th>Date debut</th>
                <th>Date echeance</th>
                <th>Date retour</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Emprunt> emprunts = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("emprunts");
                for (com.bibliotheque.model.Emprunt e : emprunts) {
            %>
            <tr>
                <td><%= e.getMembre().getNomUtilisateur() %></td>
                <td><%= e.getDateEmprunt() %></td>
                <td><%= e.getDateDebut() %></td>
                <td><%= e.getDateEcheance() %></td>
                <td><%= e.getDateRetour() %></td>
            </tr>
            <% } %>
        </table>

        <h3>Reservations</h3>
        <table>
            <tr>
                <th>Membre</th>
                <th>Date reservation</th>
                <th>Date debut</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Reservation> reservations = (java.util.List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
                for (com.bibliotheque.model.Reservation r : reservations) {
            %>
            <tr>
                <td><%= r.getMembre().getNomUtilisateur() %></td>
                <td><%= r.getDateReservation() %></td>
                <td><%= r.getDateDebut() %></td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
