DROP SCHEMA IF EXISTS HOMICIDIOS;
CREATE SCHEMA IF NOT EXISTS HOMICIDIOS;
USE HOMICIDIOS;

-- Creación de tablas y campos de la BD Homicidios

CREATE TABLE Homicidios (
	Record_ID INT NOT NULL,
    ID_Agency VARCHAR(20),
    ID_Location VARCHAR(20),
    Dates DATE,
    ID_Crime VARCHAR(20) NOT NULL,
    Crime_Solved BOOLEAN,
    ID_Victim VARCHAR(20) NOT NULL,
    ID_Perpetrator VARCHAR(20) NOT NULL,
    ID_Relationship VARCHAR(20),
    CONSTRAINT PK_Homicidios PRIMARY KEY (Record_ID)
    );
    
CREATE TABLE Agencia (
    ID_Agency VARCHAR(20) NOT NULL,
    Agency_Name TEXT(200),
    Agency_Type TEXT(200),
    CONSTRAINT PK_Agencia PRIMARY KEY (ID_Agency)
    );
    
CREATE TABLE Ubicacion (
    ID_Location VARCHAR(20) NOT NULL,
    City TEXT(200),
    State TEXT(200),
    CONSTRAINT PK_Ubicacion PRIMARY KEY (ID_Location)
    ); 
    
CREATE TABLE Tipo_de_Homicidio (
    ID_Crime VARCHAR(20) NOT NULL,
    Crime_Type TEXT(200),
    Weapon TEXT(200),
    CONSTRAINT PK_Tipo_de_Homicidio PRIMARY KEY (ID_Crime)
    );
    
CREATE TABLE Victimas (
    ID_Victim VARCHAR(20) NOT NULL,
    Victim_Sex VARCHAR(20),
    Victim_Age INT,
    Victim_Race TEXT(100),
    CONSTRAINT PK_Victimas PRIMARY KEY (ID_Victim)
    );  
    
CREATE TABLE Victimarios (
    ID_Perpetrator VARCHAR(20) NOT NULL,
    Incident INT,
    Perpetrator_Sex VARCHAR(20),
    Perpetrator_Age INT,
    Perpetrator_Race TEXT(100),
    CONSTRAINT PK_Victimarios PRIMARY KEY (ID_Perpetrator)
    );
    
CREATE TABLE Relacion (
    ID_Relationship VARCHAR(50) NOT NULL,
    Relationship VARCHAR(50),
    CONSTRAINT PK_Relacion PRIMARY KEY (ID_Relationship)
    );
    
    
-- Definición de claves Foraneas

ALTER TABLE Homicidios  ADD CONSTRAINT FK_Homicidios_ID_Agency FOREIGN KEY (ID_Agency)
REFERENCES Agencia (ID_Agency);

ALTER TABLE Homicidios  ADD CONSTRAINT FK_Homicidios_ID_Location FOREIGN KEY (ID_Location)
REFERENCES Ubicacion (ID_Location);

ALTER TABLE Homicidios  ADD CONSTRAINT FK_Homicidios_ID_Crime FOREIGN KEY (ID_Crime)
REFERENCES Tipo_de_Homicidio (ID_Crime);

ALTER TABLE Homicidios  ADD CONSTRAINT FK_Homicidios_ID_Victim FOREIGN KEY (ID_Victim)
REFERENCES Victimas (ID_Victim);

ALTER TABLE Homicidios  ADD CONSTRAINT FK_Homicidios_ID_Perpetrator FOREIGN KEY (ID_Perpetrator)
REFERENCES Victimarios (ID_Perpetrator);

ALTER TABLE Homicidios  ADD CONSTRAINT FK_Homicidios_ID_Relationship FOREIGN KEY (ID_Relationship)
REFERENCES Relacion (ID_Relationship);
