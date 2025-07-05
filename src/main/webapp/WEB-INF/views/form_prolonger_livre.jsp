<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<%@ page import="com.bibliotheque.model.Emprunt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prolonger un livre</title>
    <link rel="stylesheet" href="css/style.css"/>
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
        h2, h3 {
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
            background: #f9f9f9;
        }
        input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        input[type="datetime-local"] {
            padding: 0.3rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        form {
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Demander une prolongation</h2>
        <%
            Long idAdherent = (Long) session.getAttribute("idMembre");
        %>
        <form method="get" action="form-prolonger-livre">
            <input type="hidden" name="idAdherent" value="<%= idAdherent %>"/>
            <input type="submit" value="Afficher mes emprunts"/>
        </form>
        <% 
            List<Emprunt> emprunts = (List<Emprunt>) request.getAttribute("emprunts");
            if (emprunts != null && !emprunts.isEmpty()) {
        %>
            <h3>Livres empruntes non rendus</h3>
            <table>
                <tr>
                    <th>Livre</th>
                    <th>Exemplaire</th>
                    <th>Date debut</th>
                    <th>Date echeance</th>
                    <th>Demander prolongation</th>
                </tr>
                <%
                    for (Emprunt e : emprunts) {
                %>
                <tr>
                    <td><%= e.getExemplaire().getLivre().getTitre() %></td>
                    <td><%= e.getExemplaire().getNumeroExemplaire() %></td>
                    <td><%= e.getDateDebut() %></td>
                    <td><%= e.getDateEcheance() %></td>
                    <td>
                        <form action="prolonger-livre" method="post">
                            <input type="hidden" name="idAdherent" value="<%= e.getMembre().getId() %>"/>
                            <input type="hidden" name="idLivre" value="<%= e.getExemplaire().getLivre().getId() %>"/>
                            Nouvelle date d'echeance :
                            <input type="datetime-local" name="dateProlongement" required/>
                            <input type="submit" value="Demander"/>
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
        <h3>Mes Prolongations en cours de traitement</h3>
        <table>
            <tr>
                <th>Adherent</th>
                <th>Livre</th>
                <th>Date demande</th>
                <th>Ancienne echeance</th>
                <th>Nouvelle echeance demandee</th>
                <th>Action</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Prolongation> prolongations = 
                    (java.util.List<com.bibliotheque.model.Prolongation>) request.getAttribute("prolongations");
                if (prolongations != null) {
                    for (com.bibliotheque.model.Prolongation p : prolongations) {
            %>
            <tr>
                <td><%= p.getEmprunt().getMembre().getNomUtilisateur() %></td>
                <td><%= p.getEmprunt().getExemplaire().getLivre().getTitre() %></td>
                <td><%= p.getDateProlongation() %></td>
                <td><%= p.getAncienneEcheance() %></td>
                <td><%= p.getNouvelleEcheance() %></td>
                <td>
                    <% if (p.getAccordee() == null) { %>
                        En attente
                    <% } else if (p.getAccordee()) { %>
                        Accordee
                    <% } else { %>
                        Refusee
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
