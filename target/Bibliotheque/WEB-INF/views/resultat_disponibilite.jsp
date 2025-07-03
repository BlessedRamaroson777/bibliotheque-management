<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Disponibilite du livre</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Disponibilite</h2>
    <%
        com.bibliotheque.service.DisponibiliteResult result = (com.bibliotheque.service.DisponibiliteResult) request.getAttribute("result");
        if (result != null) {
            if (result.isDisponible()) {
    %>
                <p>Disponible ! Nombre d'exemplaires : <%= result.getNbExemplaires() %></p>
                <p>Id exemplaires : <%= result.getIdExemplaires() %></p>
    <%
            } else {
    %>
                <p>Indisponible. Prochaine date disponible : <%= result.getProchaineDateDisponible() %></p>
    <%
            }
        } else {
    %>
            <p>Erreur : Aucune donnee de disponibilite trouvee.</p>
    <%
        }
    %>
</body>
</html>
