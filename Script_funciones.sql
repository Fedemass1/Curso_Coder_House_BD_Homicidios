USE Homicidios;

-- FUNCIONES

-- CREO LA FUNCIÓN FN_CONTAR_HOMICIDIOS_POR_ESTADO

/*
DOCUMENTACIÓN DE LA FUNCIÓN
Esta función me permite contar por estado la cantidad de homicidios cometidos. Recibe dos parámetros:
p_estado, que es de tipo VARCHAR y va entre comillas simples y p_crimen_resuelto, que es CHAR. Los únicos valores admitidos para este último parámetro son:

0 ---> Casos no resueltos.
1 ---> Casos resueltos.
2 ---> Todos los casos, es decir es la suma de casos no resueltos más resueltos.

El parámetro p_crimen_resuelto puede ser ingresado sin comillas.

Para el primer parámetro p_estado, las opciones válidas son:
Alaska; Alabama; Arkansas; Arizona; California; Colorado; Connecticut;District of Columbia; 
Delaware; Florida; Georgia; Hawaii; Iowa; Idaho; Illinois; Indiana; Kansas; Kentucky; Louisiana; 
Massachusetts; Maryland; Maine; Michigan; Minnesota; Missouri; Mississippi; Montana; Nebraska; 
North Carolina; North Dakota; New Hampshire; New Jersey; New Mexico; Nevada; New York; Ohio; 
Oklahoma; Oregon; Pennsylvania; Rhodes Island; South Carolina; South Dakota; Tennessee; Texas; 
Utah; Virginia; Vermont; Washington; Wisconsin; West Virginia; Wyoming

No importa si el nombre ingresado no respeta las mayusculas y minúscula de las opciones brindadas ya que la función
cumplirá su cometido de todas maneras.
*/

DROP FUNCTION IF EXISTS FN_CONTAR_HOMICIDIOS_POR_ESTADO;
DELIMITER //
CREATE FUNCTION FN_CONTAR_HOMICIDIOS_POR_ESTADO (
    p_estado VARCHAR(50),
    p_crimen_resuelto CHAR(1)
    
) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_resultado INT; 
    
SELECT COUNT(*) INTO v_resultado
FROM Homicidios AS H
JOIN Ubicacion AS U ON U.ID_Location = H.ID_Location
WHERE State = p_estado
AND (p_crimen_resuelto = 2 OR crime_solved = p_crimen_resuelto);

    RETURN v_resultado;
END //
DELIMITER ;
 
-- USO LA FUNCION FN_CONTAR_HOMICIDIOS_POR_ESTADO

SELECT FN_CONTAR_HOMICIDIOS_POR_ESTADO ('Oklahoma' , 0)
as Cantidad_Homicidios;


-- CREO UNA SEGUNDA FUNCIÓN
/*
DOCUMENTACIÓN DE LA FUNCIÓN

La función FN_CONTAR_HOMICIDIOS_CON_FILTROS se encarga de contar la cantidad de homicidios cometidos a partir de tres parámetros recibidos.
Estos parámetros harán de filtros acorde a lo que se quiera contar. Todos ellos son del tipo VARCHAR, es decir que tienen características de texto.
El primer parámetro es p_arma y admite los siguientes tipos de arma homicida:

Firearm
Handgun
Blunt Object
Knife
Shotgun
Rifle
Unknown
Suffocation
Gun
Fire
Strangulation
Drugs
Drowning
Poison
Fall
Explosives

El siguiente parámetro es p_sexo_victimario y admite:

Male
Female
Unknown

El tercer y último se llama p_relacion (relación de la víctima con el victimario) y contiene las siguientes alternativas válidas:

Stranger
Friend
Unknown
Daughter
Wife
Acquaintance
Brother
Girlfriend
Father
Boyfriend
Neighbor
Family
Mother
Husband
Boyfriend/Girlfriend
Stepdaughter
Sister
In-Law
Employee
Stepfather
Common-Law Wife
Son
Common-Law Husband
Ex-Wife
Employer
Stepson
Ex-Husband
Stepmother

Como punto importante, cabe mencionar que los tres parámetros aceptan por igual un valor extra que no fue mencionado precedentemente, este es el valor NULL.
Lo que se logra con su utilización es obviar cierto/s parámetros como filtros. Por ejemplo, si solo se quisiera saber la cantidad
de crímenes cometidos con armas de fuego, la sentencia sería: SELECT FN_CONTAR_HOMICIDIOS_CON_FILTROS ('Firearm', NULL, NULL), en donde tanto
el segundo como tercer parámetro son obviados mediante la manifestación del NULL. NULL va sin comillas.
Tambien es válido el caso (NULL, NULL, NULL), que arrojará como consecuencia la totalidad de los homicidos cometidos, ya que no se aplicará ningun tipo
de filtro a la consulta llamada a través de la función.

*/

DROP FUNCTION IF EXISTS FN_CONTAR_HOMICIDIOS_CON_FILTROS;
DELIMITER //
CREATE FUNCTION FN_CONTAR_HOMICIDIOS_CON_FILTROS (
    p_arma VARCHAR(50) ,
    p_sexo_victimario  VARCHAR(10) ,
    p_relacion VARCHAR(50)
) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_resultado INT; 
    
SELECT COUNT(*) INTO v_resultado
FROM Homicidios AS H
JOIN Tipo_de_Homicidio AS TDH ON TDH.ID_Crime = H.ID_Crime
JOIN Victimarios AS V ON V.ID_perpetrator = H.ID_perpetrator
JOIN Relacion AS R ON R.ID_Relationship = H.ID_Relationship
WHERE (p_arma IS NULL OR weapon = p_arma)
AND (p_sexo_victimario IS NULL OR perpetrator_sex = p_sexo_victimario)
AND (p_relacion IS NULL OR Relationship  = p_relacion);

    RETURN v_resultado;
END //
DELIMITER ;

-- Utilizo la función creada
SELECT FN_CONTAR_HOMICIDIOS_CON_FILTROS ('Firearm', 'Male', 'Stranger')
as Cantidad_Homicidios;




