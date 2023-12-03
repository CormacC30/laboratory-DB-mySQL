CREATE DATABASE  IF NOT EXISTS `laboratory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laboratory`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: laboratory
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `analysis`
--

DROP TABLE IF EXISTS `analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysis` (
  `labNoteBookID` char(10) NOT NULL,
  `analyticalMethod` varchar(30) DEFAULT NULL,
  `specification` varchar(40) DEFAULT NULL,
  `employeeID` varchar(8) NOT NULL,
  PRIMARY KEY (`labNoteBookID`),
  KEY `employeeID` (`employeeID`),
  KEY `analysisType` (`analyticalMethod`),
  CONSTRAINT `analysis_ibfk_1` FOREIGN KEY (`employeeID`) REFERENCES `scientist` (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis`
--

LOCK TABLES `analysis` WRITE;
/*!40000 ALTER TABLE `analysis` DISABLE KEYS */;
INSERT INTO `analysis` VALUES ('AN001','Impurities','NGT 0.1%','CC182270'),('AN002','Water Content','NGT 5%','AB123456'),('AN003','Heavy Metals Content','NGT 10 ppm','PQ778899'),('AN004','Identity','Meets Standard Peaks','NO445566'),('AN005','Assay','99-101%','FG345678'),('AN006','Impurity Profile','<0.5%','DE789012'),('AN007','Crystal Structure','Identical to Standard','NO445566'),('AN008','Structural Conformation','Matches Reference Spectrum','CC182270'),('AN009','Acid Content','0.5-1.5%','CC182270'),('AN010','Residual Solvents','<0.1%','FG345678');
/*!40000 ALTER TABLE `analysis` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_analysis_update` BEFORE UPDATE ON `analysis` FOR EACH ROW BEGIN
	INSERT INTO auditTrail
    SET action = 'update',
		labNoteBookID = OLD.labNoteBookID,
        analyticalMethod = OLD.analyticalMethod,
        changeDate = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `audittrail`
--

DROP TABLE IF EXISTS `audittrail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audittrail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `labNotebookID` char(10) DEFAULT NULL,
  `analyticalMethod` varchar(30) DEFAULT NULL,
  `changeDate` datetime DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audittrail`
--

LOCK TABLES `audittrail` WRITE;
/*!40000 ALTER TABLE `audittrail` DISABLE KEYS */;
/*!40000 ALTER TABLE `audittrail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batch` (
  `batchNumber` varchar(20) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `dateOfManufacture` date DEFAULT NULL,
  `clientID` varchar(15) NOT NULL,
  PRIMARY KEY (`batchNumber`),
  KEY `clientID` (`clientID`),
  KEY `product` (`productName`),
  CONSTRAINT `batch_ibfk_1` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES ('B01011','Thermo Fisher RNA Test Kit','2023-10-08','TF010'),('B01012','In Vitro Diagnostic Kit','2023-10-12','TF010'),('B12346','Viagra','2023-10-18','PFI001'),('B12347','Enbrel','2023-10-21','PFI001'),('B12378','Ascorbic Acid','2023-12-15','AGRI002'),('B20203','MultiVitamins','2023-11-12','AGRI002'),('B20204','Nature\'s Harvest Minerals','2023-11-15','AGRI002'),('B23456','Thionyl Chloride','2023-12-20','GSK502'),('B34567','3-Azido-1-propanamine','2023-12-01','PFI002'),('B45455','Amoxicillin','2023-11-05','TAK454'),('B45456','Haemorrhoid Cream','2023-11-08','TAK454'),('B50203','Lemonivir','2023-09-18','GSK502'),('B50204','Penicillin','2023-09-21','GSK502'),('B56789','Lithium aluminium hydride','2023-12-10','TF010'),('B67891','Temivir Antiviral','2023-09-30','PFI002'),('B67892','Paracetamol','2023-10-02','PFI002'),('B78901','N-Bromosuccinimide','2023-11-25','PFI001'),('B89012','p-Toluenesulfonyl chloride','2023-12-05','TAK454');
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `clientID` varchar(15) NOT NULL,
  `companyName` varchar(30) NOT NULL,
  `street` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `postCode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`clientID`),
  KEY `clientind` (`companyName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES ('ABB001','AbbVie','Carrigtohill','Cork','Ireland','T45 OL8I'),('AGRI002','Nature\'s Harvest Farms','234 Marino Road','Bantry','Ireland','P78 I99R'),('AMG050','AMGEN','Dun Laoighre','Dublin','Ireland','D14 UP23'),('GSK502','GlaxoSmithKline','10 Oak Avenue','Stevenage','United Kingdom','OKP 9O1'),('PFI001','Pfizer','Grange Castle','Dublin 14','Ireland','D14 OP13'),('PFI002','PFizer','Ringaskiddy','Cork','Ireland','T15 LLCJ'),('TAK454','Takeda','101 Coast Road','Bray','Ireland','G12 PL14'),('TF010','Thermo Fisher','Ringaskiddy','Cork','Ireland','T11 P0LI');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `restrictClientDeletion` BEFORE DELETE ON `client` FOR EACH ROW BEGIN
    DECLARE batchCount INT;

    SELECT COUNT(*)
    INTO batchCount
    FROM Batch
    WHERE clientID = OLD.clientID;

    IF batchCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete client with associated batches';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clientphones`
--

DROP TABLE IF EXISTS `clientphones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientphones` (
  `contactNumber` varchar(20) NOT NULL,
  `clientID` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`contactNumber`),
  KEY `clientID` (`clientID`),
  CONSTRAINT `clientphones_ibfk_1` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientphones`
--

LOCK TABLES `clientphones` WRITE;
/*!40000 ALTER TABLE `clientphones` DISABLE KEYS */;
INSERT INTO `clientphones` VALUES ('0866543210','AGRI002'),('7747711119','GSK502'),('7747778889','GSK502'),('013366522','PFI001'),('0869876543','PFI001'),('0871234567','PFI001'),('012551122','PFI002'),('0835551122','PFI002'),('0898887766','TAK454'),('0854433221','TF010');
/*!40000 ALTER TABLE `clientphones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumes`
--

DROP TABLE IF EXISTS `consumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumes` (
  `labNoteBookID` char(10) NOT NULL,
  `lotNumber` varchar(20) NOT NULL,
  `quantityUsed` int unsigned DEFAULT '0',
  PRIMARY KEY (`labNoteBookID`,`lotNumber`),
  KEY `lotNumber` (`lotNumber`),
  CONSTRAINT `consumes_ibfk_1` FOREIGN KEY (`lotNumber`) REFERENCES `material` (`lotNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `consumes_ibfk_2` FOREIGN KEY (`labNoteBookID`) REFERENCES `analysis` (`labNoteBookID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumes`
--

LOCK TABLES `consumes` WRITE;
/*!40000 ALTER TABLE `consumes` DISABLE KEYS */;
INSERT INTO `consumes` VALUES ('AN001','ABC123',10),('AN001','XYZ456',5),('AN002','456JKL',3),('AN002','789GHI',8),('AN003','123DEF',15),('AN003','789MNO',12),('AN004','XYZABC',6),('AN005','789PQR',7),('AN006','123GHI',4),('AN006','ABCXYZ',9),('AN007','789JKL',11),('AN008','456MNO',14),('AN009','789PQR',10),('AN010','ABCXYZ',5),('AN010','XYZABC',3);
/*!40000 ALTER TABLE `consumes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updateStock` BEFORE INSERT ON `consumes` FOR EACH ROW BEGIN
   
    UPDATE Material
    SET quantityInStock = quantityInStock - NEW.quantityUsed
    WHERE lotNumber = NEW.lotNumber;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `contactstock`
--

DROP TABLE IF EXISTS `contactstock`;
/*!50001 DROP VIEW IF EXISTS `contactstock`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `contactstock` AS SELECT 
 1 AS `supplierName`,
 1 AS `supplierPhones`,
 1 AS `email`,
 1 AS `materialName`,
 1 AS `partNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `contactsupplier`
--

DROP TABLE IF EXISTS `contactsupplier`;
/*!50001 DROP VIEW IF EXISTS `contactsupplier`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `contactsupplier` AS SELECT 
 1 AS `supplierName`,
 1 AS `supplierPhones`,
 1 AS `email`,
 1 AS `materialName`,
 1 AS `partNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `expiredmaterial`
--

DROP TABLE IF EXISTS `expiredmaterial`;
/*!50001 DROP VIEW IF EXISTS `expiredmaterial`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `expiredmaterial` AS SELECT 
 1 AS `lotNumber`,
 1 AS `materialName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `finishedproduct`
--

DROP TABLE IF EXISTS `finishedproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `finishedproduct` (
  `batchNumber` varchar(20) NOT NULL,
  `presentation` varchar(20) DEFAULT NULL,
  `clientID` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`batchNumber`),
  KEY `clientID` (`clientID`),
  CONSTRAINT `finishedproduct_ibfk_1` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finishedproduct`
--

LOCK TABLES `finishedproduct` WRITE;
/*!40000 ALTER TABLE `finishedproduct` DISABLE KEYS */;
INSERT INTO `finishedproduct` VALUES ('B01011','Kit','TF010'),('B01012','Kit','TF010'),('B12346','Tablet','PFI001'),('B12347','Injection','PFI001'),('B20203','Tablet','AGRI002'),('B20204','Tablet','AGRI002'),('B45455','Capsule','TAK454'),('B45456','Cream','TAK454'),('B50203','Cream','GSK502'),('B50204','Injection','GSK502'),('B67891','Capsule','PFI002'),('B67892','Tablet','PFI002');
/*!40000 ALTER TABLE `finishedproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `labinstanalysis`
--

DROP TABLE IF EXISTS `labinstanalysis`;
/*!50001 DROP VIEW IF EXISTS `labinstanalysis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `labinstanalysis` AS SELECT 
 1 AS `equipmentID`,
 1 AS `instrumentName`,
 1 AS `Number of current tests`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `labinstruments`
--

DROP TABLE IF EXISTS `labinstruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labinstruments` (
  `equipmentID` varchar(10) NOT NULL,
  `instrumentName` varchar(40) NOT NULL,
  `nextCalDate` date NOT NULL,
  PRIMARY KEY (`equipmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labinstruments`
--

LOCK TABLES `labinstruments` WRITE;
/*!40000 ALTER TABLE `labinstruments` DISABLE KEYS */;
INSERT INTO `labinstruments` VALUES ('BAL001','Analytical Balance','2024-04-05'),('BAL002','Analytical Balance','2024-04-05'),('FTIR003','FTIR','2023-12-05'),('GC-MS002','Gas Chromatograph','2023-11-15'),('GC007','Gas Chromatograph','2023-12-15'),('HPLC006','HPLC','2023-11-25'),('HPLC012','HPLC','2023-11-18'),('ICP-OES009','ICP-OES','2023-12-20'),('LC-MS001','LC-Mass Spectrometer','2023-12-01'),('NMR005','NMR','2023-12-10'),('PH001','pH Meter','2023-11-26'),('TI008','Auto Titrator','2023-11-30'),('UV004','Ultraviolet Spectrophotometer','2023-11-20'),('UV011','Ultraviolet Spectrophotometer','2023-12-02'),('XRD010','X-ray Diffractometer','2023-11-10');
/*!40000 ALTER TABLE `labinstruments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updateCalDate` BEFORE INSERT ON `labinstruments` FOR EACH ROW BEGIN
    IF DATEDIFF(CURDATE(), NEW.nextCalDate) < 180 THEN 
        SET NEW.nextCalDate = DATE_ADD(CURDATE(), INTERVAL 6 MONTH);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `lotNumber` varchar(20) NOT NULL,
  `partNumber` varchar(20) NOT NULL,
  `materialName` varchar(50) DEFAULT NULL,
  `quantityInStock` int unsigned DEFAULT '0',
  `storageCondition` varchar(20) DEFAULT NULL,
  `expiryDate` date NOT NULL,
  `hazardClassification` varchar(20) DEFAULT NULL,
  `purity` float DEFAULT NULL,
  `supplierID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`lotNumber`),
  KEY `supplierID` (`supplierID`),
  KEY `materialind` (`materialName`),
  CONSTRAINT `material_ibfk_1` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES ('123DEF','RS78901','Phenazone Impurity A',30,'Cold Storage','2025-12-05','Corrosive',99.9,'TCI002'),('123GHI','LP67890','Acetone',60,'Room Temperature','2023-11-30','Non-Hazardous',99.2,'TCI002'),('456JKL','LP34567','Water',40,'Room Temperature','2023-12-10','Non-Hazardous',98,'LGC004'),('456MNO','AN12345','Acetonitrile',80,'Cool and Dry','2027-09-01','Flammable',99.5,'MERCK001'),('789GHI','RP23456','Ethanol',75,'Cool and Dry','2023-11-20','Irritant',97.5,'FISHER003'),('789JKL','RS78901','Paracetamol Impurity Test Mix',35,'Cold Storage','2024-12-20','Corrosive',99.8,'FISHER003'),('789MNO','RS45678','Paracetamol',25,'Cold Storage','2026-11-25','Corrosive',99.5,'MERCK001'),('789PQR','HA67890','Hydrochloric Acid',25,'Ventilated Area','2027-06-15','Corrosive',36,'SIGMA001'),('ABC123','RP12345','Acetone',100,'Cool and Dry','2025-12-01','Non-Hazardous',98.5,'MERCK001'),('ABCXYZ','SA12345','Sulfuric Acid',40,'Cool and Dry','2027-08-10','Corrosive',98,'TCI002'),('AMMO1','AH56789','Ammonium Hydroxide',30,'Cool and Dry','2028-12-15','Corrosive',25,'SIGMA001'),('ARSEN1','GA23456','Gallium Arsenide',20,'Cold Storage','2029-07-20','Toxic',NULL,'LGC004'),('GALL42','HE56789','Helium',60,'Compressed Gas','2029-11-30','Non-Flammable',NULL,'FISHER003'),('NITR06','NN558','Nitric Acid',5,'Ventilated Area','2028-12-15','Corrosive',75.4,'MERCK001'),('SODIUM1','CH34567','Sodium Chloride',50,'Room Temperature','2028-10-05','Non-Hazardous',99.9,'MERCK001'),('XYZ456','LP67890','Methanol',50,'Room Temperature','2022-11-15','Flammable',99.8,'SIGMA001'),('XYZABC','RP56789','Methanol',90,'Cool and Dry','2025-12-15','Flammable',98.7,'SIGMA001');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `productintesting`
--

DROP TABLE IF EXISTS `productintesting`;
/*!50001 DROP VIEW IF EXISTS `productintesting`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `productintesting` AS SELECT 
 1 AS `productName`,
 1 AS `batchNumber`,
 1 AS `sampleID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `rawmaterial`
--

DROP TABLE IF EXISTS `rawmaterial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rawmaterial` (
  `batchNumber` varchar(20) NOT NULL,
  `processID` varchar(10) DEFAULT NULL,
  `clientID` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`batchNumber`),
  KEY `clientID` (`clientID`),
  CONSTRAINT `rawmaterial_ibfk_1` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rawmaterial`
--

LOCK TABLES `rawmaterial` WRITE;
/*!40000 ALTER TABLE `rawmaterial` DISABLE KEYS */;
INSERT INTO `rawmaterial` VALUES ('B12378','PR345','AGRI002'),('B23456','PR678','GSK502'),('B34567','PR456','PFI002'),('B56789','PR012','TF010'),('B78901','PR123','PFI001'),('B89012','PR789','TAK454');
/*!40000 ALTER TABLE `rawmaterial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent`
--

DROP TABLE IF EXISTS `reagent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reagent` (
  `lotNumber` varchar(20) NOT NULL,
  `form` varchar(20) DEFAULT NULL,
  `supplierID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`lotNumber`),
  KEY `supplierID` (`supplierID`),
  CONSTRAINT `reagent_ibfk_1` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent`
--

LOCK TABLES `reagent` WRITE;
/*!40000 ALTER TABLE `reagent` DISABLE KEYS */;
INSERT INTO `reagent` VALUES ('789GHI','Liquid','FISHER003'),('789PQR','Liquid','SIGMA001'),('ABC123','Liquid','MERCK001'),('ABCXYZ','Liquid','TCI002'),('GALL42','Gas','FISHER003'),('NITR06','Liquid','MERCK001'),('SODIUM1','Solid','MERCK001'),('XYZABC','Liquid','SIGMA001');
/*!40000 ALTER TABLE `reagent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referencestandard`
--

DROP TABLE IF EXISTS `referencestandard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referencestandard` (
  `lotNumber` varchar(20) NOT NULL,
  `certOfAnalysis` varchar(20) DEFAULT NULL,
  `supplierID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`lotNumber`),
  KEY `supplierID` (`supplierID`),
  CONSTRAINT `referencestandard_ibfk_1` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referencestandard`
--

LOCK TABLES `referencestandard` WRITE;
/*!40000 ALTER TABLE `referencestandard` DISABLE KEYS */;
INSERT INTO `referencestandard` VALUES ('123DEF','COA12345','TCI002'),('789JKL','COA11256','FISHER003'),('789MNO','COA65654','MERCK001'),('ARSEN1','COA75511','LGC004');
/*!40000 ALTER TABLE `referencestandard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `replacematerial`
--

DROP TABLE IF EXISTS `replacematerial`;
/*!50001 DROP VIEW IF EXISTS `replacematerial`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `replacematerial` AS SELECT 
 1 AS `lotNumber`,
 1 AS `materialName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample` (
  `sampleID` varchar(15) NOT NULL,
  `storageCondition` varchar(30) DEFAULT NULL,
  `expiryDate` date DEFAULT NULL,
  `progressStatus` varchar(20) DEFAULT 'Awaiting Testing',
  `batchNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`sampleID`),
  KEY `batchNumber` (`batchNumber`),
  CONSTRAINT `sample_ibfk_1` FOREIGN KEY (`batchNumber`) REFERENCES `batch` (`batchNumber`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample`
--

LOCK TABLES `sample` WRITE;
/*!40000 ALTER TABLE `sample` DISABLE KEYS */;
INSERT INTO `sample` VALUES ('SMP001','2-8°C','2024-01-31','Completed','B12346'),('SMP002','Ambient','2023-12-20','Awaiting Testing','B67891'),('SMP003','Room Temperature','2023-12-15','Awaiting Testing','B45455'),('SMP004','2-8°C','2024-02-28','In Progress','B01011'),('SMP005','Ambient','2023-12-25','Completed','B20203'),('SMP006','Room Temperature','2023-12-30','Awaiting Testing','B50203'),('SMP007','2-8°C','2024-01-15','In Progress','B12347'),('SMP008','Ambient','2023-12-22','Completed','B67892'),('SMP009','Room Temperature','2023-12-18','Awaiting Testing','B45456'),('SMP010','2-8°C','2024-03-05','Completed','B01012'),('SMP011','Ambient','2023-12-28','Awaiting Testing','B20204'),('SMP012','Room Temperature','2024-01-10','Awaiting Testing','B50204'),('SMP013','2-8°C','2024-01-25','In Progress','B78901'),('SMP014','Ambient','2024-02-01','Completed','B34567'),('SMP015','Room Temperature','2024-02-05','Awaiting Testing','B89012'),('SMP016','2-8°C','2024-02-10','In Progress','B56789'),('SMP017','Ambient','2024-02-15','Awaiting Testing','B12378'),('SMP018','Room Temperature','2024-02-20','Awaiting Testing','B23456');
/*!40000 ALTER TABLE `sample` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updateCompleteDate` AFTER UPDATE ON `sample` FOR EACH ROW BEGIN
	IF NEW.progressStatus = 'Completed' THEN
		UPDATE Tests
		SET dateCompleted = CURDATE()
		WHERE sampleID = OLD.SampleID;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `scientist`
--

DROP TABLE IF EXISTS `scientist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scientist` (
  `employeeID` varchar(8) NOT NULL,
  `fName` varchar(40) NOT NULL,
  `lName` varchar(40) NOT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `eircode` char(8) DEFAULT NULL,
  `phoneNumber` varchar(15) DEFAULT NULL,
  `salary` mediumint unsigned DEFAULT NULL,
  `supervisor` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`employeeID`),
  KEY `supervisor` (`supervisor`),
  CONSTRAINT `scientist_ibfk_1` FOREIGN KEY (`supervisor`) REFERENCES `scientist` (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scientist`
--

LOCK TABLES `scientist` WRITE;
/*!40000 ALTER TABLE `scientist` DISABLE KEYS */;
INSERT INTO `scientist` VALUES ('AB123456','Aoife','Murphy','1990-05-22','45 Birch Street','Cork','Cork','T12 AB34','0896665214',50000,'RS112233'),('CC182270','Conor','Fogarty','1992-11-11','Loftus Square','Rathfarnham','Dublin 16','D16 FE82','0879385399',45000,'RS112233'),('DE789012','Liam','Doherty','1988-12-10','78 Oak Road','Galway','Galway','H91 CD56','0215578585',55000,'RS112233'),('FG345678','Siobhan','Kavanagh','1992-03-18','34 Elm Terrace','Limerick','Limerick','V94 EF89','0874445852',60000,'RS112233'),('HI901234','Ciaran','Fitzpatrick','1986-09-03','56 Pine Street','Waterford','Waterford','X91 JK45','0563259788',65000,'RS112233'),('JK567890','Niamh','O\'Sullivan','1994-11-20','89 Green Lane','Belfast','Antrim','BT1 2XY','0862254731',70000,'RS112233'),('LM112233','Eoin','Walsh','1989-02-15','23 Meadow Drive','Derry','Derry','BT48 6AB','0212258447',75000,'RS112233'),('NO445566','Fiona','Doyle','1993-06-01','67 Main Street','Kilkenny','Kilkenny','R95 XYZ1','0861136452',80000,'RS112233'),('PQ778899','Padraig','Ryan','1987-08-28','101 Hillside Avenue','Sligo','Sligo','F91 ABC2','0853369655',85000,'RS112233'),('RS112233','Aisling','Gallagher','1991-04-12','43 Crescent Road','Ennis','Clare','V95 DEF3','0446632552',90000,NULL);
/*!40000 ALTER TABLE `scientist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solvent`
--

DROP TABLE IF EXISTS `solvent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solvent` (
  `lotNumber` varchar(20) NOT NULL,
  `grade` varchar(20) DEFAULT NULL,
  `supplierID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`lotNumber`),
  KEY `supplierID` (`supplierID`),
  CONSTRAINT `solvent_ibfk_1` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solvent`
--

LOCK TABLES `solvent` WRITE;
/*!40000 ALTER TABLE `solvent` DISABLE KEYS */;
INSERT INTO `solvent` VALUES ('123GHI','GC Grade','TCI002'),('456JKL','HPLC Grade','LGC004'),('456MNO','HPLC Grade','MERCK001'),('XYZ456','HPLC Grade','SIGMA001');
/*!40000 ALTER TABLE `solvent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplierID` varchar(20) NOT NULL,
  `supplierName` varchar(40) NOT NULL,
  `street` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `postCode` varchar(10) DEFAULT NULL,
  `supplierPhones` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`supplierID`),
  KEY `supplName` (`supplierName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES ('FISHER003','Fisher Scientific','Lab Lane 101','London','United Kingdom','SW1A 1AA','+44 7890 123456','holly@fishersci.com'),('LGC004','LGC','Rue Du Lab 21','Paris','France','75001','+33 12-345-6789','xavier@lgc.com'),('MERCK001','Merck','Hauptstraße 123','Heidelberg','Germany','69115','+49 123 4567890','mike@merck.com'),('SIGMA001','Sigma-Aldrich','Science Avenue 456','Cambridge','USA','02138','+1 987-654-3210','paul@sigma.com'),('TCI002','TCI','Experiment Road 789','Tokyo','Japan','100-0004','+81 456-789-0123','kate@tci.com');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tests` (
  `labNoteBookID` char(10) NOT NULL,
  `sampleID` varchar(15) NOT NULL,
  `resultID` varchar(15) DEFAULT NULL,
  `dateCompleted` date DEFAULT NULL,
  PRIMARY KEY (`labNoteBookID`,`sampleID`),
  KEY `sampleID` (`sampleID`),
  CONSTRAINT `tests_ibfk_1` FOREIGN KEY (`labNoteBookID`) REFERENCES `analysis` (`labNoteBookID`) ON UPDATE CASCADE,
  CONSTRAINT `tests_ibfk_2` FOREIGN KEY (`sampleID`) REFERENCES `sample` (`sampleID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES ('AN001','SMP001','R001','2022-06-15'),('AN001','SMP011','R011',NULL),('AN002','SMP002','R002',NULL),('AN002','SMP012','R012',NULL),('AN003','SMP003','R003',NULL),('AN003','SMP013','R013',NULL),('AN004','SMP004','R004',NULL),('AN004','SMP014','R014','2023-08-05'),('AN005','SMP005','R005','2022-11-28'),('AN005','SMP015','R015',NULL),('AN006','SMP006','R006',NULL),('AN006','SMP016','R016',NULL),('AN007','SMP007','R007',NULL),('AN007','SMP017','R017',NULL),('AN008','SMP008','R008','2023-02-28'),('AN008','SMP018','R018',NULL),('AN009','SMP009','R009',NULL),('AN010','SMP010','R010','2023-04-10');
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `urgentcal`
--

DROP TABLE IF EXISTS `urgentcal`;
/*!50001 DROP VIEW IF EXISTS `urgentcal`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `urgentcal` AS SELECT 
 1 AS `instrumentName`,
 1 AS `equipmentID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `uses`
--

DROP TABLE IF EXISTS `uses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uses` (
  `equipmentID` varchar(10) NOT NULL,
  `labNoteBookID` char(10) NOT NULL,
  `measurementTime` datetime DEFAULT NULL,
  PRIMARY KEY (`equipmentID`,`labNoteBookID`),
  KEY `labNoteBookID` (`labNoteBookID`),
  CONSTRAINT `uses_ibfk_1` FOREIGN KEY (`equipmentID`) REFERENCES `labinstruments` (`equipmentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uses_ibfk_2` FOREIGN KEY (`labNoteBookID`) REFERENCES `analysis` (`labNoteBookID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uses`
--

LOCK TABLES `uses` WRITE;
/*!40000 ALTER TABLE `uses` DISABLE KEYS */;
INSERT INTO `uses` VALUES ('BAL001','AN001','2023-11-01 08:35:00'),('BAL001','AN004','2023-11-04 13:35:00'),('BAL001','AN007','2023-11-07 09:50:00'),('BAL001','AN010','2023-11-10 15:50:00'),('BAL002','AN002','2023-11-02 09:50:00'),('BAL002','AN005','2023-11-05 15:50:00'),('BAL002','AN008','2023-11-08 11:20:00'),('FTIR003','AN003','2023-11-03 11:15:00'),('GC-MS002','AN002','2023-11-02 09:45:00'),('GC007','AN007','2023-11-07 09:45:00'),('HPLC006','AN006','2023-11-06 08:30:00'),('ICP-OES009','AN009','2023-11-09 13:30:00'),('LC-MS001','AN001','2023-11-01 08:30:00'),('NMR005','AN005','2023-11-05 15:45:00'),('PH001','AN003','2023-11-03 11:20:00'),('PH001','AN006','2023-11-06 08:35:00'),('PH001','AN009','2023-11-09 13:35:00'),('TI008','AN008','2023-11-08 11:15:00'),('UV004','AN004','2023-11-04 13:30:00'),('XRD010','AN010','2023-11-10 15:45:00');
/*!40000 ALTER TABLE `uses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'laboratory'
--

--
-- Dumping routines for database 'laboratory'
--

--
-- Final view structure for view `contactstock`
--

/*!50001 DROP VIEW IF EXISTS `contactstock`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `contactstock` AS select `supplier`.`supplierName` AS `supplierName`,`supplier`.`supplierPhones` AS `supplierPhones`,`supplier`.`email` AS `email`,`material`.`materialName` AS `materialName`,`material`.`partNumber` AS `partNumber` from (`supplier` join `material` on((`supplier`.`supplierID` = `material`.`supplierID`))) where (`material`.`quantityInStock` <= 5) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `contactsupplier`
--

/*!50001 DROP VIEW IF EXISTS `contactsupplier`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `contactsupplier` AS select `supplier`.`supplierName` AS `supplierName`,`supplier`.`supplierPhones` AS `supplierPhones`,`supplier`.`email` AS `email`,`material`.`materialName` AS `materialName`,`material`.`partNumber` AS `partNumber` from (`supplier` join `material` on((`supplier`.`supplierID` = `material`.`supplierID`))) where ((to_days(`material`.`expiryDate`) - to_days(curdate())) < 14) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `expiredmaterial`
--

/*!50001 DROP VIEW IF EXISTS `expiredmaterial`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `expiredmaterial` AS select `material`.`lotNumber` AS `lotNumber`,`material`.`materialName` AS `materialName` from `material` where ((to_days(`material`.`expiryDate`) - to_days(curdate())) < 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `labinstanalysis`
--

/*!50001 DROP VIEW IF EXISTS `labinstanalysis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `labinstanalysis` AS select `labinstruments`.`equipmentID` AS `equipmentID`,`labinstruments`.`instrumentName` AS `instrumentName`,count(`labinstruments`.`equipmentID`) AS `Number of current tests` from ((((`labinstruments` join `uses` on((`labinstruments`.`equipmentID` = `uses`.`equipmentID`))) join `analysis` on((`uses`.`labNoteBookID` = `analysis`.`labNoteBookID`))) join `tests` on((`uses`.`labNoteBookID` = `tests`.`labNoteBookID`))) join `sample` on((`tests`.`sampleID` = `sample`.`sampleID`))) where (`sample`.`progressStatus` like 'In Progress') group by `labinstruments`.`equipmentID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `productintesting`
--

/*!50001 DROP VIEW IF EXISTS `productintesting`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `productintesting` AS select `batch`.`productName` AS `productName`,`batch`.`batchNumber` AS `batchNumber`,`sample`.`sampleID` AS `sampleID` from (`batch` join `sample` on((`batch`.`batchNumber` = `sample`.`batchNumber`))) where (`sample`.`progressStatus` like 'In Progress') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `replacematerial`
--

/*!50001 DROP VIEW IF EXISTS `replacematerial`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `replacematerial` AS select `material`.`lotNumber` AS `lotNumber`,`material`.`materialName` AS `materialName` from `material` where ((to_days(`material`.`expiryDate`) - to_days(curdate())) < 14) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `urgentcal`
--

/*!50001 DROP VIEW IF EXISTS `urgentcal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `urgentcal` AS select `labinstruments`.`instrumentName` AS `instrumentName`,`labinstruments`.`equipmentID` AS `equipmentID` from `labinstruments` where ((to_days(`labinstruments`.`nextCalDate`) - to_days(curdate())) < 30) */;
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

-- Dump completed on 2023-12-03 14:17:03
