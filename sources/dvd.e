class DVD inherit MEDIA
redefine 
	afficher,
	get_identifiant,
	sauvegarde
end

creation {ANY}
	make_dvd

feature {ANY}
	annee: INTEGER
	liste_realisateur: ARRAY[STRING]
	liste_acteur: ARRAY[STRING]
	type: STRING
	
feature {ANY}
	make_dvd(titre_d: STRING; annee_d: INTEGER ;liste_realisateur_d: ARRAY[STRING] ;liste_acteur_d: ARRAY[STRING] ;type_d: STRING; nombre_d , nombre_exemplaire_d : INTEGER) is
	local
		i : INTEGER
	do
		create liste_realisateur.with_capacity(0, 0)		
		create liste_acteur.with_capacity(0, 0)
		titre := titre_d
		nombre := nombre_d
		nombre_exemplaire := nombre_exemplaire_d
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
	local
		res : STRING
	do
		res := ", de : " + annee.to_string 
		if not type.is_empty then
			res := res +", type :" + type
		end
		res := ", réalisé par :"+ get_string_realisateur + ", acteurs : " + get_string_acteur+ " | DVD"
		Result := Precursor + res
	end
	
	sauvegarde : STRING is
	local 
		res : STRING
		i : INTEGER
	do
		res := " ; Annee<" + annee.to_string +"> ; Type<" + type + "> ; DVD "
		from i:=0
		until i > liste_realisateur.count-1
		loop
			res := res + " ; Realisateur<" + liste_realisateur.item(i)+"> "
			i := i + 1
		end
		from i:=0
		until i > liste_acteur.count-1
		loop
			res := res + " ; Acteur<" + liste_acteur.item(i)+"> "
			i := i + 1
		end
		Result := Precursor + res
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
	
	get_string_acteur : STRING is
	local
		i : INTEGER
		res : STRING
	do
		res := ""
		from i:=0
		until i > liste_acteur.count-1
		loop
			res := res + liste_acteur.item(i) 
			
			i := i + 1
			if i <= liste_acteur.count-1 then
				res := res + " - "
			end
		end
		Result := res
	end
	
	get_identifiant : STRING is
	do
		Result := titre +" de " + get_string_realisateur
	end
	
	
end 
