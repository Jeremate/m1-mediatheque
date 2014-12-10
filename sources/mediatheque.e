class MEDIATHEQUE

creation {ANY}
	make

feature {ANY}
	medias: ARRAY[MEDIA] -- liste des medias
	utilisateurs: ARRAY[UTILISATEUR] -- liste des utilisateurs
	filename_utilisateurs: STRING -- chemin vers le fichier utilisateurs
	filename_medias: STRING --chemin vers le fichier medias
	
	
feature
	
	make is 
		do
			-- Initialisation
			create utilisateurs.with_capacity(0,0)
			create medias.with_capacity(0, 0)
			
			create filename_utilisateurs.make_from_string("../ressources/utilisateurs.txt")
			create filename_medias.make_from_string("../ressources/medias.txt")
			--récupération utilisateurs
			lire_fichier_utilisateurs
			lire_fichier_medias
			--affiche_menu
			afficher_medias
			--afficher_utilisateurs
			
			--io.put_new_line
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
						when "Nom"
						then nom.copy(val)
						
						when "Prenom"
						then prenom.copy(val)
						
						when "Identifiant"
						then identifiant.copy(val)
						
						when "Admin"
						then 
							if(val = "OUI") then
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
				utilisateurs.add_last(user)
			end
			
			filereader.disconnect
		end
	
---------------------------------
--- LECTURE FICHIER MEDIA
---------------------------------	
	lire_fichier_medias is
	local
		filereader: TEXT_FILE_READ
		i,nombre, val, annee, var_dvd, var_livre : INTEGER
		liste_realisateur : ARRAY[STRING]
		liste_auteur : ARRAY[STRING]
		titre, type: STRING
		dvd : DVD
	do
		create filereader.connect_to(filename_medias)
		create liste_realisateur.with_capacity(0, 0)		
		create liste_auteur.with_capacity(0, 0)
		i := 1
		var_dvd := 0
		titre := ""
		nombre := 0
		annee := 0
		type := ""
		val := 99999
		from 
		until filereader.end_of_input
		loop
			--io.put_integer(i)
			if (var_dvd = 1 and i>val) then
				--io.put_string(titre)
				create dvd.make_dvd(titre, annee, liste_realisateur, liste_auteur, type, nombre)
				medias.add_last(dvd)
				var_dvd := 0
				titre := ""
				nombre := 0
				annee := 9999
				type := ""
				i := 0
				val := 99999
			end
			if (var_livre = 1 and i >1) then
				--create media.make(titre, annee, liste_realisateur, liste_auteur, type, nombre)
				var_livre := 0
				i := 0
			end
			filereader.read_word_using(";<>%R%N")
			--io.put_integer(i)
			--io.put_string(filereader.last_string)
			if (filereader.last_string.has_substring("DVD")) then
				--io.put_string("wow" + titre )
				var_dvd := 1
				val := i
			end
			if (filereader.last_string.has_substring("Livre")) then
				var_livre := 1
			end					
			if (filereader.last_string.has_substring("Realisateur")) then
				filereader.read_word_using(";<>%R%N")
				liste_realisateur.add_last(filereader.last_string)
			end
			if (filereader.last_string.has_substring("Nombre")) then
				filereader.read_word_using(";<>%R%N")
				nombre := filereader.last_string.to_integer
			end
			if (filereader.last_string.has_substring("Titre")) then
				filereader.read_word_using(";<>%R%N")
				titre.copy(filereader.last_string)
			end
			if (filereader.last_string.has_substring("Annee")) then
				filereader.read_word_using(";<>%R%N")
				annee := filereader.last_string.to_integer
			end
			if (filereader.last_string.has_substring("Acteur")) then
				filereader.read_word_using(";<>%R%N")
				liste_auteur.add_last(filereader.last_string)
			end
			if (filereader.last_string.has_substring("Type")) then
				filereader.read_word_using(";<>%R%N")
				type.copy(filereader.last_string)
			end
			--io.put_new_line
			i := i +1 

		end
		--io.put_integer(i)
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
end
