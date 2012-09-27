/*
 Navicat Premium Data Transfer

 Source Server         : localhost.hyokos
 Source Server Type    : MySQL
 Source Server Version : 50146
 Source Host           : localhost
 Source Database       : iOS_JSONParser_DB

 Target Server Type    : MySQL
 Target Server Version : 50146
 File Encoding         : utf-8

 Date: 06/30/2012 04:41:39 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `Menu_Dessert`
-- ----------------------------
DROP TABLE IF EXISTS `Menu_Dessert`;
CREATE TABLE `Menu_Dessert` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(500) NOT NULL,
  `Price` varchar(250) DEFAULT NULL,
  `ImageURL` varchar(500) NOT NULL COMMENT '54x54',
  `Serves` varchar(100) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Menu_Dinner`
-- ----------------------------
DROP TABLE IF EXISTS `Menu_Dinner`;
CREATE TABLE `Menu_Dinner` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(500) NOT NULL,
  `Price` varchar(250) DEFAULT NULL,
  `ImageURL` varchar(500) NOT NULL COMMENT '54x54',
  `Serves` varchar(100) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Menu_Drinks`
-- ----------------------------
DROP TABLE IF EXISTS `Menu_Drinks`;
CREATE TABLE `Menu_Drinks` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(500) NOT NULL,
  `Price` varchar(250) DEFAULT NULL,
  `ImageURL` varchar(500) NOT NULL COMMENT '54x54',
  `Serves` varchar(100) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
