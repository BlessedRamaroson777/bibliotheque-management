package com.bibliotheque.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

import com.bibliotheque.model.Membre;
import com.bibliotheque.model.TypeMembre;
import com.bibliotheque.model.Statut;
import com.bibliotheque.model.StatutMembre;
import com.bibliotheque.model.QuotaMembre;
import com.bibliotheque.repository.MembreRepository;
import com.bibliotheque.repository.TypeMembreRepository;
import com.bibliotheque.repository.StatutRepository;
import com.bibliotheque.repository.StatutMembreRepository;
import com.bibliotheque.repository.QuotaMembreRepository;
@Service
public class MembreService {

    @Autowired
    private MembreRepository membreRepository;

    @Autowired
    private TypeMembreRepository typeMembreRepository;

    @Autowired
    private StatutRepository statutRepository;

    @Autowired
    private StatutMembreRepository statutMembreRepository;

    @Autowired
    private QuotaMembreRepository quotaMembreRepository;

    @Transactional
    public Membre inscrireMembre(String nomUtilisateur, String email, String motDePasse,
                                 String confirmationMotDePasse, LocalDate dateInscription,
                                 LocalDate naissance, int idTypeMembre) {

        if (!motDePasse.equals(confirmationMotDePasse)) {
            throw new RuntimeException("Les mots de passe ne correspondent pas.");
        }

        if (membreRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("Email déjà utilisé.");
        }

        TypeMembre typeMembre = typeMembreRepository.findById((long)idTypeMembre)
            .orElseThrow(() -> new RuntimeException("Type membre non trouvé"));

        Membre membre = new Membre();
        membre.setNomUtilisateur(nomUtilisateur);
        membre.setEmail(email);
        membre.setMotDePasse(motDePasse);
        membre.setDateInscription(dateInscription);
        membre.setNaissance(naissance);
        membre.setTypeMembre(typeMembre);

        Membre savedMembre = membreRepository.save(membre);

        // Statut "inscrit"
        Statut statutInscrit = statutRepository.findByValeur("inscrit")
            .orElseThrow(() -> new RuntimeException("Statut 'inscrit' introuvable"));
        StatutMembre statutMembre = new StatutMembre();
        statutMembre.setMembre(savedMembre);
        statutMembre.setStatut(statutInscrit);
        statutMembre.setDateStatut(LocalDate.now());
        statutMembreRepository.save(statutMembre);

        // Quota maximal
        QuotaMembre quota = new QuotaMembre();
        quota.setMembre(savedMembre);
        quota.setQuotaEmprunt(typeMembre.getQuota());
        quota.setDateQuota(LocalDate.now());
        quotaMembreRepository.save(quota);

        return savedMembre;
    }
}
