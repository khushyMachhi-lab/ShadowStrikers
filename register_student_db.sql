-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: register_student_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `admissions`
--

DROP TABLE IF EXISTS `admissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admission_date` date DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `user_id` int NOT NULL,
  `total_fees` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6gtpkwa15xjdtslfqhpdvt93n` (`user_id`),
  CONSTRAINT `FKeqfn522qng88m95ardy20jc9a` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admissions`
--

LOCK TABLES `admissions` WRITE;
/*!40000 ALTER TABLE `admissions` DISABLE KEYS */;
INSERT INTO `admissions` VALUES (1,'2026-03-25','Self Defense','2026-06-25','2026-03-25','Pending','7227915954','Active',67,1,3000),(2,'2026-03-25','Women\'s Self-Defense','2026-05-25','2026-03-25','Paid','9723160756','Active',75,7,3000);
/*!40000 ALTER TABLE `admissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `end_time` time(6) DEFAULT NULL,
  `start_time` time(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `batch_id` bigint DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKhmh4v9lugedps4ugwdbtb8a87` (`user_id`,`date`),
  KEY `FKkn2wjq4ji44iqjf7jqtq3dv8y` (`batch_id`),
  CONSTRAINT `FKjcaqd29v2qy723owsdah2t8vx` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKkn2wjq4ji44iqjf7jqtq3dv8y` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (1,'2026-03-27','17:40:06.670000','17:10:54.649000','Present',3,1),(2,'2026-03-27','18:04:26.515000','18:02:26.619000','Present',4,7),(3,'2026-03-30',NULL,NULL,'Absent',4,7);
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batches`
--

DROP TABLE IF EXISTS `batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batches` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `batch_name` varchar(255) DEFAULT NULL,
  `batch_type` varchar(255) DEFAULT NULL,
  `end_time` varchar(255) DEFAULT NULL,
  `instructor` varchar(255) DEFAULT NULL,
  `is_live` bit(1) DEFAULT NULL,
  `meet_link` varchar(255) DEFAULT NULL,
  `start_time` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `total_capacity` int NOT NULL,
  `training_days` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batches`
--

LOCK TABLES `batches` WRITE;
/*!40000 ALTER TABLE `batches` DISABLE KEYS */;
INSERT INTO `batches` VALUES (2,'Evening MMA','Personal','18:00','Gunjesh Machhi',_binary '\0','https://meet.google.com/aur-whdk-cnd','16:00','Active',1,'Tue, Thu, Sat'),(3,'Evening Self-defense','Personal','17:00','Gunjesh Machhi',_binary '\0','https://meet.google.com/upx-tghr-ojj','16:00','Active',1,'Mon, Wed, Fri'),(4,'Morning Self-defense','Group','11:00','Gunjesh Machhi',_binary '\0','https://meet.google.com/yjf-xiju-yyo','10:00','Active',2,'Fri, Sat, Sun'),(5,'Morning Self-defense','Personal','07:00','Gunjesh Machhi',_binary '\0','https://meet.google.com/hyf-xmmm-kxt','06:00','Active',1,'Mon, Wed, Fri'),(6,'Evening Batan','Personal','16:00','Gunjesh Machhi',_binary '\0','https://meet.google.com/izj-njmo-djq','15:00','Active',1,'Mon, Tue, Wed'),(7,'Evening Stick','Personal','15:00','Gunjesh Machhi',_binary '\0','https://meet.google.com/mkw-tdcb-dbb','14:00','Active',1,'Wed, Thu');
/*!40000 ALTER TABLE `batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enquiries`
--

DROP TABLE IF EXISTS `enquiries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enquiries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `message` text,
  `phone` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `submitted_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enquiries`
--

LOCK TABLES `enquiries` WRITE;
/*!40000 ALTER TABLE `enquiries` DISABLE KEYS */;
INSERT INTO `enquiries` VALUES (1,'khushboo50.machhi@gmail.com','Viral Machhi','courses???',NULL,'New','General Inquiry','2026-03-24 22:51:01.490996'),(2,'khushboo50.machhi@gmail.com','Khushy Machhi','contact number?','6355118915','New','General Inquiry','2026-03-24 23:08:01.835947'),(3,'khushboo50.machhi@gmail.com','Gunjesh Machhi','timing?','7041551670','Closed','Boxing Training','2026-03-24 23:10:55.699387'),(4,'khushboo50.machhi@gmail.com','Nimisha Machhi',NULL,'9723160756','Converted','MMA','2026-03-25 00:09:47.938824');
/*!40000 ALTER TABLE `enquiries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` double DEFAULT NULL,
  `invoice_number` varchar(255) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_type` varchar(255) DEFAULT NULL,
  `screenshot_path` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKj94hgy9v5fw1munb90tar2eje` (`user_id`),
  CONSTRAINT `FKj94hgy9v5fw1munb90tar2eje` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1000,'INV-1774543090','2026-03-26','Course Fee',NULL,'Paid',1),(2,3000,'12345678789','2026-03-28','Course Fees','1774640485610_Ryan Garcia hitting the mits.jpg','Paid',7);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_documents`
--

DROP TABLE IF EXISTS `student_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_documents` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `aadhar_card` varchar(255) DEFAULT NULL,
  `medical_certificate` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `id_proof` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKqu5nvd4gw5brucyf1mvk33519` (`user_id`),
  CONSTRAINT `FK3sdbwroqg9lu5r2284p6d809h` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_documents`
--

LOCK TABLES `student_documents` WRITE;
/*!40000 ALTER TABLE `student_documents` DISABLE KEYS */;
INSERT INTO `student_documents` VALUES (1,NULL,'1774471124842_1774454387940_Invoice_1265487966 (1).pdf',1,'1774471124814_1774454387956_Invoice_1265487966.pdf','','Verified');
/*!40000 ALTER TABLE `student_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_participants`
--

DROP TABLE IF EXISTS `tournament_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournament_participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `age` int NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `dojo_name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `student_rank` varchar(255) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `weight` double NOT NULL,
  `tournament_id` int DEFAULT NULL,
  `technique` varchar(255) DEFAULT NULL,
  `fee_amount` double NOT NULL,
  `medal` int DEFAULT NULL,
  `is_championship` bit(1) NOT NULL,
  `kata_medal` int DEFAULT NULL,
  `kumite_medal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7m4qdyvu9tgkd7phoskg97nn5` (`tournament_id`),
  CONSTRAINT `FK7m4qdyvu9tgkd7phoskg97nn5` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_participants`
--

LOCK TABLES `tournament_participants` WRITE;
/*!40000 ALTER TABLE `tournament_participants` DISABLE KEYS */;
INSERT INTO `tournament_participants` VALUES (1,18,'Kata,Kumite','2008-03-12','Main Dojo','Viral Machhi','Male','Brown','',55,2,'Karate',500,NULL,_binary '',1,1),(2,15,'Kata,Kumite,Champion of Champions','2011-03-11','Main Dojo','Drashti Machhi','Female','Yellow','',45,2,'Karate',500,NULL,_binary '\0',0,0),(3,53,'Kata','1972-12-04','Main Dojo','Mahesh Machhi','Male','Yellow','',60,2,'Karate',500,NULL,_binary '\0',0,0),(4,13,'Kata','2012-04-12','Main Dojo','Nidhi Yadav','Female','Green','',45,2,'Karate',500,NULL,_binary '\0',0,0),(5,28,'Kata','1997-11-06','Main Dojo','Bhaumik Rathod','Male','Orange','',68,2,'Karate',500,NULL,_binary '\0',0,0),(6,51,'Kata,Kumite','1975-02-13','Main Dojo','Priyanki Panchal','Female','Yellow','SS-T-1001',70,2,'Karate',500,NULL,_binary '\0',0,0),(7,51,'Kata','1975-02-13','Main Dojo','Priyanki Panchal','Female','Yellow','SS-T-1001',60,1,'Karate',1000,NULL,_binary '\0',0,0),(8,28,'Kata,Kumite','1997-11-06','Main Dojo','Khushboo Machhi','Female','Yellow','SS-T-1002',67,2,'Karate',500,NULL,_binary '\0',0,0);
/*!40000 ALTER TABLE `tournament_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournaments`
--

DROP TABLE IF EXISTS `tournaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournaments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `end_date` date DEFAULT NULL,
  `event_year` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `start_time` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `registration_fee` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournaments`
--

LOCK TABLES `tournaments` WRITE;
/*!40000 ALTER TABLE `tournaments` DISABLE KEYS */;
INSERT INTO `tournaments` VALUES (1,'2026-02-14','2026','Anand','2026-Wado-Kai Championship','2026-02-12','08:00','Draft',1000),(2,'2026-03-27','2026','Ahmedabad','2026-Karate Championship','2026-03-26','08:00','Draft',500);
/*!40000 ALTER TABLE `tournaments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  `batch_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgw0eiqxvque72q60jhb6v0wtg` (`batch_id`),
  CONSTRAINT `FKgw0eiqxvque72q60jhb6v0wtg` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'V.V.Nagar','1997-11-06','Anand','India','khushboo50.machhi@gmail.com','khushboo','Female','Machhi','$2a$10$9l1EP2FgCCsMKnHlC8H0fev/KUZvM8PFXDBts9M1jM16Xsv5T52MG','1_1774377337441_20260214_095338.heic','Gujrat','Khushy',3),(2,'Mogri','1996-04-21','Anand','India','khushboo50.machhi@gmail.com','Vaibhav ','Male','Rathod','$2a$10$HDu6qZCSOlkXXtlc8DXDgO2rTTnBcYkr3ZspGDlXjH0aQtaGkDZk.','2_1774384980795_20231005_191259.jpg','Gujrat','Vicky',NULL),(3,'Satelite','1997-10-18','Ahemdabad','India','khushboo50.machhi@gmail.com','Vivek','Male','Joshi','$2a$10$dXAdLNSeSa3SOEqhOE6y4ewJDOOfu6z/ZrDQIMf7G0P6qAstn8FXq','3_1774385103050_20260214_120449.jpg','Gujrat','Viv',NULL),(4,'V.V.Nagar','1996-03-18','Anand','India','khushboo50.machhi@gmail.com','Kiran','Female','Yadav','$2a$10$2jv3vauhXMO1WB9E.v7JPOE.6xRDECrk6fuCiKppLV52lkAIqdwuS','4_1774385761509_20240317_173336.jpg','Gujrat','Kira',NULL),(5,'V.V.Nagar','2001-01-18','Anand','India','khushboo50.machhi@gmail.com','Trupti','Female','Baraiya','$2a$10$CYW2H9Iu09V7nVQpol6oWOKZWpuDSEOTOElLe6ebcCXIsuAESiUzK','5_1774436532293__DSC0118.JPG','Gujrat','Trupt',NULL),(6,'waghodia','1998-07-18','vadodara','India','khushboo50.machhi@gmail.com','Nimisha','Female','Machhi','$2a$10$uqCMC.QQDSTtPU.nwg04qe53nYu2cUr0gH7QGDN//Pveo1gRjlWHm','6_1774436962238_20240218_182429.jpg','Gujrat','Nimi',NULL),(7,'V.V.Nagar','1975-08-05','Anand','India','khushboo50.machhi@gmail.com','Kalpana','Female','Machhi','$2a$10$hb2XXJWk4RWC3ueqIvv3Lun5AryjOySUamNpg0PZ1ko3iBR/87dmy','7_1774440426080_wallpaper_1.jpeg','Gujrat','Julie',4);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-05 13:09:21
