class EMPRUNT

creation {ANY}
	make_emprunt

feature {ANY}
	id_media : STRING
	identifiant : STRING
	date_emprunt, date_retour : TIME
	dureeAutorisee : INTEGER
	
feature {ANY}

	make_emprunt(id_media_e : STRING; identifiant_e : STRING ) is
	do
		id_media := id_media_e
		identifiant := identifiant_e
		date_emprunt.update
		dureeAutorisee := 15
	end
	
	get_dureeAutorisee :  INTEGER is
	do
		Result := dureeAutorisee
	end
	
	get_identifiant : STRING is
	do
		Result := identifiant
	end
	
	afficher : STRING is
	do
		Result := id_media + " " +identifiant
	end
	
	get_date_retour : TIME is
	do
		Result := date_retour
	end
	
	set_date_retour is
	do
		date_retour.update
	end
	
	get_id_media : STRING is
	do
		Result := id_media
	end
end 
