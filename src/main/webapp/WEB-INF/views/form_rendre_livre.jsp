<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Rendre un livre</title>
</head>
<body>
    <h2>Rendre un livre</h2>
    <form action="rendre-livre" method="post">
        Id adherent : <input type="number" name="idAdherent" required/><br/>
        Id exemplaire : <input type="number" name="idExemplaire" required/><br/>
        Date rendu : <input type="datetime-local" name="dateRendu" required/><br/>
        <input type="submit" value="Rendre"/>
    </form>
</body>
</html>
