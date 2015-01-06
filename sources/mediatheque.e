class MEDIATHEQUE

creation {ANY}
	make

feature {ANY}
	medias: ARRAY[MEDIA] -- liste des medias
	utilisateurs: ARRAY[UTILISATEUR] -- liste des utilisateurs
	filename_utilisateurs: STRING -- chemin vers le fichier utilisateurs
	filename_medias: STRING --chemin vers le fichier medias
	interface : INTERFACE
	emprunts : ARRAY[EMPRUNT]
	prm_duree_autorisee : INTEGER
	
feature
	
	make is
		local
			stop, retour,admin , user ,test, test_suppression, fin: BOOLEAN
			command : STRING
			utilisateur ,user_actif : UTILISATEUR
			livre : LIVRE
			dvd :  DVD
			nom, prenom, identifiant, new_admin : STRING
			nombre_livre, nombre_dvd ,res ,nbr_emprunt : INTEGER
			auteur , titre ,nbr_str_livre, nbr_str_dvd, realisateur, acteur, annee_dvd: STRING
			liste_acteur , liste_realisateur : ARRAY[STRING]
			annee ,i: INTEGER
			type : STRING
			emprunt : EMPRUNT
			id_user_emprunt : STRING
		do
			-- Initialisation
			create utilisateurs.with_capacity(0,0)
			create medias.with_capacity(0,0)
			create emprunts.with_capacity(0,0)
			prm_duree_autorisee := 15
			create filename_utilisateurs.make_from_string("../ressources/utilisateurs.txt")
			create filename_medias.make_from_string("../ressources/medias.txt")
			create interface.make
			interface.accueil
			lire_fichier_utilisateurs(False)
			lire_fichier_medias(False)
			lire_fichier_emprunts
			from 			
			until
				stop
			loop
				-- connexion
				retour := False
				io.put_string(once "%N Entrer votre identifiant (q pour quitter) : ")
				io.flush
				io.read_line
				command := io.last_string.twin
				command.left_adjust
				command.right_adjust
				admin := False
				user := False
				from i:= 0
				until i > utilisateurs.count-1
				loop
					if utilisateurs.item(i).str_admin(command) and utilisateurs.item(i).est_actif then
						admin := True
						user_actif := utilisateurs.item(i)
						id_user_emprunt := command
					elseif utilisateurs.item(i).str_user(command) and utilisateurs.item(i).est_actif then
						user := True
						id_user_emprunt := command
						user_actif := utilisateurs.item(i)
					end	
					i := i+1
				end
				if command.is_equal("q") then
					stop := True
				elseif admin then
					from 					
					until
						retour
					loop
						interface.call_menu_administrateur
						command := interface.choix_commande("%N Entrer votre choix (r pour retour): ")
						inspect
							command
						when "r", "R", "retour" then
							retour := True
						when "1" then
							from 
							until
								retour
							loop
								interface.menu_gestion_utilisateurs
								command := interface.choix_commande("%N Entrer votre choix (r pour retour): ")
								inspect
									command
								when "r", "R", "retour" then
									retour := True
								when "1" then
									afficher_utilisateurs
								when "2" then
									lire_fichier_utilisateurs(True)
								when "3" then
									-- contrôle de saisie du nom
									nom := interface.choix_commande("%N  Nom de l'utilisateur : ")
									from
									until not est_vide(nom)
									loop
										nom := interface.choix_commande("%N  Nom de l'utilisateur : ")
									end
									
									-- contrôle de saisie du prénom
									prenom := interface.choix_commande("%N Prenom de l'utilisateur : ")
									from
									until not est_vide(prenom)
									loop
										prenom := interface.choix_commande("%N Prenom de l'utilisateur : ")
									end
									
									-- contrôle de saisie de l'identifiant
									identifiant := interface.choix_commande("%N Identifiant de l'utilisateur : ")
									fin := False
									from
									until fin or (not identifiant_existe(identifiant) and not est_vide(identifiant))
									loop
										if identifiant_existe(identifiant) and  not est_actif(identifiant) then
											user_actif.active
											io.put_string("%NCompte réactivé.%N")
											fin := True
										else
											io.put_string("%N Cet identifiant existe déjà.")
											identifiant := interface.choix_commande("%N Identifiant de l'utilisateur : ")
										end
										
									end
									new_admin := ""
									from
									until
										new_admin.is_equal("1") or new_admin.is_equal("0")
									loop
										new_admin := interface.choix_commande("Grade(1 pour admin, 0 sinon) : ")
										if est_vide(new_admin) then new_admin := "3" end
										inspect 
											new_admin
										when "1" then
											create utilisateur.make_admin(nom,prenom,identifiant,True)
										when "0" then
											create utilisateur.make_client(nom,prenom,identifiant,True)
										else
											io.put_string("Commande inconnue%N")
										end
									end
									ajouter_utilisateur(utilisateur,True)
								when "4" then
								-- Suppression utilisateur
									test_suppression := supprimer_utilisateur
								when "5" then
									modifier_statut
								else
									io.put_string("Commande inconnue%N")
								end
								if not retour then
									interface.continuer
								end
							end
							retour := False
						when "2" then
							from 
							until
								retour
							loop
								interface.menu_gestion_medias
								command := interface.choix_commande("%N Entrer votre choix (r pour retour): ")
								inspect
									command
								when "r", "R", "retour" then
									retour := True
								when "1" then
									afficher_medias
								when "2" then
									lire_fichier_medias(True)
								when "3" then
									from
									until
										retour
									loop
										interface.menu_choix_media
										command := interface.choix_commande("%N Entrer votre choix (r pour retour): ")
										inspect
											command
										when "r", "R", "retour" then
											retour := True
										when "1" then
											create liste_realisateur.with_capacity(0, 0)		
											create liste_acteur.with_capacity(0, 0)
											titre := interface.choix_commande("%N Titre du dvd : ")
											realisateur := interface.choix_commande("%N Réalisateur (1 pour stop) : ")
											from 
											until
												realisateur.is_equal("1") and liste_realisateur.count-1 > -1
											loop
												
												if realisateur.is_equal("1") or est_vide(realisateur) then
													io.put_string("Aucun réalisateur renseigné. %N")
												else
													liste_realisateur.add_last(realisateur)
												end
												realisateur := interface.choix_commande("%N Réalisateur (1 pour stop) : ")
											end
											acteur := interface.choix_commande("%N Acteur (1 pour stop) : ")
											from 
											until
												acteur.is_equal("1") and liste_acteur.count-1 > -1
											loop
												
												if acteur.is_equal("1") or est_vide(acteur) then
													io.put_string("Aucun acteur renseigné. %N")
												else	
													liste_acteur.add_last(acteur)
												end
												acteur := interface.choix_commande("%N Acteur (1 pour stop) : ")
											end
											type := interface.choix_commande("%N Type du dvd (coffret) : ")
											
											create nbr_str_dvd.make_empty
											from 
											until
												nbr_str_dvd.is_integer
											loop
												nbr_str_dvd := interface.choix_commande("%N Nombre d'exemplaire du dvd : ")
											end
											nombre_dvd := nbr_str_dvd.to_integer
											annee_dvd := interface.choix_commande("%N Année dvd : ")
											from 
											until
												annee_dvd.is_integer
											loop
												annee_dvd := interface.choix_commande("Nombre d'exemplaire du dvd : ")
											end
											annee := annee_dvd.to_integer
											create dvd.make_dvd(titre,annee, liste_realisateur,liste_acteur,type,nombre_dvd)
											ajouter_dvd(dvd, True)
										when "2" then
											titre := interface.choix_commande("%N Titre du livre : ")
											auteur := interface.choix_commande("%N Auteur du livre : ")
											nbr_str_livre := interface.choix_commande("%N Nombre d'exemplaire du livre : ")
											from 
											until
												nbr_str_livre.is_integer
											loop
												nbr_str_livre := interface.choix_commande("%N Nombre d'exemplaire du livre : ")
											end
											nombre_livre := nbr_str_livre.to_integer
											create livre.make_livre(titre,auteur,nombre_livre)
											ajouter_livre(livre,True)
										else
											io.put_string("Commande inconnue%N")
										end
										if not retour then
											interface.continuer
										end
									end
									retour := False
								when "4" then 
									test_suppression := supprimer_media
									if test_suppression = True then
										io.put_string("Média supprimé.%N")
									else
										io.put_string("Suppression impossible. Le média est emprunté.%N")
									end
								when "5" then
									if medias.count-1 > 0 then
										res := -1
										from
										until 
											res > 0
										loop
											titre := interface.choix_commande("%N Titre du media à rechercher : ")
											res := rechercher_media_titre(titre,True)
											if res = -1 then
												io.put_string("Aucun media correspondant.%N")
											end
										end
									else
										io.put_string("Liste des médias vide.%N")
									end
								else
									io.put_string("Commande inconnue%N")
								end
								if not retour then
									interface.continuer									
								end
							end
							retour := False
						when "3" then
							from 
							until
								retour
							loop
								interface.menu_gestion_emprunts
								command := interface.choix_commande("%N Entrer votre choix (r pour retour):")
								inspect
									command
								when "r", "R", "retour" then
									retour := True
								when "1" then
									res := rechercher_media
									if res > -1 then
										create emprunt.make_emprunt(medias.item(res).get_identifiant,id_user_emprunt,prm_duree_autorisee)
										test := medias.item(res).emprunter
										if test then
											emprunts.add_last(emprunt)
										end
										io.put_new_line
									end
								when "2" then
									nbr_emprunt := rechercher_emprunt(id_user_emprunt)
									if nbr_emprunt >= 0 then
										emprunts.item(nbr_emprunt).set_date_retour
										retour_media(emprunts.item(nbr_emprunt).get_id_media)
									end
								when "3" then
									liste_emprunt
								when "4" then
									consulter_retard
								when "5" then
									modifier_duree_autorisee
								else
									io.put_string("Commande inconnue%N")
								end
								if not retour then
									interface.continuer
								end
							end
							retour := False
						else
							io.put_string("Commande inconnue%N")
						end
					end
				elseif user then
					from					
					until
						retour
					loop
						interface.menu_gestion_emprunts_user
						command := interface.choix_commande("%N Entrer votre choix (r pour retour):")
						inspect
							command
						when "r", "R", "retour" then
							retour := True
						when "1" then
							res := rechercher_media
							if res > -1 then
								create emprunt.make_emprunt(medias.item(res).get_identifiant,id_user_emprunt,prm_duree_autorisee)
								test := medias.item(res).emprunter
								if test then
									emprunts.add_last(emprunt)
								end
								interface.continuer
							end
						when "2" then
							nbr_emprunt := rechercher_emprunt(id_user_emprunt)
							if nbr_emprunt >= 0 then
								emprunts.item(nbr_emprunt).set_date_retour
								retour_media(emprunts.item(nbr_emprunt).get_id_media)
							end
							interface.continuer
						when "3" then
							if medias.count-1 > 0 then
								res := -1
								from
								until 
									res >= 0
								loop
									titre := interface.choix_commande("%N Titre du media à rechercher : ")
									res := rechercher_media_titre(titre,True)
									if res = -1 then
										io.put_string("Aucun media correspondant.%N")
									end
								end
							else
								io.put_string("Liste des médias vide.%N")
							end
						else
							io.put_string("Commande inconnue%N")
						end
					end
				else
					io.put_string("%N Identifiant inconnu.%N")
				end				
			end
			sauvegarde
		end


---------------------------------
--- SAUVEGARDE DES INFORMATIONS
---------------------------------
	sauvegarde is
	local
		file : TEXT_FILE_WRITE
		file_name_medias : STRING
		file_name_utilisateurs : STRING
		file_name_emprunts : STRING
		i,j,k : INTEGER
	do
		file_name_medias := "../ressources/medias.txt"
		file_name_utilisateurs := "../ressources/utilisateurs.txt"
		file_name_emprunts:= "../ressources/emprunts.txt"
		-- sauvegarde utilisateurs
		create file.connect_to(file_name_utilisateurs)
		if file.is_connected then
			from i := 0
			until i > utilisateurs.count - 1
			loop
				file.put_line(utilisateurs.item(i).sauvegarde)
				i := i + 1
			end
			
		else
			io.put_string("Echec sauvegarde utilisateurs.%N")
		end
		file.disconnect
		-- sauvegarde medias
		create file.connect_to(file_name_medias)
		if file.is_connected then
			from j := 0
			until j > medias.count - 1
			loop
				file.put_line(medias.item(j).sauvegarde)
				j := j + 1
			end
		else
			io.put_string("Echec sauvegarde medias.%N")
		end
		file.disconnect
		-- sauvegarde emprunts
		create file.connect_to(file_name_emprunts)
		if file.is_connected then
			from k := 0
			until k > emprunts.count - 1
			loop
				file.put_line(emprunts.item(k).sauvegarde)
				k := k + 1
			end
		else
			io.put_string("Echec sauvegarde emprunts.%N")
		end
		file.disconnect
	end
		
---------------------------------
--- LECTURE FICHIER UTILISATEURS
---------------------------------		
	lire_fichier_utilisateurs(flag : BOOLEAN) is
		local
			filereader: TEXT_FILE_READ
			i ,fin,debut, nb_occurence: INTEGER
			valeur: STRING
			nom, prenom, buffer ,identifiant, str_admin , str_actif: STRING
			admin , actif: BOOLEAN
			user: UTILISATEUR
		do
			create filereader.connect_to(filename_utilisateurs)		
			from 
			until filereader.end_of_input
			loop
				filereader.read_line
				buffer := filereader.last_string
				if not buffer.is_equal("") then
					admin := False -- init par défaut
					nom := ""
					prenom := ""
					identifiant := ""
					nb_occurence := buffer.occurrences(';')
					debut := 1
					from i := 1
					until i > nb_occurence+1
					loop
						i := i+1
						fin := buffer.index_of(';',debut)
						actif := True
						if (fin = 0) then
							fin := buffer.count
						end
						if (buffer.substring(debut,fin).has_substring("Nom")) then
							valeur := buffer.substring(debut,fin)
							nom := valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)
							debut := fin + 1
						end
						if (buffer.substring(debut,fin).has_substring("Prenom")) then
							valeur := buffer.substring(debut,fin)
							prenom := valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)
							debut := fin + 1
						end
						if (buffer.substring(debut,fin).has_substring("Identifiant")) then
							valeur := buffer.substring(debut,fin)
							identifiant := valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)
							debut := fin + 1
						end
						if (buffer.substring(debut,fin).has_substring("Admin")) then
							valeur := buffer.substring(debut,fin)
							str_admin := valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)
							if (str_admin.same_as("oui")) then
								admin := True
							else
								admin := False
							end
							debut := fin + 1
						end
						if (buffer.substring(debut,fin).has_substring("Actif")) then
							valeur := buffer.substring(debut,fin)
							str_actif := valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)
							if (str_actif.same_as("oui")) then
								actif := True
							else
								actif := False
							end
							debut := fin + 1
						end	
					end
					if (admin) then
						if actif then
							create user.make_admin(nom, prenom, identifiant, True)
						else
							create user.make_admin(nom, prenom, identifiant, False)
						end
					else
						if actif then
							create user.make_client(nom, prenom, identifiant, True)
						else
							create user.make_client(nom, prenom, identifiant, False)
						end
					end
					ajouter_utilisateur(user,flag)
				end
			end	
			filereader.disconnect
		end
		
---------------------------------
--- LECTURE FICHIER EMPRUNT
---------------------------------	
	lire_fichier_emprunts is
	local
		filereader: TEXT_FILE_READ
		i : INTEGER
		emprunt : EMPRUNT
		buffer, valeur , id_media , identifiant: STRING
		debut , fin, nb_occurence , duree_autorisee: INTEGER
		date_emprunt , date_retour : TIME
		annee_r,mois_r,jour_r,heure_r,minute_r,seconde_r : INTEGER
		annee_e,mois_e,jour_e,heure_e,minute_e,seconde_e : INTEGER
		test : BOOLEAN
	do
		create filereader.connect_to("../ressources/emprunts.txt")
		from 
		until filereader.end_of_input
		loop
			filereader.read_line		
			buffer := filereader.last_string
			nb_occurence := buffer.occurrences(';')
			debut := 1
			if not buffer.is_equal("") then
				from i := 0
				until i > nb_occurence
				loop
					i := i + 1
					fin := buffer.index_of(';',debut)
					if (fin = 0) then
						fin := buffer.count
					end
					if (buffer.substring(debut,fin).has_substring("id_media")) then
						valeur := buffer.substring(debut,fin)
						id_media := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1))
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("identifiant")) then
						valeur := buffer.substring(debut,fin)
						identifiant := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1))
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("duree_autorisee")) then
						valeur := buffer.substring(debut,fin)
						duree_autorisee := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("annee_r")) then
						valeur := buffer.substring(debut,fin)
						annee_r := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("mois_r")) then
						valeur := buffer.substring(debut,fin)
						mois_r := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("jour_r")) then
						valeur := buffer.substring(debut,fin)
						jour_r := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("minute_r")) then
						valeur := buffer.substring(debut,fin)
						minute_r := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("heure_r")) then
						valeur := buffer.substring(debut,fin)
						heure_r := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("seconde_r")) then
						valeur := buffer.substring(debut,fin)
						seconde_r := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					-- emprunt
					if (buffer.substring(debut,fin).has_substring("annee_e")) then
						valeur := buffer.substring(debut,fin)
						annee_e := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("mois_e")) then
						valeur := buffer.substring(debut,fin)
						mois_e := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("jour_e")) then
						valeur := buffer.substring(debut,fin)
						jour_e := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("minute_e")) then
						valeur := buffer.substring(debut,fin)
						minute_e := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("heure_e")) then
						valeur := buffer.substring(debut,fin)
						heure_e := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
					if (buffer.substring(debut,fin).has_substring("seconde_e")) then
						valeur := buffer.substring(debut,fin)
						seconde_e := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
						debut := fin + 1				
					end
				end
				test := date_emprunt.set(annee_e,mois_e,jour_e,heure_e,minute_e,seconde_e)
				test := date_retour.set(annee_r,mois_r,jour_r,heure_r,minute_r,seconde_r)
				create emprunt.make_emprunt(id_media,identifiant,duree_autorisee)
				emprunt.set_date_emprunt(date_emprunt)
				emprunt.set_dat_retour(date_retour)
				emprunts.add_last(emprunt)
			end
		end
		filereader.disconnect
	end
	
---------------------------------
--- LECTURE FICHIER MEDIA
---------------------------------	
	lire_fichier_medias(flag : BOOLEAN) is
	local
		filereader: TEXT_FILE_READ
		i,nombre, annee, var_dvd, var_livre : INTEGER
		liste_realisateur : ARRAY[STRING]
		liste_acteur : ARRAY[STRING]
		buffer, valeur ,titre, type, auteur: STRING
		debut , fin, nb_occurence : INTEGER
		dvd : DVD
		livre : LIVRE
	do
		create filereader.connect_to(filename_medias)
		from 
		until filereader.end_of_input
		loop
			filereader.read_line
			create liste_realisateur.with_capacity(0, 0)		
			create liste_acteur.with_capacity(0, 0)
			buffer := filereader.last_string
			nb_occurence := buffer.occurrences(';')
			debut := 1
			nombre := 1
			from i := 0
			until i > nb_occurence
			loop
				i := i + 1
				fin := buffer.index_of(';',debut)
				if (fin = 0) then
					fin := buffer.count
				end
				if (buffer.substring(debut,fin).has_substring("DVD")) then
					var_dvd := 1
					debut := fin + 1
				end
				if (buffer.substring(debut,fin).has_substring("Livre")) then
					var_livre := 1
					debut := fin + 1
				end
				if (buffer.substring(debut,fin).has_substring("Acteur")) then
					valeur := buffer.substring(debut,fin)
					liste_acteur.add_last(valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1))
					debut := fin + 1				
				end
				if (buffer.substring(debut,fin).has_substring("Auteur")) then
					valeur := buffer.substring(debut,fin)
					auteur := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1))
					debut := fin + 1				
				end
				if (buffer.substring(debut,fin).has_substring("Realisateur")) then
					valeur := buffer.substring(debut,fin)
					liste_realisateur.add_last(valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1))
					debut := fin + 1				
				end
				if (buffer.substring(debut,fin).has_substring("Annee")) then
					valeur := buffer.substring(debut,fin)
					annee := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
					debut := fin + 1				
				end
				if (buffer.substring(debut,fin).has_substring("Titre")) then
					valeur := buffer.substring(debut,fin)
					titre := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1))
					debut := fin + 1				
				end
				if (buffer.substring(debut,fin).has_substring("Type")) then
					valeur := buffer.substring(debut,fin)
					type := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1))
					debut := fin + 1				
				end
				if (buffer.substring(debut,fin).has_substring("Nombre")) then
					valeur := buffer.substring(debut,fin)
					nombre := (valeur.substring(valeur.first_index_of('<')+1, valeur.first_index_of('>')-1)).to_integer
					debut := fin + 1				
				end
			end
			if ( var_dvd = 1) then
				
				var_dvd := 0
				create dvd.make_dvd(titre,annee,liste_realisateur,liste_acteur,type,nombre)
				ajouter_dvd(dvd, flag)
				titre := ""
				annee :=0
				type := ""
				nombre := 1
			end
			if ( var_livre = 1 ) then
				var_livre := 0
				create livre.make_livre(titre,auteur,nombre)
				ajouter_livre(livre,flag)
				auteur := ""
			end
		end
		filereader.disconnect
	end

---------------------------------
--- AJOUTER UN DVD
---------------------------------		
	ajouter_dvd(dvd : DVD; flag : BOOLEAN) is
	local
		indice : INTEGER
	do
		indice := verification_dvd(dvd)
		if (indice = -1) then
			medias.add_last(dvd)
			if flag then
				io.put_string(" Dvd créé.%N")
			end
		else
			medias.item(indice).set_nombre(dvd.nombre)
			if flag then
				io.put_string(" Dvd existant. Augmentation du nombre disponible.%N")
			end
		end
	end	

---------------------------------
--- AJOUTER UN LIVRE
---------------------------------		
	ajouter_livre(livre : LIVRE ; flag : BOOLEAN) is
	local
		indice : INTEGER
	do
		indice := verification_livre(livre)
		if (indice = -1) then
			medias.add_last(livre)
			if flag then
				io.put_string(" Livre créé.%N")
			end
		else
			medias.item(indice).set_nombre(livre.nombre)
			if flag then
				io.put_string(" Livre existant. Augmentation du nombre disponible.%N")
			end
		end
	end	

	
---------------------------------
--- AJOUTER UN UTILISATEUR
---------------------------------		
	ajouter_utilisateur(utilisateur : UTILISATEUR ; flag : BOOLEAN) is
	do
		if not (verification_utilisateur(utilisateur)) then
			utilisateurs.add_last(utilisateur)
			if flag then
				io.put_string("Utilisateur ajouté.%N")
			end
		else
			if utilisateur.est_actif then
				if flag then
					io.put_string(" Utilisateur existant.%N")
				end
			else
				utilisateur.active
				if flag then
					io.put_string(" Réactivation utilisateur.%N")
				end
			end
		end
	end	

	
---------------------------------
--- VERIFICATION DOUBLON DVD
---------------------------------		
	verification_dvd(dvd : DVD) : INTEGER is
	local 
		i : INTEGER
		m : DVD
		test, stop: BOOLEAN
	do
		stop := False
		test := False
		from i := 0
		until stop = True or i > medias.count-1
		loop
			if ({DVD}?:= medias@i) then
				m ::= medias@i
				test := m.compare(dvd)
				if (test) then
					stop := True
				end
			end
			i := i + 1
		end
		if stop = False then
			i := -1
		else
			i := i - 1
		end
		Result := i
	end	

---------------------------------
--- VERIFICATION DOUBLON LIVRE
---------------------------------		
	verification_livre(livre : LIVRE) : INTEGER is
	local 
		i : INTEGER
		m : LIVRE
		test, stop: BOOLEAN
	do
		stop := False
		test := False
		from i := 0
		until stop = True or i > medias.count-1
		loop
			if ({LIVRE}?:= medias@i) then
				m ::= medias@i
				test := m.compare(livre)
				if (test) then
					stop := True
				end
			end
			i := i + 1
		end
		if stop = False then
			i := -1
		else
			i := i - 1
		end
		Result := i
	end	

---------------------------------
--- VERIFICATION DOUBLON UTILISATEUR
---------------------------------		
	verification_utilisateur(utilisateur : UTILISATEUR) : BOOLEAN is
	local 
		i : INTEGER
		test: BOOLEAN
	do
		test := False
		from i := 0
		until test = True or i > utilisateurs.count-1
		loop
			test := utilisateurs.item(i).compare(utilisateur)
			i := i + 1
		end
		Result := test
	end	
	
---------------------------------
--- AFFICHAGE DES UTILISATEURS
---------------------------------		
	afficher_utilisateurs is
	local 
		i,j : INTEGER
	do
		j := 0
		if utilisateurs.count -1 >= 0 then
			io.put_new_line
			from i := 0
			until i > utilisateurs.count-1
			loop
				if utilisateurs.item(i).est_actif then
					io.put_integer(j+1)
					io.put_string(":"+utilisateurs.item(i).afficher)
					io.put_new_line
					j := j + 1 
				end
				i := i+1
			end
			io.put_new_line
		else
			io.put_string("Liste des utilisateurs vide. %N")
		end
	end
	
---------------------------------
--- AFFICHAGE DES MEDIA
---------------------------------		
	afficher_medias is
	local 
		i , j : INTEGER
	do
		if medias.count -1 >= 0 then
			io.put_new_line
			io.put_string("Affichage des médias %N")
			j := 0
			from i := 0
			until i > medias.count-1
			loop
				if medias.item(j).get_nombre_exemplaire > 0 then
					io.put_integer(j+1)
					io.put_string(":"+medias.item(i).afficher)
					j := j + 1
				end
				i := i+1
				io.put_new_line
			end
			io.put_new_line
		else
			io.put_string("Liste des médias vide. %N")
		end
		
	end

---------------------------------
--- renvoie true si le compte correspondant a l'identifiant est actuf
---------------------------------	
	est_actif(identifiant : STRING) : BOOLEAN is
	local
		i : INTEGER
		test : BOOLEAN
	do
		test := False
		from i := 0
		until i > utilisateurs.count-1 or test
		loop
			if utilisateurs.item(i).get_identifiant.is_equal(identifiant) and utilisateurs.item(i).est_actif then
				test := True
			end
			i := i+1
		end
		Result := test
	end
	
---------------------------------
--- IDENTIFIANT EXISTE
---------------------------------		
	identifiant_existe(id : STRING) : BOOLEAN is
	local 
		i : INTEGER
		test : BOOLEAN
	do
		test := False
		from i := 0
		until i > utilisateurs.count-1 or test
		loop
			if utilisateurs.item(i).get_identifiant.is_equal(id) then
				test := True
			end
			i := i+1
		end
		Result := test
	end
	
---------------------------------
--- RECHERCHER UN MEDIA PAR TITRE
---------------------------------		
	rechercher_media_titre(titre : STRING ; flag : BOOLEAN) : INTEGER is
	local 
		i , j: INTEGER
		test : BOOLEAN
		tab : ARRAY[INTEGER]
		command : STRING
	do
		test := False
		create tab.with_capacity(0, 0)
		j:=0
		from i := 0
		until i > medias.count-1
		loop
			if medias.item(i).get_titre.as_lower.has_substring(titre.as_lower)  then
				if flag then
					if medias.item(i).get_nombre_exemplaire > 0 and medias.item(i).get_nombre > 0  then
						io.put_integer(j+1)
						io.put_string(" : " + medias.item(i).afficher)
						tab.add_last(i)
						io.put_new_line
						j := j + 1
					end
				else
					io.put_integer(j+1)
					io.put_string(" : " + medias.item(i).afficher)
					tab.add_last(i)
					io.put_new_line
					j := j + 1
				end
			end
			i := i+1
		end
		from 
		until test or tab.count-1 = -1
		loop	
			command := interface.choix_commande("Media à selectionner : ")
			from 
			until 
				command.is_integer
			loop
				command := interface.choix_commande("Media à selectionner : ")
			end
			if command.to_integer-1 > -1 and command.to_integer-1 <= tab.count-1 then
				test := True
			end
		end
		if tab.count-1 = -1 then
			Result := -1
		else
			Result := tab.item(command.to_integer - 1)
		end
	end


---------------------------------
--- RETOUR D'UN MEDIA
---------------------------------			
	retour_media(id_media : STRING) is
	local
		i : INTEGER
	do
		from i :=0
		until i > medias.count-1
		loop
			if medias.item(i).get_identifiant.is_equal(id_media) then
				medias.item(i).rendre
			end
			i := i+1
		end
	end

---------------------------------
--- RECUPERATION LISTE EMPRUNT
---------------------------------		
	liste_emprunt is
	local
		i : INTEGER
	do
		if emprunts.count-1 >= 0 then
			from i:=0
			until
				i > emprunts.count-1
			loop
				if emprunts.item(i).get_date_retour.hash_code = 0 then
					
					io.put_string( emprunts.item(i).afficher)
					io.put_new_line
				end
				i := i + 1
			end
		else
			io.put_string("Liste des emprunts vide.%N")
		end
	end
	
---------------------------------
--- RECUPERATION LISTE RETARD
---------------------------------		
	consulter_retard is
	local
		i : INTEGER
		date_emprunt , aujourdhui: TIME
	do
		aujourdhui.update
		if emprunts.count-1 >= 0 then
			from i:=0
			until
				i > emprunts.count-1
			loop
				date_emprunt := emprunts.item(i).get_date_emprunt
				date_emprunt.add_second(emprunts.item(i).get_duree_autorisee)
				if date_emprunt < aujourdhui then
					io.put_string(emprunts.item(i).afficher)
					io.put_new_line
				end
				i := i + 1
			end
		else
			io.put_string("Liste des emprunts vide.%N")
		end
	end	
	
---------------------------------
--- GET LISTE EMPRUNT
---------------------------------		
	get_liste_emprunt(identifiant : STRING) : INTEGER is
	local
		i , j: INTEGER
		test : BOOLEAN
		command , res: STRING
		tab : ARRAY[INTEGER]
	do
		test := False
		create tab.with_capacity(0, 0)
		j:=0
		from i := 0
		until i > emprunts.count-1
		loop
			res := emprunts.item(i).get_identifiant
			if res.is_equal(identifiant) and emprunts.item(i).get_date_retour.hash_code = 0 then
				io.put_integer(j+1)
				io.put_string(" : " + emprunts.item(i).afficher)
				tab.add_last(i)
				io.put_new_line
				j := j + 1
			end
			i := i+1
		end
		from 
		until test or tab.count-1 = -1
		loop	
			command := interface.choix_commande("Emprunt à selectionner : ")
			from 
			until 
				command.is_integer
			loop
				command := interface.choix_commande("Emprunt à selectionner : ")
			end
			
			if command.to_integer-1 > -1 and command.to_integer-1 <= tab.count-1 then
				test := True
			end
		end
		if tab.count-1 = -1 then
			Result := -1
		else
			Result := tab.item(command.to_integer - 1)
		end
	end


---------------------------------
--- RECHERCHER EMPRUNT POUR UN UTILISATEUR
---------------------------------	
	rechercher_emprunt(identifiant : STRING) : INTEGER is
	local
		res : INTEGER
	do
		res := -2
		if emprunts.count-1 >= 0 then
			from
			until 
				res >= -1
			loop
				res := get_liste_emprunt(identifiant)
				if res = -1 then
					io.put_string("Aucun emprunt pour cet identifiant.")
					Result := res
				end
			end
			io.put_new_line
		else
			io.put_string("Liste des emprunts vide.%N")
		end
		Result := res
	end



---------------------------------
--- RECHERCHER MEDIA
---------------------------------	
	rechercher_media : INTEGER is
	local
		res : INTEGER
		titre : STRING
	do
		res := -1
		titre := ""
		if medias.count-1 >= 0 then
			from
			until 
				res >= 0 or titre.is_equal("0")
			loop
				titre := interface.choix_commande("%N Titre du media à rechercher : ")
				if not titre.is_equal("0") then
					res := rechercher_media_titre(titre, True)
				end
				if res = -1 then
					io.put_string("Aucun media correspondant. 0 pour annuler la recherche")
				end
				io.put_new_line
			end
		else
			io.put_string("Liste des médias vide.%N")
		end
		Result := res
	end

---------------------------------
--- retourne vrai si un media est emprunter
---------------------------------		
	est_emprunter(identifiant : STRING): BOOLEAN is
	local
		res : BOOLEAN
		i : INTEGER
	do
		res := False
		if emprunts.count-1 >= 0 then
			from i:= 0
			until
				i > emprunts.count-1
			loop
				if emprunts.item(i).get_id_media.is_equal(identifiant) and emprunts.item(i).get_date_retour.hash_code = 0 then
					res := True
				end
				i := i+1
			end
		end			
		Result := res
	end

---------------------------------
--- SUPPRIMER MEDIA
---------------------------------	
	supprimer_media : BOOLEAN is
	local
		bol : BOOLEAN
		res : INTEGER
		titre : STRING
	do
		res := -1
		bol := False
		if medias.count-1 >= 0 then
			from
			until
				res >= 0
			loop		
				titre := interface.choix_commande("%N Titre du media à rechercher : ")
				res := rechercher_media_titre(titre,True)
				if res = -1 then
					io.put_string("Aucun media correspondant")
				else
					if not (est_emprunter(medias.item(res).get_identifiant)) then
						medias.item(res).supprimer
						bol := True
					end
				end
			end
		else
			io.put_string("Liste des médias vide.%N")
		end
		Result := bol		
	end

---------------------------------
--- retourne vrai si un utilisateur a des emprunts en cours
---------------------------------		
	a_des_emprunts(identifiant : STRING): BOOLEAN is
	local
		res : BOOLEAN
		i : INTEGER
	do
		res := False
		if emprunts.count-1 >= 0 then
			from i:= 0
			until
				i > emprunts.count-1
			loop
				if emprunts.item(i).get_identifiant.is_equal(identifiant) and emprunts.item(i).get_date_retour.hash_code = 0 then
					res := True
				end
				i := i+1
			end
		end			
		Result := res
	end

---------------------------------
--- SUPPRIMER UTILISATEUR
---------------------------------	
	supprimer_utilisateur : BOOLEAN is
	local
		identifiant : STRING
		res : INTEGER
		bol : BOOLEAN
		i : INTEGER
	do
		bol := False
		res := -1
		if utilisateurs.count-1 >= 0 then
			from
			until
				res >= 0
			loop		
				identifiant := interface.choix_commande("%N Identifiant de l'utilisateur à rechercher : ")
				from i := 0
				until
					i > utilisateurs.count-1
				loop
					if utilisateurs.item(i).get_identifiant.is_equal(identifiant) then
						res := 0
						if a_des_emprunts(identifiant) then
							io.put_string("%N Suppression impossible car l'utilisateur a des emprunts en cours.%N")
						else
							if utilisateurs.item(i).est_actif then
								utilisateurs.item(i).desactive
								io.put_string("%N Utilisateur supprimé. %N")
								bol := True
							else
								io.put_string("%N Utilisateur déja désactivé. %N")
							end
						end
					end
					i := i + 1 
				end
				if res = -1 then
					res := 1
					io.put_string("Identifiant inconnu.%N")
				end
			end
		else
			io.put_string("Liste des utilisateurs vide.%N")
		end
		Result := bol		
	end

	modifier_duree_autorisee is
	local
		duree : STRING
		res : INTEGER
	do
		res := -1
		from
		until
			res >= 0
		loop	
			duree := interface.choix_commande("%N Nouvelle durée d'emprunt autorisée pour les médias : ")
			if duree.is_integer then
				if duree.to_integer > 0 then
					res := 0
					prm_duree_autorisee := duree.to_integer
					io.put_string("Durée modifée.%N")
				else
					io.put_string("Durée doit être supérieur à 0.%N")
				end
			end
		end
	end

	modifier_statut is
	local
		i ,res : INTEGER
		identifiant : STRING
	do
		res := -1
		from
		until
			res >= 0
		loop		
			identifiant := interface.choix_commande("%N Identifiant de l'utilisateur à modifier : ")
			from i := 0
			until
				i > utilisateurs.count-1
			loop
				if utilisateurs.item(i).get_identifiant.is_equal(identifiant) and  utilisateurs.item(i).est_actif then
					res := 0
					utilisateurs.item(i).modifier_statut
					io.put_string("Statut modifier.%N")
				end
				i := i + 1 
			end
			if res = -1 then
				res := 1
				io.put_string("Identifiant inconnu.%N")
			end
		end
	end
---------------------------------
--- Fonctions utiles
---------------------------------
	est_vide(valeur : STRING) : BOOLEAN is
	do
		valeur.left_adjust
		valeur.right_adjust
		Result := valeur.is_empty
	end
end
