class UTILISATEUR

creation {ANY}
	make_client, make_admin

feature {ANY}
	nom, prenom, identifiant: STRING
	actif :  BOOLEAN

feature {ANY}
	admin: BOOLEAN
	
feature {ANY}
	
	compare(utilisateur : UTILISATEUR): BOOLEAN is
	do
		Result := (nom.is_equal(utilisateur.nom) and prenom.is_equal(utilisateur.prenom) and identifiant.is_equal(utilisateur.identifiant))
	end
	
	make_client (nom_c, prenom_c, identifiant_c: STRING ; actif_c : BOOLEAN) is
	do
		nom := nom_c
		prenom := prenom_c
		identifiant := identifiant_c
		admin := False
		actif := actif_c
	end
		
	make_admin (nom_a, prenom_a, identifiant_a: STRING ; actif_a : BOOLEAN) is
	do
		nom := nom_a
		prenom := prenom_a
		identifiant := identifiant_a
		admin := True
		actif := actif_a
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

	est_actif: BOOLEAN is
	do
		Result := actif
	end
	
	active is
	do
		actif := True
	end
	
	sauvegarde : STRING is
	local
		res : STRING
	do
		res := "Nom<"+nom+"> ; Prenom<"+prenom+"> ; Identifiant<"+identifiant+"> "
		if admin = True then
			res := res + "; Admin<OUI> "
		end
		if actif then
			res := res + "; Actif<OUI> "
		else
			res := res + "; Actif<NON> "
		end
		Result := res
	end
	
	
	desactive is
	do
		actif := False
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