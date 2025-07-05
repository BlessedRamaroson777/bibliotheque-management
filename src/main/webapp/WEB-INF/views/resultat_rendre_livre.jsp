<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Resultat rendre livre</title>
    <link rel="stylesheet" href="css/style.css"/>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 2rem;
            color: #333;
        }

        h2 {
            color: #1a252f;
            border-bottom: 2px solid #1a252f;
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
        }

        h3 {
            color: #1a252f;
            margin-top: 2rem;
            margin-bottom: 0.5rem;
        }

        p {
            font-size: 1.1rem;
            margin-bottom: 1rem;
        }

        ul {
            list-style-type: disc;
            padding-left: 1.5rem;
            color: #1a252f;
            font-weight: 500;
        }

        a {
            display: inline-block;
            margin-top: 2rem;
            padding: 0.6rem 1.2rem;
            background-color: #1a252f;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #122028;
        }
    </style>
</head>
<body>
    <h2>Resultat</h2>

    <p>${resultat}</p>

    <c:if test="${penalite != null}">
        <h3>Penalite appliquee</h3>
        <ul>
            <li>Duree du retard : ${penalite.duree} jour(s)</li>
        </ul>
    </c:if>

    <a href="form-rendre-livre">Rendre un autre livre</a>
</body>
</html>
