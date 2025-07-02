<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lectures sur place</title>
</head>
<body>
    <h2>Lectures sur place en cours</h2>
    <table border="1">
        <tr>
            <th>Adherent</th>
            <th>Livre</th>
            <th>Exemplaire</th>
            <th>Date debut</th>
            <th>Action</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Emprunt> enCours = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("enCours");
            for (com.bibliotheque.model.Emprunt e : enCours) {
        %>
        <tr>
            <td><%= e.getMembre().getNomUtilisateur() %></td>
            <td><%= e.getExemplaire().getLivre().getTitre() %></td>
            <td><%= e.getExemplaire().getNumeroExemplaire() %></td>
            <td><%= e.getDateDebut() %></td>
            <td>
                <form action="finir-lecture-sur-place" method="post" style="display:inline;">
                    <input type="hidden" name="empruntId" value="<%= e.getId() %>"/>
                    <input type="submit" value="Finir"/>
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <h2>Lectures sur place terminees</h2>
    <table border="1">
        <tr>
            <th>Adherent</th>
            <th>Livre</th>
            <th>Exemplaire</th>
            <th>Date debut</th>
            <th>Date retour</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Emprunt> terminees = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("terminees");
            for (com.bibliotheque.model.Emprunt e : terminees) {
        %>
        <tr>
            <td><%= e.getMembre().getNomUtilisateur() %></td>
            <td><%= e.getExemplaire().getLivre().getTitre() %></td>
            <td><%= e.getExemplaire().getNumeroExemplaire() %></td>
            <td><%= e.getDateDebut() %></td>
            <td><%= e.getDateRetour() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>