<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion Adhérent</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Connexion Adhérent</h2>
    <form action="login-adherent" method="post">
        Email : <input type="email" name="email" required /><br/>
        Mot de passe : <input type="password" name="motDePasse" required /><br/>
        <input type="submit" value="Se connecter"/>
    </form>
    <div style="color:red">${error}</div>
</body>
</html>
