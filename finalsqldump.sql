CREATE DATABASE  IF NOT EXISTS `facebookdb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `facebookdb`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: facebookdb
-- ------------------------------------------------------
-- Server version	5.5.9

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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `album_id` int(11) NOT NULL AUTO_INCREMENT,
  `album_name` varchar(45) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `privacy_name` varchar(45) DEFAULT 'PUBLIC',
  PRIMARY KEY (`album_id`),
  KEY `fk_album_1` (`user_id`),
  KEY `fk_album_2` (`group_id`),
  KEY `fk_album_3_idx` (`privacy_name`),
  CONSTRAINT `fk_album_3` FOREIGN KEY (`privacy_name`) REFERENCES `privacydetail` (`privacy_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_album_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_album_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (79,'profilePicture',38,NULL,'2015-04-27 15:43:03','PUBLIC'),(80,'coverPicture',38,NULL,'2015-04-27 15:43:03','PUBLIC'),(81,'timeline',38,NULL,'2015-04-27 15:43:03','PUBLIC'),(82,'profilePicture',39,NULL,'2015-04-27 15:43:15','PUBLIC'),(83,'coverPicture',39,NULL,'2015-04-27 15:43:15','PUBLIC'),(84,'timeline',39,NULL,'2015-04-27 15:43:15','PUBLIC'),(85,'profilePicture',40,NULL,'2015-04-27 15:43:25','PUBLIC'),(86,'coverPicture',40,NULL,'2015-04-27 15:43:25','PUBLIC'),(87,'timeline',40,NULL,'2015-04-27 15:43:25','PUBLIC'),(88,'profilePicture',41,NULL,'2015-04-27 15:43:31','PUBLIC'),(89,'coverPicture',41,NULL,'2015-04-27 15:43:31','PUBLIC'),(90,'timeline',41,NULL,'2015-04-27 15:43:31','PUBLIC'),(91,'profilePicture',42,NULL,'2015-04-27 15:43:42','PUBLIC'),(92,'coverPicture',42,NULL,'2015-04-27 15:43:42','PUBLIC'),(93,'timeline',42,NULL,'2015-04-27 15:43:42','PUBLIC'),(94,'profilePicture',43,NULL,'2015-04-27 15:43:51','PUBLIC'),(95,'coverPicture',43,NULL,'2015-04-27 15:43:51','PUBLIC'),(96,'timeline',43,NULL,'2015-04-27 15:43:51','PUBLIC'),(97,'profilePicture',44,NULL,'2015-04-27 15:44:40','PUBLIC'),(98,'coverPicture',44,NULL,'2015-04-27 15:44:40','PUBLIC'),(99,'timeline',44,NULL,'2015-04-27 15:44:40','PUBLIC'),(100,'profilePicture',45,NULL,'2015-04-27 15:47:14','PUBLIC'),(101,'coverPicture',45,NULL,'2015-04-27 15:47:14','PUBLIC'),(102,'timeline',45,NULL,'2015-04-27 15:47:14','PUBLIC'),(103,'profilePicture',46,NULL,'2015-04-27 15:47:46','PUBLIC'),(104,'coverPicture',46,NULL,'2015-04-27 15:47:46','PUBLIC'),(105,'timeline',46,NULL,'2015-04-27 15:47:46','PUBLIC'),(106,'profilePicture',47,NULL,'2015-04-27 15:50:19','PUBLIC'),(107,'coverPicture',47,NULL,'2015-04-27 15:50:19','PUBLIC'),(108,'timeline',47,NULL,'2015-04-27 15:50:19','PUBLIC'),(109,'profilePicture',48,NULL,'2015-04-27 16:03:03','PUBLIC'),(110,'coverPicture',48,NULL,'2015-04-27 16:03:03','PUBLIC'),(111,'timeline',48,NULL,'2015-04-27 16:03:03','PUBLIC'),(112,'profilePicture',49,NULL,'2015-04-27 16:04:22','PUBLIC'),(113,'coverPicture',49,NULL,'2015-04-27 16:04:22','PUBLIC'),(114,'timeline',49,NULL,'2015-04-27 16:04:22','PUBLIC'),(115,'profilePicture',50,NULL,'2015-04-27 16:08:03','PUBLIC'),(116,'coverPicture',50,NULL,'2015-04-27 16:08:03','PUBLIC'),(117,'timeline',50,NULL,'2015-04-27 16:08:03','PUBLIC'),(118,'profilePicture',51,NULL,'2015-04-27 16:08:35','PRIVATE'),(119,'coverPicture',51,NULL,'2015-04-27 16:08:35','FRIENDS'),(120,'timeline',51,NULL,'2015-04-27 16:08:35','PUBLIC'),(121,'profilePicture',52,NULL,'2015-04-27 16:09:56','PRIVATE'),(122,'coverPicture',52,NULL,'2015-04-27 16:09:56','PUBLIC'),(123,'timeline',52,NULL,'2015-04-27 16:09:56','PUBLIC'),(124,'profilePicture',53,NULL,'2015-04-27 16:10:30','PUBLIC'),(125,'coverPicture',53,NULL,'2015-04-27 16:10:30','PUBLIC'),(126,'timeline',53,NULL,'2015-04-27 16:10:30','PUBLIC'),(127,'profilePicture',54,NULL,'2015-04-27 16:10:33','PUBLIC'),(128,'coverPicture',54,NULL,'2015-04-27 16:10:33','PUBLIC'),(129,'timeline',54,NULL,'2015-04-27 16:10:33','PUBLIC'),(130,'profilePicture',55,NULL,'2015-04-27 16:11:43','PUBLIC'),(131,'coverPicture',55,NULL,'2015-04-27 16:11:43','PUBLIC'),(132,'timeline',55,NULL,'2015-04-27 16:11:43','PUBLIC'),(133,'profilePicture',56,NULL,'2015-04-27 16:11:58','PUBLIC'),(134,'coverPicture',56,NULL,'2015-04-27 16:11:58','PUBLIC'),(135,'timeline',56,NULL,'2015-04-27 16:11:58','PUBLIC'),(136,'profilePicture',57,NULL,'2015-04-27 16:12:59','PUBLIC'),(137,'coverPicture',57,NULL,'2015-04-27 16:12:59','PUBLIC'),(138,'timeline',57,NULL,'2015-04-27 16:12:59','PUBLIC'),(139,'profilePicture',58,NULL,'2015-04-27 16:13:23','PUBLIC'),(140,'coverPicture',58,NULL,'2015-04-27 16:13:23','PUBLIC'),(141,'timeline',58,NULL,'2015-04-27 16:13:23','PUBLIC'),(142,'profilePicture',NULL,16,'2015-04-27 00:00:00','PUBLIC'),(143,'coverPicture',NULL,16,'2015-04-27 16:14:41','PUBLIC'),(144,'timeline',NULL,16,'2015-04-27 16:14:41','PUBLIC'),(145,'profilePicture',NULL,18,'2015-04-27 00:00:00','PUBLIC'),(146,'coverPicture',NULL,18,'2015-04-27 16:18:50','PUBLIC'),(147,'profilePicture',NULL,18,'2015-04-27 00:00:00','PUBLIC'),(148,'timeline',NULL,18,'2015-04-27 16:18:50','PUBLIC'),(149,'coverPicture',NULL,18,'2015-04-27 16:18:50','PUBLIC'),(150,'timeline',NULL,18,'2015-04-27 16:18:50','PUBLIC'),(151,'testalbum',52,NULL,'2015-04-27 16:20:21','PUBLIC'),(152,'profilePicture',NULL,19,'2015-04-27 00:00:00','PUBLIC'),(153,'coverPicture',NULL,19,'2015-04-27 16:35:04','PUBLIC'),(154,'timeline',NULL,19,'2015-04-27 16:35:04','PUBLIC'),(155,'profilePicture',59,NULL,'2015-04-27 18:26:38','PUBLIC'),(156,'coverPicture',59,NULL,'2015-04-27 18:26:38','PUBLIC'),(157,'timeline',59,NULL,'2015-04-27 18:26:38','PUBLIC'),(158,'test-album01_from_raman',59,NULL,'2015-04-27 19:31:18','PUBLIC'),(159,'profilePicture',NULL,20,'2015-04-27 00:00:00','PUBLIC'),(160,'coverPicture',NULL,20,'2015-04-27 19:40:27','PUBLIC'),(161,'timeline',NULL,20,'2015-04-27 19:40:27','PUBLIC'),(162,'profilePicture',60,NULL,'2015-04-28 18:50:46','PUBLIC'),(163,'coverPicture',60,NULL,'2015-04-28 18:50:46','PUBLIC'),(164,'timeline',60,NULL,'2015-04-28 18:50:46','PUBLIC'),(165,'profilePicture',61,NULL,'2015-04-29 16:25:10','PUBLIC'),(166,'coverPicture',61,NULL,'2015-04-29 16:25:10','PUBLIC'),(167,'timeline',61,NULL,'2015-04-29 16:25:10','PUBLIC'),(168,'profilePicture',62,NULL,'2015-04-29 16:38:33','PUBLIC'),(169,'coverPicture',62,NULL,'2015-04-29 16:38:33','PUBLIC'),(170,'timeline',62,NULL,'2015-04-29 16:38:33','PUBLIC'),(171,'profilePicture',NULL,21,'2015-04-29 00:00:00','PUBLIC'),(172,'coverPicture',NULL,21,'2015-04-29 16:47:58','PUBLIC'),(173,'timeline',NULL,21,'2015-04-29 16:47:58','PUBLIC'),(174,'profilePicture',NULL,22,'2015-04-29 00:00:00','PUBLIC'),(175,'coverPicture',NULL,22,'2015-04-29 17:46:06','PUBLIC'),(176,'timeline',NULL,22,'2015-04-29 17:46:06','PUBLIC'),(180,'profilePicture',64,NULL,'2015-05-01 00:05:06','PUBLIC'),(181,'coverPicture',64,NULL,'2015-05-01 00:05:06','PUBLIC'),(182,'timeline',64,NULL,'2015-05-01 00:05:06','PUBLIC'),(186,'profilePicture',66,NULL,'2015-05-01 00:09:50','PUBLIC'),(187,'coverPicture',66,NULL,'2015-05-01 00:09:50','PUBLIC'),(188,'timeline',66,NULL,'2015-05-01 00:09:50','PUBLIC'),(189,'profilePicture',NULL,23,'2015-05-01 00:00:00','PUBLIC'),(190,'coverPicture',NULL,23,'2015-05-01 01:06:02','PUBLIC'),(191,'timeline',NULL,23,'2015-05-01 01:06:02','PUBLIC');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocked`
--

DROP TABLE IF EXISTS `blocked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocked` (
  `blocked_id` int(11) NOT NULL AUTO_INCREMENT,
  `blocked_by` int(11) DEFAULT NULL,
  `blocked_to` int(11) DEFAULT NULL,
  PRIMARY KEY (`blocked_id`),
  KEY `fk_blocked_1_idx` (`blocked_by`),
  KEY `fk_blocked_2_idx` (`blocked_to`),
  CONSTRAINT `fk_blocked_1` FOREIGN KEY (`blocked_by`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_blocked_2` FOREIGN KEY (`blocked_to`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocked`
--

LOCK TABLES `blocked` WRITE;
/*!40000 ALTER TABLE `blocked` DISABLE KEYS */;
INSERT INTO `blocked` VALUES (7,50,56);
/*!40000 ALTER TABLE `blocked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `city_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  KEY `fk_city_1` (`country_id`),
  CONSTRAINT `fk_city_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(45) DEFAULT NULL,
  `event_description` varchar(1000) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `privacy` enum('private','public','secret') DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (15,'FaceBook Demo','Facebook demo to sir in his cabin. You are all welcome.','2015-04-27 00:00:00',NULL,'public','Diensha sir\'s cabin'),(16,'Facebook Demo','facedemo to sir at sir\'s cabin.','2015-04-27 00:00:00',NULL,'public','bangalore'),(17,'event test 01','lab test meeting in iiit b','2015-04-29 00:00:00',NULL,'public','main class room 106'),(18,'rajan\'s party','dance-eat-masti-:P','2015-04-29 00:00:00',NULL,'public','domino\'s');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_members`
--

DROP TABLE IF EXISTS `event_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_members` (
  `event_members_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_admin` enum('T','F') DEFAULT NULL,
  `member_request` enum('A','P','R') DEFAULT NULL,
  `member_status` enum('going','maybe','no') DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`event_members_id`),
  KEY `fk_event_members_1` (`event_id`),
  KEY `fk_event_members_2` (`user_id`),
  CONSTRAINT `fk_event_members_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_event_members_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_members`
--

LOCK TABLES `event_members` WRITE;
/*!40000 ALTER TABLE `event_members` DISABLE KEYS */;
INSERT INTO `event_members` VALUES (20,15,43,'T','A','going',NULL,NULL),(21,16,55,'T','A','going',NULL,NULL),(22,16,53,'F','A','going',NULL,NULL),(23,16,52,'F','P',NULL,NULL,NULL),(24,16,51,'F','A','going',NULL,NULL),(25,16,58,'F','P',NULL,NULL,NULL),(26,16,57,'F','P',NULL,NULL,NULL),(27,17,59,'T','A','going',NULL,NULL),(28,17,52,'F','A','no',NULL,NULL),(29,17,54,'F','A','maybe',NULL,NULL),(30,17,53,'F','A','going',NULL,NULL),(31,18,61,'T','A','going',NULL,NULL),(32,18,53,'F','P',NULL,NULL,NULL),(33,18,51,'F','A','going',NULL,NULL),(34,18,50,'F','A','no',NULL,NULL),(35,18,52,'F','P',NULL,NULL,NULL),(36,18,56,'F','P',NULL,NULL,NULL),(37,17,51,'F','A','going',NULL,NULL);
/*!40000 ALTER TABLE `event_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_post`
--

DROP TABLE IF EXISTS `event_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_post` (
  `event_post_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_description` varchar(1000) DEFAULT NULL,
  `user_from` int(11) DEFAULT NULL,
  `event_to` int(11) DEFAULT NULL,
  `post_date` datetime DEFAULT NULL,
  `pic_path` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`event_post_id`),
  KEY `fk_event_post_1` (`event_to`),
  KEY `fk_event_post_2` (`user_from`),
  CONSTRAINT `fk_event_post_1` FOREIGN KEY (`event_to`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_event_post_2` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_post`
--

LOCK TABLES `event_post` WRITE;
/*!40000 ALTER TABLE `event_post` DISABLE KEYS */;
INSERT INTO `event_post` VALUES (4,'hi',43,15,'2015-04-27 15:48:41',NULL),(5,'let us test',53,17,'2015-04-29 17:15:48',NULL);
/*!40000 ALTER TABLE `event_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_post_comment`
--

DROP TABLE IF EXISTS `event_post_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_post_comment` (
  `event_post_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`event_post_comment_id`),
  KEY `fk_event_post_comment_1` (`post_id`),
  KEY `fk_event_post_comment_2` (`user_id`),
  CONSTRAINT `fk_event_post_comment_1` FOREIGN KEY (`post_id`) REFERENCES `event_post` (`event_post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_event_post_comment_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_post_comment`
--

LOCK TABLES `event_post_comment` WRITE;
/*!40000 ALTER TABLE `event_post_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_post_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_post_like`
--

DROP TABLE IF EXISTS `event_post_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_post_like` (
  `event_post_like_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`event_post_like_id`),
  KEY `fk_event_post_like_1` (`post_id`),
  KEY `fk_event_post_like_2` (`user_id`),
  CONSTRAINT `fk_event_post_like_1` FOREIGN KEY (`post_id`) REFERENCES `event_post` (`event_post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_event_post_like_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_post_like`
--

LOCK TABLES `event_post_like` WRITE;
/*!40000 ALTER TABLE `event_post_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_post_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `friend_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_from` int(11) DEFAULT NULL,
  `user_to` int(11) DEFAULT NULL,
  `request_status` enum('A','P','R') DEFAULT NULL,
  `is_seen` enum('T','F') DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`friend_request_id`),
  KEY `fk_friend_request_1` (`user_from`),
  KEY `fk_friend_request_2` (`user_to`),
  CONSTRAINT `fk_friend_request_1` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_friend_request_2` FOREIGN KEY (`user_to`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES (34,55,50,'P','F',NULL,NULL),(59,51,62,'P','F',NULL,NULL),(65,54,50,'P','F',NULL,NULL);
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_members`
--

DROP TABLE IF EXISTS `group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_members` (
  `group_members_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_admin` enum('T','F') DEFAULT NULL,
  `member_request` enum('A','P','R','L') DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`group_members_id`),
  KEY `fk_group_members_1` (`group_id`),
  KEY `fk_group_members_2` (`user_id`),
  CONSTRAINT `fk_group_members_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_group_members_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_members`
--

LOCK TABLES `group_members` WRITE;
/*!40000 ALTER TABLE `group_members` DISABLE KEYS */;
INSERT INTO `group_members` VALUES (21,16,58,'T','A','2015-04-27 00:00:00',NULL),(22,16,51,'F','A','2015-04-27 00:00:00',NULL),(23,16,52,'F','A','2015-04-27 00:00:00',NULL),(24,16,56,'F','A','2015-04-27 00:00:00',NULL),(25,16,50,'F','A','2015-04-27 00:00:00',NULL),(26,18,51,'T','A','2015-04-27 00:00:00',NULL),(27,18,51,'T','A','2015-04-27 00:00:00',NULL),(28,18,52,'F','A','2015-04-27 00:00:00',NULL),(29,18,52,'F','A','2015-04-27 00:00:00',NULL),(30,18,55,'F','L','2015-04-27 00:00:00','2015-04-27 00:00:00'),(31,18,55,'F','L','2015-04-27 00:00:00','2015-04-27 00:00:00'),(32,18,58,'F','L','2015-04-27 00:00:00','2015-04-27 00:00:00'),(33,18,58,'F','L','2015-04-27 00:00:00','2015-04-27 00:00:00'),(34,16,55,'F','A','2015-04-27 00:00:00',NULL),(35,19,58,'T','A','2015-04-27 00:00:00',NULL),(36,19,57,'F','A','2015-04-27 00:00:00',NULL),(37,19,55,'F','A','2015-04-27 00:00:00',NULL),(38,20,59,'T','A','2015-04-27 00:00:00',NULL),(39,20,56,'F','A','2015-04-27 00:00:00',NULL),(40,20,50,'F','A','2015-04-27 00:00:00',NULL),(41,20,51,'F','A','2015-04-27 00:00:00',NULL),(42,20,54,'F','A','2015-04-27 00:00:00',NULL),(43,20,58,'F','A','2015-04-27 00:00:00',NULL),(44,21,50,'T','A','2015-04-29 00:00:00',NULL),(45,21,61,'F','A','2015-04-29 00:00:00',NULL),(46,21,56,'F','A','2015-04-29 00:00:00',NULL),(47,21,53,'F','A','2015-04-29 00:00:00',NULL),(48,21,51,'F','A','2015-04-29 00:00:00',NULL),(49,22,52,'T','A','2015-04-29 00:00:00',NULL),(50,22,51,'F','A','2015-04-29 00:00:00',NULL),(51,22,50,'F','A','2015-04-29 00:00:00',NULL),(52,23,51,'T','A','2015-05-01 00:00:00',NULL),(53,23,52,'F','A','2015-05-01 00:00:00',NULL),(54,23,50,'F','A','2015-05-01 00:00:00',NULL);
/*!40000 ALTER TABLE `group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_post`
--

DROP TABLE IF EXISTS `group_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_post` (
  `group_post_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_description` varchar(1000) DEFAULT NULL,
  `user_from` int(11) DEFAULT NULL,
  `group_to` int(11) DEFAULT NULL,
  `post_date` datetime DEFAULT NULL,
  `pic_name` varchar(500) DEFAULT NULL,
  `post_type` varchar(45) DEFAULT NULL,
  `album_name` varchar(45) DEFAULT NULL,
  `youtube_video_link` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`group_post_id`),
  KEY `fk_group_post_1` (`user_from`),
  KEY `fk_group_post_2` (`group_to`),
  CONSTRAINT `fk_group_post_1` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_group_post_2` FOREIGN KEY (`group_to`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_post`
--

LOCK TABLES `group_post` WRITE;
/*!40000 ALTER TABLE `group_post` DISABLE KEYS */;
INSERT INTO `group_post` VALUES (4,'hello',58,16,'2015-04-27 16:15:15',NULL,'Mansi Sethi Group Post','timeline',''),(5,'',58,16,'2015-04-27 16:16:17','156327.jpeg','Mansi Sethi Group Post','timeline',''),(6,'hi test post in group',59,20,'2015-04-27 19:43:17',NULL,'Raman Garg Group Post','timeline',''),(7,'hi alll',50,21,'2015-04-29 16:48:09',NULL,'Rajan Padalia Group Post','timeline',''),(8,'did you know..!!?? rajan throws party today evening..!! do come..!! and njoyy #dance_party #choco_lava  :P :D',61,21,'2015-04-29 16:50:21',NULL,'shaily sanghvi Group Post','timeline',''),(9,'',52,22,'2015-04-29 17:46:24','218203.jpeg','Kaustav Sen Group Post','timeline',''),(10,NULL,52,NULL,'2015-04-29 17:46:30',NULL,'Kaustav Sen Group Post','timeline',NULL),(11,'',52,22,'2015-04-29 17:46:52','800045.jpeg','Kaustav Sen Group Post','timeline',''),(12,NULL,52,NULL,'2015-04-29 17:47:02',NULL,'Kaustav Sen Group Post','timeline',NULL);
/*!40000 ALTER TABLE `group_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_post_comment`
--

DROP TABLE IF EXISTS `group_post_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_post_comment` (
  `group_post_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`group_post_comment_id`),
  KEY `fk_group_post_comment_1` (`post_id`),
  KEY `fk_group_post_comment_2` (`user_id`),
  CONSTRAINT `fk_group_post_comment_1` FOREIGN KEY (`post_id`) REFERENCES `group_post` (`group_post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_group_post_comment_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_post_comment`
--

LOCK TABLES `group_post_comment` WRITE;
/*!40000 ALTER TABLE `group_post_comment` DISABLE KEYS */;
INSERT INTO `group_post_comment` VALUES (1,8,51,'2015-04-29','when???? timing???'),(2,8,50,'2015-04-29','shaily when r u going to give ??'),(3,8,53,'2015-04-29','aavsu');
/*!40000 ALTER TABLE `group_post_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_post_like`
--

DROP TABLE IF EXISTS `group_post_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_post_like` (
  `group_post_like_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`group_post_like_id`),
  KEY `fk_group_post_like_1` (`post_id`),
  KEY `fk_group_post_like_2` (`user_id`),
  CONSTRAINT `fk_group_post_like_1` FOREIGN KEY (`post_id`) REFERENCES `group_post` (`group_post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_group_post_like_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_post_like`
--

LOCK TABLES `group_post_like` WRITE;
/*!40000 ALTER TABLE `group_post_like` DISABLE KEYS */;
INSERT INTO `group_post_like` VALUES (2,5,58,'2015-04-27 16:16:44');
/*!40000 ALTER TABLE `group_post_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(500) DEFAULT NULL,
  `privacy` enum('private','public','secret') DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `group_description` varchar(45) DEFAULT NULL,
  `icon` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (16,'test 1',NULL,'2015-04-27 00:00:00',NULL,'images/grp7.jpeg'),(17,'TestGroup',NULL,'2015-04-27 00:00:00',NULL,'images/grp10.jpeg'),(18,'TestGroup',NULL,'2015-04-27 00:00:00',NULL,'images/grp10.jpeg'),(19,'test 2',NULL,'2015-04-27 00:00:00',NULL,'images/grp7.jpeg'),(20,'test iiitb team',NULL,'2015-04-27 00:00:00',NULL,'images/grp11.jpeg'),(21,'Test',NULL,'2015-04-29 00:00:00',NULL,'images/grp12.png'),(22,'huhu',NULL,'2015-04-29 00:00:00',NULL,'images/grp4.jpeg'),(23,'anish_group',NULL,'2015-05-01 00:00:00',NULL,'images/grp4.jpeg');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(1000) DEFAULT NULL,
  `user_from` int(11) DEFAULT NULL,
  `user_to` int(11) DEFAULT NULL,
  `is_seen` enum('T','F') DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `conversation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`message_id`),
  KEY `fk_messages_1` (`user_from`),
  KEY `fk_messages_2` (`user_to`),
  KEY `fk_messages_3_idx` (`conversation_id`),
  CONSTRAINT `fk_messages_1` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_messages_2` FOREIGN KEY (`user_to`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_messages_3` FOREIGN KEY (`conversation_id`) REFERENCES `user_conversation` (`user_conversation_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (49,'hi there...',53,54,'T','2015-04-27 10:42:59',11),(50,'helllozzz',54,53,'T','2015-04-27 10:43:56',11),(51,'your module is working... now send me friend req',53,54,'T','2015-04-27 10:44:24',11),(52,'hi test message from raman',59,55,'T','2015-04-27 13:49:25',12),(53,'hi thanks .. reply from nitin',55,59,'T','2015-04-27 13:51:22',12),(54,'hi shaily',53,61,'T','2015-04-29 11:01:45',13),(55,'hiii setu..!!!\r\n',61,53,'T','2015-04-29 11:02:07',13),(56,'wassuupp',61,53,'T','2015-04-29 11:02:21',13),(57,'nasto kari lidho',53,61,'T','2015-04-29 11:02:25',13),(58,'Heyy ',61,51,'T','2015-04-29 11:02:41',14),(59,'thankiiuu',61,53,'T','2015-04-29 11:02:48',13),(60,'hi anish here',51,53,'T','2015-04-29 11:07:09',15),(61,'hi',51,61,'T','2015-04-29 11:08:19',14),(62,'HI Anish :P',52,51,'T','2015-04-29 11:09:19',16),(63,'no... thank you\r\n',53,61,'T','2015-04-29 11:11:11',13),(64,'hi there',53,51,'T','2015-04-29 11:11:22',15),(65,'hi replied\r\n',51,52,'T','2015-04-29 11:12:24',16),(66,'hello pandey ji',53,62,'F','2015-04-29 11:12:29',17),(67,'tum log aadhe features hi de rahe ho\r\n',61,51,'T','2015-04-29 11:13:52',14),(68,'chutyeeeeeee',50,52,'T','2015-04-29 11:14:14',18),(69,'salee',52,50,'T','2015-04-29 11:15:00',18),(70,'**************',50,52,'T','2015-04-29 11:15:22',18),(71,'abe sale',52,50,'T','2015-04-29 11:15:52',18),(72,'***** ***',50,52,'T','2015-04-29 11:17:07',18),(73,'vai chal aj chicken khate h\r\n',52,50,'T','2015-04-29 11:17:33',18),(74,'mera *******',50,52,'F','2015-04-29 11:20:01',18),(75,'kch kha le',54,53,'T','2015-04-29 11:31:36',11),(76,'okay..',53,54,'T','2015-04-29 11:44:42',11),(77,'ohkkk',54,53,'T','2015-04-29 11:45:24',11);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `notification_id` int(10) NOT NULL AUTO_INCREMENT,
  `notification_type` enum('friend','like','comment','group','event','post') DEFAULT NULL,
  `user_from` int(11) DEFAULT NULL,
  `user_to` int(11) DEFAULT NULL,
  `message` varchar(500) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `is_seen` enum('T','F') DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `fk1_idx` (`user_from`),
  KEY `fk2_idx` (`user_to`),
  CONSTRAINT `fk1` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk2` FOREIGN KEY (`user_to`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (42,'friend',50,52,'userNewsFeedAction?user_id=50 has accepted you friend request','Kaustav Sen','2015-04-27 10:42:53','T'),(43,'friend',52,50,'Kaustav Sen accepted your friend request.','profile.jsp?user_id=52','2015-04-27 10:43:39','T'),(44,'group',58,51,'Mansi Sethi has added you on group:test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:44:41','T'),(45,'group',58,52,'Mansi Sethi has added you on group:test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:44:41','T'),(46,'group',58,56,'Mansi Sethi has added you on group:test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:45:01','T'),(47,'group',58,50,'Mansi Sethi has added you on group:test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:45:01','T'),(48,'post',58,51,'Mansi Sethi has posted in group test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:45:15','T'),(49,'post',58,52,'Mansi Sethi has posted in group test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:45:15','T'),(50,'post',58,56,'Mansi Sethi has posted in group test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:45:15','T'),(51,'post',58,50,'Mansi Sethi has posted in group test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:45:15','T'),(52,'friend',51,50,'Anish Ratnawat accepted your friend request.','profile.jsp?user_id=51','2015-04-27 10:45:54','T'),(53,'post',58,51,'Mansi Sethi has posted in group test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:46:17','T'),(54,'post',58,52,'Mansi Sethi has posted in group test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:46:17','T'),(55,'post',58,56,'Mansi Sethi has posted in group test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:46:17','T'),(56,'post',58,50,'Mansi Sethi has posted in group test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:46:17','T'),(57,'group',51,52,'Anish Ratnawat has added you on group:TestGroup','getGroupDetailAction.action?group_id=18','2015-04-27 10:48:50','T'),(58,'group',51,52,'Anish Ratnawat has added you on group:TestGroup','getGroupDetailAction.action?group_id=18','2015-04-27 10:48:50','T'),(59,'group',51,55,'Anish Ratnawat has added you on group:TestGroup','getGroupDetailAction.action?group_id=18','2015-04-27 10:48:50','T'),(60,'group',51,55,'Anish Ratnawat has added you on group:TestGroup','getGroupDetailAction.action?group_id=18','2015-04-27 10:48:50','T'),(61,'group',51,58,'Anish Ratnawat has added you on group:TestGroup','getGroupDetailAction.action?group_id=18','2015-04-27 10:48:50','T'),(62,'group',51,58,'Anish Ratnawat has added you on group:TestGroup','getGroupDetailAction.action?group_id=18','2015-04-27 10:48:50','T'),(63,'group',58,55,'Mansi Sethi has added you on group:test 1','getGroupDetailAction.action?group_id=16','2015-04-27 10:49:23','T'),(64,'friend',51,52,'Anish Ratnawat has sent you friend request','userNewsFeedAction?user_id=52','2015-04-27 10:50:32','T'),(65,'friend',55,53,'Nitin kulkarni accepted your friend request.','profile.jsp?user_id=55','2015-04-27 10:50:59','T'),(66,'friend',52,51,'Kaustav Sen accepted your friend request.','profile.jsp?user_id=52','2015-04-27 10:51:15','T'),(67,'friend',52,53,'Kaustav Sen accepted your friend request.','profile.jsp?user_id=52','2015-04-27 10:51:18','T'),(68,'event',55,53,'Nitin kulkarni has sent you an invite to join Facebook Demo','eventList','2015-04-27 10:51:18','T'),(69,'friend',52,55,'Kaustav Sen accepted your friend request.','profile.jsp?user_id=52','2015-04-27 10:54:11','T'),(70,'friend',52,57,'Kaustav Sen accepted your friend request.','profile.jsp?user_id=52','2015-04-27 10:54:16','T'),(71,'like',53,51,'Setu Patani has liked your post','userNewsFeedAction?user_id=53','2015-04-27 10:54:58','T'),(72,'comment',53,51,'Setu Patani has commented your post','userNewsFeedAction?user_id=53','2015-04-27 10:55:09','T'),(73,'friend',51,57,'Anish Ratnawat has sent you friend request','userNewsFeedAction?user_id=57','2015-04-27 10:55:15','T'),(74,'friend',57,51,'Radhika Mandil accepted your friend request.','profile.jsp?user_id=57','2015-04-27 10:55:32','T'),(75,'friend',54,53,'Nupur Garg accepted your friend request.','profile.jsp?user_id=54','2015-04-27 10:55:47','T'),(76,'friend',54,55,'Nupur Garg has sent you friend request','userNewsFeedAction?user_id=55','2015-04-27 10:56:24','T'),(77,'like',52,51,'Kaustav Sen has liked your post','userNewsFeedAction?user_id=52','2015-04-27 10:56:28','T'),(78,'comment',52,51,'Kaustav Sen has commented your post','userNewsFeedAction?user_id=52','2015-04-27 10:57:19','T'),(79,'friend',55,54,'Nitin kulkarni has sent you friend request','userNewsFeedAction?user_id=54','2015-04-27 11:04:17','T'),(80,'friend',55,51,'Nitin kulkarni has sent you friend request','userNewsFeedAction?user_id=51','2015-04-27 11:04:19','T'),(81,'friend',55,50,'Nitin kulkarni has sent you friend request','userNewsFeedAction?user_id=50','2015-04-27 11:04:19','T'),(82,'event',55,52,'Nitin kulkarni has sent you an invite to join Facebook Demo','eventList','2015-04-27 11:04:34','T'),(83,'friend',51,55,'Anish Ratnawat accepted your friend request.','profile.jsp?user_id=51','2015-04-27 11:04:38','T'),(84,'group',58,57,'Mansi Sethi has added you on group:test 2','getGroupDetailAction.action?group_id=19','2015-04-27 11:05:04','T'),(85,'group',58,55,'Mansi Sethi has added you on group:test 2','getGroupDetailAction.action?group_id=19','2015-04-27 11:05:04','T'),(86,'post',51,55,'Anish Ratnawat has posted on your wall','userNewsFeedAction?user_id=51','2015-04-27 11:06:31','T'),(87,'like',55,51,'Nitin kulkarni has liked your post','userNewsFeedAction?user_id=55','2015-04-27 11:07:01','T'),(88,'comment',55,51,'Nitin kulkarni has commented your post','userNewsFeedAction?user_id=55','2015-04-27 11:07:10','T'),(89,'friend',55,52,'Nitin kulkarni accepted your friend request.','profile.jsp?user_id=55','2015-04-27 11:07:19','T'),(90,'event',55,51,'Nitin kulkarni has sent you an invite to join Facebook Demo','eventList','2015-04-27 11:07:41','T'),(91,'friend',51,58,'Anish Ratnawat accepted your friend request.','profile.jsp?user_id=51','2015-04-27 11:07:42','T'),(92,'event',51,58,'Anish Ratnawat has sent you an invite to join Facebook Demo','eventList','2015-04-27 11:08:05','T'),(93,'friend',55,57,'Nitin kulkarni accepted your friend request.','profile.jsp?user_id=55','2015-04-27 11:12:33','F'),(94,'event',55,57,'Nitin kulkarni has sent you an invite to join Facebook Demo','eventList','2015-04-27 11:12:47','F'),(95,'friend',52,51,'Kaustav Sen has sent you friend request','userNewsFeedAction?user_id=51','2015-04-27 11:39:14','T'),(96,'friend',51,52,'Anish Ratnawat accepted your friend request.','profile.jsp?user_id=51','2015-04-27 11:41:53','T'),(97,'friend',52,51,'Kaustav Sen has sent you friend request','userNewsFeedAction?user_id=51','2015-04-27 11:43:42','T'),(98,'friend',52,51,'Kaustav Sen has sent you friend request','userNewsFeedAction?user_id=51','2015-04-27 11:44:22','T'),(99,'friend',51,52,'Anish Ratnawat accepted your friend request.','profile.jsp?user_id=51','2015-04-27 11:44:43','T'),(100,'friend',52,51,'Kaustav Sen has sent you friend request','userNewsFeedAction?user_id=51','2015-04-27 11:45:02','T'),(101,'friend',51,52,'Anish Ratnawat accepted your friend request.','profile.jsp?user_id=51','2015-04-27 11:45:18','T'),(102,'friend',52,51,'Kaustav Sen has sent you friend request','userNewsFeedAction?user_id=51','2015-04-27 11:45:44','T'),(103,'friend',52,59,'Kaustav Sen accepted your friend request.','profile.jsp?user_id=52','2015-04-27 13:06:11','T'),(104,'friend',57,59,'Radhika Mandil accepted your friend request.','profile.jsp?user_id=57','2015-04-27 13:06:50','T'),(105,'friend',54,59,'Nupur Garg accepted your friend request.','profile.jsp?user_id=54','2015-04-27 13:07:18','T'),(106,'post',59,52,'Raman Garg has posted on your wall','userNewsFeedAction?user_id=59','2015-04-27 13:20:24','T'),(107,'post',59,52,'Raman Garg has posted on your wall','userNewsFeedAction?user_id=59','2015-04-27 13:33:20','T'),(108,'friend',59,55,'Raman Garg has sent you friend request','userNewsFeedAction?user_id=55','2015-04-27 13:41:20','F'),(109,'friend',59,53,'Raman Garg has sent you friend request','userNewsFeedAction?user_id=53','2015-04-27 13:44:53','T'),(110,'friend',53,59,'Setu Patani accepted your friend request.','profile.jsp?user_id=53','2015-04-27 13:45:35','F'),(111,'event',59,52,'Raman Garg has sent you an invite to join event test 01','eventList','2015-04-27 13:55:37','T'),(112,'event',59,54,'Raman Garg has sent you an invite to join event test 01','eventList','2015-04-27 13:55:37','T'),(113,'event',59,53,'Raman Garg has sent you an invite to join event test 01','eventList','2015-04-27 13:55:37','T'),(114,'group',59,56,'Raman Garg has added you on group:test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:10:27','T'),(115,'group',59,50,'Raman Garg has added you on group:test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:10:27','T'),(116,'group',59,51,'Raman Garg has added you on group:test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:10:28','T'),(117,'group',59,54,'Raman Garg has added you on group:test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:10:28','T'),(118,'post',59,56,'Raman Garg has posted in group test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:13:17','T'),(119,'post',59,50,'Raman Garg has posted in group test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:13:17','T'),(120,'post',59,51,'Raman Garg has posted in group test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:13:17','T'),(121,'post',59,54,'Raman Garg has posted in group test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:13:17','T'),(122,'group',56,58,'Dhruvik Shah has added you on group:test iiitb team','getGroupDetailAction.action?group_id=20','2015-04-27 14:15:51','T'),(123,'friend',52,51,'Kaustav Sen has sent you friend request','userNewsFeedAction?user_id=51','2015-04-28 13:46:18','T'),(124,'friend',51,52,'Anish Ratnawat accepted your friend request.','userNewsFeedAction?user_id=51','2015-04-28 13:46:34','T'),(125,'comment',52,51,'Kaustav Sen has commented your post','userNewsFeedAction?user_id=52','2015-04-28 13:47:13','T'),(126,'like',51,50,'Anish Ratnawat has liked your post','userNewsFeedAction?user_id=51','2015-04-29 10:28:17','T'),(127,'comment',51,50,'Anish Ratnawat has commented your post','userNewsFeedAction?user_id=51','2015-04-29 10:28:44','T'),(128,'like',52,51,'Kaustav Sen has liked your post','userNewsFeedAction?user_id=52','2015-04-29 10:29:00','T'),(129,'comment',52,51,'Kaustav Sen has commented your post','userNewsFeedAction?user_id=52','2015-04-29 10:29:31','T'),(130,'post',52,51,'Kaustav Sen has posted on your wall','userNewsFeedAction?user_id=52','2015-04-29 10:35:34','T'),(131,'post',52,51,'Kaustav Sen has posted on your wall','userNewsFeedAction?user_id=51','2015-04-29 10:50:09','T'),(132,'like',53,52,'Setu Patani has liked your post','userNewsFeedAction?user_id=52','2015-04-29 10:51:08','T'),(133,'like',51,52,'Anish Ratnawat has liked your post','userNewsFeedAction?user_id=52','2015-04-29 10:51:14','T'),(134,'like',53,52,'Setu Patani has liked your post','userNewsFeedAction?user_id=52','2015-04-29 10:51:36','T'),(135,'like',53,52,'Setu Patani has liked your post','userNewsFeedAction?user_id=52','2015-04-29 10:51:52','T'),(136,'comment',51,52,'Anish Ratnawat has commented your post','userNewsFeedAction?user_id=52','2015-04-29 10:53:53','T'),(137,'like',50,52,'Rajan Padalia has liked your post','userNewsFeedAction?user_id=52','2015-04-29 10:55:01','T'),(138,'friend',53,51,'Setu Patani has sent you friend request','userNewsFeedAction?user_id=51','2015-04-29 10:55:15','T'),(139,'friend',51,53,'Anish Ratnawat accepted your friend request.','userNewsFeedAction?user_id=51','2015-04-29 10:55:32','T'),(140,'post',53,50,'Setu Patani has posted on your wall','userNewsFeedAction?user_id=53','2015-04-29 10:56:36','T'),(141,'post',51,50,'Anish Ratnawat has posted on your wall','userNewsFeedAction?user_id=51','2015-04-29 10:56:44','T'),(142,'like',52,51,'Kaustav Sen has liked your post','userNewsFeedAction?user_id=51','2015-04-29 10:57:20','T'),(143,'post',52,50,'Kaustav Sen has posted on your wall','userNewsFeedAction?user_id=52','2015-04-29 10:57:59','T'),(144,'friend',53,54,'Setu Patani has sent you friend request','userNewsFeedAction?user_id=54','2015-04-29 10:58:58','T'),(145,'comment',51,52,'Anish Ratnawat has commented your post','userNewsFeedAction?user_id=52','2015-04-29 11:00:16','T'),(146,'friend',61,53,'shaily sanghvi accepted your friend request.','userNewsFeedAction?user_id=61','2015-04-29 11:01:11','T'),(147,'friend',51,61,'Anish Ratnawat accepted your friend request.','userNewsFeedAction?user_id=51','2015-04-29 11:01:40','T'),(148,'comment',51,50,'Anish Ratnawat has commented your post','userNewsFeedAction?user_id=50','2015-04-29 11:01:54','T'),(149,'friend',50,61,'Rajan Padalia accepted your friend request.','userNewsFeedAction?user_id=50','2015-04-29 11:04:13','T'),(150,'comment',53,52,'Setu Patani has commented your post','userNewsFeedAction?user_id=52','2015-04-29 11:05:41','T'),(151,'friend',52,61,'Kaustav Sen has sent you friend request','userNewsFeedAction?user_id=61','2015-04-29 11:06:08','T'),(152,'like',51,61,'Anish Ratnawat has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:06:16','T'),(153,'friend',61,52,'shaily sanghvi accepted your friend request.','userNewsFeedAction?user_id=61','2015-04-29 11:06:20','T'),(154,'comment',53,61,'Setu Patani has commented your post','userNewsFeedAction?user_id=61','2015-04-29 11:06:20','T'),(155,'comment',50,61,'Rajan Padalia has commented your post','userNewsFeedAction?user_id=61','2015-04-29 11:06:21','T'),(156,'like',53,61,'Setu Patani has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:06:25','T'),(157,'like',50,61,'Rajan Padalia has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:06:55','T'),(158,'like',52,61,'Kaustav Sen has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:08:46','T'),(159,'friend',53,62,'Setu Patani accepted your friend request.','userNewsFeedAction?user_id=53','2015-04-29 11:09:45','T'),(160,'like',52,51,'Kaustav Sen has liked your post','userNewsFeedAction?user_id=51','2015-04-29 11:10:55','T'),(161,'friend',52,62,'Kaustav Sen has sent you friend request','userNewsFeedAction?user_id=62','2015-04-29 11:11:50','T'),(162,'like',52,61,'Kaustav Sen has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:12:14','T'),(163,'friend',62,52,'Gaurav Pandey accepted your friend request.','userNewsFeedAction?user_id=62','2015-04-29 11:12:53','T'),(164,'like',51,61,'Anish Ratnawat has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:12:59','T'),(165,'friend',50,53,'Rajan Padalia accepted your friend request.','userNewsFeedAction?user_id=50','2015-04-29 11:16:55','T'),(166,'friend',51,62,'Anish Ratnawat has sent you friend request','userNewsFeedAction?user_id=62','2015-04-29 11:16:56','F'),(167,'friend',51,59,'Anish Ratnawat accepted your friend request.','userNewsFeedAction?user_id=51','2015-04-29 11:17:02','F'),(168,'friend',56,61,'Dhruvik Shah accepted your friend request.','userNewsFeedAction?user_id=56','2015-04-29 11:17:03','T'),(169,'post',56,61,'Dhruvik Shah has posted on your wall','userNewsFeedAction?user_id=56','2015-04-29 11:17:25','T'),(170,'friend',51,56,'Anish Ratnawat has sent you friend request','userNewsFeedAction?user_id=56','2015-04-29 11:17:27','T'),(171,'like',56,61,'Dhruvik Shah has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:17:55','T'),(172,'group',50,61,'Rajan Padalia has added you on group:Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:17:58','T'),(173,'group',50,56,'Rajan Padalia has added you on group:Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:17:58','T'),(174,'group',50,53,'Rajan Padalia has added you on group:Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:17:58','T'),(175,'post',50,61,'Rajan Padalia has posted in group Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:18:09','T'),(176,'post',50,56,'Rajan Padalia has posted in group Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:18:09','T'),(177,'post',50,53,'Rajan Padalia has posted in group Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:18:09','T'),(178,'like',50,61,'Rajan Padalia has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:18:23','T'),(179,'like',53,61,'Setu Patani has liked your post','userNewsFeedAction?user_id=61','2015-04-29 11:18:27','T'),(180,'post',61,50,'shaily sanghvi has posted in group Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:20:21','T'),(181,'post',61,56,'shaily sanghvi has posted in group Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:20:21','T'),(182,'post',61,53,'shaily sanghvi has posted in group Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:20:22','T'),(183,'friend',56,51,'Dhruvik Shah accepted your friend request.','userNewsFeedAction?user_id=56','2015-04-29 11:25:08','T'),(184,'group',61,51,'shaily sanghvi has added you on group:Test','getGroupDetailAction.action?group_id=21','2015-04-29 11:25:38','T'),(185,'friend',53,56,'Setu Patani accepted your friend request.','userNewsFeedAction?user_id=53','2015-04-29 11:25:53','T'),(186,'comment',51,61,'Anish Ratnawat has commented your post','userNewsFeedAction?user_id=51','2015-04-29 11:27:33','T'),(187,'friend',53,56,'Setu Patani accepted your friend request.','userNewsFeedAction?user_id=53','2015-04-29 11:27:43','F'),(188,'comment',50,61,'Rajan Padalia has commented your post','userNewsFeedAction?user_id=50','2015-04-29 11:28:37','T'),(189,'event',61,53,'shaily sanghvi has sent you an invite to join rajan\'s party','eventList','2015-04-29 11:29:27','T'),(190,'event',61,51,'shaily sanghvi has sent you an invite to join rajan\'s party','eventList','2015-04-29 11:29:27','T'),(191,'event',61,50,'shaily sanghvi has sent you an invite to join rajan\'s party','eventList','2015-04-29 11:29:27','T'),(192,'event',61,52,'shaily sanghvi has sent you an invite to join rajan\'s party','eventList','2015-04-29 11:29:27','T'),(193,'event',61,56,'shaily sanghvi has sent you an invite to join rajan\'s party','eventList','2015-04-29 11:29:27','F'),(194,'like',54,59,'Nupur Garg has liked your post','userNewsFeedAction?user_id=59','2015-04-29 11:30:02','F'),(195,'post',53,50,'Setu Patani has posted on your wall','userNewsFeedAction?user_id=53','2015-04-29 11:30:57','F'),(196,'comment',50,53,'Rajan Padalia has commented your post','userNewsFeedAction?user_id=53','2015-04-29 11:31:34','T'),(197,'friend',54,52,'Nupur Garg accepted your friend request.','userNewsFeedAction?user_id=54','2015-04-29 11:31:44','T'),(198,'friend',54,53,'Nupur Garg accepted your friend request.','userNewsFeedAction?user_id=54','2015-04-29 11:31:50','T'),(199,'friend',54,53,'Nupur Garg accepted your friend request.','userNewsFeedAction?user_id=54','2015-04-29 11:31:56','T'),(200,'friend',54,53,'Nupur Garg accepted your friend request.','userNewsFeedAction?user_id=54','2015-04-29 11:32:10','T'),(201,'friend',54,53,'Nupur Garg accepted your friend request.','userNewsFeedAction?user_id=54','2015-04-29 11:32:27','T'),(202,'friend',54,53,'Nupur Garg accepted your friend request.','userNewsFeedAction?user_id=54','2015-04-29 11:32:54','T'),(203,'friend',54,53,'Nupur Garg accepted your friend request.','userNewsFeedAction?user_id=54','2015-04-29 11:33:24','T'),(204,'friend',54,52,'Nupur Garg accepted your friend request.','userNewsFeedAction?user_id=54','2015-04-29 11:34:20','T'),(205,'friend',53,51,'Setu Patani has sent you friend request','userNewsFeedAction?user_id=51','2015-04-29 11:40:28','T'),(206,'friend',51,53,'Anish Ratnawat accepted your friend request.','userNewsFeedAction?user_id=51','2015-04-29 11:40:32','T'),(207,'like',53,54,'Setu Patani has liked your post','userNewsFeedAction?user_id=54','2015-04-29 11:44:31','T'),(208,'event',53,52,'Setu Patani has posted in event event test 01','events?eventId=17','2015-04-29 11:45:48','T'),(209,'event',53,54,'Setu Patani has posted in event event test 01','events?eventId=17','2015-04-29 11:45:48','T'),(210,'event',53,59,'Setu Patani has posted in event event test 01','events?eventId=17','2015-04-29 11:45:48','F'),(211,'comment',53,61,'Setu Patani has commented your post','userNewsFeedAction?user_id=53','2015-04-29 11:46:40','T'),(212,'post',51,52,'Anish Ratnawat has posted on your wall','userNewsFeedAction?user_id=51','2015-04-29 11:47:43','T'),(213,'friend',58,52,'Mansi Sethi accepted your friend request.','userNewsFeedAction?user_id=58','2015-04-29 11:48:08','T'),(214,'like',52,51,'Kaustav Sen has liked your post','userNewsFeedAction?user_id=51','2015-04-29 11:48:16','T'),(215,'comment',53,51,'Setu Patani has commented your post','userNewsFeedAction?user_id=51','2015-04-29 11:48:25','T'),(216,'comment',53,51,'Setu Patani has commented your post','userNewsFeedAction?user_id=51','2015-04-29 11:48:27','T'),(217,'like',54,52,'Nupur Garg has liked your post','userNewsFeedAction?user_id=52','2015-04-29 12:01:27','T'),(218,'friend',51,54,'Anish Ratnawat accepted your friend request.','userNewsFeedAction?user_id=51','2015-04-29 12:01:58','T'),(219,'like',51,54,'Anish Ratnawat has liked your post','userNewsFeedAction?user_id=54','2015-04-29 12:02:24','T'),(220,'event',54,51,'Nupur Garg has sent you an invite to join event test 01','eventList','2015-04-29 12:02:26','T'),(221,'group',52,51,'Kaustav Sen has added you on group:huhu','getGroupDetailAction.action?group_id=22','2015-04-29 12:16:06','T'),(222,'group',52,50,'Kaustav Sen has added you on group:huhu','getGroupDetailAction.action?group_id=22','2015-04-29 12:16:06','F'),(223,'post',52,51,'Kaustav Sen has posted in group huhu','getGroupDetailAction.action?group_id=22','2015-04-29 12:16:25','T'),(224,'post',52,50,'Kaustav Sen has posted in group huhu','getGroupDetailAction.action?group_id=22','2015-04-29 12:16:25','F'),(225,'post',52,51,'Kaustav Sen has posted in group huhu','getGroupDetailAction.action?group_id=22','2015-04-29 12:16:52','T'),(226,'post',52,50,'Kaustav Sen has posted in group huhu','getGroupDetailAction.action?group_id=22','2015-04-29 12:16:52','F'),(227,'group',51,52,'Anish Ratnawat has added you on group:anish_group','getGroupDetailAction.action?group_id=23','2015-04-30 19:36:03','T'),(228,'group',51,50,'Anish Ratnawat has added you on group:anish_group','getGroupDetailAction.action?group_id=23','2015-04-30 19:36:03','F'),(229,'friend',51,52,'Anish Ratnawat has suggested Dhruvik Shah as your friend.','userNewsFeedAction?user_id=56','2015-04-30 20:21:04','T'),(230,'friend',51,52,'Anish Ratnawat has suggested Dhruvik Shah as your friend.','userNewsFeedAction?user_id=56','2015-04-30 20:21:08','T'),(231,'friend',51,52,'Anish Ratnawat has suggested Dhruvik Shah as your friend.','userNewsFeedAction?user_id=56','2015-04-30 20:22:59','T');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo` (
  `photo_id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) DEFAULT NULL,
  `photo_name` varchar(45) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `fk_photo_1` (`album_id`),
  CONSTRAINT `fk_photo_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES (31,122,'261549.png','2015-04-27 16:11:05'),(32,121,'356119.png','2015-04-27 16:11:19'),(33,125,'111364.jpeg','2015-04-27 16:11:52'),(34,127,'448056.jpeg','2015-04-27 16:11:54'),(35,124,'71592.jpeg','2015-04-27 16:12:15'),(36,128,NULL,'2015-04-27 16:12:47'),(37,130,'77579.jpeg','2015-04-27 16:14:53'),(38,131,'62553.jpeg','2015-04-27 16:15:18'),(39,136,'529187.jpeg','2015-04-27 16:15:59'),(41,118,'131093.jpeg','2015-04-27 16:17:33'),(42,137,'177445.jpeg','2015-04-27 16:17:57'),(45,149,'76012.jpeg','2015-04-27 16:19:03'),(47,151,'126905.png','2015-04-27 16:20:38'),(48,151,'473223.png','2015-04-27 16:20:56'),(49,119,'696378.jpeg','2015-04-27 16:21:00'),(50,139,NULL,'2015-04-27 16:24:46'),(51,123,'78279.jpeg','2015-04-27 16:26:14'),(52,120,'688039.jpeg','2015-04-27 16:34:20'),(53,155,'863217.jpeg','2015-04-27 18:28:10'),(54,156,'764922.jpeg','2015-04-27 18:28:50'),(55,123,'914228.gif','2015-04-27 18:50:23'),(56,123,'65865.gif','2015-04-27 19:03:19'),(57,158,'822491.gif','2015-04-27 19:32:00'),(58,158,'241830.gif','2015-04-27 19:32:52'),(59,160,'717093.jpeg','2015-04-27 19:41:12'),(61,160,'874576.jpeg','2015-04-27 19:41:29'),(62,157,'790874.gif','2015-04-27 19:48:39'),(63,120,'686955.jpeg','2015-04-28 18:58:01'),(64,120,'62121.gif','2015-04-28 19:12:23'),(65,122,'947936.jpeg','2015-04-29 15:51:30'),(66,121,'69700.jpeg','2015-04-29 15:51:52'),(67,115,'653516.jpeg','2015-04-29 15:55:04'),(68,116,'105979.jpeg','2015-04-29 15:55:22'),(69,120,'874277.jpeg','2015-04-29 16:05:34'),(70,123,'874277.jpeg','2015-04-29 16:05:34'),(71,123,'639637.jpeg','2015-04-29 16:09:41'),(72,123,'376442.jpeg','2015-04-29 16:11:59'),(73,123,'858049.jpeg','2015-04-29 16:18:47'),(74,120,'918298.jpeg','2015-04-29 16:20:08'),(75,123,'918298.jpeg','2015-04-29 16:20:08'),(76,165,'714908.jpeg','2015-04-29 16:29:04'),(77,165,'144677.jpeg','2015-04-29 16:29:41'),(78,167,'652929.jpeg','2015-04-29 16:34:48'),(79,119,'709248.jpeg','2015-04-29 16:44:31'),(80,172,NULL,'2015-04-29 16:56:12'),(81,172,NULL,'2015-04-29 16:56:16'),(82,172,NULL,'2015-04-29 16:56:18'),(83,128,'919788.jpeg','2015-04-29 17:06:51'),(84,129,'948460.jpeg','2015-04-29 17:08:13'),(85,139,'183847.jpeg','2015-04-29 17:17:00'),(86,140,'806801.jpeg','2015-04-29 17:17:59'),(89,175,'9694.jpeg','2015-04-29 17:47:42'),(90,120,'300484.gif','2015-04-30 21:59:27'),(91,120,'548595.jpeg','2015-04-30 22:00:33'),(92,190,'304525.gif','2015-05-01 01:06:16'),(102,149,'780160.jpeg','2015-05-01 01:07:00'),(103,120,'723013.jpeg','2015-05-01 01:56:13');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacydetail`
--

DROP TABLE IF EXISTS `privacydetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privacydetail` (
  `privacy_name` varchar(45) NOT NULL,
  PRIMARY KEY (`privacy_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacydetail`
--

LOCK TABLES `privacydetail` WRITE;
/*!40000 ALTER TABLE `privacydetail` DISABLE KEYS */;
INSERT INTO `privacydetail` VALUES ('FRIENDS'),('PRIVATE'),('PUBLIC');
/*!40000 ALTER TABLE `privacydetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacysetting`
--

DROP TABLE IF EXISTS `privacysetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privacysetting` (
  `privacyId` int(45) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `privacy_name` varchar(45) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `privacy_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`privacyId`),
  KEY `fk_privacy_1_idx` (`user_id`),
  KEY `fk_privacy_2_idx` (`group_id`),
  KEY `fk_privacy_3_idx` (`event_id`),
  KEY `fk_privacy_4_idx` (`privacy_name`),
  CONSTRAINT `fk_privacy_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_privacy_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_privacy_3` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_privacy_4` FOREIGN KEY (`privacy_name`) REFERENCES `privacydetail` (`privacy_name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacysetting`
--

LOCK TABLES `privacysetting` WRITE;
/*!40000 ALTER TABLE `privacysetting` DISABLE KEYS */;
INSERT INTO `privacysetting` VALUES (3,66,'PRIVATE',NULL,NULL,'timeline'),(4,66,'PRIVATE',NULL,NULL,'friend'),(5,66,'PUBLIC',NULL,NULL,'message'),(6,66,'PUBLIC',NULL,NULL,'about'),(7,66,'PUBLIC',NULL,NULL,'album');
/*!40000 ALTER TABLE `privacysetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `relationship_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`relationship_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship`
--

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
INSERT INTO `relationship` VALUES (1,'Single'),(2,'Married'),(3,'In a relationship'),(4,'Engaged'),(5,'It\'s complicated'),(6,'Seperated'),(7,'Divorced'),(8,'Widowed');
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(45) NOT NULL DEFAULT '',
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `mobile_no` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `secret_question` varchar(500) DEFAULT NULL,
  `secret_answer` varchar(500) DEFAULT NULL,
  `profile_pic` varchar(500) DEFAULT NULL,
  `cover_pic` varchar(500) DEFAULT NULL,
  `isverified` varchar(3) DEFAULT 'Y',
  `hometown` varchar(45) DEFAULT NULL,
  `current_city` varchar(45) DEFAULT NULL,
  `relationship_status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_id_UNIQUE` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (50,'rajanpadalia@gmail.com','Rajan','Padalia','','1998-04-29','male','','2015-04-27 16:08:03','2015-05-01 01:57:37','12345',NULL,NULL,'653516.jpeg','105979.jpeg','Y','','',NULL),(51,'anish.ratnawat@gmail.com','Anish','Ratnawat',NULL,'1991-02-21','Male',NULL,'2015-04-27 16:08:35','2015-05-01 02:03:49','12345',NULL,NULL,'131093.jpeg','709248.jpeg','Y',NULL,NULL,NULL),(52,'senkaustav924@gmail.com','Kaustav','Sen',NULL,'2000-02-19','Male',NULL,'2015-04-27 16:09:56','2015-05-01 01:56:50','12345',NULL,NULL,'69700.jpeg','947936.jpeg','Y',NULL,NULL,NULL),(53,'srpatani@gmail.com','Setu','Patani',NULL,'1993-02-22','Male',NULL,'2015-04-27 16:10:30','2015-04-29 16:46:44','12345',NULL,NULL,'71592.jpeg','111364.jpeg','Y',NULL,NULL,NULL),(54,'nupurgarg1211@gmail.com','Nupur','Garg',NULL,'1989-10-12','Female',NULL,'2015-04-27 16:10:33','2015-04-30 20:49:00','12345',NULL,NULL,'448056.jpeg','919788.jpeg','Y',NULL,NULL,NULL),(55,'nitinkulkarni89@gmail.com','Nitin','kulkarni',NULL,'2012-12-12','Male',NULL,'2015-04-27 16:11:43','2015-04-27 19:36:24','12345',NULL,NULL,'77579.jpeg','62553.jpeg','Y',NULL,NULL,NULL),(56,'djs041092@gmail.com','Dhruvik','Shah',NULL,'1992-10-04','Male',NULL,'2015-04-27 16:11:58','2015-04-29 16:48:05','12345',NULL,NULL,NULL,NULL,'Y',NULL,NULL,NULL),(57,'mandil.radhika@gmail.com','Radhika','Mandil',NULL,'1991-09-27','Female',NULL,'2015-04-27 16:12:59','2015-04-27 19:10:59','12345',NULL,NULL,'529187.jpeg','177445.jpeg','Y',NULL,NULL,NULL),(58,'mansi.sethi@iiitb.org','Mansi','Sethi',NULL,'1991-04-18','Female',NULL,'2015-04-27 16:13:23','2015-04-29 17:18:54','12345',NULL,NULL,'183847.jpeg','806801.jpeg','Y',NULL,NULL,NULL),(59,'raman.garg@iiitb.org','Raman','Garg',NULL,'1991-02-21','Male',NULL,'2015-04-27 18:26:38','2015-04-27 19:49:16','12345',NULL,NULL,'863217.jpeg','764922.jpeg','Y',NULL,NULL,NULL),(60,'ram@gmail.com','Ram','RR',NULL,'1991-02-21','Male',NULL,'2015-04-28 18:50:44',NULL,'12345',NULL,NULL,NULL,NULL,'Y',NULL,NULL,NULL),(61,'shaily.sanghvi@gmail.com','shaily','sanghvi','','1992-03-03','male','','2015-04-29 16:25:10',NULL,'loltesting',NULL,NULL,'144677.jpeg',NULL,'Y','','','5'),(62,'a@gmail.com','Gaurav','Pandey',NULL,'1993-01-24','Male',NULL,'2015-04-29 16:38:33',NULL,'qwerty',NULL,NULL,NULL,NULL,'Y',NULL,NULL,NULL),(64,'abc@gmail.com','Anish','Ra',NULL,'1991-02-21','Male',NULL,'2015-05-01 00:05:06',NULL,'12345',NULL,NULL,NULL,NULL,'Y',NULL,NULL,NULL),(66,'anish.@gmail.com','Anish','Rat',NULL,'1991-02-21','Male',NULL,'2015-05-01 00:09:49',NULL,'12345',NULL,NULL,NULL,NULL,'Y',NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_conversation`
--

DROP TABLE IF EXISTS `user_conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_conversation` (
  `user_conversation_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_from` int(11) DEFAULT NULL,
  `user_to` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_conversation_id`),
  KEY `fk_user_conversation_1_idx` (`user_from`),
  KEY `fk_user_conversation_2_idx` (`user_to`),
  CONSTRAINT `fk_user_conversation_1` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_conversation_2` FOREIGN KEY (`user_to`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_conversation`
--

LOCK TABLES `user_conversation` WRITE;
/*!40000 ALTER TABLE `user_conversation` DISABLE KEYS */;
INSERT INTO `user_conversation` VALUES (11,53,54),(12,59,55),(13,53,61),(14,61,51),(15,51,53),(16,52,51),(17,53,62),(18,50,52);
/*!40000 ALTER TABLE `user_conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_friends`
--

DROP TABLE IF EXISTS `user_friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_friends` (
  `friend_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id1` int(11) NOT NULL,
  `user_id2` int(11) NOT NULL,
  PRIMARY KEY (`friend_id`),
  KEY `u_idx` (`user_id1`),
  KEY `u2_idx` (`user_id2`),
  CONSTRAINT `u1` FOREIGN KEY (`user_id1`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `u2` FOREIGN KEY (`user_id2`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_friends`
--

LOCK TABLES `user_friends` WRITE;
/*!40000 ALTER TABLE `user_friends` DISABLE KEYS */;
INSERT INTO `user_friends` VALUES (29,52,50),(30,50,52),(31,51,50),(32,50,51),(33,55,53),(34,53,55),(37,52,53),(38,53,52),(41,52,57),(42,57,52),(43,57,51),(44,51,57),(49,55,52),(50,52,55),(51,51,58),(52,58,51),(53,55,57),(54,57,55),(61,52,59),(62,59,52),(63,57,59),(64,59,57),(65,54,59),(66,59,54),(73,61,53),(74,53,61),(75,51,61),(76,61,51),(77,50,61),(78,61,50),(79,61,52),(80,52,61),(81,53,62),(82,62,53),(83,62,52),(84,52,62),(85,50,53),(86,53,50),(87,51,59),(88,59,51),(89,56,61),(90,61,56),(91,56,51),(92,51,56),(95,53,56),(96,56,53),(97,54,52),(98,52,54),(99,54,53),(100,53,54),(101,54,53),(102,53,54),(103,54,53),(104,53,54),(105,54,53),(106,53,54),(107,54,53),(108,53,54),(109,54,53),(110,53,54),(111,54,52),(112,52,54),(113,51,53),(114,53,51),(115,58,52),(116,52,58),(117,51,54),(118,54,51);
/*!40000 ALTER TABLE `user_friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_location`
--

DROP TABLE IF EXISTS `user_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_location` (
  `user_location_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `is_current_city` enum('T','F') DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`user_location_id`),
  KEY `fk_user_location_1` (`user_id`),
  KEY `fk_user_location_2` (`city_id`),
  CONSTRAINT `fk_user_location_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_location_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_location`
--

LOCK TABLES `user_location` WRITE;
/*!40000 ALTER TABLE `user_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_post`
--

DROP TABLE IF EXISTS `user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_post` (
  `user_post_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_description` varchar(1000) DEFAULT NULL,
  `user_from` int(11) DEFAULT NULL,
  `user_to` int(11) DEFAULT NULL,
  `post_date` datetime DEFAULT NULL,
  `pic_name` varchar(500) DEFAULT NULL,
  `post_type` varchar(45) DEFAULT NULL,
  `album_name` varchar(45) DEFAULT NULL,
  `youtube_video_link` varchar(100) DEFAULT NULL,
  `is_other_profile` varchar(45) DEFAULT NULL,
  `privacy_name` varchar(45) DEFAULT 'PUBLIC',
  PRIMARY KEY (`user_post_id`),
  KEY `fk_user_post_1` (`user_from`),
  KEY `fk_user_post_2` (`user_to`),
  KEY `fk_user_post_3_idx` (`privacy_name`),
  CONSTRAINT `fk_user_post_3` FOREIGN KEY (`privacy_name`) REFERENCES `privacydetail` (`privacy_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_post_1` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_post_2` FOREIGN KEY (`user_to`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_post`
--

LOCK TABLES `user_post` WRITE;
/*!40000 ALTER TABLE `user_post` DISABLE KEYS */;
INSERT INTO `user_post` VALUES (155,'What was POirot\'s first case???',52,52,'2015-04-27 16:12:10',NULL,'Kaustav Sen Status Update','timeline','',NULL,'PUBLIC'),(156,'Hi this is really awesome',51,51,'2015-04-27 16:24:01',NULL,'Anish Ratnawat Status Update','timeline','',NULL,'PUBLIC'),(157,'Testing from profile page',51,51,'2015-04-27 16:24:17',NULL,'Anish Ratnawat Status Update','timeline','',NULL,'PUBLIC'),(159,'Ubuntu Wallpaper',52,52,'2015-04-27 16:26:14','78279.jpeg','Kaustav Sen Status Update','timeline','',NULL,'PUBLIC'),(160,'Image testing',51,51,'2015-04-27 16:34:20','688039.jpeg','Anish Ratnawat Status Update','timeline','',NULL,'PUBLIC'),(161,'Happy Birthday...........................',51,55,'2015-04-27 16:36:31',NULL,'Anish Ratnawat posted on Nitin kulkarni wall','timeline','',NULL,'PUBLIC'),(162,'Happy Birthday...........................',51,55,'2015-04-27 16:36:31',NULL,' status Update','timeline','',NULL,'PUBLIC'),(163,'hi test information status/ news feed .. 01 raman',59,59,'2015-04-27 18:30:29',NULL,'Raman Garg Status Update','timeline','',NULL,'PUBLIC'),(164,'posted by raman .. 01',59,52,'2015-04-27 18:50:23','914228.gif','Raman Garg posted on Kaustav Sen wall','timeline','',NULL,'PUBLIC'),(165,'new post 02 from raman ',59,52,'2015-04-27 19:03:19','65865.gif','Raman Garg posted on Kaustav Sen wall','timeline','',NULL,'PUBLIC'),(166,'funny dog pic',59,59,'2015-04-27 19:48:39','790874.gif','Raman Garg Status Update','timeline','',NULL,'PUBLIC'),(167,'Status upload testing',51,51,'2015-04-28 18:56:57',NULL,'Anish Ratnawat Status Update','timeline','',NULL,'PUBLIC'),(168,'Status upload testing',51,51,'2015-04-28 18:56:57',NULL,'Anish Ratnawat Status Update','timeline','',NULL,'PUBLIC'),(169,'Photo Upload Testing',51,51,'2015-04-28 18:58:01','686955.jpeg','Anish Ratnawat Status Update','timeline','',NULL,'PUBLIC'),(173,'',51,51,'2015-04-28 19:12:23','62121.gif','Anish Ratnawat Status Update','timeline','',NULL,'PUBLIC'),(174,'helloooo.........',50,50,'2015-04-29 15:55:43',NULL,'Rajan Padalia Status Update','timeline','',NULL,'PUBLIC'),(175,'Ubuntu Image!',52,51,'2015-04-29 16:05:34','874277.jpeg','Kaustav Sen posted on Anish Ratnawat wall','timeline','',NULL,'PUBLIC'),(176,'Ubuntu Image!',51,52,'2015-04-29 16:05:34','874277.jpeg','Kaustav Sen posted on Anish Ratnawat wall','timeline','',NULL,'PUBLIC'),(177,'Interstellar',52,52,'2015-04-29 16:09:41','639637.jpeg','Kaustav Sen Status Update','timeline','',NULL,'PUBLIC'),(178,'ubuntu wallpapaer',52,52,'2015-04-29 16:18:47','858049.jpeg','Kaustav Sen Status Update','timeline','',NULL,'PUBLIC'),(179,'Posting to anish wall',52,51,'2015-04-29 16:20:08','918298.jpeg','Kaustav Sen posted on Anish Ratnawat wall','timeline','',NULL,'PUBLIC'),(180,'Happy b\'day...',53,50,'2015-04-29 16:26:36',NULL,'Setu Patani posted on Rajan Padalia wall','timeline','',NULL,'PUBLIC'),(181,'Happy Birthday Rajan.........have fun',51,50,'2015-04-29 16:26:44',NULL,'Anish Ratnawat posted on Rajan Padalia wall','timeline','',NULL,'PUBLIC'),(182,'Happy Birthday Rajan....Have a long life!!!!!',52,50,'2015-04-29 16:27:59',NULL,'Kaustav Sen posted on Rajan Padalia wall','timeline','',NULL,'PUBLIC'),(183,'hi..... anishhhhh',50,50,'2015-04-29 16:31:33',NULL,'Rajan Padalia Status Update','timeline','',NULL,'PUBLIC'),(184,'helloo all..!!! im here on facebook..!! :P',61,61,'2015-04-29 16:34:48','652929.jpeg','shaily sanghvi Status Update','timeline','',NULL,'PUBLIC'),(185,'',51,51,'2015-04-29 16:39:24',NULL,'Anish Ratnawat Status Update','timeline','https://www.youtube.com/embed/A45H6PZgwFg',NULL,'PUBLIC'),(186,'lol..!! njoy',61,61,'2015-04-29 16:40:10',NULL,'shaily sanghvi Status Update','timeline','https://www.youtube.com/watch?v=_6ZN_fRaULs',NULL,'PUBLIC'),(187,'lol1',61,61,'2015-04-29 16:41:38',NULL,'shaily sanghvi Status Update','timeline','https://www.youtube.com/embed/_6ZN_fRaULs',NULL,'PUBLIC'),(188,'hello shaily.... :D ',56,61,'2015-04-29 16:47:25',NULL,'Dhruvik Shah posted on shaily sanghvi wall','timeline','',NULL,'PUBLIC'),(189,'happy b\'day...',53,50,'2015-04-29 17:00:57',NULL,'Setu Patani posted on Rajan Padalia wall','timeline','',NULL,'PUBLIC'),(190,'hieee...',54,54,'2015-04-29 17:08:13','948460.jpeg','Nupur Garg Status Update','timeline','',NULL,'FRIENDS'),(192,'HI All',51,51,'2015-04-30 21:52:09',NULL,'Anish Ratnawat Status Update','timeline','',NULL,'PUBLIC'),(193,'Hi private',51,51,'2015-04-30 21:52:39',NULL,'Anish Ratnawat Status Update','timeline','',NULL,'FRIENDS'),(194,'hi pri',51,51,'2015-04-30 21:55:05',NULL,'Anish Ratnawat Status Update','timeline','',NULL,'PRIVATE'),(195,'hi firneds',51,51,'2015-04-30 21:55:13',NULL,'Anish Ratnawat Status Update','timeline','',NULL,'PRIVATE'),(196,'HI All',51,51,'2015-04-30 21:59:27','300484.gif','Anish Ratnawat Status Update','timeline','',NULL,'PRIVATE'),(197,'hi all',51,51,'2015-04-30 22:00:33','548595.jpeg','Anish Ratnawat Status Update','timeline','',NULL,'PRIVATE'),(198,'hi abc',51,51,'2015-05-01 01:56:13','723013.jpeg','Anish Ratnawat Status Update','timeline','',NULL,'PRIVATE');
/*!40000 ALTER TABLE `user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_post_comment`
--

DROP TABLE IF EXISTS `user_post_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_post_comment` (
  `user_post_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`user_post_comment_id`),
  KEY `fk_user_post_comment_1` (`post_id`),
  KEY `fk_user_post_comment_2` (`user_id`),
  CONSTRAINT `fk_user_post_comment_1` FOREIGN KEY (`post_id`) REFERENCES `user_post` (`user_post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_post_comment_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_post_comment`
--

LOCK TABLES `user_post_comment` WRITE;
/*!40000 ALTER TABLE `user_post_comment` DISABLE KEYS */;
INSERT INTO `user_post_comment` VALUES (1,157,53,'2015-04-27 16:25:09','Good for you...'),(2,156,52,'2015-04-27 16:27:19','Too Fast'),(3,161,55,'2015-04-27 16:37:10','thanks much!'),(5,173,51,'2015-04-28 19:12:59','cute'),(6,173,52,'2015-04-28 19:17:13','nice'),(7,174,51,'2015-04-29 15:58:44','testing frm mobile'),(8,160,52,'2015-04-29 15:59:31','Great Image!!!'),(9,179,51,'2015-04-29 16:23:53','nice picture'),(10,182,51,'2015-04-29 16:30:16','and have a good wife....................... :P :P'),(11,183,51,'2015-04-29 16:31:54','hi rajan'),(12,182,53,'2015-04-29 16:35:41','hhhh'),(13,184,61,'2015-04-29 16:35:57','huhh..!!! nobody interested..!! to talk..!! :( :('),(14,184,53,'2015-04-29 16:36:20','aav khiskoli'),(15,184,50,'2015-04-29 16:36:21','ooo please :P :P'),(16,189,50,'2015-04-29 17:01:34','5 *  apis.. joie ?'),(17,189,53,'2015-04-29 17:15:04','lai av');
/*!40000 ALTER TABLE `user_post_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_post_like`
--

DROP TABLE IF EXISTS `user_post_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_post_like` (
  `user_post_like_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`user_post_like_id`),
  KEY `fk_user_post_like_1` (`post_id`),
  KEY `fk_user_post_like_2` (`user_id`),
  CONSTRAINT `fk_user_post_like_1` FOREIGN KEY (`post_id`) REFERENCES `user_post` (`user_post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_post_like_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_post_like`
--

LOCK TABLES `user_post_like` WRITE;
/*!40000 ALTER TABLE `user_post_like` DISABLE KEYS */;
INSERT INTO `user_post_like` VALUES (7,157,53,'2015-04-27 16:24:58'),(8,157,52,'2015-04-27 16:26:27'),(9,157,51,'2015-04-27 16:35:27'),(10,161,55,'2015-04-27 16:37:00'),(11,163,59,'2015-04-27 18:31:00'),(12,164,59,'2015-04-27 18:55:57'),(14,173,51,'2015-04-28 19:12:42'),(15,174,51,'2015-04-29 15:58:17'),(16,173,52,'2015-04-29 15:59:00'),(17,179,53,'2015-04-29 16:21:08'),(18,179,51,'2015-04-29 16:21:14'),(19,178,53,'2015-04-29 16:21:36'),(20,177,53,'2015-04-29 16:21:52'),(21,179,50,'2015-04-29 16:25:01'),(22,181,52,'2015-04-29 16:27:20'),(23,184,51,'2015-04-29 16:36:15'),(24,184,53,'2015-04-29 16:36:25'),(25,184,50,'2015-04-29 16:36:55'),(26,184,52,'2015-04-29 16:38:46'),(27,185,52,'2015-04-29 16:40:55'),(28,187,52,'2015-04-29 16:42:13'),(29,187,51,'2015-04-29 16:42:58'),(30,187,56,'2015-04-29 16:47:55'),(31,187,50,'2015-04-29 16:48:22'),(32,187,53,'2015-04-29 16:48:27'),(33,185,51,'2015-04-29 16:48:33'),(34,166,54,'2015-04-29 17:00:02'),(35,190,53,'2015-04-29 17:14:30'),(37,179,54,'2015-04-29 17:31:27'),(38,190,51,'2015-04-29 17:32:23'),(40,195,51,'2015-04-30 21:55:18'),(41,196,51,'2015-05-01 01:10:18');
/*!40000 ALTER TABLE `user_post_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_relationship`
--

DROP TABLE IF EXISTS `user_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_relationship` (
  `user_relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `relationship_id` int(11) DEFAULT NULL,
  `user_from` int(11) DEFAULT NULL,
  `user_to` int(11) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`user_relationship_id`),
  KEY `fk_user_relationship_1` (`user_from`),
  KEY `fk_user_relationship_2` (`user_to`),
  KEY `fk_user_relationship_3` (`relationship_id`),
  CONSTRAINT `fk_user_relationship_1` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_relationship_2` FOREIGN KEY (`user_to`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_relationship_3` FOREIGN KEY (`relationship_id`) REFERENCES `user_relationship` (`user_relationship_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_relationship`
--

LOCK TABLES `user_relationship` WRITE;
/*!40000 ALTER TABLE `user_relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_education`
--

DROP TABLE IF EXISTS `work_education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_education` (
  `we_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` enum('work','education') DEFAULT NULL,
  `organization` varchar(1000) DEFAULT NULL,
  `position` varchar(1000) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`we_id`),
  KEY `fk_work_education_1` (`user_id`),
  CONSTRAINT `fk_work_education_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_education`
--

LOCK TABLES `work_education` WRITE;
/*!40000 ALTER TABLE `work_education` DISABLE KEYS */;
INSERT INTO `work_education` VALUES (1,55,'work','Amdocs','SME','2013-11-14',NULL),(2,55,'education','IIIT  Bangalore','Mtech','2014-06-11',NULL),(3,61,'education','IIITB','Bangalore',NULL,NULL);
/*!40000 ALTER TABLE `work_education` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-01  2:04:40
