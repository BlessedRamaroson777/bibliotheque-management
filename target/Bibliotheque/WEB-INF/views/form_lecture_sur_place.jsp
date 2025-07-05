<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lecture sur place</title>
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
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        h2 {
            color: #1a252f;
            text-align: center;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #1a252f;
            padding-bottom: 0.5rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        label {
            font-weight: bold;
            margin-bottom: 0.3rem;
            color: #1a252f;
        }

        select, input[type="datetime-local"], input[type="submit"] {
            padding: 0.6rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
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
    </style>

</head>
<body>
    <div class="container">
        <h2>Lecture sur place</h2>
        <%
            Long idBibliothecaire = (Long) session.getAttribute("idBibliothecaire");
            List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
            List<Livre> livres = (List<Livre>) request.getAttribute("livres");
        %>
        <form action="lire-sur-place" method="post">
            <label for="idAdherent">Adhérent :</label>
            <select name="idAdherent" id="idAdherent" required>
                <option value="">-- Choisir un adhérent --</option>
                <%
                    for (Membre m : adherents) {
                %>
                    <option value="<%= m.getId() %>"><%= m.getNomUtilisateur() %> (<%= m.getEmail() %>)</option>
                <%
                    }
                %>
            </select>

            <label for="idLivre">Livre :</label>
            <select name="idLivre" id="idLivre" required>
                <option value="">-- Choisir un livre --</option>
                <%
                    for (Livre l : livres) {
                %>
                    <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
                <%
                    }
                %>
            </select>

            <label for="dateLecture">Date de lecture :</label>
            <input type="datetime-local" name="dateLecture" id="dateLecture" required />

            <input type="hidden" name="idBibliothecaire" value="<%= idBibliothecaire %>"/>
            <input type="submit" value="Lire sur place" />
        </form>
    </div>
</body>
</html>
