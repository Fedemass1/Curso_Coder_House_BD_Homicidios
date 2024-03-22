USE homicidios;

-- Creo la primera vista de nombre VW_CRIMENES_RESUELTOS_EN_ALASKA
CREATE OR REPLACE VIEW VW_ASESINATOS_RESUELTOS_ALASKA AS
SELECT Dates, Agency_name , City, Weapon, Relationship
FROM Homicidios AS H
JOIN Ubicacion AS U ON U.ID_Location = H.ID_Location
JOIN Agencia AS A ON A.ID_Agency = H.ID_Agency
JOIN tipo_de_homicidio AS TDH ON TDH.ID_Crime = H.ID_Crime
JOIN Relacion AS R ON R.ID_Relationship = H.ID_Relationship
WHERE State = 'Alaska'
AND crime_solved = 1;

--  Hago la consulta de la vista creada
SELECT * FROM VW_ASESINATOS_RESUELTOS_ALASKA;


-- Creo una segunda vista de nombre VW_CRIMEN_NO_RESULETO_MENORES_15_ANIOS
CREATE OR REPLACE VIEW VW_CRIMENES_NO_RESULETOS_MENORES_15_ANIOS AS
SELECT Dates AS Fecha_del_crimen, victim_sex AS Sexo_de_la_victima, victim_age, Relationship
AS Edad_de_la_victima, relationship AS Relacion_con_el_asesino
FROM Homicidios AS H
JOIN Victimas AS V  ON V.ID_Victim = H.ID_Victim
JOIN Ubicacion ON H.ID_Location = ubicacion.ID_Location
JOIN Relacion AS R ON R.ID_Relationship = H.ID_Relationship
WHERE victim_age < 15
AND Relationship <> 'Unknown'
AND Crime_solved = 0
ORDER BY victim_age;

--  Hago la consulta de la vista creada
SELECT * FROM VW_CRIMENES_NO_RESULETOS_MENORES_15_ANIOS;


-- Creo una tercer vista de nombre VW_CANTIDAD_ASESINOS_POR_SEXO_RAZA_Y_ARMA_HOMICIDA
CREATE OR REPLACE VIEW VW_CANTIDAD_ASESINOS_POR_SEXO_RAZA_Y_ARMA_HOMICIDA AS
SELECT perpetrator_sex, perpetrator_race, weapon, count(*) AS Cantidad 
FROM HOMICIDIOS AS H
JOIN VICTIMARIOS AS V ON V.ID_PERPETRATOR = H.ID_PERPETRATOR
JOIN TIPO_DE_HOMICIDIO AS TDH ON TDH.ID_CRIME = H.ID_CRIME
WHERE perpetrator_sex <>  'Unknown'
AND perpetrator_race <>  'Unknown'
AND weapon <>  'Unknown'
GROUP BY perpetrator_sex, perpetrator_race, weapon
ORDER BY cantidad DESC;

--  Hago la consulta de la vista creada
SELECT * FROM VW_CANTIDAD_ASESINOS_POR_SEXO_RAZA_Y_ARMA_HOMICIDA;


-- Creo la cuarta vista de nombre VW_TOP_10_AGENCIAS_CON_MAS_CASOS_RESUELTOS
CREATE OR REPLACE VIEW VW_TOP_10_AGENCIAS_CON_MAS_CASOS_RESUELTOS AS
SELECT Agency_name, Agency_Type, SUM(Crime_solved) AS Cantidad_de_crimenes_resuletos
FROM Homicidios AS H
JOIN Agencia AS A ON A.ID_Agency = H.ID_Agency
GROUP BY Agency_name, Agency_Type, Crime_solved
ORDER BY Cantidad_de_crimenes_resuletos DESC
LIMIT 10;

--  Hago la consulta de la vista creada
SELECT * FROM VW_TOP_10_AGENCIAS_CON_MAS_CASOS_RESUELTOS;


-- Creo una quinta y última vista de nombre VW_RANKING_ASESINATOS_POR_ESTADO
CREATE OR REPLACE VIEW VW_RANKING_ASESINATOS_POR_ESTADO AS
SELECT State,  count(*) AS Cantidad_crimenes
FROM Homicidios AS H
JOIN Ubicacion AS U ON U.ID_Location = H.ID_Location
JOIN Tipo_de_homicidio AS TDH ON TDH.ID_CRIME = H.ID_CRIME
WHERE Crime_type = 'Murder or Manslaughter'
GROUP BY State
ORDER BY Cantidad_crimenes;

--  Hago la consulta de la vista creada
SELECT * FROM VW_RANKING_ASESINATOS_POR_ESTADO;







