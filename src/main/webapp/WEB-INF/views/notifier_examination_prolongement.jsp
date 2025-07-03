<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification examen prolongement</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <h2>Resultat examen prolongement</h2>
    <form method="get" action="notifier-examination-prolongement">
        <%
            Long idAdherent = (Long) session.getAttribute("idMembre");
        %>
        <input type="hidden" name="idAdherent" value="<%= idAdherent %>"/>
        <input type="submit" value="Voir mes prolongations"/>
    </form>
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
                    if (p.getEmprunt().getMembre().getId().equals(idAdherent)) {
        %>
        <tr>
            <td><%= p.getEmprunt().getExemplaire().getId() %></td>
            <td><%= p.getAncienneEcheance() %></td>
            <td><%= p.getNouvelleEcheance() %></td>
            <td><%= p.getAccordee() != null && p.getAccordee() ? "true" : "false" %></td>
        </tr>
        <%
                    }
                }
            }
        %>
    </table>
</body>
</html>
