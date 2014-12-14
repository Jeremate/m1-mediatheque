class EMPRUNT

creation {ANY}
	make_emprunt

feature {ANY}
	id_media : STRING
	identifiant : STRING
	date_emprunt, date_retour : INTEGER
	
feature {ANY}

	make_emprunt(id_media_e : STRING; identifiant_e : STRING ) is
	local
		temps : TIME
	do
		temps.update
		id_media := id_media_e
		identifiant := identifiant_e
		date_emprunt := temps.year*10000+temps.month*100+temps.day
		date_retour := 99999999
	end
	
	get_identifiant : STRING is
	do
		Result := identifiant
	end
	
	afficher : STRING is
	do
		Result := id_media + " " +identifiant
	end
	
	get_date_retour : INTEGER is
	do
		Result := date_retour
	end
	
	set_date_retour is
	local
		temps : TIME
	do
		temps.update
		date_retour := temps.year*10000+temps.month*100+temps.day
	end
	
	get_id_media : STRING is
	do
		Result := id_media
	end
end 
