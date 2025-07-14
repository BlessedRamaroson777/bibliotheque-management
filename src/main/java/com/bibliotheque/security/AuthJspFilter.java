package com.bibliotheque.security;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthJspFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // ✅ Page d'accueil : accessible à tous
        if (uri.endsWith("/index.jsp") || uri.equals(req.getContextPath() + "/")) {
            chain.doFilter(request, response);
            return;
        }

        // Bloquer l'accès aux pages services communs si pas connecté
        if ((uri.contains("rechercher-livres") ||
            uri.contains("form-recherche-livre") ||
            uri.contains("form-disponibilite"))
            && role == null) {
            res.sendRedirect(req.getContextPath() + "/acces-refuse"); // Ou page login générale
            return;
        }


        // Autoriser les pages de login si non connecté
        if (role == null && (uri.contains("login-adherent") || uri.contains("login-bibliothecaire"))) {
            chain.doFilter(request, response);
            return;
        }


        // 🔒 Pages bibliothécaire uniquement
        if (uri.contains("form-preter-livre") ||
            uri.contains("preter-livre") ||
            uri.contains("form-lecture-sur-place") ||
            uri.contains("lire-sur-place") ||
            uri.contains("lectures-sur-place") ||
            uri.contains("finir-lecture-sur-place") ||
            uri.contains("form-historique-pret") ||
            uri.contains("historique-pret") ||
            uri.contains("notifier-retour-livre-biblio") ||
            uri.contains("form-rendre-livre") ||
            uri.contains("rendre-livre") ||
            uri.contains("examiner-prolongation") ||
            uri.contains("examiner-reservation") ||
            uri.contains("annuler-reservation-biblio") ||
            uri.contains("assigner-bibliothecaire-reservation") ||
            uri.contains("recuperer-reservation") ||
            uri.contains("notifier-examination-prolongement-biblio") ||
            uri.contains("notifier-examination-reservation-biblio") ||
            uri.contains("demandes/en-attente") ||
            uri.contains("cotisations") // attention ici, à restreindre si besoin
        ) {
            if (!"bibliothecaire".equals(role)) {
                res.sendRedirect(req.getContextPath() + "/acces-refuse");
                return;
            }
        }

        // 🔒 Pages adhérent uniquement
        if (uri.contains("form-prolonger-livre") ||
            uri.contains("prolonger-livre") ||
            uri.contains("form-reserver-livre") ||
            uri.contains("reserver-livre") ||
            uri.contains("annuler-reservation-membre") ||
            uri.contains("notifier-retour-livre") ||
            uri.contains("notifier-examination-prolongement") ||
            uri.contains("notifier-examination-reservation") ||
            uri.contains("cotiser") ||
            uri.contains("demandes/nouvelle") ||
            uri.contains("demandes/validees")
        ) {
            if (!"adherent".equals(role)) {
                res.sendRedirect(req.getContextPath() + "/acces-refuse");
                return;
            }
        }

        // ✅ Le reste est accessible aux rôles valides
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
