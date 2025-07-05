<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen reservation</title>
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
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h2 {
            color: #1a252f; /* bleu nuit */
            border-bottom: 2px solid #7ec8e3; /* bleu ciel doux */
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
            background-color: #7ec8e3; /* bleu ciel doux */
            color: #1a252f;
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
        <h2>Liste Reservations</h2>
        <table>
            <tr>
                <th>Adherent</th>
                <th>Livre</th>
                <th>Date reservation</th>
                <th>Actions</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Reservation> reservations =
                    (java.util.List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
                if (reservations != null) {
                    for (com.bibliotheque.model.Reservation r : reservations) {
            %>
            <tr>
                <td><%= r.getMembre().getNomUtilisateur() %></td>
                <td><%= r.getLivre().getTitre() %></td>
                <td><%= r.getDateReservation() %></td>
                <td>
                    <% if ("en_cours".equals(r.getEtat())) { %>
                        <form action="examiner-reservation" method="post" style="display:inline;">
                            <input type="hidden" name="idAdherent" value="<%= r.getMembre().getId() %>"/>
                            <input type="hidden" name="idReservation" value="<%= r.getId() %>"/>
                            <button type="submit" name="accorder" value="true">Valider</button>
                            <button type="submit" name="accorder" value="false">Refuser</button>
                        </form>
                    <% } else { %>
                        <%= r.getEtat() %>
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
