<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Accès refusé</title>
    <link rel="stylesheet" href="css/style.css"/>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
            line-height: 1.6;
        }
        
        .access-denied-container {
            background-color: white;
            padding: 2.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        
        h2 {
            color: #e74c3c;
            margin-bottom: 1.5rem;
            font-size: 2rem;
        }
        
        p {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            color: #555;
        }
        
        .error-icon {
            font-size: 4rem;
            color: #e74c3c;
            margin-bottom: 1.5rem;
        }
        
        .home-link {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .home-link:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
        }
        
        @media (max-width: 480px) {
            .access-denied-container {
                padding: 1.5rem;
            }
            
            h2 {
                font-size: 1.5rem;
            }
            
            .error-icon {
                font-size: 3rem;
            }
        }
    </style>
</head>
<body>
    <div class="access-denied-container">
        <div class="error-icon">⛔</div>
        <h2>Accès refusé</h2>
        <p>Vous n'avez pas les autorisations nécessaires pour accéder à cette page.</p>
        <a href="index.jsp" class="home-link">Retour à l'accueil</a>
    </div>
</body>
</html>