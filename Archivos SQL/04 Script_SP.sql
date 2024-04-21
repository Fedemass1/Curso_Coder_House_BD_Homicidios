USE HOMICIDIOS;

-- STORE PROCEDURES

-- Creo el primer Store Procedure de nombre SP_Ordenar_homicidios

/*
DOCUMENTACIÓN SP
La finalidad de este Store Procedure es brindar, mediante una consulta dinámica SQL, una forma para que el usuario pueda
ordenar el resultado de una consulta a través del ingreso de dos parámetros. Existe un tercer parámetro para la función quye se detallará luego, por
lo que los parámetros totales requeridos al usuario serán tres.
El primer parámetro P_nombre_columna deberá definir por cual de las columnas se quiere ordenar. Las opciones son:

Dates
Agency_name
City
State
Crime_Type
Weapon
Victim_sex
Victim_age
Relationship

El segundo parámetro se denomina P_orden y solo acepta dos posibles valores

ASC ---> Indica que el orden de la columna seleccionada en P_nombre_columna debe ser ascendente.
DESC ---> Indica que el orden de la columna seleccionada en P_nombre_columna debe ser descendente.

Como se mencionó anteriormente, existe un tercer parámetro, el cual no cumple función en el ordenamiento pero sí en el filtrado de información.
Este filtrado es para reflejar en la consulta que crímenes han sido resueltos y cuales no. Las opciones a ingresar como parámetro son:

0 ---> Casos no resueltos
1 ---> Casos resueltos
2 ---> Todos los casos, es decir es la suma de casos no resueltos más resueltos.

*/

DROP PROCEDURE IF EXISTS SP_Ordenar_homicidios;
DELIMITER //

CREATE PROCEDURE SP_Ordenar_homicidios(IN P_nombre_columna VARCHAR(20),
                                        IN P_orden VARCHAR(4),
                                        IN P_crimen_resuelto CHAR(1))
BEGIN
    SET @query = CONCAT('SELECT Dates, Agency_name, City, State, Crime_Type, Weapon, Victim_sex, Victim_age, Relationship
                         FROM Homicidios AS H
                         JOIN Ubicacion AS U ON U.ID_Location = H.ID_Location
                         JOIN Agencia AS A ON A.ID_Agency = H.ID_Agency
                         JOIN tipo_de_homicidio AS TDH ON TDH.ID_Crime = H.ID_Crime
                         JOIN Relacion AS R ON R.ID_Relationship = H.ID_Relationship
                         JOIN Victimas AS V ON V.ID_Victim = H.ID_Victim
                         WHERE (', p_crimen_resuelto, ' = 2 OR crime_solved =', p_crimen_resuelto,')
                         ORDER BY ', P_nombre_columna, ' ', P_orden);

    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;

CALL SP_Ordenar_homicidios('Victim_age', 'ASC', 0);


-- Creo un segundo Store Procedure de nombre SP_Ordenar_homicidios.

/*
DOCUMENTACIÓN
El SP recibe cinco parámetros. Se describirán a continuación cada uno de ellos en orden ascendente:

p_operacion: tiene dos posibilidades 'insert' o 'delete'. El primero sirve para agregar información a la
tabla 'victimas' del esquema Homicidios en la base de datos. El segundo realiza justo lo opuesto, 
permite la eliminación de un registro.

p_id_victim:  si el parámetro anterior es 'insert' entonces se debe ingresar el nuevo ID del registro a insertar. Por 
el contrario, si es 'delete' entonces el ID ingresado es del registro a eliminar.


p_victim_sex: si el primer parámetro p_operacion es 'delete' entonces su valor debe ser NULL, caso contrario se deberá agregar el sexo de la víctima
al registro que se esta adicionando.

p_victim_age:  si el primer parámetro p_operacion  es 'delete' entonces su valor debe ser NULL, caso contrario se deberá agregar la edad de la víctima
al registro que se esta adicionando.

p_victim_race: si el primer parámetro p_operacion  es 'delete' entonces su valor debe ser NULL, caso contrario se deberá agregar la raza de la víctima
al registro que se esta adicionando.

Tanto cuando se ejecuta una operación de tipo insert o delete, aparecerá un mensaje (a modo de consulta) en donde indique el éxito o fracaso de la operación realizada.

*/

DROP PROCEDURE IF EXISTS SP_Insertar_Eliminar_Victima;
DELIMITER //

CREATE PROCEDURE SP_Insertar_Eliminar_Victima( IN p_operacion VARCHAR(10),
											   IN p_id_victim INT,
											   IN p_victim_sex VARCHAR(10),
											   IN p_victim_age INT,
											   IN p_victim_race VARCHAR(20))
BEGIN
    IF p_operacion = 'insert' THEN
        INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES (p_id_victim, p_victim_sex, p_victim_age, p_victim_race);
        SELECT 'Registro insertado correctamente.' AS Resultado;
    ELSEIF p_operacion = 'delete' THEN
        DELETE FROM Victimas WHERE ID_Victim = p_id_victim LIMIT 1;
        SELECT 'Registro eliminado correctamente.' AS Resultado;
    ELSE
        SELECT 'Operación no válida. Debe ser "insert" o "delete".' AS Resultado;
    END IF;
END//

DELIMITER ;


-- LLamo el SP de inserción de datos
CALL SP_Insertar_Eliminar_Victima('insert', 1, 'Masculino', 30, 'Blanco');


-- Verifico que  1, 'Masculino', 30, 'Blanco' efectivamente se encuentra agregado en la tabla.

SELECT * FROM Victimas;


-- Llamo el SP para eliminación del registro agregado.

CALL SP_Insertar_Eliminar_Victima('delete', 1, NULL, NULL, NULL);


-- Verifico la correcta eliminación del registro anteriormente agregado.

SELECT * FROM Victimas


