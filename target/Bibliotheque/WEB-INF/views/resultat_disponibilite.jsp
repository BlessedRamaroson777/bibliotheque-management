<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Disponibilite du livre</title>
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
        
        .availability-result {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            text-align: center;
        }
        
        h2 {
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        
        .available {
            font-size: 1.2rem;
            font-weight: 500;
            margin-bottom: 1rem;
        }
        
        .unavailable {
            font-size: 1.2rem;
            font-weight: 500;
            margin-bottom: 1rem;
        }
        
        .error {
            color: #e74c3c;
            font-style: italic;
        }
        
        .details {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 4px;
            margin-top: 1rem;
            text-align: left;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 1.5rem;
            padding: 0.6rem 1.2rem;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s;
        }
        
        /* Styles communs */
        .available {
            color: #27ae60; /* vert pour disponible (commun) */
        }
        
        .unavailable {
            color: #e74c3c; /* rouge pour indisponible (commun) */
        }
        
        /* Styles conditionnels selon le rôle */
        <% if ("bibliothecaire".equals(role)) { %>
            h2 {
                color: #1d3557; /* bleu marine */
            }
            
            .back-link {
                background-color: #1d3557; /* bleu marine */
            }
            
            .back-link:hover {
                background-color: #14213d;
                transform: translateY(-2px);
            }
        <% } else { %>
            h2 {
                color: #3498db; /* bleu clair */
            }
            
            .back-link {
                background-color: #3498db; /* bleu clair */
            }
            
            .back-link:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
            }
        <% } %>
    </style>
</head>
<body>
    <div class="availability-result">
        <h2>Disponibilite</h2>
        <%
            com.bibliotheque.service.DisponibiliteResult result = (com.bibliotheque.service.DisponibiliteResult) request.getAttribute("result");
            if (result != null) {
                if (result.isDisponible()) {
        %>
                    <div class="available">Disponible !</div>
                    <div class="details">
                        <p>Nombre d'exemplaires: <strong><%= result.getNbExemplaires() %></strong></p>
                        <p>ID exemplaires: <strong><%= result.getIdExemplaires() %></strong></p>
                    </div>
        <%
                } else {
        %>
                    <div class="unavailable">Indisponible</div>
                    <div class="details">
                        <p>Prochaine date disponible: <strong><%= result.getProchaineDateDisponible() %></strong></p>
                    </div>
        <%
                }
            } else {
        %>
                <p class="error">Erreur: Aucune donnee de disponibilite trouvee.</p>
        <%
            }
        %>
        <a href="form-disponibilite" class="back-link">Nouvelle verification</a>
    </div>
</body>
</html>