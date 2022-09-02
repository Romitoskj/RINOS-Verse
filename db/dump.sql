-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: rinos
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `allenamenti_programmati_squadre`
--

DROP TABLE IF EXISTS `allenamenti_programmati_squadre`;
/*!50001 DROP VIEW IF EXISTS `allenamenti_programmati_squadre`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `allenamenti_programmati_squadre` (
  `squadra` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `data_ora_inizio` tinyint NOT NULL,
  `ora_fine` tinyint NOT NULL,
  `stato` tinyint NOT NULL,
  `citta` tinyint NOT NULL,
  `via` tinyint NOT NULL,
  `civico` tinyint NOT NULL,
  `motivazione` tinyint NOT NULL,
  `stagione` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `allenamento`
--

DROP TABLE IF EXISTS `allenamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allenamento` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_ora_inizio` datetime NOT NULL,
  `ora_fine` time DEFAULT NULL,
  `stato` enum('PROGRAMMATO','ANNULLATO','SVOLTO') NOT NULL DEFAULT 'PROGRAMMATO',
  `citta` varchar(30) DEFAULT NULL,
  `via` varchar(50) DEFAULT NULL,
  `civico` smallint(6) DEFAULT NULL,
  `motivazione` varchar(120) DEFAULT NULL,
  `stagione` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stagione` (`stagione`),
  CONSTRAINT `allenamento_ibfk_1` FOREIGN KEY (`stagione`) REFERENCES `stagione` (`anno_inizio`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `inizio_fine` CHECK (cast(`data_ora_inizio` as time) < `ora_fine`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allenamento`
--

LOCK TABLES `allenamento` WRITE;
/*!40000 ALTER TABLE `allenamento` DISABLE KEYS */;
INSERT INTO `allenamento` VALUES (1,'2022-06-27 14:07:44',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(2,'2022-06-30 14:08:08',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(5,'2022-08-28 21:14:51',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(6,'2022-06-28 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(7,'2022-06-29 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(8,'2022-06-30 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(9,'2022-06-30 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(10,'2022-07-01 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(11,'2022-07-02 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(12,'2022-07-03 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(13,'2022-07-04 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(14,'2022-07-05 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(15,'2022-07-06 17:00:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(16,'2022-09-20 14:00:00',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(17,'2022-08-30 12:00:00','14:00:00','ANNULLATO',NULL,NULL,NULL,'NEVICA',2022),(18,'2022-06-09 13:53:19',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(19,'2022-07-06 13:53:43',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2022),(20,'2022-08-29 14:00:00',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(21,'2021-07-20 15:08:00',NULL,'SVOLTO',NULL,NULL,NULL,NULL,2021),(22,'2022-09-01 18:00:00',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(23,'2022-09-27 13:32:52',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(25,'2022-10-12 17:30:00',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(26,'2022-11-10 17:00:00',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(27,'2022-10-15 10:30:00',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(28,'2022-09-02 17:30:00',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022),(29,'2022-09-10 17:30:00',NULL,'PROGRAMMATO',NULL,NULL,NULL,NULL,2022);
/*!40000 ALTER TABLE `allenamento` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS nuovo_allenamento
BEFORE INSERT ON Allenamento
FOR EACH ROW
BEGIN
    IF NEW.data_ora_inizio <= NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La data selezionata non è corretta";
    END IF;

    IF NEW.stato <> 'PROGRAMMATO' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento non può essere inserito come annullato o svolto";
    END IF;

    IF (
        SELECT corrente 
        FROM Stagione
        WHERE anno_inizio = NEW.stagione
    ) IS FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento deve far parte del calendario della stagione in corso";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS allenamento_svolto
BEFORE UPDATE ON Allenamento
FOR EACH ROW
BEGIN
    IF NEW.stato = 'SVOLTO' THEN
        IF OLD.stato = 'ANNULLATO' THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Impossibile svolgere un allenamento annullato";
ELSEIF NOT EXISTS (SELECT * FROM Direzione WHERE allenamento = NEW.id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento non ha nessun allenatore che l'ha diretto";
        ELSEIF NOT EXISTS (SELECT * FROM Presenza WHERE allenamento = NEW.id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento non ha nessun atleta presente";
        ELSEIF NOT EXISTS (SELECT * FROM Svolgimento WHERE allenamento = NEW.id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento non ha nessun esercizio svolto";
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `allenatore`
--

DROP TABLE IF EXISTS `allenatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allenatore` (
  `utente` int(10) unsigned NOT NULL,
  PRIMARY KEY (`utente`),
  CONSTRAINT `allenatore_ibfk_1` FOREIGN KEY (`utente`) REFERENCES `utente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allenatore`
--

LOCK TABLES `allenatore` WRITE;
/*!40000 ALTER TABLE `allenatore` DISABLE KEYS */;
INSERT INTO `allenatore` VALUES (4),(6),(22),(30);
/*!40000 ALTER TABLE `allenatore` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS allenatore_maggiorenne
BEFORE INSERT ON Allenatore
FOR EACH ROW
BEGIN
    IF getUserAge(NEW.utente) < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un allenatore deve essere maggiorenne";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `amministrazione`
--

DROP TABLE IF EXISTS `amministrazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amministrazione` (
  `allenatore` int(10) unsigned NOT NULL,
  `squadra_ev` int(10) unsigned NOT NULL,
  `data_ev` datetime NOT NULL,
  PRIMARY KEY (`allenatore`,`squadra_ev`,`data_ev`),
  KEY `squadra_ev` (`squadra_ev`,`data_ev`),
  CONSTRAINT `amministrazione_ibfk_1` FOREIGN KEY (`allenatore`) REFERENCES `allenatore` (`utente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `amministrazione_ibfk_2` FOREIGN KEY (`squadra_ev`, `data_ev`) REFERENCES `evento` (`squadra`, `data_ora_inizio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amministrazione`
--

LOCK TABLES `amministrazione` WRITE;
/*!40000 ALTER TABLE `amministrazione` DISABLE KEYS */;
INSERT INTO `amministrazione` VALUES (4,2,'2022-09-18 12:30:00'),(22,1,'2022-08-17 14:00:00'),(22,2,'2022-08-27 12:00:00'),(22,2,'2022-09-11 11:30:00'),(22,2,'2022-09-25 13:00:00');
/*!40000 ALTER TABLE `amministrazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assunzione`
--

DROP TABLE IF EXISTS `assunzione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assunzione` (
  `ruolo` varchar(30) NOT NULL,
  `atleta` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ruolo`,`atleta`),
  KEY `atleta` (`atleta`),
  CONSTRAINT `assunzione_ibfk_1` FOREIGN KEY (`atleta`) REFERENCES `atleta` (`utente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assunzione_ibfk_2` FOREIGN KEY (`ruolo`) REFERENCES `ruolo` (`nome`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assunzione`
--

LOCK TABLES `assunzione` WRITE;
/*!40000 ALTER TABLE `assunzione` DISABLE KEYS */;
/*!40000 ALTER TABLE `assunzione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atleta`
--

DROP TABLE IF EXISTS `atleta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atleta` (
  `utente` int(10) unsigned NOT NULL,
  PRIMARY KEY (`utente`),
  CONSTRAINT `atleta_ibfk_1` FOREIGN KEY (`utente`) REFERENCES `utente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atleta`
--

LOCK TABLES `atleta` WRITE;
/*!40000 ALTER TABLE `atleta` DISABLE KEYS */;
INSERT INTO `atleta` VALUES (1),(3),(4),(7),(8),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(24),(25),(26),(27),(29),(30),(35);
/*!40000 ALTER TABLE `atleta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `calendario`
--

DROP TABLE IF EXISTS `calendario`;
/*!50001 DROP VIEW IF EXISTS `calendario`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `calendario` (
  `squadra` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `data_ora_inizio` tinyint NOT NULL,
  `id_allenamento` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `id` varchar(4) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `tipo` enum('RUGBY','MINIRUGBY') NOT NULL,
  `eta_min` tinyint(3) unsigned NOT NULL,
  `eta_max` tinyint(3) unsigned NOT NULL,
  `sesso` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sesso` (`sesso`),
  CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`sesso`) REFERENCES `sesso` (`value`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eta_min_max` CHECK (`eta_min` < `eta_max`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES ('SENF','SENIORES FEMMINILE','RUGBY',17,42,'F'),('SENM','SENIORES MASCHILE','RUGBY',17,42,'M'),('U11','UNDER 11','MINIRUGBY',9,10,NULL),('U13','UNDER 13','MINIRUGBY',11,12,NULL),('U15F','UNDER 15 FEMMINILE','RUGBY',13,14,'F'),('U15M','UNDER 15 MASCHILE','RUGBY',13,14,'M'),('U17F','UNDER 17 FEMMINILE','RUGBY',15,16,'F'),('U17M','UNDER 17 MASCHILE','RUGBY',15,16,'M'),('U19F','UNDER 19 FEMMINILE','RUGBY',17,19,'F'),('U19M','UNDER 19 MASCHILE','RUGBY',17,19,'M'),('U5','UNDER 5','MINIRUGBY',3,4,NULL),('U7','UNDER 7','MINIRUGBY',5,6,NULL),('U9','UNDER 9','MINIRUGBY',7,8,NULL);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS sesso_categoria
BEFORE INSERT ON Categoria
FOR EACH ROW
BEGIN
    IF NEW.tipo = 'RUGBY' AND NEW.sesso IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Bisogna specificare il sesso degli atleti";
    END IF;

    IF NEW.tipo = 'MINIRUGBY' AND NEW.sesso IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Il sesso degli atleti non deve essere specificato";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `classificazionedomanda`
--

DROP TABLE IF EXISTS `classificazionedomanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classificazionedomanda` (
  `domanda` int(10) unsigned NOT NULL,
  `etichetta` varchar(30) NOT NULL,
  PRIMARY KEY (`domanda`,`etichetta`),
  KEY `etichetta` (`etichetta`),
  CONSTRAINT `classificazionedomanda_ibfk_1` FOREIGN KEY (`domanda`) REFERENCES `domanda` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `classificazionedomanda_ibfk_2` FOREIGN KEY (`etichetta`) REFERENCES `etichetta` (`testo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classificazionedomanda`
--

LOCK TABLES `classificazionedomanda` WRITE;
/*!40000 ALTER TABLE `classificazionedomanda` DISABLE KEYS */;
INSERT INTO `classificazionedomanda` VALUES (1,'attacco'),(1,'calcio'),(1,'passaggio'),(2,'passaggio'),(3,'attacco'),(3,'passaggio'),(4,'attacco'),(5,'superiorità numerica'),(6,'difesa'),(6,'placcaggio'),(6,'ranghi ridotti'),(7,'ricezione calci'),(8,'mischia'),(8,'strutture di gioco'),(9,'attacco'),(9,'ruck'),(10,'tecnica individuale'),(10,'touche');
/*!40000 ALTER TABLE `classificazionedomanda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classificazioneesercizio`
--

DROP TABLE IF EXISTS `classificazioneesercizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classificazioneesercizio` (
  `esercizio` int(10) unsigned NOT NULL,
  `etichetta` varchar(30) NOT NULL,
  PRIMARY KEY (`esercizio`,`etichetta`),
  KEY `etichetta` (`etichetta`),
  CONSTRAINT `classificazioneesercizio_ibfk_1` FOREIGN KEY (`esercizio`) REFERENCES `esercizio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `classificazioneesercizio_ibfk_2` FOREIGN KEY (`etichetta`) REFERENCES `etichetta` (`testo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classificazioneesercizio`
--

LOCK TABLES `classificazioneesercizio` WRITE;
/*!40000 ALTER TABLE `classificazioneesercizio` DISABLE KEYS */;
INSERT INTO `classificazioneesercizio` VALUES (2,'attacco'),(2,'passaggio'),(3,'passaggio'),(3,'superiorità numerica'),(3,'tecnica individuale'),(4,'attacco'),(4,'difesa'),(4,'placcaggio'),(5,'collettivo'),(5,'passaggio'),(6,'difesa'),(6,'placcaggio'),(7,'passaggio'),(7,'tecnica individuale');
/*!40000 ALTER TABLE `classificazioneesercizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classificazioneobiettivo`
--

DROP TABLE IF EXISTS `classificazioneobiettivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classificazioneobiettivo` (
  `obiettivo` int(10) unsigned NOT NULL,
  `etichetta` varchar(30) NOT NULL,
  PRIMARY KEY (`obiettivo`,`etichetta`),
  KEY `etichetta` (`etichetta`),
  CONSTRAINT `classificazioneobiettivo_ibfk_1` FOREIGN KEY (`obiettivo`) REFERENCES `obiettivo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `classificazioneobiettivo_ibfk_2` FOREIGN KEY (`etichetta`) REFERENCES `etichetta` (`testo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classificazioneobiettivo`
--

LOCK TABLES `classificazioneobiettivo` WRITE;
/*!40000 ALTER TABLE `classificazioneobiettivo` DISABLE KEYS */;
INSERT INTO `classificazioneobiettivo` VALUES (3,'attacco'),(3,'passaggio');
/*!40000 ALTER TABLE `classificazioneobiettivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composizione`
--

DROP TABLE IF EXISTS `composizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `composizione` (
  `domanda` int(10) unsigned NOT NULL,
  `report` int(10) unsigned NOT NULL,
  `valutazione` int(11) NOT NULL CHECK (`valutazione` > 0 and `valutazione` <= 10),
  PRIMARY KEY (`domanda`,`report`),
  KEY `report` (`report`),
  CONSTRAINT `composizione_ibfk_1` FOREIGN KEY (`domanda`) REFERENCES `domanda` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `composizione_ibfk_2` FOREIGN KEY (`report`) REFERENCES `report` (`allenamento`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composizione`
--

LOCK TABLES `composizione` WRITE;
/*!40000 ALTER TABLE `composizione` DISABLE KEYS */;
INSERT INTO `composizione` VALUES (1,1,6),(1,2,6),(1,7,5),(1,8,8),(2,1,6),(2,2,7),(2,7,6),(2,8,1),(3,13,2),(4,19,4),(4,21,3),(5,14,5),(5,15,9),(5,18,5),(6,8,7),(6,19,6),(7,18,8),(8,10,5),(9,2,10),(9,21,6);
/*!40000 ALTER TABLE `composizione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `contatti_atleti_tutori`
--

DROP TABLE IF EXISTS `contatti_atleti_tutori`;
/*!50001 DROP VIEW IF EXISTS `contatti_atleti_tutori`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `contatti_atleti_tutori` (
  `atleta` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `cognome` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `telefono` tinyint NOT NULL,
  `tutore` tinyint NOT NULL,
  `nome_tutore` tinyint NOT NULL,
  `cognome_tutore` tinyint NOT NULL,
  `email_tutore` tinyint NOT NULL,
  `telefono_tutore` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `direzione`
--

DROP TABLE IF EXISTS `direzione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `direzione` (
  `allenatore` int(10) unsigned NOT NULL,
  `allenamento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`allenamento`,`allenatore`),
  KEY `allenatore` (`allenatore`),
  CONSTRAINT `direzione_ibfk_1` FOREIGN KEY (`allenamento`) REFERENCES `allenamento` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `direzione_ibfk_2` FOREIGN KEY (`allenatore`) REFERENCES `allenatore` (`utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direzione`
--

LOCK TABLES `direzione` WRITE;
/*!40000 ALTER TABLE `direzione` DISABLE KEYS */;
INSERT INTO `direzione` VALUES (6,1),(4,2),(22,6),(22,7),(22,8),(22,9),(22,10),(22,11),(22,12),(22,13),(22,14),(22,15),(4,18),(4,19),(4,21);
/*!40000 ALTER TABLE `direzione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dirigente`
--

DROP TABLE IF EXISTS `dirigente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dirigente` (
  `utente` int(10) unsigned NOT NULL,
  PRIMARY KEY (`utente`),
  CONSTRAINT `dirigente_ibfk_1` FOREIGN KEY (`utente`) REFERENCES `utente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dirigente`
--

LOCK TABLES `dirigente` WRITE;
/*!40000 ALTER TABLE `dirigente` DISABLE KEYS */;
INSERT INTO `dirigente` VALUES (30);
/*!40000 ALTER TABLE `dirigente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS dirigente_maggiorenne
BEFORE INSERT ON Dirigente
FOR EACH ROW
BEGIN
    IF getUserAge(NEW.utente) < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un dirigente deve essere maggiorenne";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `domanda`
--

DROP TABLE IF EXISTS `domanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domanda` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testo` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `testo` (`testo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domanda`
--

LOCK TABLES `domanda` WRITE;
/*!40000 ALTER TABLE `domanda` DISABLE KEYS */;
INSERT INTO `domanda` VALUES (1,'domanda 1'),(10,'domanda 10'),(2,'domanda 2'),(3,'domanda 3'),(4,'domanda 4'),(5,'domanda 5'),(6,'domanda 6'),(7,'domanda 7'),(8,'domanda 8'),(9,'domanda 9\r\n');
/*!40000 ALTER TABLE `domanda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `domande_numero_risposte`
--

DROP TABLE IF EXISTS `domande_numero_risposte`;
/*!50001 DROP VIEW IF EXISTS `domande_numero_risposte`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `domande_numero_risposte` (
  `etichetta` tinyint NOT NULL,
  `testo` tinyint NOT NULL,
  `numero_risposte` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `eseguibilita`
--

DROP TABLE IF EXISTS `eseguibilita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eseguibilita` (
  `categoria` varchar(4) NOT NULL,
  `esercizio` int(10) unsigned NOT NULL,
  PRIMARY KEY (`categoria`,`esercizio`),
  KEY `esercizio` (`esercizio`),
  CONSTRAINT `eseguibilita_ibfk_1` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eseguibilita_ibfk_2` FOREIGN KEY (`esercizio`) REFERENCES `esercizio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eseguibilita`
--

LOCK TABLES `eseguibilita` WRITE;
/*!40000 ALTER TABLE `eseguibilita` DISABLE KEYS */;
INSERT INTO `eseguibilita` VALUES ('U15M',3),('U15M',7),('U17M',2),('U5',5);
/*!40000 ALTER TABLE `eseguibilita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `esercizio`
--

DROP TABLE IF EXISTS `esercizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `esercizio` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descrizione` text NOT NULL,
  `n_partecipanti` tinyint(3) unsigned DEFAULT NULL,
  `link_video` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `esercizio`
--

LOCK TABLES `esercizio` WRITE;
/*!40000 ALTER TABLE `esercizio` DISABLE KEYS */;
INSERT INTO `esercizio` VALUES (1,'ESEMPIO','esercizio d\'esempio',NULL,NULL),(2,'Passaggi in linea','',NULL,NULL),(3,'2 vs 1','',NULL,NULL),(4,'1 vs 1','',NULL,NULL),(5,'gioco dei passaggi','',NULL,NULL),(6,'1 vs 1 su linea retta','',NULL,NULL),(7,'croci','',NULL,NULL);
/*!40000 ALTER TABLE `esercizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etichetta`
--

DROP TABLE IF EXISTS `etichetta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etichetta` (
  `testo` varchar(30) NOT NULL CHECK (`testo` regexp '[A-Za-z0-9]'),
  PRIMARY KEY (`testo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etichetta`
--

LOCK TABLES `etichetta` WRITE;
/*!40000 ALTER TABLE `etichetta` DISABLE KEYS */;
INSERT INTO `etichetta` VALUES ('attacco'),('calcio'),('cambi di direzione'),('collettivo'),('difesa'),('evasione'),('gioco'),('maul'),('mischia'),('passaggio'),('placcaggio'),('preparazione atletica'),('ranghi ridotti'),('ricezione calci'),('riscaldamento'),('ruck'),('strutture di gioco'),('superiorità numerica'),('tecnica individuale'),('touche');
/*!40000 ALTER TABLE `etichetta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evento` (
  `data_ora_inizio` datetime NOT NULL,
  `squadra` int(10) unsigned NOT NULL,
  `nome` varchar(30) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `data_ora_fine` datetime DEFAULT NULL,
  `citta` varchar(30) NOT NULL,
  `via` varchar(50) NOT NULL,
  `civico` smallint(6) DEFAULT NULL,
  `annullato` tinyint(1) NOT NULL DEFAULT 0,
  `motivazione` varchar(120) DEFAULT NULL,
  `accompagnatore` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`data_ora_inizio`,`squadra`),
  KEY `squadra` (`squadra`),
  KEY `accompagnatore` (`accompagnatore`),
  CONSTRAINT `evento_ibfk_1` FOREIGN KEY (`squadra`) REFERENCES `squadra` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `evento_ibfk_2` FOREIGN KEY (`accompagnatore`) REFERENCES `dirigente` (`utente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `inizio_e_fine` CHECK (`data_ora_inizio` < `data_ora_fine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES ('2022-08-17 14:00:00',1,'eventolo',NULL,NULL,'roma','le mani dal naso',NULL,0,NULL,NULL),('2022-08-27 12:00:00',2,'esempio annullato',NULL,NULL,'Roma','Viale di Tor di Quinto',NULL,1,'Maltempo',NULL),('2022-08-31 14:05:26',14,'Giornata 1 campionato',NULL,NULL,'Roma','Via di villa spada',NULL,0,NULL,NULL),('2022-09-10 18:30:00',14,'Riunione inizio stagione',NULL,NULL,'Roma','Via di villa spada',64,0,NULL,NULL),('2022-09-11 11:30:00',2,'Partita VS Lazio',NULL,NULL,'Roma','Viale di Tor di Quinto',57,0,NULL,NULL),('2022-09-18 12:30:00',2,'Cena di inizio stagione',NULL,NULL,'Roma','Via val senio',7,0,NULL,NULL),('2022-09-25 13:00:00',2,'Partita VS Frascati','Il fischio di inizio è alle 15 ma ci ritroviamo al campo due ore prima.',NULL,'Roma','Via di villa spada',64,0,NULL,NULL),('2022-10-26 18:00:00',2,'Torneo touch rugby',NULL,NULL,'Roma','Via di villa spada',64,0,NULL,NULL);
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS nuovo_evento
BEFORE INSERT ON Evento
FOR EACH ROW
BEGIN
    IF NEW.data_ora_inizio <= NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La data selezionata non è corretta";
    END IF;

    IF NEW.annullato IS TRUE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'evento non può essere inserito come annullato";
    END IF;

    IF (
        SELECT corrente 
        FROM Squadra JOIN Stagione ON stagione = anno_inizio
        WHERE id = NEW.squadra
    ) IS FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La squadra non è attiva nella stagione corrente";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `inviti_senza_risposta_o_assenti`
--

DROP TABLE IF EXISTS `inviti_senza_risposta_o_assenti`;
/*!50001 DROP VIEW IF EXISTS `inviti_senza_risposta_o_assenti`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `inviti_senza_risposta_o_assenti` (
  `atleta` tinyint NOT NULL,
  `squadra_ev` tinyint NOT NULL,
  `data_ev` tinyint NOT NULL,
  `presenza` tinyint NOT NULL,
  `motivazione` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `invito`
--

DROP TABLE IF EXISTS `invito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invito` (
  `atleta` int(10) unsigned NOT NULL,
  `squadra_ev` int(10) unsigned NOT NULL,
  `data_ev` datetime NOT NULL,
  `presenza` tinyint(1) DEFAULT NULL,
  `motivazione` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`atleta`,`squadra_ev`,`data_ev`),
  KEY `squadra_ev` (`squadra_ev`,`data_ev`),
  CONSTRAINT `invito_ibfk_1` FOREIGN KEY (`atleta`) REFERENCES `atleta` (`utente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `invito_ibfk_2` FOREIGN KEY (`squadra_ev`, `data_ev`) REFERENCES `evento` (`squadra`, `data_ora_inizio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invito`
--

LOCK TABLES `invito` WRITE;
/*!40000 ALTER TABLE `invito` DISABLE KEYS */;
INSERT INTO `invito` VALUES (4,1,'2022-08-17 14:00:00',NULL,NULL),(12,2,'2022-09-11 11:30:00',1,NULL),(12,2,'2022-09-18 12:30:00',NULL,NULL),(12,2,'2022-09-25 13:00:00',1,NULL),(13,2,'2022-09-11 11:30:00',1,NULL),(13,2,'2022-09-25 13:00:00',1,NULL),(14,2,'2022-09-11 11:30:00',NULL,NULL),(14,2,'2022-09-25 13:00:00',1,NULL),(15,2,'2022-09-11 11:30:00',0,NULL),(15,2,'2022-09-25 13:00:00',1,NULL),(16,2,'2022-09-11 11:30:00',1,NULL),(16,2,'2022-09-25 13:00:00',0,'Quel weekend sono fuori Roma.'),(17,2,'2022-09-11 11:30:00',1,NULL),(17,2,'2022-09-25 13:00:00',1,NULL),(18,2,'2022-08-27 12:00:00',NULL,NULL),(18,2,'2022-09-11 11:30:00',0,NULL),(18,2,'2022-09-25 13:00:00',0,NULL),(19,2,'2022-09-11 11:30:00',0,NULL),(19,2,'2022-09-25 13:00:00',1,NULL),(20,2,'2022-09-11 11:30:00',NULL,NULL),(21,2,'2022-09-11 11:30:00',1,NULL),(24,14,'2022-09-10 18:30:00',NULL,NULL);
/*!40000 ALTER TABLE `invito` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS invito_evento
BEFORE INSERT ON invito
FOR EACH ROW
BEGIN
    IF NEW.atleta NOT IN (
        SELECT atleta
        FROM rosa
        WHERE squadra = NEW.squadra_ev
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'atleta deve far parte della squadra a cui l'evento afferisce";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `numero_allenamenti_svolti_squadre`
--

DROP TABLE IF EXISTS `numero_allenamenti_svolti_squadre`;
/*!50001 DROP VIEW IF EXISTS `numero_allenamenti_svolti_squadre`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `numero_allenamenti_svolti_squadre` (
  `squadra` tinyint NOT NULL,
  `numero` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `obiettivo`
--

DROP TABLE IF EXISTS `obiettivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obiettivo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `squadra` int(10) unsigned NOT NULL,
  `raggiunto` tinyint(1) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `scadenza` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `squadra` (`squadra`),
  CONSTRAINT `obiettivo_ibfk_1` FOREIGN KEY (`squadra`) REFERENCES `squadra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obiettivo`
--

LOCK TABLES `obiettivo` WRITE;
/*!40000 ALTER TABLE `obiettivo` DISABLE KEYS */;
INSERT INTO `obiettivo` VALUES (1,'ESEMPIO',1,1,'bisogna placcare tutto',NULL),(3,'Migliorare il passaggio',2,0,NULL,NULL),(4,'Migliorare il placcaggio',2,0,NULL,NULL),(5,'Padroneggiare schemi di attacco',2,0,NULL,NULL);
/*!40000 ALTER TABLE `obiettivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partecipazione`
--

DROP TABLE IF EXISTS `partecipazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partecipazione` (
  `squadra` int(10) unsigned NOT NULL,
  `allenamento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`allenamento`,`squadra`),
  KEY `squadra` (`squadra`),
  CONSTRAINT `partecipazione_ibfk_1` FOREIGN KEY (`allenamento`) REFERENCES `allenamento` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `partecipazione_ibfk_2` FOREIGN KEY (`squadra`) REFERENCES `squadra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partecipazione`
--

LOCK TABLES `partecipazione` WRITE;
/*!40000 ALTER TABLE `partecipazione` DISABLE KEYS */;
INSERT INTO `partecipazione` VALUES (1,1),(2,2),(1,5),(1,6),(2,6),(2,7),(13,7),(2,8),(1,9),(2,9),(2,10),(13,10),(2,11),(1,12),(2,12),(13,12),(1,13),(2,13),(1,14),(2,14),(2,15),(2,16),(14,16),(14,17),(10,18),(10,19),(2,20),(16,21),(1,22),(2,22),(2,25),(13,25),(35,25),(2,26),(2,27),(13,27),(1,28),(2,28),(1,29),(2,29);
/*!40000 ALTER TABLE `partecipazione` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS partecipazione_allenamento
BEFORE INSERT ON Partecipazione
FOR EACH ROW
BEGIN
    IF (
        SELECT stagione
        FROM Squadra
        WHERE id = NEW.squadra
    ) <> (
        SELECT stagione
        FROM Allenamento
        WHERE id = NEW.allenamento
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La squadra deve essere attiva nella stagione in cui si svolge l'allenamento";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `presenza`
--

DROP TABLE IF EXISTS `presenza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presenza` (
  `atleta` int(10) unsigned NOT NULL,
  `allenamento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`allenamento`,`atleta`),
  KEY `atleta` (`atleta`),
  CONSTRAINT `presenza_ibfk_1` FOREIGN KEY (`allenamento`) REFERENCES `allenamento` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `presenza_ibfk_2` FOREIGN KEY (`atleta`) REFERENCES `atleta` (`utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presenza`
--

LOCK TABLES `presenza` WRITE;
/*!40000 ALTER TABLE `presenza` DISABLE KEYS */;
INSERT INTO `presenza` VALUES (3,1),(16,2),(3,5),(12,6),(13,6),(17,6),(19,6),(20,6),(12,7),(13,7),(15,7),(19,7),(21,7),(12,8),(13,8),(16,8),(17,8),(18,8),(19,8),(12,9),(13,9),(14,9),(15,9),(16,9),(19,9),(20,9),(21,9),(12,10),(13,10),(16,10),(19,10),(12,11),(13,11),(15,11),(16,11),(18,11),(21,11),(12,12),(13,12),(14,12),(16,12),(17,12),(19,12),(20,12),(12,13),(15,13),(16,13),(17,13),(19,13),(20,13),(21,13),(12,14),(13,14),(16,14),(17,14),(18,14),(19,14),(21,14),(12,15),(13,15),(15,15),(16,15),(17,15),(19,15),(21,15),(26,18),(27,19),(29,21);
/*!40000 ALTER TABLE `presenza` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS presenza_allenamento
BEFORE INSERT ON presenza
FOR EACH ROW
BEGIN
    IF NEW.atleta NOT IN (
        SELECT R.atleta
        FROM Rosa AS R JOIN Partecipazione AS P ON R.squadra = P.squadra
        WHERE P.allenamento = NEW.allenamento
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'atleta deve far parte di una delle squadre che partecipano all'allenamento";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `programmazione`
--

DROP TABLE IF EXISTS `programmazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programmazione` (
  `esercizio` int(10) unsigned NOT NULL,
  `allenamento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`esercizio`,`allenamento`),
  KEY `allenamento` (`allenamento`),
  CONSTRAINT `programmazione_ibfk_1` FOREIGN KEY (`esercizio`) REFERENCES `esercizio` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `programmazione_ibfk_2` FOREIGN KEY (`allenamento`) REFERENCES `allenamento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programmazione`
--

LOCK TABLES `programmazione` WRITE;
/*!40000 ALTER TABLE `programmazione` DISABLE KEYS */;
INSERT INTO `programmazione` VALUES (2,28),(2,29),(3,26),(3,27),(3,28),(3,29),(7,26),(7,27);
/*!40000 ALTER TABLE `programmazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `allenamento` int(10) unsigned NOT NULL,
  `autore` int(10) unsigned NOT NULL,
  `valutazione` int(11) NOT NULL CHECK (`valutazione` > 0 and `valutazione` <= 10),
  `note` text DEFAULT NULL,
  PRIMARY KEY (`allenamento`),
  KEY `report_ibfk_2` (`autore`),
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`allenamento`) REFERENCES `allenamento` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `report_ibfk_2` FOREIGN KEY (`autore`) REFERENCES `allenatore` (`utente`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (1,6,7,NULL),(2,4,8,NULL),(7,22,8,NULL),(8,22,5,NULL),(9,22,7,NULL),(10,22,10,NULL),(11,22,3,NULL),(12,22,8,NULL),(13,22,6,NULL),(14,22,10,NULL),(15,22,8,NULL),(18,4,8,NULL),(19,4,5,NULL),(21,4,8,NULL);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS recensione_allenamento
BEFORE INSERT ON Report
FOR EACH ROW
BEGIN
    IF 'SVOLTO' <> (SELECT stato FROM Allenamento WHERE id = NEW.allenamento) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Si possono recensire solo allenamenti svolti";
    END IF;
    
    IF NEW.autore NOT IN (
        SELECT allenatore
        FROM Direzione 
        WHERE allenamento = NEW.allenamento
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'autore della recensione deve aver diretto il relativo allenamento";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rimuovere`
--

DROP TABLE IF EXISTS `rimuovere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rimuovere` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rimuovere`
--

LOCK TABLES `rimuovere` WRITE;
/*!40000 ALTER TABLE `rimuovere` DISABLE KEYS */;
INSERT INTO `rimuovere` VALUES (1,NULL),(2,'F'),(3,NULL),(5,'M');
/*!40000 ALTER TABLE `rimuovere` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rosa`
--

DROP TABLE IF EXISTS `rosa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rosa` (
  `atleta` int(10) unsigned NOT NULL,
  `squadra` int(10) unsigned NOT NULL,
  PRIMARY KEY (`atleta`,`squadra`),
  KEY `squadra` (`squadra`),
  CONSTRAINT `rosa_ibfk_1` FOREIGN KEY (`atleta`) REFERENCES `atleta` (`utente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `rosa_ibfk_2` FOREIGN KEY (`squadra`) REFERENCES `squadra` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rosa`
--

LOCK TABLES `rosa` WRITE;
/*!40000 ALTER TABLE `rosa` DISABLE KEYS */;
INSERT INTO `rosa` VALUES (3,1),(4,1),(7,2),(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(24,14),(25,12),(26,10),(27,10),(29,16),(30,14),(35,21);
/*!40000 ALTER TABLE `rosa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `atleta_minorenne` BEFORE INSERT ON `rosa` FOR EACH ROW BEGIN
    IF getUserAge(NEW.atleta) < 18 AND NOT EXISTS (
        SELECT *
        FROM Tutela 
        WHERE atleta = NEW.atleta
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un atleta deve essere maggiorenne o avere dei tutori per poter far parte di una rosa";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS eta_sesso_atleta
BEFORE INSERT ON Rosa
FOR EACH ROW
BEGIN
    DECLARE anno_nascita INT;
    DECLARE sesso CHAR(1);

    SET anno_nascita = (SELECT YEAR(data_nascita) FROM Utente WHERE id = NEW.atleta);
    SET sesso = (SELECT U.sesso FROM Utente AS U WHERE id = NEW.atleta);

    IF anno_nascita > (SELECT anno_max FROM Squadra WHERE id = NEW.squadra)
        OR anno_nascita < (SELECT anno_min FROM Squadra WHERE id = NEW.squadra) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'età dell'atleta non è adatta alla squadra";
    END IF;

    IF sesso <> (
        SELECT C.sesso
        FROM Categoria AS C JOIN Squadra AS S ON C.id = S.categoria
        WHERE S.id = NEW.squadra
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Il sesso dell'atleta non è accettato dalla categoria";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ruolo`
--

DROP TABLE IF EXISTS `ruolo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ruolo` (
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ruolo`
--

LOCK TABLES `ruolo` WRITE;
/*!40000 ALTER TABLE `ruolo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ruolo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scopo`
--

DROP TABLE IF EXISTS `scopo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scopo` (
  `obiettivo` int(10) unsigned NOT NULL,
  `allenamento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`obiettivo`,`allenamento`),
  KEY `allenamento` (`allenamento`),
  CONSTRAINT `scopo_ibfk_1` FOREIGN KEY (`obiettivo`) REFERENCES `obiettivo` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `scopo_ibfk_2` FOREIGN KEY (`allenamento`) REFERENCES `allenamento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scopo`
--

LOCK TABLES `scopo` WRITE;
/*!40000 ALTER TABLE `scopo` DISABLE KEYS */;
INSERT INTO `scopo` VALUES (1,1),(3,22),(3,25),(3,26),(3,27),(3,28),(3,29),(5,27),(5,28),(5,29);
/*!40000 ALTER TABLE `scopo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS scopo_allenamento
BEFORE INSERT ON Scopo
FOR EACH ROW
BEGIN
    IF (SELECT raggiunto FROM Obiettivo WHERE id = NEW.obiettivo) IS TRUE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'obiettivo è già stato raggiunto";
    END IF;

    IF NEW.obiettivo NOT IN (
        SELECT id
        FROM Obiettivo
        WHERE squadra IN (
            SELECT squadra
            FROM Partecipazione
            WHERE allenamento = NEW.allenamento
        )
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'obbiettivo non è assegnato ad una squadra che partecipa all'allenamento";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sesso`
--

DROP TABLE IF EXISTS `sesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sesso` (
  `value` char(1) NOT NULL,
  PRIMARY KEY (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesso`
--

LOCK TABLES `sesso` WRITE;
/*!40000 ALTER TABLE `sesso` DISABLE KEYS */;
INSERT INTO `sesso` VALUES ('F'),('M');
/*!40000 ALTER TABLE `sesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squadra`
--

DROP TABLE IF EXISTS `squadra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squadra` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `categoria` varchar(4) NOT NULL,
  `stagione` smallint(5) unsigned NOT NULL,
  `anno_min` smallint(5) unsigned DEFAULT NULL,
  `anno_max` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categoria_stagione` (`categoria`,`stagione`),
  KEY `stagione` (`stagione`),
  CONSTRAINT `squadra_ibfk_1` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `squadra_ibfk_2` FOREIGN KEY (`stagione`) REFERENCES `stagione` (`anno_inizio`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `anno_min_max` CHECK (`anno_min` < `anno_max`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squadra`
--

LOCK TABLES `squadra` WRITE;
/*!40000 ALTER TABLE `squadra` DISABLE KEYS */;
INSERT INTO `squadra` VALUES (1,'U17M',2022,2006,2007),(2,'U15M',2022,2008,2009),(10,'U5',2022,2018,2019),(12,'U7',2022,2016,2017),(13,'U19M',2022,2003,2005),(14,'SENM',2022,1980,2005),(15,'U15F',2022,2008,2009),(16,'SENF',2021,1979,2004),(21,'U9',2022,2014,2015),(35,'U17F',2022,2006,2007),(42,'U11',2022,2012,2013);
/*!40000 ALTER TABLE `squadra` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS anno_max_e_min_squadra
BEFORE INSERT ON Squadra
FOR EACH ROW
BEGIN
    SET NEW.anno_min = NEW.stagione - (SELECT eta_max FROM Categoria WHERE id = NEW.categoria);
    SET NEW.anno_max = NEW.stagione - (SELECT eta_min FROM Categoria WHERE id = NEW.categoria);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `allenatore` int(10) unsigned NOT NULL,
  `squadra` int(10) unsigned NOT NULL,
  PRIMARY KEY (`allenatore`,`squadra`),
  KEY `squadra` (`squadra`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`allenatore`) REFERENCES `allenatore` (`utente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`squadra`) REFERENCES `squadra` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (4,10),(4,12),(4,14),(4,15),(4,16),(4,42),(6,2),(6,14),(6,21),(22,1),(22,2),(22,13),(22,14),(22,42),(30,2),(30,13),(30,35);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stagione`
--

DROP TABLE IF EXISTS `stagione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stagione` (
  `anno_inizio` smallint(5) unsigned NOT NULL,
  `anno_fine` smallint(5) unsigned NOT NULL,
  `corrente` tinyint(1) NOT NULL,
  PRIMARY KEY (`anno_inizio`),
  CONSTRAINT `inizio_e_fine` CHECK (`anno_inizio` < `anno_fine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stagione`
--

LOCK TABLES `stagione` WRITE;
/*!40000 ALTER TABLE `stagione` DISABLE KEYS */;
INSERT INTO `stagione` VALUES (2021,2022,0),(2022,2023,1);
/*!40000 ALTER TABLE `stagione` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS insert_stagione_corrente
BEFORE INSERT ON Stagione
FOR EACH ROW
BEGIN
    IF NEW.corrente = 1 AND EXISTS (SELECT * FROM stagione WHERE corrente = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "C'è già una stagione in corso";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS update_stagione_corrente
BEFORE UPDATE ON Stagione
FOR EACH ROW
BEGIN
    IF NEW.corrente = 1 AND EXISTS (SELECT * FROM stagione WHERE corrente = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "C'è già una stagione in corso";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `svolgimento`
--

DROP TABLE IF EXISTS `svolgimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `svolgimento` (
  `esercizio` int(10) unsigned NOT NULL,
  `allenamento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`esercizio`,`allenamento`),
  KEY `allenamento` (`allenamento`),
  CONSTRAINT `svolgimento_ibfk_1` FOREIGN KEY (`esercizio`) REFERENCES `esercizio` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `svolgimento_ibfk_2` FOREIGN KEY (`allenamento`) REFERENCES `allenamento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `svolgimento`
--

LOCK TABLES `svolgimento` WRITE;
/*!40000 ALTER TABLE `svolgimento` DISABLE KEYS */;
INSERT INTO `svolgimento` VALUES (1,1),(1,7),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,18),(1,19),(2,21),(3,2),(3,21),(6,6),(7,8),(7,21);
/*!40000 ALTER TABLE `svolgimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutela`
--

DROP TABLE IF EXISTS `tutela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutela` (
  `atleta` int(10) unsigned NOT NULL,
  `tutore` int(10) unsigned NOT NULL,
  PRIMARY KEY (`atleta`,`tutore`),
  KEY `tutore` (`tutore`),
  CONSTRAINT `tutela_ibfk_1` FOREIGN KEY (`atleta`) REFERENCES `atleta` (`utente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tutela_ibfk_2` FOREIGN KEY (`tutore`) REFERENCES `tutore` (`utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutela`
--

LOCK TABLES `tutela` WRITE;
/*!40000 ALTER TABLE `tutela` DISABLE KEYS */;
INSERT INTO `tutela` VALUES (1,2),(3,2),(3,9),(7,2),(12,9),(13,9),(14,9),(15,9),(16,9),(17,9),(18,9),(19,9),(20,2),(20,9),(21,9),(35,30);
/*!40000 ALTER TABLE `tutela` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutore`
--

DROP TABLE IF EXISTS `tutore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutore` (
  `utente` int(10) unsigned NOT NULL,
  PRIMARY KEY (`utente`),
  CONSTRAINT `tutore_ibfk_1` FOREIGN KEY (`utente`) REFERENCES `utente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutore`
--

LOCK TABLES `tutore` WRITE;
/*!40000 ALTER TABLE `tutore` DISABLE KEYS */;
INSERT INTO `tutore` VALUES (2),(4),(9),(30);
/*!40000 ALTER TABLE `tutore` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS tutore_maggiorenne
BEFORE INSERT ON Tutore
FOR EACH ROW
BEGIN
    IF getUserAge(NEW.utente) < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un tutore deve essere maggiorenne";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utente` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` char(60) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `data_nascita` date NOT NULL,
  `sesso` char(1) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `tessera` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `telefono` (`telefono`),
  UNIQUE KEY `n_tessera` (`tessera`),
  UNIQUE KEY `tessera` (`tessera`),
  KEY `sesso` (`sesso`),
  CONSTRAINT `utente_ibfk_1` FOREIGN KEY (`sesso`) REFERENCES `sesso` (`value`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `numero_tel` CHECK (`telefono` regexp '^[+]?([0-9]{6}[0-9]*)$'),
  CONSTRAINT `email_format` CHECK (`email` regexp '^[A-Za-z0-9][A-Za-z0-9-.]+[A-Za-z0-9]@([A-Za-z0-9-]+.)+[A-Za-z0-9]+')
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES (1,'figlio 1','gigi','figlio','primo','2018-08-09','F','abc@gmail.com','334334334',NULL),(2,'genitore','gen1','genitore','alfonso','1988-08-18','M','def@dominio.com','30303030',NULL),(3,'minorenne con tut','afafafafafafa','figlio','secondo','2006-06-13','M',NULL,'312345678',NULL),(4,'maggiorenne','mag','Fagiani','Lorenzo','2000-11-09','M','mario.magica@dominio.it','333111222',NULL),(6,'simongino','a','Alberani','Simone','1988-08-09','M','eemail@email.com','57849308958',NULL),(7,'u15m','alberto','figlio','terzo','2009-04-05','M','alberto.scorfano@pixar.com','33455566',NULL),(8,'U15F','hellen','hellen','parr','2009-03-01','F',NULL,'321321321',NULL),(9,'francesco.rossi','password','Rossi','Francesco','1978-08-24','M','francesco.rossi@email.it','333935778',NULL),(12,'giocatore1','qwerty','Uno','Giocatore','2008-12-15','M',NULL,NULL,NULL),(13,'giocatore2','qwerty','Due','Giocatore','2009-01-13','M',NULL,NULL,NULL),(14,'giocatore3','qwerty','Tre','Giocatore','2008-04-04','M',NULL,NULL,NULL),(15,'giocatore4','qwerty','Quattro','Giocatore','2009-09-14','M',NULL,NULL,NULL),(16,'giocatore5','qwert','Cinque','Giocatore','2009-06-21','M',NULL,NULL,NULL),(17,'giocatore6','qwerty','Sei','Giocatore','2008-11-16','M',NULL,NULL,NULL),(18,'giocatore7','qwerty','Sette','Giocatore','2009-05-01','M',NULL,NULL,NULL),(19,'giocatore8','qwerty','Otto','Giocatore','2008-09-30','M',NULL,NULL,NULL),(20,'giocatore9','qwerty','figlio','quarto','2009-12-28','M',NULL,NULL,NULL),(21,'giocatore10','qwerrty','Dieci','Giocatore','2009-02-20','M',NULL,NULL,NULL),(22,'AllenatoreU15','allenatore15','Margoletti','Lorenzo','1992-08-16','M',NULL,NULL,NULL),(24,'sen e 19','','19','sqn','2004-08-14','M',NULL,NULL,NULL),(25,'C','','BOH','BOH','2017-08-01','M',NULL,NULL,NULL),(26,'bimbo1','','','','2018-08-02','M',NULL,NULL,NULL),(27,'bimbo2','','','','2019-05-22','F',NULL,NULL,NULL),(29,'SENIORES F','','','','1988-08-18','F',NULL,NULL,NULL),(30,'antonio.romito','antonio','Romito','Antonio','2001-11-21','M',NULL,NULL,NULL),(34,'Gigi','gigi','Bruzzese','Luigi','1995-04-13','M','gigi@bruz.it',NULL,NULL),(35,'abc','abc','abc','abc','2015-05-05','M',NULL,NULL,NULL);
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `valutazioni_medie_squadre_per_mese`
--

DROP TABLE IF EXISTS `valutazioni_medie_squadre_per_mese`;
/*!50001 DROP VIEW IF EXISTS `valutazioni_medie_squadre_per_mese`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `valutazioni_medie_squadre_per_mese` (
  `squadra` tinyint NOT NULL,
  `mese` tinyint NOT NULL,
  `valutazione_media` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `allenamenti_programmati_squadre`
--

/*!50001 DROP TABLE IF EXISTS `allenamenti_programmati_squadre`*/;
/*!50001 DROP VIEW IF EXISTS `allenamenti_programmati_squadre`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `allenamenti_programmati_squadre` AS select `s`.`id` AS `squadra`,`a`.`id` AS `id`,`a`.`data_ora_inizio` AS `data_ora_inizio`,`a`.`ora_fine` AS `ora_fine`,`a`.`stato` AS `stato`,`a`.`citta` AS `citta`,`a`.`via` AS `via`,`a`.`civico` AS `civico`,`a`.`motivazione` AS `motivazione`,`a`.`stagione` AS `stagione` from ((`squadra` `s` join `partecipazione` `p` on(`p`.`squadra` = `s`.`id`)) join `allenamento` `a` on(`a`.`id` = `p`.`allenamento`)) where `a`.`data_ora_inizio` > current_timestamp() and `a`.`stato` = 'PROGRAMMATO' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `calendario`
--

/*!50001 DROP TABLE IF EXISTS `calendario`*/;
/*!50001 DROP VIEW IF EXISTS `calendario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `calendario` AS select `partecipazione`.`squadra` AS `squadra`,'Allenamento' AS `nome`,`allenamento`.`data_ora_inizio` AS `data_ora_inizio`,`allenamento`.`id` AS `id_allenamento` from (`allenamento` join `partecipazione` on(`partecipazione`.`allenamento` = `allenamento`.`id`)) where `allenamento`.`stato` = 'PROGRAMMATO' union select `evento`.`squadra` AS `squadra`,`evento`.`nome` AS `nome`,`evento`.`data_ora_inizio` AS `data_ora_inizio`,NULL AS `id_allenamento` from `evento` where `evento`.`annullato` is false order by `data_ora_inizio` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `contatti_atleti_tutori`
--

/*!50001 DROP TABLE IF EXISTS `contatti_atleti_tutori`*/;
/*!50001 DROP VIEW IF EXISTS `contatti_atleti_tutori`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `contatti_atleti_tutori` AS select `atl`.`id` AS `atleta`,`atl`.`nome` AS `nome`,`atl`.`cognome` AS `cognome`,`atl`.`email` AS `email`,`atl`.`telefono` AS `telefono`,`tutela`.`tutore` AS `tutore`,`tut`.`nome` AS `nome_tutore`,`tut`.`cognome` AS `cognome_tutore`,`tut`.`email` AS `email_tutore`,`tut`.`telefono` AS `telefono_tutore` from (((`utente` `atl` join `atleta` on(`atl`.`id` = `atleta`.`utente`)) left join `tutela` on(`tutela`.`atleta` = `atl`.`id`)) left join `utente` `tut` on(`tut`.`id` = `tutela`.`tutore`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `domande_numero_risposte`
--

/*!50001 DROP TABLE IF EXISTS `domande_numero_risposte`*/;
/*!50001 DROP VIEW IF EXISTS `domande_numero_risposte`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `domande_numero_risposte` AS select `cd`.`etichetta` AS `etichetta`,`d`.`testo` AS `testo`,count(0) AS `numero_risposte` from ((`domanda` `d` join `classificazionedomanda` `cd` on(`cd`.`domanda` = `d`.`id`)) join `composizione` `c` on(`c`.`domanda` = `d`.`id`)) group by `cd`.`etichetta`,`d`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `inviti_senza_risposta_o_assenti`
--

/*!50001 DROP TABLE IF EXISTS `inviti_senza_risposta_o_assenti`*/;
/*!50001 DROP VIEW IF EXISTS `inviti_senza_risposta_o_assenti`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `inviti_senza_risposta_o_assenti` AS select `invito`.`atleta` AS `atleta`,`invito`.`squadra_ev` AS `squadra_ev`,`invito`.`data_ev` AS `data_ev`,`invito`.`presenza` AS `presenza`,`invito`.`motivazione` AS `motivazione` from `invito` where `invito`.`presenza` = 0 or `invito`.`presenza` is null */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `numero_allenamenti_svolti_squadre`
--

/*!50001 DROP TABLE IF EXISTS `numero_allenamenti_svolti_squadre`*/;
/*!50001 DROP VIEW IF EXISTS `numero_allenamenti_svolti_squadre`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `numero_allenamenti_svolti_squadre` AS select `partecipazione`.`squadra` AS `squadra`,count(0) AS `numero` from (`partecipazione` join `allenamento` on(`partecipazione`.`allenamento` = `allenamento`.`id`)) where `allenamento`.`stato` = 'SVOLTO' group by `partecipazione`.`squadra` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `valutazioni_medie_squadre_per_mese`
--

/*!50001 DROP TABLE IF EXISTS `valutazioni_medie_squadre_per_mese`*/;
/*!50001 DROP VIEW IF EXISTS `valutazioni_medie_squadre_per_mese`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `valutazioni_medie_squadre_per_mese` AS select `p`.`squadra` AS `squadra`,month(`a`.`data_ora_inizio`) AS `mese`,avg(`r`.`valutazione`) AS `valutazione_media` from (((`report` `r` join `partecipazione` `p` on(`p`.`allenamento` = `r`.`allenamento`)) join `allenamento` `a` on(`a`.`id` = `r`.`allenamento`)) join `squadra` `s` on(`s`.`id` = `p`.`squadra`)) where `s`.`stagione` = (select `stagione`.`anno_inizio` from `stagione` where `stagione`.`corrente` is true) group by `p`.`squadra`,month(`a`.`data_ora_inizio`) */;
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

-- Dump completed on 2022-09-01 18:03:16
