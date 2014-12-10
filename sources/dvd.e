class DVD inherit MEDIA
redefine 
	afficher
end

creation {ANY}
	make_dvd


feature {MEDIATHEQUE}
	annee: INTEGER
	liste_realisateur: ARRAY[STRING]
	liste_acteur: ARRAY[STRING]
	type: STRING
	
feature {ANY}
	make_dvd(titre_d: STRING, annee_d: INTEGER ,liste_realisateur_d: ARRAY[STRING] ,liste_acteur_d: ARRAY[STRING] ,type_d: STRING, nombre_d : INTEGER) is
		do
			titre := titre_d
			nombre := nombre_d
			annee := annee_d
			liste_realisateur := liste_realisateur_d
			liste_acteur := liste_acteur_d
			type := type_d
		end
	afficher : STRING is
	do
		Result := Precursor + " " + annee.to_string + " " + type
	end
end 