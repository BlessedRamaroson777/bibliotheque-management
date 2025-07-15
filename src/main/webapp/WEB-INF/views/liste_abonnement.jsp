<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%
    LocalDate now = LocalDate.now();
%>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f5f5f5;
        margin: 0;
        padding: 2rem;
        color: #333;
    }
    .container {
        max-width: 1000px;
        margin: 0 auto;
        background: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }
    h2 {
        color: #2c3e50;
        border-bottom: 2px solid #1a252f;
        padding-bottom: 0.5rem;
        margin-bottom: 1.5rem;
    }
    h3 {
        color: #3498db;
        margin: 1.5rem 0 1rem;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 2rem;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 0.8rem;
        text-align: left;
    }
    th {
        background-color: #1a252f;
        color: white;
    }
    tr:nth-child(even) {
        background: #f9f9f9;
    }
    .expired {
        color: #e74c3c;
        font-weight: bold;
    }
    .valid {
        color: #2ecc71;
    }
    .no-data {
        text-align: center;
        padding: 2rem;
        color: #7f8c8d;
        font-style: italic;
    }
</style>

<div class="container">
    <h2>Liste des abonnements</h2>
    <%
        java.util.List<com.bibliotheque.model.Abonnement> abonnements = 
            (java.util.List<com.bibliotheque.model.Abonnement>) request.getAttribute("abonnements");
        
        if (abonnements != null && !abonnements.isEmpty()) {
            java.util.Collections.sort(abonnements, new java.util.Comparator<com.bibliotheque.model.Abonnement>() {
                @Override
                public int compare(com.bibliotheque.model.Abonnement a1, com.bibliotheque.model.Abonnement a2) {
                    return a1.getMembre().getNomUtilisateur().compareToIgnoreCase(a2.getMembre().getNomUtilisateur());
                }
            });

            String currentMembre = null;
            boolean firstMembre = true;

            for (com.bibliotheque.model.Abonnement abonnement : abonnements) {
                String membreNom = abonnement.getMembre().getNomUtilisateur();

                if (!membreNom.equals(currentMembre)) {
                    if (!firstMembre) {
    %>
                        </tbody>
                        </table>
                        <br/>
    <%
                    }
                    currentMembre = membreNom;
                    firstMembre = false;
    %>
                    <h3>Membre : <%= currentMembre %></h3>
                    <table border="1" style="width: 100%; border-collapse: collapse;">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Type</th>
                                <th>Debut</th>
                                <th>Fin</th>
                                <th>Etat</th>
                            </tr>
                        </thead>
                        <tbody>
    <%
                }
                // Ici on compare LocalDate (pas LocalDateTime) avec now
                java.time.LocalDate finDate = abonnement.getFinAbonnement().toLocalDate();
                String color = finDate.isBefore(now) ? "red" : "black";
                String debutStr = abonnement.getDebutAbonnement().toLocalDate().toString();
                String finStr = finDate.toString();
                String etat = finDate.isBefore(now) ? "Non valide" : "Valide";
    %>
                <tr style="color: <%= color %>;">
                    <td><%= abonnement.getId() %></td>
                    <td><%= abonnement.getTypeAbonnement().getNom() %></td>
                    <td><%= debutStr %></td>
                    <td><%= finStr %></td>
                    <td><%= etat %></td>
                </tr>
    <%
            } // fin for
    %>
                    </tbody>
                </table>
    <%
        } else {
    %>
            <p>Aucun abonnement trouve.</p>
    <%
        }
    %>
</div>