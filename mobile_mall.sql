/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 80020
Source Host           : localhost:3306
Source Database       : mobile_mall

Target Server Type    : MYSQL
Target Server Version : 80020
File Encoding         : 65001

Date: 2021-09-07 06:45:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  `nickName` varchar(100) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '123456', '管理员', '4.jpg');

-- ----------------------------
-- Table structure for advert
-- ----------------------------
DROP TABLE IF EXISTS `advert`;
CREATE TABLE `advert` (
  `id` int NOT NULL,
  `img` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of advert
-- ----------------------------
INSERT INTO `advert` VALUES ('1', 'http://localhost:8181/assets/upload/banner6.jpg', '', '');
INSERT INTO `advert` VALUES ('2', 'http://localhost:8181/assets/upload/banner9.jpg', '', '');
INSERT INTO `advert` VALUES ('3', 'http://localhost:8181/assets/upload/banner7.jpg', '', '');
INSERT INTO `advert` VALUES ('4', 'http://localhost:8181/assets/upload/banner2.jpg', '', '');
INSERT INTO `advert` VALUES ('5', '', '欢迎来到天狼星手机商城,快看有没有你需要的', '');
INSERT INTO `advert` VALUES ('6', '', 'iphone降价啦', '#');
INSERT INTO `advert` VALUES ('7', '', '小米最新款', '#');
INSERT INTO `advert` VALUES ('8', '', '华为手机统一价', '#');
INSERT INTO `advert` VALUES ('9', '', '购买须知', '#');
INSERT INTO `advert` VALUES ('10', 'https://qqlykm.cn/api/netcard/api.php', '', 'http://localhost:8181/assets/upload/banner1.jpg');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pid` int DEFAULT NULL,
  `count` int DEFAULT NULL,
  `uid` int DEFAULT NULL,
  `totalPrice` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `uid` (`uid`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `product` (`product_id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `cate_id` int NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(100) NOT NULL,
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='类别表';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '苹果手机');
INSERT INTO `category` VALUES ('2', '小米手机');
INSERT INTO `category` VALUES ('3', '华为手机');
INSERT INTO `category` VALUES ('4', 'oppo手机');
INSERT INTO `category` VALUES ('5', 'vivo手机');
INSERT INTO `category` VALUES ('6', '魅族手机');
INSERT INTO `category` VALUES ('7', '三星手机');
INSERT INTO `category` VALUES ('8', '三星牌');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `pid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `pid` (`pid`),
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`user_id`),
  CONSTRAINT `collect_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES ('1', '1', '7');
INSERT INTO `collect` VALUES ('2', '1', '5');
INSERT INTO `collect` VALUES ('3', '18', '56');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `com_id` int NOT NULL AUTO_INCREMENT,
  `com_rate` int DEFAULT NULL,
  `com_content` varchar(300) DEFAULT NULL,
  `dateComment` datetime DEFAULT NULL,
  `uid` int DEFAULT NULL,
  `pid` int DEFAULT NULL,
  PRIMARY KEY (`com_id`),
  KEY `uid` (`uid`),
  KEY `pid` (`pid`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`user_id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '5', '不错不错呀', '2021-03-18 17:05:37', '1', '1');
INSERT INTO `comment` VALUES ('9', '5', '便宜实惠，下次再来', '2021-03-24 21:48:48', '2', '1');
INSERT INTO `comment` VALUES ('13', '5', '好用，商品质量真好', '2021-03-25 09:45:57', '4', '1');

-- ----------------------------
-- Table structure for d_address
-- ----------------------------
DROP TABLE IF EXISTS `d_address`;
CREATE TABLE `d_address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `receive_name` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `uid` int NOT NULL,
  `delete_state` int NOT NULL,
  `selected_state` int NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `uid` (`uid`),
  CONSTRAINT `d_address_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='地址表';

-- ----------------------------
-- Records of d_address
-- ----------------------------
INSERT INTO `d_address` VALUES ('1', '张三', '河南省商丘市民权县112街', '13598654751', '1', '0', '1');
INSERT INTO `d_address` VALUES ('2', '李四', '河南省郑州市新郑市沙窝里村', '13598654722', '1', '0', '0');
INSERT INTO `d_address` VALUES ('3', '德芙', '广东省中山市聚贤街125号', '15868974125', '1', '0', '0');
INSERT INTO `d_address` VALUES ('4', '王五', '河南省开封市清明上河园景区', '15698755473', '1', '0', '0');
INSERT INTO `d_address` VALUES ('5', '大声', '河南省郑州市新郑市沙窝里村', '18264789654', '2', '0', '0');
INSERT INTO `d_address` VALUES ('6', '张萌', '河南省郑州市新郑市沙窝里村', '13598654751', '2', '0', '0');
INSERT INTO `d_address` VALUES ('7', '张美丽', '河南省郑州市新郑市沙窝里村', '13598654751', '2', '0', '0');
INSERT INTO `d_address` VALUES ('8', '王小二', '河南省郑州市新郑市沙窝里村', '13598654751', '3', '0', '0');
INSERT INTO `d_address` VALUES ('9', '珑铸', '河南省郑州市新郑市沙窝里村', '13598654751', '3', '0', '0');
INSERT INTO `d_address` VALUES ('10', '大师傅', '河南省郑州市新郑市沙窝里村', '13598654751', '3', '0', '0');
INSERT INTO `d_address` VALUES ('11', '拉反弹', '河南省郑州市新郑市沙窝里村', '13598654751', '4', '0', '1');
INSERT INTO `d_address` VALUES ('12', '黑风', '河南省郑州市新郑市沙窝里村', '13598654751', '4', '0', '0');
INSERT INTO `d_address` VALUES ('13', '沸点', '河南省郑州市新郑市沙窝里村', '13598654751', '4', '0', '0');
INSERT INTO `d_address` VALUES ('14', '工具', '河南省郑州市新郑市沙窝里村', '13598654751', '4', '0', '0');
INSERT INTO `d_address` VALUES ('15', '法人', '河南省郑州市新郑市沙窝里村', '13598654751', '4', '0', '0');
INSERT INTO `d_address` VALUES ('17', '闸机', '上海市陆家嘴东方明珠塔下', '15698632786', '1', '0', '0');
INSERT INTO `d_address` VALUES ('18', '我啦', '河南省郑州市新郑沙窝里村', '15003994068', '18', '0', '1');

-- ----------------------------
-- Table structure for d_order
-- ----------------------------
DROP TABLE IF EXISTS `d_order`;
CREATE TABLE `d_order` (
  `id` varchar(20) NOT NULL,
  `good_price` double NOT NULL,
  `order_time` datetime NOT NULL,
  `order_state` int DEFAULT NULL,
  `addr_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addr_id` (`addr_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `d_order_ibfk_1` FOREIGN KEY (`addr_id`) REFERENCES `d_address` (`address_id`),
  CONSTRAINT `d_order_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of d_order
-- ----------------------------
INSERT INTO `d_order` VALUES ('20210411161206', '2300', '2021-04-11 16:12:06', '0', '1', '1');
INSERT INTO `d_order` VALUES ('20210411162734', '2900', '2021-04-11 16:27:34', '0', '1', '1');

-- ----------------------------
-- Table structure for mail
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
  `id` int NOT NULL,
  `email` varchar(30) NOT NULL,
  `host` varchar(30) NOT NULL,
  `port` int NOT NULL,
  `nickName` varchar(20) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SMTP';

-- ----------------------------
-- Records of mail
-- ----------------------------
INSERT INTO `mail` VALUES ('1', '1291758809@qq.com', 'smtp.qq.com', '587', '1291758809@qq.com', 'yzimgprrregijibg');

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `order_id` varchar(20) DEFAULT NULL,
  `count` int DEFAULT NULL,
  `unit_price` double(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `d_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='订单详情表';

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES ('1', '2', '20210411161206', '1', '2300.00');
INSERT INTO `order_item` VALUES ('2', '3', '20210411162734', '1', '2900.00');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `cid` int NOT NULL,
  `product_price` double DEFAULT NULL,
  `product_name` varchar(200) NOT NULL,
  `groundingDate` datetime DEFAULT NULL,
  `inventory` int NOT NULL,
  `salenum` int DEFAULT NULL,
  `messages` varchar(400) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `ram` int DEFAULT NULL,
  `product_image` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `state` int DEFAULT '1',
  `rate` int DEFAULT '5',
  PRIMARY KEY (`product_id`),
  KEY `cid` (`cid`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='商品表';

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '1', '1300', 'iPhone6', '2021-03-30 20:32:21', '1254', '25', '体验不一样的科技感', '白色', '64', 'http://localhost:8181/assets/upload/iPhone6.jpg', '1', '5');
INSERT INTO `product` VALUES ('2', '1', '2300', 'iPhone6', '2021-03-30 20:32:45', '1254', '25', 'iphone6 128G', '白色', '128', 'http://localhost:8181/assets/upload/iPhone6.jpg', '1', '5');
INSERT INTO `product` VALUES ('3', '1', '2900', 'iPhone7', '2021-03-30 20:30:18', '1254', '25', '苹果7 64G', '白色', '64', 'http://localhost:8181/assets/upload/iPhone7.jpg', '1', '5');
INSERT INTO `product` VALUES ('4', '1', '3999', 'iPhone7 Plus', '2021-03-30 20:29:44', '1254', '25', 'iPhone7 Plus', '红色', '64', 'http://localhost:8181/assets/upload/iPhone7 plus.jpg', '1', '5');
INSERT INTO `product` VALUES ('5', '1', '4200', 'iPhone8', '2021-03-30 20:29:30', '1254', '25', '体验不一样的科技感', '白色', '64', 'http://localhost:8181/assets/upload/iPhone8.jpg', '1', '5');
INSERT INTO `product` VALUES ('7', '2', '1099', '小米8 6+64', '2021-03-29 09:13:55', '-2', '27', '体验不一样的科技感', '白色', '64', 'http://localhost:8181/assets/upload/iPhone6.jpg', '1', '5');
INSERT INTO `product` VALUES ('8', '4', '5999', 'OPPO Find X3 Pro', '2021-03-28 15:27:30', '12345', '0', '镜黑 12G+256G', '镜黑', '256', 'http://localhost:8181/assets/upload/8535e147-042e-44e0-8049-ccaeecaf3c72202103081003196045865fa669e.jpg', '1', '5');
INSERT INTO `product` VALUES ('9', '4', '2699', 'OPPO Reno5', '2021-03-28 15:35:26', '1234', '0', '星河入梦 8G+128G', '星河入梦', '128', 'http://localhost:8181/assets/upload/xhrm.jpg', '1', '5');
INSERT INTO `product` VALUES ('10', '4', '3799', 'OnePlus 9', '2021-03-28 15:42:22', '1233', '0', '5G手机 8G+128G', '紫翼', '128', 'http://localhost:8181/assets/upload/0f47b4e1-1191-4e64-86ae-f5f06f0f2d8b20210324120331605a190f7d7ee.jpg', '1', '5');
INSERT INTO `product` VALUES ('11', '4', '1499', 'OPPO K7x', '2021-03-28 15:46:46', '1245', '0', '黑镜 6G+128G', '黑镜', '128', 'http://localhost:8181/assets/upload/054962a9-0525-48e7-aa86-bfc5802e5134202011040911045fa208906d9b5.jpg', '1', '5');
INSERT INTO `product` VALUES ('12', '3', '6499', 'HUAWEI Mate 40 Pro', '2021-03-28 15:52:50', '1245', '0', '5G全网通 8GB+128GB', '釉白色', '128', 'http://localhost:8181/assets/upload/e37e4191-1e30-4f23-9275-368b6ed819ca下载.jpg', '1', '5');
INSERT INTO `product` VALUES ('13', '5', '4998', 'NEX 3S 5G版 ', '2021-03-28 16:28:02', '1245', '0', '8GB+256GB 深空流光', '深空流光', '256', 'http://localhost:8181/assets/upload/4460136f-8f35-4fc9-91ce-5ce9333c5a24nex3s.jpg', '1', '5');
INSERT INTO `product` VALUES ('14', '5', '4498', 'vivo X60 Pro', '2021-03-28 16:32:30', '1245', '0', '5G版 12GB+256GB', '原力', '256', 'http://localhost:8181/assets/upload/23a7df30-645e-4d00-a493-ae0efe63129fvivo x60.jpg', '1', '5');
INSERT INTO `product` VALUES ('15', '5', '1499', 'vivo Y30g', '2021-03-28 16:48:13', '1245', '0', '8GB+128GB 水漾蓝', '水漾蓝', '128', 'http://localhost:8181/assets/upload/0d971c80-0f3a-479d-aa17-f9e48f84f33cy30.jpg', '1', '5');
INSERT INTO `product` VALUES ('16', '7', '5799', '三星 Galaxy S21 5G', '2021-03-28 17:02:12', '1246', '12', 'SM-G9910 8G+256G', '墨影灰', '256', 'http://localhost:8181/assets/upload/Galaxy.jpg', '1', '5');
INSERT INTO `product` VALUES ('17', '6', '4399', '魅族 18', '2021-03-28 17:05:00', '1234', '6', '全网通8G+128G', '等风', '128', 'http://localhost:8181/assets/upload/魅族18.jpg', '1', '5');
INSERT INTO `product` VALUES ('18', '6', '5499', '魅族 18 Pro 苍穹浩瀚', '2021-03-28 22:24:56', '1245', '2', '魅族 18 Pro 8G+256G', '苍穹浩瀚', '256', 'http://localhost:8181/assets/upload/魅族8苍穹浩瀚.jpg', '1', '5');
INSERT INTO `product` VALUES ('19', '6', '4299', '魅族 17 Pro 定白', '2021-03-28 22:30:55', '2356', '2', '魅族 17 Pro 8G+128G', '定白', '128', 'http://localhost:8181/assets/upload/魅族17.jpg', '1', '5');
INSERT INTO `product` VALUES ('20', '6', '798', '魅族魅蓝E2', '2021-03-28 22:40:49', '4578', '12', '（4GB RAM/全网通）', '香槟金', '64', 'http://localhost:8181/assets/upload/魅蓝E2.jpg', '1', '5');
INSERT INTO `product` VALUES ('21', '6', '1299', '魅蓝 note6', '2021-03-28 22:44:40', '1234', '12', '魅蓝 4GB+64GB', '蓝色', '64', 'http://localhost:8181/assets/upload/魅蓝note6.jpg', '1', '5');
INSERT INTO `product` VALUES ('22', '6', '2299', '魅族PRO 6s', '2021-03-28 22:48:34', '245', '14', '全网通公开版64G', '粉色', '64', 'http://localhost:8181/assets/upload/魅族Pro6s.jpg', '1', '5');
INSERT INTO `product` VALUES ('23', '6', '1299', '魅族 PRO 7', '2021-03-28 22:51:02', '689', '25', '全网通公开版4G+64G', '提香红', '64', 'http://localhost:8181/assets/upload/魅族Pro7.jpg', '1', '5');
INSERT INTO `product` VALUES ('24', '3', '3999', 'HUAWEI nova 8 Pro', '2021-03-28 22:59:16', '1235', '10', '华为8GB+128GB', '绮境森林', '128', 'http://localhost:8181/assets/upload/华为 HUAWEI nova8.jpg', '1', '5');
INSERT INTO `product` VALUES ('25', '3', '1088', '华为荣耀9青春版', '2021-03-28 23:05:49', '1245', '225', ' 尊享版 4GB+64GB', '蓝色', '64', 'http://localhost:8181/assets/upload/华为荣耀9青春版.jpg', '1', '5');
INSERT INTO `product` VALUES ('26', '2', '2999', '黑鲨4', '2021-03-29 09:01:24', '1245', '0', '12G+128G', '墨海黑', '128', 'http://localhost:8181/assets/upload/黑鲨4.jpg', '1', '5');
INSERT INTO `product` VALUES ('27', '2', '3299', '小米10S', '2021-03-29 09:02:57', '1246', '2', '骁龙870 8G+128G', '白色', '128', 'http://localhost:8181/assets/upload/小米10s.jpg', '1', '5');
INSERT INTO `product` VALUES ('28', '2', '2799', 'Redmi K40 Pro', '2021-03-29 09:05:07', '457', '2', '骁龙888 6G+128G', '墨羽', '128', 'http://localhost:8181/assets/upload/红米k40  pro.jpg', '1', '5');
INSERT INTO `product` VALUES ('29', '2', '4699', '小米11', '2021-03-29 09:06:36', '1234', '23', '骁龙888 12G+256G', '蓝色', '256', 'http://localhost:8181/assets/upload/小米11.jpg', '1', '5');
INSERT INTO `product` VALUES ('30', '2', '2199', 'Redmi K40', '2021-03-29 09:09:59', '2364', '24', '骁龙870 8G+128G', '幻境', '128', 'http://localhost:8181/assets/upload/红米k40.jpg', '1', '5');
INSERT INTO `product` VALUES ('31', '2', '469', '红米note4X', '2021-03-29 09:17:54', '236', '2', '64G全网通4G指纹解锁', '蓝色', '64', 'http://localhost:8181/assets/upload/红米note4X.jpg', '1', '5');
INSERT INTO `product` VALUES ('32', '7', '1799', '三星 Galaxy A01', '2021-03-29 09:26:54', '124', '2', '智能手机 5.7英寸 32G', ' 黑色', '32', 'http://localhost:8181/assets/upload/Galaxy A01.jpg', '1', '5');
INSERT INTO `product` VALUES ('33', '7', '4999', '三星Galaxy S21 5G', '2021-03-29 09:32:05', '1245', '24', ' 8GB+128GB', '梵梦紫', '128', 'http://localhost:8181/assets/upload/Galaxy S21.jpg', '1', '5');
INSERT INTO `product` VALUES ('34', '2', '2999', '小米10 青春版 5G', '2021-03-29 10:41:21', '1236', '21', '骁龙765 8G+128G', '黑巧风暴', '128', 'http://localhost:8181/assets/upload/小米10 青春版.jpg', '1', '5');
INSERT INTO `product` VALUES ('35', '2', '1799', 'Note 9 Pro 5G', '2021-03-29 10:45:30', '1234', '12', '骁龙750 8G+128G', '碧海星辰', '128', 'http://localhost:8181/assets/upload/Note 9 Pro.jpg', '1', '5');
INSERT INTO `product` VALUES ('36', '5', '3998', 'vivo X50 Pro', '2021-03-30 18:51:15', '2356', '12', '8GB+128GB 液氧', '液氧', '128', 'http://localhost:8181/assets/upload/vivo X50.jpg', '1', '5');
INSERT INTO `product` VALUES ('37', '5', '2689', 'vivo S7t 5G版', '2021-03-30 19:00:32', '1234', '12', '8GB+128GB 莫奈漫彩', '莫奈漫彩', '128', 'http://localhost:8181/assets/upload/vivo S7t.jpg', '1', '5');
INSERT INTO `product` VALUES ('38', '5', '2198', 'vivo S7e 活力版', '2021-03-30 19:08:09', '2354', '14', '8GB+128GB 银月', '银月', '128', 'http://localhost:8181/assets/upload/vivo S7e.jpg', '1', '5');
INSERT INTO `product` VALUES ('39', '5', '2699', 'vivo S9e 5G版', '2021-03-30 19:11:44', '1235', '25', '8GB+256GB 星夜极光', '星夜极光', '256', 'http://localhost:8181/assets/upload/vivo S9e.jpg', '1', '5');
INSERT INTO `product` VALUES ('40', '5', '3299', 'vivo S9 5G版', '2021-03-30 19:14:53', '1245', '26', '12GB+256GB 印象拾光', '印象拾光', '256', 'http://localhost:8181/assets/upload/vivo S9.jpg', '1', '5');
INSERT INTO `product` VALUES ('41', '5', '2099', 'vivo Y73s 5G版', '2021-03-30 19:16:43', '1247', '25', '8GB+256GB 黑镜', '黑镜', '256', 'http://localhost:8181/assets/upload/vivo Y73s.jpg', '1', '5');
INSERT INTO `product` VALUES ('42', '5', '1798', 'vivo Y52s 5G版', '2021-03-30 19:48:23', '1264', '20', '莫奈彩 限时促销', '莫奈彩', '128', 'http://localhost:8181/assets/upload/vivo Y52s .jpg', '1', '5');
INSERT INTO `product` VALUES ('43', '5', '1598', 'vivo Y31s 5G版', '2021-03-30 19:24:02', '1234', '12', '6GB+128GB 钛空灰', '钛空灰', '128', 'http://localhost:8181/assets/upload/vivo Y31s.jpg', '1', '5');
INSERT INTO `product` VALUES ('44', '5', '1499', 'vivo Y30g', '2021-03-30 19:26:57', '1245', '23', '8GB+128GB 水漾蓝', '水漾蓝', '128', 'http://localhost:8181/assets/upload/vivo Y30g.jpg', '1', '5');
INSERT INTO `product` VALUES ('45', '3', '6488', 'HUAWEI P40 Pro', '2021-03-30 19:35:10', '1245', '18', '华为全网通 8GB+256GB', '深海蓝', '256', 'http://localhost:8181/assets/upload/HUAWEI P40 Pro.jpg', '1', '5');
INSERT INTO `product` VALUES ('46', '3', '3699', 'HUAWEI nova 7 Pro', '2021-03-30 19:41:39', '2345', '2', '华为麒麟985 SoC ', '仲夏紫', '128', 'http://localhost:8181/assets/upload/HUAWEI nova 7 Pro.jpg', '1', '5');
INSERT INTO `product` VALUES ('47', '3', '2699', 'HUAWEI nova 8 SE', '2021-03-30 19:44:09', '1245', '20', '全网通 8G+128G 高配版', '幻夜黑', '128', 'http://localhost:8181/assets/upload/HUAWEI nova 8 SE.jpg', '1', '5');
INSERT INTO `product` VALUES ('48', '4', '4499', 'OPPO Find X3', '2021-03-30 19:51:52', '1234', '12', '雾蓝 8G+128G', '雾蓝', '128', 'http://localhost:8181/assets/upload/OPPO Find X3.jpg', '1', '5');
INSERT INTO `product` VALUES ('49', '4', '4499', 'OPPO Reno5 Pro+', '2021-03-30 19:56:26', '1245', '32', '艺术家限定版 5G版', '变色幻境', '256', 'http://localhost:8181/assets/upload/OPPO Reno5 Pro+.jpg', '1', '5');
INSERT INTO `product` VALUES ('50', '4', '2699', 'OPPO Reno5 K ', '2021-03-30 19:58:26', '2345', '23', ' 恋恋青风 8G+128G', ' 恋恋青风', '128', 'http://localhost:8181/assets/upload/OPPO Reno5 K.jpg', '1', '5');
INSERT INTO `product` VALUES ('51', '7', '4699', '三星Galaxy S20 FE ', '2021-03-30 20:03:59', '1234', '25', '5G手机 骁龙865', '奇幻紫', '256', 'http://localhost:8181/assets/upload/三星Galaxy S20 FE .jpg', '1', '5');
INSERT INTO `product` VALUES ('52', '7', '19999', '三星W21 5G', '2021-03-30 20:10:11', '1234', '0', '5G熠辉金12GB+512GB\n', '熠辉金', '512', 'http://localhost:8181/assets/upload/三星W21 5G.jpg', '1', '5');
INSERT INTO `product` VALUES ('53', '7', '14999', 'Galaxy Z Fold2 5G', '2021-03-30 20:13:09', '1243', '0', '三星 12GB+512GB', '迷雾金', '512', 'http://localhost:8181/assets/upload/Galaxy Z Fold2 5G.jpg', '1', '5');
INSERT INTO `product` VALUES ('54', '7', '8999', 'Galaxy S20 Ultra 5G', '2021-03-30 20:18:50', '2345', '1', '三星幻游黑 12G+256G\n', '幻游黑', '256', 'http://localhost:8181/assets/upload/Galaxy S20 Ultra 5G.jpg', '1', '5');
INSERT INTO `product` VALUES ('55', '1', '5129', ' iPhone 12 mini 5G', '2021-03-30 20:36:39', '1246', '29', '苹果全网通64GB', '蓝色', '64', 'http://localhost:8181/assets/upload/iPhone 12 mini.jpg', '1', '5');
INSERT INTO `product` VALUES ('56', '1', '5998', ' iPhone11', '2021-03-30 20:36:27', '1234', '28', '苹果11 256G', '黑色', '256', 'http://localhost:8181/assets/upload/iPhone11.jpg', '1', '5');
INSERT INTO `product` VALUES ('57', '1', '5868', 'iPhone 12 白色', '2021-03-30 20:46:29', '1245', '34', '苹果12 5G手机', '白色', '64', 'http://localhost:8181/assets/upload/iPhone 12.jpg', '1', '5');
INSERT INTO `product` VALUES ('58', '1', '6409', ' iPhone 12  红色', '2021-03-30 20:45:58', '1245', '30', '苹果 iPhone 12 5G手机', '红色', '128', 'http://localhost:8181/assets/upload/iPhone 12red.jpg', '1', '5');

-- ----------------------------
-- Table structure for sys
-- ----------------------------
DROP TABLE IF EXISTS `sys`;
CREATE TABLE `sys` (
  `id` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `key_word` varchar(100) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `ico` varchar(200) DEFAULT NULL,
  `logo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网站基础配置';

-- ----------------------------
-- Records of sys
-- ----------------------------
INSERT INTO `sys` VALUES ('1', '天狼星手机商城', '手机商城,买手机,手机销售,便宜买手机', '本站出售的手机都是最新款，比市面上更便宜，欢迎大家购买', 'favicon.ico', 'logo.png');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `user_pwd` varchar(100) NOT NULL,
  `createTime` datetime NOT NULL,
  `age` int DEFAULT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `state` int DEFAULT NULL,
  `nickName` varchar(100) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '123456@qq.com', '123456', '2021-03-02 16:40:45', '25', '男', '13568974125', '1', '张撒', 'b687cac9-fc34-4012-9526-e3542ba988ed5.jpg');
INSERT INTO `user` VALUES ('2', '222222@qq.com', '123456', '2021-03-02 16:40:45', '24', '男', '15657889562', '1', '李四', '2.jpg');
INSERT INTO `user` VALUES ('3', '333333@qq.com', '123456', '2021-03-02 16:40:45', '25', '男', '13596547824', '1', '王五', '2.jpg');
INSERT INTO `user` VALUES ('4', '44444@qq.com', '123456', '2021-03-02 16:40:45', '25', '女', '18256987458', '1', '王五', '3.jpg');
INSERT INTO `user` VALUES ('5', 'r47609371@163.com', '123456', '2021-03-02 16:40:45', '25', '女', '13586547854', '1', '王五', '3.jpg');
INSERT INTO `user` VALUES ('17', '1456789@qq.com', '123456', '2021-03-08 19:14:31', '23', '男', '13589784667', '0', '阿道夫', 'b55ca64c-4289-41ea-ac43-9bccd70d4a9a7.jpg');
INSERT INTO `user` VALUES ('18', '3614930772@qq.com', '123456', '2021-03-20 22:54:27', '0', null, null, '0', '默认昵称', null);
