<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Resultat rendre livre</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Resultat</h2>

    <p>${resultat}</p>

    <c:if test="${penalite != null}">
        <h3>Penalite appliquee</h3>
        <ul>
            <li>Duree du retard : ${penalite.duree} jour(s)</li>
        </ul>
    </c:if>

    <a href="form-rendre-livre">Rendre un autre livre</a>
</body>
</html>
