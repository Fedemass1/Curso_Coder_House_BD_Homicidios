USE Homicidios;

-- Creo la tabla Log_auditoria para ir almacenando las modificaciones que vayan capturando los triggers que se definirán más adelante

drop table if  exists Log_auditoria;
CREATE TABLE IF NOT EXISTS Log_auditoria 
(
ID_log INT AUTO_INCREMENT ,
Nombre_de_accion VARCHAR(10) ,
Nombre_tabla VARCHAR(50) ,
Usuario VARCHAR(100) , 
Fecha_UPD_INS_DEL DATE , 
PRIMARY KEY (ID_log)
);

-- Con el mismo propósito creo una segunda tabla llamada Log_auditoria_2. A diferencia de la anterior se le añaden dos campos para registrar el campo anterior a las modificaciones
-- y el nuevo luego de haber operado.

drop table if  exists Log_auditoria_2;
CREATE TABLE IF NOT EXISTS Log_auditoria_2
(
ID_log INT AUTO_INCREMENT ,
Valor_anterior VARCHAR(200),
Valor_nuevo VARCHAR(200),
Nombre_de_accion VARCHAR(10) ,
Nombre_tabla VARCHAR(50) ,
Usuario VARCHAR(100) ,
Fecha_UPD_INS_DEL DATE    ,
PRIMARY KEY (ID_log)
);


-- TABLAS DE INTERÉS: VICTIMARIOS Y VICTIMAS. 
-- Se desarrollarán na continuación seis triggers en relación a la tabla VICTIMARIOS.

-- TABLA VICTIMARIOS
-- TRIGGER 1 (AFTER - INSERT) Guarda información en TABLA LOG_AUDITORIA

DROP TRIGGER IF EXISTS TRG_LOG_VICTIMARIOS;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMARIOS AFTER INSERT ON HOMICIDIOS.VICTIMARIOS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA (NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( 'INSERT' , 'VICTIMARIOS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;

-- TRIGGER 2 (BEFORE - INSERT) Guarda información en TABLA LOG_AUDITORIA_2
DROP TRIGGER IF EXISTS TRG_LOG_VICTIMARIOS_2 ;

DELIMITER //
CREATE TRIGGER  TRG_LOG_VICTIMARIOS_2 BEFORE INSERT ON HOMICIDIOS.VICTIMARIOS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA_2 (VALOR_NUEVO, NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( NEW.ID_perpetrator, 'INSERT' , 'VICTIMARIOS' ,CURRENT_USER() , NOW());
       
END//
DELIMITER ;


-- Inserto dos nuevos registros en la tabla Victimarios del esquema Homicidios

INSERT INTO Victimarios (ID_perpetrator, Incident, Perpetrator_sex, Perpetrator_age, Perpetrator_Race ) VALUES ('PERP_1', 1,'Male', 15, 'Black');
INSERT INTO Victimarios (ID_perpetrator, Incident, Perpetrator_sex, Perpetrator_age, Perpetrator_Race ) VALUES ('PERP_2', 1,'Female', 32, 'White');

-- Hago la consulta para verificar que efectivamente se hayan agregado
SELECT * FROM VICTIMARIOS
ORDER BY ID_perpetrator DESC;

-- Hago la consulta a la nueva tabla de Log_auditoria, para verificar si efectivamente el trigger TRG_LOG_VICTIMARIOS cumplió su cometido de registrar los INSERT realizados
SELECT * FROM Log_auditoria;

-- Verifico lo mismo para la tabla Log_auditoria_2 para TRG_LOG_VICTIMARIOS_2
SELECT * FROM Log_auditoria_2;

/*===============================================================================================================================================*/

-- TRIGGER 3 (BEFORE - UPDATE) Guarda información en TABLA LOG_AUDITORIA
DROP TRIGGER IF EXISTS TRG_LOG_VICTIMARIOS_3 ;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMARIOS_3 BEFORE UPDATE ON HOMICIDIOS.VICTIMARIOS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA (NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ('UPDATE' , 'VICTIMARIOS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;


-- TRIGGER 4 (AFTER - UPDATE) Guarda información en TABLA LOG_AUDITORIA_2

DROP TRIGGER IF EXISTS TRG_LOG_VICTIMARIOS_4 ;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMARIOS_4 AFTER UPDATE ON HOMICIDIOS.VICTIMARIOS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA_2 (VALOR_ANTERIOR, VALOR_NUEVO, NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( OLD.ID_perpetrator, NEW.ID_perpetrator, 'UPDATE' , 'VICTIMARIOS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;


-- Actualizo los valores previamente agregados para comprobar el funcionamientos de los triggers 3 y 4.

UPDATE Victimarios 
SET 
	ID_perpetrator = 'PERP_3',
	Incident = 2,
    Perpetrator_sex = 'Desconocido',
    Perpetrator_age = 15,
    Perpetrator_Race = 'Old black'
WHERE ID_perpetrator = 'PERP_1';

UPDATE Victimarios 
SET ID_perpetrator = 'PERP_4',
    Incident = 1,
    Perpetrator_sex = 'Female',
    Perpetrator_age = 32,
    Perpetrator_Race = 'White'
WHERE ID_perpetrator = 'PERP_2';
    
-- Hago la consulta para verificar la actualización.
SELECT * FROM VICTIMARIOS
ORDER BY ID_perpetrator DESC;

-- Chequeo los logs
SELECT * FROM log_auditoria;
SELECT * FROM log_auditoria_2;

/* =============================================================================================================*/

-- TRIGGER 5 (BEFORE - DELETE) Guarda información en TABLA LOG_AUDITORIA
DROP TRIGGER IF EXISTS TRG_LOG_VICTIMARIOS_5 ;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMARIOS_5 BEFORE DELETE ON HOMICIDIOS.VICTIMARIOS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA (NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( 'DELETE' , 'VICTIMARIOS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;


-- TRIGGER 5 (BEFORE - DELETE) Guarda información en TABLA LOG_AUDITORIA_2
DROP TRIGGER IF EXISTS TRG_LOG_VICTIMARIOS_6 ;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMARIOS_6 BEFORE DELETE ON HOMICIDIOS.VICTIMARIOS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA_2 (VALOR_ANTERIOR, NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( OLD.ID_perpetrator,  'DELETE' , 'VICTIMARIOS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;

-- Borro los registros agregados, que posteriormente fueron modificados
DELETE FROM Victimarios
WHERE ID_Perpetrator =  'PERP_3';

DELETE FROM Victimarios
WHERE ID_Perpetrator =  'PERP_4';

-- Realizo la consulta a la tabla victimarios para verificar si fueron eliminados
SELECT * FROM Victimarios;

-- Compruebo en ambas tablas de logs los registros correspondientes a la acción delete.
SELECT * FROM log_auditoria;
SELECT * FROM log_auditoria_2;


/*
===============================================================================================================
===============================================================================================================
*/

-- TABLA VICTIMAS

-- TRIGGER 7 (AFTER - INSERT) Guarda información en TABLA LOG_AUDITORIA

DROP TRIGGER IF EXISTS TRG_LOG_VICTIMAS

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMAS AFTER INSERT ON HOMICIDIOS.VICTIMAS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA (NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( 'INSERT' , 'VICTIMAS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;

-- TRIGGER 2 (BEFORE - INSERT) Guarda información en TABLA LOG_AUDITORIA_2
DROP TRIGGER IF EXISTS TRG_LOG_VICTIMAS_2 ;

DELIMITER //
CREATE TRIGGER  TRG_LOG_VICTIMAS_2 BEFORE INSERT ON HOMICIDIOS.VICTIMAS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA_2 (VALOR_NUEVO, NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( NEW.ID_victim, 'INSERT' , 'VICTIMAS' ,CURRENT_USER() , NOW());
       
END//
DELIMITER ;


-- Inserto dos nuevos registros en la tabla Victimas del esquema Homicidios

INSERT INTO Victimas (ID_victim, Victim_sex, Victim_age, Victim_Race ) VALUES ('VICT_1', 'Male', 45, 'Black');
INSERT INTO Victimas (ID_victim, Victim_sex, Victim_age, Victim_Race ) VALUES ('VICT_2', 'Female', 12, 'White');

-- Hago la consulta para verificar que efectivamente se hayan agregado
SELECT * FROM VICTIMAS
ORDER BY ID_victim;

-- Hago la consulta a la nueva tabla de Log_auditoria, para verificar si efectivamente el trigger TRG_LOG_VICTIMAS cumplió su cometido de registrar los INSERT realizados
SELECT * FROM Log_auditoria;

-- Verifico lo mismo para la tabla Log_auditoria_2 para TRG_LOG_VICTIMAS_2
SELECT * FROM Log_auditoria_2;

/*===============================================================================================================================================*/

-- TRIGGER 3 (BEFORE - UPDATE) Guarda información en TABLA LOG_AUDITORIA
DROP TRIGGER IF EXISTS TRG_LOG_VICTIMAS_3 ;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMAS_3 BEFORE UPDATE ON HOMICIDIOS.VICTIMAS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA (NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ('UPDATE' , 'VICTIMAS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;


-- TRIGGER 4 (AFTER - UPDATE) Guarda información en TABLA LOG_AUDITORIA_2

DROP TRIGGER IF EXISTS TRG_LOG_VICTIMAS_4 ;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMAS_4 AFTER UPDATE ON HOMICIDIOS.VICTIMAS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA_2 (VALOR_ANTERIOR, VALOR_NUEVO, NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( OLD.ID_victim, NEW.ID_victim, 'UPDATE' , 'VICTIMAS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;


-- Actualizo los valores previamente agregados para comprobar el funcionamientos de los triggers 3 y 4.

UPDATE Victimas
SET 
	ID_victim = 'VICT_3',
    Victim_sex = 'Desconocido',
    Victim_age = 15,
    Victim_Race = 'Old black'
WHERE ID_victim = 'VICT_1';

UPDATE Victimas
SET 
	ID_victim = 'VICT_4',
    Victim_sex = 'Male',
    Victim_age = 9,
    Victim_Race = 'Desconocido'
WHERE ID_victim = 'VICT_2';
    
-- Hago la consulta para verificar la actualización.
SELECT * FROM VICTIMAS
ORDER BY ID_victim;

-- Chequeo los logs
SELECT * FROM log_auditoria;
SELECT * FROM log_auditoria_2;

/* =============================================================================================================*/

-- TRIGGER 5 (BEFORE - DELETE) Guarda información en TABLA LOG_AUDITORIA
DROP TRIGGER IF EXISTS TRG_LOG_VICTIMAS_5 ;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMAS_5 BEFORE DELETE ON HOMICIDIOS.VICTIMAS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA ( NOMBRE_DE_ACCION, NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( 'DELETE' , 'VICTIMAS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;


-- TRIGGER 5 (BEFORE - DELETE) Guarda información en TABLA LOG_AUDITORIA_2
DROP TRIGGER IF EXISTS TRG_LOG_VICTIMAS_6 ;

DELIMITER //
CREATE TRIGGER TRG_LOG_VICTIMAS_6 BEFORE DELETE ON HOMICIDIOS.VICTIMAS
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA_2 (VALOR_ANTERIOR, NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( OLD.ID_victim,  'DELETE' , 'VICTIMAS' ,CURRENT_USER() , NOW());

END//
DELIMITER ;

-- Borro los registros agregados, que posteriormente fueron modificados
DELETE FROM Victimas
WHERE ID_victim =  'VICT_3';

DELETE FROM Victimas
WHERE ID_victim =  'VICT_4';

-- Realizo la consulta a la tabla victimas para verificar si fueron eliminados
SELECT * FROM Victimas;

-- Compruebo en ambas tablas de logs los registros correspondientes a la acción delete.
SELECT * FROM log_auditoria;
SELECT * FROM log_auditoria_2;

