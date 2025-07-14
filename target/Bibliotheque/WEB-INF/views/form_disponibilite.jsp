<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verifier disponibilite d'un livre</title>
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
        
        .availability-container {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        
        h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        
        select, input[type="datetime-local"] {
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
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-top: 0.5rem;
            font-weight: 500;
        }
        
        /* Styles communs */
        select:focus, input[type="datetime-local"]:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        /* Styles conditionnels selon le rôle */
        <% if ("bibliothecaire".equals(role)) { %>
            h2 {
                color: #1d3557; /* bleu marine */
            }
            
            select:focus, input[type="datetime-local"]:focus {
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
            
            select:focus, input[type="datetime-local"]:focus {
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
    <div class="availability-container">
        <h2>Verifier disponibilite d'un exemplaire</h2>
        <form action="verifier-disponibilite" method="get">
            <div class="form-group">
                <label for="livreId">Livre :</label>
                <select name="livreId" id="livreId" required>
                    <option value="">-- Choisir un livre --</option>
                    <%
                        List<Livre> livres = (List<Livre>) request.getAttribute("livres");
                        for (Livre l : livres) {
                    %>
                        <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="dateDispo">Date de disponibilite :</label>
                <input type="datetime-local" name="dateDispo" id="dateDispo" required />
            </div>
            
            <input type="submit" value="Verifier" class="submit-btn"/>
        </form>
    </div>
</body>
</html>