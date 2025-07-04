<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion Bibliothécaire</title>
    <link rel="stylesheet" href="css/style.css"/>
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
            background-image: linear-gradient(rgba(255,255,255,0.9), rgba(255,255,255,0.9)), 
                              url('https://images.unsplash.com/photo-1589998059171-988d887df646?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
        }
        
        .login-container {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            border-top: 4px solid #2c3e50;
        }
        
        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 600;
            font-size: 1.5rem;
        }
        
        form {
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
        }
        
        input[type="text"],
        input[type="password"] {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            width: 100%;
            box-sizing: border-box;
        }
        
        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #2c3e50;
            box-shadow: 0 0 0 2px rgba(44, 62, 80, 0.2);
        }
        
        input[type="submit"] {
            background-color: #2c3e50;
            color: white;
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 0.5rem;
            font-weight: 500;
            letter-spacing: 0.5px;
        }
        
        input[type="submit"]:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
        }
        
        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-top: 1rem;
            font-size: 0.9rem;
            padding: 0.5rem;
            background-color: rgba(231, 76, 60, 0.1);
            border-radius: 4px;
        }
        
        label {
            font-weight: 500;
            margin-bottom: -0.8rem;
            display: block;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Connexion Bibliothécaire</h2>
        <form action="login-bibliothecaire" method="post">
            <label for="nomUtilisateur">Nom utilisateur :</label>
            <input type="text" name="nomUtilisateur" id="nomUtilisateur" value="admin1" required />
            
            <label for="motDePasse">Mot de passe :</label>
            <input type="password" name="motDePasse" id="motDePasse" value="admin123" required />
            
            <input type="submit" value="Se connecter"/>
        </form>
        <div class="error-message">${error}</div>
    </div>
</body>
</html>