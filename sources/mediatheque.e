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
	
feature
	
	make is
		local
			stop, retour,admin , user : BOOLEAN
			command : STRING
			utilisateur : UTILISATEUR
			livre : LIVRE
			dvd :  DVD
			nom, prenom, identifiant, new_admin : STRING
			temps : TIME
			nombre_livre, nombre_dvd ,res : INTEGER
			auteur , titre ,nbr_str_livre, nbr_str_dvd, realisateur, acteur, annee_dvd: STRING
			liste_acteur , liste_realisateur : ARRAY[STRING]
			annee ,i: INTEGER
			type : STRING
			
		do
			-- Initialisation
			create utilisateurs.with_capacity(0,0)
			create medias.with_capacity(0,0)
			create emprunts.with_capacity(0,0)
			
			create filename_utilisateurs.make_from_string("../ressources/utilisateurs.txt")
			create filename_medias.make_from_string("../ressources/medias.txt")
			create interface.make
			interface.accueil
			temps.update
			lire_fichier_utilisateurs
			--io.put_integer(temps.year*10000+temps.month*100+temps.day)
			from 
				
			until
				stop
			loop
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
					if utilisateurs.item(i).str_admin(command) then
						admin := True
					elseif utilisateurs.item(i).str_user(command) then
						user := True
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
						command := interface.choix_commande("%N Entrer votre choix (retour): ")
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
								command := interface.choix_commande("%N Entrer votre choix (retour): ")
								inspect
									command
								when "r", "R", "retour" then
									retour := True
								when "1" then
									afficher_utilisateurs
								when "2" then
									lire_fichier_utilisateurs
								when "3" then
									nom := interface.choix_commande("%N  Nom de l'utilisateur : ")
									prenom := interface.choix_commande("%N Prenom de l'utilisateur : ")
									identifiant := interface.choix_commande("%N Identifiant de l'utilisateur : ")
									new_admin := ""
									from
									until
										new_admin.is_equal("1") or new_admin.is_equal("0")
									loop
										new_admin := interface.choix_commande("Grade(1 pour admin, 0 sinon)")
										inspect 
											new_admin
										when "1" then
											create utilisateur.make_admin(nom,prenom,identifiant)
										when "0" then
											create utilisateur.make_client(nom,prenom,identifiant)
										else
											io.put_string("Commande inconnue%N")
										end
										ajouter_utilisateur(utilisateur)
									end
								when "4" then
									io.put_string("%N En cours de devellopement%N")
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
								command := interface.choix_commande("%N Entrer votre choix (retour): ")
								inspect
									command
								when "r", "R", "retour" then
									retour := True
								when "1" then
									afficher_medias
								when "2" then
									lire_fichier_medias
								when "3" then
									from
									until
										retour
									loop
										interface.menu_choix_media
										command := interface.choix_commande("%N Entrer votre choix (retour): ")
										inspect
											command
										when "r", "R", "retour" then
											retour := True
										when "1" then
											create liste_realisateur.with_capacity(0, 0)		
											create liste_acteur.with_capacity(0, 0)
											titre := interface.choix_commande("%N Titre du dvd : ")
											realisateur := interface.choix_commande("%N Réalistaeur (1 pour stop) : ")
											from 
											until
												realisateur.is_equal("1") and liste_realisateur.count >= 1
											loop
												realisateur := interface.choix_commande("%N Réalistaeur (1 pour stop) : ")
												liste_realisateur.add_last(realisateur)
											end
											acteur := interface.choix_commande("%N Acteur (1 pour stop) : ")
											from 
											until
												acteur.is_equal("1") and liste_acteur.count >= 1
											loop
												acteur := interface.choix_commande("%N Acteur (1 pour stop) : ")
												liste_acteur.add_last(acteur)
											end
											type := interface.choix_commande("%N Type du dvd (coffret) : ")
											nbr_str_dvd := interface.choix_commande("%N Nombre d'exemplaire du dvd : ")
											from 
											until
												nbr_str_dvd.is_integer
											loop
												nbr_str_dvd := interface.choix_commande("%N Nombre d'exemplaire du livre : ")
											end
											nombre_dvd := nbr_str_dvd.to_integer
											annee_dvd := interface.choix_commande("%N Année dvd : ")
											from 
											until
												annee_dvd.is_integer
											loop
												annee_dvd := interface.choix_commande("Nombre d'exemplaire du livre : ")
											end
											annee := nbr_str_dvd.to_integer
											create dvd.make_dvd(titre,annee, liste_realisateur,liste_acteur,type,nombre_dvd)
											ajouter_dvd(dvd)
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
											ajouter_livre(livre)
										else
											io.put_string("Commande inconnue%N")
										end
										io.put_boolean(retour)
										if not retour then
											interface.continuer
										end
									end
								when "4" then 
									io.put_string("%N En cours de devellopement%N")
								when "5" then
									if medias.count-1 > 0 then
										res := 0
										from
										until 
											res > 0
										loop
											titre := interface.choix_commande("%N Titre du media à rechercher : ")
											res := rechercher_media_titre(titre)
											if res = 0 then
												io.put_string("Aucun media correspondant")
											end
										end
										io.put_integer(res)
										io.put_new_line
									else
										io.put_string("Liste des médias vide")
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
								command := interface.choix_commande("%N Entrer votre choix (retour):")
								inspect
									command
								when "r", "R", "retour" then
									retour := True
								when "1" then
									io.put_string("%N En cours de devellopement%N")
								when "2" then
									io.put_string("%N En cours de devellopement%N")
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
						interface.call_menu
						command := interface.choix_commande("%N Entrer votre choix (retour):")
						inspect
							command
						when "r", "R", "retour" then
							retour := True
						else
							io.put_string("Commande inconnue%N")
						end
					end
				
				else
					io.put_string("%N Identifiant inconnu%N")
				end				
			end
		end
		
---------------------------------
--- LECTURE FICHIER UTILISATEURS
---------------------------------		
	lire_fichier_utilisateurs is
		local
			filereader: TEXT_FILE_READ
			cle_val: ARRAY[STRING]
			i : INTEGER
			cle, val: STRING
			nom, prenom, identifiant: STRING
			admin: BOOLEAN
			user: UTILISATEUR
		do
			create filereader.connect_to(filename_utilisateurs)
			create cle_val.with_capacity(0, 0)
			
			from 
			until filereader.end_of_input
			loop
				filereader.read_line
				cle_val.copy(filereader.last_string.split)
				admin := False -- init par défaut
				nom := ""
				prenom := ""
				identifiant := ""
				cle := ""
				val := ""	
				from i := 1
				until i > cle_val.count
				loop
					cle.copy(cle_val.item(i).substring(1, cle_val.item(i).first_index_of('<')-1))
					val.copy(cle_val.item(i).substring(cle_val.item(i).first_index_of('<')+1, cle_val.item(i).first_index_of('>')-1))
					
					inspect cle
						when "Nom" then 
							nom.copy(val)						
						when "Prenom" then
							prenom.copy(val)	
						when "Identifiant" then
							identifiant.copy(val)						
						when "Admin" then 
							if (val.same_as("oui")) then
								admin := True
							else
								admin := False
							end
					end
					
					i := i+2 -- évite les ;
				end
				if (admin) then
					create user.make_admin(nom, prenom, identifiant)
				else
					create user.make_client(nom, prenom, identifiant)
				end
				ajouter_utilisateur(user)
			end	
			filereader.disconnect
		end
	
---------------------------------
--- LECTURE FICHIER MEDIA
---------------------------------	
	lire_fichier_medias is
	local
		filereader: TEXT_FILE_READ
		i,nombre, annee, var_dvd, var_livre : INTEGER
		liste_realisateur : ARRAY[STRING]
		liste_acteur : ARRAY[STRING]
		buffer valeur ,titre, type, auteur: STRING
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
				ajouter_dvd(dvd)
				titre := ""
				annee :=0
				type := ""
				nombre := 1
			end
			if ( var_livre = 1 ) then
				var_livre := 0
				create livre.make_livre(titre,auteur,nombre)
				ajouter_livre(livre)
				auteur := ""
			end
		end
	end

---------------------------------
--- AJOUTER UN DVD
---------------------------------		
	ajouter_dvd(dvd : DVD) is
	local
		indice : INTEGER
	do
		indice := verification_dvd(dvd)
		if (indice = -1) then
			medias.add_last(dvd)
			io.put_string(" Dvd crée.%N")
		else
			medias.item(indice).set_nombre(dvd.nombre)
			io.put_string(" Dvd existant. Augmentation du nombre disponible.%N")
		end
	end	

---------------------------------
--- AJOUTER UN LIVRE
---------------------------------		
	ajouter_livre(livre : LIVRE) is
	local
		indice : INTEGER
	do
		indice := verification_livre(livre)
		if (indice = -1) then
			medias.add_last(livre)
			io.put_string(" Livre crée.%N")
		else
			medias.item(indice).set_nombre(livre.nombre)
			io.put_string(" Livre crée. Augmentation du nombre disponible.%%N")
		end
	end	

	
---------------------------------
--- AJOUTER UN UTILISATEUR
---------------------------------		
	ajouter_utilisateur(utilisateur : UTILISATEUR) is
	do
		if not (verification_utilisateur(utilisateur)) then
			utilisateurs.add_last(utilisateur)
			io.put_string("Utilisateur ajouté.%N")
		else
			io.put_string(" Utilisateur existant.%N")
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
		i : INTEGER
	do
		io.put_new_line
		from i := 0
		until i > utilisateurs.count-1
		loop
			io.put_integer(i+1)
			io.put_string(":"+utilisateurs.item(i).afficher)
			i := i+1
			io.put_new_line
		end
		io.put_new_line
	end
	
---------------------------------
--- AFFICHAGE DES MEDIA
---------------------------------		
	afficher_medias is
	local 
		i : INTEGER
	do
		io.put_new_line
		io.put_string("Affichage des médias %N")
		from i := 0
		until i > medias.count-1
		loop
			io.put_integer(i+1)
			io.put_string(":"+medias.item(i).afficher)
			i := i+1
			io.put_new_line
		end
		io.put_new_line
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
	rechercher_media_titre(titre : STRING) : INTEGER is
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
			if medias.item(i).get_titre.has_substring(titre) then
				io.put_integer(j+1)
				io.put_string(" : " + medias.item(i).afficher)
				tab.add_last(i)
				io.put_new_line
				j := j + 1
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
			Result := 0
		else
			Result := tab.item(command.to_integer - 1)
		end
	end
	
end
