CREATE DATABASE  IF NOT EXISTS `vidaAnimal` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `vidaAnimal`;
-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: vidaAnimal
-- ------------------------------------------------------
-- Server version	5.7.18-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `numeroDocumento` int(11) NOT NULL,
  `tipoDocumento_idtipoDocumento` int(11) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `provincia_idprovincia` int(11) NOT NULL,
  `localidad_idlocalidad` int(11) NOT NULL,
  `telefonoFijo` varchar(15) DEFAULT NULL,
  `telefonoCelular` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idcliente`),
  KEY `fk_cliente_tipoDocumento1_idx` (`tipoDocumento_idtipoDocumento`),
  KEY `fk_cliente_provincia1_idx` (`provincia_idprovincia`),
  KEY `fk_cliente_localidad1_idx` (`localidad_idlocalidad`),
  CONSTRAINT `fk_cliente_localidad1` FOREIGN KEY (`localidad_idlocalidad`) REFERENCES `localidad` (`idlocalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_provincia1` FOREIGN KEY (`provincia_idprovincia`) REFERENCES `provincia` (`idprovincia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_tipoDocumento1` FOREIGN KEY (`tipoDocumento_idtipoDocumento`) REFERENCES `tipoDocumento` (`idtipoDocumento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,31894149,4,'Soledad Pichetti','Gaudard 957',28,40,'','0358215440210','solepichetti@gmail.com',1),(2,31383546,4,'Ricardo Zerbato','Gaudard 957',28,40,'','','',1),(4,6653249,4,'Graziano Zerbato','Pringles 150',28,39,'421163','03582440210','chano@gmail.com',1),(5,12345678,4,'fdasfasd','asdf',28,40,'','','',0);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consulta` (
  `idconsulta` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `cliente_idcliente` int(11) NOT NULL,
  `paciente_idpaciente` int(11) NOT NULL,
  `tipoConsulta_idtipoConsulta` int(11) NOT NULL,
  `motivo` text NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idconsulta`),
  KEY `fk_consulta_paciente1_idx` (`paciente_idpaciente`),
  KEY `fk_consulta_tipoConsulta1_idx` (`tipoConsulta_idtipoConsulta`),
  KEY `fk_consulta_cliente1_idx` (`cliente_idcliente`),
  CONSTRAINT `fk_consulta_cliente1` FOREIGN KEY (`cliente_idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_paciente1` FOREIGN KEY (`paciente_idpaciente`) REFERENCES `paciente` (`idpaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_tipoConsulta1` FOREIGN KEY (`tipoConsulta_idtipoConsulta`) REFERENCES `tipoConsulta` (`idtipoConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta`
--

LOCK TABLES `consulta` WRITE;
/*!40000 ALTER TABLE `consulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruge_authassignment`
--

DROP TABLE IF EXISTS `cruge_authassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cruge_authassignment` (
  `userid` int(11) NOT NULL,
  `bizrule` text,
  `data` text,
  `itemname` varchar(64) NOT NULL,
  PRIMARY KEY (`userid`,`itemname`),
  KEY `fk_cruge_authassignment_cruge_authitem1` (`itemname`),
  KEY `fk_cruge_authassignment_user` (`userid`),
  CONSTRAINT `fk_cruge_authassignment_cruge_authitem1` FOREIGN KEY (`itemname`) REFERENCES `cruge_authitem` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cruge_authassignment_user` FOREIGN KEY (`userid`) REFERENCES `cruge_user` (`iduser`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruge_authassignment`
--

LOCK TABLES `cruge_authassignment` WRITE;
/*!40000 ALTER TABLE `cruge_authassignment` DISABLE KEYS */;
INSERT INTO `cruge_authassignment` VALUES (3,NULL,'N;','FullUser');
/*!40000 ALTER TABLE `cruge_authassignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruge_authitem`
--

DROP TABLE IF EXISTS `cruge_authitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cruge_authitem` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruge_authitem`
--

LOCK TABLES `cruge_authitem` WRITE;
/*!40000 ALTER TABLE `cruge_authitem` DISABLE KEYS */;
INSERT INTO `cruge_authitem` VALUES ('action_cliente_admin',0,'',NULL,'N;'),('action_cliente_create',0,'',NULL,'N;'),('action_cliente_delete',0,'',NULL,'N;'),('action_cliente_index',0,'',NULL,'N;'),('action_cliente_update',0,'',NULL,'N;'),('action_cliente_view',0,'',NULL,'N;'),('action_diagnosticocomplementario_admin',0,'',NULL,'N;'),('action_diagnosticocomplementario_create',0,'',NULL,'N;'),('action_diagnosticocomplementario_delete',0,'',NULL,'N;'),('action_diagnosticocomplementario_index',0,'',NULL,'N;'),('action_diagnosticocomplementario_update',0,'',NULL,'N;'),('action_diagnosticocomplementario_view',0,'',NULL,'N;'),('action_especie_admin',0,'',NULL,'N;'),('action_especie_buscarid',0,'',NULL,'N;'),('action_especie_create',0,'',NULL,'N;'),('action_especie_delete',0,'',NULL,'N;'),('action_especie_index',0,'',NULL,'N;'),('action_especie_update',0,'',NULL,'N;'),('action_especie_view',0,'',NULL,'N;'),('action_localidad_admin',0,'',NULL,'N;'),('action_localidad_buscarlocalidades',0,'',NULL,'N;'),('action_localidad_create',0,'',NULL,'N;'),('action_localidad_delete',0,'',NULL,'N;'),('action_localidad_index',0,'',NULL,'N;'),('action_localidad_listadodinamico',0,'',NULL,'N;'),('action_localidad_update',0,'',NULL,'N;'),('action_localidad_view',0,'',NULL,'N;'),('action_marca_admin',0,'',NULL,'N;'),('action_marca_buscarmarcas',0,'',NULL,'N;'),('action_marca_create',0,'',NULL,'N;'),('action_marca_delete',0,'',NULL,'N;'),('action_marca_index',0,'',NULL,'N;'),('action_marca_update',0,'',NULL,'N;'),('action_marca_view',0,'',NULL,'N;'),('action_paciente_admin',0,'',NULL,'N;'),('action_paciente_create',0,'',NULL,'N;'),('action_paciente_delete',0,'',NULL,'N;'),('action_paciente_index',0,'',NULL,'N;'),('action_paciente_update',0,'',NULL,'N;'),('action_paciente_view',0,'',NULL,'N;'),('action_producto_actualizaprecios',0,'',NULL,'N;'),('action_producto_admin',0,'',NULL,'N;'),('action_producto_create',0,'',NULL,'N;'),('action_producto_delete',0,'',NULL,'N;'),('action_producto_index',0,'',NULL,'N;'),('action_producto_print',0,'',NULL,'N;'),('action_producto_update',0,'',NULL,'N;'),('action_producto_view',0,'',NULL,'N;'),('action_raza_admin',0,'',NULL,'N;'),('action_raza_create',0,'',NULL,'N;'),('action_raza_delete',0,'',NULL,'N;'),('action_raza_index',0,'',NULL,'N;'),('action_raza_update',0,'',NULL,'N;'),('action_raza_view',0,'',NULL,'N;'),('action_rubro_admin',0,'',NULL,'N;'),('action_rubro_buscarid',0,'',NULL,'N;'),('action_rubro_create',0,'',NULL,'N;'),('action_rubro_delete',0,'',NULL,'N;'),('action_rubro_index',0,'',NULL,'N;'),('action_rubro_update',0,'',NULL,'N;'),('action_rubro_view',0,'',NULL,'N;'),('action_site_contact',0,'',NULL,'N;'),('action_site_error',0,'',NULL,'N;'),('action_site_index',0,'',NULL,'N;'),('action_site_login',0,'',NULL,'N;'),('action_site_logout',0,'',NULL,'N;'),('action_subrubro_admin',0,'',NULL,'N;'),('action_subrubro_buscarsubrubros',0,'',NULL,'N;'),('action_subrubro_create',0,'',NULL,'N;'),('action_subrubro_delete',0,'',NULL,'N;'),('action_subrubro_index',0,'',NULL,'N;'),('action_subrubro_listadodinamico',0,'',NULL,'N;'),('action_subrubro_update',0,'',NULL,'N;'),('action_subrubro_view',0,'',NULL,'N;'),('action_tipoconsulta_admin',0,'',NULL,'N;'),('action_tipoconsulta_create',0,'',NULL,'N;'),('action_tipoconsulta_delete',0,'',NULL,'N;'),('action_tipoconsulta_index',0,'',NULL,'N;'),('action_tipoconsulta_update',0,'',NULL,'N;'),('action_tipoconsulta_view',0,'',NULL,'N;'),('controller_cliente',0,'',NULL,'N;'),('controller_diagnosticocomplementario',0,'',NULL,'N;'),('controller_especie',0,'',NULL,'N;'),('controller_localidad',0,'',NULL,'N;'),('controller_marca',0,'',NULL,'N;'),('controller_paciente',0,'',NULL,'N;'),('controller_producto',0,'',NULL,'N;'),('controller_raza',0,'',NULL,'N;'),('controller_rubro',0,'',NULL,'N;'),('controller_site',0,'',NULL,'N;'),('controller_subrubro',0,'',NULL,'N;'),('controller_tipoconsulta',0,'',NULL,'N;'),('FullUser',2,'Puede administrar todo menos los usuarios','','N;');
/*!40000 ALTER TABLE `cruge_authitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruge_authitemchild`
--

DROP TABLE IF EXISTS `cruge_authitemchild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cruge_authitemchild` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `crugeauthitemchild_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `cruge_authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `crugeauthitemchild_ibfk_2` FOREIGN KEY (`child`) REFERENCES `cruge_authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruge_authitemchild`
--

LOCK TABLES `cruge_authitemchild` WRITE;
/*!40000 ALTER TABLE `cruge_authitemchild` DISABLE KEYS */;
/*!40000 ALTER TABLE `cruge_authitemchild` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruge_field`
--

DROP TABLE IF EXISTS `cruge_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cruge_field` (
  `idfield` int(11) NOT NULL AUTO_INCREMENT,
  `fieldname` varchar(20) NOT NULL,
  `longname` varchar(50) DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `required` int(11) DEFAULT '0',
  `fieldtype` int(11) DEFAULT '0',
  `fieldsize` int(11) DEFAULT '20',
  `maxlength` int(11) DEFAULT '45',
  `showinreports` int(11) DEFAULT '0',
  `useregexp` varchar(512) DEFAULT NULL,
  `useregexpmsg` varchar(512) DEFAULT NULL,
  `predetvalue` mediumblob,
  PRIMARY KEY (`idfield`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruge_field`
--

LOCK TABLES `cruge_field` WRITE;
/*!40000 ALTER TABLE `cruge_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `cruge_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruge_fieldvalue`
--

DROP TABLE IF EXISTS `cruge_fieldvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cruge_fieldvalue` (
  `idfieldvalue` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `idfield` int(11) NOT NULL,
  `value` blob,
  PRIMARY KEY (`idfieldvalue`),
  KEY `fk_cruge_fieldvalue_cruge_user1` (`iduser`),
  KEY `fk_cruge_fieldvalue_cruge_field1` (`idfield`),
  CONSTRAINT `fk_cruge_fieldvalue_cruge_field1` FOREIGN KEY (`idfield`) REFERENCES `cruge_field` (`idfield`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cruge_fieldvalue_cruge_user1` FOREIGN KEY (`iduser`) REFERENCES `cruge_user` (`iduser`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruge_fieldvalue`
--

LOCK TABLES `cruge_fieldvalue` WRITE;
/*!40000 ALTER TABLE `cruge_fieldvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `cruge_fieldvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruge_session`
--

DROP TABLE IF EXISTS `cruge_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cruge_session` (
  `idsession` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `created` bigint(30) DEFAULT NULL,
  `expire` bigint(30) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `ipaddress` varchar(45) DEFAULT NULL,
  `usagecount` int(11) DEFAULT '0',
  `lastusage` bigint(30) DEFAULT NULL,
  `logoutdate` bigint(30) DEFAULT NULL,
  `ipaddressout` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idsession`),
  KEY `crugesession_iduser` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruge_session`
--

LOCK TABLES `cruge_session` WRITE;
/*!40000 ALTER TABLE `cruge_session` DISABLE KEYS */;
INSERT INTO `cruge_session` VALUES (1,1,1492261513,1492263313,1,'127.0.0.1',1,1492261513,NULL,NULL),(2,1,1492468859,1492470659,0,'127.0.0.1',1,1492468859,NULL,NULL),(3,1,1492470680,1492472480,0,'127.0.0.1',1,1492470680,NULL,NULL),(4,1,1492472631,1492474431,0,'127.0.0.1',1,1492472631,NULL,NULL),(5,1,1492474453,1492476253,0,'127.0.0.1',1,1492474453,NULL,NULL),(6,1,1492476341,1492478141,1,'127.0.0.1',1,1492476341,NULL,NULL),(7,1,1492532313,1492534113,0,'127.0.0.1',1,1492532313,NULL,NULL),(8,1,1492534130,1492535930,1,'127.0.0.1',1,1492534130,NULL,NULL),(9,1,1492537183,1492538983,1,'127.0.0.1',1,1492537183,NULL,NULL),(10,1,1492641199,1492642999,0,'127.0.0.1',1,1492641199,NULL,NULL),(11,1,1492643115,1492644915,0,'127.0.0.1',1,1492643115,NULL,NULL),(12,1,1492644936,1492646736,0,'127.0.0.1',1,1492644936,NULL,NULL),(13,1,1492646771,1492648571,1,'127.0.0.1',1,1492646771,NULL,NULL),(14,1,1492692760,1492694560,1,'127.0.0.1',1,1492692760,NULL,NULL),(15,1,1492698845,1492700645,1,'127.0.0.1',1,1492698845,NULL,NULL),(16,1,1492863767,1492865567,0,'::1',1,1492863767,NULL,NULL),(17,1,1492867109,1492868909,0,'::1',1,1492867109,NULL,NULL),(18,1,1492868955,1492870755,0,'::1',1,1492868955,NULL,NULL),(19,1,1492870865,1492872665,1,'::1',1,1492870865,NULL,NULL),(20,1,1492874962,1492876762,1,'::1',1,1492874962,NULL,NULL),(21,1,1492899122,1492900922,0,'::1',1,1492899122,NULL,NULL),(22,1,1492901521,1492903321,0,'::1',2,1492903223,NULL,NULL),(23,1,1492903419,1492905219,0,'::1',1,1492903419,NULL,NULL),(24,1,1492905364,1492907164,1,'::1',1,1492905364,NULL,NULL),(25,1,1492974352,1492976152,1,'127.0.0.1',1,1492974352,NULL,NULL),(26,1,1493043759,1493045559,1,'127.0.0.1',1,1493043759,NULL,NULL),(27,1,1493052860,1493054660,0,'127.0.0.1',1,1493052860,NULL,NULL),(28,1,1493054920,1493056720,1,'127.0.0.1',1,1493054920,NULL,NULL),(29,1,1493137756,1493139556,0,'127.0.0.1',1,1493137756,NULL,NULL),(30,1,1493139613,1493141413,0,'127.0.0.1',1,1493139613,NULL,NULL),(31,1,1493141420,1493143220,1,'127.0.0.1',1,1493141420,NULL,NULL),(32,1,1493169562,1493171362,0,'127.0.0.1',1,1493169562,NULL,NULL),(33,1,1493171374,1493173174,1,'127.0.0.1',3,1493171973,NULL,NULL),(34,1,1493212495,1493214295,0,'127.0.0.1',1,1493212495,NULL,NULL),(35,1,1493214425,1493216225,1,'127.0.0.1',1,1493214425,NULL,NULL),(36,1,1493228327,1493230127,1,'127.0.0.1',1,1493228327,NULL,NULL),(37,1,1493403259,1493405059,1,'127.0.0.1',1,1493403259,NULL,NULL),(38,1,1493407099,1493408899,1,'127.0.0.1',1,1493407099,NULL,NULL),(39,1,1493496884,1493498684,0,'127.0.0.1',1,1493496884,NULL,NULL),(40,1,1493498751,1493500551,0,'127.0.0.1',1,1493498751,NULL,NULL),(41,1,1493500564,1493502364,0,'127.0.0.1',1,1493500564,NULL,NULL),(42,1,1493640169,1493641969,0,'127.0.0.1',1,1493640169,NULL,NULL),(43,1,1493642044,1493643844,0,'127.0.0.1',2,1493643398,NULL,NULL),(44,1,1493643980,1493645780,0,'127.0.0.1',3,1493645307,NULL,NULL),(45,1,1493646004,1493647804,0,'127.0.0.1',1,1493646004,NULL,NULL),(46,1,1493647985,1493649785,1,'127.0.0.1',1,1493647985,NULL,NULL),(47,1,1493827658,1493829458,1,'127.0.0.1',1,1493827658,NULL,NULL),(48,1,1493987177,1493988977,0,'127.0.0.1',1,1493987177,NULL,NULL),(49,1,1493989964,1493991764,1,'127.0.0.1',1,1493989964,NULL,NULL),(50,1,1494073591,1494075391,0,'127.0.0.1',1,1494073591,NULL,NULL),(51,1,1494075446,1494077246,0,'127.0.0.1',1,1494075446,NULL,NULL),(52,1,1494077360,1494079160,1,'127.0.0.1',1,1494077360,NULL,NULL),(53,1,1494079880,1494081680,1,'127.0.0.1',1,1494079880,NULL,NULL),(54,1,1494449287,1494451087,1,'127.0.0.1',1,1494449287,NULL,NULL),(55,1,1494511045,1494512845,0,'127.0.0.1',1,1494511045,NULL,NULL),(56,1,1494512930,1494514730,1,'127.0.0.1',1,1494512930,NULL,NULL),(57,1,1494524764,1494526564,0,'127.0.0.1',1,1494524764,NULL,NULL),(58,1,1494526734,1494528534,1,'127.0.0.1',1,1494526734,NULL,NULL),(59,1,1494852639,1494854439,1,'127.0.0.1',1,1494852639,NULL,NULL),(60,1,1494865925,1494867725,0,'127.0.0.1',1,1494865925,NULL,NULL),(61,1,1494867824,1494869624,0,'127.0.0.1',1,1494867824,NULL,NULL),(62,1,1494869678,1494871478,1,'127.0.0.1',1,1494869678,NULL,NULL),(63,1,1494966220,1494968020,1,'127.0.0.1',1,1494966220,NULL,NULL),(64,1,1495028156,1495029956,0,'127.0.0.1',1,1495028156,NULL,NULL),(65,1,1495030037,1495031837,0,'127.0.0.1',1,1495030037,NULL,NULL),(66,1,1495032039,1495033839,1,'127.0.0.1',1,1495032039,NULL,NULL),(67,1,1495126381,1495128181,1,'127.0.0.1',1,1495126381,NULL,NULL),(68,1,1495131090,1495132890,1,'127.0.0.1',1,1495131090,NULL,NULL),(69,1,1495201770,1495203570,1,'127.0.0.1',1,1495201770,NULL,NULL),(70,1,1495216233,1495218033,0,'127.0.0.1',1,1495216233,NULL,NULL),(71,1,1495218484,1495220284,1,'127.0.0.1',1,1495218484,NULL,NULL),(72,1,1495366963,1495368763,1,'127.0.0.1',1,1495366963,NULL,NULL),(73,1,1495455237,1495457037,0,'127.0.0.1',1,1495455237,NULL,NULL),(74,1,1495457437,1495459237,0,'127.0.0.1',1,1495457437,NULL,NULL),(75,1,1495460065,1495461865,1,'127.0.0.1',2,1495460119,NULL,NULL),(76,1,1495542363,1495544163,0,'127.0.0.1',1,1495542363,NULL,NULL),(77,1,1495544286,1495546086,1,'127.0.0.1',1,1495544286,NULL,NULL),(78,1,1495547203,1495549003,1,'127.0.0.1',1,1495547203,NULL,NULL),(79,1,1495550631,1495552431,1,'127.0.0.1',1,1495550631,NULL,NULL),(80,1,1495652663,1495654463,1,'127.0.0.1',1,1495652663,NULL,NULL),(81,1,1495656826,1495658626,0,'127.0.0.1',1,1495656826,NULL,NULL),(82,1,1495658657,1495660457,1,'127.0.0.1',1,1495658657,NULL,NULL),(83,1,1495806992,1495808792,0,'127.0.0.1',1,1495806992,NULL,NULL),(84,1,1495808838,1495810638,1,'127.0.0.1',1,1495808838,NULL,NULL),(85,1,1495822970,1495824770,0,'127.0.0.1',1,1495822970,NULL,NULL),(86,1,1495825178,1495826978,1,'127.0.0.1',1,1495825178,NULL,NULL),(87,1,1495827577,1495829377,0,'127.0.0.1',1,1495827577,NULL,NULL),(88,1,1495829885,1495837085,1,'127.0.0.1',1,1495829885,NULL,NULL),(89,1,1495886569,1495893769,1,'127.0.0.1',1,1495886569,NULL,NULL),(90,1,1496061426,1496068626,1,'127.0.0.1',1,1496061426,NULL,NULL),(91,1,1496083312,1496090512,1,'127.0.0.1',1,1496083312,NULL,NULL),(92,1,1496168395,1496175595,1,'127.0.0.1',1,1496168395,NULL,NULL);
/*!40000 ALTER TABLE `cruge_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruge_system`
--

DROP TABLE IF EXISTS `cruge_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cruge_system` (
  `idsystem` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `largename` varchar(45) DEFAULT NULL,
  `sessionmaxdurationmins` int(11) DEFAULT '30',
  `sessionmaxsameipconnections` int(11) DEFAULT '10',
  `sessionreusesessions` int(11) DEFAULT '1' COMMENT '1yes 0no',
  `sessionmaxsessionsperday` int(11) DEFAULT '-1',
  `sessionmaxsessionsperuser` int(11) DEFAULT '-1',
  `systemnonewsessions` int(11) DEFAULT '0' COMMENT '1yes 0no',
  `systemdown` int(11) DEFAULT '0',
  `registerusingcaptcha` int(11) DEFAULT '0',
  `registerusingterms` int(11) DEFAULT '0',
  `terms` blob,
  `registerusingactivation` int(11) DEFAULT '1',
  `defaultroleforregistration` varchar(64) DEFAULT NULL,
  `registerusingtermslabel` varchar(100) DEFAULT NULL,
  `registrationonlogin` int(11) DEFAULT '1',
  PRIMARY KEY (`idsystem`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruge_system`
--

LOCK TABLES `cruge_system` WRITE;
/*!40000 ALTER TABLE `cruge_system` DISABLE KEYS */;
INSERT INTO `cruge_system` VALUES (1,'default',NULL,120,10,1,-1,-1,0,0,0,0,'',0,'','',1);
/*!40000 ALTER TABLE `cruge_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruge_user`
--

DROP TABLE IF EXISTS `cruge_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cruge_user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `regdate` bigint(30) DEFAULT NULL,
  `actdate` bigint(30) DEFAULT NULL,
  `logondate` bigint(30) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL COMMENT 'Hashed password',
  `authkey` varchar(100) DEFAULT NULL COMMENT 'llave de autentificacion',
  `state` int(11) DEFAULT '0',
  `totalsessioncounter` int(11) DEFAULT '0',
  `currentsessioncounter` int(11) DEFAULT '0',
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruge_user`
--

LOCK TABLES `cruge_user` WRITE;
/*!40000 ALTER TABLE `cruge_user` DISABLE KEYS */;
INSERT INTO `cruge_user` VALUES (1,NULL,NULL,1496168395,'admin','admin@tucorreo.com','admin',NULL,1,0,0),(2,NULL,NULL,NULL,'invitado','invitado','nopassword',NULL,1,0,0),(3,1496061483,NULL,NULL,'dargenti','diegoargenti@hotmail.com','vidaanimal','042a196ab4effabdd912719c54b08b4d',1,0,0);
/*!40000 ALTER TABLE `cruge_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnosticoComplementario`
--

DROP TABLE IF EXISTS `diagnosticoComplementario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diagnosticoComplementario` (
  `iddiagnosticoComplementario` int(11) NOT NULL AUTO_INCREMENT,
  `consulta_idconsulta` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `archivo` longblob NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`iddiagnosticoComplementario`),
  KEY `fk_diagnosticoComplementario_consulta1_idx` (`consulta_idconsulta`),
  CONSTRAINT `fk_diagnosticoComplementario_consulta1` FOREIGN KEY (`consulta_idconsulta`) REFERENCES `consulta` (`idconsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosticoComplementario`
--

LOCK TABLES `diagnosticoComplementario` WRITE;
/*!40000 ALTER TABLE `diagnosticoComplementario` DISABLE KEYS */;
/*!40000 ALTER TABLE `diagnosticoComplementario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especie`
--

DROP TABLE IF EXISTS `especie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especie` (
  `idespecie` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idespecie`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especie`
--

LOCK TABLES `especie` WRITE;
/*!40000 ALTER TABLE `especie` DISABLE KEYS */;
INSERT INTO `especie` VALUES (1,'Canino',1),(2,'Felino',0),(3,'Equino',0),(4,'Equino',1),(5,'Felino',1);
/*!40000 ALTER TABLE `especie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localidad`
--

DROP TABLE IF EXISTS `localidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `localidad` (
  `idlocalidad` int(11) NOT NULL AUTO_INCREMENT,
  `codigoPostal` int(11) NOT NULL,
  `provincia_idprovincia` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idlocalidad`),
  KEY `fk_localidad_provincia1_idx` (`provincia_idprovincia`),
  CONSTRAINT `fk_localidad_provincia1` FOREIGN KEY (`provincia_idprovincia`) REFERENCES `provincia` (`idprovincia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localidad`
--

LOCK TABLES `localidad` WRITE;
/*!40000 ALTER TABLE `localidad` DISABLE KEYS */;
INSERT INTO `localidad` VALUES (32,5829,28,'Sampacho',0),(33,5800,27,'Río Cuarto',0),(34,59874,25,'pindonga',0),(35,32453565,27,'asdfgsgfasg',0),(36,5829,28,'Sampacho',0),(37,5800,28,'Río Cuarto',0),(38,5829,28,'Sampacho',0),(39,5829,28,'Sampacho',1),(40,5800,28,'Río Cuarto',1);
/*!40000 ALTER TABLE `localidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marca`
--

DROP TABLE IF EXISTS `marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marca` (
  `idmarca` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `rubro_idRubro` int(11) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idmarca`),
  KEY `fk_marca_rubro_idx` (`rubro_idRubro`),
  CONSTRAINT `fk_marca_rubro` FOREIGN KEY (`rubro_idRubro`) REFERENCES `rubro` (`idRubro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca`
--

LOCK TABLES `marca` WRITE;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` VALUES (1,'Marca Accesorios',4,1),(2,'Marca Farmacia',2,1),(3,'collares',4,0),(4,'Mi Collar',4,1);
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente` (
  `idpaciente` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_idcliente` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `pacientecol` varchar(45) DEFAULT NULL,
  `especie_idespecie` int(11) NOT NULL,
  `raza_idraza` int(11) NOT NULL,
  `sexo` varchar(9) NOT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `observacion` text,
  `señaParticular` varchar(100) DEFAULT NULL,
  `foto` longblob,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idpaciente`),
  KEY `fk_paciente_especie1_idx` (`especie_idespecie`),
  KEY `fk_paciente_raza1_idx` (`raza_idraza`),
  KEY `fk_paciente_cliente1_idx` (`cliente_idcliente`),
  CONSTRAINT `fk_paciente_cliente1` FOREIGN KEY (`cliente_idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_especie1` FOREIGN KEY (`especie_idespecie`) REFERENCES `especie` (`idespecie`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_raza1` FOREIGN KEY (`raza_idraza`) REFERENCES `raza` (`idraza`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `rubro_idRubro` int(11) NOT NULL,
  `subRubro_idSubRubro` int(11) NOT NULL,
  `marca_idmarca` int(11) NOT NULL,
  `precioCosto` float DEFAULT NULL,
  `precioEfectivo` float NOT NULL,
  `precio2` float DEFAULT NULL,
  `precio3` float DEFAULT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idproducto`),
  KEY `fk_producto_rubro1_idx` (`rubro_idRubro`),
  KEY `fk_producto_subRubro1_idx` (`subRubro_idSubRubro`),
  KEY `fk_producto_marca1_idx` (`marca_idmarca`),
  CONSTRAINT `fk_producto_marca1` FOREIGN KEY (`marca_idmarca`) REFERENCES `marca` (`idmarca`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_rubro1` FOREIGN KEY (`rubro_idRubro`) REFERENCES `rubro` (`idRubro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_subRubro1` FOREIGN KEY (`subRubro_idSubRubro`) REFERENCES `subRubro` (`idSubRubro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'codProducto1','Ropa para perro',4,3,4,10,11,11.55,13.2,1),(2,'123','adsf',4,3,1,1,11,11.55,13.2,0),(3,'1234','Mi producto 1234',4,3,1,1,5,5.25,6,1),(4,'12345','wrfgv',4,4,1,1,10,10.5,12,1);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provincia`
--

DROP TABLE IF EXISTS `provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincia` (
  `idprovincia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idprovincia`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincia`
--

LOCK TABLES `provincia` WRITE;
/*!40000 ALTER TABLE `provincia` DISABLE KEYS */;
INSERT INTO `provincia` VALUES (24,'Buenos Aires',1),(25,'Catamarca',1),(26,'Chaco',1),(27,'Chubut',1),(28,'Córdoba',1),(29,'Corrientes',1),(30,'Entre Ríos',1),(31,'Formosa',1),(32,'Jujuy',1),(33,'La Pampa',1),(34,'La Rioja',1),(35,'Mendoza',1),(36,'Misiones',1),(37,'Neuquén',1),(38,'Río Negro',1),(39,'Salta',1),(40,'San Juan',1),(41,'San Luis',1),(42,'Santa Cruz',1),(43,'Santa Fe',1),(44,'Santiago del Estero',1),(45,'Tierra del Fuego',1),(46,'Tucumán',1);
/*!40000 ALTER TABLE `provincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raza`
--

DROP TABLE IF EXISTS `raza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raza` (
  `idraza` int(11) NOT NULL AUTO_INCREMENT,
  `especie_idespecie` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idraza`),
  KEY `fk_raza_especie1_idx` (`especie_idespecie`),
  CONSTRAINT `fk_raza_especie1` FOREIGN KEY (`especie_idespecie`) REFERENCES `especie` (`idespecie`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raza`
--

LOCK TABLES `raza` WRITE;
/*!40000 ALTER TABLE `raza` DISABLE KEYS */;
INSERT INTO `raza` VALUES (2,2,'Persa',1),(5,2,'Siames',1),(6,1,'Caniche Toy',1);
/*!40000 ALTER TABLE `raza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rubro`
--

DROP TABLE IF EXISTS `rubro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rubro` (
  `idRubro` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idRubro`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rubro`
--

LOCK TABLES `rubro` WRITE;
/*!40000 ALTER TABLE `rubro` DISABLE KEYS */;
INSERT INTO `rubro` VALUES (1,'Accesorios',0),(2,'Farmacia',1),(3,'Alimentos',1),(4,'Accesorios',1);
/*!40000 ALTER TABLE `rubro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subRubro`
--

DROP TABLE IF EXISTS `subRubro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subRubro` (
  `idSubRubro` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `rubro_idRubro` int(11) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idSubRubro`),
  KEY `fk_subRubro_rubro1_idx` (`rubro_idRubro`),
  CONSTRAINT `fk_subRubro_rubro1` FOREIGN KEY (`rubro_idRubro`) REFERENCES `rubro` (`idRubro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subRubro`
--

LOCK TABLES `subRubro` WRITE;
/*!40000 ALTER TABLE `subRubro` DISABLE KEYS */;
INSERT INTO `subRubro` VALUES (1,'Collares',4,0),(2,'Antiparasitarios',2,1),(3,'Ropa',4,1),(4,'Collares',4,1);
/*!40000 ALTER TABLE `subRubro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoConsulta`
--

DROP TABLE IF EXISTS `tipoConsulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoConsulta` (
  `idtipoConsulta` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idtipoConsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoConsulta`
--

LOCK TABLES `tipoConsulta` WRITE;
/*!40000 ALTER TABLE `tipoConsulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipoConsulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoDocumento`
--

DROP TABLE IF EXISTS `tipoDocumento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoDocumento` (
  `idtipoDocumento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(4) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idtipoDocumento`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoDocumento`
--

LOCK TABLES `tipoDocumento` WRITE;
/*!40000 ALTER TABLE `tipoDocumento` DISABLE KEYS */;
INSERT INTO `tipoDocumento` VALUES (4,'DNI',1),(5,'CUIT',1),(6,'CUIL',1);
/*!40000 ALTER TABLE `tipoDocumento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-30 22:42:31
