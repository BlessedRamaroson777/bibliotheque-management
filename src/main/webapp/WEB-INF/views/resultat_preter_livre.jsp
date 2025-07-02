<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Resultat prêt</title>
</head>
<body>
    <h2>Resultat</h2>
    <p>${resultat}</p>
    <h3>Prêts en cours</h3>
    <table border="1">
        <tr>
            <th>Adherent</th>
            <th>Livre</th>
            <th>Exemplaire</th>
            <th>Date debut</th>
            <th>Date echeance</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Emprunt> prets = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("prets");
            if (prets != null) {
                for (com.bibliotheque.model.Emprunt e : prets) {
        %>
        <tr>
            <td><%= e.getMembre().getNomUtilisateur() %></td>
            <td><%= e.getExemplaire().getLivre().getTitre() %></td>
            <td><%= e.getExemplaire().getNumeroExemplaire() %></td>
            <td><%= e.getDateDebut() %></td>
            <td><%= e.getDateEcheance() %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
    <a href="form-preter-livre">Nouveau prêt</a>
</body>
</html>