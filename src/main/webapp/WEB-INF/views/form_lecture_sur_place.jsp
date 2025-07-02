<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lecture sur place</title>
</head>
<body>
    <h2>Lecture sur place</h2>
    <form action="lire-sur-place" method="post">
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
        <input type="submit" value="Lire sur place"/>
    </form>
</body>
</html>