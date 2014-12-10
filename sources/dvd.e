class DVD inherit MEDIA
redefine 
	afficher
end

creation {ANY}
	make_dvd

feature {ANY}
	annee: INTEGER
	liste_realisateur: ARRAY[STRING]
	liste_acteur: ARRAY[STRING]
	type: STRING
	
feature {ANY}
	make_dvd(titre_d: STRING; annee_d: INTEGER ;liste_realisateur_d: ARRAY[STRING] ;liste_acteur_d: ARRAY[STRING] ;type_d: STRING; nombre_d : INTEGER) is
	local
		i : INTEGER
	do
		create liste_realisateur.with_capacity(0, 0)		
		create liste_acteur.with_capacity(0, 0)
		titre := titre_d
		nombre := nombre_d
		annee := annee_d
		from i:=0
		until i > liste_realisateur_d.count-1
		loop
			liste_realisateur.add_last(liste_realisateur_d.item(i))
			i := i + 1
		end
		from i:=0
		until i > liste_acteur_d.count-1
		loop
			liste_acteur.add_last(liste_acteur_d.item(i))
			i := i + 1
		end
		type := type_d
	end
	
	afficher : STRING is
	do
		Result := Precursor + " " + annee.to_string +" " + type + get_string_realisateur
	end

	compare(dvd : DVD) : BOOLEAN is
	do
		Result := (titre.is_equal(dvd.titre) and liste_realisateur.is_equal_map(dvd.liste_realisateur))
	end
	
	get_string_realisateur : STRING is
	local
		i : INTEGER
		res : STRING
	do
		res := ""
		from i:=0
		until i > liste_realisateur.count-1
		loop
			res := res + " " + liste_realisateur.item(i)
			i := i + 1
		end
		Result := res
	end
	
-----------------------------
--- SETTERS
-----------------------------
	
	
	
end 
