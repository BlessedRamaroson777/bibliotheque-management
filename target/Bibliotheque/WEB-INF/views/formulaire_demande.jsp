<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouvelle demande d'emprunt</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 2rem;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-top: 1rem;
            font-weight: 500;
        }

        input[type="number"],
        input[type="datetime-local"],
        select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-top: 4px;
        }

        input[type="submit"] {
            margin-top: 2rem;
            padding: 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        p {
            margin-top: 1rem;
            font-weight: bold;
            color: #27ae60;
        }

        a {
            display: block;
            margin-top: 1rem;
            color: #3498db;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Faire une nouvelle demande d'emprunt</h2>

    <form action="${pageContext.request.contextPath}/demandes/nouvelle" method="post">
        <%
            Long idAdherent = (Long) session.getAttribute("idMembre");
        %>
        <input type="number" id="idMembre" name="idMembre" value="<%= idAdherent %>" hidden />

        <label for="idLivre">Livre :</label>
        <select name="idLivre" id="idLivre" required>
            <%
                List<Livre> livres = (List<Livre>) request.getAttribute("livres");
                for (Livre l : livres) {
            %>
                <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
            <%
                }
            %>
        </select>

        <label for="dateDemande">Date de la demande :</label>
        <input type="datetime-local" name="dateDemande" id="dateDemande" required />

        <label for="datePrevu">Date prévue de l'emprunt :</label>
        <input type="datetime-local" name="datePrevu" id="datePrevu" />

        <input type="submit" value="Envoyer la demande" />
    </form>

    <p>${resultat}</p>
    <a href="${pageContext.request.contextPath}/">&larr; Retour à l'accueil</a>
</div>
</body>
</html>
