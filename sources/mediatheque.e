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
		else
			medias.item(indice).set_nombre(dvd.nombre)
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
		else
			medias.item(indice).set_nombre(livre.nombre)
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
--- VERIFICATION DOUBLON LIVE
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
end
