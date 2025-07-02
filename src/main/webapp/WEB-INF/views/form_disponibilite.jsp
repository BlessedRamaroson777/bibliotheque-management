<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vérifier disponibilité d'un livre</title>
</head>
<body>
    <h2>Vérifier disponibilité d'un exemplaire</h2>
    <form action="verifier-disponibilite" method="get">
        Livre :
        <select name="livreId" required>
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
        Date de disponibilité :
        <input type="date" name="dateDispo" required />
        <br/>
        <input type="submit" value="Vérifier"/>
    </form>
</body>
</html>