<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen prolongement</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <h2>Liste prolongement</h2>
    <table border="1">
        <tr>
            <th>Id exemplaire</th>
            <th>Date rendu avant</th>
            <th>Date rendu apres</th>
            <th>Accordee</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Prolongation> prolongations = (java.util.List<com.bibliotheque.model.Prolongation>) request.getAttribute("prolongations");
            if (prolongations != null) {
                for (com.bibliotheque.model.Prolongation p : prolongations) {
        %>
        <tr>
            <td><%= p.getEmprunt().getExemplaire().getId() %></td>
            <td><%= p.getAncienneEcheance() %></td>
            <td><%= p.getNouvelleEcheance() %></td>
            <td>
                <% if (p.getAccordee() == null) { %>
                    <form method="post" action="examiner-prolongation">
                        <input type="hidden" name="idProlongation" value="<%= p.getId() %>" />
                        <button type="submit" name="accorder" value="true">Accepter</button>
                        <button type="submit" name="accorder" value="false">Refuser</button>
                    </form>
                <% } else { %>
                    <%= p.getAccordee() ? "true" : "false" %>
                <% } %>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
