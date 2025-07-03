<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification retour livre</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Livres a rendre dans 2 jours</h2>
    <form method="get" action="notifier-retour-livre">
        Adhérent :
        <select name="idAdherent" required>
            <option value="">-- Choisir un adhérent --</option>
            <%
                java.util.List<com.bibliotheque.model.Membre> adherents = (java.util.List<com.bibliotheque.model.Membre>) request.getAttribute("adherents");
                if (adherents != null) {
                    for (com.bibliotheque.model.Membre m : adherents) {
            %>
                <option value="<%= m.getId() %>"><%= m.getNomUtilisateur() %></option>
            <%
                    }
                }
            %>
        </select>
        <input type="submit" value="Voir"/>
    </form>
    <br/>
    <table border="1">
        <tr>
            <th>Id exemplaire</th>
            <th>Date rendu</th>
            <th>Duree restante (jours)</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Emprunt> emprunts = (java.util.List<com.bibliotheque.model.Emprunt>) request.getAttribute("emprunts");
            if (emprunts != null) {
                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                for (com.bibliotheque.model.Emprunt e : emprunts) {
                    long joursRestant = java.time.temporal.ChronoUnit.DAYS.between(now.toLocalDate(), e.getDateEcheance().toLocalDate());
        %>
        <tr>
            <td><%= e.getExemplaire().getId() %></td>
            <td><%= e.getDateEcheance() %></td>
            <td><%= joursRestant %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="3">Aucun emprunt trouvé.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
