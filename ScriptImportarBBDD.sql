-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         12.2.2-MariaDB-ubu2404 - mariadb.org binary distribution
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para dht
CREATE DATABASE IF NOT EXISTS `dht` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `dht`;

-- Volcando estructura para tabla dht.sensor_data
CREATE TABLE IF NOT EXISTS `sensor_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `humidity` decimal(20,6) DEFAULT NULL,
  `temperature` decimal(20,6) DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla dht.sensor_data: ~13 rows (aproximadamente)
INSERT INTO `sensor_data` (`id`, `humidity`, `temperature`, `date`) VALUES
	(3, 10.000000, 10.000000, '2026-04-23 10:11:59'),
	(4, 11.000000, 11.000000, '2026-04-23 10:12:18'),
	(5, 12.000000, 12.000000, '2026-04-23 10:12:22'),
	(6, 10.000000, 10.000000, '2026-04-23 10:27:11'),
	(7, 10.000000, 10.000000, '2026-04-23 10:27:26'),
	(8, 10.000000, 10.000000, '2026-04-23 10:27:41'),
	(9, 10.000000, 10.000000, '2026-04-23 10:27:56'),
	(10, 10.000000, 10.000000, '2026-04-23 10:31:08'),
	(11, 10.000000, 10.000000, '2026-04-23 10:32:37'),
	(12, 10.000000, 10.000000, '2026-04-23 10:32:52'),
	(13, 10.000000, 10.000000, '2026-04-23 10:38:08'),
	(14, 10.000000, 10.000000, '2026-04-23 10:38:23'),
	(15, 10.000000, 10.000000, '2026-04-23 10:38:38'),
	(16, 10.000000, 10.000000, '2026-04-23 10:38:53'),
	(17, 10.000000, 10.000000, '2026-04-23 10:39:08');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
