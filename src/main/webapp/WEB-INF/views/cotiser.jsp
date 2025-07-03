<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cotiser</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <h2>Nouvelle cotisation</h2>
    <form action="cotiser" method="post">
        Date début : <input type="datetime-local" name="dateDebut" required/><br/>
        Date fin : <input type="datetime-local" name="dateFin" required/><br/>
        <input type="submit" value="Cotiser"/>
    </form>
    <div style="color:green">${message}</div>
</body>
</html>
