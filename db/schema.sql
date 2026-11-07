
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `tblCustomer4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblCustomer4` (
  `tblUser4id` int NOT NULL,
  `tblMemberCard4membershipCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`tblUser4id`),
  UNIQUE KEY `tblMemberCard4membershipCode` (`tblMemberCard4membershipCode`),
  CONSTRAINT `fk_customer_card` FOREIGN KEY (`tblMemberCard4membershipCode`) REFERENCES `tblMemberCard4` (`membershipCode`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_user` FOREIGN KEY (`tblUser4id`) REFERENCES `tblUser4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblInvoice4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblInvoice4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paymentMethod` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tblCustomer4tblUser4id` int DEFAULT NULL,
  `tblSalesStaff4tblUser4id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_inv_customer` (`tblCustomer4tblUser4id`),
  KEY `fk_inv_staff` (`tblSalesStaff4tblUser4id`),
  CONSTRAINT `fk_inv_customer` FOREIGN KEY (`tblCustomer4tblUser4id`) REFERENCES `tblCustomer4` (`tblUser4id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_inv_staff` FOREIGN KEY (`tblSalesStaff4tblUser4id`) REFERENCES `tblSalesStaff4` (`tblUser4id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblManager4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblManager4` (
  `department` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tblUser4id` int NOT NULL,
  PRIMARY KEY (`tblUser4id`),
  CONSTRAINT `fk_manager_user` FOREIGN KEY (`tblUser4id`) REFERENCES `tblUser4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblMemberCard4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblMemberCard4` (
  `membershipCode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `membershipRegistrationDate` date NOT NULL,
  `rewardPoints` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`membershipCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblMovie4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblMovie4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movieTitle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `director` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cast` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ageRating` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `releaseDate` date NOT NULL,
  `endDate` date NOT NULL,
  `posterImage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblMovieGenre4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblMovieGenre4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `genreName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblMovieGenreDetail4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblMovieGenreDetail4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tblMovie4id` int NOT NULL,
  `tblMovieGenre4id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tblMovie4id` (`tblMovie4id`,`tblMovieGenre4id`),
  KEY `fk_mgd_genre` (`tblMovieGenre4id`),
  CONSTRAINT `fk_mgd_genre` FOREIGN KEY (`tblMovieGenre4id`) REFERENCES `tblMovieGenre4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mgd_movie` FOREIGN KEY (`tblMovie4id`) REFERENCES `tblMovie4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblMovieTicket4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblMovieTicket4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `tblShowtime4id` int NOT NULL,
  `tblSeat4id` int NOT NULL,
  `tblInvoice4id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tblShowtime4id` (`tblShowtime4id`,`tblSeat4id`),
  KEY `fk_ticket_seat` (`tblSeat4id`),
  KEY `fk_ticket_invoice` (`tblInvoice4id`),
  CONSTRAINT `fk_ticket_invoice` FOREIGN KEY (`tblInvoice4id`) REFERENCES `tblInvoice4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_seat` FOREIGN KEY (`tblSeat4id`) REFERENCES `tblSeat4` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_showtime` FOREIGN KEY (`tblShowtime4id`) REFERENCES `tblShowtime4` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblSalesStaff4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblSalesStaff4` (
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `workShift` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tblUser4id` int NOT NULL,
  PRIMARY KEY (`tblUser4id`),
  CONSTRAINT `fk_staff_user` FOREIGN KEY (`tblUser4id`) REFERENCES `tblUser4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblScreeningRoom4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblScreeningRoom4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roomName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roomType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roomStatus` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblSeat4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblSeat4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seatRow` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seatNumber` int NOT NULL,
  `seatStatus` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tblScreeningRoom4id` int NOT NULL,
  `tblSeatType4id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tblScreeningRoom4id` (`tblScreeningRoom4id`,`seatRow`,`seatNumber`),
  KEY `fk_seat_type` (`tblSeatType4id`),
  CONSTRAINT `fk_seat_room` FOREIGN KEY (`tblScreeningRoom4id`) REFERENCES `tblScreeningRoom4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_seat_type` FOREIGN KEY (`tblSeatType4id`) REFERENCES `tblSeatType4` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblSeatPrice4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblSeatPrice4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `tblShowtime4id` int NOT NULL,
  `tblSeatType4id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tblShowtime4id` (`tblShowtime4id`,`tblSeatType4id`),
  KEY `fk_sp_seattype` (`tblSeatType4id`),
  CONSTRAINT `fk_sp_seattype` FOREIGN KEY (`tblSeatType4id`) REFERENCES `tblSeatType4` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_sp_showtime` FOREIGN KEY (`tblShowtime4id`) REFERENCES `tblShowtime4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblSeatType4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblSeatType4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblShowtime4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblShowtime4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `showDate` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `tblMovie4id` int NOT NULL,
  `tblScreeningRoom4id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_showtime_movie` (`tblMovie4id`),
  KEY `fk_showtime_room` (`tblScreeningRoom4id`),
  CONSTRAINT `fk_showtime_movie` FOREIGN KEY (`tblMovie4id`) REFERENCES `tblMovie4` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_showtime_room` FOREIGN KEY (`tblScreeningRoom4id`) REFERENCES `tblScreeningRoom4` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tblUser4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblUser4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateOfBirth` date NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phoneNumber` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accountStatus` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phoneNumber` (`phoneNumber`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

