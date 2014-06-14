-- MySQL dump 10.10
--
-- Host: 184.168.228.74    Database: equibidz
-- ------------------------------------------------------
-- Server version	5.0.91-log

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
-- Table structure for table `_auction_types`
--

DROP TABLE IF EXISTS `_auction_types`;
CREATE TABLE `_auction_types` (
  `code` varchar(1) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `_auction_types`
--

LOCK TABLES `_auction_types` WRITE;
/*!40000 ALTER TABLE `_auction_types` DISABLE KEYS */;
INSERT INTO `_auction_types` VALUES ('D','Dutch (for auctions selling more than one item)'),('E','English (for auctions selling only one item)');
/*!40000 ALTER TABLE `_auction_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
CREATE TABLE `access` (
  `ID` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `login` varchar(50) default NULL,
  `admin_access` tinyint(1) default '0',
  `defaults_access` tinyint(1) default '0',
  `users_access` tinyint(1) default '0',
  `accounts_access` tinyint(1) default '0',
  `categories_access` tinyint(1) default '0',
  `auctions_access` tinyint(1) default '0',
  `siteinfo_access` tinyint(1) default '0',
  `reports_access` tinyint(1) default '0',
  `access_access` tinyint(1) default '0',
  `is_active` tinyint(1) default '1',
  `admin_id` int(11) NOT NULL default '0',
  `classified_access` tinyint(1) default NULL,
  `support_access` tinyint(1) default '0',
  `banner_access` tinyint(1) default '0',
  PRIMARY KEY  (`ID`),
  KEY `admin_id` (`admin_id`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `access`
--

LOCK TABLES `access` WRITE;
/*!40000 ALTER TABLE `access` DISABLE KEYS */;
INSERT INTO `access` VALUES (93,'Test','admin',1,1,1,1,1,1,1,1,1,1,101,0,1,1),(94,'test1','test1',1,1,1,1,1,1,1,1,1,1,102,1,1,1),(95,'Administrator','admin',0,0,0,0,0,0,0,0,0,1,103,0,0,0),(96,'Brian','adopogi2',1,1,1,1,1,1,1,1,1,1,104,1,1,1),(98,'davidh1','davidh1',0,0,0,0,0,0,0,0,0,0,105,0,0,0),(126,'Book Keeper','bookkeeper',1,0,0,0,0,0,0,0,0,1,16,0,0,0),(130,'Taylor','Taylor',1,1,1,1,1,1,1,1,1,1,20,1,1,1);
/*!40000 ALTER TABLE `access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_defaults`
--

DROP TABLE IF EXISTS `ad_defaults`;
CREATE TABLE `ad_defaults` (
  `ad_dur` tinyint(3) unsigned NOT NULL default '0',
  `ad_fee` double NOT NULL default '0',
  PRIMARY KEY  (`ad_dur`),
  UNIQUE KEY `ad_dur` (`ad_dur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ad_defaults`
--

LOCK TABLES `ad_defaults` WRITE;
/*!40000 ALTER TABLE `ad_defaults` DISABLE KEYS */;
INSERT INTO `ad_defaults` VALUES (1,1);
/*!40000 ALTER TABLE `ad_defaults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_info`
--

DROP TABLE IF EXISTS `ad_info`;
CREATE TABLE `ad_info` (
  `adnum` int(11) NOT NULL default '0',
  `status` tinyint(3) unsigned NOT NULL default '0',
  `title` varchar(45) NOT NULL default 'New Ad Title',
  `user_id` int(11) NOT NULL default '0',
  `category1` int(11) NOT NULL default '0',
  `category2` int(11) default '0',
  `ad_body` longtext NOT NULL,
  `ask_price` double NOT NULL default '0',
  `obo` tinyint(1) NOT NULL default '0',
  `picture_url` longtext NOT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `community_ad` double NOT NULL default '0',
  `ad_dur` int(11) NOT NULL default '10',
  `ad_fee` double NOT NULL default '0',
  `remote_ip` varchar(24) NOT NULL default '127.0.0.1',
  `picture1` varchar(255) default NULL,
  `picture2` varchar(255) default NULL,
  `picture3` varchar(255) default NULL,
  `picture4` varchar(255) default NULL,
  PRIMARY KEY  (`adnum`),
  UNIQUE KEY `adnum` (`adnum`),
  KEY `use_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ad_info`
--

LOCK TABLES `ad_info` WRITE;
/*!40000 ALTER TABLE `ad_info` DISABLE KEYS */;
INSERT INTO `ad_info` VALUES (734993303,0,'testph classified',730931115,730931213,0,'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test ',5,0,'http://','2003-04-15 12:48:00','2003-04-16 12:48:00',0,1,1,'127.0.0.1',NULL,NULL,NULL,NULL),(881102986,0,'Test Only',880835450,880155011,0,'lkjlakdjlkjasd',10,0,'http://','2007-12-01 14:49:00','2007-12-02 14:49:00',0,1,1,'127.0.0.1','','','',''),(881103704,0,'None',880835450,880155011,0,'dfsdfsdfsdf',11,0,'http://','2007-12-01 15:01:00','2007-12-02 15:01:00',0,1,1,'127.0.0.1','','','','');
/*!40000 ALTER TABLE `ad_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_offers`
--

DROP TABLE IF EXISTS `ad_offers`;
CREATE TABLE `ad_offers` (
  `ID` int(11) NOT NULL auto_increment,
  `adnum` double NOT NULL default '0',
  `offer` double NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  KEY `adnum` (`adnum`),
  KEY `ID` (`ID`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ad_offers`
--

LOCK TABLES `ad_offers` WRITE;
/*!40000 ALTER TABLE `ad_offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_trans_log`
--

DROP TABLE IF EXISTS `ad_trans_log`;
CREATE TABLE `ad_trans_log` (
  `trans_id` int(11) NOT NULL default '0',
  `adnum` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `date_posted` datetime NOT NULL,
  `description` varchar(200) NOT NULL default 'Trans Log Description',
  `details` longtext NOT NULL,
  `amount` double NOT NULL default '0',
  `remote_ip` varchar(23) NOT NULL default '127.0.0.1',
  PRIMARY KEY  (`trans_id`),
  UNIQUE KEY `trans_id_index` (`trans_id`),
  KEY `date_posted_index` (`date_posted`),
  KEY `description_index` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ad_trans_log`
--

LOCK TABLES `ad_trans_log` WRITE;
/*!40000 ALTER TABLE `ad_trans_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_trans_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `administrators`
--

DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators` (
  `name` varchar(65) default 'Admin Name',
  `login` varchar(12) default NULL,
  `password` varchar(12) default 'admin',
  `date_created` datetime default NULL,
  `sec_level` smallint(6) NOT NULL default '0',
  `is_active` tinyint(1) NOT NULL default '0',
  `admin_id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `administrators`
--

LOCK TABLES `administrators` WRITE;
/*!40000 ALTER TABLE `administrators` DISABLE KEYS */;
INSERT INTO `administrators` VALUES ('Administrator','admin','admin=2011','2004-03-11 09:45:07',10,1,1),('Book Keeper','bookkeeper','acct=2011','2011-07-21 16:36:57',10,1,16);
/*!40000 ALTER TABLE `administrators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adv_defaults`
--

DROP TABLE IF EXISTS `adv_defaults`;
CREATE TABLE `adv_defaults` (
  `ad_dur` tinyint(3) unsigned NOT NULL default '0',
  `ad_fee` double NOT NULL default '0',
  PRIMARY KEY  (`ad_dur`),
  UNIQUE KEY `ad_dur` (`ad_dur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `adv_defaults`
--

LOCK TABLES `adv_defaults` WRITE;
/*!40000 ALTER TABLE `adv_defaults` DISABLE KEYS */;
INSERT INTO `adv_defaults` VALUES (1,30),(2,55),(3,75),(4,90),(5,105),(6,115),(9,125),(12,135);
/*!40000 ALTER TABLE `adv_defaults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adv_info`
--

DROP TABLE IF EXISTS `adv_info`;
CREATE TABLE `adv_info` (
  `adnum` int(11) NOT NULL default '0',
  `date_created` datetime NOT NULL,
  `status` tinyint(3) unsigned NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `ad_dur` int(11) NOT NULL default '10',
  `ad_fee` double NOT NULL default '0',
  `picture` varchar(255) NOT NULL,
  `webaddress` varchar(255) default NULL,
  `paused` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`adnum`),
  UNIQUE KEY `adnum` (`adnum`),
  KEY `use_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `adv_info`
--

LOCK TABLES `adv_info` WRITE;
/*!40000 ALTER TABLE `adv_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `adv_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `ID` int(11) NOT NULL auto_increment,
  `factor` int(11) default '0',
  `file_name` longtext NOT NULL,
  `company` longtext,
  `webaddress` longtext,
  `username` longtext,
  `password` longtext,
  `ban_hptop` tinyint(1) NOT NULL,
  `ban_am` tinyint(1) NOT NULL,
  `ban_hpbot` tinyint(1) NOT NULL,
  `banner_enable` tinyint(1) default '1',
  PRIMARY KEY  (`ID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
INSERT INTO `banners` VALUES (131,1,'images.jpg','Hunter Jumper','www.equibidz.com',' ',' ',1,0,0,1),(132,1,'1images.jpg','Racehorses','www.equibidz.com',' ',' ',1,0,0,1),(133,1,'IMG_0489.JPG','Reiner','www.equibidz.com',' ',' ',1,0,0,1);
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bids`
--

DROP TABLE IF EXISTS `bids`;
CREATE TABLE `bids` (
  `ID` int(11) NOT NULL auto_increment,
  `itemnum` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `time_placed` datetime NOT NULL,
  `bid` double NOT NULL default '0',
  `quantity` smallint(6) NOT NULL default '0',
  `remote_ip` varchar(23) NOT NULL default '127.0.0.1',
  `buynow` tinyint(1) default '0',
  `hide` tinyint(1) default '0',
  `winner` tinyint(1) default '0',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `id` (`ID`),
  KEY `itemnum_index` (`itemnum`),
  KEY `time_placed_index` (`time_placed`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bids`
--

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocked_bidders`
--

DROP TABLE IF EXISTS `blocked_bidders`;
CREATE TABLE `blocked_bidders` (
  `ID` int(11) NOT NULL auto_increment,
  `seller` int(11) NOT NULL default '0',
  `bidder` int(11) NOT NULL default '0',
  `date_placed` datetime NOT NULL,
  `itemnum` int(11) NOT NULL default '0',
  `remote_ip` varchar(23) NOT NULL default '127.0.0.1',
  PRIMARY KEY  (`ID`),
  KEY `date_placed_index` (`date_placed`),
  KEY `ID` (`ID`),
  KEY `itemnum` (`itemnum`),
  KEY `user_id_from` (`bidder`),
  KEY `user_id_index` (`seller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `blocked_bidders`
--

LOCK TABLES `blocked_bidders` WRITE;
/*!40000 ALTER TABLE `blocked_bidders` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocked_bidders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocked_ip`
--

DROP TABLE IF EXISTS `blocked_ip`;
CREATE TABLE `blocked_ip` (
  `id` int(11) NOT NULL auto_increment,
  `blocked_ip` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `blocked_ip`
--

LOCK TABLES `blocked_ip` WRITE;
/*!40000 ALTER TABLE `blocked_ip` DISABLE KEYS */;
INSERT INTO `blocked_ip` VALUES (1,'192.188.111.1');
/*!40000 ALTER TABLE `blocked_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category` int(11) NOT NULL default '0',
  `parent` int(11) NOT NULL default '0',
  `child_count` smallint(6) NOT NULL default '0',
  `name` varchar(255) NOT NULL default 'New Category',
  `date_created` datetime NOT NULL,
  `active` tinyint(1) NOT NULL default '0',
  `allow_sales` tinyint(1) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `require_login` tinyint(1) NOT NULL default '0',
  `count_items` int(11) NOT NULL default '0',
  `count_total` int(11) NOT NULL default '0',
  `parent_setting` tinyint(1) default '1',
  `cat_image` varchar(255) default NULL,
  `heading_color` varchar(50) default NULL,
  `bg_color` varchar(50) default NULL,
  `font_color` varchar(50) default NULL,
  `font_style` varchar(50) default NULL,
  `fee_listing` double default '0',
  `lvl_1` int(11) default '0',
  `lvl_2` int(11) default '0',
  `lvl_3` int(11) default '0',
  `lvl_4` int(11) default '0',
  `lvl_5` int(11) default '0',
  `lvl_6` int(11) default '0',
  `lvl_7` int(11) default '0',
  `lvl_8` int(11) default '0',
  `this_lvl` int(11) default '0',
  PRIMARY KEY  (`category`),
  UNIQUE KEY `category_index` (`category`),
  KEY `active_index` (`active`),
  KEY `allow_sales_index` (`allow_sales`),
  KEY `num_children` (`child_count`),
  KEY `parent_index` (`parent`),
  KEY `require_login_index` (`require_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (-2,-3,0,'_None','1999-01-01 00:00:00',0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(0,-1,91,'_Top','1999-01-01 00:00:00',1,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(989485725,0,0,'STALLIONS','2011-05-09 02:07:39',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,989485725,0,0,0,0,0,0,0,1),(989490587,0,0,'WEANLINGS','2006-05-09 03:28:46',1,0,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,989490587,0,0,0,0,0,0,0,1),(989490657,0,0,'MARE BREEDING LEASE','2007-05-09 03:30:33',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,989490657,0,0,0,0,0,0,0,1),(989490761,0,0,'STALLION BREEDING SERVICE','2009-05-09 03:31:58',1,0,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,989490761,0,0,0,0,0,0,0,1),(990724531,0,0,'YEARLINGS','2011-05-23 10:15:16',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,990724531,0,0,0,0,0,0,0,1),(991700296,0,0,'GELDINGS','2011-06-03 16:17:58',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,991700296,0,0,0,0,0,0,0,1),(991700311,0,0,'MARES','2011-06-03 16:17:29',1,1,0,0,1,0,1,NULL,NULL,NULL,NULL,NULL,1,991700311,0,0,0,0,0,0,0,1),(992967487,0,0,'BROOD MARES','2011-06-18 08:17:47',1,1,0,0,1,0,1,NULL,NULL,NULL,NULL,NULL,20,992967487,0,0,0,0,0,0,0,1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_cards`
--

DROP TABLE IF EXISTS `credit_cards`;
CREATE TABLE `credit_cards` (
  `ID` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `itemnum` int(11) NOT NULL default '0',
  `ad_num` int(11) NOT NULL default '0',
  `name` varchar(65) NOT NULL default 'Name on Credit Card',
  `card_number` varchar(50) NOT NULL default '0000000000000000',
  `expiration` varchar(6) NOT NULL default '00/00',
  PRIMARY KEY  (`ID`),
  KEY `ad_num` (`ad_num`),
  KEY `ID` (`ID`),
  KEY `itemnum_index` (`itemnum`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `credit_cards`
--

LOCK TABLES `credit_cards` WRITE;
/*!40000 ALTER TABLE `credit_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `defaults`
--

DROP TABLE IF EXISTS `defaults`;
CREATE TABLE `defaults` (
  `ID` int(11) NOT NULL auto_increment,
  `name` varchar(15) NOT NULL default 'Name',
  `pair` varchar(30) NOT NULL default 'Pair',
  PRIMARY KEY  (`ID`),
  KEY `ID` (`ID`),
  KEY `name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=843 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `defaults`
--

LOCK TABLES `defaults` WRITE;
/*!40000 ALTER TABLE `defaults` DISABLE KEYS */;
INSERT INTO `defaults` VALUES (1,'link_color','000000'),(2,'alink_color','0000bb'),(3,'vlink_color','008000'),(4,'bg_color','ffffff'),(5,'category_new','30'),(6,'listing_new','30'),(7,'itemsperpage','30'),(8,'listing_bgcolor','efefef'),(9,'hrsending_color','000000'),(10,'hrsending','24'),(11,'bids4hot','5'),(12,'le_prm_listing','1'),(13,'le_feat_listing','0'),(14,'le_std_listing','0'),(15,'le_root_listing','1'),(16,'le_categories','1'),(17,'e_categories','{ts \'1999-06-03 15:10:00\'}'),(18,'e_current','{ts \'1999-06-03 15:10:00\'}'),(19,'e_new','{ts \'1999-06-03 16:00:00\'}'),(20,'e_ending','{ts \'1999-06-03 16:30:00\'}'),(21,'e_completed','{ts \'1999-06-03 05:00:00\'}'),(22,'e_going','{ts \'1999-06-03 13:20:00\'}'),(23,'e_featured','{ts \'1999-06-03 13:30:00\'}'),(24,'e_rootindex','{ts \'1999-06-03 15:10:00\'}'),(29,'def_duration','0030'),(30,'def_bidding','regular'),(31,'dynamic','0000'),(32,'def_dynamic','0002'),(33,'dynamic','0003'),(34,'dynamic','0005'),(35,'dynamic','0006'),(36,'dynamic','0007'),(37,'dynamic','0008'),(38,'dynamic','0009'),(39,'dynamic','0010'),(40,'dynamic','0004'),(41,'dynamic','0020'),(42,'enable_iescrow','1'),(43,'free_trial_days','0'),(44,'free_trial','1'),(45,'fee_listing','20.00'),(46,'fee_bold','0.25'),(47,'fee_featured','9.95'),(48,'fee_banner','1'),(49,'fee_studio','5.00'),(50,'fee_feat_studio','7.00'),(51,'fee_late_charge','25'),(52,'fee_feat_cat','5.00'),(53,'enable_ssl','0'),(54,'last_seller','945538660'),(55,'fb_per_page','20'),(56,'text_color','000080'),(57,'fee_second_cat','0.05'),(58,'billing_period','30'),(59,'site_currency','USD'),(60,'chkTableFutureW','0'),(64,'def_increment','5'),(68,'increment','1'),(69,'increment','5'),(70,'increment','10'),(72,'e_futurewatch','880835450'),(73,'bMaxoutProxies','1'),(77,'exclusive_cat','100.00'),(78,'PairLoginPass','1'),(79,'IEIconFrontPage','std_120x34.gif'),(80,'mode_switch','Single'),(81,'auction_mode','0'),(82,'bMinoutProxies','0'),(83,'dynamic','0002'),(84,'enable_thumbs','1'),(87,'duration','0030'),(90,'increment','100'),(91,'increment','20'),(92,'increment','50'),(93,'fee_inspector','0'),(112,'billing_type','per_auction'),(113,'credit_limit','0'),(114,'heading_color','6b85b6'),(115,'heading_fcolor','ffffff'),(116,'heading_font','Arial'),(122,'featitemspage','6'),(124,'featcolspage','2'),(126,'membership_sta','1'),(128,'membership_opt','30_80_Platinum_Annual'),(129,'membership_opt','15_50_Gold_Annual'),(140,'enable_cat_fee','0'),(141,'fee_reserve_bid','0.00'),(142,'limitcat_frpage','20'),(146,'fee_picture1','0.05'),(147,'fee_picture2','0.15'),(148,'fee_picture3','0.15'),(149,'fee_picture4','0.15'),(150,'top_seller','5'),(152,'heading_fsize','14'),(168,'membership_opt','20_50_test_Monthly'),(179,'noinv_user','880835450'),(180,'administrative','0'),(181,'premium','10'),(182,'financial','0'),(183,'breed','Quarter Horse'),(184,'color','Chestnut'),(194,'dollar_type','Dollar Type 1'),(195,'dollar_type','Dollar Type 2'),(199,'location','Middle-Atlantic'),(200,'location','Midwest'),(201,'location','New England'),(234,'bloodline','Not Disclosed'),(236,'experience','Not Disclosed'),(240,'discipline','Reining'),(241,'discipline','Cutting'),(243,'discipline','Cow Horse'),(245,'temperament','2'),(246,'temperament','3'),(247,'temperament','4'),(248,'temperament','5'),(249,'temperament','6'),(250,'temperament','7'),(251,'temperament','8'),(252,'temperament','9'),(254,'color','Black'),(256,'color','Sorrel'),(257,'color','Palomino'),(258,'color','Dun'),(260,'color','Grey'),(261,'color','Roan'),(262,'color','Buckskin'),(265,'discipline','Racing'),(266,'discipline','All Around'),(267,'discipline','Barrel Racing'),(268,'discipline','Calf Roping'),(269,'discipline','Dressage'),(270,'discipline','Driving'),(272,'discipline','English Pleasure'),(273,'discipline','Halter'),(274,'discipline','Polo'),(275,'discipline','Ranch Versatility'),(276,'discipline','Reined Cow'),(277,'discipline','Roping'),(280,'discipline','Western Pleasure'),(282,'color','Bay'),(283,'color','Brown'),(284,'color','Champagne'),(285,'color','Cremello '),(286,'color','Grulla'),(287,'color','Other'),(288,'color','Pinto'),(289,'color','White'),(291,'temperament','1'),(292,'list_type','Stallion'),(293,'list_type','Stallion Breeding Services'),(294,'list_type','Mare Breeding Lease'),(295,'list_type','Embryo Auction'),(296,'list_type','Mare'),(297,'list_type','Gelding'),(298,'breed','Breeds w/Most Ads'),(299,'breed','Any'),(301,'breed','Thoroughbred'),(302,'breed','Arabian'),(304,'breed','Abyssinian'),(305,'breed','Akhal Teke'),(306,'breed','Albanian'),(307,'breed','Altai'),(308,'breed','American Cream Draft'),(309,'breed','American Creme and White'),(310,'breed','American Curly'),(311,'breed','American Gaited Mountain Horse'),(312,'breed','American Gaited Pony'),(313,'breed','American Saddlebred'),(314,'breed','American Walking Pony'),(315,'breed','American Warmblood'),(316,'breed','Andalusian'),(317,'breed','Andravida'),(318,'breed','Anglo-Arab'),(319,'breed','Anglo-Kabarda'),(320,'breed','Appaloosa'),(321,'breed','Appendix Quarter Horse'),(322,'breed','Araappaloosa'),(323,'breed','Ardennes'),(324,'breed','Argentine Criollo'),(325,'breed','Asturian'),(326,'breed','Australian Brumby'),(327,'breed','Australian Stock Horse'),(328,'breed','Azteca'),(329,'breed','Balearic'),(330,'breed','Baluchi'),(331,'breed','Ban-ei'),(332,'breed','Banker'),(333,'breed','Barb'),(334,'breed','Bashkir'),(335,'breed','Bashkir Curly'),(336,'breed','Basotho Pony'),(337,'breed','Belgian'),(338,'breed','Belgian Warmblood'),(339,'breed','Bhirum Pony'),(340,'breed','Bhotia Pony'),(341,'breed','Black Forest'),(342,'breed','Blue Eyed Horse Association'),(343,'breed','Boer'),(344,'breed','Brandenburger'),(345,'breed','Breton'),(346,'breed','Buckskin'),(347,'breed','Budyonny'),(348,'breed','Byelorussian Harness'),(349,'breed','Camargue'),(350,'experience','Champion'),(351,'breed','Campolina'),(352,'experience','Choose A Ranking'),(353,'breed','Canadian Horse'),(354,'experience','Competed or Shown'),(355,'breed','Canadian Sport Horse'),(356,'breed','Carthusian'),(357,'experience','Prospect'),(358,'breed','Caspian'),(359,'breed','Cayuse'),(360,'breed','Cheju'),(361,'experience','Rank Not Applicable'),(362,'breed','Chilean Corralero'),(363,'experience','Trained'),(364,'breed','Chincoteague Pony'),(365,'breed','Cleveland Bay'),(366,'breed','Clydesdale'),(367,'breed','Colorado Ranger Horse'),(368,'breed','Connemara'),(369,'breed','Cremello'),(370,'breed','Crioulo'),(371,'breed','Dales Pony'),(372,'breed','Danish Warmblood'),(373,'breed','Danube'),(374,'breed','Dartmoor Pony'),(375,'breed','Deliboz'),(377,'breed','Djerma'),(380,'breed','Dole'),(381,'breed','Dongola'),(383,'breed','Donkey'),(384,'breed','Draft'),(385,'breed','Draft Cross'),(386,'breed','Drum Horse'),(387,'breed','Dutch Draft'),(388,'breed','Dutch Harness'),(390,'breed','Dutch Warmblood'),(391,'breed','East Bulgarian'),(392,'breed','Egyptian'),(393,'breed','Eriskay Pony'),(394,'breed','Estonian Native'),(395,'breed','Exmoor Pony'),(396,'breed','Faeroes Pony'),(397,'breed','Falabella '),(398,'breed','Fell Pony'),(399,'breed','Finnhorse'),(400,'breed','Fjord'),(401,'breed','Fleuve'),(402,'breed','Florida Cracker'),(403,'breed','Foundation Quarter Horse'),(404,'breed','Fouta'),(405,'breed','Frederiksborg'),(406,'breed','French Saddlebred'),(407,'breed','French Trotter'),(408,'breed','Friesian'),(409,'breed','Friesian Cross'),(410,'breed','Galiceno'),(411,'breed','Galician Pony'),(412,'breed','Gelderlander'),(413,'breed','German Bred'),(414,'breed','German Riding Pony'),(415,'breed','Gidran'),(416,'breed','Golden American Saddlebred'),(417,'breed','Gotland'),(418,'breed','Groningen'),(419,'breed','Guangxi'),(420,'breed','Gypsy Cob'),(421,'breed','Gypsy Vanner'),(422,'breed','Hackney'),(423,'breed','Haflinger'),(424,'breed','Half-Arabian'),(425,'breed','Hanoverian'),(426,'breed','Hequ'),(427,'breed','Highland Pony'),(428,'breed','Hokkaido'),(429,'breed','Holsteiner'),(430,'breed','Hucul'),(431,'breed','Hungarian Warmblood'),(432,'breed','Icelandic'),(433,'breed','Iomud'),(434,'breed','Irish Cob'),(435,'breed','Irish Draught'),(436,'breed','Irish Sport Horse'),(437,'breed','Jinzhou'),(438,'breed','Jutland'),(439,'breed','Kabarda'),(440,'breed','Karabair'),(441,'breed','Karabakh'),(442,'breed','Kazakh'),(443,'breed','Kentucky Mountain Saddle Horse'),(444,'breed','Kerry Bog Pony'),(445,'breed','Kiger Mustang'),(446,'breed','Kirdi Pony'),(447,'breed','Kisber Felver'),(448,'breed','Kiso'),(449,'breed','Kladruby'),(450,'breed','Knabstrup'),(451,'breed','Kushum'),(452,'breed','Kustanai'),(453,'breed','Latvian'),(454,'breed','Lipizzan'),(455,'breed','Lithuanian Heavy Draft'),(456,'breed','Lokai'),(457,'breed','Losino'),(458,'breed','Lusitano'),(459,'breed','Malopolski'),(460,'breed','Mangalarga'),(461,'breed','Marwari'),(463,'breed','M\'Bayar'),(464,'breed','Merens Pony'),(465,'breed','Messara'),(466,'breed','Miniature'),(467,'breed','Misaki'),(468,'breed','Missouri Fox Trotter'),(469,'breed','Miyako'),(470,'breed','Mongolian'),(471,'breed','Morab'),(472,'breed','Morgan'),(473,'breed','Mountain Pleasure Horse'),(474,'breed','Moyle'),(475,'breed','Mule'),(476,'breed','Murgese'),(477,'breed','Mustang'),(478,'breed','National Show Horse'),(479,'breed','New Forest Pony'),(480,'breed','New Kirgiz'),(481,'breed','Newfoundland Pony'),(482,'breed','Nokota'),(483,'breed','Noma'),(484,'breed','Nooitgedacht Pony'),(485,'breed','Nordland'),(486,'breed','Noric'),(487,'breed','North Swedish Horse'),(488,'breed','Northeastern'),(489,'breed','Ob'),(490,'breed','Oldenburg'),(491,'breed','Orlov Trotter'),(492,'breed','Paint (Overo)'),(493,'breed','Paint (Solid)'),(494,'breed','Paint (Tobiano)'),(495,'breed','Paint (Tovero)'),(496,'breed','Paints (All)'),(497,'breed','Palomino'),(498,'breed','Pantaneiro'),(499,'breed','Paso Fino'),(500,'breed','Percheron'),(501,'breed','Peruvian Paso'),(502,'breed','Pindos Pony'),(503,'breed','Pinia'),(504,'breed','Pintabian'),(505,'breed','Pinto'),(506,'breed','POA'),(507,'breed','Ponies'),(508,'breed','Ponies (All)'),(509,'breed','Pottok'),(510,'breed','Przewalski'),(511,'breed','Pura Raza Espanola (PRE)'),(512,'breed','Pyrenean Tarpan'),(513,'breed','Qatgani'),(514,'breed','Quarab'),(515,'breed','Quarter Horse Cross'),(516,'breed','Quarter Pony'),(517,'breed','Racking Horse'),(518,'breed','Rheinland Pfalz Saar'),(519,'breed','Rocky Mountain'),(520,'breed','Russian Don'),(521,'breed','Russian Heavy Draft'),(522,'breed','Russian Trakhener'),(523,'breed','Russian Trotter'),(524,'breed','Sanhe'),(525,'breed','Schleswiger Heavy Draft'),(526,'breed','Schwarzwalder Fuchs'),(527,'breed','Selle Francais'),(528,'breed','Shagya'),(529,'breed','Shetland Pony'),(530,'breed','Shire'),(531,'breed','Single-Footing Horse'),(532,'breed','Skyros Pony'),(533,'breed','Somali Pony'),(534,'breed','Sorraia'),(535,'breed','Soviet Heavy Draft'),(536,'breed','Spanish Mustang'),(537,'breed','Spanish-Barb'),(538,'breed','Spanish-Norman'),(539,'breed','Spot Horse of Color'),(540,'breed','Spotted Draft'),(541,'breed','Spotted Mountain Horse'),(542,'breed','Spotted Saddle'),(543,'breed','Standardbred'),(544,'breed','Sudan Country-Bred'),(545,'breed','Suffolk'),(546,'breed','Swedish Warmblood'),(547,'breed','Taishuh'),(548,'breed','Tarpan'),(549,'breed','Tawleed'),(550,'breed','Tennessee Walker'),(551,'breed','Tersk'),(552,'breed','Thessalian'),(553,'breed','Thoroughbred Cross'),(554,'breed','Tiger Horse'),(555,'breed','Tokara'),(556,'breed','Tori'),(557,'breed','Trakehner'),(558,'breed','Ukrainian Saddle'),(559,'breed','Virginia Highlander'),(560,'breed','Vlaamperd'),(561,'breed','Vladimir Heavy Draft'),(562,'breed','Vyatka'),(563,'breed','Walkaloosa'),(564,'breed','Warmblood'),(565,'breed','Warmblood Cross'),(566,'breed','Warmbloods (All)'),(567,'breed','Warmbloods of Color'),(568,'breed','Welara Pony'),(569,'breed','Welsh Cob'),(570,'breed','Welsh Pony'),(571,'breed','West African Barb'),(572,'breed','Western Sudan Pony'),(573,'breed','Westphalian'),(574,'breed','Wielkopolski'),(575,'breed','Xilingol'),(576,'breed','Yakut'),(577,'breed','Yanqi'),(578,'breed','Yili'),(579,'breed','Yonaguni'),(580,'breed','Zangersheide'),(581,'breed','Zaniskari Pony'),(582,'breed','Zhemaichu'),(583,'breed','Zorse'),(624,'location','South'),(625,'location','Southwest'),(626,'location','West'),(627,'location','Alabama'),(628,'location','Alaska'),(629,'location','Alberta, Canada'),(630,'location','American Samoa'),(631,'location','Argentina'),(632,'location','Arizona'),(633,'location','Arkansas'),(634,'location','Belgium'),(635,'location','Bermuda'),(636,'location','Brazil'),(637,'location','British Columbia, Canada'),(638,'location','California'),(639,'location','Colorado'),(640,'location','Connecticut'),(641,'location','Delaware'),(642,'location','Denmark'),(643,'location','District of Columbia'),(644,'location','England'),(645,'location','Federated States of Micronesia'),(646,'location','Florida'),(647,'location','France'),(648,'location','Georgia'),(649,'location','Germany'),(650,'location','Guam'),(651,'location','Hawaii'),(652,'location','Idaho'),(653,'location','Illinois'),(654,'location','Indiana'),(655,'location','Iowa'),(656,'location','Ireland'),(657,'location','Kansas'),(658,'location','Kentucky'),(659,'location','Louisiana'),(660,'location','Maine'),(661,'location','Manitoba, Canada'),(662,'location','Marshall Islands'),(663,'location','Maryland'),(664,'location','Massachusetts'),(665,'location','Mexico'),(666,'location','Michigan'),(667,'location','Minnesota'),(668,'location','Mississippi'),(669,'location','Missouri'),(670,'location','Montana'),(671,'location','Nebraska'),(672,'location','Nevada'),(673,'location','New Brunswick, Canada'),(674,'location','New Hampshire'),(675,'location','New Jersey'),(676,'location','New Mexico'),(677,'location','New York'),(678,'location','New Zealand'),(679,'location','Newfoundland'),(680,'location','Nicaragua'),(681,'location','North Carolina'),(682,'location','North Dakota'),(683,'location','Northern Mariana Islands'),(684,'location','Northwest Territories'),(685,'location','Nova Scotia, Canada'),(686,'location','Nunavut, Canada'),(687,'location','Ohio'),(688,'location','Oklahoma'),(689,'location','Ontario, Canada'),(690,'location','Oregon'),(691,'location','Other Location'),(692,'location','PALAU'),(693,'location','Pennsylvania'),(694,'location','Perth, Australia'),(695,'location','Portugal'),(696,'location','Prince Edward Island, Canada'),(697,'location','Puerto Rico'),(698,'location','Quebec, Canada'),(699,'location','Rhode Island'),(700,'location','Saskatchewan, Canada'),(701,'location','Scotland'),(702,'location','Slovakia'),(703,'location','South Africa'),(704,'location','South Carolina'),(705,'location','South Dakota'),(706,'location','Spain'),(707,'location','Sweden'),(708,'location','Tennesse'),(709,'location','Texas'),(710,'location','The Netherlands'),(711,'location','U.S. Virgin Islands'),(712,'location','Utah'),(713,'location','Vermont'),(714,'location','Victoria, Australia'),(715,'location','Virginia'),(716,'location','Wales'),(717,'location','Washington'),(718,'location','West Virginia'),(719,'location','Wisconsin'),(720,'location','Wyoming'),(721,'location','Yukon Territory, Canada'),(722,'discipline','Beginner/ Family'),(723,'discipline','Breeding'),(724,'discipline','Broodmare'),(725,'discipline','Companion Only'),(726,'discipline','Country Pleasure'),(727,'discipline','Cowboy Mounted Shooting'),(728,'discipline','Draft'),(729,'discipline','Drill Team'),(730,'discipline','Endurance Riding'),(731,'discipline','Equitation'),(732,'discipline','Eventing'),(733,'discipline','Field Hunter'),(734,'discipline','Gaited'),(735,'discipline','Harness'),(736,'discipline','Horsemanship'),(737,'discipline','Hunter'),(738,'discipline','Hunter Under Saddle'),(739,'discipline','Jumper'),(740,'discipline','Lesson Horse'),(741,'discipline','Longe-Line'),(742,'discipline','Not Applicable'),(743,'discipline','Pleasure Driving'),(744,'discipline','Pole Bending'),(745,'discipline','Ranch Horse'),(746,'discipline','Ranch Sorting'),(747,'discipline','Showmanship'),(748,'discipline','Steer Wrestling'),(749,'discipline','Team Penning'),(750,'discipline','Team Roping'),(751,'discipline','Team Sorting'),(752,'discipline','Trail Horse'),(753,'discipline','Vaulting'),(755,'attributes','Any'),(756,'attributes','All-Around Champion'),(757,'attributes','All-Around Reserve Champion'),(758,'attributes','APHA Breeders Trust'),(759,'attributes','Breed Assn Futurity Winner'),(760,'attributes','Breed Assn National Champ'),(761,'attributes','Breed Assn Point Earner'),(762,'attributes','Breed Assn Res National Champ'),(763,'attributes','Breed Assn Res Show Champ'),(764,'attributes','Breed Assn Res World Champ'),(765,'attributes','Breed Assn Show Champ'),(766,'attributes','Breed Assn Top 10 National '),(767,'attributes','Breed Assn Top 10 World'),(768,'attributes','Breed Assn World Champ'),(769,'attributes','Breeders Sweepstakes Enrolled'),(770,'attributes','Breeders Sweepstakes Nominated'),(771,'attributes','Foundation Eligible'),(772,'attributes','Foundation Registered'),(773,'attributes','Futurity Eligible'),(774,'attributes','Futurity Money Earner'),(775,'attributes','Homozygous'),(776,'attributes','HYPP H/H'),(777,'attributes','HYPP N/H'),(778,'attributes','HYPP N/N'),(779,'attributes','Incentive Fund Eligible'),(780,'attributes','Incentive Fund Enrolled'),(781,'attributes','Jackpot Money Earner'),(782,'attributes','KY Incentive Fund'),(783,'attributes','Mare in Foal'),(784,'attributes','Money Earner'),(785,'attributes','NCHA Money Earner'),(786,'attributes','NCHR Breeders Classic'),(787,'attributes','NCHR Stallion Stakes'),(788,'attributes','NCHR Super Stakes'),(789,'attributes','NRHA Derby Champ'),(790,'attributes','NRHA Money Earner'),(791,'attributes','NRHA Open Champ'),(792,'attributes','Open Show Winner'),(793,'attributes','Performance Champ'),(794,'attributes','Race Money Earner'),(795,'attributes','Register of Merit'),(796,'attributes','Rodeo Winner'),(797,'attributes','SHN Payback Enrolled'),(798,'attributes','Sire and Dam Program'),(805,'height','14.0'),(807,'height','15.0'),(808,'list_type',' n/a'),(809,'duration','0060'),(810,'duration','0090'),(811,'location','N/A'),(812,'height','15.1'),(813,'height','15.2'),(814,'height','15.3'),(815,'height','16'),(816,'height','9.0'),(817,'height','9.1'),(820,'discipline','A Champion'),(827,'Sex','Stallion'),(828,'Sex','Mare'),(829,'Sex','Gelding'),(832,'adinfo_public','1'),(833,'adinfo_private','1'),(838,'height','16.5'),(839,'height','17'),(841,'temperament','10'),(842,'height','14.1');
/*!40000 ALTER TABLE `defaults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_blocks`
--

DROP TABLE IF EXISTS `email_blocks`;
CREATE TABLE `email_blocks` (
  `ID` int(11) NOT NULL auto_increment,
  `address` varchar(65) NOT NULL default 'address@doman.com',
  `block_type` varchar(1) NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  KEY `address_index` (`address`),
  KEY `block_type_index` (`block_type`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `email_blocks`
--

LOCK TABLES `email_blocks` WRITE;
/*!40000 ALTER TABLE `email_blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqquestion`
--

DROP TABLE IF EXISTS `faqquestion`;
CREATE TABLE `faqquestion` (
  `quest_id` int(11) NOT NULL auto_increment,
  `sub_id` int(11) default '0',
  `date_created` datetime default NULL,
  `active` tinyint(1) default '1',
  `question` longtext,
  `answer` longtext,
  `name` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `phone` varchar(50) default NULL,
  PRIMARY KEY  (`quest_id`),
  UNIQUE KEY `quest_id` (`quest_id`),
  KEY `sub_id` (`sub_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faqquestion`
--

LOCK TABLES `faqquestion` WRITE;
/*!40000 ALTER TABLE `faqquestion` DISABLE KEYS */;
INSERT INTO `faqquestion` VALUES (14,5,NULL,1,'test question','test answer',NULL,NULL,NULL),(18,5,NULL,1,'i have a question','this is your answer','adopogi2','brian@beyondsolutions.com',NULL),(19,5,NULL,1,'asasasasa','duda','dadads','asdada@sasa.com',NULL),(20,16,NULL,1,'What r they','birds, very tasty birds',NULL,NULL,NULL);
/*!40000 ALTER TABLE `faqquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqsubject`
--

DROP TABLE IF EXISTS `faqsubject`;
CREATE TABLE `faqsubject` (
  `sub_id` int(11) NOT NULL auto_increment,
  `subjects` varchar(100) default NULL,
  PRIMARY KEY  (`sub_id`),
  UNIQUE KEY `sub_id` (`sub_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faqsubject`
--

LOCK TABLES `faqsubject` WRITE;
/*!40000 ALTER TABLE `faqsubject` DISABLE KEYS */;
INSERT INTO `faqsubject` VALUES (5,'support subject'),(13,'another subject'),(14,'asdfads'),(15,'test'),(16,'chickens'),(18,'How does it all work?');
/*!40000 ALTER TABLE `faqsubject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `ID` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `user_id_from` int(11) NOT NULL default '0',
  `date_placed` datetime NOT NULL,
  `rating` smallint(6) NOT NULL default '0',
  `comment` varchar(80) NOT NULL default 'Feedback Comment',
  `itemnum` int(11) NOT NULL default '0',
  `remote_ip` varchar(23) NOT NULL default '127.0.0.1',
  PRIMARY KEY  (`ID`),
  KEY `date_placed_index` (`date_placed`),
  KEY `ID` (`ID`),
  KEY `itemnum` (`itemnum`),
  KEY `rating_index` (`rating`),
  KEY `user_id_from` (`user_id_from`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,961375758,957633228,'2011-05-15 14:26:53',1,'Feedback Comment',989461899,'127.0.0.1'),(2,961375758,957633228,'2011-05-15 14:26:59',1,'Feedback Comment',989461899,'127.0.0.1'),(3,961375758,957633228,'2011-05-15 14:26:53',1,'Feedback Comment',989461899,'127.0.0.1'),(4,961375758,957633228,'2011-05-15 14:26:59',1,'Feedback Comment',989461899,'127.0.0.1');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `futurewatch`
--

DROP TABLE IF EXISTS `futurewatch`;
CREATE TABLE `futurewatch` (
  `ID` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `keywords` varchar(255) NOT NULL default 'Futurewatch Keywords',
  `enabled` tinyint(1) NOT NULL default '0',
  `last_sent` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  KEY `ID` (`ID`),
  KEY `keywords` (`keywords`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `futurewatch`
--

LOCK TABLES `futurewatch` WRITE;
/*!40000 ALTER TABLE `futurewatch` DISABLE KEYS */;
INSERT INTO `futurewatch` VALUES (1,880835450,'volkswagon',1,0),(2,942526421,'saddle,barrel',1,0),(3,991498245,'Mare',1,0),(4,992667247,'mare',1,0),(5,995322690,'Stallion',1,0),(6,993931328,'Stallion Test',1,0),(7,957633228,'camelo',0,0);
/*!40000 ALTER TABLE `futurewatch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `itemnum` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `status` tinyint(1) NOT NULL default '0',
  `date_created` datetime NOT NULL,
  `date_due` datetime NOT NULL,
  `listing` double NOT NULL default '0',
  `fee` double NOT NULL default '0',
  `bold` double NOT NULL default '0',
  `featured` double NOT NULL default '0',
  `featured_cat` double NOT NULL default '0',
  `banner` double NOT NULL default '0',
  `studio` double NOT NULL default '0',
  `featured_studio` double NOT NULL default '0',
  `picture1` double NOT NULL default '0',
  `picture2` double NOT NULL default '0',
  `picture3` double NOT NULL default '0',
  `picture4` double NOT NULL default '0',
  `second_cat` double NOT NULL default '0',
  `reserve_bid` double NOT NULL default '0',
  `late_charge` double NOT NULL default '0',
  `paid` double NOT NULL default '0',
  `reference` varchar(255) NOT NULL default 'Invoice Reference',
  `invoice_total` double NOT NULL default '0',
  `fee_inspector` double default '0',
  `date_exported` datetime default NULL,
  `docnum` varchar(40) default NULL,
  `discount_note` varchar(50) default NULL,
  `archive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`itemnum`),
  UNIQUE KEY `itemnum_index` (`itemnum`),
  KEY `date_due_index` (`date_due`),
  KEY `docnum` (`docnum`),
  KEY `status_index` (`status`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `itemnum` int(11) NOT NULL default '0',
  `status` tinyint(1) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `category` varchar(1) NOT NULL default '',
  `list_title` varchar(255) NOT NULL default '',
  `list_type` varchar(255) NOT NULL default '',
  `category1` int(11) NOT NULL default '-2',
  `category2` int(11) NOT NULL default '-2',
  `auction_type` varchar(1) NOT NULL default 'E',
  `title` varchar(255) NOT NULL default 'Auction Title',
  `name` varchar(255) NOT NULL,
  `weblink` varchar(255) NOT NULL,
  `sire` varchar(255) NOT NULL default 'N/A',
  `dam` varchar(255) NOT NULL default 'N/A',
  `pri_breed` varchar(40) NOT NULL,
  `sec_breed` varchar(40) NOT NULL,
  `bloodline` varchar(255) default NULL,
  `pure_breed` tinyint(1) NOT NULL default '0',
  `registration` varchar(40) NOT NULL,
  `year_foaled` varchar(40) default NULL,
  `color` varchar(40) NOT NULL,
  `dob` datetime NOT NULL,
  `sex` varchar(40) NOT NULL,
  `height` varchar(40) NOT NULL,
  `discipline` varchar(200) NOT NULL,
  `experience` varchar(40) NOT NULL,
  `attributes` varchar(200) NOT NULL,
  `temperament` varchar(40) NOT NULL,
  `ped4` varchar(250) NOT NULL default 'N/A',
  `ped5` varchar(250) NOT NULL default 'N/A',
  `ped6` varchar(250) NOT NULL default 'N/A',
  `ped7` varchar(250) NOT NULL default 'N/A',
  `ped8` varchar(250) NOT NULL default 'N/A',
  `ped9` varchar(250) NOT NULL default 'N/A',
  `ped10` varchar(250) NOT NULL default 'N/A',
  `ped11` varchar(250) NOT NULL default 'N/A',
  `ped12` varchar(250) NOT NULL default 'N/A',
  `ped13` varchar(250) NOT NULL default 'N/A',
  `ped14` varchar(250) NOT NULL default 'N/A',
  `ped15` varchar(250) NOT NULL default 'N/A',
  `nominations` longtext NOT NULL,
  `comments` longtext NOT NULL,
  `performance` longtext NOT NULL,
  `produce` longtext NOT NULL,
  `sire_performance` longtext NOT NULL,
  `dam_performance` longtext NOT NULL,
  `stallion_incentive` longtext NOT NULL,
  `isfoal` varchar(1) NOT NULL,
  `last_bred_date` varchar(40) NOT NULL,
  `regular_fee` double NOT NULL default '0',
  `shipped_semen` varchar(1) NOT NULL,
  `frozen_semen` varchar(1) NOT NULL,
  `shipped_semen_fee` double NOT NULL default '0',
  `intl_shipped_semen_fee` double NOT NULL default '0',
  `counter_fee` double NOT NULL default '0',
  `booking_fee` double NOT NULL default '0',
  `mare_care_fee` double NOT NULL default '0',
  `earnings` double NOT NULL default '0',
  `auction_mode` int(11) default '0',
  `minimum_bid` double NOT NULL default '0',
  `maximum_bid` double NOT NULL default '0',
  `location` varchar(100) NOT NULL default 'Auction Location',
  `dollar_type` varchar(40) default NULL,
  `city` varchar(40) NOT NULL,
  `state` varchar(40) NOT NULL,
  `province` varchar(40) NOT NULL,
  `zipcode` varchar(10) NOT NULL,
  `country` varchar(45) NOT NULL default 'Auction Country',
  `pay_morder_ccheck` tinyint(1) NOT NULL default '0',
  `pay_cod` tinyint(1) NOT NULL default '0',
  `pay_see_desc` tinyint(1) NOT NULL default '0',
  `pay_pcheck` tinyint(1) NOT NULL default '0',
  `pay_ol_escrow` tinyint(1) NOT NULL default '0',
  `pay_other` tinyint(1) NOT NULL default '0',
  `pay_visa_mc` tinyint(1) NOT NULL default '0',
  `pay_am_express` tinyint(1) NOT NULL default '0',
  `pay_discover` tinyint(1) NOT NULL default '0',
  `ship_sell_pays` tinyint(1) NOT NULL default '0',
  `ship_buy_pays_act` tinyint(1) NOT NULL default '0',
  `ship_see_desc` tinyint(1) NOT NULL default '0',
  `ship_buy_pays_fxd` tinyint(1) NOT NULL default '0',
  `ship_international` tinyint(1) NOT NULL default '0',
  `desc_languages` varchar(250) NOT NULL default 'Description Languages',
  `picture` varchar(250) NOT NULL default 'http://',
  `picture1` varchar(250) default '',
  `picture2` varchar(250) default '',
  `picture3` varchar(250) default '',
  `picture4` varchar(250) default '',
  `picture5` varchar(20) NOT NULL default '',
  `picture6` varchar(20) NOT NULL default '',
  `youtube` varchar(500) NOT NULL default '',
  `sound` varchar(250) NOT NULL default 'http://',
  `quantity` smallint(6) NOT NULL default '0',
  `increment` tinyint(1) NOT NULL default '0',
  `increment_valu` double NOT NULL default '1',
  `dynamic` tinyint(1) NOT NULL default '0',
  `dynamic_valu` smallint(6) NOT NULL default '5',
  `reserve_bid` double NOT NULL default '0',
  `bold_title` tinyint(1) NOT NULL default '0',
  `featured` tinyint(1) NOT NULL default '0',
  `featured_cat` tinyint(1) NOT NULL default '0',
  `private` tinyint(1) NOT NULL default '0',
  `banner` tinyint(1) NOT NULL default '0',
  `banner_line` varchar(45) NOT NULL default 'Banner Line',
  `studio` tinyint(1) NOT NULL default '0',
  `featured_studio` tinyint(1) NOT NULL default '0',
  `picture_studio` varchar(250) NOT NULL default 'none.gif',
  `sound_studio` varchar(250) NOT NULL default 'http://',
  `duration` smallint(6) NOT NULL default '0',
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `prequal_start` datetime default NULL,
  `prequal_end` datetime default NULL,
  `billmeth` varchar(2) NOT NULL default 'BM',
  `remote_ip` varchar(24) NOT NULL default '127.0.0.1',
  `hide` tinyint(1) NOT NULL default '0',
  `auto_relist` int(11) NOT NULL default '0',
  `buynow` tinyint(1) default NULL,
  `buynow_price` double default '0',
  `org_quantity` smallint(6) default '0',
  `payment_details` varchar(255) default NULL,
  `shipping_details` varchar(255) default NULL,
  `current_price` double default '0',
  `current_price1` double default NULL,
  `current_price2` double default NULL,
  `current_price3` double default NULL,
  `current_price4` double default NULL,
  `current_price5` double default NULL,
  `current_price6` double default NULL,
  `totalbids` varchar(50) default NULL,
  `totalbids1` varchar(50) default NULL,
  `totalbids2` varchar(50) default NULL,
  `totalbids3` varchar(50) default NULL,
  `totalbids4` varchar(50) default NULL,
  `totalbids5` varchar(50) default NULL,
  `totalbids6` varchar(50) default NULL,
  `seller` varchar(255) default NULL,
  `bulkloader` tinyint(1) default '0',
  `feedback_left` tinyint(1) default '0',
  `hit_counter` int(11) default '0',
  `blocked_list` longtext,
  `lvl_1` int(11) default '0',
  `lvl_2` int(11) default '0',
  `lvl_3` int(11) default '0',
  `lvl_4` int(11) default '0',
  `lvl_5` int(11) default '0',
  `lvl_6` int(11) default '0',
  `lvl_7` int(11) default '0',
  `lvl_8` int(11) default '0',
  `cat2_lvl_1` int(11) default '0',
  `cat2_lvl_2` int(11) default '0',
  `cat2_lvl_3` int(11) default '0',
  `cat2_lvl_4` int(11) default '0',
  `cat2_lvl_5` int(11) default '0',
  `cat2_lvl_6` int(11) default '0',
  `cat2_lvl_7` int(11) default '0',
  `cat2_lvl_8` int(11) default '0',
  `salestax` tinyint(4) default '0',
  `shipping_fee` double default '0',
  `administrative` varchar(10) default NULL,
  `financial` varchar(10) default NULL,
  `premium` varchar(10) default NULL,
  `terms` longtext,
  PRIMARY KEY  (`itemnum`),
  UNIQUE KEY `itemnum_index` (`itemnum`),
  KEY `auction_type` (`auction_type`),
  KEY `cat2_M_1` (`cat2_lvl_1`),
  KEY `cat2_M_2` (`cat2_lvl_2`),
  KEY `cat2_M_3` (`cat2_lvl_3`),
  KEY `cat2_M_4` (`cat2_lvl_4`),
  KEY `cat2_M_5` (`cat2_lvl_5`),
  KEY `cat2_M_6` (`cat2_lvl_6`),
  KEY `cat2_M_7` (`cat2_lvl_7`),
  KEY `cat2_M_8` (`cat2_lvl_8`),
  KEY `category1_index` (`category1`),
  KEY `category2_index` (`category2`),
  KEY `date_end_index` (`date_end`),
  KEY `featured_cat_index` (`featured_cat`),
  KEY `featured_gallery_index` (`featured_studio`),
  KEY `featured_index` (`featured`),
  KEY `gallery_index` (`studio`),
  KEY `itemsquantity` (`quantity`),
  KEY `M_1` (`lvl_1`),
  KEY `M_2` (`lvl_2`),
  KEY `M_3` (`lvl_3`),
  KEY `M_4` (`lvl_4`),
  KEY `M_5` (`lvl_5`),
  KEY `M_6` (`lvl_6`),
  KEY `M_7` (`lvl_7`),
  KEY `M_8` (`lvl_8`),
  KEY `status_index` (`status`),
  KEY `title_index` (`title`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout`
--

DROP TABLE IF EXISTS `layout`;
CREATE TABLE `layout` (
  `id` int(11) NOT NULL auto_increment,
  `logo` varchar(50) default NULL,
  `date_posted` datetime default NULL,
  `studio_logo` varchar(50) default NULL,
  `promotion_logo` varchar(50) default NULL,
  `company_name` varchar(255) default NULL,
  `about_us` longtext,
  `contact_us` longtext,
  `paypal_enable` varchar(50) default NULL,
  `paypal_email` varchar(50) default NULL,
  `linkpoint_enable` varchar(50) default NULL,
  `linkpoint_pem` varchar(50) default NULL,
  `authorize_enable` varchar(50) default NULL,
  `authorize_login` varchar(50) default NULL,
  `authorize_password` varchar(50) default NULL,
  `timezone` varchar(50) default NULL,
  `privacy` longtext,
  `terms` longtext,
  `timechange` smallint(6) default '0',
  `problem_email` varchar(255) default 'problem@',
  `service_email` varchar(255) default 'service@',
  `question_email` varchar(255) default 'question@',
  `LP_REQSTORENAME` varchar(50) default NULL,
  `LP_REQKEYFILE` varchar(255) default 'c:\\\\winnt\\\\system32\\\\',
  `LP_REQHOSTADDR` varchar(255) default 'secure.linkpt.net',
  `featured` tinyint(1) default '1',
  `statistic` tinyint(1) default '1',
  `news` tinyint(1) default '1',
  `promotion` tinyint(1) default '1',
  `tellafriend` tinyint(1) default '1',
  `gallery` tinyint(1) default '1',
  `welcome` tinyint(1) default '1',
  `topseller` tinyint(1) default '1',
  `search_cache` tinyint(1) default '1',
  `listings_cache` tinyint(1) default '1',
  `all_cache` tinyint(1) default '1',
  `homepage_cache` tinyint(1) default '1',
  `hits` tinyint(1) default NULL,
  `hotauctions` tinyint(1) default '1',
  `visitors` tinyint(1) default '0',
  `keywords` longtext,
  `descriptions` longtext,
  `login` tinyint(1) default '1',
  `legend1` varchar(255) default NULL,
  `legend2` varchar(255) default NULL,
  `legend3` varchar(255) default NULL,
  `legend4` varchar(255) default NULL,
  `legend5` varchar(255) default NULL,
  `legend6` varchar(255) default NULL,
  `legend7` varchar(255) default NULL,
  `legend8` varchar(255) default NULL,
  `legend9` varchar(255) default NULL,
  `legend10` varchar(255) default NULL,
  `legend11` varchar(255) default NULL,
  `aboutmeicon` varchar(255) default NULL,
  `bidicon` varchar(255) default NULL,
  `descriptionicon` varchar(255) default NULL,
  `useronline` tinyint(1) default '1',
  `template` int(11) default '0',
  `membershipicon` varchar(50) default NULL,
  `page_layout` int(11) default '0',
  `menu_header_layout` int(11) default '0',
  `heading_style` int(11) default '0',
  `button_style` varchar(20) default NULL,
  `button_font` varchar(20) default NULL,
  `button_size` varchar(20) default NULL,
  `button_color` varchar(20) default NULL,
  `button_hover` varchar(20) default NULL,
  `matching_bgcolor` tinyint(1) default NULL,
  `page_width` int(11) default '0',
  `heading_color` varchar(15) default '6B85B6',
  `heading_fcolor` varchar(15) default 'ffffff',
  `heading_font` varchar(15) default 'Arial',
  `heading_fsize` varchar(15) default '14',
  `link_color` varchar(15) default '4682B4',
  `alink_color` varchar(15) default '80',
  `vlink_color` varchar(15) default '8000',
  `hlink_color` varchar(50) default NULL,
  `bg_color` varchar(15) default 'ffffff',
  `text_color` varchar(15) default '80',
  `text_font` varchar(50) default NULL,
  `listing_bgcolor` varchar(15) default 'EFEFEF',
  `hrsending_color` varchar(15) default '000000',
  `ListingNew` int(11) default '0',
  `SectionImage1` varchar(50) default NULL,
  `SectionImage2` varchar(50) default NULL,
  `SectionImage3` varchar(50) default NULL,
  `SectionImage4` varchar(50) default NULL,
  `SectionImage5` varchar(50) default NULL,
  `SectionImage6` varchar(50) default NULL,
  `SectionImage7` varchar(50) default NULL,
  `SectionImage8` varchar(50) default NULL,
  `SectionImage9` varchar(50) default NULL,
  `Col1Sec1` smallint(6) default '1',
  `Col1Sec2` smallint(6) default '2',
  `Col1Sec3` smallint(6) default '3',
  `Col2Sec1` smallint(6) default '4',
  `Col2Sec2` smallint(6) default '5',
  `Col2Sec3` smallint(6) default '6',
  `Col3Sec1` smallint(6) default '7',
  `Col3Sec2` smallint(6) default '8',
  `Col3Sec3` smallint(6) default '9',
  `PageImage1` varchar(50) default NULL,
  `PageImage2` varchar(50) default NULL,
  `PageImage3` varchar(50) default NULL,
  `PageImage4` varchar(50) default NULL,
  `PageImage5` varchar(50) default NULL,
  `PageImage6` varchar(50) default NULL,
  `PageImage7` varchar(50) default NULL,
  `PageImage8` varchar(50) default NULL,
  `PageImage9` varchar(50) default NULL,
  `main_content` text,
  `side_content` text,
  PRIMARY KEY  (`id`),
  KEY `bid` (`bidicon`),
  KEY `id` (`id`),
  KEY `keywords` (`keywords`(10))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `layout`
--

LOCK TABLES `layout` WRITE;
/*!40000 ALTER TABLE `layout` DISABLE KEYS */;
INSERT INTO `layout` VALUES (1,'IMG_1164.jpg','2003-12-11 08:40:00','7.jpg','1.gif','EQUIBIDZ.COM','Hey I was just checking to see if this thing worked or not.','Contact Us Info Here','No','sales@you.com','no','800217','No','login','password','CST','Privacy Policy','Terms and Conditions\r\n   By registering you agree to the following Terms and Conditions that shall govern this on-line auction: \r\n\r\n1. Bidder Registration \r\nBidders must be 18 years of age or older to register for this auction. Only persons who can enter into legally binding contracts under applicable law may bid. If you are registering as an agent or using a business name, you represent that you have authority to bind same to these Terms and Conditions. \r\nYou are responsible for providing accurate registration information that will be used to identify you to this on-line auction and allow Equibidz, LLC to contact you. Please update any change in your contact information immediately. Any error caused by your failure to do so is not the responsibility of Equibidz, LLC. Your personal information will be protected as stated herein under the Privacy Policy (see #19). Equibidz, LLC reserves the right to approve/disapprove any bidder application. You will be banned from this site if you provide false registration information. \r\n\r\n2. Web Site Information \r\nEvery effort has been made to ensure the correctness of the on-line sale information. Known defects will be stated at listing time. Equibidz, LLC believes the descriptions of horses appearing in this on-line auction and in advertising for this auction are correct. Equibidz, LLC is not responsible for errors or omissions either verbal or written and assume no liability for same regarding horses sold. \r\nEquibidz, LLC is not responsible for the actions of the Owner/Seller and Buyers before, during, and after the on-line auction, typographical errors, misprints, loss of money, damage or failure of equipment, due to visits to this site. Use of this site is at Bidder’s own risk. This on-line auction site contains links to other web sites and Equibidz, LLC is not responsible for their practices or content. \r\nBroodmares listed in foal to the stallion indicated were pregnancy checked within fourteen (14) days prior to the sale. Broodmares listed as exposed to the stallion indicated may or may not be in foal by sale time. All broodmares not in foal are sold as broodmare sound and may be checked by a veterinarian for soundness at Buyer’s expense. \r\nThe Owner/Seller reserves the right to withdraw a lot after being listed if necessary at any time. A lot substitution may be made with the approval of Equibidz, LLC. \r\n\r\n3. Reserve Price \r\nA reserve price is the lowest price at which the lot will be sold however it will not be disclosed to Bidders. When the reserve price has been met it will say “Reserve Price Met” and then the horse will be sold to the highest bidder. If the reserve price is not met the lot will not be sold. \r\n\r\n4. Bidding \r\nAll bids are in US Dollars. All bidding will be done on the Internet by registered and approved Bidders. You are responsible to monitor bidding activity. You will not receive notification if another bidder outbids your bid. While the pages are refreshed automatically you are advised to also refresh the pages on your own. \r\nIt is suggested you bid the maximum amount you are willing to pay for a lot because you may be outbid minutes before the close of the on-line auction and may not be able to enter another bid. When bidding ends, all sales shall be considered final. There are no exchanges or refunds unless there is a statement to the contrary expressed herein. A bid by any person shall be deemed conclusive proof that such person is familiar with the Terms and Conditions as stated herein and that the Bidder agrees to be bound by them. \r\nTransmission time varies and bids are time stamped by the host computer with the time received. Bids must be received by the host computer prior to closeout to be accepted. \r\nBidders acknowledge that this on-line auction is conducted electronically and that Equibidz, LLC and other parties to the on-line auction must therefore rely on hardware and software that may malfunction without warning. In the event of malfunction by the host computer, the on-line auction will be stopped. If the malfunction has not affected the sale prior to the malfunction, the lot will be considered sold. Auction of any remaining lots will be completed upon correction of the malfunction. Bidding on the remaining lots will be open, with no bid positions given until resumption of the auction. Any malfunction by the Bidder’s computer or Internet service provider is not the responsibility of Equibidz, LLC. \r\nIf a bid is the high/winning bid, that Bidder will be obligated to buy the lot at said price indicated. Placing a bid on this auction site, winning, then not paying for the lot is illegal in most states and prosecution can result. \r\nAs a Bidder, you are responsible for any bids placed by you or your representative under your bidding number and password. The security of your Bidder information is your sole responsibility and the Bidder will be responsible for any and all bids placed under the assigned name and/or number. If, at any time, you feel that your Bidder number and password have been compromised due to lack of security on your part, notify Equibidz, LLC immediately. \r\nBidders agree not to interfere or attempt to interfere with the functioning of this auction. Equibidz, LLC reserves the right to void bids believed not to have been made in good faith or are unlawful. A fraudulent bid may result in legal action. \r\n\r\n5. Absentee Bidding \r\nAbsentee bidding means a bidder can enter a maximum bid amount and the auction will automatically bid in their absence, executing their bid for them and trying to keep the bid price as low as possible. A bidder doesn\'t have to watch the auction every minute to make sure they are not outbid. However, when you are the highest bidder and you have been out-bid by another user, you will not receive an email notification so you must monitor the bidding periodically. \r\n\r\n6. Bid Retractions \r\nA submitted bid is non-cancellable. Once a bid is made and confirmed, it cannot be retracted. When a bid is made you manifest your intent and ability to buy the lot at the bid price.',-2,'info@equibidz.com','info@equibidz.com','info@equibidz.com','800217','c:\\\\winnt\\\\system32\\\\','secure.linkpt.net',1,0,1,1,1,1,1,0,0,0,1,0,0,1,1,'equibidz.COM,horse auction, horse for sale, equine, show horse, performance horse, sell horse, buy horse, cutting horse, barrel horse, race horse,low fees, online auction, online horse auction, online equine auction,horse auctioneer, sell','equibidz.com the horse auction site',1,'snakegreen.gif','snakeskinblack.gif','snakeskinblue.gif','snakeskindontknow.gif','snakeskingreen.gif','snakeskinlightblue.gif','snakeskinlime.gif','snakeskinorange.gif','snakeskinpurple.gif','snakeskinpink.gif','snakeskinred.gif','aboutme.gif','icon_bid.gif','icon_description.gif',0,1,'member.gif',1,2,2,'24','cursive','13','ffffff','000000',1,1003,'000000','aaaaaa','arial','52','000000','000000','000000','bb0000','5688b9','0000bb','arial','aaaaaa','bb0000',10,'layoutimages/hot_section.gif','layoutimages/login_section.gif','layoutimages/tellafriend_section.gif','layoutimages/categories_section.gif','layoutimages/featured_section.gif','layoutimages/gallery_section.gif','layoutimages/imageonly.gif','layoutimages/newusers_section.gif','layoutimages/promotions_section.gif',6,7,3,2,5,4,10,9,8,'layoutimages/testimage.gif','layoutimages/no_image.gif','layoutimages/testimage.gif','layoutimages/testimage.gif','layoutimages/no_image.gif','layoutimages/no_image.gif','layoutimages/4.jpg','layoutimages/IMG_0490.JPG','layoutimages/no_image.gif','This website has been developed with horsemen and horsewomen in mind. We want our customers and friends to have a place where they can\r\n									post horses and then have the horses sale with little effort from the seller. Do you have a pasture\r\n									or barn full of horses but no local or affordable sale to take them to, then our website is for you.\r\n									Equibidz allows you to take nice pictures and some video and then simply\r\n								       	<b>LET THE BIDDING BEGIN!</b> There will be no <b>HAULING TO THE SALE, NO SALE ENTRY \r\n                                                                        FEES</b> and finally <b>LESS SALE PREPPING</b>. Equibidz will allow you to use the power of the internet to sell\r\n                                                                        your horses. If at any time you have a problem or need help posting your horse please contact us, we are here to help. \r\n<b>LOOK NO FURTHER - EQUIBIDZ WAS CREATED WITH YOU IN MIND.</b>','<b>EQUIBIDZ IS READY FOR BUSINESS!!!</b> Now for the first month of business we will allow you to post horses to our website\r\n									for $10 for 90 days. Please contact form multiple horse discounts!');
/*!40000 ALTER TABLE `layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loggedin`
--

DROP TABLE IF EXISTS `loggedin`;
CREATE TABLE `loggedin` (
  `ID` int(11) NOT NULL auto_increment,
  `nickname` varchar(255) default NULL,
  `loggedin` tinyint(1) default NULL,
  `date_time` datetime default NULL,
  `remote_ip` varchar(50) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `loggedin`
--

LOCK TABLES `loggedin` WRITE;
/*!40000 ALTER TABLE `loggedin` DISABLE KEYS */;
/*!40000 ALTER TABLE `loggedin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_bal`
--

DROP TABLE IF EXISTS `member_bal`;
CREATE TABLE `member_bal` (
  `trans_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default '0',
  `itemnum` int(11) default '0',
  `date_time` datetime default NULL,
  `descr` varchar(255) default NULL,
  `pmt_credit` double default '0',
  `fee` double default '0',
  `total` double default '0',
  `credit` double default '0',
  PRIMARY KEY  (`trans_id`),
  UNIQUE KEY `trans_id` (`trans_id`),
  KEY `itemnum` (`itemnum`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `member_bal`
--

LOCK TABLES `member_bal` WRITE;
/*!40000 ALTER TABLE `member_bal` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_bal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL default '0',
  `from_user_id` int(11) NOT NULL default '0',
  `message` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL default '0',
  `is_new` tinyint(1) NOT NULL default '0',
  `is_flagged` tinyint(1) NOT NULL default '0',
  `subject` varchar(255) NOT NULL default 'New Subject',
  `to_user_id` int(11) NOT NULL default '0',
  `ref_message_id` int(11) NOT NULL default '0',
  `priority` varchar(10) NOT NULL default '0',
  `when_sent` datetime NOT NULL,
  PRIMARY KEY  (`message_id`),
  UNIQUE KEY `message_id` (`message_id`),
  KEY `from_user_id` (`to_user_id`),
  KEY `ref_message_id` (`ref_message_id`),
  KEY `user_id` (`from_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL auto_increment,
  `news` longtext,
  `date_posted` datetime default NULL,
  `title` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `ID` int(11) NOT NULL auto_increment,
  `itemnum` int(11) NOT NULL default '0',
  `date_posted` datetime NOT NULL,
  `user_id` int(11) NOT NULL default '0',
  `amount` double NOT NULL default '0',
  `reference` varchar(255) NOT NULL default 'Payment Reference',
  `date_exported` datetime default NULL,
  `docnum` varchar(40) default NULL,
  `archive` tinyint(1) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `date_posted_index` (`date_posted`),
  KEY `docNum` (`docnum`),
  KEY `ID` (`ID`),
  KEY `itemnum_index` (`itemnum`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_bids`
--

DROP TABLE IF EXISTS `proxy_bids`;
CREATE TABLE `proxy_bids` (
  `ID` int(11) NOT NULL auto_increment,
  `itemnum` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `time_placed` datetime NOT NULL,
  `bid` double NOT NULL default '0',
  `quantity` smallint(6) NOT NULL default '0',
  `remote_ip` varchar(23) NOT NULL default '127.0.0.1',
  PRIMARY KEY  (`ID`),
  KEY `ID` (`ID`),
  KEY `itemnum_index` (`itemnum`),
  KEY `time_index` (`time_placed`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `proxy_bids`
--

LOCK TABLES `proxy_bids` WRITE;
/*!40000 ALTER TABLE `proxy_bids` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
CREATE TABLE `registration` (
  `ID` int(11) NOT NULL auto_increment,
  `domain` varchar(255) NOT NULL default 'domain.com',
  `reg_key` varchar(50) NOT NULL default '0',
  `company` varchar(50) NOT NULL default 'Company',
  `version` varchar(32) NOT NULL default '0',
  `contact_name` varchar(50) NOT NULL default 'Contact Name',
  `contact_email` varchar(50) NOT NULL default 'Contact Email',
  `contact_phone` varchar(32) NOT NULL default 'Contact Telephone',
  PRIMARY KEY  (`ID`),
  KEY `domain` (`domain`),
  KEY `ID` (`ID`),
  KEY `reg_key` (`reg_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
CREATE TABLE `stats` (
  `id` int(11) NOT NULL auto_increment,
  `auctions` int(11) default '0',
  `categories` int(11) default '0',
  `bids` int(11) default '0',
  `total_auctions` int(11) default '0',
  `hit` int(11) default '0',
  `tracking` int(11) default '0',
  PRIMARY KEY  (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (1,0,3,0,0,3,801);
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `clicklink` tinyint(1) default NULL,
  `clicklink1` tinyint(1) default NULL,
  `clicklink2` tinyint(1) default NULL,
  `clicklink3` tinyint(1) default NULL,
  `clicklink4` tinyint(1) default NULL,
  `clicklink5` tinyint(1) default NULL,
  `clicklink6` tinyint(1) default NULL,
  `default` varchar(50) default NULL,
  `default1` varchar(50) default NULL,
  `default2` varchar(50) default NULL,
  `default3` varchar(50) default NULL,
  `default4` varchar(50) default NULL,
  `default5` varchar(50) default NULL,
  `default6` varchar(50) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stored`
--

DROP TABLE IF EXISTS `stored`;
CREATE TABLE `stored` (
  `ID` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `user_id_from` int(11) NOT NULL default '0',
  `date_placed` datetime NOT NULL,
  `rating` smallint(6) NOT NULL default '0',
  `comment` varchar(80) NOT NULL default 'Feedback Comment',
  `itemnum` int(11) NOT NULL default '0',
  `remote_ip` varchar(23) NOT NULL default '127.0.0.1',
  `seller` tinyint(1) default '0',
  `buyer` tinyint(1) default '0',
  `date_end` datetime default NULL,
  PRIMARY KEY  (`ID`),
  KEY `date_placed_index` (`date_placed`),
  KEY `ID` (`ID`),
  KEY `itemnum` (`itemnum`),
  KEY `rating_index` (`rating`),
  KEY `user_id_from` (`user_id_from`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stored`
--

LOCK TABLES `stored` WRITE;
/*!40000 ALTER TABLE `stored` DISABLE KEYS */;
/*!40000 ALTER TABLE `stored` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracking`
--

DROP TABLE IF EXISTS `tracking`;
CREATE TABLE `tracking` (
  `id` int(11) NOT NULL auto_increment,
  `tracker` varchar(50) NOT NULL,
  `webbrowser` varchar(255) default NULL,
  `referer` longtext,
  `date_time` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1217 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tracking`
--

LOCK TABLES `tracking` WRITE;
/*!40000 ALTER TABLE `tracking` DISABLE KEYS */;
INSERT INTO `tracking` VALUES (416,'76.168.104.195','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) ; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)','','2009-03-01 16:17:15'),(417,'71.105.206.6','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; FunWebProducts; .NET CLR 2.0.50727)','http://us.mc373.mail.yahoo.com/mc/showMessage?fid=Inbox&sort=date&order=down&startMid=0&.rand=1251191401&da=0&midIndex=4&mid=1_4083869_APVav9EAABmFSariQA1M2jof1bI&prevMid=1_4084402_APdav9EAAETdSarupw43e35aFtw&nextMid=1_4083352_APlav9EAAMqlSarGowP7vUClImk&m=1_4085953_APZav9EAAKd8SavnpgJjkDZdgZU,1_4085436_APhav9EAAPR0SavUHAB6Sx1iLJI,1_4084919_APhav9EAAA2LSaubNAXmjUczmHc,1_4084402_APdav9EAAETdSarupw43e35aFtw,1_4083869_APVav9EAABmFSariQA1M2jof1bI,1_4083352_APlav9EAAMqlSarGowP7vUClImk,1_4082720_APlav9EAAHetSaq95wOytwtXtoU,1_4082044_APZav9EAATOUSapxVwCR2SY0hvo,1_4080385_APpav9EAACVySapheAhCBD9cdIk,1_4081279_APtav9EAAMfCSaphnwGUDhnoUF8,','2009-03-02 12:42:02'),(418,'75.51.178.199','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)','','2009-03-04 22:58:38'),(419,'121.1.18.237','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)','','2009-03-08 20:30:36'),(420,'121.1.37.149','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)','http://68.183.144.71:5606/','2009-03-08 21:06:17'),(421,'120.28.131.222','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)','','2009-03-09 01:11:37'),(422,'222.127.38.23','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)','','2009-03-09 01:42:36'),(423,'222.127.191.2','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.1','http://68.183.144.71:5606/admin/login.cfm?failed=2&CFID=92639&CFTOKEN=75364441','2009-03-12 04:35:32'),(424,'121.54.32.97','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)','','2009-03-16 00:18:52'),(425,'222.127.41.6','Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420.1 (KHTML, like Gecko) Version/3.0 Mobile/4A102 Safari/419.3','http://68.183.144.71:5610/admin/login.cfm?failed=2&CFID=94032&CFTOKEN=83715032','2009-03-17 02:06:55'),(426,'68.111.72.40','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7','http://email.secureserver.net/webmail.php?login=1','2009-03-23 21:45:01'),(427,'68.183.144.71','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; InfoPath.2)','http://68.183.144.71:5610/admin/login.cfm?failed=2&CFID=92832&CFTOKEN=74554572','2009-03-25 13:56:06'),(428,'202.57.45.50','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)','','2009-09-26 05:49:39'),(429,'202.69.188.166','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3','','2009-09-26 05:49:47'),(430,'76.90.242.50','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB6; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) ; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)','','2009-10-24 14:32:31'),(431,'71.165.176.40','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; FunWebProducts;  Embedded Web Browser from: http://bsalsa.com/; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; yie8)','','2009-10-30 01:48:17'),(432,'75.200.83.239','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-11-11 16:57:35'),(433,'207.47.211.232','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322)','','2009-11-23 20:40:31'),(434,'68.11.146.43','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.15) Gecko/2009101601 Firefox/3.0.15 (.NET CLR 3.5.30729)','http://heritagespringer.com:2095/horde/imp/view.php?popup_view=1&index=5282&mailbox=INBOX&actionID=view_attach&id=1&mimecache=654b401a5808dd34003fcf0854c82c64','2009-11-24 15:33:02'),(435,'24.226.16.20','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5 (.NET CLR 3.5.30729)','','2009-12-01 14:27:17'),(436,'75.251.83.224','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-03 08:02:08'),(437,'75.250.14.170','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-04 00:35:24'),(438,'75.203.215.29','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-05 03:23:19'),(439,'75.200.12.190','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-09 13:25:17'),(440,'75.201.96.111','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-09 23:16:00'),(441,'209.136.146.112','ColdFusion','','2009-12-10 00:15:49'),(442,'75.248.22.96','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-10 23:04:15'),(443,'75.249.19.165','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-12 04:22:07'),(444,'75.201.24.89','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-12 18:47:47'),(445,'202.147.26.18','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.43 Safari/530.5','','2009-12-15 04:59:49'),(446,'112.201.101.122','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; InfoPath.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)','','2009-12-15 21:56:48'),(447,'124.83.27.88','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091107 Firefox/3.5.5 CometBird/3.5.5','http://209.136.146.112/admin/login.cfm?failed=2&CFID=502511&CFTOKEN=46365084','2009-12-15 21:57:12'),(448,'75.249.172.139','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-16 04:41:48'),(449,'75.248.67.213','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-16 12:27:54'),(450,'121.54.2.4','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.15) Gecko/2009102815 Ubuntu/9.04 (jaunty) Firefox/3.0.15','','2009-12-16 14:16:17'),(451,'124.83.29.79','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091107 Firefox/3.5.5 CometBird/3.5.5','http://209.136.146.112/admin/login.cfm?failed=2&CFID=502511&CFTOKEN=46365084','2009-12-16 22:38:57'),(452,'75.200.132.161','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-17 03:20:12'),(453,'75.250.166.202','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-17 22:57:08'),(454,'124.83.16.137','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091107 Firefox/3.5.5 CometBird/3.5.5','http://209.136.146.112/admin/login.cfm?failed=2&CFID=502511&CFTOKEN=46365084','2009-12-18 00:16:32'),(455,'124.83.28.206','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091107 Firefox/3.5.5 CometBird/3.5.5','','2009-12-18 21:08:52'),(456,'75.201.125.97','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','','2009-12-19 04:36:20'),(457,'207.201.197.25','Opera/9.80 (Windows NT 5.1; U; en) Presto/2.2.15 Version/10.10','','2010-02-03 14:34:30'),(458,'209.12.152.27','ColdFusion','','2010-02-03 20:02:53'),(459,'204.11.25.80','Toata dragostea mea pentru diavola','','2010-02-17 15:36:35'),(460,'93.186.31.208','BlackBerry9000/4.6.0.303 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/245','','2010-02-17 17:28:46'),(461,'208.80.193.42','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; SIMBAR Enabled; (R1 1.3); .NET CLR 1.1.4322)','','2010-02-18 01:58:53'),(462,'208.80.193.32','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; LN; .NET CLR 1.1.4322; InfoPath.1)','','2010-02-19 15:30:18'),(463,'81.141.85.69','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-GB; rv:1.9.2) Gecko/20100115 Firefox/3.6 (.NET CLR 3.5.30729)','http://209.12.152.44/admin/login.cfm?failed=2&CFID=981225&CFTOKEN=37802058','2010-02-20 12:39:49'),(464,'208.80.193.34','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; InfoPath.1; SpamBlockerUtility 4.8.4)','','2010-02-21 04:41:04'),(465,'82.45.221.199','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-GB; rv:1.9.2) Gecko/20100115 Firefox/3.6 (.NET CLR 3.5.30729)','http://209.12.152.44/admin/login.cfm?failed=2&CFID=981225&CFTOKEN=37802058','2010-02-21 08:51:02'),(466,'74.52.245.146','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0','','2010-05-06 11:42:59'),(467,'184.73.125.181','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.1.6; taptu-downloader) Gecko/20070725 Firefox/2.0.0.6','','2010-05-06 18:18:57'),(468,'64.246.165.210','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/visualbarter.com','2010-05-11 05:35:40'),(469,'122.52.97.38','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.04 (lucid) Firefox/3.6.13','','2011-03-01 14:48:38'),(470,'166.137.12.15','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-03-01 16:52:49'),(471,'72.37.171.84','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2; Tablet PC 2.0; MS-RTC LM 8; .NET4.0C)','','2011-03-01 17:24:11'),(472,'203.87.176.250','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.13 (KHTML, like Gecko) Chrome/9.0.597.98 Safari/534.13','http://email10.secureserver.net/webmail.php?login=1','2011-03-01 17:50:51'),(473,'68.222.247.155','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-03-01 19:18:41'),(474,'174.129.117.237','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13','','2011-03-02 00:16:03'),(475,'99.118.90.215','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-03-02 01:51:34'),(476,'72.148.31.116','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; MDDC; .NET4.0C)','','2011-03-02 02:23:05'),(477,'72.30.142.228','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-03-02 08:33:47'),(478,'222.216.28.2','example/1.0','http://g7.in/2871.html','2011-03-02 16:51:30'),(479,'67.195.114.231','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-03-03 05:34:59'),(480,'207.172.118.161','Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-us) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4','','2011-03-03 08:25:01'),(481,'66.249.71.107','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-03-03 22:18:38'),(482,'166.137.9.157','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-03-03 23:22:24'),(483,'87.106.135.77','Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)','','2011-03-06 09:12:09'),(484,'222.216.28.52','example/1.0','http://g7.in/2871.html','2011-03-07 01:32:31'),(485,'123.125.71.23','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:32:19'),(486,'123.125.71.13','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:33:30'),(487,'123.125.71.34','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:33:35'),(488,'123.125.71.21','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:33:41'),(489,'123.125.71.31','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:33:52'),(490,'123.125.71.35','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:34:06'),(491,'123.125.71.28','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:34:09'),(492,'123.125.71.32','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:34:16'),(493,'123.125.71.14','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:34:41'),(494,'123.125.71.16','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:34:44'),(495,'123.125.71.18','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:34:59'),(496,'123.125.71.22','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:35:14'),(497,'123.125.71.25','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:35:20'),(498,'123.125.71.20','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:35:38'),(499,'123.125.71.30','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:35:40'),(500,'123.125.71.33','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:35:47'),(501,'69.28.58.33','Wget/1.9+cvs-stable (Red Hat modified)','','2011-03-07 10:35:48'),(502,'123.125.71.26','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:35:52'),(503,'123.125.71.27','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:35:54'),(504,'123.125.71.29','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:36:07'),(505,'123.125.71.12','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:36:08'),(506,'123.125.71.15','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:36:13'),(507,'123.125.71.17','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:36:32'),(508,'123.125.71.24','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:36:51'),(509,'123.125.71.36','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-07 10:37:01'),(510,'64.185.30.174','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; GTB6.6; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; AskTbFWV5/5.9.1.14019)','','2011-03-07 12:37:52'),(511,'199.80.52.5','Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3','','2011-03-07 21:37:58'),(512,'38.127.197.107','Mozilla/4.0 (compatible; MSIE 7.0;  Windows NT 5.2)','','2011-03-08 08:18:14'),(513,'74.9.106.126','Mozilla/5.0 (iPad; U; CPU OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-03-09 02:32:08'),(514,'195.54.163.122','Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Win 9x 4.90)','http://www.equibidz.com/','2011-03-09 12:36:06'),(515,'66.249.67.58','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-03-09 15:55:28'),(516,'112.204.11.103','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.13 (KHTML, like Gecko) Chrome/9.0.597.107 Safari/534.13','','2011-03-10 00:39:58'),(517,'64.246.187.42','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-03-10 04:42:47'),(518,'195.54.162.34','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 9.0','http://www.equibidz.com/','2011-03-10 12:55:08'),(519,'207.46.195.234','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-03-11 19:16:46'),(520,'111.125.101.101','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15 GTB7.1','http://search.avg.com/dns_err.aspx?i=23&l=en&tp=dns&q=http%3A%2F%2Fwww.equibidz.com%2F&iy=&ychte=ph&al=us&alu=ww&d=4d636d4a','2011-03-12 04:30:26'),(521,'188.233.134.253','Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Win 9x 4.90)','http://www.equibidz.com/','2011-03-12 20:35:05'),(522,'66.249.68.14','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-03-13 02:37:37'),(523,'78.22.171.66','Mozilla/3.0','','2011-03-13 04:08:19'),(524,'12.144.64.99','Mozilla/5.0 (iPad; U; CPU OS 4_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8F191 Safari/6533.18.5','http://www.google.com/search?q=equibidz&ie=UTF-8&oe=UTF-8&hl=en&client=safari','2011-03-15 01:05:55'),(525,'166.137.13.70','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-03-15 16:26:38'),(526,'209.190.3.210','Java/1.6.0_23','','2011-03-16 08:54:58'),(527,'72.94.249.37','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)','','2011-03-17 15:58:14'),(528,'79.142.69.77','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-03-18 19:04:18'),(529,'216.249.252.82','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; GTB6.6; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; eSobiSubscriber 2.0.4.16)','','2011-03-20 22:20:42'),(530,'216.145.11.94','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-03-21 11:19:22'),(531,'123.125.71.113','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-21 14:46:47'),(532,'220.181.108.185','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-03-21 14:47:32'),(533,'115.249.60.162','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15','','2011-03-22 12:45:27'),(534,'64.202.161.41','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.8) Gecko/20100202 Firefox/3.5.8 ( .NET CLR 3.5.30729)','','2011-03-23 11:17:37'),(535,'69.58.178.57','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3; ips-agent) Gecko/20090824 Fedora/1.0.7-1.1.fc4  Firefox/3.5.3','','2011-03-24 02:01:49'),(536,'98.175.131.234','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; GTB6.6; .NET CLR 2.0.50727; .NET CLR 1.1.4322; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET4.0C; .NET4.0E; AskTbDIC2V5/5.9.1.14019)','','2011-03-24 11:17:05'),(537,'150.70.172.107','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','','2011-03-24 11:24:54'),(538,'205.223.0.76','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://www.google.com/m/search?q=www.equibidz.com&mshr=35&popt=1&pbx=1&aq=&oq=www.equibidz.com&aqi=&fkt=4710&fsdt=32758&htf=&his=&csll=&action=&ltoken=5070dccb','2011-03-24 13:26:27'),(539,'121.54.32.156','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)','','2011-03-24 19:27:49'),(540,'89.149.241.201','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15','','2011-03-25 00:24:20'),(541,'66.249.71.23','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-03-25 13:07:13'),(542,'78.159.111.228','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15','','2011-03-25 16:03:53'),(543,'89.149.242.120','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15','','2011-03-26 17:17:24'),(544,'78.159.120.253','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15','','2011-03-27 09:56:56'),(545,'67.195.110.159','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-03-28 08:32:01'),(546,'80.90.43.208','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.16) Gecko/20110319 Firefox/3.6.16','','2011-03-28 14:11:17'),(547,'65.52.110.82','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-03-28 16:12:11'),(548,'166.137.11.164','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-03-28 17:01:05'),(549,'66.249.68.23','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-03-29 11:48:05'),(550,'92.48.109.94','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.16) Gecko/20110319 Firefox/3.6.16','http://www.equibidz.com/','2011-03-29 16:04:09'),(551,'222.216.28.93','example/1.0','http://g7.in/3893.html','2011-03-29 20:36:17'),(552,'112.205.8.170','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16','http://www.equibidz.com/','2011-03-30 20:18:41'),(553,'97.74.215.26','ColdFusion','','2011-03-31 12:08:58'),(554,'166.137.15.183','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://equibidz.com/index.cfm','2011-03-31 19:42:40'),(555,'12.177.253.250','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://equibidz.com/','2011-04-01 11:51:13'),(556,'79.142.69.78','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-04-03 05:48:55'),(557,'72.159.2.254','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16','http://www.equibidz.com/','2011-04-04 15:10:38'),(558,'121.97.99.221','Mozilla/5.0 (Windows NT 6.1; rv:2.0) Gecko/20100101 Firefox/4.0','http://www.equibidz.com/','2011-04-06 02:56:56'),(559,'203.87.152.6','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16','http://equibidz.com/','2011-04-11 18:53:02'),(560,'67.195.115.108','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-04-12 06:55:32'),(561,'112.206.148.54','Mozilla/5.0 (Windows NT 6.1; rv:2.0) Gecko/20100101 Firefox/4.0','http://www.equibidz.com/','2011-04-12 15:42:29'),(562,'38.127.197.103','Mozilla/4.0 (compatible; MSIE 7.0;  Windows NT 5.2)','http://www.equibidz.com/','2011-04-15 13:23:05'),(563,'69.58.178.56','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3; ips-agent) Gecko/20090824 Fedora/1.0.7-1.1.fc4  Firefox/3.5.3','','2011-04-16 15:30:12'),(564,'65.52.110.30','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-04-16 17:56:16'),(565,'67.195.111.153','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-04-17 03:43:12'),(566,'207.46.204.232','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-04-17 05:18:51'),(567,'69.73.11.134','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://equibidz.com/index.cfm','2011-04-17 15:12:44'),(568,'120.28.64.75','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/531.0 (KHTML, like Gecko) Chrome/3.0.190.1 Safari/531.0','http://www.equibidz.com/','2011-04-18 12:33:33'),(569,'166.137.12.77','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8G4 Safari/6533.18.5','http://www.equibidz.com/stallions.cfm','2011-04-18 15:13:41'),(570,'166.137.11.168','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://equibidz.com/index.cfm','2011-04-18 15:37:41'),(571,'112.205.39.22','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16','http://www.equibidz.com/','2011-04-18 17:50:26'),(572,'12.50.238.34','Mozilla/5.0 (iPad; U; CPU OS 4_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8F191 Safari/6533.18.5','http://equibidz.com/','2011-04-19 00:54:39'),(573,'112.206.155.82','Mozilla/5.0 (Windows NT 6.1; rv:2.0) Gecko/20100101 Firefox/4.0','http://www.equibidz.com/','2011-04-19 14:32:25'),(574,'123.125.71.101','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-04-19 23:06:07'),(575,'66.249.72.130','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-04-20 14:28:38'),(576,'112.198.78.102','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.23 Safari/533.4','http://equibidz.com/','2011-04-21 19:38:06'),(577,'207.46.199.45','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-04-21 20:33:50'),(578,'123.125.71.97','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-04-22 21:40:50'),(579,'123.125.71.103','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-04-23 20:59:43'),(580,'112.205.59.191','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16','http://www.equibidz.com/','2011-04-24 21:11:03'),(581,'123.125.71.114','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-04-24 23:02:24'),(582,'123.125.71.108','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-04-24 23:10:04'),(583,'123.125.71.111','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-04-25 01:15:12'),(584,'180.191.107.13','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.16) Gecko/20110319 Firefox/3.6.16','http://www.google.com.ph/url?sa=t&source=web&cd=7&ved=0CEwQFjAG&url=http%3A%2F%2Fequibidz.com%2Fhelp%2F&rct=j&q=how%20much%20are%20they%20paying%20on%20%22beyond%20solutions%20inc%22&ei=efG0TdCRMYHwvwP11YWYBw&usg=AFQjCNGe-y8uGSlpymY_lPRXPjuJdtIEOg&cad=rja','2011-04-25 02:00:25'),(585,'123.125.71.102','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-04-25 04:12:45'),(586,'207.46.199.40','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-04-25 07:49:52'),(587,'166.137.8.18','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://equibidz.com/','2011-04-25 11:06:50'),(588,'66.196.119.20','Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; MALC)','http://babelfish.yahoo.com/translate_url_load?lp=en_ja&trurl=http%3A%2F%2Fequibidz.com%2Fsearch%2F&sig=PsI6UGZ2cQM229yVkkAdwA--','2011-04-26 16:08:13'),(589,'66.196.119.21','Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; MALC) (via babelfish.yahoo.com)','http://66.196.80.202/babelfish/translate_url_content?.intl=us&lp=en_ja&trurl=http%3A%2F%2Fequibidz.com%2Fsearch%2F','2011-04-26 16:08:57'),(590,'66.249.72.183','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-04-26 16:12:41'),(591,'92.248.142.147','Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 6.0)','http://www.equibidz.com/','2011-04-27 15:26:02'),(592,'66.249.72.151','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-04-27 19:36:03'),(593,'112.206.159.150','Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','','2011-04-29 14:39:21'),(594,'110.54.168.234','Mozilla/5.0 (Windows NT 5.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','','2011-04-29 18:32:05'),(595,'166.137.13.177','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-04-30 18:35:16'),(596,'109.230.217.147','Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Win 9x 4.90)','http://equibidz.com/','2011-05-01 05:01:47'),(597,'207.46.195.227','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-02 17:43:17'),(598,'207.46.195.204','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;  SV1;  .NET CLR 1.1.4325;  .NET CLR 2.0.50727;  .NET CLR 3.0.30729;  .NET CLR 3.5.30707;  MS-RTC LM 8)','','2011-05-02 21:12:04'),(599,'70.189.202.119','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.17) Gecko/20110420 Firefox/3.6.17 ( .NET CLR 3.5.30729; .NET4.0C)','http://www.google.com/url?sa=t&source=web&cd=1&ved=0CBYQFjAA&url=http%3A%2F%2Fequibidz.com%2F&rct=j&q=equibidz.com&ei=6HDATcuLHq6y0QHQtdCiBQ&usg=AFQjCNFJJjmg0Doe9iVD4PXgJKYA_v85SA','2011-05-03 19:17:35'),(600,'112.205.82.39','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.60 Safari/534.24','','2011-05-03 20:13:04'),(601,'166.137.11.58','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-05-03 21:40:28'),(602,'207.46.204.180','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-04 05:53:17'),(603,'75.184.43.161','Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)','http://www.google.com/','2011-05-04 18:58:04'),(604,'123.125.71.98','Baiduspider+(+http://www.baidu.com/search/spider.htm)','','2011-05-05 06:53:33'),(605,'157.55.17.104','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-05 07:54:18'),(606,'120.28.64.78','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110420 Firefox/3.6.17','','2011-05-05 19:41:52'),(607,'112.205.90.128','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.60 Safari/534.24','','2011-05-06 18:14:46'),(608,'182.18.230.161','Mozilla/5.0 (Windows NT 5.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','','2011-05-06 19:35:39'),(609,'65.52.110.45','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-06 19:39:08'),(610,'112.204.12.218','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.60 Safari/534.24','','2011-05-06 19:56:01'),(611,'112.206.144.177','Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','','2011-05-06 20:43:13'),(612,'195.54.163.28','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; ru) Opera 8.01','http://www.equibidz.com/','2011-05-07 03:17:32'),(613,'207.46.204.233','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-09 06:18:47'),(614,'203.87.176.23','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.65 Safari/534.24','http://email06.secureserver.net/webmail.php?login=1','2011-05-09 09:29:59'),(615,'166.137.9.21','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-05-09 21:06:49'),(616,'166.137.11.173','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8G4 Safari/6533.18.5','http://www.equibidz.com/registration/','2011-05-10 18:40:04'),(617,'66.249.68.40','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-05-10 20:42:07'),(618,'64.53.200.117','Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)','','2011-05-11 06:02:48'),(619,'128.91.252.157','','','2011-05-11 07:54:59'),(620,'123.125.71.110','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-11 09:24:55'),(621,'123.125.71.96','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-11 09:25:15'),(622,'123.125.71.115','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-11 09:25:21'),(623,'123.125.71.117','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-11 09:25:25'),(624,'83.223.118.170','Mozilla/5.0 (compatible; ReactionEngine/V3.0; +http://www.reactionengine.com/robot)','','2011-05-11 10:49:01'),(625,'128.30.52.70','W3C_Validator/1.2','','2011-05-11 10:49:05'),(626,'216.18.209.44','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101213 HeartRails_Capture/1.0.4 (+http://capture.heartrails.com/) Namoroka/3.6.13','','2011-05-11 10:49:55'),(627,'128.30.52.71','W3C_Validator/1.2','','2011-05-11 23:06:06'),(628,'128.30.52.165','W3C_Validator/1.2','','2011-05-11 23:07:02'),(629,'143.89.190.35','Mozilla/5.0 (Windows NT 6.0) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.60 Safari/534.24','','2011-05-12 02:24:28'),(630,'207.46.204.243','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-12 09:31:38'),(631,'112.206.137.170','Mozilla/5.0 (Windows NT 6.1; rv:2.0) Gecko/20100101 Firefox/4.0','','2011-05-12 11:03:20'),(632,'203.177.101.236','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13','','2011-05-12 23:15:22'),(633,'121.54.2.87','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2)','','2011-05-15 01:18:21'),(634,'123.125.71.116','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-15 03:37:53'),(635,'112.206.146.217','Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','','2011-05-16 14:33:17'),(636,'166.137.9.231','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-05-16 16:21:35'),(637,'166.137.8.240','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-05-16 16:39:20'),(638,'166.137.11.175','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://equibidz.com/listings/details/index.cfm?itemnum=989461899&curr_cat=S&curr_lvl=0','2011-05-16 19:56:56'),(639,'207.46.13.45','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-17 02:59:19'),(640,'123.125.71.112','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-17 08:38:39'),(641,'123.125.71.109','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-17 08:39:00'),(642,'166.137.11.84','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-05-17 11:56:27'),(643,'119.63.196.51','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-17 14:42:14'),(644,'166.137.11.143','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-05-18 10:49:37'),(645,'123.125.71.105','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-19 09:26:33'),(646,'65.52.110.26','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-19 15:07:09'),(647,'173.160.52.13','Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; en-us) AppleWebKit/533.21.1 (KHTML, like Gecko) Version/5.0.5 Safari/533.21.1','http://www.google.com/url?sa=t&source=web&cd=2&sqi=2&ved=0CCYQFjAB&url=http%3A%2F%2Fequibidz.com%2Flistings%2Ffeatured%2Findex2.cfm%3Fsortby%3Dtitle_desc&rct=j&q=%22Visual%20Auction%20Copyright%22&ei=VYDVTY66J4zdsgaCq4GcBw&usg=AFQjCNFQfxRvBdDAVW3dXhGRXzMzOeC3zQ&sig2=qhJqCBROwMBHRA7RoTKcRw','2011-05-19 18:40:57'),(648,'66.249.67.219','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-05-19 23:36:06'),(649,'64.121.18.17','Mozilla/5.0 (iPad; U; CPU OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J3 Safari/6533.18.5','','2011-05-21 00:42:44'),(650,'123.125.71.99','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-21 05:20:54'),(651,'207.46.12.240','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-21 11:23:47'),(652,'123.125.71.104','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-22 23:21:59'),(653,'66.249.67.90','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-05-24 01:13:58'),(654,'65.52.110.46','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-24 01:44:17'),(655,'112.205.96.0','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.68 Safari/534.24','','2011-05-24 09:21:27'),(656,'65.52.110.92','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-24 21:52:48'),(657,'12.182.106.130','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-05-25 01:48:05'),(658,'66.249.67.140','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-05-25 04:50:11'),(659,'166.137.10.215','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-05-25 17:15:05'),(660,'166.137.14.55','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://equibidz.com/registration/findpassword.cfm','2011-05-26 00:33:42'),(661,'207.46.204.189','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-27 09:03:49'),(662,'66.249.67.84','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-05-27 22:26:42'),(663,'66.249.67.236','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-05-28 10:06:52'),(664,'66.249.71.136','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-05-28 10:29:20'),(665,'207.46.204.196','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-05-29 04:25:58'),(666,'123.125.71.106','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-05-29 09:37:09'),(667,'112.205.47.229','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.71 Safari/534.24','','2011-05-29 09:57:38'),(668,'64.246.165.50','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-05-30 19:26:36'),(669,'147.251.43.20','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.1.8) Gecko/20100202 Firefox/3.5.8','','2011-05-31 20:14:52'),(670,'65.52.108.59','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-01 11:42:46'),(671,'76.73.165.11','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','','2011-06-01 13:36:44'),(672,'67.195.112.115','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-06-01 17:46:12'),(673,'209.59.96.38','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)','http://www.google.com.ag/','2011-06-01 22:24:26'),(674,'123.125.71.94','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-02 10:01:16'),(675,'123.125.71.107','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-02 10:01:30'),(676,'66.249.72.212','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-02 14:31:59'),(677,'50.16.154.48','WWW-Mechanize/1.66','','2011-06-03 19:54:43'),(678,'112.206.150.244','Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','','2011-06-03 22:15:54'),(679,'123.125.71.100','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-04 09:43:48'),(680,'188.143.232.40','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-06-04 17:44:09'),(681,'65.52.110.74','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-05 09:37:12'),(682,'207.46.204.235','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-05 10:34:11'),(683,'94.142.133.188','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.1','http://equibidz.com/support/faqsubmit.cfm','2011-06-05 12:55:21'),(684,'184.168.152.136','','','2011-06-07 01:53:05'),(685,'216.18.209.28','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110515 HeartRails_Capture/1.0.4 (+http://capture.heartrails.com/) Namoroka/3.6.17','','2011-06-07 01:53:10'),(686,'67.195.112.84','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-06-08 00:59:22'),(687,'72.94.249.38','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)','','2011-06-08 01:34:12'),(688,'166.137.8.162','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-06-08 20:08:17'),(689,'207.46.195.229','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-08 21:13:09'),(690,'66.249.68.37','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-08 22:31:43'),(691,'65.52.110.44','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-09 08:52:13'),(692,'94.142.130.97','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-06-09 13:46:46'),(693,'66.249.67.187','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-09 15:20:28'),(694,'184.73.94.212','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 GTB6 (.NET CLR 3.5.30729)','','2011-06-09 18:05:42'),(695,'93.116.234.101','Java/1.6.0_24','','2011-06-10 03:47:46'),(696,'98.173.63.206','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 1.1.4322; InfoPath.2; InfoPath.1)','','2011-06-10 16:26:38'),(697,'207.46.204.195','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-12 06:20:12'),(698,'208.90.245.161','Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.91 Safari/534.30','http://www.google.com/url?sa=D&q=http://www.equibidz.com/&usg=AFQjCNFsMttk-G6JQ8JfFOYapbwB0Ix74Q','2011-06-13 03:16:14'),(699,'119.63.196.44','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-13 12:12:39'),(700,'166.137.8.14','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-06-13 16:38:38'),(701,'166.137.10.35','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-06-13 20:00:20'),(702,'166.137.12.5','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-06-13 23:34:02'),(703,'119.63.196.112','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-14 01:03:11'),(704,'119.63.196.104','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-14 01:10:09'),(705,'119.63.196.17','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-14 01:16:55'),(706,'119.63.196.14','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-14 01:24:49'),(707,'119.63.196.40','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-14 01:45:34'),(708,'119.63.196.109','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-14 02:08:04'),(709,'207.46.13.41','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-14 12:11:01'),(710,'41.190.89.69','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.0.10) Gecko/2009042316 Firefox/3.0.10','http://www.google.com.gh/search?hl=en&safe=active&client=firefox-a&rls=org.mozilla:en-US:official&noj=1&sa=X&ei=Aqj3TfuLKdSzhAegsfiHDA&ved=0CBMQBSgA&q=equibidz.com&spell=1&biw=1366&bih=497','2011-06-14 16:27:37'),(711,'74.125.16.3','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.14 (KHTML, like Gecko; Google Web Preview) Chrome/9.0.597 Safari/534.14','','2011-06-14 16:29:07'),(712,'119.63.196.88','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-15 02:17:51'),(713,'66.249.72.110','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-15 11:05:56'),(714,'66.249.72.48','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-15 11:05:58'),(715,'207.46.199.215','msnbot-media/1.1 (+http://search.msn.com/msnbot.htm)','','2011-06-15 11:59:00'),(716,'166.137.13.50','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-06-15 16:48:00'),(717,'119.63.196.115','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-16 02:12:13'),(718,'66.249.67.114','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-16 02:59:19'),(719,'207.46.199.52','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-16 13:27:26'),(720,'119.63.196.76','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-17 02:10:11'),(721,'66.249.68.78','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-17 09:06:25'),(722,'66.249.68.140','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-17 10:42:52'),(723,'99.118.89.221','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','http://www.equibidz.com/listings/index.cfm?curr_cat=S&curr_lvl=0','2011-06-17 13:56:08'),(724,'112.204.5.104','Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','','2011-06-17 21:37:58'),(725,'69.171.224.251','facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)','','2011-06-18 01:03:19'),(726,'76.106.147.127','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; GTB7.0; chromeframe/12.0.742.100; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.30618; .NET CLR 3.5.30729; .NET4.0C; XF_mmhpset)','','2011-06-18 01:40:57'),(727,'119.63.196.91','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-18 02:19:32'),(728,'64.134.147.58','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://www.equibidz.com/admin/login.cfm','2011-06-18 15:05:41'),(729,'119.63.196.119','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-18 19:18:32'),(730,'119.63.196.80','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-19 17:51:44'),(731,'119.63.196.84','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-19 19:13:18'),(732,'69.58.178.59','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3; ips-agent) Gecko/20090824 Fedora/1.0.7-1.1.fc4  Firefox/3.5.3','','2011-06-20 02:15:55'),(733,'119.63.196.107','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-20 18:20:12'),(734,'188.138.91.67','','','2011-06-21 20:24:29'),(735,'128.30.52.65','W3C_Validator/1.2','','2011-06-22 01:03:28'),(736,'123.125.71.95','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-22 01:09:50'),(737,'207.46.13.43','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-22 02:32:40'),(738,'207.46.13.145','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-22 09:17:57'),(739,'65.52.110.36','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-22 10:01:27'),(740,'166.137.8.68','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','','2011-06-22 13:07:33'),(741,'119.63.196.46','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-22 19:13:07'),(742,'119.63.196.87','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-23 19:19:16'),(743,'64.246.165.180','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-06-23 22:25:37'),(744,'207.46.12.237','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-23 22:52:04'),(745,'188.229.88.103','','','2011-06-24 09:08:29'),(746,'112.205.96.195','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.100 Safari/534.30','','2011-06-24 16:29:10'),(747,'65.52.110.52','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-25 12:37:42'),(748,'119.63.196.103','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-25 19:11:49'),(749,'112.205.105.20','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.100 Safari/534.30','','2011-06-25 20:02:15'),(750,'166.137.10.203','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','http://www.equibidz.com/listings/details/index.cfm?itemnum=992872772&curr_cat=S&curr_lvl=0&fromList=0','2011-06-26 06:42:49'),(751,'207.46.199.250','msnbot-media/1.1 (+http://search.msn.com/msnbot.htm)','','2011-06-26 10:36:22'),(752,'119.63.196.15','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-26 19:09:36'),(753,'38.100.21.21','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.2)','','2011-06-27 01:15:40'),(754,'207.46.199.47','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-28 14:33:42'),(755,'65.52.110.23','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-28 15:28:11'),(756,'119.63.196.117','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-28 19:07:05'),(757,'46.4.95.200','Opera/9.64 (X11; Linux x86_64; U; en-GB) Presto/2.1.1','http://www.text-link-ads.com/?ref=310762','2011-06-29 04:00:24'),(758,'66.249.71.206','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-06-29 04:47:46'),(759,'96.31.166.228','Mozilla/5.0 (compatible; Search17Bot/1.1; http://www.search17.com/bot.php)','','2011-06-29 08:02:43'),(760,'119.63.196.90','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-29 19:08:06'),(761,'66.249.85.2','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.24 (KHTML, like Gecko; Google Web Preview) Chrome/11.0.696 Safari/534.24','','2011-06-30 06:49:57'),(762,'74.125.64.83','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.24 (KHTML, like Gecko; Google Web Preview) Chrome/11.0.696 Safari/534.24','','2011-06-30 06:50:03'),(763,'74.125.46.85','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.24 (KHTML, like Gecko; Google Web Preview) Chrome/11.0.696 Safari/534.24','','2011-06-30 06:50:08'),(764,'65.52.110.17','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-06-30 12:51:01'),(765,'119.63.196.11','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-30 13:49:46'),(766,'119.63.196.118','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-06-30 19:18:16'),(767,'83.103.212.248','Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)','','2011-06-30 23:47:15'),(768,'119.63.196.110','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-01 14:31:16'),(769,'166.137.11.27','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','http://www.equibidz.com/listings/index.cfm?gencat=S&curr_cat=S&curr_lvl=0&from_search=0','2011-07-01 15:31:04'),(770,'119.63.196.74','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-01 19:14:00'),(771,'188.138.113.145','Mozilla/5.0 (Windows; U; Windows NT 6.0; en; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.8 (.NET CLR 3.5.30729)','','2011-07-01 22:11:07'),(772,'119.63.196.27','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-02 11:00:01'),(773,'65.52.110.47','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-02 12:48:57'),(774,'98.89.181.107','Mozilla/5.0 (iPad; U; CPU OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','http://www.google.com/url?sa=t&source=web&cd=2&sqi=2&ved=0CCQQFjAB&url=http%3A%2F%2Fequibidz.com%2Fregistration%2Fuser_agreement.cfm&rct=j&q=bidz%20offers%20made%20if%20reserve%20is%20not%20met&ei=X-EPTqaHIpCbtwew2NHjDQ&usg=AFQjCNGgpUzzX-QDPhh416P0MKpscdK4MA','2011-07-02 18:26:53'),(775,'119.63.196.42','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-02 19:18:57'),(776,'207.46.199.39','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-04 06:33:57'),(777,'119.63.196.13','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-04 18:42:08'),(778,'119.63.196.108','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-04 19:11:18'),(779,'119.63.196.105','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-05 10:23:35'),(780,'38.100.21.15','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.2)','','2011-07-05 15:29:05'),(781,'112.205.58.190','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30','','2011-07-06 02:25:18'),(782,'119.63.196.38','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-06 10:42:02'),(783,'173.51.255.169','Mozilla/Nutch-1.2 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.11)','','2011-07-06 11:54:27'),(784,'119.63.196.111','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-06 19:55:16'),(785,'119.63.196.79','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-07 07:30:32'),(786,'80.140.110.45','Mozilla/5.0 (Windows NT 6.0; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','http://www.google.de/imgres?imgurl=http://equibidz.com/fullsize_thumbs/992872772.jpg&imgrefurl=http://equibidz.com/listings/index.cfm%3Fcurr_cat%3DS%26curr_lvl%3D0&usg=__hsKpmQL2Ah52nBZrKctKCaycJdc=&h=1587&w=2268&sz=657&hl=de&start=104&sig2=eymHQxa0MFz4eXPWWsfLUg&zoom=1&tbnid=o1ZFMmS_5mhlsM:&tbnh=146&tbnw=198&ei=sQMWTta6HcTLswbV4-CYDw&prev=/search%3Fq%3DKabarda%2Bhorse%26um%3D1%26hl%3Dde%26sa%3DN%26rlz%3D1B3GGIC_de___DE377%26biw%3D1280%26bih%3D618%26tbm%3Disch&um=1&itbs=1&iact=hc&vpx=871&vpy=234&dur=1673&hovh=188&hovw=268&tx=161&ty=76&page=7&ndsp=18&ved=1t:429,r:4,s:104','2011-07-07 10:07:35'),(787,'166.137.11.222','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-07-07 17:11:43'),(788,'119.63.196.21','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-07 18:36:03'),(789,'119.63.196.86','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-07 19:18:09'),(790,'207.46.13.99','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-08 08:03:57'),(791,'66.249.68.69','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-07-08 09:16:37'),(792,'207.46.204.230','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-08 14:58:12'),(793,'119.63.196.113','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-08 18:34:13'),(794,'207.46.199.50','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-08 18:39:07'),(795,'119.63.196.83','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-08 19:09:44'),(796,'66.249.71.179','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-07-09 00:17:09'),(797,'119.63.196.23','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-10 03:29:05'),(798,'119.63.196.73','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-10 11:16:30'),(799,'119.63.196.56','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-10 19:10:52'),(800,'119.63.196.10','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-11 02:05:59'),(801,'119.63.196.81','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-11 07:45:39'),(802,'119.63.196.50','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-11 12:45:14'),(803,'207.46.13.51','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-11 17:15:12'),(804,'119.63.196.18','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-11 17:41:42'),(805,'119.63.196.114','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-11 19:15:27'),(806,'119.63.196.24','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-12 00:21:49'),(807,'119.63.196.52','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-12 02:41:13'),(808,'119.63.196.41','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-12 04:55:53'),(809,'119.63.196.82','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-12 07:05:17'),(810,'89.149.242.189','Mozilla/4.0 (compatible; Synapse)','','2011-07-12 07:16:16'),(811,'119.63.196.39','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-12 09:19:29'),(812,'46.4.120.7','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)','','2011-07-12 17:24:15'),(813,'119.63.196.49','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-12 18:16:28'),(814,'119.63.196.55','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-12 19:17:11'),(815,'119.63.196.45','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-13 01:00:28'),(816,'119.63.196.53','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-13 03:16:33'),(817,'119.63.196.48','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-13 10:42:36'),(818,'119.63.196.47','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-13 15:23:15'),(819,'119.63.196.26','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-13 17:42:25'),(820,'119.63.196.12','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-13 22:10:12'),(821,'119.63.196.54','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-14 00:08:10'),(822,'119.63.196.120','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-14 08:01:01'),(823,'119.63.196.9','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-14 09:58:36'),(824,'65.52.110.13','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-14 14:18:35'),(825,'112.198.132.49','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30','','2011-07-14 16:17:14'),(826,'69.171.224.249','facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)','','2011-07-14 16:24:44'),(827,'166.137.11.48','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-07-14 18:45:52'),(828,'65.52.108.145','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-14 19:15:57'),(829,'119.63.196.78','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-14 19:30:43'),(830,'65.52.110.87','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-14 21:37:57'),(831,'112.198.133.217','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','','2011-07-15 11:43:24'),(832,'112.205.80.84','Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0','','2011-07-15 14:40:04'),(833,'119.63.196.57','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-15 17:05:50'),(834,'119.63.196.85','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-16 03:21:23'),(835,'119.63.196.77','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-16 18:13:32'),(836,'119.63.196.89','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-16 19:27:52'),(837,'98.221.139.240','Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)','http://www.google.com/url?sa=t&source=web&cd=7&ved=0CHIQFjAG&url=http%3A%2F%2Fequibidz.com%2Fregistration%2Fuser_agreement.cfm&rct=j&q=equi%20bids&ei=PHgjTo7mO6f10gGb1JnMAw&usg=AFQjCNGgpUzzX-QDPhh416P0MKpscdK4MA','2011-07-17 15:03:22'),(838,'91.214.45.223','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-07-17 15:09:43'),(839,'109.73.68.18','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-07-17 16:47:20'),(840,'207.46.195.231','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-17 23:39:05'),(841,'83.103.212.245','Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)','','2011-07-18 03:07:40'),(842,'87.152.33.254','Mozilla/5.0 (Windows NT 6.1; rv:5.0) Gecko/20100101 Firefox/5.0','http://www.google.de/imgres?imgurl=http://equibidz.com/fullsize_thumbs/990989164.jpg&imgrefurl=http://equibidz.com/listings/index.cfm%3Fcurr_cat%3DS%26curr_lvl%3D0&usg=__8dWs8XatItWOEaTHGcODYPuK9Mw=&h=300&w=402&sz=57&hl=de&start=131&zoom=1&tbnid=htduwereki2R5M:&tbnh=165&tbnw=220&ei=tikkTvfUFNGq-AbSx-S3Aw&prev=/search%3Fq%3Dquarter%2Bhorse%2Bchestnut%26hl%3Dde%26safe%3Dstrict%26biw%3D1272%26bih%3D882%26gbv%3D2%26tbm%3Disch&itbs=1&iact=rc&dur=250&page=7&ndsp=20&ved=1t:429,r:3,s:131&tx=136&ty=142&biw=1272&bih=882','2011-07-18 03:41:23'),(843,'222.127.223.70','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','','2011-07-18 11:42:25'),(844,'112.206.140.87','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','','2011-07-18 14:18:27'),(845,'64.246.165.160','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-07-18 19:39:47'),(846,'112.198.133.175','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','','2011-07-19 11:34:29'),(847,'119.63.196.43','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-19 11:49:16'),(848,'184.168.152.134','','','2011-07-20 05:26:24'),(849,'184.168.152.137','','','2011-07-20 06:06:57'),(850,'119.63.196.106','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-20 07:42:47'),(851,'119.63.196.25','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-20 11:08:42'),(852,'222.127.223.71','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','','2011-07-20 12:31:48'),(853,'66.249.68.167','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-07-20 13:42:38'),(854,'119.63.196.22','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-20 17:53:10'),(855,'66.249.68.90','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-07-20 20:05:59'),(856,'173.242.116.112','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705; .NET CLR 1.1.4322)','http://equibidz.com/support/faqsubmit.cfm','2011-07-20 22:19:59'),(857,'66.249.72.168','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-07-21 02:35:58'),(858,'65.52.104.82','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-21 05:47:26'),(859,'109.73.78.98','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)','','2011-07-21 12:20:37'),(860,'65.52.6.168','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)','','2011-07-21 13:48:16'),(861,'207.46.204.239','msnbot/2.0b (+http://search.msn.com/msnbot.htm)','','2011-07-21 13:50:55'),(862,'66.249.68.241','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-07-21 20:15:58'),(863,'222.127.223.75','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','http://www.equibidz.com/admin/login.cfm?failed=2&CFID=17248574&CFTOKEN=27569181','2011-07-22 00:08:04'),(864,'119.63.196.75','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-22 01:12:35'),(865,'180.190.1.180','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','http://www.equibidz.com/terms.cfm','2011-07-22 03:27:58'),(866,'69.71.222.186','','http://www.sitedossier.com/site/equibidz.com','2011-07-22 03:47:56'),(867,'66.249.71.215','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-07-22 15:25:08'),(868,'64.202.161.47','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.8) Gecko/20100202 Firefox/3.5.8 ( .NET CLR 3.5.30729)','','2011-07-23 02:48:09'),(869,'119.63.196.121','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-23 14:22:19'),(870,'65.52.109.16','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-24 04:03:56'),(871,'119.63.196.102','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-24 07:04:59'),(872,'112.205.101.70','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','','2011-07-25 06:34:09'),(873,'112.198.141.94','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','http://www.facebook.com/l.php?u=http%3A%2F%2Fwww.equibidz.com%2F&h=-AQC0z-ce','2011-07-25 17:57:42'),(874,'66.220.146.248','facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)','','2011-07-25 17:57:43'),(875,'65.52.110.56','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-25 21:28:57'),(876,'65.52.108.191','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-27 01:20:56'),(877,'119.63.196.19','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-07-27 07:22:14'),(878,'69.58.178.58','BlackBerry9000/4.6.0.167 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/102 ips-agent','','2011-07-27 09:57:30'),(879,'157.55.17.103','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-27 20:59:21'),(880,'180.190.4.9','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','','2011-07-28 04:57:34'),(881,'112.206.135.217','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0','','2011-07-28 06:15:42'),(882,'69.247.8.49','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; FunWebProducts; GTB6.5; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)','','2011-07-28 17:10:42'),(883,'67.195.112.175','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-07-28 17:14:01'),(884,'107.20.6.152','Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)','','2011-07-28 18:38:14'),(885,'69.245.25.131','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30','','2011-07-29 10:28:23'),(886,'65.52.109.18','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-29 20:12:26'),(887,'157.55.16.57','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-30 04:12:26'),(888,'64.246.165.170','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-07-31 09:12:39'),(889,'91.217.90.68','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1)','','2011-07-31 12:11:34'),(890,'112.205.127.157','','','2011-07-31 15:01:47'),(891,'207.46.199.37','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-31 20:49:49'),(892,'207.46.204.193','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-07-31 21:13:20'),(893,'184.168.152.135','','','2011-08-01 01:23:18'),(894,'207.46.204.181','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-02 06:39:56'),(895,'112.205.54.97','','','2011-08-02 13:00:13'),(896,'24.162.211.103','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; GTB6.6; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; InfoPath.1; .NET4.0C; .NET CLR 3.0.30729)','http://www.google.com/url?sa=t&source=web&cd=2&ved=0CBsQFjAB&url=http%3A%2F%2Fequibidz.com%2Fregistration%2Fuser_agreement.cfm&rct=j&q=EQUIBIDZ&ei=NaI4Ts_eCpCctwfS2uzqAg&usg=AFQjCNGgpUzzX-QDPhh416P0MKpscdK4MA','2011-08-02 16:19:52'),(897,'109.230.220.240','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-03 00:52:10'),(898,'65.52.110.190','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-04 08:43:50'),(899,'46.73.48.4','Opera/9.25 (Windows NT 4.0; U; en)','','2011-08-06 05:45:12'),(900,'65.52.110.48','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-06 07:41:57'),(901,'46.21.144.176','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-08 01:07:57'),(902,'112.198.136.247','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.107 Safari/535.1','','2011-08-08 15:48:57'),(903,'112.205.102.246','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.107 Safari/535.1','','2011-08-08 16:22:07'),(904,'109.230.217.91','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-08 21:49:07'),(905,'46.21.144.52','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-08 21:54:55'),(906,'46.21.144.51','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-08 21:58:20'),(907,'178.204.9.186','Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906','','2011-08-09 02:35:23'),(908,'112.206.131.141','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0','','2011-08-09 06:19:35'),(909,'38.100.21.12','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.2)','','2011-08-09 08:00:58'),(910,'112.205.33.160','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.107 Safari/535.1','','2011-08-09 13:20:21'),(911,'95.220.166.19','Mozilla/5.4 (X11; U; Linux )686; en-UR; rv:1.¸*1.2) Gecko/20061201 Fi2efox/2.0.0.2','','2011-08-09 15:10:30'),(912,'112.198.134.50','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1','','2011-08-10 13:20:50'),(913,'66.249.67.199','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-08-10 15:48:32'),(914,'94.100.25.42','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-10 17:43:53'),(915,'114.139.39.52','MOziLlq/5.0 (X11; U; Lynuø i686; en-US; rv:1.8.1) Gecko/20061010 Firefox/2.0','','2011-08-11 03:36:20'),(916,'1.56.210.37','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020919','','2011-08-11 05:13:35'),(917,'112.237.76.239','Opera/8.52 (X11; Linux i686; U; en)','','2011-08-11 06:40:14'),(918,'114.91.19.217','Opera/8.52 (X11; Linux i686; U; en)','','2011-08-11 06:40:14'),(919,'114.47.10.85','Lynx/2.8.5rel.1 libwen-US/2.14 Sen-US/1.4.1 OpenSSL/0.9.7l','','2011-08-11 07:51:49'),(920,'111.176.64.48','Lynx/2.8.5rel.1 libwen-US/2.14 Sen-US/1.4.1 OpenSSL/0.9.7l','','2011-08-11 07:52:05'),(921,'118.124.124.47','Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 5.1; .NET CLR 1.1.4322; InfoPath.1; .NET CLR 2.0.50727)','','2011-08-11 08:59:11'),(922,'89.149.241.175','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-11 11:07:59'),(923,'193.105.210.91','Mozilla/5.0 (compatible; Konqueror/3.3) KHTML/3.3.2 (like Gecko)','','2011-08-11 12:14:25'),(924,'66.249.68.119','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-08-11 16:40:28'),(925,'65.52.110.53','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-12 21:35:27'),(926,'64.246.165.190','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-08-13 03:54:13'),(927,'113.132.59.137','Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.13) Gecko/20060414','','2011-08-14 07:48:45'),(928,'114.94.90.110','Mozilla\'5.0 (X11; U; Linux i686; en-UQ; rv:1n8.1.10) Gecko/20071203 Ubuntu/7.10 (gutsy) Firefox/2.0.0.10','','2011-08-14 08:49:09'),(929,'114.41.227.64','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217','','2011-08-14 09:46:57'),(930,'113.125.220.94','Lynx/2.8.5rel.1 libwen-US/2.14FM','','2011-08-14 10:46:41'),(931,'115.152.233.174','Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1','','2011-08-14 11:44:34'),(932,'67.195.115.111','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-08-14 12:30:43'),(933,'89.200.139.205','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.60 Safari/534.24','','2011-08-14 17:25:41'),(934,'207.46.204.192','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-15 00:59:20'),(935,'65.52.104.83','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-15 10:25:29'),(936,'113.120.136.209','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20040406','','2011-08-15 12:26:08'),(937,'178.238.134.125','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1','','2011-08-15 13:25:05'),(938,'118.125.26.36','Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.8) Gecko/20071022 Ubuntu/7.10 (gutsy) Firefox/2.0.0.8','','2011-08-15 13:29:36'),(939,'118.120.239.101','Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.8) Gecko/20071022 Ubuntu/7.10 (gutsy) Firefox/2.0.0.8','','2011-08-15 13:29:37'),(940,'99.240.166.175','Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; en-us) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27','http://www.google.ca/url?sa=t&source=web&cd=1&ved=0CBcQFjAA&url=http%3A%2F%2Fequibidz.com%2Flistings%2Ffeatured%2Findex2.cfm%3Fsortby%3Ddate_desc&rct=j&q=equibidz&ei=tKJJTt-XAq2ksQKMnvm3CA&usg=AFQjCNEX7_ZI5Mjl1CcmkEI0CLtxWL8qOw&sig2=dnwyEeVzwrINKU2rMASp3Q','2011-08-15 13:50:31'),(941,'118.169.135.237','Mozilla/5.0 (Photon; U; QNX x86pc; en-US; rv:1.6) Gecko/20040429','','2011-08-15 14:38:54'),(942,'125.58.158.180','Opera/9.01 (Windows NT 5.1; U; en)','','2011-08-15 15:50:10'),(943,'115.193.30.46','Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.2) Gecko/20870317 Firefox/2n0.0.2','','2011-08-15 17:08:44'),(944,'66.249.68.46','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-08-16 07:49:33'),(945,'112.206.132.128','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1','','2011-08-16 09:17:18'),(946,'66.249.67.204','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-08-16 20:18:40'),(947,'178.239.58.142','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-17 23:51:48'),(948,'65.52.110.35','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-18 01:38:48'),(949,'119.63.196.116','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-18 21:09:44'),(950,'85.17.31.132','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0.1) Gecko/20100101 Firefox/5.0.1','http://www.myspace.com/','2011-08-19 04:19:30'),(951,'112.205.54.154','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1','','2011-08-19 15:42:45'),(952,'178.162.61.78','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-20 14:08:54'),(953,'157.55.16.220','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-20 14:31:16'),(954,'119.63.196.16','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-20 20:16:53'),(955,'67.195.115.55','Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)','','2011-08-22 06:18:18'),(956,'71.2.245.3','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; GTB6.3; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C)','http://www.google.com/imgres?imgurl=http://www.equibidz.com/fullsize_thumbs2/989446481.jpg&imgrefurl=http://www.equibidz.com/listings/details/index.cfm%3Fitemnum%3D989446481%26curr_cat%3D989490587%26curr_lvl%3D1%26fromList%3D0&usg=__83-tUrUEuvnX54y20iuSamng-h4=&h=201&w=251&sz=11&hl=en&start=9&zoom=1&tbnid=mgqBtLBVXu30BM:&tbnh=123&tbnw=154&ei=hLpTTryCN4Hc0QHywuT0BQ&prev=/search%3Fq%3Dthoroughbred%26tbnh%3D121%26tbnw%3D155%26hl%3Den%26gbv%3D2%26biw%3D1366%26bih%3D561%26tbs%3Dsimg:CAQSEgnSVn8sLy587SFsqkDZ7QGHUA%26tbm%3Disch&itbs=1&iact=rc&dur=328&page=1&ved=1t:429,r:8,s:0&tx=91&ty=76','2011-08-23 05:35:00'),(957,'112.206.155.65','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20100101 Firefox/6.0','','2011-08-23 10:00:54'),(958,'203.87.152.24','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20100101 Firefox/6.0','','2011-08-23 14:03:51'),(959,'166.137.15.125','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','','2011-08-23 14:16:19'),(960,'150.70.64.193','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','','2011-08-23 14:50:24'),(961,'119.63.196.20','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-23 22:40:54'),(962,'150.70.75.36','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','','2011-08-24 01:22:37'),(963,'166.137.11.210','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','','2011-08-24 13:54:17'),(964,'184.73.4.81','Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)','','2011-08-24 22:04:21'),(965,'123.125.71.49','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-25 04:12:22'),(966,'123.125.71.48','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-25 04:12:28'),(967,'123.125.71.52','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-25 04:12:31'),(968,'123.125.71.44','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-25 04:12:34'),(969,'69.108.152.123','Mozilla/5.0 (Windows NT 5.1; rv:6.0) Gecko/20100101 Firefox/6.0','','2011-08-25 12:27:02'),(970,'66.249.68.214','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-08-25 14:11:32'),(971,'216.104.15.142','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','','2011-08-26 03:39:43'),(972,'216.104.15.138','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','','2011-08-26 03:47:22'),(973,'112.205.98.29','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.215 Safari/535.1','','2011-08-26 13:22:06'),(974,'123.125.71.39','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-27 02:45:29'),(975,'157.55.17.146','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-08-29 01:25:59'),(976,'188.143.232.20','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-29 07:54:58'),(977,'123.125.71.46','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-29 19:09:26'),(978,'188.143.232.10','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-29 22:56:08'),(979,'31.184.236.11','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)','http://equibidz.com/support/faqsubmit.cfm','2011-08-30 02:08:00'),(980,'188.143.232.53','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-30 16:38:05'),(981,'123.125.71.47','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-08-30 19:13:17'),(982,'188.92.75.82','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-08-31 01:55:37'),(983,'178.204.123.252','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2;)','','2011-09-01 02:02:48'),(984,'66.249.67.143','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-09-01 02:08:32'),(985,'31.184.236.32','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-09-01 03:32:19'),(986,'74.92.81.101','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; CMDTDF)','','2011-09-01 03:39:08'),(987,'66.249.67.100','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-09-01 04:11:28'),(988,'188.138.84.125','Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Win 9x4.90)','','2011-09-01 08:13:52'),(989,'166.137.11.151','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','','2011-09-01 11:12:53'),(990,'178.205.38.228','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/4.0.206.1 Safari/532.0','','2011-09-01 12:28:27'),(991,'120.29.89.136','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.21) Gecko/20110830 Firefox/3.6.21','','2011-09-01 15:28:29'),(992,'207.172.123.74','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_1) AppleWebKit/534.48.3 (KHTML, like Gecko) Version/5.1 Safari/534.48.3','','2011-09-01 15:35:39'),(993,'166.137.11.148','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','','2011-09-01 15:59:37'),(994,'65.52.108.67','Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)','','2011-09-01 17:17:01'),(995,'180.76.5.61','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-01 23:50:59'),(996,'180.76.5.23','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 00:47:32'),(997,'180.76.5.180','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 01:08:30'),(998,'180.76.5.55','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 01:25:51'),(999,'180.76.5.170','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 02:15:42'),(1000,'180.76.5.162','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 02:31:19'),(1001,'166.137.8.106','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','','2011-09-02 03:49:27'),(1002,'178.205.23.231','','','2011-09-02 13:13:43'),(1003,'180.76.5.111','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 15:52:20'),(1004,'180.76.5.63','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 16:04:41'),(1005,'180.76.5.165','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 16:15:59'),(1006,'180.76.5.171','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 16:43:26'),(1007,'180.76.5.164','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 16:51:54'),(1008,'180.76.5.103','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 17:37:14'),(1009,'180.76.5.94','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 17:58:16'),(1010,'180.76.5.14','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 18:02:15'),(1011,'180.76.5.17','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 18:27:12'),(1012,'180.76.5.51','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 18:55:25'),(1013,'180.76.5.142','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 19:10:50'),(1014,'180.76.5.144','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 19:20:33'),(1015,'180.76.5.19','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 19:45:56'),(1016,'180.76.5.195','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 20:11:05'),(1017,'180.76.5.183','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 20:36:46'),(1018,'180.76.5.27','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 21:05:49'),(1019,'180.76.5.146','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 21:06:04'),(1020,'180.76.5.56','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 21:26:38'),(1021,'180.76.5.52','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 21:31:44'),(1022,'180.76.5.91','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 21:47:28'),(1023,'180.76.5.101','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 21:57:10'),(1024,'180.76.5.145','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 22:34:29'),(1025,'180.76.5.194','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 23:05:16'),(1026,'180.76.5.67','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 23:20:02'),(1027,'180.76.5.176','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-02 23:33:37'),(1028,'180.76.5.21','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 00:57:11'),(1029,'180.76.5.191','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 01:11:45'),(1030,'180.76.5.58','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 02:21:45'),(1031,'180.76.5.168','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 02:31:15'),(1032,'180.76.5.87','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 04:18:34'),(1033,'180.76.5.188','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 06:52:05'),(1034,'180.76.5.64','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 07:37:02'),(1035,'180.76.5.137','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 08:09:49'),(1036,'180.76.5.97','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 08:48:53'),(1037,'180.76.5.138','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 09:39:07'),(1038,'180.76.5.172','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 09:58:20'),(1039,'180.76.5.25','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 10:53:36'),(1040,'180.76.5.197','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 11:13:34'),(1041,'180.76.5.160','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 11:34:14'),(1042,'180.76.5.161','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 12:20:10'),(1043,'180.76.5.92','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 13:26:09'),(1044,'180.76.5.143','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 13:42:02'),(1045,'180.76.5.167','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 14:36:05'),(1046,'180.76.5.18','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 16:33:59'),(1047,'180.76.5.163','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 16:52:11'),(1048,'180.76.5.100','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 17:24:10'),(1049,'180.76.5.178','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 17:34:21'),(1050,'180.76.5.196','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 17:44:03'),(1051,'180.76.5.186','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 18:01:25'),(1052,'180.76.5.20','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 18:23:37'),(1053,'180.76.5.24','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 18:27:44'),(1054,'180.76.5.136','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 18:40:29'),(1055,'180.76.5.62','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 19:10:20'),(1056,'180.76.5.147','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 19:32:33'),(1057,'180.76.5.49','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 19:36:56'),(1058,'180.76.5.177','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 19:39:51'),(1059,'180.76.5.60','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 19:56:23'),(1060,'180.76.5.54','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 19:59:19'),(1061,'180.76.5.13','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 20:11:33'),(1062,'180.76.5.187','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 20:17:27'),(1063,'180.76.5.151','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 20:31:45'),(1064,'180.76.5.139','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 20:38:31'),(1065,'180.76.5.113','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 21:18:53'),(1066,'180.76.5.98','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 22:05:51'),(1067,'180.76.5.99','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 22:20:28'),(1068,'178.205.26.3','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27','','2011-09-03 22:43:39'),(1069,'180.76.5.89','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 22:47:25'),(1070,'180.76.5.153','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 23:00:26'),(1071,'180.76.5.150','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 23:07:16'),(1072,'180.76.5.93','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 23:18:05'),(1073,'180.76.5.148','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 23:49:37'),(1074,'180.76.5.141','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-03 23:53:47'),(1075,'180.76.5.192','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 00:14:38'),(1076,'180.76.5.175','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 00:35:05'),(1077,'180.76.5.158','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 00:42:18'),(1078,'180.76.5.10','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 00:52:10'),(1079,'180.76.5.90','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 00:56:08'),(1080,'180.76.5.193','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 01:00:39'),(1081,'180.76.5.107','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 01:20:12'),(1082,'180.76.5.22','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 01:44:07'),(1083,'180.76.5.184','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 02:44:19'),(1084,'123.125.71.45','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 02:59:11'),(1085,'180.76.5.96','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 03:26:57'),(1086,'180.76.5.140','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 04:10:58'),(1087,'180.76.5.8','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 04:25:48'),(1088,'180.76.5.26','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 05:32:39'),(1089,'180.76.5.179','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 06:19:40'),(1090,'180.76.5.173','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 07:58:27'),(1091,'180.76.5.185','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 08:29:27'),(1092,'180.76.5.16','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 08:58:07'),(1093,'180.76.5.110','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 09:04:22'),(1094,'178.205.6.237','Mozilla/5.0 (Windows; U; WinNT4.0; fr-FR; rv:1.0.0) Gecko/20020530','','2011-09-04 09:08:52'),(1095,'180.76.5.95','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 10:37:26'),(1096,'180.76.5.149','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 14:34:27'),(1097,'180.76.5.88','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 17:51:10'),(1098,'180.76.5.166','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 18:07:17'),(1099,'180.76.5.159','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-04 23:24:15'),(1100,'178.204.116.158','Mozilla/5.0 (compatible; Konqueror/3.0-rc5; i686 Linux; 20020910)','','2011-09-05 09:57:38'),(1101,'98.139.241.248','Opera/9.80 (Android; Opera Mini/6.1.25577/25.823; U; en) Presto/2.5.25 Version/10.54','','2011-09-05 10:35:27'),(1102,'95.108.156.251','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','','2011-09-05 12:16:56'),(1103,'180.76.5.65','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-05 17:12:58'),(1104,'180.76.5.157','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-05 17:25:49'),(1105,'178.204.30.109','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; Trident/4.0; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; OfficeLiveConnector.1.4; OfficeLivePatch.1.3; GreenBrowser)','','2011-09-05 17:37:10'),(1106,'180.76.5.53','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-05 18:04:26'),(1107,'180.76.5.15','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-05 18:17:09'),(1108,'180.76.5.59','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-05 22:02:14'),(1109,'180.76.5.7','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-05 22:19:51'),(1110,'180.76.5.50','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-05 22:48:59'),(1111,'180.76.5.189','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-05 23:34:07'),(1112,'92.126.33.4','Opera/8.00 (Windows NT 5.1; U; en)','http://equibidz.com/support/faqsubmit.cfm','2011-09-06 00:13:35'),(1113,'180.76.5.66','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-06 00:29:44'),(1114,'180.76.5.11','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-06 00:45:12'),(1115,'180.76.5.12','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-06 01:44:42'),(1116,'216.104.15.130','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','','2011-09-06 03:18:43'),(1117,'180.76.5.169','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-06 05:06:50'),(1118,'180.76.5.154','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-06 06:17:47'),(1119,'112.206.128.140','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.1) Gecko/20100101 Firefox/6.0.1','http://www.google.com.ph/url?sa=t&source=web&cd=1&ved=0CBYQFjAA&url=http%3A%2F%2Fequibidz.com%2F&rct=j&q=equibidz.com&ei=sUxmTpydBsOQiAf_upW9Cg&usg=AFQjCNFJJjmg0Doe9iVD4PXgJKYA_v85SA&sig2=svjnEgqB-_fn7D92dXNrWw','2011-09-06 07:39:15'),(1120,'180.76.5.182','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-06 08:43:03'),(1121,'166.137.10.112','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','http://www.equibidz.com/login.cfm?login=1&path=/advertise/index.cfm&CFID=10415441&CFTOKEN=16243101','2011-09-06 10:01:44'),(1122,'180.76.5.57','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-06 12:15:00'),(1123,'71.199.246.200','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.21) Gecko/20110830 Firefox/3.6.21 ( .NET CLR 3.5.30729; .NET4.0C)','','2011-09-06 12:30:55'),(1124,'180.76.5.155','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-06 14:26:21'),(1125,'193.105.210.46','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-09-06 14:44:56'),(1126,'178.205.41.222','Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.9) Gecko/20071025 Firefox/2.0.0.9','','2011-09-06 18:15:46'),(1127,'166.137.10.134','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','','2011-09-06 18:37:56'),(1128,'112.203.72.38','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1','http://www.google.com.ph/url?sa=t&source=web&cd=2&sqi=2&ved=0CCAQFjAB&url=http%3A%2F%2Fequibidz.com%2Flistings%2FStudio.cfm%3Ffeatured%3DTRUE%26%2F&rct=j&q=EQUIBIDZ.COM&ei=EgNnTuCSObDJmAX5roi5DA&usg=AFQjCNHoCoSzuwr_6ugK41A54ocb7TtEkA','2011-09-06 20:37:38'),(1129,'180.76.5.48','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-07 06:15:22'),(1130,'180.76.5.190','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-07 07:31:02'),(1131,'66.249.72.6','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-09-07 14:09:29'),(1132,'178.205.42.50','Mozilla/5.0 (macintosh; U; PPC mac OS X; en) AppleWebKit/103u (KHTML, like Gecko) Safari/100','','2011-09-07 17:31:45'),(1133,'180.76.5.156','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-07 21:38:45'),(1134,'180.76.5.181','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-07 21:45:38'),(1135,'38.100.21.19','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.2)','','2011-09-08 00:48:10'),(1136,'216.145.5.42','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-09-08 01:28:41'),(1137,'184.107.155.35','Wget/1.11.4 Red Hat modified','','2011-09-08 04:42:56'),(1138,'178.204.118.155','Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.9.2b5) Gecko/20091204 Firefox/3.6b5','','2011-09-08 04:54:57'),(1139,'112.205.35.108','','','2011-09-08 06:12:58'),(1140,'94.181.168.5','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; MyIE2; Deepnet Explorer)','http://equibidz.com/support/faqsubmit.cfm','2011-09-08 13:08:58'),(1141,'94.142.134.246','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-09-08 18:50:44'),(1142,'96.126.120.25','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:5.0.1) Gecko/20100101 Firefox/5.0.1','','2011-09-08 20:35:44'),(1143,'204.236.219.103','Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_1; en-us) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10','http://www.google.com/','2011-09-09 00:11:20'),(1144,'98.139.241.251','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-09-09 00:50:36'),(1145,'178.204.91.73','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2; Lunascape 6.3.2.22803)','','2011-09-09 03:55:49'),(1146,'94.181.134.148','Mozilla/4.0 (compatible; MSIE 5.0; Windows 2000) Opera 6.0 [en]','http://equibidz.com/support/faqsubmit.cfm','2011-09-09 13:01:02'),(1147,'123.125.71.60','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-09 20:28:08'),(1148,'178.204.99.18','Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/528.11 (KHTML, like Gecko) Chrome/2.0.157.0 Safari/528.11','','2011-09-10 04:21:58'),(1149,'178.205.25.86','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; BTT V3.0)','','2011-09-10 08:27:53'),(1150,'193.105.210.185','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-09-10 14:43:17'),(1151,'31.131.140.212','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; TheFreeDictionary.com; .NET CLR 1.1.4322; .NET CLR 1.0.3705; .NET CLR 2.0.50727)','http://equibidz.com/support/faqsubmit.cfm','2011-09-10 15:26:32'),(1152,'87.242.64.22','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4','http://equibidz.com/support/faqsubmit.cfm','2011-09-10 23:15:06'),(1153,'188.138.116.151','Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Win 9x4.90)','','2011-09-11 05:16:41'),(1154,'178.205.42.110','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; sbcydsl 3.12)','','2011-09-11 08:37:33'),(1155,'166.248.67.142','Mozilla/5.0 (iPad; U; CPU OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','http://equibidz.com/listings/index.cfm?curr_cat=S&curr_lvl=0','2011-09-11 12:21:54'),(1156,'12.150.238.197','Mozilla/5.0 (iPad; U; CPU OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5','','2011-09-11 17:06:30'),(1157,'169.228.66.68','Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)','','2011-09-12 02:49:57'),(1158,'178.205.26.180','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Q312468)','','2011-09-12 09:21:49'),(1159,'169.228.66.66','Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)','','2011-09-12 13:31:07'),(1160,'166.248.64.202','Mozilla/5.0 (Windows NT 6.0; rv:2.0.1) Gecko/20100101 Firefox/4.0.1','http://www.equibidz.com/admin/login.cfm?failed=1&CFID=108274&CFTOKEN=88889910','2011-09-12 14:51:01'),(1161,'64.202.160.161','','','2011-09-12 19:33:35'),(1162,'123.125.71.58','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-12 19:43:35'),(1163,'112.206.150.120','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20100101 Firefox/6.0.2','','2011-09-13 10:47:56'),(1164,'166.137.12.246','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','http://www.google.com/search?q=eguibidz.com&ie=UTF-8&oe=UTF-8&hl=en&client=safari','2011-09-13 11:26:26'),(1165,'66.249.71.106','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-09-13 14:38:00'),(1166,'203.82.92.50','Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1','http://www.google.com.my/imgres?q=Anglo-Kabarda&hl=en&gbv=2&biw=1024&bih=634&tbs=isz:l&tbm=isch&tbnid=o1ZFMmS_5mhlsM:&imgrefurl=http://equibidz.com/listings/details/index.cfm%3Fcurr_cat%3D991700311%26curr_lvl%3D1%26fromList%3D0%26itemnum%3D992872772&docid=qUDrgECypo2l_M&itg=1&w=2268&h=1587&ei=IQ9wTq-lKc_QrQfgkaXyBg&zoom=1&iact=hc&vpx=290&vpy=143&dur=2761&hovh=188&hovw=268&tx=174&ty=69&page=1&tbnh=114&tbnw=152&start=0&ndsp=16&ved=1t:429,r:1,s:0','2011-09-13 17:19:27'),(1167,'99.247.94.108','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; EasyBits GO v1.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2; Zune 4.0; .NET4.0C; OfficeLiveConnector.1.5; OfficeLivePatch.1.3)','http://www.google.ca/','2011-09-13 21:02:00'),(1168,'64.202.161.177','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.7) Gecko/20091221 Firefox/3.5.7 (.NET CLR 3.5.30729)','','2011-09-14 07:46:43'),(1169,'141.0.9.59','Opera/9.80 (Windows NT 6.1; U; en) Presto/2.9.168 Version/11.50','','2011-09-14 14:04:39'),(1170,'27.110.243.226','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1','','2011-09-14 14:37:11'),(1171,'99.227.242.167','Mozilla/5.0 (Linux; U; Android 2.2; en-ca; GT-P1000M Build/FROYO) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1','http://www.google.com/m/search?q=equibidz&mshr=33&msbs=2&mscq=&mscm=&popt=1&pbx=1&aq=&oq=equibidz&aqi=&fkt=12121&fsdt=35525&cqt=32381&rst=32542&htf=&his=&maction=&source=android-home&client=ms-android-samsung&csll=&action=&ltoken=4fe95894','2011-09-15 05:56:14'),(1172,'141.0.9.4','Opera/9.80 (J2ME/MIDP; Opera Mini/6.1.25378/25.858; U; es) Presto/2.5.25 Version/10.54','http://www.google.com/m/search?client=ms-opera-mini&channel=new&sa=2&q=bidz.com+xxx&site=universal','2011-09-17 02:22:08'),(1173,'123.125.71.78','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-18 04:01:11'),(1174,'117.197.73.216','Gootkit auto-rooter scanner','','2011-09-18 04:45:05'),(1175,'178.205.6.24','Opera/9.80 (Windows NT 6.1; U; en-US) Presto/2.7.62 Version/11.01','','2011-09-18 08:26:09'),(1176,'178.205.25.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-jp) AppleWebKit/534.7 (KHTML, like Gecko) Iron/7.0.520.1 Chrome/7.0.520.1 Safari/534.7','','2011-09-19 02:21:38'),(1177,'220.181.51.89','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-19 05:40:11'),(1178,'93.116.183.14','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; YPC 3.0.2; .NET CLR 1.1.4322; yplus 4.4.02b)','http://equibidz.com/support/faqsubmit.cfm','2011-09-19 13:50:51'),(1179,'178.204.62.64','Mozilla/5.0 (X11; U; SunOS sun4u; fr-FR; rv:1.7) Gecko/20040621','','2011-09-19 16:54:46'),(1180,'66.249.68.185','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-09-19 17:28:28'),(1181,'66.249.67.42','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-09-19 22:53:26'),(1182,'217.23.5.167','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-09-20 02:23:14'),(1183,'178.204.104.212','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081217 KMLite/1.1.2','','2011-09-20 08:23:56'),(1184,'178.205.45.200','Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-us) AppleWebKit/125.5.7 (KHTML, like Gecko) SunriseBrowser/0.853','','2011-09-20 11:10:25'),(1185,'123.125.68.115','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-20 14:02:27'),(1186,'193.105.210.137','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-09-20 18:32:50'),(1187,'64.246.165.150','Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','http://whois.domaintools.com/equibidz.com','2011-09-20 21:42:43'),(1188,'66.249.72.178','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-09-21 05:39:59'),(1189,'178.205.11.200','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; Lunascape 6.0.1.20094)','','2011-09-21 12:34:36'),(1190,'178.204.104.203','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 2.0.50727; Lunascape 5.0 alpha1)','','2011-09-22 08:43:35'),(1191,'95.221.75.223','Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.6.30 Version/10.63','http://yandex.ru/yandsearch?text=the+maximum+amount','2011-09-23 07:11:37'),(1192,'178.204.12.108','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; AtHome021SI; Q312461)','','2011-09-23 13:55:27'),(1193,'176.14.27.178','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)','http://yandex.ru/yandsearch?text=your+User+ID+and+Password','2011-09-23 21:22:48'),(1194,'95.24.157.219','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; InfoPath.1)','http://yandex.ru/yandsearch?text=equibidz.com','2011-09-24 00:00:58'),(1195,'66.249.72.85','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-09-24 09:02:09'),(1196,'178.204.105.198','Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.458.0 Safari/534.3','','2011-09-24 09:37:24'),(1197,'123.125.68.123','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-24 12:56:08'),(1198,'70.30.2.180','Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.12) Gecko/20101026 Firefox/3.6.12','http://www.google.com/search?q=does+bidz.com+use+reverse+auction&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a','2011-09-24 17:25:57'),(1199,'178.205.34.0','Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:0.9.4) Gecko/20011019 Netscape6/6.2','','2011-09-24 20:58:12'),(1200,'72.9.227.18','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-09-25 04:39:51'),(1201,'95.27.205.76','Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.6.30 Version/10.63','http://yandex.ru/yandsearch?text=AUCTIONS+ADVERTISE','2011-09-25 05:32:28'),(1202,'77.247.28.142','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-09-25 06:24:27'),(1203,'220.181.51.85','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-25 12:18:54'),(1204,'178.205.55.216','Mozilla/5.0 (X11; U; FreeBSD i386; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16','','2011-09-25 20:27:04'),(1205,'90.156.196.156','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','http://equibidz.com/support/faqsubmit.cfm','2011-09-26 01:11:56'),(1206,'90.156.196.11','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','http://equibidz.com/support/faqsubmit.cfm','2011-09-26 01:11:58'),(1207,'123.125.71.92','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-26 03:02:12'),(1208,'220.181.51.122','Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','','2011-09-26 03:52:50'),(1209,'188.143.232.126','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-10-08 10:31:40'),(1210,'69.73.26.95','Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20100101 Firefox/7.0.1','','2011-10-08 10:33:30'),(1211,'198.228.224.139','Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5','','2011-10-08 10:35:13'),(1212,'188.143.232.105','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-10-08 10:51:06'),(1213,'178.123.213.104','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-10-08 11:27:28'),(1214,'109.200.159.110','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)','','2011-10-08 12:40:15'),(1215,'66.249.68.138','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-10-08 12:45:28'),(1216,'66.249.67.89','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','','2011-10-08 12:47:28');
/*!40000 ALTER TABLE `tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_log`
--

DROP TABLE IF EXISTS `transaction_log`;
CREATE TABLE `transaction_log` (
  `trans_id` int(11) NOT NULL auto_increment,
  `itemnum` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `date_posted` datetime NOT NULL,
  `description` varchar(255) NOT NULL default 'New Transaction Log Description',
  `details` longtext NOT NULL,
  `amount` double NOT NULL default '0',
  `remote_ip` varchar(23) NOT NULL default '127.0.0.1',
  PRIMARY KEY  (`trans_id`),
  KEY `date_posted_index` (`date_posted`),
  KEY `description_index` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=2524 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transaction_log`
--

LOCK TABLES `transaction_log` WRITE;
/*!40000 ALTER TABLE `transaction_log` DISABLE KEYS */;
INSERT INTO `transaction_log` VALUES (1761,0,0,'2009-03-04 03:24:14','Account Created & Finalized by Administrator','NAME: David',0,'71.105.206.6'),(1762,0,0,'2009-03-04 03:24:33','Access changed','Access changed for David',0,'71.105.206.6'),(1763,0,0,'2009-03-04 03:28:31','Account Deleted by Administrator','USER ID: 30',0,'71.105.206.6'),(1764,0,0,'2009-03-04 03:29:47','Account Created & Finalized by Administrator','NAME: Davidh',0,'71.105.206.6'),(1765,0,0,'2009-03-04 04:07:19','Access changed','Access changed for Administrator',0,'71.105.206.6'),(1766,0,0,'2009-03-04 04:07:42','Site Defaults Modified','No Details Available',0,'71.105.206.6'),(1767,0,0,'2009-03-04 04:07:57','Account Information Updated by Administrator','USER ID: 880835450',0,'71.105.206.6'),(1768,0,0,'2009-03-04 04:09:28','Category Created','CATEGORY NAME: Top Level 1     CATEGORY ID: 920704167     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'71.105.206.6'),(1769,0,0,'2009-03-04 04:09:39','Category Created','CATEGORY NAME: Level 2     CATEGORY ID: 920704179     PARENT: 920704167     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'71.105.206.6'),(1770,0,0,'2009-03-04 04:09:55','Category Created','CATEGORY NAME: Level 3     CATEGORY ID: 920704195     PARENT: 920704179     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'71.105.206.6'),(1771,0,0,'2009-03-04 04:10:05','Category Created','CATEGORY NAME: Level 4     CATEGORY ID: 920704205     PARENT: 920704195     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'71.105.206.6'),(1772,0,0,'2009-03-04 04:10:14','Category Created','CATEGORY NAME: Level 5     CATEGORY ID: 920704214     PARENT: 920704205     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'71.105.206.6'),(1773,0,0,'2009-03-04 04:10:24','Category Created','CATEGORY NAME: Level 6     CATEGORY ID: 920704223     PARENT: 920704214     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'71.105.206.6'),(1774,0,0,'2009-03-04 04:10:32','Category Created','CATEGORY NAME: Level 7     CATEGORY ID: 920704232     PARENT: 920704223     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'71.105.206.6'),(1775,0,0,'2009-03-04 04:10:43','Category Created','CATEGORY NAME: Level 8     CATEGORY ID: 920704243     PARENT: 920704232     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'71.105.206.6'),(1776,0,0,'2009-03-04 04:12:31','Account Created & Finalized by Administrator','USER ID: 920704351',0,'71.105.206.6'),(1777,0,920710318,'2009-03-04 05:51:58','Account Created','EMAIL: opalsoftwarenet@yahoo.com',0,'71.105.206.6'),(1778,0,0,'2009-03-04 05:52:42','Account Information Updated by Administrator','USER ID: 920710318',0,'71.105.206.6'),(1779,920710623,920710318,'2009-03-04 05:57:08','Auction Started','Just testing ',0,'71.105.206.6'),(1780,0,920710318,'2009-03-04 05:57:25','Account Information Updated','No Details Available',0,'71.105.206.6'),(1781,0,0,'2009-03-04 23:00:29','Account Created & Finalized by Administrator','NAME: Test Admin',0,'75.51.178.199'),(1782,0,0,'2009-03-08 21:10:55','Category Created','CATEGORY NAME: SubLevel 6a     CATEGORY ID: 921111055     PARENT: 920704214     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'121.1.37.149'),(1783,0,0,'2009-03-08 21:11:25','Category Created','CATEGORY NAME: SubLevel 6b     CATEGORY ID: 921111085     PARENT: 921111055     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'121.1.37.149'),(1784,0,0,'2009-03-09 01:47:02','Add news','ADD NEWS OPTION',0,'222.127.38.23'),(1785,0,0,'2009-03-12 05:58:26','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'121.1.18.237'),(1786,0,0,'2009-03-12 05:58:43','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'121.1.18.237'),(1787,0,0,'2009-03-12 05:59:21','Report Ran (Mailing List)','OUTPUT TYPE: csv     SORT ORDER: nameA     NICKNAME: 0     USER ID: 0     DATE REGISTERED: 0     MAILING ADDRESS: 0     PHONE NUMBERS: 0     PREFERRED LANGUAGE: 0     SURVEY INFO: 0     COMPANY: 0',0,'121.1.18.237'),(1788,0,0,'2009-03-12 06:00:47','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'121.1.18.237'),(1789,0,0,'2009-03-12 06:01:22','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'121.1.18.237'),(1790,0,0,'2009-03-12 06:02:01','Report Ran (Account History)','OUTPUT TYPE: csv     SORT ORDER: nameA     DAYS: 30',0,'121.1.18.237'),(1791,0,0,'2009-03-12 06:02:28','Report Ran (Transaction Log)','OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30',0,'121.1.18.237'),(1792,0,0,'2009-03-12 06:03:01','Report Ran (Transaction Log)','OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30',0,'121.1.18.237'),(1793,0,0,'2009-03-12 06:03:29','Report Ran (Winning Bidder)','FROM DATE: 03/11/2009    TO DATE: 03/12/2009    OUTPUT TYPE: csv     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'121.1.18.237'),(1794,0,0,'2009-03-12 06:04:00','Report Ran (Users Information)','FROM DATE: 03/11/2009    TO DATE: 03/12/2009    OUTPUT TYPE: csv     SORT ORDER: nicknameA',0,'121.1.18.237'),(1795,0,0,'2009-03-12 06:04:34','Report Ran (Mailing List)','OUTPUT TYPE: csv     SORT ORDER: nameA     NICKNAME: 0     USER ID: 0     DATE REGISTERED: 0     MAILING ADDRESS: 0     PHONE NUMBERS: 0     PREFERRED LANGUAGE: 0     SURVEY INFO: 0     COMPANY: 0',0,'121.1.18.237'),(1796,0,0,'2009-03-12 06:21:07','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'121.1.18.237'),(1797,0,0,'2009-03-12 06:28:30','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'121.1.18.237'),(1798,921554191,880835450,'2009-03-14 00:18:14','Auction Started by Administrator','TITLE: Test post from admin     STATUS: 1     DATE START: {ts \'2009-03-13 19:16:00\'}     DATE END: {ts \'2009-03-15 19:16:00\'}     QUANTITY: 1     MINIMUM BID: 100  MAXMINIMUM BID: 0   RESERVE BID: 150     USE BID INCREMENT: 1     INCREMENT VALUE: 1     USE DYNAMIC CLOSE: 0     DYNAMIC VALUE: 0     CATEGORY 1: 920704167     CATEGORY 2: -1     PRIVATE: 0     USE BANNER: 0     BANNER LINE: ',0,'71.105.206.6'),(1799,0,0,'2009-03-14 00:18:29','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90',0,'71.105.206.6'),(1800,0,0,'2009-03-14 00:22:55','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90',0,'71.105.206.6'),(1801,0,0,'2009-03-14 01:05:57','Add New No Invoice User (adopogi3)','NEW NO INVOICE USER: adopogi3',0,'121.1.37.149'),(1802,0,0,'2009-03-14 01:11:23','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'121.1.37.149'),(1803,0,0,'2009-03-14 01:11:34','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'121.1.37.149'),(1804,0,0,'2009-03-14 01:11:44','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'121.1.37.149'),(1805,0,0,'2009-03-14 01:11:53','Report Ran (Account History)','OUTPUT TYPE: csv     SORT ORDER: nameA     DAYS: 30',0,'121.1.37.149'),(1806,0,0,'2009-03-14 01:12:00','Report Ran (Transaction Log)','OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30',0,'121.1.37.149'),(1807,0,0,'2009-03-14 01:12:08','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'121.1.37.149'),(1808,0,0,'2009-03-15 00:01:26','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'121.1.37.149'),(1809,0,0,'2009-03-15 02:13:47','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'121.1.37.149'),(1810,0,0,'2009-03-16 00:50:38','Update meta keywords information','Meta keywords information updated',0,'121.1.37.149'),(1811,0,0,'2010-05-05 14:13:48','Account Created & Finalized by Administrator','USER ID: 957633228',0,'76.90.242.50'),(1812,0,0,'2010-05-05 17:55:24','Ad Expired (Invalid User ID)','No Details Available',0,'68.183.144.71'),(1813,0,0,'2010-05-05 17:55:25','Ad Expired (Invalid User ID)','No Details Available',0,'68.183.144.71'),(1814,0,0,'2010-05-05 17:55:25','Ad Expired (Invalid User ID)','No Details Available',0,'68.183.144.71'),(1815,957647794,957633228,'2010-05-05 18:55:17','Auction Started','Test Again',0,'68.183.144.71'),(1816,957660517,957633228,'2010-05-05 22:23:13','Auction Started','Test Test',0,'68.183.144.71'),(1817,0,958244181,'2010-05-12 15:56:21','New Membership ( richierich)','MEMBERSHIP FEE: 30    MEMBERSHIP OPTION: 30_80_Platinum_Annual',0,'68.183.144.71'),(1818,0,0,'2010-05-12 15:56:21','Account Created & Finalized by Administrator','USER ID: 958244181',0,'68.183.144.71'),(1819,0,0,'2010-05-12 15:57:51','Site Information Updated','No Details Available',0,'68.183.144.71'),(1820,0,0,'2010-05-12 15:58:31','Site Information Updated','No Details Available',0,'68.183.144.71'),(1821,0,0,'2010-05-12 15:59:10','Site Information Updated','No Details Available',0,'68.183.144.71'),(1822,0,0,'2010-05-12 16:10:11','Account Created & Finalized by Administrator','USER ID: 958245011',0,'68.183.144.71'),(1823,0,0,'2010-05-12 16:10:57','Category Created','CATEGORY NAME: Apparel     CATEGORY ID: 958245057     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'68.183.144.71'),(1824,0,0,'2010-05-12 16:14:53','Site Information Updated','No Details Available',0,'68.183.144.71'),(1825,0,0,'2010-05-12 16:15:53','Company Name updated','Company Name updated',0,'68.183.144.71'),(1826,958247076,958245011,'2010-05-12 16:45:02','Auction Started','ftrt',0,'68.183.144.71'),(1827,958256883,958245011,'2010-05-12 19:28:17','Auction Started','Residential High-Rise Apartments at the Heart of the City',0,'68.183.144.71'),(1828,0,958270021,'2010-05-12 23:07:01','Account Created','EMAIL: douglaspaulmusic@yahoo.com',0,'76.90.242.50'),(1829,0,0,'2010-06-17 21:36:14','Site Information Updated','No Details Available',0,'68.183.144.71'),(1830,0,0,'2010-06-17 21:38:08','Category Deleted','CATEGORY ID: 951237253     PARENT: 951234046',0,'68.183.144.71'),(1831,0,0,'2010-06-17 21:38:09','Category Deleted','CATEGORY ID: 951237281     PARENT: 951234046',0,'68.183.144.71'),(1832,0,0,'2010-06-17 21:38:10','Category Deleted','CATEGORY ID: 951237201     PARENT: 951234046',0,'68.183.144.71'),(1833,0,0,'2010-06-17 21:38:12','Category Deleted','CATEGORY ID: 951237190     PARENT: 951234046',0,'68.183.144.71'),(1834,0,0,'2010-06-17 21:38:18','Category Public Sales Disabled','CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1835,0,0,'2010-06-17 21:38:27','Category Public Sales Disabled','CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1836,0,0,'2010-06-17 21:38:31','Category Public Sales Disabled','CATEGORY ID: 951234046     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1837,0,0,'2010-06-17 21:38:43','Category Public Sales Disabled','CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1838,0,0,'2010-06-17 21:38:49','Category Deleted','CATEGORY ID: 955837322     PARENT: 0',0,'68.183.144.71'),(1839,0,0,'2010-06-17 21:38:57','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1840,0,0,'2010-06-17 21:39:02','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1841,0,0,'2010-06-17 21:39:03','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1842,0,0,'2010-06-17 21:39:04','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1843,0,0,'2010-06-17 21:39:18','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1844,0,0,'2010-06-17 21:39:43','Category Deleted','CATEGORY ID: 951237044     PARENT:  951234037',0,'68.183.144.71'),(1845,0,0,'2010-06-17 21:39:47','Category Deleted','CATEGORY ID: 951789814     PARENT:  951234037',0,'68.183.144.71'),(1846,0,0,'2010-06-17 21:39:50','Category Deleted','CATEGORY ID: 951234467     PARENT:  951234037',0,'68.183.144.71'),(1847,0,0,'2010-06-17 21:39:51','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1848,0,0,'2010-06-17 21:39:54','Category Deleted','CATEGORY ID: 951234475     PARENT:  951234037',0,'68.183.144.71'),(1849,0,0,'2010-06-17 21:39:57','Category Deleted','CATEGORY ID: 951237035     PARENT:  951234037',0,'68.183.144.71'),(1850,0,0,'2010-06-17 21:39:59','Category Deleted','CATEGORY ID: 951237058     PARENT:  951234037',0,'68.183.144.71'),(1851,0,0,'2010-06-17 21:40:02','Category Deleted','CATEGORY ID: 951306825     PARENT:  951234037',0,'68.183.144.71'),(1852,0,0,'2010-06-17 21:40:05','Category Deleted','CATEGORY ID: 951234449     PARENT:  951234037',0,'68.183.144.71'),(1853,0,0,'2010-06-17 21:40:07','Category Deleted','CATEGORY ID: 951234207     PARENT:  951234037',0,'68.183.144.71'),(1854,0,0,'2010-06-17 21:40:10','Category Deleted','CATEGORY ID: 951234248     PARENT:  951234037',0,'68.183.144.71'),(1855,0,0,'2010-06-17 21:40:13','Category Deleted','CATEGORY ID: 951234500     PARENT:  951234037',0,'68.183.144.71'),(1856,0,0,'2010-06-17 21:40:15','Category Deleted','CATEGORY ID: 951234328     PARENT:  951234037',0,'68.183.144.71'),(1857,0,0,'2010-06-17 21:40:17','Category Deleted','CATEGORY ID: 951234289     PARENT:  951234037',0,'68.183.144.71'),(1858,0,0,'2010-06-17 21:40:19','Category Deleted','CATEGORY ID: 951234350     PARENT:  951234037',0,'68.183.144.71'),(1859,0,0,'2010-06-17 21:40:21','Category Deleted','CATEGORY ID: 951306759     PARENT:  951234037',0,'68.183.144.71'),(1860,0,0,'2010-06-17 21:40:23','Category Deleted','CATEGORY ID: 951234369     PARENT:  951234037',0,'68.183.144.71'),(1861,0,0,'2010-06-17 21:40:25','Category Deleted','CATEGORY ID: 951306836     PARENT:  951234037',0,'68.183.144.71'),(1862,0,0,'2010-06-17 21:40:27','Category Deleted','CATEGORY ID: 951306816     PARENT:  951234037',0,'68.183.144.71'),(1863,0,0,'2010-06-17 21:40:29','Category Deleted','CATEGORY ID: 951234423     PARENT:  951234037',0,'68.183.144.71'),(1864,0,0,'2010-06-17 21:40:31','Category Deleted','CATEGORY ID: 951234385     PARENT:  951234037',0,'68.183.144.71'),(1865,0,0,'2010-06-17 21:40:33','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1866,0,0,'2010-06-17 21:40:40','Category Public Sales Disabled','CATEGORY ID: 951234046     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1867,0,0,'2010-06-17 21:40:47','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1868,0,0,'2010-06-17 21:40:51','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1869,0,0,'2010-06-17 21:41:10','Category Public Sales Disabled','CATEGORY ID: 951234046     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1870,0,0,'2010-06-17 21:41:15','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1871,0,0,'2010-06-17 21:41:33','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1872,0,0,'2010-06-17 21:41:46','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1873,0,0,'2010-06-17 21:41:57','Category Public Sales Disabled','CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1874,0,0,'2010-06-17 21:42:17','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1875,0,0,'2010-06-17 21:42:29','Category Information Updated','CATEGORY NAME: Apartments     CATEGORY ID: 951236959     ACTIVE: 0     ALLOW PUBLIC SALES: 0    FEE LISTING: 1',0,'68.183.144.71'),(1876,0,0,'2010-06-17 21:42:31','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1877,0,0,'2010-06-17 21:42:33','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1878,0,0,'2010-06-17 21:42:51','Category Public Sales Disabled','CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1879,0,0,'2010-06-17 21:42:53','Category Public Sales Disabled','CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1880,0,0,'2010-06-17 21:43:00','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1881,0,0,'2010-06-17 21:43:29','Category Information Updated','CATEGORY NAME: Apartments     CATEGORY ID: 951236959     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 1',0,'68.183.144.71'),(1882,0,0,'2010-06-17 21:43:31','Category Public Sales Disabled','CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'68.183.144.71'),(1883,958256883,0,'2010-06-17 21:44:25','Auction Deleted by Administrator','No Details Available',0,'68.183.144.71'),(1884,957647794,0,'2010-06-17 21:44:36','Auction Deleted by Administrator','No Details Available',0,'68.183.144.71'),(1885,957660517,0,'2010-06-17 21:44:39','Auction Deleted by Administrator','No Details Available',0,'68.183.144.71'),(1886,958247076,0,'2010-06-17 21:44:55','Auction Deleted by Administrator','No Details Available',0,'68.183.144.71'),(1887,945657026,0,'2010-06-17 21:44:56','Auction Deleted by Administrator','No Details Available',0,'68.183.144.71'),(1888,945694906,0,'2010-06-17 21:44:57','Auction Deleted by Administrator','No Details Available',0,'68.183.144.71'),(1889,945660603,0,'2010-06-17 21:44:58','Auction Deleted by Administrator','No Details Available',0,'68.183.144.71'),(1890,0,0,'2010-06-17 21:45:34','Category Deleted','CATEGORY ID: 958245057     PARENT: 0',0,'68.183.144.71'),(1891,0,0,'2010-06-17 21:45:36','Category Deleted','CATEGORY ID: 951234046     PARENT: 0',0,'68.183.144.71'),(1892,0,0,'2010-06-17 21:45:40','Category Deleted','CATEGORY ID: 951236959     PARENT: 951234037',0,'68.183.144.71'),(1893,0,0,'2010-06-17 21:45:45','Category Deleted','CATEGORY ID: 951234037     PARENT: 0',0,'68.183.144.71'),(1894,0,0,'2010-06-17 21:46:11','Category Created','CATEGORY NAME: Test Only     CATEGORY ID: 961375571     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 0',0,'68.183.144.71'),(1895,0,0,'2010-06-17 21:46:28','Account Deleted by Administrator','USER ID: 14',0,'68.183.144.71'),(1896,0,0,'2010-06-17 21:46:37','Account Deleted by Administrator','USER ID: 958244181',0,'68.183.144.71'),(1897,0,0,'2010-06-17 21:46:44','Account Deleted by Administrator','USER ID: 958245011',0,'68.183.144.71'),(1898,0,0,'2010-06-17 21:46:49','Account Deleted by Administrator','USER ID: 958270021',0,'68.183.144.71'),(1899,0,0,'2010-06-17 21:47:31','Account Information Updated by Administrator','USER ID: 957633228',0,'68.183.144.71'),(1900,0,0,'2010-06-17 21:49:18','Account Created & Finalized by Administrator','USER ID: 961375758',0,'68.183.144.71'),(1901,0,0,'2010-06-17 21:58:18','Company Name updated','Company Name updated',0,'68.183.144.71'),(1902,0,0,'2010-06-17 21:59:29','Update about us','About us updated',0,'68.183.144.71'),(1903,0,0,'2010-06-17 22:00:00','Update contact','contact updated',0,'68.183.144.71'),(1904,0,0,'2011-03-29 16:47:10','Site Information Updated','No Details Available',0,'92.48.109.94'),(1905,0,0,'2011-03-29 23:12:44','Site Information Updated','No Details Available',0,'92.48.109.94'),(1906,0,0,'2011-03-29 23:19:33','Site Information Updated','No Details Available',0,'92.48.109.94'),(1907,0,0,'2011-03-29 23:29:19','Site Information Updated','No Details Available',0,'92.48.109.94'),(1908,0,986065566,'2011-03-30 16:06:06','Account Created','EMAIL: person@somewhere.com',0,'92.48.109.94'),(1909,0,0,'2011-03-31 12:08:50','Category Created','CATEGORY NAME: Stallions     CATEGORY ID: 986137730     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'92.48.109.94'),(1910,0,0,'2011-03-31 12:08:56','Category Deleted','CATEGORY ID: 961375571     PARENT: 0',0,'92.48.109.94'),(1911,0,0,'2011-03-31 12:09:11','Category Created','CATEGORY NAME: Mares     CATEGORY ID: 986137751     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'92.48.109.94'),(1912,0,0,'2011-03-31 12:09:23','Category Created','CATEGORY NAME: Geldings     CATEGORY ID: 986137763     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'92.48.109.94'),(1913,986138843,986065441,'2011-03-31 12:28:11','Auction Started by Administrator','TITLE: Chocolate Chic Olena     STATUS: 1     DATE START: {ts \'2011-03-31 07:27:00\'}     DATE END: {ts \'2011-04-02 07:27:00\'}     QUANTITY: 1     MINIMUM BID: 100  MAXMINIMUM BID: 0   RESERVE BID: 0     USE BID INCREMENT: 1     INCREMENT VALUE: 5     USE DYNAMIC CLOSE: 0     DYNAMIC VALUE: 0     CATEGORY 1: 986137763     CATEGORY 2: 986137763     PRIVATE: 0     USE BANNER: 0     BANNER LINE:       BOLD TITLE: 0     STUDIO: 0     FEATURED: 0     FEATURED: 0     FEATURED IN CATEGORY: 0     LOCATION: Alabama     COUNTRY: USA  AUCTION MODE: 0 AUTO RELIST: 0',0,'92.48.109.94'),(1914,986138843,986065441,'2011-04-02 07:34:54','Auction Invoiced','No Details Available',1.05,'111.125.101.101'),(1915,986138843,986065441,'2011-04-02 07:34:54','Auction Expired','No Details Available',0,'111.125.101.101'),(1916,986138843,986065441,'2011-04-02 07:34:54','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=986138843\r\n\r\n',0,'111.125.101.101'),(1917,0,986599949,'2011-04-05 20:32:29','Account Created','EMAIL: rosesomoza@yahoo.com',0,'112.204.11.103'),(1918,0,0,'2011-04-05 20:35:10','Account Confirmation','USER ID: 986599949    NICKNAME: rosesomoza',0,'112.204.11.103'),(1919,0,0,'2011-04-05 20:35:56','Account Confirmation','USER ID: 986599949    NICKNAME: rosesomoza',0,'112.204.11.103'),(1920,0,987394073,'2011-04-15 01:07:53','Account Created','EMAIL: Person@somewhere.com',0,'72.148.31.116'),(1921,0,987394774,'2011-04-15 01:19:34','Account Created','EMAIL: Jm18488@bellsouth.net',0,'72.148.31.116'),(1922,0,0,'2011-04-15 01:20:17','Account Confirmation','USER ID: 987394774    NICKNAME: Jmcward1',0,'72.148.31.116'),(1923,0,0,'2011-04-15 01:20:50','Account Confirmation','USER ID: 987394774    NICKNAME: Jmcward1',0,'72.148.31.116'),(1924,989461899,957633228,'2011-05-19 13:57:52','BuyNow','BUYNOW: 500',0,'112.206.146.217'),(1925,989461899,957633228,'2011-05-19 13:57:52','Buynow email sent to buyer','Buynow: 500',0,'112.206.146.217'),(1926,989461899,961375758,'2011-05-19 13:57:52','Buynow email sent to seller','Buynow: 500  	Buyer: 957633228',0,'112.206.146.217'),(1927,0,990906101,'2011-05-25 16:41:42','Account Created','EMAIL: tvet2b@aol.com',0,'72.159.2.254'),(1928,0,0,'2011-05-25 17:15:05','Account Confirmation','USER ID: 990906101    NICKNAME: tbone',0,'166.137.10.215'),(1929,990474959,990906101,'2011-05-25 17:27:26','Bid','BID: 15000',0,'72.159.2.254'),(1930,0,990933961,'2011-05-26 00:26:01','Account Created','EMAIL: dickcaadan@yahoo.com.ph',0,'112.205.96.0'),(1931,0,0,'2011-05-26 00:32:32','Account Confirmation','USER ID: 990933961    NICKNAME: aaronjohn',0,'112.205.96.0'),(1932,0,990934851,'2011-05-26 00:40:51','Account Created','EMAIL: dickcaadan@yahoo.com.ph',0,'112.205.96.0'),(1933,0,0,'2011-05-26 00:42:37','Account Confirmation','USER ID: 990934851    NICKNAME: julieanne',0,'112.205.96.0'),(1934,0,990936401,'2011-05-26 01:06:41','Account Created','EMAIL: dickcaadan@yahoo.com.ph',0,'112.205.96.0'),(1935,0,0,'2011-05-26 01:09:04','Account Confirmation','USER ID: 990936401    NICKNAME: aaron',0,'112.205.96.0'),(1936,0,0,'2011-05-26 01:11:54','Account Confirmation','USER ID: 990936401    NICKNAME: aaron',0,'112.205.96.0'),(1937,0,0,'2011-05-26 01:12:33','Account Confirmation','USER ID: 990936401    NICKNAME: aaron',0,'112.205.96.0'),(1938,990474959,990906101,'2011-05-26 16:47:32','BuyNow','BUYNOW: 25000',0,'72.159.2.254'),(1939,990474959,990906101,'2011-05-26 16:47:32','Buynow email sent to buyer','Buynow: 25000',0,'72.159.2.254'),(1940,990474959,957633228,'2011-05-26 16:47:32','Buynow email sent to seller','Buynow: 25000  	Buyer: 990906101',0,'72.159.2.254'),(1941,0,991498245,'2011-06-01 13:10:46','Account Created','EMAIL: jm18488@bellsouth.net',0,'72.37.171.84'),(1942,0,0,'2011-06-01 18:27:53','Account Confirmation','USER ID: 991498245    NICKNAME: jmcward',0,'72.37.171.84'),(1943,0,0,'2011-06-01 18:28:25','Account Confirmation','USER ID: 991498245    NICKNAME: jmcward',0,'72.37.171.84'),(1944,0,0,'2011-06-01 18:28:45','Account Confirmation','USER ID: 991498245    NICKNAME: jmcward',0,'72.37.171.84'),(1945,989514078,991498245,'2011-06-01 18:31:02','BuyNow','BUYNOW: 500',0,'72.37.171.84'),(1946,989514078,991498245,'2011-06-01 18:31:02','Buynow email sent to buyer','Buynow: 500',0,'72.37.171.84'),(1947,989514078,961375758,'2011-06-01 18:31:02','Buynow email sent to seller','Buynow: 500  	Buyer: 991498245',0,'72.37.171.84'),(1948,990078778,991498245,'2011-06-01 18:33:29','BuyNow','BUYNOW: 500',0,'72.37.171.84'),(1949,990078778,991498245,'2011-06-01 18:33:29','Buynow email sent to buyer','Buynow: 500',0,'72.37.171.84'),(1950,990078778,961375758,'2011-06-01 18:33:29','Buynow email sent to seller','Buynow: 500  	Buyer: 991498245',0,'72.37.171.84'),(1951,0,0,'2011-06-03 21:13:20','Category Created','CATEGORY NAME: Mares     CATEGORY ID: 991700000     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'99.118.90.215'),(1952,0,0,'2011-06-03 21:14:15','Category Created','CATEGORY NAME: Mares     CATEGORY ID: 991700055     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'72.148.31.116'),(1953,0,0,'2011-06-03 21:16:02','Category Public Sales Disabled','CATEGORY ID: 990724531     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1954,0,0,'2011-06-03 21:16:16','Category Deleted','CATEGORY ID: 991700000     PARENT: 0',0,'72.148.31.116'),(1955,0,0,'2011-06-03 21:17:58','Category Created','CATEGORY NAME: Stallions     CATEGORY ID: 991700278     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'72.148.31.116'),(1956,0,0,'2011-06-03 21:18:16','Category Created','CATEGORY NAME: Geldings     CATEGORY ID: 991700296     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'72.148.31.116'),(1957,0,0,'2011-06-03 21:18:31','Category Created','CATEGORY NAME: MARES     CATEGORY ID: 991700311     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'68.183.144.71'),(1958,0,0,'2011-06-03 21:18:52','Category Deleted','CATEGORY ID: 991700055     PARENT: 0',0,'99.118.90.215'),(1959,0,0,'2011-06-03 21:19:52','Category Deleted','CATEGORY ID: 989503762     PARENT: 0',0,'99.118.90.215'),(1960,0,0,'2011-06-03 21:19:57','Category Deleted','CATEGORY ID: 989490718     PARENT: 0',0,'99.118.90.215'),(1961,0,0,'2011-06-03 21:20:04','Category Deleted','CATEGORY ID: 990724515     PARENT: 0',0,'99.118.90.215'),(1962,0,0,'2011-06-03 21:20:09','Category Deleted','CATEGORY ID: 989503756     PARENT: 0',0,'99.118.90.215'),(1963,0,0,'2011-06-03 21:20:12','Category Public Sales Disabled','CATEGORY ID: 989490761     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1964,0,0,'2011-06-03 21:20:19','Category Public Sales Disabled','CATEGORY ID: 990724531     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1965,0,0,'2011-06-03 21:23:32','Category Information Updated','CATEGORY NAME: GELDINGS     CATEGORY ID: 991700296     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 1',0,'72.148.31.116'),(1966,0,0,'2011-06-03 21:23:52','Category Information Updated','CATEGORY NAME: STALLIONS     CATEGORY ID: 991700278     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 1',0,'72.148.31.116'),(1967,990989164,991498245,'2011-06-03 21:25:23','BuyNow','BUYNOW: 7000',0,'72.148.31.116'),(1968,990989164,991498245,'2011-06-03 21:25:23','Buynow email sent to buyer','Buynow: 7000',0,'72.148.31.116'),(1969,990989164,990906101,'2011-06-03 21:25:23','Buynow email sent to seller','Buynow: 7000  	Buyer: 991498245',0,'72.148.31.116'),(1970,0,0,'2011-06-03 21:29:36','Category Public Sales Disabled','CATEGORY ID: 990724531     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1971,991666543,961375758,'2011-06-03 21:29:54','BuyNow','BUYNOW: 25000',0,'68.183.144.71'),(1972,991666543,961375758,'2011-06-03 21:29:54','Buynow email sent to buyer','Buynow: 25000',0,'68.183.144.71'),(1973,991666543,991498245,'2011-06-03 21:29:54','Buynow email sent to seller','Buynow: 25000  	Buyer: 961375758',0,'68.183.144.71'),(1974,0,0,'2011-06-03 21:34:07','Site Defaults Modified','No Details Available',0,'72.148.31.116'),(1975,0,0,'2011-06-03 22:03:39','Category Public Sales Disabled','CATEGORY ID: 989490761     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1976,0,0,'2011-06-03 22:20:49','Category Public Sales Disabled','CATEGORY ID: 990724531     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1977,0,0,'2011-06-03 22:32:50','Category Public Sales Disabled','CATEGORY ID: 989490761     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'72.148.31.116'),(1978,0,0,'2011-06-03 22:32:55','Category Public Sales Disabled','CATEGORY ID: 990724531     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1979,0,0,'2011-06-03 22:33:58','Category Information Updated','CATEGORY NAME: STALLION BREEDING SERVICE     CATEGORY ID: 989490761     ACTIVE: 1     ALLOW PUBLIC SALES: 0    FEE LISTING: 1',0,'72.148.31.116'),(1980,0,0,'2011-06-03 22:35:04','Category Deleted','CATEGORY ID: 989529691     PARENT: 989490657',0,'99.118.90.215'),(1981,0,0,'2011-06-03 22:35:05','Category Deleted','CATEGORY ID: 989529718     PARENT: 989490657',0,'99.118.90.215'),(1982,0,0,'2011-06-03 22:35:06','Category Deleted','CATEGORY ID: 989529703     PARENT: 989490657',0,'99.118.90.215'),(1983,0,0,'2011-06-03 22:36:01','Category Information Updated','CATEGORY NAME: MARE BREEDING LEASE     CATEGORY ID: 989490657     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 1',0,'72.148.31.116'),(1984,0,0,'2011-06-03 22:36:35','Category Public Sales Disabled','CATEGORY ID: 990724531     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'72.148.31.116'),(1985,0,0,'2011-06-03 22:38:36','Category Deleted','CATEGORY ID: 989529815     PARENT: 989490587',0,'99.118.90.215'),(1986,0,0,'2011-06-03 22:38:37','Category Deleted','CATEGORY ID: 989529835     PARENT: 989490587',0,'99.118.90.215'),(1987,0,0,'2011-06-03 22:38:37','Category Deleted','CATEGORY ID: 989529825     PARENT: 989490587',0,'99.118.90.215'),(1988,0,0,'2011-06-03 22:38:43','Category Public Sales Disabled','CATEGORY ID: 989490587     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1989,0,0,'2011-06-03 22:38:53','Category Deleted','CATEGORY ID: 989529954     PARENT: 989485725',0,'99.118.90.215'),(1990,0,0,'2011-06-03 22:38:54','Category Deleted','CATEGORY ID: 989529959     PARENT: 989485725',0,'99.118.90.215'),(1991,0,0,'2011-06-03 22:38:55','Category Deleted','CATEGORY ID: 989529965     PARENT: 989485725',0,'99.118.90.215'),(1992,0,0,'2011-06-03 22:39:03','Category Public Sales Disabled','CATEGORY ID: 989485725     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'99.118.90.215'),(1993,0,0,'2011-06-04 00:35:26','Category Public Sales Disabled','CATEGORY ID: 989490587     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'72.148.31.116'),(1994,0,0,'2011-06-04 00:35:33','Category Public Sales Disabled','CATEGORY ID: 989490587     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'72.148.31.116'),(1995,0,0,'2011-06-04 00:35:41','Category Public Sales Disabled','CATEGORY ID: 989485725     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'72.148.31.116'),(1996,0,0,'2011-06-04 00:36:04','Category Public Sales Disabled','CATEGORY ID: 990724531     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE',0,'72.148.31.116'),(1997,0,0,'2011-06-04 00:36:38','Category Information Updated','CATEGORY NAME: ATRC Stallion Service Auction 2009     CATEGORY ID: 990724531     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 1',0,'72.148.31.116'),(1998,0,0,'2011-06-04 00:38:24','Category Deleted','CATEGORY ID: 991700278     PARENT: 0',0,'72.148.31.116'),(1999,0,0,'2011-06-04 00:39:01','Category Information Updated','CATEGORY NAME: STALLIONS     CATEGORY ID: 989485725     ACTIVE: 1     ALLOW PUBLIC SALES: 0    FEE LISTING: 1',0,'72.148.31.116'),(2000,0,0,'2011-06-04 00:41:05','Category Information Updated','CATEGORY NAME: YEARLINGS     CATEGORY ID: 990724531     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 1',0,'72.148.31.116'),(2001,0,0,'2011-06-04 00:41:46','Category Information Updated','CATEGORY NAME: WEANLINGS     CATEGORY ID: 989490587     ACTIVE: 1     ALLOW PUBLIC SALES: 0    FEE LISTING: 1',0,'72.148.31.116'),(2002,0,0,'2011-06-04 00:46:50','Category Information Updated','CATEGORY NAME: STALLIONS     CATEGORY ID: 989485725     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 1',0,'72.148.31.116'),(2003,0,0,'2011-06-04 01:12:09','Site Defaults Modified','No Details Available',0,'72.148.31.116'),(2004,0,0,'2011-06-04 01:15:30','Access changed','Access changed for Administrator',0,'72.148.31.116'),(2005,0,0,'2011-06-04 01:15:34','Access changed','Access changed for Administrator',0,'72.148.31.116'),(2006,0,0,'2011-06-04 01:18:26','Account Information Updated by Administrator','USER ID: 991498245',0,'72.148.31.116'),(2007,990492839,990906101,'2011-06-04 01:30:48','Bid','BID: 7500',0,'99.118.90.215'),(2008,990492839,991498245,'2011-06-04 01:36:29','Bid','BID: 9000',0,'72.148.31.116'),(2009,0,0,'2011-06-04 01:40:17','Account Information Updated by Administrator','USER ID: 991498245',0,'72.148.31.116'),(2010,0,991498245,'2011-06-04 01:55:06','Future Watch Updated','KEYWORDS: Mare     ENABLED: 1',0,'72.148.31.116'),(2011,989461899,991498245,'2011-06-04 01:58:37','Bid','BID: 600',0,'72.148.31.116'),(2012,989461899,961375758,'2011-06-04 02:05:17','Bid','BID: 610',0,'99.118.90.215'),(2013,0,0,'2011-06-06 21:21:41','Access changed','Access changed for Administrator',0,'99.118.90.215'),(2014,0,992033194,'2011-06-07 17:46:35','Account Created','EMAIL: Bob.huff@knology.net',0,'205.223.0.76'),(2015,0,0,'2011-06-07 17:47:18','Account Confirmation','USER ID: 992033194    NICKNAME: Bobhuff',0,'205.223.0.76'),(2016,991702051,992033194,'2011-06-07 17:54:36','BuyNow','BUYNOW: 7000',0,'205.223.0.76'),(2017,991702051,992033194,'2011-06-07 17:54:36','Buynow email sent to buyer','Buynow: 7000',0,'205.223.0.76'),(2018,991702051,990906101,'2011-06-07 17:54:36','Buynow email sent to seller','Buynow: 7000  	Buyer: 992033194',0,'205.223.0.76'),(2019,0,0,'2011-06-07 21:56:12','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'72.148.31.116'),(2020,0,0,'2011-06-07 21:56:33','Report Ran (Account History)','OUTPUT TYPE: csv     SORT ORDER: nameA     DAYS: 30',0,'72.148.31.116'),(2021,0,0,'2011-06-07 21:56:38','Report Ran (Users Information)','FROM DATE: 06/06/2011    TO DATE: 06/07/2011    OUTPUT TYPE: html     SORT ORDER: nicknameA',0,'203.87.152.6'),(2022,0,0,'2011-06-07 21:56:47','Report Ran (Users Information)','FROM DATE: 06/06/2011    TO DATE: 06/07/2011    OUTPUT TYPE: csv     SORT ORDER: nicknameA',0,'72.148.31.116'),(2023,0,0,'2011-06-08 01:06:33','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'72.148.31.116'),(2024,0,0,'2011-06-08 01:08:09','Report Ran (Transaction Log)','OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30',0,'72.148.31.116'),(2025,0,0,'2011-06-08 01:13:01','Report Ran (Transaction Log)','OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30',0,'72.148.31.116'),(2026,0,0,'2011-06-08 01:15:11','Report Ran (Winning Bidder)','FROM DATE: 06/07/2011    TO DATE: 06/08/2011    OUTPUT TYPE: csv     SORT ORDER: date_endA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.148.31.116'),(2027,0,0,'2011-06-08 01:15:57','Report Ran (Winning Bidder)','FROM DATE: 06/07/2011    TO DATE: 06/08/2011    OUTPUT TYPE: csv     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.148.31.116'),(2028,0,0,'2011-06-08 01:16:14','Report Ran (Winning Bidder)','FROM DATE: 06/01/2011    TO DATE: 06/08/2011    OUTPUT TYPE: csv     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.148.31.116'),(2029,0,0,'2011-06-08 01:25:27','Fee Segment Deleted','DELETED FEE SEGMENT: 00000.00,P,0.05 ',0,'72.148.31.116'),(2030,0,0,'2011-06-13 16:49:10','Report Ran (Account History)','OUTPUT TYPE: csv     SORT ORDER: nameA     DAYS: 30',0,'205.223.0.76'),(2031,0,0,'2011-06-13 17:29:03','Report Ran (Transaction Log)','OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30',0,'72.37.171.84'),(2032,0,0,'2011-06-13 17:31:04','Report Ran (Winning Bidder)','FROM DATE: 06/12/2011    TO DATE: 06/13/2011    OUTPUT TYPE: csv     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.37.171.84'),(2033,0,0,'2011-06-13 17:31:19','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'72.37.171.84'),(2034,0,992667247,'2011-06-15 01:54:08','Account Created','EMAIL: person@somewhere.com',0,'203.87.152.6'),(2035,989514078,991498245,'2011-06-17 18:18:37','BuyNow','BUYNOW: 500',0,'68.222.247.155'),(2036,989514078,991498245,'2011-06-17 18:18:37','Buynow email sent to buyer','Buynow: 500',0,'68.222.247.155'),(2037,989514078,961375758,'2011-06-17 18:18:38','Buynow email sent to seller','Buynow: 500  	Buyer: 991498245',0,'68.222.247.155'),(2038,0,0,'2011-06-17 19:38:51','Update contact','contact updated',0,'203.87.152.6'),(2039,0,0,'2011-06-17 19:39:01','Update about us','About us updated',0,'203.87.152.6'),(2040,992609809,961375758,'2011-06-17 20:03:26','BuyNow','BUYNOW: 15000',0,'203.87.152.6'),(2041,992609809,961375758,'2011-06-17 20:03:27','Buynow email sent to buyer','Buynow: 15000',0,'203.87.152.6'),(2042,992609809,957633228,'2011-06-17 20:03:27','Buynow email sent to seller','Buynow: 15000  	Buyer: 961375758',0,'203.87.152.6'),(2043,0,0,'2011-06-17 22:53:23','Account Information Updated by Administrator','USER ID: 992667247',0,'203.87.152.6'),(2044,990078778,961375758,'2011-06-17 23:02:00','Bid','BID: 50.00',0,'112.204.5.104'),(2045,991666543,992667247,'2011-06-18 00:29:32','Bid','BID: 1000.00',0,'203.87.152.6'),(2046,991666543,992667247,'2011-06-18 00:30:38','Bid','BID: 1010.00',0,'203.87.152.6'),(2047,991666543,992667247,'2011-06-18 00:31:50','Bid','BID: 1020.00',0,'203.87.152.6'),(2048,991666543,992667247,'2011-06-18 00:33:12','Bid','BID: 1030.00',0,'203.87.152.6'),(2049,989461899,992667247,'2011-06-18 00:33:38','Bid','BID: 100.00',0,'203.87.152.6'),(2050,991666543,992667247,'2011-06-18 00:35:52','Bid','BID: 1040.00',0,'203.87.152.6'),(2051,992612447,992667247,'2011-06-18 00:38:08','Bid','BID: 15000.00',0,'203.87.152.6'),(2052,992823550,992667247,'2011-06-18 00:59:29','Bid','BID: 1100.00',0,'203.87.152.6'),(2053,991702051,992667247,'2011-06-18 01:06:11','Bid','BID: 1000.00',0,'203.87.152.6'),(2054,992829594,957633228,'2011-06-18 01:10:09','Bid','BID: 10000.00',0,'112.205.47.229'),(2055,992829594,957633228,'2011-06-18 01:12:17','Bid','BID: 10100.00',0,'112.205.47.229'),(2056,992612447,992667247,'2011-06-18 01:19:24','Bid','BID: 15500.00',0,'203.87.152.6'),(2057,992829594,957633228,'2011-06-18 01:24:08','Bid','BID: 10200.00',0,'112.205.47.229'),(2058,992829594,957633228,'2011-06-18 01:33:32','Bid','BID: 10300.00',0,'112.205.47.229'),(2059,991702051,957633228,'2011-06-18 01:41:35','Bid','BID: 1010.00',0,'112.205.47.229'),(2060,0,0,'2011-06-18 01:49:46','Site Defaults Modified','No Details Available',0,'72.148.31.116'),(2061,992898640,992667247,'2011-06-18 02:24:15','BuyNow','BUYNOW: 150000',0,'203.87.152.6'),(2062,992898640,992667247,'2011-06-18 02:24:15','Buynow email sent to buyer','Buynow: 150000',0,'203.87.152.6'),(2063,992898640,991498245,'2011-06-18 02:24:16','Buynow email sent to seller','Buynow: 150000  	Buyer: 992667247',0,'203.87.152.6'),(2064,989461899,992667247,'2011-06-18 02:40:11','BuyNow','BUYNOW: 500',0,'203.87.152.6'),(2065,989461899,992667247,'2011-06-18 02:40:11','Buynow email sent to buyer','Buynow: 500',0,'203.87.152.6'),(2066,989461899,961375758,'2011-06-18 02:40:11','Buynow email sent to seller','Buynow: 500  	Buyer: 992667247',0,'203.87.152.6'),(2067,992872772,957633228,'2011-06-18 07:13:29','Bid','BID: 3000.00',0,'112.205.47.229'),(2068,992872772,957633228,'2011-06-18 07:15:42','Bid','BID: 3010.00',0,'112.205.47.229'),(2069,992922864,957633228,'2011-06-18 07:21:41','Bid','BID: 11110.00',0,'112.205.47.229'),(2070,0,0,'2011-06-18 13:18:07','Category Created','CATEGORY NAME: Brood Mares     CATEGORY ID: 992967487     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1',0,'72.148.31.116'),(2071,0,0,'2011-06-18 13:18:27','Category Information Updated','CATEGORY NAME: BROOD MARES     CATEGORY ID: 992967487     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 20',0,'72.148.31.116'),(2072,0,0,'2011-06-18 17:12:28','Email addresses updated','Email addresses updated',0,'99.118.90.215'),(2073,0,0,'2011-06-18 10:13:32','Time  updated','Time  updated',0,'99.118.90.215'),(2074,0,0,'2011-06-18 10:13:48','Time zone updated','Time zone updated',0,'99.118.90.215'),(2075,0,0,'2011-06-18 11:03:42','Site Information Updated','No Details Available',0,'99.118.90.215'),(2076,0,0,'2011-06-18 11:05:11','Site Information Updated','No Details Available',0,'99.118.90.215'),(2077,0,0,'2011-06-18 11:09:05','Site Information Updated','No Details Available',0,'99.118.90.215'),(2078,0,0,'2011-06-18 11:11:00','Site Information Updated','No Details Available',0,'99.118.90.215'),(2079,0,0,'2011-06-18 11:13:23','Site Information Updated','No Details Available',0,'99.118.90.215'),(2080,0,0,'2011-06-18 11:14:50','Site Information Updated','No Details Available',0,'99.118.90.215'),(2081,0,0,'2011-06-18 11:17:19','Site Information Updated','No Details Available',0,'99.118.90.215'),(2082,0,0,'2011-06-18 11:18:52','Site Information Updated','No Details Available',0,'99.118.90.215'),(2083,0,0,'2011-06-18 11:21:07','Site Information Updated','No Details Available',0,'99.118.90.215'),(2084,0,0,'2011-06-18 11:22:21','Site Information Updated','No Details Available',0,'99.118.90.215'),(2085,0,0,'2011-06-18 11:22:48','Site Information Updated','No Details Available',0,'99.118.90.215'),(2086,0,0,'2011-06-18 11:24:02','Site Information Updated','No Details Available',0,'99.118.90.215'),(2087,0,0,'2011-06-18 11:24:59','Site Information Updated','No Details Available',0,'99.118.90.215'),(2088,0,0,'2011-06-18 11:27:15','Site Information Updated','No Details Available',0,'99.118.90.215'),(2089,0,0,'2011-06-18 11:27:22','Site Information Updated','No Details Available',0,'99.118.90.215'),(2090,0,0,'2011-06-18 11:28:47','Site Information Updated','No Details Available',0,'99.118.90.215'),(2091,0,0,'2011-06-18 11:28:52','Site Information Updated','No Details Available',0,'99.118.90.215'),(2092,0,0,'2011-06-18 11:31:36','Update about us','About us updated',0,'99.118.90.215'),(2093,0,0,'2011-06-18 11:36:35','Site Information Updated','No Details Available',0,'99.118.90.215'),(2094,0,0,'2011-06-18 11:40:40','Site Information Updated','No Details Available',0,'99.118.90.215'),(2095,0,0,'2011-06-18 11:42:12','Site Information Updated','No Details Available',0,'99.118.90.215'),(2096,0,0,'2011-06-18 11:43:24','Site Information Updated','No Details Available',0,'99.118.90.215'),(2097,0,0,'2011-06-18 11:44:10','Site Information Updated','No Details Available',0,'99.118.90.215'),(2098,0,0,'2011-06-18 11:44:14','Site Information Updated','No Details Available',0,'99.118.90.215'),(2099,0,0,'2011-06-18 11:51:17','site caching updated','site caching updated',0,'99.118.90.215'),(2100,0,0,'2011-06-19 10:13:05','Site Information Updated','No Details Available',0,'99.118.90.215'),(2101,0,0,'2011-06-19 10:13:10','Site Information Updated','No Details Available',0,'99.118.90.215'),(2102,0,0,'2011-06-19 10:53:05','Site Information Updated','No Details Available',0,'99.118.90.215'),(2103,0,0,'2011-06-19 11:10:20','site caching updated','site caching updated',0,'99.118.90.215'),(2104,989446481,957633228,'2011-06-19 16:10:16','Bid','BID: 50.00',0,'112.205.47.229'),(2105,989446481,957633228,'2011-06-19 16:11:32','Bid','BID: 60.00',0,'112.205.47.229'),(2106,990078778,957633228,'2011-06-19 16:14:23','Bid','BID: 51.00',0,'112.205.47.229'),(2107,991666543,961375758,'2011-06-19 16:18:51','Bid','BID: 1050.00',0,'112.205.47.229'),(2108,991666543,961375758,'2011-06-19 16:45:06','Bid','BID: 1060.00',0,'112.205.47.229'),(2109,992898640,961375758,'2011-06-19 16:45:40','Bid','BID: 151000.00',0,'112.205.47.229'),(2110,992922864,961375758,'2011-06-19 16:45:57','Bid','BID: 11120.00',0,'112.205.47.229'),(2111,992922864,957633228,'2011-06-19 16:46:42','Bid','BID: 11130.00',0,'112.205.47.229'),(2112,991666543,957633228,'2011-06-19 16:59:21','Bid','BID: 1070.00',0,'112.205.47.229'),(2113,992922864,957633228,'2011-06-19 17:04:44','Bid','BID: 11140.00',0,'112.205.47.229'),(2114,0,0,'2011-06-19 18:07:18','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2115,0,0,'2011-06-19 18:07:25','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2116,0,0,'2011-06-19 18:07:41','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2117,0,0,'2011-06-19 18:08:56','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2118,0,0,'2011-06-19 18:09:09','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2119,0,0,'2011-06-19 19:10:00','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2120,0,0,'2011-06-19 19:10:11','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2121,0,0,'2011-06-19 19:11:42','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2122,0,0,'2011-06-19 19:12:28','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2123,0,0,'2011-06-19 19:12:55','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2124,0,0,'2011-06-19 19:17:49','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2125,992898640,991498245,'2011-06-19 19:18:55','Bid','BID: 152000',0,'72.148.31.116'),(2126,0,0,'2011-06-20 03:09:22','Update Term and conditions','Term and conditions updated',0,'99.118.90.215'),(2127,990474959,991498245,'2011-06-20 04:55:56','BuyNow','BUYNOW: 25000',0,'205.223.0.76'),(2128,990474959,991498245,'2011-06-20 04:55:56','Buynow email sent to buyer','Buynow: 25000',0,'205.223.0.76'),(2129,990474959,957633228,'2011-06-20 04:55:56','Buynow email sent to seller','Buynow: 25000  	Buyer: 991498245',0,'205.223.0.76'),(2130,0,0,'2011-06-20 05:17:32','Site Information Updated','No Details Available',0,'205.223.0.76'),(2131,0,0,'2011-06-20 05:19:27','Site Information Updated','No Details Available',0,'205.223.0.76'),(2132,0,0,'2011-06-20 08:54:22','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'72.37.171.84'),(2133,0,0,'2011-06-20 08:54:55','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90',0,'72.37.171.84'),(2134,0,0,'2011-06-20 08:55:38','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90',0,'72.37.171.84'),(2135,0,0,'2011-06-20 08:56:07','Report Ran (Winning Bidder)','FROM DATE: 01/19/2011    TO DATE: 06/20/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.37.171.84'),(2136,0,0,'2011-06-20 08:57:13','Report Ran (Transaction Log)','OUTPUT TYPE: html     SORT ORDER: dateA     DAYS: 90',0,'72.37.171.84'),(2137,0,0,'2011-06-20 09:04:52','Site Information Updated','No Details Available',0,'72.37.171.84'),(2138,991666543,990906101,'2011-06-20 11:19:21','BuyNow','BUYNOW: 25000',0,'99.118.90.215'),(2139,991666543,990906101,'2011-06-20 11:19:21','Buynow email sent to buyer','Buynow: 25000',0,'99.118.90.215'),(2140,991666543,991498245,'2011-06-20 11:19:21','Buynow email sent to seller','Buynow: 25000  	Buyer: 990906101',0,'99.118.90.215'),(2141,0,993179094,'2011-06-20 17:04:54','Account Created','EMAIL: Jm18488@bellsouth.net',0,'72.148.31.116'),(2142,991702051,991498245,'2011-06-20 17:28:45','BuyNow','BUYNOW: 7000',0,'72.148.31.116'),(2143,991702051,991498245,'2011-06-20 17:28:46','Buynow email sent to buyer','Buynow: 7000',0,'72.148.31.116'),(2144,991702051,990906101,'2011-06-20 17:28:46','Buynow email sent to seller','Buynow: 7000  	Buyer: 991498245',0,'72.148.31.116'),(2145,0,0,'2011-06-20 17:41:06','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'72.148.31.116'),(2146,0,0,'2011-06-20 17:42:07','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90',0,'72.148.31.116'),(2147,0,0,'2011-06-20 17:42:11','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'99.118.90.215'),(2148,0,0,'2011-06-20 17:42:33','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90',0,'72.148.31.116'),(2149,0,0,'2011-06-20 17:42:45','Report Ran (Winning Bidder)','FROM DATE: 06/19/2011    TO DATE: 06/20/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'99.118.90.215'),(2150,0,0,'2011-06-20 17:43:49','Report Ran (Winning Bidder)','FROM DATE: 06/1/2011    TO DATE: 06/20/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.148.31.116'),(2151,0,0,'2011-06-20 17:44:19','Report Ran (Winning Bidder)','FROM DATE: 06/19/2011    TO DATE: 06/20/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'99.118.90.215'),(2152,0,0,'2011-06-20 17:45:08','Report Ran (Winning Bidder)','FROM DATE: 06/19/2011    TO DATE: 06/20/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'99.118.90.215'),(2153,0,0,'2011-06-20 17:45:31','Report Ran (Winning Bidder)','FROM DATE: 06/01/2010    TO DATE: 06/20/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.148.31.116'),(2154,0,0,'2011-06-20 18:35:06','Site Information Updated','No Details Available',0,'112.205.47.229'),(2155,0,0,'2011-06-20 18:35:43','Site Information Updated','No Details Available',0,'112.205.47.229'),(2156,0,0,'2011-06-20 18:37:18','Site Information Updated','No Details Available',0,'112.205.47.229'),(2157,0,0,'2011-06-20 19:15:49','Site Defaults Modified','No Details Available',0,'112.205.47.229'),(2158,0,0,'2011-06-20 19:25:23','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2159,0,0,'2011-06-20 19:26:06','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2160,0,0,'2011-06-20 19:57:31','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2161,0,0,'2011-06-20 19:57:40','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2162,0,0,'2011-06-20 20:06:57','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2163,0,0,'2011-06-20 20:13:27','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2164,0,0,'2011-06-20 20:13:58','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2165,0,0,'2011-06-20 20:15:11','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2166,0,0,'2011-06-20 20:16:13','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2167,0,0,'2011-06-20 20:21:12','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2168,0,0,'2011-06-20 20:21:27','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2169,0,0,'2011-06-20 20:23:08','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2170,0,0,'2011-06-20 22:58:01','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2171,0,0,'2011-06-20 22:58:12','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2172,989514078,957633228,'2011-06-20 22:59:17','BuyNow','BUYNOW: 500',0,'112.205.47.229'),(2173,989514078,957633228,'2011-06-20 22:59:17','Buynow email sent to buyer','Buynow: 500',0,'112.205.47.229'),(2174,989514078,961375758,'2011-06-20 22:59:18','Buynow email sent to seller','Buynow: 500  	Buyer: 957633228',0,'112.205.47.229'),(2175,0,0,'2011-06-20 23:13:10','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2176,0,0,'2011-06-20 23:13:23','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2177,0,0,'2011-06-20 23:14:14','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2178,0,0,'2011-06-20 23:14:39','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 30',0,'112.205.47.229'),(2179,0,0,'2011-06-20 23:30:27','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 60',0,'112.205.47.229'),(2180,0,0,'2011-06-20 23:30:55','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2181,0,0,'2011-06-20 23:43:39','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2182,0,0,'2011-06-20 23:58:16','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2183,0,0,'2011-06-21 00:09:01','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2184,989514078,957633228,'2011-06-21 00:18:52','Bid','BID: 500.00',0,'112.205.47.229'),(2185,0,0,'2011-06-21 00:20:04','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2186,0,0,'2011-06-21 00:20:14','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2187,0,0,'2011-06-21 00:21:33','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2188,0,0,'2011-06-21 00:31:10','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2189,0,0,'2011-06-21 00:32:45','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2190,0,0,'2011-06-21 00:36:04','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2191,0,0,'2011-06-21 00:36:50','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2192,0,0,'2011-06-21 00:39:20','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2193,0,0,'2011-06-21 00:39:29','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2194,989514078,961375758,'2011-06-21 00:55:44','Auction Invoiced','No Details Available',20.4,'112.205.47.229'),(2195,989514078,961375758,'2011-06-21 00:55:44','Auction Expired','No Details Available',0,'112.205.47.229'),(2196,989514078,961375758,'2011-06-21 00:55:44','Auction Results emailed to Seller','Item Number: 989514078\r\nItem Title: Swift September\r\nDate Started: 05/09/2011 15:01:00\r\nDate Ended: 06/21/2011 15:01:00\r\nAuction Type: English\r\n\r\nQualified bidders in order of rank, highest to lowest\r\n\r\nNickname: douglas\r\nEmail: dickcaadan@yahoo.com.ph\r\nRank: 1\r\nQuantity desired: 1\r\nPrice:         510.00 USD\r\nShipping address is the same as billing address.\r\nBilling address: 1111111\r\n                 Buena Park, Connecticut 90621\r\n                 USA\r\n\r\nPlease contact these winners as soon as possible.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=989514078\r\n\r\n',0,'112.205.47.229'),(2197,989514078,957633228,'2011-06-21 00:55:44','Auction Results emailed to Bidder','Item Number: 989514078\r\nItem Title: Swift September\r\nSeller\'s Nickname: dick\r\nSeller\'s Email: dickcaadan@yahoo.com.ph\r\nDate Started: 05/09/2011 15:01:00\r\nDate Ended: 06/21/2011 15:01:00\r\nAuction Type: English\r\n\r\nYour Nickname: douglas\r\nRank: 1\r\nQuantity desired: 1\r\nQuantity available: 1\r\nPrice:         510.00 USD\r\n\r\nSales Tax Rate: 0 %\r\nSales Tax:           0.00 USD\r\n\r\nAdministrative Fee:           0.00 USD\r\nFinancial Fee:           0.00 USD\r\nBuyer\'s Premium:          51.00 USD\r\nShipping Fee:           0.00 USD\r\n\r\nTotal:         561.00 USD\r\n\r\nPlease contact the seller as soon as possible.\r\n\r\nClick here for the complete results of this auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=989514078\r\n\r\n',0,'112.205.47.229'),(2198,0,0,'2011-06-21 00:57:10','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2199,0,0,'2011-06-21 01:27:19','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2200,0,0,'2011-06-21 01:27:27','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2201,0,0,'2011-06-21 01:27:46','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2202,989514078,961375758,'2011-06-21 01:30:03','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2203,989514078,961375758,'2011-06-21 01:30:03','Auction Expired','No Details Available',0,'174.122.143.37'),(2204,989514078,961375758,'2011-06-21 01:30:03','Auction Results emailed to Seller','Item Number: 989514078\r\nItem Title: Swift September\r\nDate Started: 05/09/2011 15:01:00\r\nDate Ended: 06/21/2011 15:01:00\r\nAuction Type: English\r\n\r\nQualified bidders in order of rank, highest to lowest\r\n\r\nNickname: douglas\r\nEmail: dickcaadan@yahoo.com.ph\r\nRank: 1\r\nQuantity desired: 1\r\nPrice:         510.00 USD\r\nShipping address is the same as billing address.\r\nBilling address: 1111111\r\n                 Buena Park, Connecticut 90621\r\n                 USA\r\n\r\nPlease contact these winners as soon as possible.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=989514078\r\n\r\n',0,'174.122.143.37'),(2205,989514078,957633228,'2011-06-21 01:30:03','Auction Results emailed to Bidder','Item Number: 989514078\r\nItem Title: Swift September\r\nSeller\'s Nickname: dick\r\nSeller\'s Email: dickcaadan@yahoo.com.ph\r\nDate Started: 05/09/2011 15:01:00\r\nDate Ended: 06/21/2011 15:01:00\r\nAuction Type: English\r\n\r\nYour Nickname: douglas\r\nRank: 1\r\nQuantity desired: 1\r\nQuantity available: 1\r\nPrice:         510.00 USD\r\n\r\nSales Tax Rate: 0 %\r\nSales Tax:           0.00 USD\r\n\r\nAdministrative Fee:           0.00 USD\r\nFinancial Fee:           0.00 USD\r\nBuyer\'s Premium:          51.00 USD\r\nShipping Fee:           0.00 USD\r\n\r\nTotal:         561.00 USD\r\n\r\nPlease contact the seller as soon as possible.\r\n\r\nClick here for the complete results of this auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=989514078\r\n\r\n',0,'174.122.143.37'),(2206,990474959,957633228,'2011-06-21 01:30:03','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2207,990474959,957633228,'2011-06-21 01:30:03','Auction Expired','No Details Available',0,'174.122.143.37'),(2208,990474959,957633228,'2011-06-21 01:30:03','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=990474959\r\n\r\n',0,'174.122.143.37'),(2209,0,0,'2011-06-21 01:32:27','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2210,0,0,'2011-06-21 01:32:41','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2211,989461899,961375758,'2011-06-21 02:00:03','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2212,989461899,961375758,'2011-06-21 02:00:03','Auction Expired','No Details Available',0,'174.122.143.37'),(2213,989461899,961375758,'2011-06-21 02:00:03','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=989461899\r\n\r\n',0,'174.122.143.37'),(2214,989514078,961375758,'2011-06-21 02:00:03','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2215,989514078,961375758,'2011-06-21 02:00:04','Auction Expired','No Details Available',0,'174.122.143.37'),(2216,989514078,961375758,'2011-06-21 02:00:04','Auction Results emailed to Seller','Item Number: 989514078\r\nItem Title: Swift September\r\nDate Started: 05/09/2011 15:01:00\r\nDate Ended: 06/21/2011 15:01:00\r\nAuction Type: English\r\n\r\nQualified bidders in order of rank, highest to lowest\r\n\r\nNickname: douglas\r\nEmail: dickcaadan@yahoo.com.ph\r\nRank: 1\r\nQuantity desired: 1\r\nPrice:         510.00 USD\r\nShipping address is the same as billing address.\r\nBilling address: 1111111\r\n                 Buena Park, Connecticut 90621\r\n                 USA\r\n\r\nPlease contact these winners as soon as possible.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=989514078\r\n\r\n',0,'174.122.143.37'),(2217,989514078,957633228,'2011-06-21 02:00:04','Auction Results emailed to Bidder','Item Number: 989514078\r\nItem Title: Swift September\r\nSeller\'s Nickname: dick\r\nSeller\'s Email: dickcaadan@yahoo.com.ph\r\nDate Started: 05/09/2011 15:01:00\r\nDate Ended: 06/21/2011 15:01:00\r\nAuction Type: English\r\n\r\nYour Nickname: douglas\r\nRank: 1\r\nQuantity desired: 1\r\nQuantity available: 1\r\nPrice:         510.00 USD\r\n\r\nSales Tax Rate: 0 %\r\nSales Tax:           0.00 USD\r\n\r\nAdministrative Fee:           0.00 USD\r\nFinancial Fee:           0.00 USD\r\nBuyer\'s Premium:          51.00 USD\r\nShipping Fee:           0.00 USD\r\n\r\nTotal:         561.00 USD\r\n\r\nPlease contact the seller as soon as possible.\r\n\r\nClick here for the complete results of this auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=989514078\r\n\r\n',0,'174.122.143.37'),(2218,990474959,957633228,'2011-06-21 02:00:04','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2219,990474959,957633228,'2011-06-21 02:00:04','Auction Expired','No Details Available',0,'174.122.143.37'),(2220,990474959,957633228,'2011-06-21 02:00:04','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=990474959\r\n\r\n',0,'174.122.143.37'),(2221,991666543,991498245,'2011-06-21 02:00:04','Auction Invoiced','No Details Available',20.1,'174.122.143.37'),(2222,991666543,991498245,'2011-06-21 02:00:04','Auction Expired','No Details Available',0,'174.122.143.37'),(2223,991666543,991498245,'2011-06-21 02:00:04','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=991666543\r\n\r\n',0,'174.122.143.37'),(2224,991702051,990906101,'2011-06-21 02:00:04','Auction Invoiced','No Details Available',20.25,'174.122.143.37'),(2225,991702051,990906101,'2011-06-21 02:00:04','Auction Expired','No Details Available',0,'174.122.143.37'),(2226,991702051,990906101,'2011-06-21 02:00:04','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=991702051\r\n\r\n',0,'174.122.143.37'),(2227,992609809,957633228,'2011-06-21 02:00:04','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2228,992609809,957633228,'2011-06-21 02:00:04','Auction Expired','No Details Available',0,'174.122.143.37'),(2229,992609809,957633228,'2011-06-21 02:00:04','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992609809\r\n\r\n',0,'174.122.143.37'),(2230,0,0,'2011-06-21 02:23:00','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2231,0,0,'2011-06-21 02:23:20','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'112.205.47.229'),(2232,0,0,'2011-06-21 06:20:56','Account Information Updated by Administrator','USER ID: 993179094',0,'68.222.247.155'),(2233,0,0,'2011-06-21 06:22:07','Account Deactivated by Administrator','USER ID: 993179094',0,'68.222.247.155'),(2234,0,0,'2011-06-21 06:23:44','Account Information Updated by Administrator','USER ID: 993179094',0,'72.37.171.84'),(2235,0,0,'2011-06-21 06:26:24','Account Deleted by Administrator','USER ID: 993179094',0,'72.37.171.84'),(2236,0,993227310,'2011-06-21 06:28:30','Account Created','EMAIL: jm18488@bellsouth.net',0,'72.37.171.84'),(2237,0,0,'2011-06-21 06:30:46','Site Information Updated','No Details Available',0,'72.37.171.84'),(2238,0,0,'2011-06-21 06:40:00','Account Information Updated by Administrator','USER ID: 993227310',0,'72.37.171.84'),(2239,0,0,'2011-06-21 06:42:02','Site Defaults Modified','No Details Available',0,'72.37.171.84'),(2240,0,0,'2011-06-21 15:50:30','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90',0,'72.148.31.116'),(2241,0,0,'2011-06-21 15:51:47','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90',0,'72.148.31.116'),(2242,0,0,'2011-06-21 15:52:22','Report Ran (Account History)','OUTPUT TYPE: html     SORT ORDER: nameA     DAYS: 90',0,'72.148.31.116'),(2243,0,0,'2011-06-21 15:54:23','Report Ran (Transaction Log)','OUTPUT TYPE: html     SORT ORDER: dateA     DAYS: 90',0,'72.148.31.116'),(2244,0,0,'2011-06-21 15:55:08','Report Ran (Transaction Log)','OUTPUT TYPE: html     SORT ORDER: dateA     DAYS: 90',0,'72.148.31.116'),(2245,0,0,'2011-06-21 15:56:03','Report Ran (Winning Bidder)','FROM DATE: 03/20/2011    TO DATE: 06/21/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.148.31.116'),(2246,0,0,'2011-06-21 15:57:09','Site Information Updated','No Details Available',0,'72.148.31.116'),(2247,0,0,'2011-06-21 15:57:31','Report Ran (Users Information)','FROM DATE: 06/20/2011    TO DATE: 06/21/2011    OUTPUT TYPE: html     SORT ORDER: nicknameA',0,'72.148.31.116'),(2248,992612447,991498245,'2011-06-21 16:35:33','Bid','BID: 20000',0,'72.148.31.116'),(2249,0,0,'2011-06-21 16:40:31','Site Information Updated','No Details Available',0,'72.148.31.116'),(2250,992829594,990906101,'2011-06-21 16:48:22','BuyNow','BUYNOW: 15000',0,'99.118.90.215'),(2251,992829594,990906101,'2011-06-21 16:48:22','Buynow email sent to buyer','Buynow: 15000',0,'99.118.90.215'),(2252,992829594,957633228,'2011-06-21 16:48:22','Buynow email sent to seller','Buynow: 15000  	Buyer: 990906101',0,'99.118.90.215'),(2253,992829594,957633228,'2011-06-21 16:50:06','Auction Invoiced','No Details Available',20.1,'174.122.143.37'),(2254,992829594,957633228,'2011-06-21 16:50:06','Auction Expired','No Details Available',0,'174.122.143.37'),(2255,992829594,957633228,'2011-06-21 16:50:06','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992829594\r\n\r\n',0,'174.122.143.37'),(2256,992823550,990906101,'2011-06-21 16:53:40','BuyNow','BUYNOW: 1500',0,'99.118.90.215'),(2257,992823550,990906101,'2011-06-21 16:53:40','Buynow email sent to buyer','Buynow: 1500',0,'99.118.90.215'),(2258,992823550,957633228,'2011-06-21 16:53:40','Buynow email sent to seller','Buynow: 1500  	Buyer: 990906101',0,'99.118.90.215'),(2259,0,0,'2011-06-21 16:59:17','Report Ran (Winning Bidder)','FROM DATE: 06/20/2011    TO DATE: 06/21/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'72.148.31.116'),(2260,0,0,'2011-06-21 16:59:24','Report Ran (Winning Bidder)','FROM DATE: 06/20/2011    TO DATE: 06/21/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'99.118.90.215'),(2261,992823550,957633228,'2011-06-21 17:00:05','Auction Invoiced','No Details Available',20.1,'174.122.143.37'),(2262,992823550,957633228,'2011-06-21 17:00:05','Auction Expired','No Details Available',0,'174.122.143.37'),(2263,992823550,957633228,'2011-06-21 17:00:05','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992823550\r\n\r\n',0,'174.122.143.37'),(2264,0,993265508,'2011-06-21 17:05:08','Account Created','EMAIL: drmac15@bellsouth.net',0,'72.148.31.116'),(2265,0,0,'2011-06-21 17:49:45','Account Confirmation','USER ID: 993265508    NICKNAME: palomino15',0,'72.148.31.116'),(2266,993306146,991498245,'2011-06-22 04:23:05','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2267,993306390,991498245,'2011-06-22 04:28:49','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2268,993306535,991498245,'2011-06-22 04:29:29','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2269,0,0,'2011-06-22 04:43:28','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2270,0,0,'2011-06-22 04:44:24','Account Information Updated by Administrator','USER ID: 993265508',0,'68.222.247.155'),(2271,0,0,'2011-06-22 04:49:32','Report Ran (Transaction Log)','OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 90',0,'68.222.247.155'),(2272,0,0,'2011-06-22 05:21:43','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2273,0,0,'2011-06-22 05:26:36','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2274,0,0,'2011-06-22 05:27:12','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2275,0,0,'2011-06-22 05:27:27','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2276,0,0,'2011-06-22 05:28:16','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2277,0,0,'2011-06-22 05:29:01','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2278,993325708,991498245,'2011-06-22 09:48:56','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2279,993325738,991498245,'2011-06-22 09:49:15','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2280,993325757,991498245,'2011-06-22 09:49:35','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2281,993325778,991498245,'2011-06-22 09:49:52','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2282,993325795,991498245,'2011-06-22 09:50:09','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2283,993325812,991498245,'2011-06-22 09:50:23','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2284,993325825,991498245,'2011-06-22 09:50:38','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2285,993325840,991498245,'2011-06-22 09:50:52','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2286,993325856,991498245,'2011-06-22 09:51:11','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2287,993325873,991498245,'2011-06-22 09:51:25','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2288,993325890,991498245,'2011-06-22 09:51:47','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2289,993325909,991498245,'2011-06-22 09:52:08','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2290,993325930,991498245,'2011-06-22 09:52:30','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2291,993325952,991498245,'2011-06-22 09:52:50','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2292,993325972,991498245,'2011-06-22 09:53:08','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2293,993325991,991498245,'2011-06-22 09:53:24','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2294,993326006,991498245,'2011-06-22 09:53:45','Advertisement Application','http://www.yahoo.com',0,'68.222.247.155'),(2295,0,0,'2011-06-23 09:06:45','Update meta description information','Meta description information updated',0,'68.222.247.155'),(2296,0,0,'2011-06-23 09:07:41','Update meta keywords information','Meta keywords information updated',0,'68.222.247.155'),(2297,0,0,'2011-06-23 09:11:28','Update meta keywords information','Meta keywords information updated',0,'68.222.247.155'),(2298,0,0,'2011-06-23 09:45:21','Site Information Updated','No Details Available',0,'68.222.247.155'),(2299,0,0,'2011-06-23 09:46:31','Site Information Updated','No Details Available',0,'68.222.247.155'),(2300,0,0,'2011-06-23 09:46:48','Site Information Updated','No Details Available',0,'68.222.247.155'),(2301,0,0,'2011-06-23 09:47:47','Site Information Updated','No Details Available',0,'68.222.247.155'),(2302,0,0,'2011-06-23 09:47:54','Site Information Updated','No Details Available',0,'68.222.247.155'),(2303,0,0,'2011-06-23 09:49:45','Site Information Updated','No Details Available',0,'68.222.247.155'),(2304,0,0,'2011-06-23 09:51:56','Update Term and conditions','Term and conditions updated',0,'68.222.247.155'),(2305,0,0,'2011-06-23 09:55:51','Update Term and conditions','Term and conditions updated',0,'68.222.247.155'),(2306,0,0,'2011-06-23 09:57:35','Site Information Updated','No Details Available',0,'68.222.247.155'),(2307,0,0,'2011-06-23 10:00:26','Site Information Updated','No Details Available',0,'68.222.247.155'),(2308,0,0,'2011-06-23 10:00:58','Site Information Updated','No Details Available',0,'68.222.247.155'),(2309,0,0,'2011-06-23 10:07:23','Site Information Updated','No Details Available',0,'99.118.90.215'),(2310,0,0,'2011-06-23 10:07:31','Site Information Updated','No Details Available',0,'99.118.90.215'),(2311,0,0,'2011-06-23 10:09:08','Site Information Updated','No Details Available',0,'68.222.247.155'),(2312,0,0,'2011-06-23 10:13:41','Site Information Updated','No Details Available',0,'99.118.90.215'),(2313,0,0,'2011-06-23 10:14:02','Site Information Updated','No Details Available',0,'99.118.90.215'),(2314,0,0,'2011-06-23 10:44:42','Site Information Updated','No Details Available',0,'68.222.247.155'),(2315,0,0,'2011-06-23 11:09:16','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2316,0,0,'2011-06-23 11:15:39','Site Information Updated','No Details Available',0,'68.222.247.155'),(2317,0,0,'2011-06-23 11:22:18','Update Term and conditions','Term and conditions updated',0,'68.222.247.155'),(2318,0,0,'2011-06-23 11:28:35','Site Information Updated','No Details Available',0,'68.222.247.155'),(2319,0,0,'2011-06-23 11:29:17','Update Term and conditions','Term and conditions updated',0,'68.222.247.155'),(2320,0,0,'2011-06-23 11:29:49','Update Term and conditions','Term and conditions updated',0,'68.222.247.155'),(2321,0,0,'2011-06-24 05:52:47','site caching updated','site caching updated',0,'68.222.247.155'),(2322,0,0,'2011-06-24 05:53:30','Site Information Updated','No Details Available',0,'68.222.247.155'),(2323,0,0,'2011-06-24 05:54:19','Site Information Updated','No Details Available',0,'68.222.247.155'),(2324,0,0,'2011-06-24 05:55:05','Site Information Updated','No Details Available',0,'68.222.247.155'),(2325,0,0,'2011-06-24 05:56:07','Site Information Updated','No Details Available',0,'68.222.247.155'),(2326,0,0,'2011-06-24 05:57:43','Site Information Updated','No Details Available',0,'68.222.247.155'),(2327,0,0,'2011-06-27 05:04:57','Site Information Updated','No Details Available',0,'99.118.90.215'),(2328,0,0,'2011-06-27 05:05:03','Site Information Updated','No Details Available',0,'99.118.90.215'),(2329,0,993931328,'2011-06-29 10:02:09','Account Created','EMAIL: info@tpfarms.com',0,'99.118.90.215'),(2330,0,0,'2011-06-29 10:08:35','Account Confirmation','USER ID: 993931328    NICKNAME: tpreiner',0,'99.118.90.215'),(2331,993829590,990906101,'2011-06-29 10:19:47','BuyNow','BUYNOW: 3500',0,'99.118.90.215'),(2332,993829590,990906101,'2011-06-29 10:19:47','Buynow email sent to buyer','Buynow: 3500',0,'99.118.90.215'),(2333,993829590,991498245,'2011-06-29 10:19:47','Buynow email sent to seller','Buynow: 3500  	Buyer: 990906101',0,'99.118.90.215'),(2334,993829590,991498245,'2011-06-29 10:20:04','Auction Invoiced','No Details Available',20.1,'174.122.143.37'),(2335,993829590,991498245,'2011-06-29 10:20:05','Auction Expired','No Details Available',0,'174.122.143.37'),(2336,993829590,991498245,'2011-06-29 10:20:05','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=993829590\r\n\r\n',0,'174.122.143.37'),(2337,0,0,'2011-06-29 11:32:35','Report Ran (Winning Bidder)','FROM DATE: 06/28/2011    TO DATE: 06/29/2011    OUTPUT TYPE: html     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0',0,'99.118.90.215'),(2338,0,0,'2011-06-29 11:34:17','Auction Duration Deleted','DELETED DURATION: 0001',0,'99.118.90.215'),(2339,0,0,'2011-06-29 11:34:26','Auction Duration Deleted','DELETED DURATION: 0002',0,'99.118.90.215'),(2340,0,0,'2011-06-29 11:34:33','Auction Duration Deleted','DELETED DURATION: 0003',0,'99.118.90.215'),(2341,0,0,'2011-06-29 11:34:40','Auction Duration Deleted','DELETED DURATION: 0004',0,'99.118.90.215'),(2342,0,0,'2011-06-29 11:34:46','Auction Duration Deleted','DELETED DURATION: 0005',0,'99.118.90.215'),(2343,0,0,'2011-06-29 11:34:53','Auction Duration Deleted','DELETED DURATION: 0006',0,'99.118.90.215'),(2344,0,0,'2011-06-29 11:35:00','Auction Duration Deleted','DELETED DURATION: 0007',0,'99.118.90.215'),(2345,0,0,'2011-06-29 11:35:07','Auction Duration Deleted','DELETED DURATION: 0009',0,'99.118.90.215'),(2346,0,0,'2011-06-29 11:35:15','Auction Duration Deleted','DELETED DURATION: 0010',0,'99.118.90.215'),(2347,0,0,'2011-06-29 11:35:21','Auction Duration Deleted','DELETED DURATION: 0021',0,'99.118.90.215'),(2348,0,0,'2011-06-29 11:35:28','Auction Duration Added','NEW DURATION: 0060',0,'99.118.90.215'),(2349,0,0,'2011-06-29 11:35:36','Auction Duration Added','NEW DURATION: 0090',0,'99.118.90.215'),(2350,0,0,'2011-06-29 11:36:18','Bidding Increment Deleted','DELETED BIDDING INCREMENT: 0.5',0,'99.118.90.215'),(2351,0,0,'2011-06-29 11:38:35','Site Defaults Modified','No Details Available',0,'99.118.90.215'),(2352,0,0,'2011-07-01 04:14:27','Update meta description information','Meta description information updated',0,'68.222.247.155'),(2353,989446481,961375758,'2011-07-02 11:50:04','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2354,989446481,961375758,'2011-07-02 11:50:04','Auction Expired','No Details Available',0,'174.122.143.37'),(2355,989446481,961375758,'2011-07-02 11:50:04','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=989446481\r\n\r\n',0,'174.122.143.37'),(2356,990078778,961375758,'2011-07-02 11:50:05','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2357,990078778,961375758,'2011-07-02 11:50:05','Auction Expired','No Details Available',0,'174.122.143.37'),(2358,990078778,961375758,'2011-07-02 11:50:05','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=990078778\r\n\r\n',0,'174.122.143.37'),(2359,990492839,957633228,'2011-07-02 11:50:05','Auction Invoiced','No Details Available',20.4,'174.122.143.37'),(2360,990492839,957633228,'2011-07-02 11:50:05','Auction Expired','No Details Available',0,'174.122.143.37'),(2361,990492839,957633228,'2011-07-02 11:50:05','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=990492839\r\n\r\n',0,'174.122.143.37'),(2362,993916308,990906101,'2011-07-09 16:05:18','Bid','BID: 100000.00',0,'99.118.90.215'),(2363,0,995322690,'2011-07-15 12:31:30','Account Created','EMAIL: sylvz101@yahoo.com',0,'112.198.133.217'),(2364,0,0,'2011-07-15 12:35:00','Account Confirmation','USER ID: 995322690    NICKNAME: greggy',0,'112.198.133.217'),(2365,0,0,'2011-07-15 12:35:16','Account Confirmation','USER ID: 995322690    NICKNAME: greggy',0,'112.198.133.217'),(2366,0,0,'2011-07-15 17:28:14','Update Term and conditions','Term and conditions updated',0,'112.198.133.217'),(2367,0,0,'2011-07-15 17:28:46','Update Term and conditions','Term and conditions updated',0,'112.198.133.217'),(2368,993247373,995322690,'2011-07-18 12:50:05','Bid','BID: 5000',0,'222.127.223.70'),(2369,993262620,995322690,'2011-07-18 13:00:35','BuyNow','BUYNOW: 35050',0,'222.127.223.70'),(2370,993262620,995322690,'2011-07-18 13:00:35','Buynow email sent to buyer','Buynow: 35050',0,'222.127.223.70'),(2371,993262620,991498245,'2011-07-18 13:00:35','Buynow email sent to seller','Buynow: 35050  	Buyer: 995322690',0,'222.127.223.70'),(2372,995756079,995322690,'2011-07-20 12:55:25','Advertisement Application','http://www.facebook.com',0,'222.127.223.71'),(2373,995758691,993931328,'2011-07-20 13:53:26','Bid','BID: 12.00',0,'222.127.223.71'),(2374,995758144,993931328,'2011-07-20 13:54:18','Bid','BID: 12.00',0,'222.127.223.71'),(2375,993829282,993931328,'2011-07-20 13:55:23','Bid','BID: 10000.00',0,'222.127.223.71'),(2376,995759933,995322690,'2011-07-20 14:04:52','Bid','BID: 12.00',0,'222.127.223.71'),(2377,0,0,'2011-07-20 15:55:20','Site Defaults Modified','No Details Available',0,'222.127.223.71'),(2378,992829594,0,'2011-07-20 20:27:50','Invoice Updated',' REFERENCE: automated billing: no changes  ',0,'222.127.223.71'),(2379,991702051,990906101,'2011-07-20 20:30:13','Payment','No Details Available',20.25,'222.127.223.71'),(2380,991702051,0,'2011-07-20 20:30:43','Invoice Updated',' REFERENCE: automated billing: no changes  ',0,'222.127.223.71'),(2381,0,0,'2011-07-21 12:08:41','Site Defaults Modified','No Details Available',0,'222.127.223.70'),(2382,0,0,'2011-07-21 13:41:25','Access changed','Access changed for Administrator',0,'112.206.140.87'),(2383,0,0,'2011-07-21 13:54:22','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2384,0,0,'2011-07-21 13:54:23','Site Defaults Modified','No Details Available',0,'112.206.140.87'),(2385,0,0,'2011-07-21 14:30:00','Report Ran (Account History)','OUTPUT TYPE: html     SORT ORDER: nameA     DAYS: 30',0,'99.118.90.215'),(2386,0,0,'2011-07-21 14:30:19','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'112.206.140.87'),(2387,0,0,'2011-07-21 14:30:27','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7',0,'68.222.247.155'),(2388,0,0,'2011-07-21 14:30:56','Report Ran (Completed Auctions)','OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 90',0,'68.222.247.155'),(2389,0,0,'2011-07-21 14:34:53','Account Created & Finalized by Administrator','NAME: test1',0,'112.206.140.87'),(2390,0,0,'2011-07-21 14:36:57','Account Created & Finalized by Administrator','NAME: Book Keeper',0,'68.222.247.155'),(2391,0,0,'2011-07-21 14:37:18','Account Created & Finalized by Administrator','NAME: Taylor',0,'99.118.90.215'),(2392,0,0,'2011-07-21 14:37:28','Access changed','Access changed for Book Keeper',0,'68.222.247.155'),(2393,0,0,'2011-07-21 14:37:46','Access changed','Access changed for Taylor',0,'99.118.90.215'),(2394,0,0,'2011-07-21 14:37:51','Access changed','Access changed for Administrator',0,'68.222.247.155'),(2395,0,0,'2011-07-21 14:38:05','Access changed','Access changed for Book Keeper',0,'68.222.247.155'),(2396,0,0,'2011-07-21 14:38:56','Account Information Updated by Administrator','NAME: Book Keeper',0,'68.222.247.155'),(2397,0,0,'2011-07-21 14:40:05','Account Deleted by Administrator','USER ID: 17',0,'99.118.90.215'),(2398,0,0,'2011-07-21 14:40:29','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2399,0,0,'2011-07-21 14:40:32','Account Created & Finalized by Administrator','NAME: Taylor',0,'99.118.90.215'),(2400,0,0,'2011-07-21 14:40:48','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2401,0,0,'2011-07-21 14:41:01','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2402,0,0,'2011-07-21 14:41:06','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2403,0,0,'2011-07-21 14:41:30','Account Deleted by Administrator','USER ID: 18',0,'99.118.90.215'),(2404,0,0,'2011-07-21 14:41:39','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2405,0,0,'2011-07-21 14:41:47','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2406,0,0,'2011-07-21 14:42:06','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2407,0,0,'2011-07-21 14:42:10','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2408,0,0,'2011-07-21 14:42:17','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2409,0,0,'2011-07-21 14:42:20','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2410,0,0,'2011-07-21 14:42:22','Account Created & Finalized by Administrator','NAME: Taylor',0,'99.118.90.215'),(2411,0,0,'2011-07-21 14:42:30','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2412,0,0,'2011-07-21 14:42:36','Access changed','Access changed for Book Keeper',0,'112.206.140.87'),(2413,0,0,'2011-07-21 14:42:41','Access changed','Access changed for Taylor',0,'99.118.90.215'),(2414,0,0,'2011-07-21 14:43:32','Access changed','Access changed for Taylor',0,'99.118.90.215'),(2415,992612447,957633228,'2011-07-22 14:35:54','Auction Invoiced','No Details Available',20.4,'222.127.223.75'),(2416,992612447,957633228,'2011-07-22 14:35:55','Auction Expired','No Details Available',0,'222.127.223.75'),(2417,992612447,957633228,'2011-07-22 14:35:55','Auction Results emailed to Seller','Item Number: 992612447\r\nItem Title: Black Sunshine III\r\nDate Started: 06/14/2011 10:40:00\r\nDate Ended: 07/14/2011 10:40:00\r\nAuction Type: English\r\n\r\nQualified bidders in order of rank, highest to lowest\r\n\r\nNickname: jmcward\r\nEmail: jm18488@bellsouth.net\r\nRank: 1\r\nQuantity desired: 1\r\nPrice:       20000.00 USD\r\nShipping address is the same as billing address.\r\nBilling address: 104 Long Branch\r\n                 Somewhere, Oklahoma 58712\r\n                 USA\r\n\r\nPlease contact these winners as soon as possible.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992612447\r\n\r\n',0,'222.127.223.75'),(2418,992612447,991498245,'2011-07-22 14:35:55','Auction Results emailed to Bidder','Item Number: 992612447\r\nItem Title: Black Sunshine III\r\nSeller\'s Nickname: douglas\r\nSeller\'s Email: dickcaadan@yahoo.com.ph\r\nDate Started: 06/14/2011 10:40:00\r\nDate Ended: 07/14/2011 10:40:00\r\nAuction Type: English\r\n\r\nYour Nickname: jmcward\r\nRank: 1\r\nQuantity desired: 1\r\nQuantity available: 1\r\nPrice:       20000.00 USD\r\n\r\nSales Tax Rate: 0 %\r\nSales Tax:           0.00 USD\r\n\r\nAdministrative Fee:           0.00 USD\r\nFinancial Fee:           0.00 USD\r\nBuyer\'s Premium:        2000.00 USD\r\nShipping Fee:           0.00 USD\r\n\r\nTotal:       22000.00 USD\r\n\r\nPlease contact the seller as soon as possible.\r\n\r\nClick here for the complete results of this auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992612447\r\n\r\n',0,'222.127.223.75'),(2419,992872772,991498245,'2011-07-22 14:35:55','Auction Invoiced','No Details Available',20.1,'222.127.223.75'),(2420,992872772,991498245,'2011-07-22 14:35:55','Auction Expired','No Details Available',0,'222.127.223.75'),(2421,992872772,991498245,'2011-07-22 14:35:55','Auction Results emailed to Seller','Item Number: 992872772\r\nItem Title: Big Jake\r\nDate Started: 06/17/2011 10:59:00\r\nDate Ended: 07/17/2011 10:59:00\r\nAuction Type: English\r\n\r\nQualified bidders in order of rank, highest to lowest\r\n\r\nNickname: douglas\r\nEmail: dickcaadan@yahoo.com.ph\r\nRank: 1\r\nQuantity desired: 1\r\nPrice:        3010.00 USD\r\nShipping address is the same as billing address.\r\nBilling address: 1111111\r\n                 Buena Park, Connecticut 90621\r\n                 USA\r\n\r\nPlease contact these winners as soon as possible.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992872772\r\n\r\n',0,'222.127.223.75'),(2422,992872772,957633228,'2011-07-22 14:35:55','Auction Results emailed to Bidder','Item Number: 992872772\r\nItem Title: Big Jake\r\nSeller\'s Nickname: jmcward\r\nSeller\'s Email: jm18488@bellsouth.net\r\nDate Started: 06/17/2011 10:59:00\r\nDate Ended: 07/17/2011 10:59:00\r\nAuction Type: English\r\n\r\nYour Nickname: douglas\r\nRank: 1\r\nQuantity desired: 1\r\nQuantity available: 1\r\nPrice:        3010.00 USD\r\n\r\nSales Tax Rate: 0 %\r\nSales Tax:           0.00 USD\r\n\r\nAdministrative Fee:           0.00 USD\r\nFinancial Fee:           0.00 USD\r\nBuyer\'s Premium:         301.00 USD\r\nShipping Fee:           0.00 USD\r\n\r\nTotal:        3311.00 USD\r\n\r\nPlease contact the seller as soon as possible.\r\n\r\nClick here for the complete results of this auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992872772\r\n\r\n',0,'222.127.223.75'),(2423,992898640,991498245,'2011-07-22 14:35:55','Auction Invoiced','No Details Available',20.1,'222.127.223.75'),(2424,992898640,991498245,'2011-07-22 14:35:55','Auction Expired','No Details Available',0,'222.127.223.75'),(2425,992898640,991498245,'2011-07-22 14:35:55','Auction Results emailed to Seller','Item Number: 992898640\r\nItem Title: Pending\r\nDate Started: 06/17/2011 18:10:00\r\nDate Ended: 07/17/2011 18:10:00\r\nAuction Type: English\r\n\r\nQualified bidders in order of rank, highest to lowest\r\n\r\nNickname: jmcward\r\nEmail: jm18488@bellsouth.net\r\nRank: 1\r\nQuantity desired: 1\r\nPrice:      152000.00 USD\r\nShipping address is the same as billing address.\r\nBilling address: 104 Long Branch\r\n                 Somewhere, Oklahoma 58712\r\n                 USA\r\n\r\nPlease contact these winners as soon as possible.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992898640\r\n\r\n',0,'222.127.223.75'),(2426,992898640,991498245,'2011-07-22 14:35:55','Auction Results emailed to Bidder','Item Number: 992898640\r\nItem Title: Pending\r\nSeller\'s Nickname: jmcward\r\nSeller\'s Email: jm18488@bellsouth.net\r\nDate Started: 06/17/2011 18:10:00\r\nDate Ended: 07/17/2011 18:10:00\r\nAuction Type: English\r\n\r\nYour Nickname: jmcward\r\nRank: 1\r\nQuantity desired: 1\r\nQuantity available: 1\r\nPrice:      152000.00 USD\r\n\r\nSales Tax Rate: 0 %\r\nSales Tax:           0.00 USD\r\n\r\nAdministrative Fee:           0.00 USD\r\nFinancial Fee:           0.00 USD\r\nBuyer\'s Premium:       15200.00 USD\r\nShipping Fee:           0.00 USD\r\n\r\nTotal:      167200.00 USD\r\n\r\nPlease contact the seller as soon as possible.\r\n\r\nClick here for the complete results of this auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=992898640\r\n\r\n',0,'222.127.223.75'),(2427,993247373,990906101,'2011-07-22 14:35:55','Auction Invoiced','No Details Available',20.1,'222.127.223.75'),(2428,993247373,990906101,'2011-07-22 14:35:55','Auction Expired','No Details Available',0,'222.127.223.75'),(2429,993247373,990906101,'2011-07-22 14:35:55','Auction Results emailed to Seller','Item Number: 993247373\r\nItem Title: Chexy Tex N Belle\r\nDate Started: 06/21/2011 12:02:00\r\nDate Ended: 07/21/2011 12:02:00\r\nAuction Type: English\r\n\r\nQualified bidders in order of rank, highest to lowest\r\n\r\nNickname: greggy\r\nEmail: sylvestermolina@ymail.com\r\nRank: 1\r\nQuantity desired: 1\r\nPrice:        5000.00 USD\r\nShipping address is the same as billing address.\r\nBilling address: smith\r\n                 atlantis, Alabama 12345\r\n                 USA\r\n\r\nPlease contact these winners as soon as possible.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=993247373\r\n\r\n',0,'222.127.223.75'),(2430,993247373,995322690,'2011-07-22 14:35:55','Auction Results emailed to Bidder','Item Number: 993247373\r\nItem Title: Chexy Tex N Belle\r\nSeller\'s Nickname: tbone\r\nSeller\'s Email: tvet2b@aol.com\r\nDate Started: 06/21/2011 12:02:00\r\nDate Ended: 07/21/2011 12:02:00\r\nAuction Type: English\r\n\r\nYour Nickname: greggy\r\nRank: 1\r\nQuantity desired: 1\r\nQuantity available: 1\r\nPrice:        5000.00 USD\r\n\r\nSales Tax Rate: 0 %\r\nSales Tax:           0.00 USD\r\n\r\nAdministrative Fee:           0.00 USD\r\nFinancial Fee:           0.00 USD\r\nBuyer\'s Premium:         500.00 USD\r\nShipping Fee:           0.00 USD\r\n\r\nTotal:        5500.00 USD\r\n\r\nPlease contact the seller as soon as possible.\r\n\r\nClick here for the complete results of this auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=993247373\r\n\r\n',0,'222.127.223.75'),(2431,993262620,991498245,'2011-07-22 14:35:56','Auction Invoiced','No Details Available',20.1,'222.127.223.75'),(2432,993262620,991498245,'2011-07-22 14:35:56','Auction Expired','No Details Available',0,'222.127.223.75'),(2433,993262620,991498245,'2011-07-22 14:35:56','Auction Results emailed to Seller','No qualified bids were placed on this item.\r\n\r\nClick here for the complete results of your auction: http://www.equibidz.com/listings/details/index.cfm?itemnum=993262620\r\n\r\n',0,'222.127.223.75'),(2434,0,0,'2011-07-25 23:44:14','Site Defaults Modified','No Details Available',0,'203.87.152.6'),(2435,993915534,992667247,'2011-07-25 23:46:02','Bid','BID: 3340.00',0,'203.87.152.6'),(2436,993915534,992667247,'2011-07-25 23:46:39','Bid','BID: 3350.00',0,'203.87.152.6'),(2437,995759933,991498245,'2011-08-03 10:30:56','Bid','BID: 24',0,'68.222.247.155'),(2438,996957239,991498245,'2011-08-03 10:35:12','Advertisement Application','http://www.tpfarms.com',0,'68.222.247.155'),(2439,0,0,'2011-08-03 10:45:49','Site Defaults Modified','No Details Available',0,'68.222.247.155'),(2440,0,0,'2011-08-03 11:48:05','Update contact','contact updated',0,'99.118.90.215'),(2441,994983460,991498245,'2011-08-05 05:35:38','BuyNow','BUYNOW: 100',0,'72.148.31.116'),(2442,994983460,991498245,'2011-08-05 05:35:38','Buynow email sent to buyer','Buynow: 100',0,'72.148.31.116'),(2443,994983460,961375758,'2011-08-05 05:35:38','Buynow email sent to seller','Buynow: 100  	Buyer: 991498245',0,'72.148.31.116'),(2444,0,0,'2011-08-08 07:42:58','Report Ran (Completed Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'222.127.223.70'),(2445,0,0,'2011-08-08 07:43:08','Report Ran (All Auctions)','OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7',0,'222.127.223.70'),(2446,997380501,957633228,'2011-08-08 08:08:47','Advertisement Application','http://www.yahoo.com',0,'222.127.223.70'),(2447,0,0,'2011-08-09 14:17:25','Fee Segment Deleted','DELETED FEE SEGMENT: 00100.00,P,0.045',0,'112.206.131.141'),(2448,0,0,'2011-08-09 14:17:35','Fee Segment Deleted','DELETED FEE SEGMENT: 01001.00,P,0.04 ',0,'112.206.131.141'),(2449,0,0,'2011-08-09 14:17:52','Fee Segment Deleted','DELETED FEE SEGMENT: 10000.00,F,50.00 ',0,'112.206.131.141'),(2450,0,0,'2011-08-09 14:20:02','Site Defaults Modified','No Details Available',0,'99.118.90.215'),(2451,0,0,'2011-08-09 14:20:25','Fee Segment Deleted','DELETED FEE SEGMENT: 10000.00,F,50.00 ',0,'112.206.131.141'),(2452,0,0,'2011-08-09 14:20:35','Site Defaults Modified','No Details Available',0,'99.118.90.215'),(2453,0,0,'2011-08-09 14:20:55','Fee Segment Added','NEW FEE SEGMENT: 00000.00,P,0.09',0,'112.206.131.141'),(2454,0,0,'2011-08-09 14:21:15','Site Defaults Modified','No Details Available',0,'99.118.90.215'),(2455,997573378,957633228,'2011-08-10 14:17:18','Advertisement Application','http://www.yahoo.com',0,'112.198.134.50'),(2456,0,0,'2011-08-12 06:36:10','Site Defaults Modified','No Details Available',0,'72.159.2.254'),(2457,0,0,'2011-08-12 06:36:15','Site Defaults Modified','No Details Available',0,'72.37.171.84'),(2458,0,0,'2011-08-12 06:36:50','Fee Segment Deleted','DELETED FEE SEGMENT: 00000.00,P,0.09 ',0,'72.37.171.84'),(2459,0,0,'2011-08-12 06:37:13','Site Defaults Modified','No Details Available',0,'72.159.2.254'),(2460,0,0,'2011-08-12 06:37:53','Site Defaults Modified','No Details Available',0,'72.159.2.254'),(2461,0,0,'2011-08-12 06:38:38','Site Defaults Modified','No Details Available',0,'72.159.2.254'),(2462,0,0,'2011-08-12 06:38:43','Site Defaults Modified','No Details Available',0,'72.159.2.254'),(2463,0,0,'2011-08-12 06:39:20','Site Defaults Modified','No Details Available',0,'72.159.2.254'),(2464,0,0,'2011-08-12 06:39:24','Site Defaults Modified','No Details Available',0,'72.159.2.254'),(2465,0,0,'2011-08-16 10:37:18','Fee Segment Added','NEW FEE SEGMENT: 00000.00,P,0.09',0,'112.206.132.128'),(2466,0,0,'2011-08-16 10:38:43','Fee Segment Added','NEW FEE SEGMENT: 00000.00,P,0.1',0,'72.159.2.254'),(2467,0,0,'2011-08-16 10:38:53','Fee Segment Added','NEW FEE SEGMENT: 00000.00,P,0.09',0,'112.206.132.128'),(2468,0,0,'2011-08-16 10:43:35','Site Information Updated','No Details Available',0,'112.206.132.128'),(2469,0,0,'2011-08-24 06:23:22','Site Information Updated','No Details Available',0,'72.159.2.254'),(2470,0,0,'2011-08-25 11:53:40','Site Information Updated','No Details Available',0,'99.118.90.215'),(2471,0,0,'2011-08-26 16:45:59','Site Information Updated','No Details Available',0,'99.118.90.215'),(2472,0,0,'2011-08-26 16:46:06','Site Information Updated','No Details Available',0,'99.118.90.215'),(2473,0,0,'2011-08-26 16:46:47','Site Information Updated','No Details Available',0,'99.118.90.215'),(2474,0,0,'2011-08-26 16:46:52','Site Information Updated','No Details Available',0,'99.118.90.215'),(2475,0,999284657,'2011-08-30 09:04:17','Account Created','EMAIL: kim@beyondsolutions.com',0,'68.183.144.71'),(2476,0,0,'2011-08-30 09:07:12','Account Confirmation','USER ID: 999284657    NICKNAME: kjhbsi',0,'68.183.144.71'),(2477,0,0,'2011-08-30 13:17:44','Fee Segment Deleted','DELETED FEE SEGMENT: 00000.00,P,0.09 ',0,'68.183.144.71'),(2478,0,0,'2011-08-30 13:21:55','Fee Segment Deleted','DELETED FEE SEGMENT: 00000.00,P,0.09 ',0,'68.183.144.71'),(2479,0,0,'2011-08-30 13:22:08','Fee Segment Deleted','DELETED FEE SEGMENT: 00000.00,P,0.1 ',0,'68.183.144.71'),(2480,0,0,'2011-08-30 13:53:20','Report Ran (Transaction Log)','OUTPUT TYPE: html     SORT ORDER: dateA     DAYS: 30',0,'68.183.144.71'),(2481,0,0,'2011-09-03 22:07:18','Update home page main_content','home page main_content updated',0,'203.87.152.24'),(2482,0,0,'2011-09-03 22:07:33','Update home page side_content','home page side_content updated',0,'203.87.152.24'),(2483,0,0,'2011-09-04 01:48:37','Update home page main_content','home page main_content updated',0,'203.87.152.24'),(2484,0,0,'2011-09-04 01:51:04','Update home page side_content','home page side_content updated',0,'203.87.152.24'),(2485,0,0,'2011-09-08 12:20:43','Update Term and conditions','Term and conditions updated',0,'205.223.0.76'),(2486,0,0,'2011-09-08 14:42:59','Account Information Updated by Administrator','NAME: Administrator',0,'72.148.31.116'),(2487,0,0,'2011-09-08 14:43:59','Account Deleted by Administrator','USER ID: 15',0,'72.148.31.116'),(2488,0,0,'2011-09-08 14:44:33','Account Deleted by Administrator','USER ID: 19',0,'72.148.31.116'),(2489,0,0,'2011-09-08 14:45:07','Account Information Updated by Administrator','NAME: Book Keeper',0,'72.148.31.116'),(2490,0,0,'2011-09-08 14:46:14','Account Deleted by Administrator','USER ID: 990936401',0,'72.148.31.116'),(2491,0,0,'2011-09-08 14:47:26','Account Deactivated by Administrator','USER ID: 957633228',0,'72.148.31.116'),(2492,0,0,'2011-09-08 15:29:06','Account Deactivated by Administrator','USER ID: 961375758',0,'72.148.31.116'),(2493,0,0,'2011-09-08 15:34:21','Account Deleted by Administrator','USER ID: 995322690',0,'72.148.31.116'),(2494,0,0,'2011-09-08 15:34:31','Account Deleted by Administrator','USER ID: 999284657',0,'72.148.31.116'),(2495,0,0,'2011-09-08 15:34:46','Account Deleted by Administrator','USER ID: 993227310',0,'72.148.31.116'),(2496,0,0,'2011-09-08 15:34:51','Account Deleted by Administrator','USER ID: 992667247',0,'72.148.31.116'),(2497,0,1000087130,'2011-09-08 15:58:50','Account Created','EMAIL: jm18488@bellsouth.net',0,'72.148.31.116'),(2498,0,1000098194,'2011-09-08 19:03:14','Account Created','EMAIL: jm18488@bellsouth.net',0,'72.148.31.116'),(2499,0,0,'2011-09-08 19:30:25','Account Confirmation','USER ID: 1000098194    NICKNAME: tester1',0,'72.148.31.116'),(2500,0,1000641159,'2011-09-15 01:52:39','Account Created','EMAIL: person@somewhere.com',0,'141.0.9.59'),(2501,0,1000641624,'2011-09-15 02:00:24','Account Created','EMAIL: midnighthei@yahoo.com',0,'141.0.9.59'),(2502,0,0,'2011-09-15 02:01:16','Account Confirmation','USER ID: 1000641624    NICKNAME: betatester',0,'141.0.9.59'),(2503,0,0,'2011-09-15 02:01:32','Account Confirmation','USER ID: 1000641624    NICKNAME: betatester',0,'141.0.9.59'),(2504,0,0,'2011-09-23 16:51:35','Update home page main_content','home page main_content updated',0,'72.148.31.116'),(2505,0,0,'2011-09-23 16:55:02','Update home page main_content','home page main_content updated',0,'72.148.31.116'),(2506,0,0,'2011-09-23 16:56:13','Update home page main_content','home page main_content updated',0,'72.148.31.116'),(2507,0,0,'2011-09-23 17:13:22','Update home page main_content','home page main_content updated',0,'72.148.31.116'),(2508,999273088,1000098194,'2011-09-23 19:08:39','Bid','BID: 100.00',0,'72.148.31.116'),(2509,1001343144,1000098194,'2011-09-23 19:09:57','BuyNow','BUYNOW: 8000',0,'72.148.31.116'),(2510,1001343144,1000098194,'2011-09-23 19:09:57','Buynow email sent to buyer','Buynow: 8000',0,'72.148.31.116'),(2511,1001343144,993931328,'2011-09-23 19:09:57','Buynow email sent to seller','Buynow: 8000  	Buyer: 1000098194',0,'72.148.31.116'),(2512,1000694225,1000098194,'2011-09-23 19:11:37','BuyNow','BUYNOW: 10000',0,'72.148.31.116'),(2513,1000694225,1000098194,'2011-09-23 19:11:37','Buynow email sent to buyer','Buynow: 10000',0,'72.148.31.116'),(2514,1000694225,993931328,'2011-09-23 19:11:37','Buynow email sent to seller','Buynow: 10000  	Buyer: 1000098194',0,'72.148.31.116'),(2515,1000502904,1000098194,'2011-09-23 19:46:20','Bid','BID: 2200.00',0,'72.148.31.116'),(2516,0,0,'2011-09-24 10:46:48','Update home page main_content','home page main_content updated',0,'99.118.90.215'),(2517,1001459950,993931328,'2011-09-24 13:26:48','BuyNow','BUYNOW: 10',0,'99.118.90.215'),(2518,1001459950,993931328,'2011-09-24 13:26:48','Buynow email sent to buyer','Buynow: 10',0,'99.118.90.215'),(2519,1001459950,1000098194,'2011-09-24 13:26:48','Buynow email sent to seller','Buynow: 10  	Buyer: 993931328',0,'99.118.90.215'),(2520,999273088,993931328,'2011-09-24 17:33:50','Bid','BID: 110.00',0,'99.118.90.215'),(2521,1001452246,993931328,'2011-09-24 17:34:51','Bid','BID: 1000.00',0,'99.118.90.215'),(2522,0,0,'2011-09-24 17:52:09','Update home page main_content','home page main_content updated',0,'99.118.90.215'),(2523,0,0,'2011-09-24 17:54:17','Update home page main_content','home page main_content updated',0,'99.118.90.215');
/*!40000 ALTER TABLE `transaction_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uploads`
--

DROP TABLE IF EXISTS `uploads`;
CREATE TABLE `uploads` (
  `ID` int(11) NOT NULL auto_increment,
  `remote_ip` varchar(25) NOT NULL default '127.0.0.1',
  `when_uploaded` datetime NOT NULL,
  `original_name` varchar(255) NOT NULL default 'Original Name',
  `local_name` varchar(255) NOT NULL default 'Local Name',
  `mime_type` varchar(50) NOT NULL default 'text/plain',
  `user_id` int(11) NOT NULL default '0',
  `file_id` int(11) NOT NULL default '0',
  `file_size` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `file_id` (`file_id`),
  KEY `ID` (`ID`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `uploads`
--

LOCK TABLES `uploads` WRITE;
/*!40000 ALTER TABLE `uploads` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `nickname` varchar(20) NOT NULL default '0',
  `email` varchar(50) NOT NULL default 'email@domain.com',
  `password` varchar(12) NOT NULL default 'password',
  `keyword` varchar(20) NOT NULL default 'keyword',
  `date_registered` datetime NOT NULL,
  `fname` varchar(50) default NULL,
  `lname` varchar(50) default NULL,
  `name` varchar(100) NOT NULL default 'Your Name',
  `company` varchar(65) default 'Company',
  `address1` varchar(100) NOT NULL default 'Address Line 1',
  `address2` varchar(65) default NULL,
  `city` varchar(65) NOT NULL default 'Your City',
  `state` varchar(50) NOT NULL default 'Your State',
  `postal_code` varchar(20) NOT NULL default 'Postal Code',
  `country` varchar(50) NOT NULL default 'Country',
  `phone1` varchar(20) NOT NULL default 'Telephone',
  `phone2` varchar(20) default 'Alternate Phone',
  `fax` varchar(20) default 'Fax',
  `url_page` varchar(50) NOT NULL default 'http://',
  `url_logo` varchar(70) default 'http://',
  `comment` varchar(255) default 'New Comment',
  `language` varchar(5) NOT NULL default 'EN',
  `heard_from` varchar(45) default 'Heard From',
  `promotion_code` varchar(10) default 'Promo Code',
  `friends_email` varchar(65) default 'Friend''s Email',
  `use_for` varchar(1) default '0',
  `interested` varchar(255) default 'Interested In',
  `age` varchar(15) default '0',
  `education` varchar(25) default 'Education',
  `income` varchar(25) default '0',
  `survey` tinyint(1) NOT NULL default '0',
  `gender` varchar(1) NOT NULL default 'M',
  `mailing` tinyint(1) NOT NULL default '0',
  `billing` double NOT NULL default '0',
  `balance` double NOT NULL default '0',
  `credit` double NOT NULL default '0',
  `statement_date` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL default '0',
  `last_login_date` datetime NOT NULL,
  `cc_name` varchar(65) NOT NULL default 'Name on Credit Card',
  `cc_number` varchar(50) NOT NULL default '0',
  `cc_expiration` varchar(7) NOT NULL default '00/00',
  `remote_ip` varchar(25) NOT NULL default '127.0.0.1',
  `sent_mail` tinyint(1) default NULL,
  `date_sent` datetime default NULL,
  `last_message` longtext,
  `watch_list` longtext,
  `same_address` tinyint(1) default '1',
  `shipping_address1` varchar(100) default NULL,
  `shipping_address2` varchar(65) default NULL,
  `shipping_city` varchar(65) default NULL,
  `shipping_state` varchar(50) default NULL,
  `shipping_postal_code` varchar(20) default NULL,
  `shipping_country` varchar(50) default NULL,
  `confirmation` tinyint(1) default '0',
  `bid_confirm_email` tinyint(1) default '1',
  `outbid_email` tinyint(1) default '1',
  `autobid_email` tinyint(1) default '1',
  `membership_status` tinyint(1) default '0',
  `membership` varchar(30) default NULL,
  `membership_exp` datetime default NULL,
  `full_control` tinyint(1) default '0',
  `blocked_list` longtext,
  `mypage` longtext,
  `showfeedback` tinyint(1) default '0',
  `showauctions` tinyint(1) default '0',
  `license` varchar(20) NOT NULL default '',
  `tax_id` varchar(20) NOT NULL default '',
  `bank_name` varchar(100) NOT NULL default '',
  `bank_city` varchar(100) NOT NULL default '',
  `bank_phone` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `user_id_index` (`user_id`),
  KEY `keyword` (`keyword`),
  KEY `last_login_date` (`last_login_date`),
  KEY `password_index` (`password`),
  KEY `postal_code` (`postal_code`),
  KEY `promotion_code` (`promotion_code`),
  KEY `shipping_postal_code` (`shipping_postal_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
CREATE TABLE `watchlist` (
  `id` int(11) NOT NULL auto_increment,
  `itemnum` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `watchlist`
--

LOCK TABLES `watchlist` WRITE;
/*!40000 ALTER TABLE `watchlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xcategories`
--

DROP TABLE IF EXISTS `xcategories`;
CREATE TABLE `xcategories` (
  `category` int(11) NOT NULL auto_increment,
  `parent` int(11) NOT NULL default '0',
  `child_count` smallint(6) NOT NULL default '0',
  `name` varchar(40) NOT NULL default 'New Category',
  `date_created` datetime NOT NULL,
  `active` tinyint(1) NOT NULL default '0',
  `allow_sales` tinyint(1) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `require_login` tinyint(1) NOT NULL default '0',
  `count_items` int(11) NOT NULL default '0',
  `count_total` int(11) NOT NULL default '0',
  `parent_setting` tinyint(1) default '1',
  `cat_image` varchar(255) default NULL,
  `heading_color` varchar(50) default NULL,
  `bg_color` varchar(50) default NULL,
  `font_color` varchar(50) default NULL,
  `font_style` varchar(50) default NULL,
  `fee_listing` double default '0',
  `lvl_1` int(11) default '0',
  `lvl_2` int(11) default '0',
  `lvl_3` int(11) default '0',
  `lvl_4` int(11) default '0',
  `lvl_5` int(11) default '0',
  `lvl_6` int(11) default '0',
  `lvl_7` int(11) default '0',
  `lvl_8` int(11) default '0',
  `this_lvl` int(11) NOT NULL default '0',
  PRIMARY KEY  (`category`),
  UNIQUE KEY `category_index` (`category`),
  KEY `active_index` (`active`),
  KEY `allow_sales_index` (`allow_sales`),
  KEY `M_1` (`lvl_1`),
  KEY `M_2` (`lvl_2`),
  KEY `M_3` (`lvl_3`),
  KEY `M_4` (`lvl_4`),
  KEY `M_5` (`lvl_5`),
  KEY `M_6` (`lvl_6`),
  KEY `M_7` (`lvl_7`),
  KEY `M_8` (`lvl_8`),
  KEY `num_children` (`child_count`),
  KEY `parent_index` (`parent`),
  KEY `require_login_index` (`require_login`),
  KEY `this_M` (`this_lvl`)
) ENGINE=InnoDB AUTO_INCREMENT=921111088 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `xcategories`
--

LOCK TABLES `xcategories` WRITE;
/*!40000 ALTER TABLE `xcategories` DISABLE KEYS */;
INSERT INTO `xcategories` VALUES (920704167,0,1,'Top Level 1','2009-03-03 23:09:17',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,0,0,0,0,0,0,0,1),(920704179,920704167,1,'Level 2','2009-03-03 23:09:32',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,0,0,0,0,0,0,2),(920704195,920704179,1,'Level 3','2009-03-03 23:09:41',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,920704195,0,0,0,0,0,3),(920704205,920704195,1,'Level 4','2009-03-03 23:09:59',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,920704195,920704205,0,0,0,0,4),(920704214,920704205,2,'Level 5','2009-03-03 23:10:07',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,920704195,920704205,920704214,0,0,0,5),(920704223,920704214,1,'Level 6','2009-03-03 23:10:17',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,920704195,920704205,920704214,920704223,0,0,6),(920704232,920704223,1,'Level 7','2009-03-03 23:10:26',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,920704195,920704205,920704214,920704223,920704232,0,7),(920704243,920704232,0,'Level 8','2009-03-03 23:10:35',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,920704195,920704205,920704214,920704223,920704232,920704243,8),(921111055,920704214,1,'SubLevel 6a','2009-03-08 16:10:30',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,920704195,920704205,920704214,921111055,0,0,6),(921111085,921111055,0,'SubLevel 6b','2009-03-08 16:11:09',1,1,0,0,0,0,1,NULL,NULL,NULL,NULL,NULL,1,920704167,920704179,920704195,920704205,920704214,921111055,921111085,0,7),(921111086,-3,0,'_None','1999-01-01 00:00:00',0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0),(921111087,-1,1,'_Top','1999-01-01 00:00:00',1,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `xcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zips`
--

DROP TABLE IF EXISTS `zips`;
CREATE TABLE `zips` (
  `zip` varchar(5) NOT NULL,
  `Place` varchar(65) default NULL,
  `State` varchar(2) default NULL,
  `County` varchar(50) default NULL,
  `Latitude` double default '0',
  `Longitude` double default '0',
  `AC` varchar(50) default NULL,
  PRIMARY KEY  (`zip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `zips`
--

LOCK TABLES `zips` WRITE;
/*!40000 ALTER TABLE `zips` DISABLE KEYS */;
/*!40000 ALTER TABLE `zips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-10-08 22:56:31
