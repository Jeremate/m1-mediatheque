class UTILISATEUR

creation {ANY}
	make_client, make_admin

feature {ANY}
	nom, prenom, identifiant: STRING

feature {ANY}
	admin: BOOLEAN
	
feature {ANY}
	
	compare(utilisateur : UTILISATEUR): BOOLEAN is
	do
		Result := (nom.is_equal(utilisateur.nom) and prenom.is_equal(utilisateur.prenom) and identifiant.is_equal(utilisateur.identifiant))
	end
	
	make_client (nom_c, prenom_c, identifiant_c: STRING) is
	do
		nom := nom_c
		prenom := prenom_c
		identifiant := identifiant_c
		admin := False
	end
		
	make_admin (nom_a, prenom_a, identifiant_a: STRING) is
	do
		nom := nom_a
		prenom := prenom_a
		identifiant := identifiant_a
		admin := True
	end
	
	est_admin: BOOLEAN is
	do
		Result := admin
	end
	
	afficher: STRING is
	local
		estadm : STRING
	do
		if admin then
			estadm := "Administrateur"
		else
			estadm := "Utilisateur standard"
		end
		Result := identifiant + " : " + nom + " " + prenom + " - " + estadm +"%N"
	end

	
	str_user(valeur : STRING) : BOOLEAN is
	do
		Result := identifiant.is_equal(valeur) and admin = False
	end
	
	str_admin(valeur : STRING) : BOOLEAN is
	do
		Result := identifiant.is_equal(valeur) and admin = True
	end
	
	get_identifiant: STRING is
	do
		Result := identifiant
	end
end -- fermeture class