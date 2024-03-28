-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.4.33-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- diary 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `diary` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `diary`;

-- 테이블 diary.diary 구조 내보내기
CREATE TABLE IF NOT EXISTS `diary` (
  `diary_date` date NOT NULL,
  `feeling` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` text NOT NULL,
  `weather` enum('맑음','흐림','비','눈') NOT NULL,
  `content` text NOT NULL,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`diary_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.diary:~12 rows (대략적) 내보내기
INSERT IGNORE INTO `diary` (`diary_date`, `feeling`, `title`, `weather`, `content`, `update_date`, `create_date`) VALUES
	('2024-03-02', '&#128538', 'fsfsf', '맑음', 'sfsfsfsf', '2024-03-26 16:10:45', '2024-03-26 16:10:45'),
	('2024-03-05', '&#128538', 'gdgdg', '맑음', 'dgdgdgd', '2024-03-26 16:10:21', '2024-03-26 16:10:21'),
	('2024-03-08', '&#128538', 'ㅎㅇ', '맑음', 'ㅎㅇ', '2024-03-26 15:54:24', '2024-03-26 15:54:24'),
	('2024-03-10', '&#128538', 'ㅎㅇ', '맑음', 'ㅎㅇㅎㅇㅎㅇㅎ', '2024-03-26 17:05:56', '2024-03-26 17:05:56'),
	('2024-03-12', '&#128538', 'ㅎㅇㅎㅇㅎ', '맑음', 'ㅎㅇㅎㅇㅎㅇㅎㅇ', '2024-03-26 15:55:00', '2024-03-26 15:55:00'),
	('2024-03-15', '&#128538', 'sfsf', '맑음', 'fsfsfsf', '2024-03-26 16:10:28', '2024-03-26 16:10:28'),
	('2024-03-18', '&#128538', 'fsfsf', '맑음', 'sfsfsfsfs', '2024-03-26 16:11:04', '2024-03-26 16:11:04'),
	('2024-03-20', '&#128538', 'ㅎㅇ', '맑음', 'ㅎㅇ', '2024-03-26 15:54:33', '2024-03-26 15:54:33'),
	('2024-03-25', '😡', 'fsfs', '맑음', 'fsfsfsfs', '2024-03-26 16:10:37', '2024-03-26 16:10:37'),
	('2024-03-26', '&#128538', 'ㅎㅇ', '맑음', 'ㅎㅇㅎㅇㅎㅇ', '2024-03-26 17:06:21', '2024-03-26 17:06:21'),
	('2024-03-30', '😭', 'ㄹㄴㄴㄹ', '맑음', 'ㄹㄴㄹㄴㄹㄴㄹㄴㄹ', '2024-03-27 14:36:25', '2024-03-27 14:36:25'),
	('2024-03-31', '&#128538', '집에 가지마 ', '눈', '지금당장', '2024-03-26 15:13:46', '2024-03-26 15:13:46');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
