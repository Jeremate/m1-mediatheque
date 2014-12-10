class MEDIA

creation {ANY}
	make
	
feature {ANY}
	titre: STRING
	nombre: INTEGER
	
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
	end
	
	
end -- classe MEDIA

