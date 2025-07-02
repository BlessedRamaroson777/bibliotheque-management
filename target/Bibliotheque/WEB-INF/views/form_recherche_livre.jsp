<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche de livres</title>
</head>
<body>
    <h2>Recherche de livres</h2>
    <form action="rechercher-livres" method="get">
        Titre: <input type="text" name="titre"/><br/>
        Date édition: <input type="date" name="dateEdition"/><br/>
        Nom auteur: <input type="text" name="nomAuteur"/><br/>
        Type auteur: <input type="text" name="typeAuteur"/><br/>
        Genre: <input type="text" name="typeLivre"/><br/>
        <input type="submit" value="Rechercher"/>
    </form>
</body>
</html>
