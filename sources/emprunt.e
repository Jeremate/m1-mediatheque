class EMPRUNT

creation {ANY}
	make_emprunt

feature {ANY}
	id_media : STRING
	identifiant : STRING
	date_emprunt, date_retour : TIME
	duree_autorisee : INTEGER
	
feature {ANY}

	make_emprunt(id_media_e : STRING; identifiant_e : STRING ; duree_autorisee_e : INTEGER ) is
	do
		id_media := id_media_e
		identifiant := identifiant_e
		date_emprunt.update
		duree_autorisee := duree_autorisee_e
	end
	
	get_duree_autorisee :  INTEGER is
	do
		Result := duree_autorisee
	end
	
	sauvegarde : STRING is
	do
		Result := "id_media<"+id_media+"> ; identifiant<"+identifiant+" ; "
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
