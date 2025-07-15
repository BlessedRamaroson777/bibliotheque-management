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

        // Debug : Affiche l'URI demandée (à désactiver en prod)
        System.out.println("URI demandée : " + uri);

        // ✅ Page d'accueil : accessible à tous
        if (uri.endsWith("/index.jsp") || uri.equals(req.getContextPath() + "/")) {
            chain.doFilter(request, response);
            return;
        }

        // Bloquer l'accès aux pages publiques si non connecté
        if ((uri.endsWith("rechercher-livres") ||
             uri.endsWith("form-recherche-livre") ||
             uri.endsWith("form-disponibilite"))
            && role == null) {
            res.sendRedirect(req.getContextPath() + "/acces-refuse");
            return;
        }

        // Autoriser login si pas connecté
        if (role == null && (uri.endsWith("login-adherent") || uri.endsWith("login-bibliothecaire"))) {
            chain.doFilter(request, response);
            return;
        }

        // 🔒 Pages réservées au bibliothécaire
        if (uri.endsWith("form-preter-livre") ||
            uri.endsWith("preter-livre") ||
            uri.endsWith("membre/inscrire") ||            
            uri.endsWith("abonnements/form") ||
            uri.endsWith("abonnements/liste") ||            
            uri.endsWith("form-lecture-sur-place") ||
            uri.endsWith("lire-sur-place") ||
            uri.endsWith("lectures-sur-place") ||
            uri.endsWith("finir-lecture-sur-place") ||
            uri.endsWith("form-historique-pret") ||
            uri.endsWith("historique-pret") ||
            uri.endsWith("notifier-retour-livre-biblio") ||
            uri.endsWith("form-rendre-livre") ||
            uri.endsWith("rendre-livre") ||
            uri.endsWith("examiner-prolongation") ||
            uri.endsWith("examiner-reservation") ||
            uri.endsWith("annuler-reservation-biblio") ||
            uri.endsWith("assigner-bibliothecaire-reservation") ||
            uri.endsWith("recuperer-reservation") ||
            uri.endsWith("notifier-examination-prolongement-biblio") ||
            uri.endsWith("notifier-examination-reservation-biblio") ||  // <-- bien ici
            uri.endsWith("demandes/en-attente") ||
            uri.endsWith("cotisations") // à restreindre si besoin
        ) {
            if (!"bibliothecaire".equals(role)) {
                res.sendRedirect(req.getContextPath() + "/acces-refuse");
                return;
            }
        }

        // 🔒 Pages réservées à l’adhérent
        if (uri.endsWith("form-prolonger-livre") ||
            uri.endsWith("prolonger-livre") ||
            uri.endsWith("form-reserver-livre") ||
            uri.endsWith("reserver-livre") ||
            uri.endsWith("annuler-reservation-membre") ||
            uri.endsWith("notifier-retour-livre") ||
            uri.endsWith("notifier-examination-prolongement") ||
            uri.endsWith("notifier-examination-reservation") ||
            uri.endsWith("cotiser") ||
            uri.endsWith("cotisations") ||
            uri.endsWith("demandes/nouvelle") ||
            uri.endsWith("demandes/validees")
        ) {
            if (!"adherent".equals(role)) {
                res.sendRedirect(req.getContextPath() + "/acces-refuse");
                return;
            }
        }

        // ✅ Tout le reste est autorisé si connecté
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
