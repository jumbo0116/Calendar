-- 建立 table

CREATE TABLE `accounts` (
  `num` int NOT NULL AUTO_INCREMENT,
  `Id` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `diary` (
  `num` int NOT NULL AUTO_INCREMENT,
  `Id` varchar(225) NOT NULL,
  `date` Date NOT NULL,
  `name` varchar(225) NOT NULL,
  `type` varchar(225) NOT NULL,
  `description` int NOT NULL,
  `account` varchar(225) NOT NULL,
  `note` varchar(225),
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;