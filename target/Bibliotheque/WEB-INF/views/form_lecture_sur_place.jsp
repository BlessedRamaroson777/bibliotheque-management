<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lecture sur place</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <h2>Lecture sur place</h2>
    <%
        Long idBibliothecaire = (Long) session.getAttribute("idBibliothecaire");
        List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
        List<Livre> livres = (List<Livre>) request.getAttribute("livres");
    %>
    <form action="lire-sur-place" method="post">
        Adherent :
        <select name="idAdherent" required>
            <option value="">-- Choisir un adherent --</option>
            <%
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
                for (Livre l : livres) {
            %>
                <option value="<%= l.getId() %>"><%= l.getTitre() %></option>
            <%
                }
            %>
        </select>
        <br/>
        Date de lecture :
        <input type="datetime-local" name="dateLecture" required />
        <input type="hidden" name="idBibliothecaire" value="<%= idBibliothecaire %>"/>
        <input type="submit" value="Lire sur place"/>
    </form>
</body>
</html>