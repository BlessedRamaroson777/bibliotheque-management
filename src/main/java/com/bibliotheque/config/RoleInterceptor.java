package com.bibliotheque.config;

import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RoleInterceptor implements HandlerInterceptor {
    @SuppressWarnings("null")
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // Bibliothecaire uniquement
        if (
            uri.contains("form-preter-livre") || uri.contains("preter-livre") ||
            uri.contains("form-lecture-sur-place") || uri.contains("lire-sur-place") ||
            uri.contains("lectures-sur-place") || uri.contains("finir-lecture-sur-place") ||
            uri.contains("form-historique-pret") || uri.contains("historique-pret") ||
            uri.contains("notifier-retour-livre-biblio") ||
            uri.contains("form-rendre-livre") || uri.contains("rendre-livre") ||
            uri.contains("examiner-prolongation") || uri.contains("examiner-reservation") ||
            uri.contains("annuler-reservation-biblio") || uri.contains("assigner-bibliothecaire-reservation") ||
            uri.contains("recuperer-reservation")
        ) {
            if (!"bibliothecaire".equals(role)) {
                response.sendRedirect("/acces-refuse");
                return false;
            }
        }

        // Adherent uniquement
        if (
            uri.contains("form-prolonger-livre") || uri.contains("prolonger-livre") ||
            uri.contains("form-reserver-livre") || uri.contains("reserver-livre") ||
            uri.contains("annuler-reservation-membre") ||
            uri.contains("notifier-retour-livre") ||
            uri.contains("notifier-examination-prolongement") ||
            uri.contains("notifier-examination-reservation")
        ) {
            if (!"adherent".equals(role)) {
                response.sendRedirect("/acces-refuse");
                return false;
            }
        }

        // Accessible à tous (recherche, disponibilité, login, inscription, accueil)
        return true;
    }
}
