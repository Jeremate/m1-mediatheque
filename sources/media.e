class MEDIA

creation {ANY}
	make
	
feature {ANY}
	titre: STRING
	nombre: INTEGER
	nombre_exemplaire : INTEGER
	
	
	make is
	do
	
	end
	
	afficher: STRING is
	do
		Result := " " + titre + ", nombre disponible :"+ nombre.to_string
	end
	
---------------------
--- SETTERS
---------------------
	set_nombre(valeur: INTEGER) is
	do
       nombre := nombre + valeur
	   nombre_exemplaire := nombre_exemplaire + valeur
	end

	supprimer is
	do
		nombre_exemplaire := 0
		nombre := 0
	end
	
---------------------
--- GETTERS
---------------------

	get_titre : STRING is
	do
		Result := titre
	end
	
	get_nombre : INTEGER is
	do
		Result := nombre
	end
---------------------
--EMPRUNT / RENDU
---------------------
	emprunter : BOOLEAN is
	require
		nombre >= 0
	do
		if nombre > 0 then
			nombre := nombre -1
			io.put_string("Emprunt effectué !%N")
			Result := True
		else
			io.put_string("Emprunt impossible, pas de stock disponible !%N")
			Result := False
		end
	end
    
	rendre is
	do
		nombre := nombre + 1
		io.put_string("Retour effectué !%N")
	end

	get_identifiant : STRING is
	do
		Result := titre
	end
		
end -- classe MEDIA

