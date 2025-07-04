<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bibliotheque</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h2>Inscription d'un nouveau membre</h2>
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div style="color:green">${message}</div>
    </c:if>
    <form action="inscrire" method="post">
        Nom: <input type="text" name="nomUtilisateur"/><br/>
        Email: <input type="email" name="email"/><br/>
        Mot de passe: <input type="password" name="motDePasse"/><br/>
        Confirmer: <input type="password" name="confirmationMotDePasse"/><br/>
        Date inscription: <input type="datetime-local" name="dateInscription"/><br/>
        Date de naissance: <input type="datetime-local" name="dateNaissance"/><br/>
        Type membre:
        <select name="idTypeMembre" required>
            <%
                java.util.List<com.bibliotheque.model.TypeMembre> TypeMembres = (java.util.List<com.bibliotheque.model.TypeMembre>) request.getAttribute("typesMembres");
                for (com.bibliotheque.model.TypeMembre c : TypeMembres) {
            %>
                <option value="<%= c.getId() %>"><%= c.getNom() %></option>
            <% } %>
        </select>
        <input type="submit" value="Inscrire"/>
    </form>
</body>
</html>
