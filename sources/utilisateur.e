class UTILISATEUR

creation {ANY}
	make_client, make_admin

feature {MEDIATHEQUE}
	nom, prenom, identifiant: STRING

feature {NONE}
	admin: BOOLEAN
	
feature {ANY}
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
		do
			Result := nom + " " + prenom + "%N"
		end
	
	
end -- fermeture class
