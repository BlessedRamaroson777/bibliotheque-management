<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Historique des prêts - Selection du livre</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Voir l'historique des prêts d'un livre</h2>
    <form action="historique-pret" method="get">
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
        <input type="submit" value="Voir l'historique"/>
    </form>
</body>
</html>