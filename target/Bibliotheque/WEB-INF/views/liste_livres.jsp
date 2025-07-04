<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultats recherche livres</title>
    <link rel="stylesheet" href="css/style.css"/>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h2 {
            color: #3498db;
            text-align: center;
            margin-bottom: 20px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #3498db;
            color: white;
            font-weight: 500;
        }
        
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        tr:hover {
            background-color: #e8f4fc;
        }
        
        .empty-results {
            text-align: center;
            padding: 20px;
            color: #666;
            font-style: italic;
        }
        
        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s;
        }
        
        .back-button:hover {
            background-color: #3498db;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Resultats de la recherche</h2>
        
        <% java.util.List<com.bibliotheque.model.Livre> Livres = (java.util.List<com.bibliotheque.model.Livre>) request.getAttribute("livres");
        if (Livres == null || Livres.isEmpty()) { %>
            <div class="empty-results">Aucun resultat trouve</div>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Titre</th>
                        <th>Date edition</th>
                        <th>Auteur</th>
                        <th>Nom artiste</th>
                        <th>Genre</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (com.bibliotheque.model.Livre c : Livres) { %>
                        <tr>
                            <td><%= c.getTitre() %></td>
                            <td><%= c.getDateEdition() %></td>
                            <td><%= (c.getAuteur() != null && c.getAuteur().getNom() != null) ? c.getAuteur().getNom() : "-" %></td>
                            <td><%= (c.getAuteur() != null && c.getAuteur().getNomArtiste() != null) ? c.getAuteur().getNomArtiste() : "-" %></td>
                            <td><%= (c.getGenreLivre() != null && c.getGenreLivre().getNom() != null) ? c.getGenreLivre().getNom() : "-" %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
        
        <a href="form-recherche-livre" class="back-button">Nouvelle recherche</a>
    </div>
</body>
</html>