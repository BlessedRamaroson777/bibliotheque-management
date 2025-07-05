<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bibliotheque.model.DemandeEmprunt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des demandes admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #1a252f;
            color: #7ec8e3;
            margin: 0; padding: 2rem;
        }
        h2 {
            color: #7ec8e3;
            border-bottom: 2px solid #7ec8e3;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 30px;
        }
        th, td {
            border: 1px solid #3b4a5a;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #7ec8e3;
            color: #1a252f;
        }
        tr:nth-child(even) {
            background-color: #22303f;
        }
        tr:nth-child(odd) {
            background-color: #1a252f;
        }
        form {
            display: inline;
        }
        .btn-valider {
            background-color: #2ecc71;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-refuser {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-valider:hover, .btn-refuser:hover {
            opacity: 0.9;
        }
        a {
            color: #7ec8e3;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Demandes en attente</h2>
    <table>
        <thead>
            <tr>
                <th>ID Demande</th>
                <th>Adherent</th>
                <th>Livre</th>
                <th>Date de la demande</th>
                <th>Date prevu de l'emprunt</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<DemandeEmprunt> enAttente =
                    (List<DemandeEmprunt>) request.getAttribute("demandesEnAttente");
                if (enAttente != null && !enAttente.isEmpty()) {
                    for (DemandeEmprunt d : enAttente) {
            %>
            <tr>
                <td><%= d.getId() %></td>
                <td><%= d.getMembre().getNomUtilisateur() %></td>
                <td><%= d.getLivre().getTitre() %></td>
                <td><%= d.getDateDemande() %></td>
                <td><%= d.getDatePrevu() %></td>
                <td>
                    <form action="<%= request.getContextPath() %>/demandes/<%= d.getId() %>/valider" method="post">
                        <%
                            Long idBibliothecaire = (Long) session.getAttribute("idBibliothecaire");
                        %>
                        <input type="hidden" name="idBibliothecaire" value="<%= idBibliothecaire %>" />
                        <input class="btn-valider" type="submit" value="Valider" />
                    </form>
                    <form action="<%= request.getContextPath() %>/demandes/<%= d.getId() %>/refuser" method="post">
                        <input type="hidden" name="idBibliothecaire" value="1" />
                        <input class="btn-refuser" type="submit" value="Refuser" />
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="6">Aucune demande en attente.</td></tr>
            <%
                }
            %>
        </tbody>
    </table>

    <h2>Demandes traitees (validees ou refusees)</h2>
    <table>
        <thead>
            <tr>
                <th>ID Demande</th>
                <th>Adherent</th>
                <th>Livre</th>
                <th>Date de la demande</th>
                <th>Date prevu de l'emprunt</th>
                <th>Date de traitement</th>
                <th>Statut</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<DemandeEmprunt> nonEnAttente =
                    (List<DemandeEmprunt>) request.getAttribute("demandesNonEnAttente");
                if (nonEnAttente != null && !nonEnAttente.isEmpty()) {
                    for (DemandeEmprunt d : nonEnAttente) {
            %>
            <tr>
                <td><%= d.getId() %></td>
                <td><%= d.getMembre().getNomUtilisateur() %></td>
                <td><%= d.getLivre().getTitre() %></td>
                <td><%= d.getDateDemande() %></td>
                <td><%= d.getDatePrevu() %></td>
                <td><%= d.getDateTraitement() %></td>
                <td><%= "validee".equals(d.getStatut()) ? "Validee" : "Refusee" %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="7">Aucune demande traitee.</td></tr>
            <%
                }
            %>
        </tbody>
    </table>

    <a href="<%= request.getContextPath() %>/" style="text-decoration: none;">&larr; Retour à l'accueil</a>
</div>
</body>
</html>
