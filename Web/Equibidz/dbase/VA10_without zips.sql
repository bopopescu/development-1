-- phpMyAdmin SQL Dump
-- version 2.11.9.4
-- http://www.phpmyadmin.net
--
-- Host: 173.201.217.5
-- Generation Time: Jun 17, 2010 at 06:06 PM
-- Server version: 5.0.91
-- PHP Version: 5.2.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 
--

-- --------------------------------------------------------

--
-- Table structure for table `access`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=126 ;

--
-- Dumping data for table `access`
--

INSERT INTO `access` VALUES(93, 'Test', 'admin', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 101, 0, 1, 1);
INSERT INTO `access` VALUES(94, 'test1', 'test1', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 102, 1, 1, 1);
INSERT INTO `access` VALUES(95, 'Administrator', 'admin', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 103, 1, 1, 1);
INSERT INTO `access` VALUES(96, 'Brian', 'adopogi2', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 104, 1, 1, 1);
INSERT INTO `access` VALUES(98, 'davidh1', 'davidh1', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 105, 0, 0, 0);
INSERT INTO `access` VALUES(124, 'David', 'davidh1', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 15, 1, 1, 1);
INSERT INTO `access` VALUES(125, 'Davidh', 'davidh2', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 15, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

CREATE TABLE `administrators` (
  `name` varchar(65) default 'Admin Name',
  `login` varchar(12) default NULL,
  `password` varchar(12) default 'admin',
  `date_created` datetime default NULL,
  `sec_level` smallint(6) NOT NULL default '0',
  `is_active` tinyint(1) NOT NULL default '0',
  `admin_id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `administrators`
--

INSERT INTO `administrators` VALUES('Administrator', 'admin', 'admin', '2004-03-11 09:45:07', 10, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ad_defaults`
--

CREATE TABLE `ad_defaults` (
  `ad_dur` tinyint(3) unsigned NOT NULL default '0',
  `ad_fee` double NOT NULL default '0',
  PRIMARY KEY  (`ad_dur`),
  UNIQUE KEY `ad_dur` (`ad_dur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ad_defaults`
--

INSERT INTO `ad_defaults` VALUES(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ad_info`
--

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

INSERT INTO `ad_info` VALUES(734993303, 0, 'testph classified', 730931115, 730931213, 0, 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test ', 5, 0, 'http://', '2003-04-15 12:48:00', '2003-04-16 12:48:00', 0, 1, 1, '127.0.0.1', NULL, NULL, NULL, NULL);
INSERT INTO `ad_info` VALUES(881102986, 0, 'Test Only', 880835450, 880155011, 0, 'lkjlakdjlkjasd', 10, 0, 'http://', '2007-12-01 14:49:00', '2007-12-02 14:49:00', 0, 1, 1, '127.0.0.1', '', '', '', '');
INSERT INTO `ad_info` VALUES(881103704, 0, 'None', 880835450, 880155011, 0, 'dfsdfsdfsdf', 11, 0, 'http://', '2007-12-01 15:01:00', '2007-12-02 15:01:00', 0, 1, 1, '127.0.0.1', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `ad_offers`
--

CREATE TABLE `ad_offers` (
  `ID` int(11) NOT NULL auto_increment,
  `adnum` double NOT NULL default '0',
  `offer` double NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  KEY `adnum` (`adnum`),
  KEY `ID` (`ID`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ad_offers`
--


-- --------------------------------------------------------

--
-- Table structure for table `ad_trans_log`
--

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


-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=109 ;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` VALUES(108, 1, 'smsinterfaces_banner.jpeg', 'sms', 'http://www.smsinterfaces.com', ' ', ' ', 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE `bids` (
  `ID` int(11) NOT NULL auto_increment,
  `itemnum` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `time_placed` datetime NOT NULL,
  `bid` double NOT NULL default '0',
  `quantity` smallint(6) NOT NULL default '0',
  `remote_ip` varchar(23) NOT NULL default '127.0.0.1',
  `buynow` tinyint(1) default NULL,
  `hide` tinyint(1) default '0',
  `winner` tinyint(1) default '0',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `id` (`ID`),
  KEY `itemnum_index` (`itemnum`),
  KEY `time_placed_index` (`time_placed`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=89 ;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` VALUES(80, 943529782, 920710318, '2009-11-23 16:05:33', 10, 1, '71.165.176.40', 0, 0, 1);
INSERT INTO `bids` VALUES(81, 943562135, 920710318, '2009-11-23 17:42:37', 14, 1, '71.165.176.40', 1, 0, 1);
INSERT INTO `bids` VALUES(82, 943562611, 920710318, '2009-11-23 17:43:53', 10, 1, '71.165.176.40', 0, 0, 0);
INSERT INTO `bids` VALUES(83, 943562907, 920710318, '2009-11-23 18:45:25', 10, 1, '71.165.176.40', 0, 0, 0);
INSERT INTO `bids` VALUES(84, 945540149, 945648040, '2009-12-17 23:04:17', 200, 1, '202.147.26.18', 0, 0, 0);
INSERT INTO `bids` VALUES(85, 945663729, 945648040, '2009-12-18 09:39:06', 211, 1, '121.54.2.4', 0, 0, 0);
INSERT INTO `bids` VALUES(86, 945626440, 945538660, '2009-12-18 09:44:49', 200, 1, '121.54.2.4', 0, 0, 0);
INSERT INTO `bids` VALUES(87, 945540219, 945648040, '2009-12-18 09:48:56', 300, 1, '121.54.2.4', 0, 0, 1);
INSERT INTO `bids` VALUES(88, 945657026, 945648040, '2009-12-18 09:58:36', 7, 1, '121.54.2.4', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `blocked_bidders`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `blocked_bidders`
--


-- --------------------------------------------------------

--
-- Table structure for table `blocked_ip`
--

CREATE TABLE `blocked_ip` (
  `id` int(11) NOT NULL auto_increment,
  `blocked_ip` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `blocked_ip`
--

INSERT INTO `blocked_ip` VALUES(1, '192.188.111.1');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category` int(11) NOT NULL default '0',
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

INSERT INTO `categories` VALUES(-2, -3, 0, '_None', '1999-01-01 00:00:00', 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `categories` VALUES(0, -1, 81, '_Top', '1999-01-01 00:00:00', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `categories` VALUES(961375571, 0, 0, 'Test Only', '2010-06-17 16:45:45', 1, 0, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 961375571, 0, 0, 0, 0, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `credit_cards`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `credit_cards`
--


-- --------------------------------------------------------

--
-- Table structure for table `defaults`
--

CREATE TABLE `defaults` (
  `ID` int(11) NOT NULL auto_increment,
  `name` varchar(15) NOT NULL default 'Name',
  `pair` varchar(30) NOT NULL default 'Pair',
  PRIMARY KEY  (`ID`),
  KEY `ID` (`ID`),
  KEY `name_index` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=183 ;

--
-- Dumping data for table `defaults`
--

INSERT INTO `defaults` VALUES(1, 'link_color', '000000');
INSERT INTO `defaults` VALUES(2, 'alink_color', '0000bb');
INSERT INTO `defaults` VALUES(3, 'vlink_color', '008000');
INSERT INTO `defaults` VALUES(4, 'bg_color', 'ffffff');
INSERT INTO `defaults` VALUES(5, 'category_new', '30');
INSERT INTO `defaults` VALUES(6, 'listing_new', '30');
INSERT INTO `defaults` VALUES(7, 'itemsperpage', '30');
INSERT INTO `defaults` VALUES(8, 'listing_bgcolor', 'efefef');
INSERT INTO `defaults` VALUES(9, 'hrsending_color', '000000');
INSERT INTO `defaults` VALUES(10, 'hrsending', '1');
INSERT INTO `defaults` VALUES(11, 'bids4hot', '5');
INSERT INTO `defaults` VALUES(12, 'le_prm_listing', '1');
INSERT INTO `defaults` VALUES(13, 'le_feat_listing', '0');
INSERT INTO `defaults` VALUES(14, 'le_std_listing', '0');
INSERT INTO `defaults` VALUES(15, 'le_root_listing', '1');
INSERT INTO `defaults` VALUES(16, 'le_categories', '1');
INSERT INTO `defaults` VALUES(17, 'e_categories', '{ts ''1999-06-03 15:10:00''}');
INSERT INTO `defaults` VALUES(18, 'e_current', '{ts ''1999-06-03 15:10:00''}');
INSERT INTO `defaults` VALUES(19, 'e_new', '{ts ''1999-06-03 16:00:00''}');
INSERT INTO `defaults` VALUES(20, 'e_ending', '{ts ''1999-06-03 16:30:00''}');
INSERT INTO `defaults` VALUES(21, 'e_completed', '{ts ''1999-06-03 05:00:00''}');
INSERT INTO `defaults` VALUES(22, 'e_going', '{ts ''1999-06-03 13:20:00''}');
INSERT INTO `defaults` VALUES(23, 'e_featured', '{ts ''1999-06-03 13:30:00''}');
INSERT INTO `defaults` VALUES(24, 'e_rootindex', '{ts ''1999-06-03 15:10:00''}');
INSERT INTO `defaults` VALUES(25, 'duration', '0003');
INSERT INTO `defaults` VALUES(27, 'duration', '0007');
INSERT INTO `defaults` VALUES(28, 'duration', '0010');
INSERT INTO `defaults` VALUES(29, 'def_duration', '0002');
INSERT INTO `defaults` VALUES(30, 'def_bidding', 'regular');
INSERT INTO `defaults` VALUES(31, 'dynamic', '0000');
INSERT INTO `defaults` VALUES(32, 'def_dynamic', '0002');
INSERT INTO `defaults` VALUES(33, 'dynamic', '0003');
INSERT INTO `defaults` VALUES(34, 'dynamic', '0005');
INSERT INTO `defaults` VALUES(35, 'dynamic', '0006');
INSERT INTO `defaults` VALUES(36, 'dynamic', '0007');
INSERT INTO `defaults` VALUES(37, 'dynamic', '0008');
INSERT INTO `defaults` VALUES(38, 'dynamic', '0009');
INSERT INTO `defaults` VALUES(39, 'dynamic', '0010');
INSERT INTO `defaults` VALUES(40, 'dynamic', '0004');
INSERT INTO `defaults` VALUES(41, 'dynamic', '0020');
INSERT INTO `defaults` VALUES(42, 'enable_iescrow', '1');
INSERT INTO `defaults` VALUES(43, 'free_trial_days', '0');
INSERT INTO `defaults` VALUES(44, 'free_trial', '1');
INSERT INTO `defaults` VALUES(45, 'fee_listing', '1.00');
INSERT INTO `defaults` VALUES(46, 'fee_bold', '0.25');
INSERT INTO `defaults` VALUES(47, 'fee_featured', '9.95');
INSERT INTO `defaults` VALUES(48, 'fee_banner', '1');
INSERT INTO `defaults` VALUES(49, 'fee_studio', '5.00');
INSERT INTO `defaults` VALUES(50, 'fee_feat_studio', '7.00');
INSERT INTO `defaults` VALUES(51, 'fee_late_charge', '10');
INSERT INTO `defaults` VALUES(52, 'fee_feat_cat', '5.00');
INSERT INTO `defaults` VALUES(53, 'enable_ssl', '0');
INSERT INTO `defaults` VALUES(54, 'last_seller', '945538660');
INSERT INTO `defaults` VALUES(55, 'fb_per_page', '20');
INSERT INTO `defaults` VALUES(56, 'text_color', '000080');
INSERT INTO `defaults` VALUES(57, 'fee_second_cat', '0.05');
INSERT INTO `defaults` VALUES(58, 'billing_period', '30');
INSERT INTO `defaults` VALUES(59, 'site_currency', 'USD');
INSERT INTO `defaults` VALUES(60, 'chkTableFutureW', '0');
INSERT INTO `defaults` VALUES(64, 'def_increment', '5');
INSERT INTO `defaults` VALUES(67, 'increment', '0.5');
INSERT INTO `defaults` VALUES(68, 'increment', '1');
INSERT INTO `defaults` VALUES(69, 'increment', '5');
INSERT INTO `defaults` VALUES(70, 'increment', '10');
INSERT INTO `defaults` VALUES(72, 'e_futurewatch', '880835450');
INSERT INTO `defaults` VALUES(73, 'bMaxoutProxies', '1');
INSERT INTO `defaults` VALUES(76, 'duration', '0002');
INSERT INTO `defaults` VALUES(77, 'exclusive_cat', '100.00');
INSERT INTO `defaults` VALUES(78, 'PairLoginPass', '1');
INSERT INTO `defaults` VALUES(79, 'IEIconFrontPage', 'std_120x34.gif');
INSERT INTO `defaults` VALUES(80, 'mode_switch', 'Dual');
INSERT INTO `defaults` VALUES(81, 'auction_mode', '0');
INSERT INTO `defaults` VALUES(82, 'bMinoutProxies', '0');
INSERT INTO `defaults` VALUES(83, 'dynamic', '0002');
INSERT INTO `defaults` VALUES(84, 'enable_thumbs', '1');
INSERT INTO `defaults` VALUES(87, 'duration', '0030');
INSERT INTO `defaults` VALUES(90, 'increment', '100');
INSERT INTO `defaults` VALUES(91, 'increment', '20');
INSERT INTO `defaults` VALUES(92, 'increment', '50');
INSERT INTO `defaults` VALUES(93, 'fee_inspector', '0');
INSERT INTO `defaults` VALUES(95, 'duration', '0009');
INSERT INTO `defaults` VALUES(100, 'duration', '0021');
INSERT INTO `defaults` VALUES(112, 'billing_type', 'per_auction');
INSERT INTO `defaults` VALUES(113, 'credit_limit', '0');
INSERT INTO `defaults` VALUES(114, 'heading_color', '6b85b6');
INSERT INTO `defaults` VALUES(115, 'heading_fcolor', 'ffffff');
INSERT INTO `defaults` VALUES(116, 'heading_font', 'Arial');
INSERT INTO `defaults` VALUES(122, 'featitemspage', '6');
INSERT INTO `defaults` VALUES(124, 'featcolspage', '2');
INSERT INTO `defaults` VALUES(126, 'membership_sta', '1');
INSERT INTO `defaults` VALUES(128, 'membership_opt', '30_80_Platinum_Annual');
INSERT INTO `defaults` VALUES(129, 'membership_opt', '15_50_Gold_Annual');
INSERT INTO `defaults` VALUES(140, 'enable_cat_fee', '0');
INSERT INTO `defaults` VALUES(141, 'fee_reserve_bid', '0.00');
INSERT INTO `defaults` VALUES(142, 'limitcat_frpage', '20');
INSERT INTO `defaults` VALUES(146, 'fee_picture1', '0.05');
INSERT INTO `defaults` VALUES(147, 'fee_picture2', '0.15');
INSERT INTO `defaults` VALUES(148, 'fee_picture3', '0.15');
INSERT INTO `defaults` VALUES(149, 'fee_picture4', '0.15');
INSERT INTO `defaults` VALUES(150, 'top_seller', '5');
INSERT INTO `defaults` VALUES(152, 'heading_fsize', '14');
INSERT INTO `defaults` VALUES(156, 'duration', '0004');
INSERT INTO `defaults` VALUES(157, 'duration', '0005');
INSERT INTO `defaults` VALUES(158, 'duration', '0006');
INSERT INTO `defaults` VALUES(168, 'membership_opt', '20_50_test_Monthly');
INSERT INTO `defaults` VALUES(173, 'duration', '0001');
INSERT INTO `defaults` VALUES(174, 'scale_segment', '00000.00,P,0.05 ');
INSERT INTO `defaults` VALUES(175, 'scale_segment', '00100.00,P,0.045');
INSERT INTO `defaults` VALUES(176, 'scale_segment', '01001.00,P,0.04 ');
INSERT INTO `defaults` VALUES(177, 'duration', '0001');
INSERT INTO `defaults` VALUES(178, 'scale_segment', '10000.00,F,50.00 ');
INSERT INTO `defaults` VALUES(179, 'noinv_user', '880835450');
INSERT INTO `defaults` VALUES(180, 'administrative', '0');
INSERT INTO `defaults` VALUES(181, 'premium', '10');
INSERT INTO `defaults` VALUES(182, 'financial', '0');

-- --------------------------------------------------------

--
-- Table structure for table `email_blocks`
--

CREATE TABLE `email_blocks` (
  `ID` int(11) NOT NULL auto_increment,
  `address` varchar(65) NOT NULL default 'address@doman.com',
  `block_type` varchar(1) NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  KEY `address_index` (`address`),
  KEY `block_type_index` (`block_type`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `email_blocks`
--


-- --------------------------------------------------------

--
-- Table structure for table `faqquestion`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `faqquestion`
--

INSERT INTO `faqquestion` VALUES(14, 5, NULL, 1, 'test question', 'test answer', NULL, NULL, NULL);
INSERT INTO `faqquestion` VALUES(18, 5, NULL, 1, 'i have a question', 'this is your answer', 'adopogi2', 'brian@beyondsolutions.com', NULL);
INSERT INTO `faqquestion` VALUES(19, 5, NULL, 1, 'asasasasa', 'duda', 'dadads', 'asdada@sasa.com', NULL);
INSERT INTO `faqquestion` VALUES(20, 16, NULL, 1, 'whAt r they', 'birds', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `faqsubject`
--

CREATE TABLE `faqsubject` (
  `sub_id` int(11) NOT NULL auto_increment,
  `subjects` varchar(100) default NULL,
  PRIMARY KEY  (`sub_id`),
  UNIQUE KEY `sub_id` (`sub_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `faqsubject`
--

INSERT INTO `faqsubject` VALUES(5, 'support subject');
INSERT INTO `faqsubject` VALUES(13, 'another subject');
INSERT INTO `faqsubject` VALUES(14, 'asdfads');
INSERT INTO `faqsubject` VALUES(15, 'test');
INSERT INTO `faqsubject` VALUES(16, 'chickens');
INSERT INTO `faqsubject` VALUES(18, 'How does it all work?');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `feedback`
--


-- --------------------------------------------------------

--
-- Table structure for table `futurewatch`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `futurewatch`
--

INSERT INTO `futurewatch` VALUES(1, 880835450, 'volkswagon', 1, 0);
INSERT INTO `futurewatch` VALUES(2, 942526421, 'saddle,barrel', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

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
  `archive` tinyint(1) default NULL,
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

INSERT INTO `invoices` VALUES(920710623, 920710318, 0, '2009-11-23 06:41:56', '2009-12-23 06:41:56', 1, 0, 0.25, 9.95, 0, 1, 0, 0, 0.05, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 12.25, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943522918, 920710318, 0, '2009-11-23 06:50:21', '2009-12-23 06:50:21', 1, 0, 0.25, 9.95, 0, 1, 0, 0, 0.05, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 12.25, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943529186, 920710318, 0, '2009-12-01 18:26:13', '2009-12-31 18:26:13', 1, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 6, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943529681, 920710318, 0, '2009-12-01 18:26:13', '2009-12-31 18:26:13', 1, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 6, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943529782, 920710318, 0, '2009-12-01 18:26:13', '2009-12-31 18:26:13', 1, 0.5, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 6.5, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943561607, 920710318, 0, '2009-12-01 18:26:13', '2009-12-31 18:26:13', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 1, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943561733, 920710318, 0, '2009-12-01 18:26:13', '2009-12-31 18:26:13', 1, 0, 0.25, 9.95, 5, 1, 5, 7, 0.05, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 29.25, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943562135, 920710318, 0, '2009-11-23 17:43:03', '2009-12-23 17:43:03', 1, 0.7, 0.25, 9.95, 5, 1, 5, 7, 0.05, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 29.95, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943562611, 920710318, 0, '2009-12-01 18:26:13', '2009-12-31 18:26:13', 1, 0, 0.25, 9.95, 5, 1, 5, 7, 0.05, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 29.25, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943562907, 920710318, 0, '2009-12-01 18:26:13', '2009-12-31 18:26:13', 1, 0, 0, 9.95, 5, 0, 5, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 27.95, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(943566232, 920710318, 0, '2009-12-01 18:26:13', '2009-12-31 18:26:13', 1, 0, 0, 9.95, 5, 0, 5, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 27.95, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(944256379, 920710318, 0, '2009-12-03 13:27:00', '2010-01-02 13:27:00', 1, 0, 0, 9.95, 5, 0, 5, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 27.95, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(944256380, 920710318, 0, '2009-12-03 13:27:00', '2010-01-02 13:27:00', 1, 0, 0, 9.95, 5, 0, 5, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 27.95, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(944256874, 920710318, 0, '2009-12-03 13:37:00', '2010-01-02 13:37:00', 1, 0, 0.25, 9.95, 5, 1, 5, 7, 0.05, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 29.25, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(945540149, 945538660, 0, '2009-12-17 23:08:53', '2010-01-16 23:08:53', 1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 10, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(945540219, 945538660, 0, '2009-12-18 09:50:18', '2010-01-17 09:50:18', 1, 13.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 14.5, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(945626440, 945538660, 0, '2009-12-18 09:46:12', '2010-01-17 09:46:12', 1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 10, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(945657026, 945538660, 0, '2010-01-03 21:46:03', '2010-02-02 21:46:03', 1, 0.35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 1.35, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(945660603, 945538660, 0, '2010-02-03 14:35:03', '2010-03-05 14:35:03', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 1, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(945663729, 945538660, 0, '2009-12-18 09:41:25', '2010-01-17 09:41:25', 1, 9.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 10.5, 0, NULL, NULL, '', 0);
INSERT INTO `invoices` VALUES(945694906, 945648040, 0, '2010-02-03 14:35:03', '2010-03-05 14:35:03', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'automated billing: no changes', 1, 0, NULL, NULL, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `itemnum` int(11) NOT NULL default '0',
  `status` tinyint(1) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `category1` int(11) NOT NULL default '-2',
  `category2` int(11) NOT NULL default '-2',
  `auction_type` varchar(1) NOT NULL default 'E',
  `title` varchar(255) NOT NULL default 'Auction Title',
  `auction_mode` int(11) default '0',
  `minimum_bid` double NOT NULL default '0',
  `maximum_bid` double NOT NULL default '0',
  `location` varchar(100) NOT NULL default 'Auction Location',
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
  `description` longtext NOT NULL,
  `desc_languages` varchar(250) NOT NULL default 'Description Languages',
  `picture` varchar(250) NOT NULL default 'http://',
  `picture1` varchar(250) default 'http://',
  `picture2` varchar(250) default 'http://',
  `picture3` varchar(250) default 'http://',
  `picture4` varchar(250) default 'http://',
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
  `salestax` varchar(10) default NULL,
  `shipping_fee` varchar(10) default NULL,
  `administrative` varchar(10) default NULL,
  `financial` varchar(10) default NULL,
  `premium` varchar(10) default NULL,
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


-- --------------------------------------------------------

--
-- Table structure for table `layout`
--

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
  PRIMARY KEY  (`id`),
  KEY `bid` (`bidicon`),
  KEY `id` (`id`),
  KEY `keywords` (`keywords`(10))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `layout`
--

INSERT INTO `layout` VALUES(1, 'VALogo.jpg', '2003-12-11 08:40:00', 'VA10_Screenshot.jpg', 'promotion.Jpg', 'Company Name', 'About Us Info Here', 'Contact Us Info Here', 'No', 'sales@you.com', 'no', '800217', 'No', 'login', 'password', 'gmt', 'Privacy Policy', 'Terms and Conditions', 5, 'problem@', 'service@', 'question@', '800217', 'c:\\\\winnt\\\\system32\\\\', 'secure.linkpt.net', 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 'THEPROPERTYBID.COM, The Property Bid, Property, lettings, Lettings, London, london, UK, uk, houses, estate agent, estate agents, estate, real estate, home, homes, house, residential, Residential, relocation, rent, property, buy a home, buy a house, properties, Properties, homes, Homes, Mobile, rents, house, real-estate, Real Estate, Real-Estate, Property lettings, property broker, Thepropertybid.com, property rents UK, England, The Property Bid, auction, auction my property, 10% commission fees, bid, cheap, home, house, house auction, let, ThePropertybid.com, Residential Property, Commercial Property, Property Auction, UK Estate Agent London, Estate Agent, Estate Agents, London Estate Agents, Real Estate, Commercial Property to Let, Property Auction, London Property Auctions, Regional Property, International Property, Property for Rent in UK, Properties for Rent in UK, Houses for rent in UK, Flats for rent in UK, Properties in UK, Houses in UK, Flats in UK, Property for Rent in London, Properties for rent in London, Houses for rent in London, Flats for Rent in London, Properties in London, Auction Properties for rent, Houses in London, Flats in London, Properties for Rent, Property for Rent, House for Rent, Flat for Rent, letting agent, lettings, low fees, online auction, online property auction, online property auction uk, property, property auction, property auctioneer, sell, uk estate agents, uk property', 'Thepropertybid.com the property rental auction site', 1, 'snakegreen.gif', 'snakeskinblack.gif', 'snakeskinblue.gif', 'snakeskindontknow.gif', 'snakeskingreen.gif', 'snakeskinlightblue.gif', 'snakeskinlime.gif', 'snakeskinorange.gif', 'snakeskinpurple.gif', 'snakeskinpink.gif', 'snakeskinred.gif', 'aboutme.gif', 'icon_bid.gif', 'icon_description.gif', 0, 1, 'member.gif', 1, 2, 2, '24', 'arial', '12', 'ffffff', 'ff8000', 1, 1003, '02254d', 'ffffff', 'arial', '14', '000080', 'aaaaaa', '4040ff', '000080', 'ffffff', '000000', 'arial', 'aaaaaa', 'bb0000', 10, 'layoutimages/map_section.gif', 'layoutimages/categories_section.gif', 'layoutimages/tellafriend_section.gif', 'layoutimages/featured_section.gif', 'layoutimages/hot_section.gif', 'layoutimages/gallery_section.gif', 'layoutimages/login_section.gif', 'layoutimages/promotions_section.gif', 'layoutimages/newusers_section.gif', 1, 2, 3, 5, 6, 4, 7, 8, 9, 'layoutimages/testimage.gif', 'layoutimages/no_image.gif', 'layoutimages/testimage.gif', 'layoutimages/testimage.gif', 'layoutimages/no_image.gif', 'layoutimages/no_image.gif', 'layoutimages/no_image.gif', 'layoutimages/no_image.gif', 'layoutimages/no_image.gif');

-- --------------------------------------------------------

--
-- Table structure for table `loggedin`
--

CREATE TABLE `loggedin` (
  `ID` int(11) NOT NULL auto_increment,
  `nickname` varchar(255) default NULL,
  `loggedin` tinyint(1) default NULL,
  `date_time` datetime default NULL,
  `remote_ip` varchar(50) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `loggedin`
--

INSERT INTO `loggedin` VALUES(28, 'douglas', 1, '2010-05-05 14:14:07', '76.90.242.50');

-- --------------------------------------------------------

--
-- Table structure for table `member_bal`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `member_bal`
--


-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

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

INSERT INTO `messages` VALUES(958255453, 958245011, 'test', 0, 0, 0, 'test', 958245011, 0, 'Normal', '2010-05-12 14:04:13');
INSERT INTO `messages` VALUES(958255490, 958245011, 'hi rich,\r\n\r\nthis is a test message. please reply upon receipt.\r\n\r\nthanks,\r\n\r\ngolden', 0, 1, 0, 'test', 958244181, 0, 'Normal', '2010-05-12 14:04:50');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL auto_increment,
  `news` longtext,
  `date_posted` datetime default NULL,
  `title` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=50 ;

--
-- Dumping data for table `news`
--

INSERT INTO `news` VALUES(48, 'There is no news today.  Sorry, everything is fine.', '2009-03-09 01:47:01', 'Newsof the Day');
INSERT INTO `news` VALUES(49, 'March 2010', '2010-02-21 09:37:26', 'Thepropertybid.com will soon be launching');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `payments`
--


-- --------------------------------------------------------

--
-- Table structure for table `proxy_bids`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84 ;

--
-- Dumping data for table `proxy_bids`
--

INSERT INTO `proxy_bids` VALUES(78, 943529782, 920710318, '2009-11-23 16:05:33', 10, 1, '71.165.176.40');
INSERT INTO `proxy_bids` VALUES(79, 943529782, 920710318, '2009-11-23 16:09:10', 11, 1, '71.165.176.40');
INSERT INTO `proxy_bids` VALUES(80, 943529782, 920710318, '2009-11-23 16:11:14', 12, 1, '71.165.176.40');
INSERT INTO `proxy_bids` VALUES(81, 943562135, 920710318, '2009-11-23 17:42:37', 14, 1, '71.165.176.40');
INSERT INTO `proxy_bids` VALUES(82, 943562611, 920710318, '2009-11-23 17:43:53', 10, 1, '71.165.176.40');
INSERT INTO `proxy_bids` VALUES(83, 943562907, 920710318, '2009-11-23 18:45:25', 10, 1, '71.165.176.40');

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `registration`
--


-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `stats`
--

INSERT INTO `stats` VALUES(1, 0, 3, 2, 4, 636, 53);

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

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


-- --------------------------------------------------------

--
-- Table structure for table `stored`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `stored`
--


-- --------------------------------------------------------

--
-- Table structure for table `tracking`
--

CREATE TABLE `tracking` (
  `id` int(11) NOT NULL auto_increment,
  `tracker` varchar(50) NOT NULL,
  `webbrowser` varchar(255) default NULL,
  `referer` longtext,
  `date_time` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=469 ;

--
-- Dumping data for table `tracking`
--

INSERT INTO `tracking` VALUES(416, '76.168.104.195', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) ; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)', '', '2009-03-01 16:17:15');
INSERT INTO `tracking` VALUES(417, '71.105.206.6', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; FunWebProducts; .NET CLR 2.0.50727)', 'http://us.mc373.mail.yahoo.com/mc/showMessage?fid=Inbox&sort=date&order=down&startMid=0&.rand=1251191401&da=0&midIndex=4&mid=1_4083869_APVav9EAABmFSariQA1M2jof1bI&prevMid=1_4084402_APdav9EAAETdSarupw43e35aFtw&nextMid=1_4083352_APlav9EAAMqlSarGowP7vUClImk&m=1_4085953_APZav9EAAKd8SavnpgJjkDZdgZU,1_4085436_APhav9EAAPR0SavUHAB6Sx1iLJI,1_4084919_APhav9EAAA2LSaubNAXmjUczmHc,1_4084402_APdav9EAAETdSarupw43e35aFtw,1_4083869_APVav9EAABmFSariQA1M2jof1bI,1_4083352_APlav9EAAMqlSarGowP7vUClImk,1_4082720_APlav9EAAHetSaq95wOytwtXtoU,1_4082044_APZav9EAATOUSapxVwCR2SY0hvo,1_4080385_APpav9EAACVySapheAhCBD9cdIk,1_4081279_APtav9EAAMfCSaphnwGUDhnoUF8,', '2009-03-02 12:42:02');
INSERT INTO `tracking` VALUES(418, '75.51.178.199', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)', '', '2009-03-04 22:58:38');
INSERT INTO `tracking` VALUES(419, '121.1.18.237', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)', '', '2009-03-08 20:30:36');
INSERT INTO `tracking` VALUES(420, '121.1.37.149', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)', 'http://68.183.144.71:5606/', '2009-03-08 21:06:17');
INSERT INTO `tracking` VALUES(421, '120.28.131.222', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)', '', '2009-03-09 01:11:37');
INSERT INTO `tracking` VALUES(422, '222.127.38.23', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)', '', '2009-03-09 01:42:36');
INSERT INTO `tracking` VALUES(423, '222.127.191.2', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.1', 'http://68.183.144.71:5606/admin/login.cfm?failed=2&CFID=92639&CFTOKEN=75364441', '2009-03-12 04:35:32');
INSERT INTO `tracking` VALUES(424, '121.54.32.97', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)', '', '2009-03-16 00:18:52');
INSERT INTO `tracking` VALUES(425, '222.127.41.6', 'Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420.1 (KHTML, like Gecko) Version/3.0 Mobile/4A102 Safari/419.3', 'http://68.183.144.71:5610/admin/login.cfm?failed=2&CFID=94032&CFTOKEN=83715032', '2009-03-17 02:06:55');
INSERT INTO `tracking` VALUES(426, '68.111.72.40', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7', 'http://email.secureserver.net/webmail.php?login=1', '2009-03-23 21:45:01');
INSERT INTO `tracking` VALUES(427, '68.183.144.71', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; InfoPath.2)', 'http://68.183.144.71:5610/admin/login.cfm?failed=2&CFID=92832&CFTOKEN=74554572', '2009-03-25 13:56:06');
INSERT INTO `tracking` VALUES(428, '202.57.45.50', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)', '', '2009-09-26 05:49:39');
INSERT INTO `tracking` VALUES(429, '202.69.188.166', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3', '', '2009-09-26 05:49:47');
INSERT INTO `tracking` VALUES(430, '76.90.242.50', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB6; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) ; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)', '', '2009-10-24 14:32:31');
INSERT INTO `tracking` VALUES(431, '71.165.176.40', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; FunWebProducts;  Embedded Web Browser from: http://bsalsa.com/; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; yie8)', '', '2009-10-30 01:48:17');
INSERT INTO `tracking` VALUES(432, '75.200.83.239', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-11-11 16:57:35');
INSERT INTO `tracking` VALUES(433, '207.47.211.232', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322)', '', '2009-11-23 20:40:31');
INSERT INTO `tracking` VALUES(434, '68.11.146.43', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.15) Gecko/2009101601 Firefox/3.0.15 (.NET CLR 3.5.30729)', 'http://heritagespringer.com:2095/horde/imp/view.php?popup_view=1&index=5282&mailbox=INBOX&actionID=view_attach&id=1&mimecache=654b401a5808dd34003fcf0854c82c64', '2009-11-24 15:33:02');
INSERT INTO `tracking` VALUES(435, '24.226.16.20', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5 (.NET CLR 3.5.30729)', '', '2009-12-01 14:27:17');
INSERT INTO `tracking` VALUES(436, '75.251.83.224', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-03 08:02:08');
INSERT INTO `tracking` VALUES(437, '75.250.14.170', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-04 00:35:24');
INSERT INTO `tracking` VALUES(438, '75.203.215.29', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-05 03:23:19');
INSERT INTO `tracking` VALUES(439, '75.200.12.190', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-09 13:25:17');
INSERT INTO `tracking` VALUES(440, '75.201.96.111', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-09 23:16:00');
INSERT INTO `tracking` VALUES(441, '209.136.146.112', 'ColdFusion', '', '2009-12-10 00:15:49');
INSERT INTO `tracking` VALUES(442, '75.248.22.96', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-10 23:04:15');
INSERT INTO `tracking` VALUES(443, '75.249.19.165', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-12 04:22:07');
INSERT INTO `tracking` VALUES(444, '75.201.24.89', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-12 18:47:47');
INSERT INTO `tracking` VALUES(445, '202.147.26.18', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.43 Safari/530.5', '', '2009-12-15 04:59:49');
INSERT INTO `tracking` VALUES(446, '112.201.101.122', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; InfoPath.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)', '', '2009-12-15 21:56:48');
INSERT INTO `tracking` VALUES(447, '124.83.27.88', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091107 Firefox/3.5.5 CometBird/3.5.5', 'http://209.136.146.112/admin/login.cfm?failed=2&CFID=502511&CFTOKEN=46365084', '2009-12-15 21:57:12');
INSERT INTO `tracking` VALUES(448, '75.249.172.139', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-16 04:41:48');
INSERT INTO `tracking` VALUES(449, '75.248.67.213', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-16 12:27:54');
INSERT INTO `tracking` VALUES(450, '121.54.2.4', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.15) Gecko/2009102815 Ubuntu/9.04 (jaunty) Firefox/3.0.15', '', '2009-12-16 14:16:17');
INSERT INTO `tracking` VALUES(451, '124.83.29.79', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091107 Firefox/3.5.5 CometBird/3.5.5', 'http://209.136.146.112/admin/login.cfm?failed=2&CFID=502511&CFTOKEN=46365084', '2009-12-16 22:38:57');
INSERT INTO `tracking` VALUES(452, '75.200.132.161', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-17 03:20:12');
INSERT INTO `tracking` VALUES(453, '75.250.166.202', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-17 22:57:08');
INSERT INTO `tracking` VALUES(454, '124.83.16.137', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091107 Firefox/3.5.5 CometBird/3.5.5', 'http://209.136.146.112/admin/login.cfm?failed=2&CFID=502511&CFTOKEN=46365084', '2009-12-18 00:16:32');
INSERT INTO `tracking` VALUES(455, '124.83.28.206', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091107 Firefox/3.5.5 CometBird/3.5.5', '', '2009-12-18 21:08:52');
INSERT INTO `tracking` VALUES(456, '75.201.125.97', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)', '', '2009-12-19 04:36:20');
INSERT INTO `tracking` VALUES(457, '207.201.197.25', 'Opera/9.80 (Windows NT 5.1; U; en) Presto/2.2.15 Version/10.10', '', '2010-02-03 14:34:30');
INSERT INTO `tracking` VALUES(458, '209.12.152.27', 'ColdFusion', '', '2010-02-03 20:02:53');
INSERT INTO `tracking` VALUES(459, '204.11.25.80', 'Toata dragostea mea pentru diavola', '', '2010-02-17 15:36:35');
INSERT INTO `tracking` VALUES(460, '93.186.31.208', 'BlackBerry9000/4.6.0.303 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/245', '', '2010-02-17 17:28:46');
INSERT INTO `tracking` VALUES(461, '208.80.193.42', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; SIMBAR Enabled; (R1 1.3); .NET CLR 1.1.4322)', '', '2010-02-18 01:58:53');
INSERT INTO `tracking` VALUES(462, '208.80.193.32', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; LN; .NET CLR 1.1.4322; InfoPath.1)', '', '2010-02-19 15:30:18');
INSERT INTO `tracking` VALUES(463, '81.141.85.69', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-GB; rv:1.9.2) Gecko/20100115 Firefox/3.6 (.NET CLR 3.5.30729)', 'http://209.12.152.44/admin/login.cfm?failed=2&CFID=981225&CFTOKEN=37802058', '2010-02-20 12:39:49');
INSERT INTO `tracking` VALUES(464, '208.80.193.34', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; InfoPath.1; SpamBlockerUtility 4.8.4)', '', '2010-02-21 04:41:04');
INSERT INTO `tracking` VALUES(465, '82.45.221.199', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-GB; rv:1.9.2) Gecko/20100115 Firefox/3.6 (.NET CLR 3.5.30729)', 'http://209.12.152.44/admin/login.cfm?failed=2&CFID=981225&CFTOKEN=37802058', '2010-02-21 08:51:02');
INSERT INTO `tracking` VALUES(466, '74.52.245.146', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0', '', '2010-05-06 11:42:59');
INSERT INTO `tracking` VALUES(467, '184.73.125.181', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.1.6; taptu-downloader) Gecko/20070725 Firefox/2.0.0.6', '', '2010-05-06 18:18:57');
INSERT INTO `tracking` VALUES(468, '64.246.165.210', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)', 'http://whois.domaintools.com/visualbarter.com', '2010-05-11 05:35:40');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_log`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1904 ;

--
-- Dumping data for table `transaction_log`
--

INSERT INTO `transaction_log` VALUES(1761, 0, 0, '2009-03-04 03:24:14', 'Account Created & Finalized by Administrator', 'NAME: David', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1762, 0, 0, '2009-03-04 03:24:33', 'Access changed', 'Access changed for David', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1763, 0, 0, '2009-03-04 03:28:31', 'Account Deleted by Administrator', 'USER ID: 30', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1764, 0, 0, '2009-03-04 03:29:47', 'Account Created & Finalized by Administrator', 'NAME: Davidh', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1765, 0, 0, '2009-03-04 04:07:19', 'Access changed', 'Access changed for Administrator', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1766, 0, 0, '2009-03-04 04:07:42', 'Site Defaults Modified', 'No Details Available', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1767, 0, 0, '2009-03-04 04:07:57', 'Account Information Updated by Administrator', 'USER ID: 880835450', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1768, 0, 0, '2009-03-04 04:09:28', 'Category Created', 'CATEGORY NAME: Top Level 1     CATEGORY ID: 920704167     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1769, 0, 0, '2009-03-04 04:09:39', 'Category Created', 'CATEGORY NAME: Level 2     CATEGORY ID: 920704179     PARENT: 920704167     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1770, 0, 0, '2009-03-04 04:09:55', 'Category Created', 'CATEGORY NAME: Level 3     CATEGORY ID: 920704195     PARENT: 920704179     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1771, 0, 0, '2009-03-04 04:10:05', 'Category Created', 'CATEGORY NAME: Level 4     CATEGORY ID: 920704205     PARENT: 920704195     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1772, 0, 0, '2009-03-04 04:10:14', 'Category Created', 'CATEGORY NAME: Level 5     CATEGORY ID: 920704214     PARENT: 920704205     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1773, 0, 0, '2009-03-04 04:10:24', 'Category Created', 'CATEGORY NAME: Level 6     CATEGORY ID: 920704223     PARENT: 920704214     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1774, 0, 0, '2009-03-04 04:10:32', 'Category Created', 'CATEGORY NAME: Level 7     CATEGORY ID: 920704232     PARENT: 920704223     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1775, 0, 0, '2009-03-04 04:10:43', 'Category Created', 'CATEGORY NAME: Level 8     CATEGORY ID: 920704243     PARENT: 920704232     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1776, 0, 0, '2009-03-04 04:12:31', 'Account Created & Finalized by Administrator', 'USER ID: 920704351', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1777, 0, 920710318, '2009-03-04 05:51:58', 'Account Created', 'EMAIL: opalsoftwarenet@yahoo.com', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1778, 0, 0, '2009-03-04 05:52:42', 'Account Information Updated by Administrator', 'USER ID: 920710318', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1779, 920710623, 920710318, '2009-03-04 05:57:08', 'Auction Started', 'Just testing ', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1780, 0, 920710318, '2009-03-04 05:57:25', 'Account Information Updated', 'No Details Available', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1781, 0, 0, '2009-03-04 23:00:29', 'Account Created & Finalized by Administrator', 'NAME: Test Admin', 0, '75.51.178.199');
INSERT INTO `transaction_log` VALUES(1782, 0, 0, '2009-03-08 21:10:55', 'Category Created', 'CATEGORY NAME: SubLevel 6a     CATEGORY ID: 921111055     PARENT: 920704214     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1783, 0, 0, '2009-03-08 21:11:25', 'Category Created', 'CATEGORY NAME: SubLevel 6b     CATEGORY ID: 921111085     PARENT: 921111055     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1784, 0, 0, '2009-03-09 01:47:02', 'Add news', 'ADD NEWS OPTION', 0, '222.127.38.23');
INSERT INTO `transaction_log` VALUES(1785, 0, 0, '2009-03-12 05:58:26', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1786, 0, 0, '2009-03-12 05:58:43', 'Report Ran (All Auctions)', 'OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1787, 0, 0, '2009-03-12 05:59:21', 'Report Ran (Mailing List)', 'OUTPUT TYPE: csv     SORT ORDER: nameA     NICKNAME: 0     USER ID: 0     DATE REGISTERED: 0     MAILING ADDRESS: 0     PHONE NUMBERS: 0     PREFERRED LANGUAGE: 0     SURVEY INFO: 0     COMPANY: 0', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1788, 0, 0, '2009-03-12 06:00:47', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1789, 0, 0, '2009-03-12 06:01:22', 'Report Ran (All Auctions)', 'OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1790, 0, 0, '2009-03-12 06:02:01', 'Report Ran (Account History)', 'OUTPUT TYPE: csv     SORT ORDER: nameA     DAYS: 30', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1791, 0, 0, '2009-03-12 06:02:28', 'Report Ran (Transaction Log)', 'OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1792, 0, 0, '2009-03-12 06:03:01', 'Report Ran (Transaction Log)', 'OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1793, 0, 0, '2009-03-12 06:03:29', 'Report Ran (Winning Bidder)', 'FROM DATE: 03/11/2009    TO DATE: 03/12/2009    OUTPUT TYPE: csv     SORT ORDER: itemnumA     MAILING ADDRESS: 0     PHONE NUMBERS: 0     LOCATION: 0     DATE_END: 0', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1794, 0, 0, '2009-03-12 06:04:00', 'Report Ran (Users Information)', 'FROM DATE: 03/11/2009    TO DATE: 03/12/2009    OUTPUT TYPE: csv     SORT ORDER: nicknameA', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1795, 0, 0, '2009-03-12 06:04:34', 'Report Ran (Mailing List)', 'OUTPUT TYPE: csv     SORT ORDER: nameA     NICKNAME: 0     USER ID: 0     DATE REGISTERED: 0     MAILING ADDRESS: 0     PHONE NUMBERS: 0     PREFERRED LANGUAGE: 0     SURVEY INFO: 0     COMPANY: 0', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1796, 0, 0, '2009-03-12 06:21:07', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1797, 0, 0, '2009-03-12 06:28:30', 'Report Ran (All Auctions)', 'OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7', 0, '121.1.18.237');
INSERT INTO `transaction_log` VALUES(1798, 921554191, 880835450, '2009-03-14 00:18:14', 'Auction Started by Administrator', 'TITLE: Test post from admin     STATUS: 1     DATE START: {ts ''2009-03-13 19:16:00''}     DATE END: {ts ''2009-03-15 19:16:00''}     QUANTITY: 1     MINIMUM BID: 100  MAXMINIMUM BID: 0   RESERVE BID: 150     USE BID INCREMENT: 1     INCREMENT VALUE: 1     USE DYNAMIC CLOSE: 0     DYNAMIC VALUE: 0     CATEGORY 1: 920704167     CATEGORY 2: -1     PRIVATE: 0     USE BANNER: 0     BANNER LINE: ', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1799, 0, 0, '2009-03-14 00:18:29', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1800, 0, 0, '2009-03-14 00:22:55', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 90', 0, '71.105.206.6');
INSERT INTO `transaction_log` VALUES(1801, 0, 0, '2009-03-14 01:05:57', 'Add New No Invoice User (adopogi3)', 'NEW NO INVOICE USER: adopogi3', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1802, 0, 0, '2009-03-14 01:11:23', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1803, 0, 0, '2009-03-14 01:11:34', 'Report Ran (All Auctions)', 'OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1804, 0, 0, '2009-03-14 01:11:44', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1805, 0, 0, '2009-03-14 01:11:53', 'Report Ran (Account History)', 'OUTPUT TYPE: csv     SORT ORDER: nameA     DAYS: 30', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1806, 0, 0, '2009-03-14 01:12:00', 'Report Ran (Transaction Log)', 'OUTPUT TYPE: csv     SORT ORDER: dateA     DAYS: 30', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1807, 0, 0, '2009-03-14 01:12:08', 'Report Ran (All Auctions)', 'OUTPUT TYPE: html     SORT ORDER: dateD     DAYS: 7', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1808, 0, 0, '2009-03-15 00:01:26', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1809, 0, 0, '2009-03-15 02:13:47', 'Report Ran (Completed Auctions)', 'OUTPUT TYPE: csv     SORT ORDER: dateD     DAYS: 7', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1810, 0, 0, '2009-03-16 00:50:38', 'Update meta keywords information', 'Meta keywords information updated', 0, '121.1.37.149');
INSERT INTO `transaction_log` VALUES(1811, 0, 0, '2010-05-05 14:13:48', 'Account Created & Finalized by Administrator', 'USER ID: 957633228', 0, '76.90.242.50');
INSERT INTO `transaction_log` VALUES(1812, 0, 0, '2010-05-05 17:55:24', 'Ad Expired (Invalid User ID)', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1813, 0, 0, '2010-05-05 17:55:25', 'Ad Expired (Invalid User ID)', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1814, 0, 0, '2010-05-05 17:55:25', 'Ad Expired (Invalid User ID)', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1815, 957647794, 957633228, '2010-05-05 18:55:17', 'Auction Started', 'Test Again', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1816, 957660517, 957633228, '2010-05-05 22:23:13', 'Auction Started', 'Test Test', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1817, 0, 958244181, '2010-05-12 15:56:21', 'New Membership ( richierich)', 'MEMBERSHIP FEE: 30    MEMBERSHIP OPTION: 30_80_Platinum_Annual', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1818, 0, 0, '2010-05-12 15:56:21', 'Account Created & Finalized by Administrator', 'USER ID: 958244181', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1819, 0, 0, '2010-05-12 15:57:51', 'Site Information Updated', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1820, 0, 0, '2010-05-12 15:58:31', 'Site Information Updated', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1821, 0, 0, '2010-05-12 15:59:10', 'Site Information Updated', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1822, 0, 0, '2010-05-12 16:10:11', 'Account Created & Finalized by Administrator', 'USER ID: 958245011', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1823, 0, 0, '2010-05-12 16:10:57', 'Category Created', 'CATEGORY NAME: Apparel     CATEGORY ID: 958245057     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 1', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1824, 0, 0, '2010-05-12 16:14:53', 'Site Information Updated', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1825, 0, 0, '2010-05-12 16:15:53', 'Company Name updated', 'Company Name updated', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1826, 958247076, 958245011, '2010-05-12 16:45:02', 'Auction Started', 'ftrt', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1827, 958256883, 958245011, '2010-05-12 19:28:17', 'Auction Started', 'Residential High-Rise Apartments at the Heart of the City', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1828, 0, 958270021, '2010-05-12 23:07:01', 'Account Created', 'EMAIL: douglaspaulmusic@yahoo.com', 0, '76.90.242.50');
INSERT INTO `transaction_log` VALUES(1829, 0, 0, '2010-06-17 21:36:14', 'Site Information Updated', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1830, 0, 0, '2010-06-17 21:38:08', 'Category Deleted', 'CATEGORY ID: 951237253     PARENT: 951234046', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1831, 0, 0, '2010-06-17 21:38:09', 'Category Deleted', 'CATEGORY ID: 951237281     PARENT: 951234046', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1832, 0, 0, '2010-06-17 21:38:10', 'Category Deleted', 'CATEGORY ID: 951237201     PARENT: 951234046', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1833, 0, 0, '2010-06-17 21:38:12', 'Category Deleted', 'CATEGORY ID: 951237190     PARENT: 951234046', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1834, 0, 0, '2010-06-17 21:38:18', 'Category Public Sales Disabled', 'CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1835, 0, 0, '2010-06-17 21:38:27', 'Category Public Sales Disabled', 'CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1836, 0, 0, '2010-06-17 21:38:31', 'Category Public Sales Disabled', 'CATEGORY ID: 951234046     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1837, 0, 0, '2010-06-17 21:38:43', 'Category Public Sales Disabled', 'CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1838, 0, 0, '2010-06-17 21:38:49', 'Category Deleted', 'CATEGORY ID: 955837322     PARENT: 0', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1839, 0, 0, '2010-06-17 21:38:57', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1840, 0, 0, '2010-06-17 21:39:02', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1841, 0, 0, '2010-06-17 21:39:03', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1842, 0, 0, '2010-06-17 21:39:04', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1843, 0, 0, '2010-06-17 21:39:18', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1844, 0, 0, '2010-06-17 21:39:43', 'Category Deleted', 'CATEGORY ID: 951237044     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1845, 0, 0, '2010-06-17 21:39:47', 'Category Deleted', 'CATEGORY ID: 951789814     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1846, 0, 0, '2010-06-17 21:39:50', 'Category Deleted', 'CATEGORY ID: 951234467     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1847, 0, 0, '2010-06-17 21:39:51', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1848, 0, 0, '2010-06-17 21:39:54', 'Category Deleted', 'CATEGORY ID: 951234475     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1849, 0, 0, '2010-06-17 21:39:57', 'Category Deleted', 'CATEGORY ID: 951237035     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1850, 0, 0, '2010-06-17 21:39:59', 'Category Deleted', 'CATEGORY ID: 951237058     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1851, 0, 0, '2010-06-17 21:40:02', 'Category Deleted', 'CATEGORY ID: 951306825     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1852, 0, 0, '2010-06-17 21:40:05', 'Category Deleted', 'CATEGORY ID: 951234449     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1853, 0, 0, '2010-06-17 21:40:07', 'Category Deleted', 'CATEGORY ID: 951234207     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1854, 0, 0, '2010-06-17 21:40:10', 'Category Deleted', 'CATEGORY ID: 951234248     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1855, 0, 0, '2010-06-17 21:40:13', 'Category Deleted', 'CATEGORY ID: 951234500     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1856, 0, 0, '2010-06-17 21:40:15', 'Category Deleted', 'CATEGORY ID: 951234328     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1857, 0, 0, '2010-06-17 21:40:17', 'Category Deleted', 'CATEGORY ID: 951234289     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1858, 0, 0, '2010-06-17 21:40:19', 'Category Deleted', 'CATEGORY ID: 951234350     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1859, 0, 0, '2010-06-17 21:40:21', 'Category Deleted', 'CATEGORY ID: 951306759     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1860, 0, 0, '2010-06-17 21:40:23', 'Category Deleted', 'CATEGORY ID: 951234369     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1861, 0, 0, '2010-06-17 21:40:25', 'Category Deleted', 'CATEGORY ID: 951306836     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1862, 0, 0, '2010-06-17 21:40:27', 'Category Deleted', 'CATEGORY ID: 951306816     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1863, 0, 0, '2010-06-17 21:40:29', 'Category Deleted', 'CATEGORY ID: 951234423     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1864, 0, 0, '2010-06-17 21:40:31', 'Category Deleted', 'CATEGORY ID: 951234385     PARENT:  951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1865, 0, 0, '2010-06-17 21:40:33', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1866, 0, 0, '2010-06-17 21:40:40', 'Category Public Sales Disabled', 'CATEGORY ID: 951234046     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1867, 0, 0, '2010-06-17 21:40:47', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1868, 0, 0, '2010-06-17 21:40:51', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1869, 0, 0, '2010-06-17 21:41:10', 'Category Public Sales Disabled', 'CATEGORY ID: 951234046     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1870, 0, 0, '2010-06-17 21:41:15', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1871, 0, 0, '2010-06-17 21:41:33', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1872, 0, 0, '2010-06-17 21:41:46', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1873, 0, 0, '2010-06-17 21:41:57', 'Category Public Sales Disabled', 'CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1874, 0, 0, '2010-06-17 21:42:17', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1875, 0, 0, '2010-06-17 21:42:29', 'Category Information Updated', 'CATEGORY NAME: Apartments     CATEGORY ID: 951236959     ACTIVE: 0     ALLOW PUBLIC SALES: 0    FEE LISTING: 1', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1876, 0, 0, '2010-06-17 21:42:31', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1877, 0, 0, '2010-06-17 21:42:33', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1878, 0, 0, '2010-06-17 21:42:51', 'Category Public Sales Disabled', 'CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1879, 0, 0, '2010-06-17 21:42:53', 'Category Public Sales Disabled', 'CATEGORY ID: 958245057     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1880, 0, 0, '2010-06-17 21:43:00', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1881, 0, 0, '2010-06-17 21:43:29', 'Category Information Updated', 'CATEGORY NAME: Apartments     CATEGORY ID: 951236959     ACTIVE: 1     ALLOW PUBLIC SALES: 1    FEE LISTING: 1', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1882, 0, 0, '2010-06-17 21:43:31', 'Category Public Sales Disabled', 'CATEGORY ID: 951236959     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1883, 958256883, 0, '2010-06-17 21:44:25', 'Auction Deleted by Administrator', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1884, 957647794, 0, '2010-06-17 21:44:36', 'Auction Deleted by Administrator', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1885, 957660517, 0, '2010-06-17 21:44:39', 'Auction Deleted by Administrator', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1886, 958247076, 0, '2010-06-17 21:44:55', 'Auction Deleted by Administrator', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1887, 945657026, 0, '2010-06-17 21:44:56', 'Auction Deleted by Administrator', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1888, 945694906, 0, '2010-06-17 21:44:57', 'Auction Deleted by Administrator', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1889, 945660603, 0, '2010-06-17 21:44:58', 'Auction Deleted by Administrator', 'No Details Available', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1890, 0, 0, '2010-06-17 21:45:34', 'Category Deleted', 'CATEGORY ID: 958245057     PARENT: 0', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1891, 0, 0, '2010-06-17 21:45:36', 'Category Deleted', 'CATEGORY ID: 951234046     PARENT: 0', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1892, 0, 0, '2010-06-17 21:45:40', 'Category Deleted', 'CATEGORY ID: 951236959     PARENT: 951234037', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1893, 0, 0, '2010-06-17 21:45:45', 'Category Deleted', 'CATEGORY ID: 951234037     PARENT: 0', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1894, 0, 0, '2010-06-17 21:46:11', 'Category Created', 'CATEGORY NAME: Test Only     CATEGORY ID: 961375571     PARENT: 0     ACTIVE: 1     ALLOW PUBLIC SALES: 0', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1895, 0, 0, '2010-06-17 21:46:28', 'Account Deleted by Administrator', 'USER ID: 14', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1896, 0, 0, '2010-06-17 21:46:37', 'Account Deleted by Administrator', 'USER ID: 958244181', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1897, 0, 0, '2010-06-17 21:46:44', 'Account Deleted by Administrator', 'USER ID: 958245011', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1898, 0, 0, '2010-06-17 21:46:49', 'Account Deleted by Administrator', 'USER ID: 958270021', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1899, 0, 0, '2010-06-17 21:47:31', 'Account Information Updated by Administrator', 'USER ID: 957633228', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1900, 0, 0, '2010-06-17 21:49:18', 'Account Created & Finalized by Administrator', 'USER ID: 961375758', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1901, 0, 0, '2010-06-17 21:58:18', 'Company Name updated', 'Company Name updated', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1902, 0, 0, '2010-06-17 21:59:29', 'Update about us', 'About us updated', 0, '68.183.144.71');
INSERT INTO `transaction_log` VALUES(1903, 0, 0, '2010-06-17 22:00:00', 'Update contact', 'contact updated', 0, '68.183.144.71');

-- --------------------------------------------------------

--
-- Table structure for table `uploads`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `uploads`
--


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

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

INSERT INTO `users` VALUES(957633228, 'douglas', 'douglas@douglas.com', 'douglas123', '123', '2010-05-05 14:13:48', NULL, NULL, 'douglas', 'none', '1111111', '', 'CBP', 'CA', '90621', 'USA', '111111111', '', 'none', 'http://', 'http://', 'New Comment', 'en', 'Business Associate', '', '', 'P', '', '25-34', 'College', '$25,000 - $35,000', 1, 'N', 1, 0, 0, 0, '2010-05-05 14:13:48', 1, '2010-05-05 14:13:48', '0', '0', '0', '127.0.0.1', NULL, NULL, NULL, NULL, 1, '', '', '', '', '', 'USA', 1, 1, 1, 1, 0, NULL, NULL, 1, NULL, NULL, 0, 0);
INSERT INTO `users` VALUES(961375758, 'adopogi2', 'ad@ado.com', 'adopogi2', 'adopogi2', '2010-06-17 21:49:18', NULL, NULL, 'adopogi2', 'none', '1111 Nowhere St.', '', 'Nowhere', 'CA', '90680', 'USA', '714-555-1212', '', 'none', 'http://', 'http://', 'New Comment', 'en', 'Business Associate', '', '', 'P', '', '25-34', 'College', '$25,000 - $35,000', 1, 'N', 1, 0, 0, 0, '2010-06-17 21:49:18', 1, '2010-06-17 21:49:18', '0', '0', '0', '127.0.0.1', NULL, NULL, NULL, NULL, 1, '', '', '', '', '', 'USA', 1, 1, 1, 1, 0, NULL, NULL, 1, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `xcategories`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=921111088 ;

--
-- Dumping data for table `xcategories`
--

INSERT INTO `xcategories` VALUES(920704167, 0, 1, 'Top Level 1', '2009-03-03 23:09:17', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO `xcategories` VALUES(920704179, 920704167, 1, 'Level 2', '2009-03-03 23:09:32', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 0, 0, 0, 0, 0, 0, 2);
INSERT INTO `xcategories` VALUES(920704195, 920704179, 1, 'Level 3', '2009-03-03 23:09:41', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 920704195, 0, 0, 0, 0, 0, 3);
INSERT INTO `xcategories` VALUES(920704205, 920704195, 1, 'Level 4', '2009-03-03 23:09:59', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 920704195, 920704205, 0, 0, 0, 0, 4);
INSERT INTO `xcategories` VALUES(920704214, 920704205, 2, 'Level 5', '2009-03-03 23:10:07', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 920704195, 920704205, 920704214, 0, 0, 0, 5);
INSERT INTO `xcategories` VALUES(920704223, 920704214, 1, 'Level 6', '2009-03-03 23:10:17', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 920704195, 920704205, 920704214, 920704223, 0, 0, 6);
INSERT INTO `xcategories` VALUES(920704232, 920704223, 1, 'Level 7', '2009-03-03 23:10:26', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 920704195, 920704205, 920704214, 920704223, 920704232, 0, 7);
INSERT INTO `xcategories` VALUES(920704243, 920704232, 0, 'Level 8', '2009-03-03 23:10:35', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 920704195, 920704205, 920704214, 920704223, 920704232, 920704243, 8);
INSERT INTO `xcategories` VALUES(921111055, 920704214, 1, 'SubLevel 6a', '2009-03-08 16:10:30', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 920704195, 920704205, 920704214, 921111055, 0, 0, 6);
INSERT INTO `xcategories` VALUES(921111085, 921111055, 0, 'SubLevel 6b', '2009-03-08 16:11:09', 1, 1, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 920704167, 920704179, 920704195, 920704205, 920704214, 921111055, 921111085, 0, 7);
INSERT INTO `xcategories` VALUES(921111086, -3, 0, '_None', '1999-01-01 00:00:00', 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `xcategories` VALUES(921111087, -1, 1, '_Top', '1999-01-01 00:00:00', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `zips`
--

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

INSERT INTO `zips` VALUES('00210', 'Portsmouth', 'NH', 'Rockingham', 43.05685, -70.782013, '603');
INSERT INTO `zips` VALUES('00211', 'Portsmouth', 'NH', 'Rockingham', 43.05685, -70.782013, '603');
INSERT INTO `zips` VALUES('00212', 'Portsmouth', 'NH', 'Rockingham', 43.05685, -70.782013, '603');
INSERT INTO `zips` VALUES('00213', 'Portsmouth', 'NH', 'Rockingham', 43.05685, -70.782013, '603');
INSERT INTO `zips` VALUES('00214', 'Portsmouth', 'NH', 'Rockingham', 43.05685, -70.782013, '603');
INSERT INTO `zips` VALUES('00215', 'Portsmouth', 'NH', 'Rockingham', 43.05685, -70.782013, '603');
INSERT INTO `zips` VALUES('00501', 'Holtsville', 'NY', 'Suffolk', 40.813296, -73.047623, '631');
INSERT INTO `zips` VALUES('00544', 'Holtsville', 'NY', 'Suffolk', 40.813296, -73.047623, '631');
INSERT INTO `zips` VALUES('00601', 'Adjuntas', 'PR', 'Adjuntas', 18.1045, -66.45, '787');
INSERT INTO `zips` VALUES('00602', 'Aguada', 'PR', 'Aguada', 18.382156, -67.187814, '787');
INSERT INTO `zips` VALUES('00603', 'Aguadilla', 'PR', 'Aguadilla', 18.439712, -67.154909, '787');
INSERT INTO `zips` VALUES('00604', 'Aguadilla', 'PR', 'Aguadilla', 18.439712, -67.154909, '787');
INSERT INTO `zips` VALUES('00605', 'Aguadilla', 'PR', 'Aguadilla', 18.439712, -67.154909, '787');
INSERT INTO `zips` VALUES('00606', 'Maricao', 'PR', 'Maricao', 18.186137, -66.98043, '787');
INSERT INTO `zips` VALUES('00610', 'Anasco', 'PR', 'Anasco', 18.288466, -67.141345, '787');
INSERT INTO `zips` VALUES('00611', 'Angeles', 'PR', 'Utuado', 18.271407, -66.705606, '787');
INSERT INTO `zips` VALUES('00612', 'Arecibo', 'PR', 'Arecibo', 18.456723, -66.735899, '787');
INSERT INTO `zips` VALUES('00613', 'Arecibo', 'PR', 'Arecibo', 18.456723, -66.735899, '787');
INSERT INTO `zips` VALUES('00614', 'Arecibo', 'PR', 'Arecibo', 18.456723, -66.735899, '787');
INSERT INTO `zips` VALUES('00616', 'Bajadero', 'PR', 'Arecibo', 18.425285, -66.676542, '787');
INSERT INTO `zips` VALUES('00617', 'Barceloneta', 'PR', 'Barceloneta', 18.454802, -66.538961, '787');
INSERT INTO `zips` VALUES('00622', 'Boqueron', 'PR', 'Cabo Rojo', 18.209544, -65.848864, '787');
INSERT INTO `zips` VALUES('00623', 'Cabo Rojo', 'PR', 'Cabo Rojo', 18.088289, -67.148564, '787');
INSERT INTO `zips` VALUES('00624', 'Penuelas', 'PR', 'Penuelas', 18.061508, -66.721403, '787');
INSERT INTO `zips` VALUES('00627', 'Camuy', 'PR', 'Camuy', 18.485664, -66.849072, '787');
INSERT INTO `zips` VALUES('00631', 'Castaner', 'PR', 'Lares', 18.296274, -66.882222, '787');
INSERT INTO `zips` VALUES('00636', 'Rosario', 'PR', 'San German', 18.084687, -67.0455, '787');
INSERT INTO `zips` VALUES('00637', 'Sabana Grande', 'PR', 'Sabana Grande', 18.084023, -66.96705, '787');
INSERT INTO `zips` VALUES('00638', 'Ciales', 'PR', 'Ciales', 18.336028, -66.470989, '787');
INSERT INTO `zips` VALUES('00641', 'Utuado', 'PR', 'Utuado', 18.271407, -66.705606, '787');
INSERT INTO `zips` VALUES('00646', 'Dorado', 'PR', 'Dorado', 18.47015, -66.271509, '787');
INSERT INTO `zips` VALUES('00647', 'Ensenada', 'PR', 'Guanica', 17.970369, -66.930667, '787');
INSERT INTO `zips` VALUES('00650', 'Florida', 'PR', 'Florida', 18.364391, -66.561529, '787');
INSERT INTO `zips` VALUES('00652', 'Garrochales', 'PR', 'Arecibo', 18.464356, -66.570133, '787');
INSERT INTO `zips` VALUES('00653', 'Guanica', 'PR', 'Guanica', 17.970369, -66.930667, '787');
INSERT INTO `zips` VALUES('00656', 'Guayanilla', 'PR', 'Guayanilla', 18.024881, -66.789968, '787');
INSERT INTO `zips` VALUES('00659', 'Hatillo', 'PR', 'Hatillo', 18.487172, -66.8235, '787');
INSERT INTO `zips` VALUES('00660', 'Hormigueros', 'PR', 'Hormigueros', 18.144351, -67.120759, '787');
INSERT INTO `zips` VALUES('00662', 'Isabela', 'PR', 'Isabela', 18.505278, -67.02104, '787');
INSERT INTO `zips` VALUES('00664', 'Jayuya', 'PR', 'Jayuya', 18.220457, -66.596969, '787');
INSERT INTO `zips` VALUES('00667', 'Lajas', 'PR', 'Lajas', 18.046367, -67.060264, '787');
INSERT INTO `zips` VALUES('00669', 'Lares', 'PR', 'Lares', 18.296274, -66.882222, '787');
INSERT INTO `zips` VALUES('00670', 'Las Marias', 'PR', 'Las Marias', 18.294321, -67.144848, '787');
INSERT INTO `zips` VALUES('00674', 'Manati', 'PR', 'Manati', 18.430958, -66.484242, '787');
INSERT INTO `zips` VALUES('00676', 'Moca', 'PR', 'Moca', 18.3966, -67.114157, '787');
INSERT INTO `zips` VALUES('00677', 'Rincon', 'PR', 'Rincon', 18.340953, -67.252636, '787');
INSERT INTO `zips` VALUES('00678', 'Quebradillas', 'PR', 'Quebradillas', 18.475841, -66.936284, '787');
INSERT INTO `zips` VALUES('00680', 'Mayaguez', 'PR', 'Mayaguez', 18.203568, -67.143361, '787');
INSERT INTO `zips` VALUES('00681', 'Mayaguez', 'PR', 'Mayaguez', 18.203568, -67.143361, '787');
INSERT INTO `zips` VALUES('00682', 'Mayaguez', 'PR', 'Mayaguez', 18.203568, -67.143361, '787');

-- --------------------------------------------------------

--
-- Table structure for table `_auction_types`
--

CREATE TABLE `_auction_types` (
  `code` varchar(1) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `_auction_types`
--

INSERT INTO `_auction_types` VALUES('D', 'Dutch (for auctions selling more than one item)');
INSERT INTO `_auction_types` VALUES('E', 'English (for auctions selling only one item)');
