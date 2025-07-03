package com.bibliotheque.controller;

import com.bibliotheque.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NotificationController {
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/notifier-retour-livre")
    public String notifierRetourLivre(@RequestParam Long idAdherent, Model model) {
        model.addAttribute("emprunts", notificationService.getEmpruntsARendreDans2Jours(idAdherent));
        return "notifier_retour_livre";
    }
}
