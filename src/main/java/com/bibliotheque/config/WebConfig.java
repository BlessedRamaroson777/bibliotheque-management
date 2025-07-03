package com.bibliotheque.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new RoleInterceptor())
            .addPathPatterns("/**")
            .excludePathPatterns(
                "/login-adherent", "/login-bibliothecaire", "/membre/inscrire", "/acces-refuse",
                "/form-recherche-livre", "/rechercher-livres", "/form-disponibilite", "/verifier-disponibilite",
                "/index.jsp", "/", "/css/**", "/js/**", "/images/**"
            );
    }
}
