class INTERFACE

creation {ANY}
	make
	
feature {ANY}	
	make is
	do
	
	end
	
----------------------
---ECRANS
----------------------
	ecran_accueil is
	do
	   io.put_string("------------- Bienvenue sur le logiciel de gestion de la médiathèque -------------%N%N%N%N%N%N")
	end

	ecran_menu_accueil is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Se connecter en administrateur.%N 2 : Consulter un livre.%N 3 : Consulter un DVD.%N 4 : Voir la liste de tous les livres.%N 5 : Voir la liste de tous les DVD.%N")
	   io.put_string(" 6 : Consulter un Livre ou un DVD de manière aléatoire%N Q : Quitter l'application.%N")
	end
	
	ecran_menu_administrateur is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Consulter la fiche d'une personne.%N 2 : Consulter un livre.%N 3 : Consulter un DVD.%N")
	   io.put_string(" 4 : Enregistrer une nouvelle personne.%N 5 : Enregistrer un nouveau livre.%N 6 : Enregistrer un nouveau DVD.%N")
	   io.put_string(" 7 : Désinscrire une personne.%N 8 : Retirer un livre.%N 9 : Retirer un DVD.%N")
	   io.put_string(" 10 : Modifier les informations d'une personne.%N 11 : Modifier les informations d'un livre.%N 12 : Modifier les informations d'un DVD.%N")
	   io.put_string(" 13 : Gestion des emprunts.%N 14 : Voir la liste de tous les livres.%N 15 : Voir la liste de tous les DVD.%N 16 : Voir la liste de tous les adherents.%N 17. Voir les adhérents qui ont emprunté le média selectionné.%N 0 : Se deconnecter.%N Q : Quitter l'application.%N")
	end

	ecran_connexion_administrateur is
	do
	  io.put_string(" Mot de passe : ")
	end
	
	ecran_menu_error_pw is
	do
	  io.put_string("Le mot de passe que vous avez saisi est incorrect.%NQue voulez faire ?%N 1 : Essayer à nouveau.%N 0 : Revenir au menu précédent.%N Q : Quitter l'application.%N")
	end

	ecran_connected is
	do
	  io.put_string(" Vous êtes actuellement connecté en mode administrateur %N")
	end
	
	ecran_deconnexion is
	do
	  io.put_string("Vous quittez le mode administrateur.%N")
	end

	ecran_recherche_personne is
	do
	  io.put_string(" Saisissez le pseudo de la personne recherchée : ")
	end

	ecran_menu_recherche_livre is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Rechercher un livre par son titre.%N 2 : Rechercher un livre par son auteur.%N 3 : Recherche aléatoire.%N 0 : Revenir au menu précédent.%N Q : Quitter l'application.%N")
	end
	
	ecran_menu_recherche_dvd is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Rechercher un DVD par son titre.%N 2 : Rechercher un DVD par son réalisateur.%N 3 : Rechercher un DVD par l'un des acteurs.%N 4 : Recherche aléatoire.%N 0 : Revenir au menu précédent.%N Q : Quitter l'application.%N")
	end
	
	ecran_menu_gestion_emprunt is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Emprunter un livre%N 2 : Emprunter un DVD.%N 3 : Rendre un livre.%N 4 : Rendre un DVD.%N 5 : Consulter la liste des emprunts d'une personne.%N 0 : Revenir au menu précédent.%N Q : Quitter l'application.%N")
	end

	ecran_recherche_livre_titre is
	do
	   io.put_string("%N Saisissez le titre du livre que vous souhaitez rechercher : %N")
	end
	
	ecran_recherche_dvd_titre is
	do
	   io.put_string("%N Saisissez le titre du DVD que vous souhaitez rechercher : %N")
	end

	ecran_recherche_auteur is
	do
	   io.put_string("%N Saisissez le nom de l'auteur du livre que vous souhaitez rechercher : %N")
	end
	
	ecran_recherche_realisateur is
	do
	   io.put_string("%N Saisissez le nom de la personne qui a réalisé le film que vous souhaitez rechercher : %N")
	end
	
	ecran_recherche_acteur is
	do
	   io.put_string("%N Saisissez le nom de l'acteur qui a joué dans le film que vous souhaitez rechercher : %N")
	end
	
	ecran_emprunt_livre is
	do
	   io.put_string("%N Saisissez le titre du livre puis le pseudo de la personne qui effectue l'emprunt :%N")
	end
	
	ecran_emprunt_dvd is
	do
	   io.put_string("%N Saisissez le titre du dvd puis le pseudo de la personne qui effectue l'emprunt :%N")
	end

	ecran_rendre_dvd is
	do
	   io.put_string("%N Saisissez le titre du dvd puis le pseudo de la personne qui effectue le retour :%N")
	end
	
	ecran_rendre_livre is
	do
	   io.put_string("%N Saisissez le titre du livre puis le pseudo de la personne qui effectue le retour :%N")
	end
	ecran_suppression(i : INTEGER) is
	do
	   if i = 0 then
		  io.put_string(" Suppression impossible car un des exemplaires du média a été emprunté.%N")
	   else
		   io.put_string(" Média supprimé !%N")
	   end
	end
	ecran_rechercher_emprunt is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Rechercher les personnes ayant empruntées un livre.%N")
	   io.put_string(" 2 : Rechercher les personnes ayant empruntées un DVD.%N")
	   io.put_string(" 0 : Revenir au menu précédent.%N")
	end


end -- classe MENU