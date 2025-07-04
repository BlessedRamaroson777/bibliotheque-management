<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Accueil Adherent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
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
            line-height: 1.6;
        }
        
        .welcome-container {
            background-color: white;
            padding: 2.5rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }
        
        h2 {
            color: #3498db;
            margin-bottom: 1rem;
            font-weight: 600;
        }
        
        .welcome-message {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            font-size: 1.1rem;
        }
        
        .home-link {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s;
            border: 2px solid transparent;
        }
        
        .home-link:hover {
            background-color: white;
            color: #3498db;
            border-color: #3498db;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(52, 152, 219, 0.2);
        }
        
        .user-name {
            color: #27ae60;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <h2>Bienvenue, <span class="user-name">${adherent.nomUtilisateur}</span> !</h2>
        <p class="welcome-message">Vous etes connecte en tant qu'adherent.</p>
        <a href="index.jsp" class="home-link">Retour a l'accueil</a>
    </div>
</body>
</html>