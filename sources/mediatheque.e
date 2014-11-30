class MEDIATHEQUE

creation {ANY}
	make

feature {ANY}
	--medias: ARRAY[MEDIA] -- liste des medias
	utilisateurs: ARRAY[UTILISATEUR] -- liste des utilisateurs
	filename_utilisateurs: STRING -- chemin vers le fichier utilisateurs
	
	
feature
	
	make is 
		do
			-- Initialisation
			create utilisateurs.with_capacity(0,0)
			--create medias.with_capacity(0, 0)
			
			create filename_utilisateurs.make_from_string("../ressources/utilisateurs.txt")
			lire_fichier_utilisateurs
			--affiche_menu
			afficher_utilisateurs
			
			io.put_new_line
		end
		
	
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
				if(admin) then
					create user.make_admin(nom, prenom, identifiant)
				else
					create user.make_client(nom, prenom, identifiant)
				end
				utilisateurs.add_last(user)
			end
			
			filereader.disconnect
		end
	
	
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
end
