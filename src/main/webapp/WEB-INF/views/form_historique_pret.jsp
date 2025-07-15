<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<%@ page import="com.bibliotheque.model.TypeAbonnement" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Ajouter un abonnement</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        .registration-container {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 600px;
        }
        h2 {
            color: #1a252f;
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        .form-group {
            margin-bottom: 1.2rem;
        }
        label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #1a252f;
        }
        select, input[type="date"], button {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.8rem center;
            background-size: 1rem;
        }
        select:focus, input:focus {
            outline: none;
            border-color: #1a252f;
            box-shadow: 0 0 0 2px rgba(26,37,47,0.2);
        }
        button {
            background-color: #1a252f;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 1rem;
            font-weight: 500;
        }
        button:hover {
            background-color: #121a22;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="registration-container">
    <h2>Ajouter un abonnement</h2>
    <form action="${pageContext.request.contextPath}/abonnements/ajouter" method="post">

        <div class="form-group">
            <label for="idMembre">Membre :</label>
            <select name="idMembre" id="idMembre" required>
                <%
                    List<Membre> membres = (List<Membre>) request.getAttribute("membres");
                    for (Membre membre : membres) {
                %>
                    <option value="<%= membre.getId() %>"><%= membre.getNom() %></option>
                <% } %>
            </select>
        </div>

        <div class="form-group">
            <label for="idType">Type abonnement :</label>
            <select name="idType" id="idType" required>
                <%
                    List<TypeAbonnement> types = (List<TypeAbonnement>) request.getAttribute("types");
                    for (TypeAbonnement type : types) {
                %>
                    <option value="<%= type.getId() %>"><%= type.getNom() %></option>
                <% } %>
            </select>
        </div>

        <div class="form-group">
            <label for="debut">Date début :</label>
            <input type="date" id="debut" name="debut" required />
        </div>

        <div class="form-group">
            <label for="fin">Date fin :</label>
            <input type="date" id="fin" name="fin" required />
        </div>

        <button type="submit">Ajouter</button>
    </form>
</div>
</body>
</html>
