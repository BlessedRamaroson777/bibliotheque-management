<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<%@ page import="com.bibliotheque.model.Bibliothecaire" %>
<!DOCTYPE html>
<html>
<head>
    <title>Preter un livre</title>
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
            max-width: 900px;
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
            margin-bottom: 1.5rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        label {
            font-weight: bold;
        }

        select, input[type="submit"] {
            padding: 0.6rem;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #1a252f;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #121a22;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
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
        <h2>Preter un livre</h2>
        <form action="preter-livre" method="post">
            <label for="idAdherent">Adhérent :</label>
            <select name="idAdherent" id="idAdherent" required>
                <option value="">-- Choisir un adhérent --</option>
                <%
                    List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
                    for (Membre m : adherents) {
                %>
                <option value="<%= m.getId() %>"><%= m.getNomUtilisateur() %> (<%= m.getEmail() %>)</option>
                <% } %>
            </select>

            <label for="idLivre">Livre :</label>
            <select name="idLivre" id="idLivre" required>
                <option value="">-- Choisir un livre --</option>
                <%
                    List<Livre> livres = (List<Livre>) request.getAttribute("livres");
                    for (Livre l : livres) {
                %>
                <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
                <% } %>
            </select>

            <label for="dateEmprunt">Date d'emprunt :</label>
            <%
                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                String formattedNow = now.toString().substring(0, 16); // yyyy-MM-ddTHH:mm
            %>
            <input type="datetime-local" name="dateEmprunt" id="dateEmprunt" required value="<%= formattedNow %>"/>

            <%
                com.bibliotheque.model.Bibliothecaire biblio = (com.bibliotheque.model.Bibliothecaire) session.getAttribute("bibliothecaire");
                String nomBiblio = (biblio != null) ? biblio.getNomUtilisateur() : "";
                Long idBiblio = (biblio != null) ? biblio.getId() : null;
            %>

            <label for="nomBibliothecaire">Bibliothécaire :</label>
            <input type="text" id="nomBibliothecaire" value="<%= nomBiblio %>" readonly />

            <!-- Champ caché pour envoyer l'ID dans le formulaire -->
            <input type="hidden" name="idBibliothecaire" value="<%= idBiblio %>" />



            <input type="submit" value="Preter"/>
        </form>

        <h3>Prets en cours</h3>
        <table>
            <tr>
                <th>Adhérent</th>
                <th>Livre</th>
                <th>Exemplaire</th>
                <th>Date début</th>
                <th>Date échéance</th>
            </tr>
            <%
                java.util.List<com.bibliotheque.model.Emprunt> prets = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("prets");
                if (prets != null) {
                    for (com.bibliotheque.model.Emprunt e : prets) {
            %>
            <tr>
                <td><%= e.getMembre().getNomUtilisateur() %></td>
                <td><%= e.getExemplaire().getLivre().getTitre() %></td>
                <td><%= e.getExemplaire().getNumeroExemplaire() %></td>
                <td><%= e.getDateDebut() %></td>
                <td><%= e.getDateEcheance() %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
