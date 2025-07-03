<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<%@ page import="com.bibliotheque.model.Emprunt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rendre un livre</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Rendre un livre</h2>
    <form method="get" action="form-rendre-livre">
        Adherent :
        <select name="idAdherent" required onchange="this.form.submit()">
            <option value="">-- Choisir un adherent --</option>
            <%
                List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
                String selectedId = request.getParameter("idAdherent");
                for (Membre m : adherents) {
            %>
                <option value="<%= m.getId() %>" <%= (selectedId != null && selectedId.equals(m.getId().toString())) ? "selected" : "" %>><%= m.getNomUtilisateur() %></option>
            <%
                }
            %>
        </select>
    </form>

    <%
        List<Emprunt> emprunts = (List<Emprunt>) request.getAttribute("emprunts");
        if (emprunts != null && !emprunts.isEmpty()) {
    %>
    <h3>Livres non rendus</h3>
    <table border="1">
        <tr>
            <th>Id exemplaire</th>
            <th>Livre</th>
            <th>Date debut</th>
            <th>Date echeance</th>
            <th>Action</th>
        </tr>
        <%
            for (Emprunt e : emprunts) {
        %>
        <tr>
            <td><%= e.getExemplaire().getId() %></td>
            <td><%= e.getExemplaire().getLivre().getTitre() %></td>
            <td><%= e.getDateDebut() %></td>
            <td><%= e.getDateEcheance() %></td>
            <td>
                <form action="rendre-livre" method="post" style="display:inline;">
                    <input type="hidden" name="idAdherent" value="<%= e.getMembre().getId() %>"/>
                    <input type="hidden" name="idExemplaire" value="<%= e.getExemplaire().getId() %>"/>
                    <input type="hidden" name="dateRendu" value="<%= java.time.LocalDateTime.now().toString().substring(0,16) %>"/>
                    <input type="submit" value="Rendre"/>
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
</body>
</html>
