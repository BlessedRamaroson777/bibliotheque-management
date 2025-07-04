<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion Adhérent</title>
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
        }
        
        .login-container {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        
        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        
        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        input[type="email"],
        input[type="password"] {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            width: 100%;
            box-sizing: border-box;
        }
        
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        input[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 0.5rem;
        }
        
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        
        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        
        label {
            font-weight: 500;
            margin-bottom: -0.5rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Connexion Adhérent</h2>
        <form action="login-adherent" method="post">
            <label for="email">Email :</label>
            <input type="email" name="email" id="email" value="alice@mail.com" required />
            
            <label for="motDePasse">Mot de passe :</label>
            <input type="password" name="motDePasse" id="motDePasse" value="passalice" required />
            
            <input type="submit" value="Se connecter"/>
        </form>
        <div class="error-message">${error}</div>
    </div>
</body>
</html>