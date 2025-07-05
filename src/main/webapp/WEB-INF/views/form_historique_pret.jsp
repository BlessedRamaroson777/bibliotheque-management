<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Historique des prets - Selection du livre</title>
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
            border-bottom: 2px solid #1a252f;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
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
    </style>

</head>
<body>
    <div class="container">
        <h2>Voir l'historique des prets d'un livre</h2>
        <form action="historique-pret" method="get">
            <label for="livreId">Livre :</label>
            <select name="livreId" id="livreId" required>
                <option value="">-- Choisir un livre --</option>
                <%
                    List<Livre> livres = (List<Livre>) request.getAttribute("livres");
                    for (Livre l : livres) {
                %>
                    <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
                <% } %>
            </select>
            <input type="submit" value="Voir l'historique"/>
        </form>
    </div>
</body>
</html>
