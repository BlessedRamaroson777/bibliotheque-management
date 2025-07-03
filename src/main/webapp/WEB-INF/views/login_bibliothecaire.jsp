<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion Bibliothécaire</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Connexion Bibliothécaire</h2>
    <form action="login-bibliothecaire" method="post">
        Nom utilisateur : <input type="text" name="nomUtilisateur" value="admin1" required /><br/>
        Mot de passe : <input type="password" name="motDePasse" value="admin123" required /><br/>
        <input type="submit" value="Se connecter"/>
    </form>
    <div style="color:red">${error}</div>
</body>
</html>
