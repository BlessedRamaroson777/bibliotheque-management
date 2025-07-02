<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prolonger un livre</title>
</head>
<body>
    <h2>Demander une prolongation</h2>
    <form action="prolonger-livre" method="post">
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
        Nouvelle date d'échéance souhaitée :
        <input type="datetime-local" name="dateProlongement" required/>
        <br/>
        <input type="submit" value="Demander la prolongation"/>
    </form>
</body>
</html>