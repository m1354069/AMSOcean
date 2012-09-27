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

 Date: 07/03/2012 16:34:42 PM
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
--  Records of `Menu_Dessert`
-- ----------------------------
BEGIN;
INSERT INTO `Menu_Dessert` VALUES ('1', 'Cheese Cake', '$4.99', '/images/dessert/cc.jpg', '1', 'With the choices in our collection of cheesecake recipes, you can easily make this delicious dessert for any occasion and any taste.'), ('2', 'Strawberry Shortcake', '$7.99', '/images/dessert/sbsc.jpg', '2', 'Strawberry Shortcake is a great summertime dessert with fresh strawberries picked right from the garden! This Strawberry Shortcake Recipe is the perfect reason to till up a spot in that garden for fresh strawberries!'), ('3', 'Sugar Cookies', '$2.99', '/images/dessert/sc.jpg', '1', 'This is a tried and true old-fashioned sugar cookie recipe from a wonderful old neighbor who gave them out every Christmas. This is now our family recipe, Judy\'s Sugar Cookies (or Mom\'s sugar cookies to the kids).');
COMMIT;

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
--  Records of `Menu_Dinner`
-- ----------------------------
BEGIN;
INSERT INTO `Menu_Dinner` VALUES ('1', 'Chicken & Chili', '$8.99', '/images/dinner/chicchili.jpg', '2', 'This unique and delicious chicken chili is a much-requested meal around our house. I think you\'ll find it\'s a nice change of pace from the typical beef version.'), ('2', 'Chicken Franchase', '$9.99', '/images/dinner/chicfran.jpg', '2', 'Served in a lemon and butter sauce'), ('3', 'Salmon', '$14.99', '/images/dinner/salmon.jpg', '1', 'A simple soy sauce and brown sugar marinade, with hints of lemon and garlic, are the perfect salty-sweet complement to rich salmon fillets.');
COMMIT;

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

-- ----------------------------
--  Records of `Menu_Drinks`
-- ----------------------------
BEGIN;
INSERT INTO `Menu_Drinks` VALUES ('1', 'Lemonade', '$.99', '/images/drinks/lemonade.jpg', '1', 'Everybody knows how to make lemonade, right? Squeeze some lemons, add sugar and water. But how to make lemonade so that it tastes right everytime? Only we can do that!'), ('2', 'Long Island Iced Tea', '$7.99', '/images/drinks/liicedtea.jpg', '1', '1 part vodka\r\n1 part tequila\r\n1 part rum\r\n1 part gin\r\n1 part triple sec\r\n1 1/2 parts sweet and sour mix\r\n1 splash Coca-Cola'), ('3', 'Sangria', '$5.99', '/images/drinks/sangria.jpg', '1', '1 Bottle of red wine (Cabernet Sauvignon, Merlot, Rioja reds, Zinfandel, Shiraz)\r\n1 Lemon cut into wedges\r\n1 Orange cut into wedges\r\n2 Tbsp sugar\r\n1 Shot brandy\r\n2 Cups ginger ale or club soda');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
