class INTERFACE

creation {ANY}
	make
	
feature {ANY}	
	make is
	do
	
	end
	
----------------------------------
------  
----------------------------------

	accueil is
	do
	   encart("Bienvenue sur le logiciel de gestion de la médiathèque")
	end

	
----------------------------------
------  ENCART POUR LES MENU
----------------------------------	
	encart(val_encart : STRING) is
	local
		i :  INTEGER
	do
		io.put_new_line
		from i := 1
		until i > val_encart.count+9
		loop
			io.put_string("#")
			i := i + 1
		end
		io.put_new_line
		io.put_string("###  ")
		from i := 1
		until i > val_encart.count
		loop
			io.put_string(" ")
			i := i + 1
		end
		io.put_string(" ###%N")
		io.put_string("###  ")
		io.put_string(val_encart)
		io.put_string(" ###%N")
		io.put_string("###  ")
		from i := 1
		until i > val_encart.count
		loop
			io.put_string(" ")
			i := i + 1
		end
		io.put_string(" ###")
		io.put_new_line
		from i := 1
		until i > val_encart.count+9
		loop
			io.put_string("#")
			i := i + 1
		end
		io.put_new_line
	end
	
	choix_principal is
	do
		encart("Simulation de connexion")
		io.put_string("%N 1 - Menu administrateur%N")
		io.put_string("%N 2 - Menu principal%N")
	end
	
	call_menu_administrateur is
	do
		encart("Menu administrateur")
		io.put_string("%N 1 - Gestion des utilisateurs%N")
		io.put_string("%N 2 - Gestion des medias%N")
		io.put_string("%N 3 - Gestion des emprunts%N")		
	end
	
	call_menu is
	do
		encart("Menu")
		io.put_string("%N 1 - Gestion des emprunts%N")	
	end
	
	menu_gestion_medias is
	do
		encart("Gestion des medias")
		io.put_string("%N 1 - Afficher la liste des medias %N")
		io.put_string("%N 2 - Importer les informations du fichier medias.txt %N")
		io.put_string("%N 3 - Ajouter un media %N")
		io.put_string("%N 4 - Supprimer un media (par titre) %N")
		io.put_string("%N 5 - Rechercher un media (par titre) %N")
	end
	
	menu_gestion_emprunts is
	do
		encart("Gestion des emprunts")
		io.put_string("%N 1 - Emprunter un media %N")
		io.put_string("%N 2 - Rendre un media %N")
		io.put_string("%N 3 - Consulter les emprunts en cours %N")
		io.put_string("%N 4 - Consulter les retards %N")
		io.put_string("%N 5 - Modifier la durée autorisée d'un emprunt %N")
	end
	
	menu_gestion_emprunts_user is
	do
		encart("Gestion des emprunts")
		io.put_string("%N 1 - Emprunter un media %N")
		io.put_string("%N 2 - Rendre un media %N")
		io.put_string("%N 3 - Rechercher un media (par titre) %N")
	end
	
	menu_gestion_utilisateurs is
	do
		encart("Gestion des utilisateurs")
		io.put_string("%N 1 - Afficher la liste des utilisateurs %N")
		io.put_string("%N 2 - Importer les informations du fichier utilisateurs.txt %N")
		io.put_string("%N 3 - Ajouter un utilisateur %N")
		io.put_string("%N 4 - Supprimer un utilisateur (par identifiant) %N")
		io.put_string("%N 5 - Modifier statut d'un utilisateur %N")
	end
	
	menu_choix_media is 
	do
		encart("Choix média à ajouter")
		io.put_string("%N 1 - Ajouter un dvd %N")
		io.put_string("%N 2 - Ajouter un livre %N")
	end
	
	choix_commande(info : STRING) : STRING is
	local
		command : STRING
	do
		io.put_string(info)
		io.flush
		io.read_line
		command := io.last_string.twin
		command.left_adjust
		command.right_adjust
		Result := command
	end

	continuer is
	do
		io.put_string("Appuyer sur Entrée pour continuer.")
		io.read_line
	end
	
end -- classe INTERFACE