<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Disponibilité du livre</title>
</head>
<body>
    <h2>Disponibilité</h2>
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
            <p>Erreur : Aucune donnée de disponibilité trouvée.</p>
    <%
        }
    %>
</body>
</html>
