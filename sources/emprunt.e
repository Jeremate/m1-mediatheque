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
	
	affichage_historique : STRING is
	do
		Result := id_media + " emprunté le " + date_emprunt.day.to_string+"/"+date_emprunt.month.to_string+"/"+date_emprunt.year.to_string
	end
	
	sauvegarde : STRING is
	local
		res : STRING
	do
		res := "id_media<"+id_media +"> ; identifiant<"+identifiant+"> ; duree_autorisee<"+duree_autorisee.to_string+"> "
		res := res + "; annee_e<" + date_emprunt.year.to_string+"> ; mois_e<"+date_emprunt.month.to_string+"> ; jour_e<"+date_emprunt.day.to_string+"> ; heure_e<"+date_emprunt.hour.to_string+"> ; minute_e<"+date_emprunt.minute.to_string+"> ; seconde_e<"+date_emprunt.second.to_string+"> "
		res := res + "; annee_r<" + date_retour.year.to_string+"> ; mois_r<"+date_retour.month.to_string+"> ; jour_r<"+date_retour.day.to_string+"> ; heure_r<"+date_retour.hour.to_string+"> ; minute_r<"+date_retour.minute.to_string+"> ; seconde_r<"+date_retour.second.to_string+"> "
		Result := res
	end
	
	get_identifiant : STRING is
	do
		Result := identifiant
	end
	
	afficher : STRING is
	do
		Result := id_media + " emprunté par " + identifiant
	end
	
	get_date_retour : TIME is
	do
		Result := date_retour
	end
	
	get_date_emprunt : TIME is
	do
		Result := date_emprunt
	end
	
	set_date_emprunt(date : TIME) is
	do
		date_emprunt := date
	end
	
	set_dat_retour(date : TIME) is
	do
		date_retour := date
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
