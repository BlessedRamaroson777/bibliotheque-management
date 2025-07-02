## Titre : inscrire personne
Utilisateur : bibliothecaire
Entree : nom, date_naissance, profession, date_inscription
Regle de gestion :
    - un type 
    - mot_de_passe confirmer
    - email inexistant
Scenario nominal : 
    - un type adherent trouve
    - ajout adherent
    - mettre cet adherent en inscrit
    - mettre le quota en maximal
Sortie : id_adherent, date_expiration sans abonnement


## Titre : Rechercher livre
Utilisateur : bibliothecaire, adherent
Entree :  date edition, nom du livre, nom auteur, type_auteur, type_livre, note
Sortie : liste livres

## Titre : Verifier disponibilite d'exemplaire d'un livre
Utilisateur : bibliothecaire, adherent
Entree : livre, date_disponibilite
Regle de gestion :
    - pas jour ferie
    - nbr exemplaire moins nb pret, nb reserve, nb prolonger, (sur place si le    jour meme)
    - nbr minimum dans la bibliotheque
Scenario nominal :
    - nb exemplaire
Sortie : true/false,  nbr exemplaire, id_exemplaire(s), prochaine date et       recent

## Titre : Historique pret
Utilisateur : bibliothecaire
Entree : livre
Sortie : liste pret(avant + en cours + prolongement), liste reservation 

## Titre : Lire un livre sur place
Utilisateur : bibliothecaire
Entree : id_adherent, id_livre
Regles de gestion :
    - id_adherent existe
    - id_adherent actif
    - id_adherent non penaliser
    - id_livre existe
    - exemplaire id_livre disponible
    - id_livre compatible a id_adherent
Scenario nominal : 
    - un exemplaire lu sur place
Scenario alternatif : 
    - message d erreur
Sortie : examplaire indisponible

## Titre : Preter un livre
Utilisateur : bibliothecaire
Entree : id_adherent, id_livre
Regles de gestion :
    - id_adherent existe
    - id_adherent actif avant et apres
    - id_adherent non penaliser
    - id_adherent limite quota non atteint
    - id_livre existe
    - exemplaire id_livre disponible
    - id_livre compatible a id_adherent
Scenario nominal : 
    - un exemplaire prete
Scenario alternatif : 
    - message d erreur
Sortie : examplaire indisponible, date_rendu

## Titre : Prolonger un livre 
Utilisateur : adherent
Entree : id_adherent, id_livre, date_prolongement
Regles de gestion : 
    - id_adherent existe
    - id_livre existe
Scenario nominal :
    - un exemplaire demande a prolonger
Scenario alternatif : 
    - message d'erreur
Sortie : message envoye au bibliothecaire

## Titre : Reserver un livre
Utilisateur : adherent
Entree : id_adherent, id_livre, date_reservation
Regles de gestion :
    - id_adherent existe
    - id_livre existe
Scenario nominal : 
    - un exemplaire demande a reserver
Scenario alternatif : 
    - message d erreur
Sortie : message envoye au bibliothecaire

## Titre : Examiner prolongement 
Utilisateur : bibliothecaire
Entree : id_prolongement(notification)
Regles de gestion : 
    - id_adherent existe
    - id_adherent actif avant et apres
    - id_adherent non penaliser
    - id_adherent limite quota non atteint a la date_prolongement
    - id_livre existe
    - exemplaire id_livre disponible a la date_prolongement
    - id_livre compatible a id_adherent
Scenario nominal : 
    - un exemaplaire indisponible a la date
Scenaio alternatif
    - message d erreur vers adherent
Sortie : exemplaire indiponible a la date, message vers adherent

## Titre : Examiner reservation 
Utilisateur : bibliothecaire
Entree : id_reservation(notification)
Regles de gestion : 
    - id_adherent existe
    - id_adherent actif avant et apres
    - id_adherent non penaliser
    - id_adherent limite quota non atteint a la date_reservation
    - id_livre existe
    - exemplaire id_livre disponible a la date_reservation
    - id_livre compatible a id_adherent
Scenario nominal : 
    - un exemaplaire indisponible a la date
Scenaio alternatif
    - message d erreur vers adherent
Sortie : exemplaire indisponible a la date, quota -1, , message vers adherent

## Titre : notifier retour de livre
Utilisateur : adherent
Entee : 
Regles de gestion : 
    - un exemplaire a 2jours de la date_rendu
Sortie : id_exmeplaire, date_rendu, duree restant

## Titre : notifier retour de livre
Utilisateur : bibliothecaire
Entee : 
Regles de gestion : 
    - un exemplaire a 2jours de la date_rendu
Sortie : id_exmeplaire, date_rendu, duree restant, date_pret, id_adherent

## Titre : notifier examination prolongement
Utilisateur : adherent
Entree : 
Sortie : id_exemplaire, date_rendu avant, date_rendu apres, true/false

## Titre : notifier examination reservation 
Utilisateur : adherent
Entree : 
Sortie : id_exemplaire, date_pret, date_rendu, true/false

## Titre : rendre un livre
Utilisateur : bibliothecaire
Entree: id_adhrent, id_exemplaire, date_rendu
Regles de gestion
    - id_adherent existe
    - id_exemlaire existe
    - id_exemplaire prete par id_adherent
    - penaliser par rapport date_rendu
Scenario nominal : 
    - livre rendu
Scenario alternatif :
    - livre rendu
    - penaliser id_adherent
Sortie : quota +1, examplaire disponible

## Titre : payer penalisation id_adherent
Utilisateur : bibliothecaire
Entree : id_adherent
Regles de gestion : 
    - payer une penalisation 
Scenario nominal : 
    - adherent penaliser
Sortie : statut actif/inscrit ou 


- Type livre
- Type adherent
- duree inscription : activite / inactivite
- duree de pret
- quota
- jour ferie
- penalisation