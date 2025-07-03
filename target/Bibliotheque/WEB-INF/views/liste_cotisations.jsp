<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Historique des cotisations</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <h2>Historique des cotisations</h2>
    <table border="1">
        <tr>
            <th>Adhérent</th>
            <th>Date début</th>
            <th>Date fin</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Cotisation> cotisations = (java.util.List<com.bibliotheque.model.Cotisation>) request.getAttribute("cotisations");
            if (cotisations != null) {
                for (com.bibliotheque.model.Cotisation c : cotisations) {
        %>
        <tr>
            <td><%= c.getMembre().getNomUtilisateur() %></td>
            <td><%= c.getDateDebut() %></td>
            <td><%= c.getDateFin() %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
