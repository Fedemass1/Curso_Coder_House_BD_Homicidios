USE HOMICIDIOS;
SELECT @@sql_safe_updates;
SELECT @@foreign_key_checks;
SELECT @@autocommit;

SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

SELECT * FROM VICTIMARIOS;

START TRANSACTION;

DELETE FROM VICTIMARIOS WHERE 
ID_PERPETRATOR = 'PERP_000001';

DELETE FROM VICTIMARIOS WHERE 
ID_PERPETRATOR = 'PERP_000002';

DELETE FROM VICTIMARIOS WHERE 
ID_PERPETRATOR = 'PERP_000003';

DELETE FROM VICTIMARIOS WHERE 
ID_PERPETRATOR = 'PERP_000004';

DELETE FROM VICTIMARIOS WHERE 
ID_PERPETRATOR = 'PERP_000005';


SELECT * FROM VICTIMARIOS;

-- ROLLBACK;

SELECT * FROM VICTIMARIOS;

-- COMMIT;

SELECT * FROM VICTIMAS;
START TRANSACTION;

INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES ('AAAAAAA01', 'Male', 18, 'Native American');
        
INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES ('AAAAAAA02', 'Female', 20, 'Native American');
        
INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES ('AAAAAAA03', 'Male', 50, 'White');
        
INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES ('AAAAAAA04', 'Male', 50, 'White');

SAVEPOINT SP1;
        
INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES ('AAAAAAA05', 'Female', 26, 'Black');
        
INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES ('AAAAAAA06', 'Female', 78, 'Black');
        
INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES ('AAAAAAA07', 'Male', 14, 'Asian');
        
INSERT INTO Victimas (ID_Victim, Victim_sex, Victim_age, Victim_race)
        VALUES ('AAAAAAA08', 'Female', 41, 'White');

SAVEPOINT SP2;
        
SELECT * FROM VICTIMAS;

-- RELEASE SAVEPOINT SP1;

SELECT * FROM VICTIMAS;