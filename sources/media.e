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
		Result := titre + " "+ nombre.to_string
	end
	
---------------------
--- SETTERS
---------------------
	set_nombre(valeur: INTEGER) is
	do
       nombre := nombre + valeur
	   nombre_exemplaire := nombre_exemplaire + valeur
	end

	
---------------------
--- GETTERS
---------------------

	get_titre : STRING is
	do
		Result := titre
	end
---------------------
--EMPRUNT / RENDU
---------------------
    	emprunter : BOOLEAN is
    	require
    	         nombre >= 0
    	do
    		if nombre > 0 then
    			set_nombre(nombre-1)
    			io.put_string("Emprunt effectué !%N")
    			Result := True
    		else
    			io.put_string("Emprunt impossible, pas de stock disponible !%N")
    			Result := False
    		end
    	end
    
        rendre is
        do
           set_nombre(nombre+1)
           io.put_string("Retour effectué !%N")
        end
	
end -- classe MEDIA

