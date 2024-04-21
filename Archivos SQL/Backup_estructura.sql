CREATE DATABASE  IF NOT EXISTS `homicidios` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `homicidios`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: homicidios
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agencia`
--

DROP TABLE IF EXISTS `agencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agencia` (
  `ID_Agency` varchar(20) NOT NULL,
  `Agency_Name` text,
  `Agency_Type` text,
  PRIMARY KEY (`ID_Agency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `homicidios`
--

DROP TABLE IF EXISTS `homicidios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homicidios` (
  `Record_ID` int NOT NULL,
  `ID_Agency` varchar(20) DEFAULT NULL,
  `ID_Location` varchar(20) DEFAULT NULL,
  `Dates` date DEFAULT NULL,
  `ID_Crime` varchar(20) NOT NULL,
  `Crime_Solved` tinyint(1) DEFAULT NULL,
  `ID_Victim` varchar(20) NOT NULL,
  `ID_Perpetrator` varchar(20) NOT NULL,
  `ID_Relationship` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Record_ID`),
  KEY `FK_Homicidios_ID_Agency` (`ID_Agency`),
  KEY `FK_Homicidios_ID_Location` (`ID_Location`),
  KEY `FK_Homicidios_ID_Crime` (`ID_Crime`),
  KEY `FK_Homicidios_ID_Victim` (`ID_Victim`),
  KEY `FK_Homicidios_ID_Perpetrator` (`ID_Perpetrator`),
  KEY `FK_Homicidios_ID_Relationship` (`ID_Relationship`),
  CONSTRAINT `FK_Homicidios_ID_Agency` FOREIGN KEY (`ID_Agency`) REFERENCES `agencia` (`ID_Agency`),
  CONSTRAINT `FK_Homicidios_ID_Crime` FOREIGN KEY (`ID_Crime`) REFERENCES `tipo_de_homicidio` (`ID_Crime`),
  CONSTRAINT `FK_Homicidios_ID_Location` FOREIGN KEY (`ID_Location`) REFERENCES `ubicacion` (`ID_Location`),
  CONSTRAINT `FK_Homicidios_ID_Perpetrator` FOREIGN KEY (`ID_Perpetrator`) REFERENCES `victimarios` (`ID_Perpetrator`),
  CONSTRAINT `FK_Homicidios_ID_Relationship` FOREIGN KEY (`ID_Relationship`) REFERENCES `relacion` (`ID_Relationship`),
  CONSTRAINT `FK_Homicidios_ID_Victim` FOREIGN KEY (`ID_Victim`) REFERENCES `victimas` (`ID_Victim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_auditoria`
--

DROP TABLE IF EXISTS `log_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_auditoria` (
  `ID_log` int NOT NULL AUTO_INCREMENT,
  `Nombre_de_accion` varchar(10) DEFAULT NULL,
  `Nombre_tabla` varchar(50) DEFAULT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_UPD_INS_DEL` date DEFAULT NULL,
  PRIMARY KEY (`ID_log`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_auditoria_2`
--

DROP TABLE IF EXISTS `log_auditoria_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_auditoria_2` (
  `ID_log` int NOT NULL AUTO_INCREMENT,
  `Valor_anterior` varchar(200) DEFAULT NULL,
  `Valor_nuevo` varchar(200) DEFAULT NULL,
  `Nombre_de_accion` varchar(10) DEFAULT NULL,
  `Nombre_tabla` varchar(50) DEFAULT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_UPD_INS_DEL` date DEFAULT NULL,
  PRIMARY KEY (`ID_log`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relacion`
--

DROP TABLE IF EXISTS `relacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relacion` (
  `ID_Relationship` varchar(50) NOT NULL,
  `Relationship` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_Relationship`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_de_homicidio`
--

DROP TABLE IF EXISTS `tipo_de_homicidio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_de_homicidio` (
  `ID_Crime` varchar(20) NOT NULL,
  `Crime_Type` text,
  `Weapon` text,
  PRIMARY KEY (`ID_Crime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubicacion` (
  `ID_Location` varchar(20) NOT NULL,
  `City` text,
  `State` text,
  PRIMARY KEY (`ID_Location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `victimarios`
--

DROP TABLE IF EXISTS `victimarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `victimarios` (
  `ID_Perpetrator` varchar(20) NOT NULL,
  `Incident` int DEFAULT NULL,
  `Perpetrator_Sex` varchar(20) DEFAULT NULL,
  `Perpetrator_Age` int DEFAULT NULL,
  `Perpetrator_Race` text,
  PRIMARY KEY (`ID_Perpetrator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `victimas`
--

DROP TABLE IF EXISTS `victimas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `victimas` (
  `ID_Victim` varchar(20) NOT NULL,
  `Victim_Sex` varchar(20) DEFAULT NULL,
  `Victim_Age` int DEFAULT NULL,
  `Victim_Race` text,
  PRIMARY KEY (`ID_Victim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vw_asesinatos_resueltos_alaska`
--

DROP TABLE IF EXISTS `vw_asesinatos_resueltos_alaska`;
/*!50001 DROP VIEW IF EXISTS `vw_asesinatos_resueltos_alaska`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_asesinatos_resueltos_alaska` AS SELECT 
 1 AS `Dates`,
 1 AS `Agency_name`,
 1 AS `City`,
 1 AS `Weapon`,
 1 AS `Relationship`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_cantidad_asesinos_por_sexo_raza_y_arma_homicida`
--

DROP TABLE IF EXISTS `vw_cantidad_asesinos_por_sexo_raza_y_arma_homicida`;
/*!50001 DROP VIEW IF EXISTS `vw_cantidad_asesinos_por_sexo_raza_y_arma_homicida`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_cantidad_asesinos_por_sexo_raza_y_arma_homicida` AS SELECT 
 1 AS `perpetrator_sex`,
 1 AS `perpetrator_race`,
 1 AS `weapon`,
 1 AS `Cantidad`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_crimen_no_resuleto_menor_15`
--

DROP TABLE IF EXISTS `vw_crimen_no_resuleto_menor_15`;
/*!50001 DROP VIEW IF EXISTS `vw_crimen_no_resuleto_menor_15`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_crimen_no_resuleto_menor_15` AS SELECT 
 1 AS `Fecha_del_crimen`,
 1 AS `Fue_resuelto`,
 1 AS `Sexo_de_la_victima`,
 1 AS `Edad_de_la_victima`,
 1 AS `Relacion_con_el_asesino`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_crimen_no_resuleto_menor_15_anios`
--

DROP TABLE IF EXISTS `vw_crimen_no_resuleto_menor_15_anios`;
/*!50001 DROP VIEW IF EXISTS `vw_crimen_no_resuleto_menor_15_anios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_crimen_no_resuleto_menor_15_anios` AS SELECT 
 1 AS `Fecha_del_crimen`,
 1 AS `Fue_resuelto`,
 1 AS `Sexo_de_la_victima`,
 1 AS `Edad_de_la_victima`,
 1 AS `Relacion_con_el_asesino`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_crimenes_no_resuletos_menores_15_anios`
--

DROP TABLE IF EXISTS `vw_crimenes_no_resuletos_menores_15_anios`;
/*!50001 DROP VIEW IF EXISTS `vw_crimenes_no_resuletos_menores_15_anios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_crimenes_no_resuletos_menores_15_anios` AS SELECT 
 1 AS `Fecha_del_crimen`,
 1 AS `Sexo_de_la_victima`,
 1 AS `victim_age`,
 1 AS `Edad_de_la_victima`,
 1 AS `Relacion_con_el_asesino`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_dates_record_agency_perpetrator`
--

DROP TABLE IF EXISTS `vw_dates_record_agency_perpetrator`;
/*!50001 DROP VIEW IF EXISTS `vw_dates_record_agency_perpetrator`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_dates_record_agency_perpetrator` AS SELECT 
 1 AS `Dates`,
 1 AS `Record_ID`,
 1 AS `ID_Agency`,
 1 AS `ID_Perpetrator`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_ranking_asesinatos_por_estado`
--

DROP TABLE IF EXISTS `vw_ranking_asesinatos_por_estado`;
/*!50001 DROP VIEW IF EXISTS `vw_ranking_asesinatos_por_estado`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_ranking_asesinatos_por_estado` AS SELECT 
 1 AS `State`,
 1 AS `Cantidad_crimenes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_top_10_agencias_con_mas_casos_resueltos`
--

DROP TABLE IF EXISTS `vw_top_10_agencias_con_mas_casos_resueltos`;
/*!50001 DROP VIEW IF EXISTS `vw_top_10_agencias_con_mas_casos_resueltos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_top_10_agencias_con_mas_casos_resueltos` AS SELECT 
 1 AS `Agency_name`,
 1 AS `Agency_Type`,
 1 AS `Cantidad_de_crimenes_resuletos`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_asesinatos_resueltos_alaska`
--

/*!50001 DROP VIEW IF EXISTS `vw_asesinatos_resueltos_alaska`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_asesinatos_resueltos_alaska` AS select `h`.`Dates` AS `Dates`,`a`.`Agency_Name` AS `Agency_name`,`u`.`City` AS `City`,`tdh`.`Weapon` AS `Weapon`,`r`.`Relationship` AS `Relationship` from ((((`homicidios` `h` join `ubicacion` `u` on((`u`.`ID_Location` = `h`.`ID_Location`))) join `agencia` `a` on((`a`.`ID_Agency` = `h`.`ID_Agency`))) join `tipo_de_homicidio` `tdh` on((`tdh`.`ID_Crime` = `h`.`ID_Crime`))) join `relacion` `r` on((`r`.`ID_Relationship` = `h`.`ID_Relationship`))) where ((`u`.`State` = 'Alaska') and (`h`.`Crime_Solved` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_cantidad_asesinos_por_sexo_raza_y_arma_homicida`
--

/*!50001 DROP VIEW IF EXISTS `vw_cantidad_asesinos_por_sexo_raza_y_arma_homicida`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_cantidad_asesinos_por_sexo_raza_y_arma_homicida` AS select `v`.`Perpetrator_Sex` AS `perpetrator_sex`,`v`.`Perpetrator_Race` AS `perpetrator_race`,`tdh`.`Weapon` AS `weapon`,count(0) AS `Cantidad` from ((`homicidios` `h` join `victimarios` `v` on((`v`.`ID_Perpetrator` = `h`.`ID_Perpetrator`))) join `tipo_de_homicidio` `tdh` on((`tdh`.`ID_Crime` = `h`.`ID_Crime`))) where ((`v`.`Perpetrator_Sex` <> 'Unknown') and (`v`.`Perpetrator_Race` <> 'Unknown') and (`tdh`.`Weapon` <> 'Unknown')) group by `v`.`Perpetrator_Sex`,`v`.`Perpetrator_Race`,`tdh`.`Weapon` order by `Cantidad` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_crimen_no_resuleto_menor_15`
--

/*!50001 DROP VIEW IF EXISTS `vw_crimen_no_resuleto_menor_15`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_crimen_no_resuleto_menor_15` AS select `h`.`Dates` AS `Fecha_del_crimen`,`h`.`Crime_Solved` AS `Fue_resuelto`,`v`.`Victim_Sex` AS `Sexo_de_la_victima`,`v`.`Victim_Age` AS `Edad_de_la_victima`,`r`.`Relationship` AS `Relacion_con_el_asesino` from (((`homicidios` `h` join `victimas` `v` on((`v`.`ID_Victim` = `h`.`ID_Victim`))) join `ubicacion` on((`h`.`ID_Location` = `ubicacion`.`ID_Location`))) join `relacion` `r` on((`r`.`ID_Relationship` = `h`.`ID_Relationship`))) where ((`v`.`Victim_Age` < 15) and (`r`.`Relationship` <> 'Unknown') and (`h`.`Crime_Solved` = 0)) order by `v`.`Victim_Age` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_crimen_no_resuleto_menor_15_anios`
--

/*!50001 DROP VIEW IF EXISTS `vw_crimen_no_resuleto_menor_15_anios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_crimen_no_resuleto_menor_15_anios` AS select `h`.`Dates` AS `Fecha_del_crimen`,`h`.`Crime_Solved` AS `Fue_resuelto`,`v`.`Victim_Sex` AS `Sexo_de_la_victima`,`v`.`Victim_Age` AS `Edad_de_la_victima`,`r`.`Relationship` AS `Relacion_con_el_asesino` from (((`homicidios` `h` join `victimas` `v` on((`v`.`ID_Victim` = `h`.`ID_Victim`))) join `ubicacion` on((`h`.`ID_Location` = `ubicacion`.`ID_Location`))) join `relacion` `r` on((`r`.`ID_Relationship` = `h`.`ID_Relationship`))) where ((`v`.`Victim_Age` < 15) and (`r`.`Relationship` <> 'Unknown') and (`h`.`Crime_Solved` = 0)) order by `v`.`Victim_Age` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_crimenes_no_resuletos_menores_15_anios`
--

/*!50001 DROP VIEW IF EXISTS `vw_crimenes_no_resuletos_menores_15_anios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_crimenes_no_resuletos_menores_15_anios` AS select `h`.`Dates` AS `Fecha_del_crimen`,`v`.`Victim_Sex` AS `Sexo_de_la_victima`,`v`.`Victim_Age` AS `victim_age`,`r`.`Relationship` AS `Edad_de_la_victima`,`r`.`Relationship` AS `Relacion_con_el_asesino` from (((`homicidios` `h` join `victimas` `v` on((`v`.`ID_Victim` = `h`.`ID_Victim`))) join `ubicacion` on((`h`.`ID_Location` = `ubicacion`.`ID_Location`))) join `relacion` `r` on((`r`.`ID_Relationship` = `h`.`ID_Relationship`))) where ((`v`.`Victim_Age` < 15) and (`r`.`Relationship` <> 'Unknown') and (`h`.`Crime_Solved` = 0)) order by `v`.`Victim_Age` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dates_record_agency_perpetrator`
--

/*!50001 DROP VIEW IF EXISTS `vw_dates_record_agency_perpetrator`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dates_record_agency_perpetrator` AS select `homicidios`.`Dates` AS `Dates`,`homicidios`.`Record_ID` AS `Record_ID`,`homicidios`.`ID_Agency` AS `ID_Agency`,`homicidios`.`ID_Perpetrator` AS `ID_Perpetrator` from (`homicidios` join `ubicacion` on((`homicidios`.`ID_Location` = `ubicacion`.`ID_Location`))) where ((`ubicacion`.`State` = 'Alaska') and (`homicidios`.`Crime_Solved` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_ranking_asesinatos_por_estado`
--

/*!50001 DROP VIEW IF EXISTS `vw_ranking_asesinatos_por_estado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_ranking_asesinatos_por_estado` AS select `u`.`State` AS `State`,count(0) AS `Cantidad_crimenes` from ((`homicidios` `h` join `ubicacion` `u` on((`u`.`ID_Location` = `h`.`ID_Location`))) join `tipo_de_homicidio` `tdh` on((`tdh`.`ID_Crime` = `h`.`ID_Crime`))) where (`tdh`.`Crime_Type` = 'Murder or Manslaughter') group by `u`.`State` order by `Cantidad_crimenes` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_top_10_agencias_con_mas_casos_resueltos`
--

/*!50001 DROP VIEW IF EXISTS `vw_top_10_agencias_con_mas_casos_resueltos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_top_10_agencias_con_mas_casos_resueltos` AS select `a`.`Agency_Name` AS `Agency_name`,`a`.`Agency_Type` AS `Agency_Type`,sum(`h`.`Crime_Solved`) AS `Cantidad_de_crimenes_resuletos` from (`homicidios` `h` join `agencia` `a` on((`a`.`ID_Agency` = `h`.`ID_Agency`))) group by `a`.`Agency_Name`,`a`.`Agency_Type`,`h`.`Crime_Solved` order by `Cantidad_de_crimenes_resuletos` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-21 11:33:33
