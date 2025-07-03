<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<%@ page import="com.bibliotheque.model.Bibliothecaire" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prêter un livre</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Prêter un livre</h2>
    <form action="preter-livre" method="post">
        Adhérent :
        <select name="idAdherent" required>
            <option value="">-- Choisir un adhérent --</option>
            <%
                List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
                for (Membre m : adherents) {
            %>
                <option value="<%= m.getId() %>"><%= m.getNomUtilisateur() %> (<%= m.getEmail() %>)</option>
            <%
                }
            %>
        </select>
        <br/>
        Livre :
        <select name="idLivre" required>
            <option value="">-- Choisir un livre --</option>
            <%
                List<Livre> livres = (List<Livre>) request.getAttribute("livres");
                for (Livre l : livres) {
            %>
                <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
            <%
                }
            %>
        </select>
        <br/>
        Bibliothécaire :
        <select name="idBibliothecaire" required>
            <option value="">-- Choisir --</option>
            <%
                List<Bibliothecaire> biblios = (List<Bibliothecaire>) request.getAttribute("bibliothecaires");
                for (Bibliothecaire b : biblios) {
            %>
                <option value="<%= b.getId() %>"><%= b.getNomUtilisateur() %></option>
            <%
                }
            %>
        </select>
        <input type="submit" value="Prêter"/>
    </form>
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
</body>
</html>