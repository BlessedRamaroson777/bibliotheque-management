<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Auteur" %>
<%@ page import="com.bibliotheque.model.GenreLivre" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche de livres</title>
</head>
<body>
    <h2>Recherche de livres</h2>
    <form action="rechercher-livres" method="get">
        Titre: <input type="text" name="titre"/><br/>
        Date edition: <input type="date" name="dateEdition"/><br/>
        Nom auteur:
        <select name="nomAuteur">
            <option value="">-- Tous --</option>
            <%
                List<Auteur> auteurs = (List<Auteur>) request.getAttribute("auteurs");
                if (auteurs != null) {
                    for (Auteur a : auteurs) {
            %>
                <option value="<%= a.getNom() %>"><%= a.getNom() %></option>
            <%
                    }
                }
            %>
        </select><br/>
        Type auteur:
        <select name="typeAuteur">
            <option value="">-- Tous --</option>
            <%
                if (auteurs != null) {
                    for (Auteur a : auteurs) {
                        String nomArtiste = a.getNomArtiste();
                        if (nomArtiste != null && !nomArtiste.isEmpty()) {
            %>
                <option value="<%= nomArtiste %>"><%= nomArtiste %></option>
            <%
                        }
                    }
                }
            %>
        </select><br/>
        Genre:
        <select name="typeLivre">
            <option value="">-- Tous --</option>
            <%
                List<GenreLivre> genres = (List<GenreLivre>) request.getAttribute("genres");
                if (genres != null) {
                    for (GenreLivre g : genres) {
            %>
                <option value="<%= g.getNom() %>"><%= g.getNom() %></option>
            <%
                    }
                }
            %>
        </select><br/>
        <input type="submit" value="Rechercher"/>
    </form>
</body>
</html>