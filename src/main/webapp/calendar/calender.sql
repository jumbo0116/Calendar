-- 建立 table

CREATE TABLE `accounts` (
  `num` int NOT NULL AUTO_INCREMENT,
  `Id` varchar(20) NOT NULL,
  `password` varchar(1000) NOT NULL,
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

-- 一月樣本
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240101,'晚餐',101,80,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240102,'晚餐',101,100,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240103,'晚餐',101,80,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240105,'晚餐',101,300,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240105,'計程車錢',102,600,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240106,'密室逃脫',103,700,1,'好好玩');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240106,'公車',102,80,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240106,'牙刷',104,100,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240106,'感冒看醫生',105,200,1,'一直發燒');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240107,'外套',106,200,1,'NIKE');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240108,'繳稅',107,2000,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240108,'車禍賠錢',108,5000,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240106,'薪水',201,50000,1,'');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240116,'晚餐',101,100,1,'');

-- 二月樣本
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240212,'晚餐',101,3000,1,'屋馬');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240212,'高鐵',102,1200,1,'台中');
insert into calendar.diary(Id,date,name,type,description,account,note)
values('jumbo0116',20240212,'麻將',203,1200,1,'1200');