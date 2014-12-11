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
	   io.put_string("------------- Bienvenue sur le logiciel de gestion de la m�diath�que -------------%N%N%N%N%N%N")
	end

	ecran_menu_accueil is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Se connecter en administrateur.%N 2 : Consulter un livre.%N 3 : Consulter un DVD.%N 4 : Voir la liste de tous les livres.%N 5 : Voir la liste de tous les DVD.%N")
	   io.put_string(" 6 : Consulter un Livre ou un DVD de mani�re al�atoire%N Q : Quitter l'application.%N")
	end
	
	ecran_menu_administrateur is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Consulter la fiche d'une personne.%N 2 : Consulter un livre.%N 3 : Consulter un DVD.%N")
	   io.put_string(" 4 : Enregistrer une nouvelle personne.%N 5 : Enregistrer un nouveau livre.%N 6 : Enregistrer un nouveau DVD.%N")
	   io.put_string(" 7 : D�sinscrire une personne.%N 8 : Retirer un livre.%N 9 : Retirer un DVD.%N")
	   io.put_string(" 10 : Modifier les informations d'une personne.%N 11 : Modifier les informations d'un livre.%N 12 : Modifier les informations d'un DVD.%N")
	   io.put_string(" 13 : Gestion des emprunts.%N 14 : Voir la liste de tous les livres.%N 15 : Voir la liste de tous les DVD.%N 16 : Voir la liste de tous les adherents.%N 17. Voir les adh�rents qui ont emprunt� le m�dia selectionn�.%N 0 : Se deconnecter.%N Q : Quitter l'application.%N")
	end

	ecran_connexion_administrateur is
	do
	  io.put_string(" Mot de passe : ")
	end
	
	ecran_menu_error_pw is
	do
	  io.put_string("Le mot de passe que vous avez saisi est incorrect.%NQue voulez faire ?%N 1 : Essayer � nouveau.%N 0 : Revenir au menu pr�c�dent.%N Q : Quitter l'application.%N")
	end

	ecran_connected is
	do
	  io.put_string(" Vous �tes actuellement connect� en mode administrateur %N")
	end
	
	ecran_deconnexion is
	do
	  io.put_string("Vous quittez le mode administrateur.%N")
	end

	ecran_recherche_personne is
	do
	  io.put_string(" Saisissez le pseudo de la personne recherch�e : ")
	end

	ecran_menu_recherche_livre is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Rechercher un livre par son titre.%N 2 : Rechercher un livre par son auteur.%N 3 : Recherche al�atoire.%N 0 : Revenir au menu pr�c�dent.%N Q : Quitter l'application.%N")
	end
	
	ecran_menu_recherche_dvd is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Rechercher un DVD par son titre.%N 2 : Rechercher un DVD par son r�alisateur.%N 3 : Rechercher un DVD par l'un des acteurs.%N 4 : Recherche al�atoire.%N 0 : Revenir au menu pr�c�dent.%N Q : Quitter l'application.%N")
	end
	
	ecran_menu_gestion_emprunt is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Emprunter un livre%N 2 : Emprunter un DVD.%N 3 : Rendre un livre.%N 4 : Rendre un DVD.%N 5 : Consulter la liste des emprunts d'une personne.%N 0 : Revenir au menu pr�c�dent.%N Q : Quitter l'application.%N")
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
	   io.put_string("%N Saisissez le nom de la personne qui a r�alis� le film que vous souhaitez rechercher : %N")
	end
	
	ecran_recherche_acteur is
	do
	   io.put_string("%N Saisissez le nom de l'acteur qui a jou� dans le film que vous souhaitez rechercher : %N")
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
		  io.put_string(" Suppression impossible car un des exemplaires du m�dia a �t� emprunt�.%N")
	   else
		   io.put_string(" M�dia supprim� !%N")
	   end
	end
	ecran_rechercher_emprunt is
	do
	   io.put_string("%N%N%N%N------------------------------------------%N")
	   io.put_string("|       Que souhaitez vous faire ?       |%N")
	   io.put_string("------------------------------------------%N")
	   io.put_string(" 1 : Rechercher les personnes ayant emprunt�es un livre.%N")
	   io.put_string(" 2 : Rechercher les personnes ayant emprunt�es un DVD.%N")
	   io.put_string(" 0 : Revenir au menu pr�c�dent.%N")
	end


end -- classe MENU