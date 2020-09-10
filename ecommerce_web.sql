-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ecommerce_web
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `academic`
--

DROP TABLE IF EXISTS `academic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic` (
  `id` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'pending',
  `customerId` int(11) DEFAULT NULL,
  `sellRequested` int(11) DEFAULT NULL,
  KEY `productId` (`productId`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `academic_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `academic_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic`
--

LOCK TABLES `academic` WRITE;
/*!40000 ALTER TABLE `academic` DISABLE KEYS */;
INSERT INTO `academic` VALUES (NULL,23,'Pen',200,'undefined-1575647553038.jpg','Frst grade pen',NULL,1,NULL);
/*!40000 ALTER TABLE `academic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accomodation`
--

DROP TABLE IF EXISTS `accomodation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accomodation` (
  `id` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT 'pending',
  KEY `productId` (`productId`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `accomodation_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accomodation_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accomodation`
--

LOCK TABLES `accomodation` WRITE;
/*!40000 ALTER TABLE `accomodation` DISABLE KEYS */;
/*!40000 ALTER TABLE `accomodation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admincredentials`
--

DROP TABLE IF EXISTS `admincredentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admincredentials` (
  `id` int(11) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admincredentials`
--

LOCK TABLES `admincredentials` WRITE;
/*!40000 ALTER TABLE `admincredentials` DISABLE KEYS */;
INSERT INTO `admincredentials` VALUES (3000,'hala');
/*!40000 ALTER TABLE `admincredentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apparel`
--

DROP TABLE IF EXISTS `apparel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apparel` (
  `id` int(11) DEFAULT NULL,
  `productId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT 'pending',
  PRIMARY KEY (`productId`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `apparel_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `apparel_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apparel`
--

LOCK TABLES `apparel` WRITE;
/*!40000 ALTER TABLE `apparel` DISABLE KEYS */;
/*!40000 ALTER TABLE `apparel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `athletics`
--

DROP TABLE IF EXISTS `athletics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `athletics` (
  `id` int(11) DEFAULT NULL,
  `productId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT 'pending',
  PRIMARY KEY (`productId`),
  KEY `customerId` (`customerId`),
  KEY `ststus_key_idx` (`status`),
  CONSTRAINT `athletics_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `athletics`
--

LOCK TABLES `athletics` WRITE;
/*!40000 ALTER TABLE `athletics` DISABLE KEYS */;
INSERT INTO `athletics` VALUES (NULL,27,'Mountain Bike',200,'undefined-1575656275279.jpg','Awesome mw!!!!',1,'pending');
/*!40000 ALTER TABLE `athletics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Rashik','rashikhassan@gmail.com','Rashik'),(2,'yossri','essamhatem66@yahoo.com','Yossri'),(3,'Riyadh','riyadh.hossain114@gmail.com','Riyadh'),(11,'2131','jdw@gmail.com','john'),(12,'2131','hdiwq','swq\';'),(23,'2131','kdsw@d','Kepler'),(34,'Mama','dkpoewkd','Mama');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `other`
--

DROP TABLE IF EXISTS `other`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other` (
  `id` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT 'pending',
  KEY `customerId` (`customerId`),
  KEY `other_ibfk_1` (`productId`),
  CONSTRAINT `other_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `other_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other`
--

LOCK TABLES `other` WRITE;
/*!40000 ALTER TABLE `other` DISABLE KEYS */;
INSERT INTO `other` VALUES (19,NULL,'PS4',220,'undefined-1575519261665.jpg','Wanna play game?? There you go.',2,'pending'),(NULL,26,'ksmd;lwqm',111,'undefined-1575656005657.jpg','dlkmewlkd',1,'pending'),(NULL,28,'Mountain Bike Blue',109,'undefined-1575658376739.jpg','new bike for sale',23,'pending');
/*!40000 ALTER TABLE `other` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `imageURL` varchar(1000) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `sellRequested` int(11) DEFAULT '0',
  `status` varchar(45) DEFAULT 'pending',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (19,'PS4',220,'undefined-1575519261665.jpg','Wanna play game?? There you go.',2,0,'approved'),(23,'Pen',200,'undefined-1575647553038.jpg','Frst grade pen',1,0,'approved'),(24,'RASHIK',124,'undefined-1575655479547.jpg','THIS IS A PLAYSTATSION ',1,0,'approved'),(25,'Yossri',1000,'undefined-1575655874069.jpg','Do nothing',1,0,'approved'),(26,'ksmd;lwqm',111,'undefined-1575656005657.jpg','dlkmewlkd',1,0,'approved'),(27,'Mountain Bike',200,'undefined-1575656275279.jpg','Awesome mw!!!!',1,0,'approved'),(28,'Mountain Bike Blue',109,'undefined-1575658376739.jpg','new bike for sale',23,0,'approved');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-06 23:39:52
