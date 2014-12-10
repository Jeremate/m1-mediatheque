class LIVRE inherit MEDIA
redefine 
	afficher
end

creation {ANY}
	make_livre

feature {ANY}
	auteur: STRING
	
feature {ANY}
	make_livre(titre_l : STRING; auteur_l: STRING ; nombre_l : INTEGER) is
	do
		titre := titre_l
		auteur := auteur_l
		nombre := nombre_l
	end
	
	afficher : STRING is
	do
		Result := Precursor + " " + auteur
	end

	compare(livre : LIVRE) : BOOLEAN is
	do
		Result := (titre.is_equal(livre.titre) and auteur.is_equal(livre.auteur))
	end
	
	
-----------------------------
--- SETTERS
-----------------------------
	
end 
