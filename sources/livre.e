class LIVRE inherit MEDIA
redefine 
	afficher,
	get_identifiant,
	sauvegarde
end

creation {ANY}
	make_livre

feature {ANY}
	auteur: STRING
	
feature {ANY}
	make_livre(titre_l : STRING; auteur_l: STRING ; nombre_l , nombre_exemplaire_l: INTEGER) is
	do
		titre := titre_l
		auteur := auteur_l
		nombre := nombre_l
		nombre_exemplaire := nombre_exemplaire_l
	end
	
	afficher : STRING is
	do
		Result := Precursor + ", écrit par " + auteur + " | LIVRE"
	end

	sauvegarde  : STRING is
	do
		Result := Precursor + "; Auteur<" + auteur + "> ; Livre "
	end
	
	compare(livre : LIVRE) : BOOLEAN is
	do
		Result := (titre.is_equal(livre.titre) and auteur.is_equal(livre.auteur))
	end
	
	get_identifiant : STRING is
	do
		Result := titre +" de "+ auteur
	end
	
-----------------------------
--- SETTERS
-----------------------------
	
end 
