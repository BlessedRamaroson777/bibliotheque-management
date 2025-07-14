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
            background-color: #f5f5f5;
            margin: 0;
            padding: 2rem;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        h2 {
            color: #1a252f;
            border-bottom: 2px solid #1a252f;
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }

        th, td {
            padding: 0.8rem;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #1a252f;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        input[type="submit"] {
            background-color: #1a252f;
            color: white;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #121a22;
        }
        a {
            color: #1a252f;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        /* Ajoutez ces styles dans votre balise <style> */

        .btn-valider {
            background-color: #4CAF50 !important; /* Vert */
            color: white !important;
            border: none;
            padding: 0.5rem 1rem !important;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-refuser {
            background-color: #f44336 !important; /* Rouge */
            color: white !important;
            border: none;
            padding: 0.5rem 1rem !important;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-valider:hover {
            background-color: #45a049 !important; /* Vert plus foncé au survol */
        }

        .btn-refuser:hover {
            background-color: #d32f2f !important; /* Rouge plus foncé au survol */
        }

        /* Pour aligner les formulaires côte à côte */
        td form {
            display: inline-block;
            margin-right: 5px;
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
