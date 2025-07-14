<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Auteur" %>
<%@ page import="com.bibliotheque.model.GenreLivre" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche de livres</title>
    <link rel="stylesheet" href="css/style.css"/>
    
    <% 
       String role = (session.getAttribute("role") != null) ? session.getAttribute("role").toString() : ""; 
    %>
    
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
        
        .search-container {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }
        
        h2 {
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
            color: #2c3e50;
        }
        
        input[type="text"],
        input[type="datetime-local"],
        select {
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
        
        .submit-btn {
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-top: 1rem;
            font-weight: 500;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        /* Styles communs */
        input[type="text"]:focus,
        input[type="datetime-local"]:focus,
        select:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        @media (max-width: 600px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .search-container {
                padding: 1.5rem;
            }
        }
        
        /* Styles conditionnels selon le rôle */
        <% if ("bibliothecaire".equals(role)) { %>
            h2 {
                color: #1d3557; /* bleu marine */
            }
            
            input[type="text"]:focus,
            input[type="datetime-local"]:focus,
            select:focus {
                border-color: #1d3557;
            }
            
            .submit-btn {
                background-color: #1d3557; /* bleu marine */
            }
            
            .submit-btn:hover {
                background-color: #14213d;
                transform: translateY(-2px);
            }
        <% } else { %>
            h2 {
                color: #3498db; /* bleu clair */
            }
            
            input[type="text"]:focus,
            input[type="datetime-local"]:focus,
            select:focus {
                border-color: #3498db;
            }
            
            .submit-btn {
                background-color: #3498db; /* bleu clair */
            }
            
            .submit-btn:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
            }
        <% } %>
    </style>
</head>
<body>
    <div class="search-container">
        <h2>Recherche de livres</h2>
        <form action="rechercher-livres" method="get">
            <div class="form-group">
                <label for="titre">Titre:</label>
                <input type="text" name="titre" id="titre"/>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="dateEdition">Date édition:</label>
                    <input type="datetime-local" name="dateEdition" id="dateEdition"/>
                </div>
                
                <div class="form-group">
                    <label for="typeLivre">Genre:</label>
                    <select name="typeLivre" id="typeLivre">
                        <option value="">-- Tous --</option>
                        <%
                            List<GenreLivre> genres = (List<GenreLivre>) request.getAttribute("genres");
                            if (genres != null) {
                                for (GenreLivre g : genres) {
                        %>
                            <option value="<%= g.getNom() %>"><%= g.getNom() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="nomAuteur">Nom auteur:</label>
                    <select name="nomAuteur" id="nomAuteur">
                        <option value="">-- Tous --</option>
                        <%
                            List<Auteur> auteurs = (List<Auteur>) request.getAttribute("auteurs");
                            if (auteurs != null) {
                                for (Auteur a : auteurs) {
                        %>
                            <option value="<%= a.getNom() %>"><%= a.getNom() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="typeAuteur">Type auteur:</label>
                    <select name="typeAuteur" id="typeAuteur">
                        <option value="">-- Tous --</option>
                        <%
                            if (auteurs != null) {
                                for (Auteur a : auteurs) {
                                    String nomArtiste = a.getNomArtiste();
                                    if (nomArtiste != null && !nomArtiste.isEmpty()) {
                        %>
                            <option value="<%= nomArtiste %>"><%= nomArtiste %></option>
                        <%
                                    }
                                }
                            }
                        %>
                    </select>
                </div>
            </div>
            
            <input type="submit" value="Rechercher" class="submit-btn"/>
        </form>
    </div>
</body>
</html>