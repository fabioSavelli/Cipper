CREATE DATABASE  IF NOT EXISTS `cipper` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `cipper`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: cipper
-- ------------------------------------------------------
-- Server version	5.7.20

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
-- Table structure for table `cip`
--

DROP TABLE IF EXISTS `cip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cip` (
  `idCip` int(11) NOT NULL AUTO_INCREMENT,
  `testo` varchar(150) NOT NULL,
  `idAutore` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `shares` int(11) NOT NULL,
  `data` date NOT NULL,
  PRIMARY KEY (`idCip`),
  KEY `idAutore` (`idAutore`),
  CONSTRAINT `cip_ibfk_1` FOREIGN KEY (`idAutore`) REFERENCES `utente` (`idUtente`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `follower`
--

DROP TABLE IF EXISTS `follower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `follower` (
  `idFollower` int(11) NOT NULL AUTO_INCREMENT,
  `idUtente` int(11) NOT NULL,
  `idSeguito` int(11) NOT NULL,
  `valido` varchar(45) NOT NULL,
  PRIMARY KEY (`idFollower`),
  KEY `idSeguito` (`idSeguito`),
  KEY `idUtente_idx` (`idUtente`),
  CONSTRAINT `follower_ibfk_2` FOREIGN KEY (`idSeguito`) REFERENCES `utente` (`idUtente`),
  CONSTRAINT `idUtente` FOREIGN KEY (`idUtente`) REFERENCES `utente` (`idUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `idLike` int(11) NOT NULL AUTO_INCREMENT,
  `idCip` int(11) NOT NULL,
  `idUtente` int(11) NOT NULL,
  `valido` varchar(45) NOT NULL,
  PRIMARY KEY (`idLike`),
  KEY `idCip` (`idCip`),
  KEY `likes_ibfk_1_idx` (`idUtente`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`idUtente`) REFERENCES `utente` (`idUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`idCip`) REFERENCES `cip` (`idCip`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reCip`
--

DROP TABLE IF EXISTS `reCip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reCip` (
  `idReCip` int(11) NOT NULL AUTO_INCREMENT,
  `idUtente` int(11) NOT NULL,
  `idCip` int(11) NOT NULL,
  `dataReCip` date NOT NULL,
  PRIMARY KEY (`idReCip`),
  KEY `idUtente` (`idUtente`),
  KEY `idCip` (`idCip`),
  CONSTRAINT `recip_ibfk_1` FOREIGN KEY (`idUtente`) REFERENCES `utente` (`idUtente`),
  CONSTRAINT `recip_ibfk_2` FOREIGN KEY (`idCip`) REFERENCES `cip` (`idCip`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utente` (
  `idUtente` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `psw` varchar(45) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `attivo` varchar(45) NOT NULL,
  PRIMARY KEY (`idUtente`),
  UNIQUE KEY `idUtente_UNIQUE` (`idUtente`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'cipper'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-07 18:23:56
