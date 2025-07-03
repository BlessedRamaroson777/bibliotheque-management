<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.Livre" %>
<%@ page import="com.bibliotheque.model.Membre" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reserver un livre</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <% 
        String resultat = (String) request.getAttribute("resultat");
        if (resultat != null && !resultat.isEmpty()) {
    %>
        <div style="color:blue"><%= resultat %></div>
    <% } %>
    <h2>Reserver un livre</h2>
    <form action="reserver-livre" method="post">
        Adherent :
        <select name="idAdherent" required>
            <option value="">-- Choisir un adherent --</option>
            <%
                List<Membre> adherents = (List<Membre>) request.getAttribute("adherents");
                for (Membre m : adherents) {
            %>
                <option value="<%= m.getId() %>"><%= m.getNomUtilisateur() %></option>
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
        Date reservation :
        <input type="datetime-local" name="dateReservation" value="<%= java.time.LocalDateTime.now().toString().substring(0,16) %>"/>
        <br/>
        Date début (retrait prévu) :
        <input type="datetime-local" name="dateDebut" required/>
        <br/>
        <input type="submit" value="Reserver"/>
    </form>
    <h3>Reservations non recuperees</h3>
    <table border="1">
        <tr>
            <th>Adherent</th>
            <th>Livre</th>
            <th>Date reservation</th>
            <th>Actions</th>
        </tr>
        <%
            List<com.bibliotheque.model.Reservation> reservations = (List<com.bibliotheque.model.Reservation>) request.getAttribute("reservations");
            List<com.bibliotheque.model.Bibliothecaire> bibliothecaires = (List<com.bibliotheque.model.Bibliothecaire>) request.getAttribute("bibliothecaires");
            if (reservations != null) {
                for (com.bibliotheque.model.Reservation r : reservations) {
        %>
        <tr>
            <td><%= r.getMembre().getNomUtilisateur() %></td>
            <td><%= r.getLivre().getTitre() %></td>
            <td><%= r.getDateReservation() %></td>
            <td>
                <% 
                    java.time.LocalDate today = java.time.LocalDate.now();
                    java.time.LocalDate dateDebut = r.getDateDebut().toLocalDate();
                    if (dateDebut.isBefore(today)) { 
                %>
                <form action="annuler-reservation-biblio" method="post" style="display:inline;">
                    <input type="hidden" name="idReservation" value="<%= r.getId() %>"/>
                    <select name="idBibliothecaire" required>
                        <option value="">-- Bibliothecaire --</option>
                        <% if (bibliothecaires != null) {
                            for (com.bibliotheque.model.Bibliothecaire b : bibliothecaires) { %>
                                <option value="<%= b.getId() %>"><%= b.getNomUtilisateur() %></option>
                        <%  }
                        } %>
                    </select>
                    <input type="submit" value="Annuler (biblio)"/>
                </form>
                <% } %>
                <% if (r.getBibliothecaire() != null) { %>
                <form action="annuler-reservation-membre" method="post" style="display:inline;">
                    <input type="hidden" name="idReservation" value="<%= r.getId() %>"/>
                    <input type="hidden" name="idMembre" value="<%= r.getMembre().getId() %>"/>
                    <input type="submit" value="Annuler"/>
                </form>
                <form action="recuperer-reservation" method="post" style="display:inline;">
                    <input type="hidden" name="idReservation" value="<%= r.getId() %>"/>
                    <input type="hidden" name="idBibliothecaire" value="<%= r.getBibliothecaire().getId() %>"/>
                    <input type="submit" value="Recuperer"/>
                </form>
                <form action="examiner-reservation" method="post" style="display:inline;">
                    <input type="hidden" name="idReservation" value="<%= r.getId() %>"/>
                    <button type="submit" name="accorder" value="true">Accorder</button>
                    <button type="submit" name="accorder" value="false">Refuser</button>
                </form>
                <% } %>
                <% if (r.getBibliothecaire() == null) { %>
                <form action="assigner-bibliothecaire-reservation" method="post" style="display:inline;">
                    <input type="hidden" name="idReservation" value="<%= r.getId() %>"/>
                    <select name="idBibliothecaire" required>
                        <option value="">-- Assigner bibliothécaire --</option>
                        <% if (bibliothecaires != null) {
                            for (com.bibliotheque.model.Bibliothecaire b : bibliothecaires) { %>
                                <option value="<%= b.getId() %>"><%= b.getNomUtilisateur() %></option>
                        <%  }
                        } %>
                    </select>
                    <input type="submit" value="Assigner"/>
                </form>
                <% } %>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>