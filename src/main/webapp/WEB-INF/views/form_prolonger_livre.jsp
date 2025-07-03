<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<%@ page import="com.bibliotheque.model.Emprunt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prolonger un livre</title>
</head>
<body>
    <h2>Demander une prolongation</h2>
    <%-- Sélection de l'adhérent --%>
    <form method="get" action="form-prolonger-livre">
        Adhérent :
        <select name="idAdherent" required onchange="this.form.submit()">
            <option value="">-- Choisir un adhérent --</option>
            <%
                List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
                Long selectedId = request.getParameter("idAdherent") != null ? Long.parseLong(request.getParameter("idAdherent")) : null;
                for (Membre m : adherents) {
            %>
                <option value="<%= m.getId() %>" <%= (selectedId != null && m.getId().equals(selectedId)) ? "selected" : "" %>><%= m.getNomUtilisateur() %> (<%= m.getEmail() %>)</option>
            <%
                }
            %>
        </select>
    </form>

    <%-- Liste des emprunts en cours --%>
    <%
        List<Emprunt> emprunts = (List<Emprunt>) request.getAttribute("emprunts");
        if (emprunts != null && !emprunts.isEmpty()) {
    %>
        <h3>Livres empruntés non rendus</h3>
        <table border="1">
            <tr>
                <th>Livre</th>
                <th>Exemplaire</th>
                <th>Date début</th>
                <th>Date échéance</th>
                <th>Demander prolongation</th>
            </tr>
            <%
                for (Emprunt e : emprunts) {
            %>
            <tr>
                <td><%= e.getExemplaire().getLivre().getTitre() %></td>
                <td><%= e.getExemplaire().getNumeroExemplaire() %></td>
                <td><%= e.getDateDebut() %></td>
                <td><%= e.getDateEcheance() %></td>
                <td>
                    <form action="prolonger-livre" method="post">
                        <input type="hidden" name="idAdherent" value="<%= e.getMembre().getId() %>"/>
                        <input type="hidden" name="idLivre" value="<%= e.getExemplaire().getLivre().getId() %>"/>
                        Nouvelle date d'échéance :
                        <input type="datetime-local" name="dateProlongement" required/>
                        <input type="submit" value="Demander"/>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    <h3>Prolongations en cours</h3>
    <table border="1">
        <tr>
            <th>Adhérent</th>
            <th>Livre</th>
            <th>Date demande</th>
            <th>Ancienne échéance</th>
            <th>Nouvelle échéance demandée</th>
            <th>Action</th>
        </tr>
        <%
            java.util.List<com.bibliotheque.model.Prolongation> prolongations = (java.util.List<com.bibliotheque.model.Prolongation>) request.getAttribute("prolongations");
            if (prolongations != null) {
                for (com.bibliotheque.model.Prolongation p : prolongations) {
        %>
        <tr>
            <td><%= p.getEmprunt().getMembre().getNomUtilisateur() %></td>
            <td><%= p.getEmprunt().getExemplaire().getLivre().getTitre() %></td>
            <td><%= p.getDateProlongation() %></td>
            <td><%= p.getAncienneEcheance() %></td>
            <td><%= p.getNouvelleEcheance() %></td>
            <td>
                <form action="examiner-prolongation" method="post" style="display:inline;">
                    <input type="hidden" name="idProlongation" value="<%= p.getId() %>"/>
                    <button type="submit" name="accorder" value="true">Accorder</button>
                    <button type="submit" name="accorder" value="false">Refuser</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>