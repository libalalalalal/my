/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80037
 Source Host           : localhost:3306
 Source Schema         : drug

 Target Server Type    : MySQL
 Target Server Version : 80037
 File Encoding         : 65001

 Date: 26/06/2024 08:43:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for druginfo
-- ----------------------------
DROP TABLE IF EXISTS `druginfo`;
CREATE TABLE `druginfo`  (
  `drugname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `changshang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beizhu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `guige` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tiaoxingma` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of druginfo
-- ----------------------------
INSERT INTO `druginfo` VALUES ('药品A', '厂家A', '备注1', '库位1', '盒', '规格1', '1234567890');
INSERT INTO `druginfo` VALUES ('药品B', '厂家B', '备注2', '库位2', '瓶', '规格2', '0987654321');
INSERT INTO `druginfo` VALUES ('药品C', '厂家C', '备注3', '库位3', '包', '规格3', '1122334455');
INSERT INTO `druginfo` VALUES ('药品D', '厂家D', '备注4', '库位4', '袋', '规格4', '6677889900');
INSERT INTO `druginfo` VALUES ('药品E', '厂家E', '备注5', '库位5', '支', '规格5', '5566778899');
INSERT INTO `druginfo` VALUES ('药品F', '厂家F', '备注6', '库位6', '盒', '规格6', '4433221100');
INSERT INTO `druginfo` VALUES ('药品G', '厂家G', '备注7', '库位7', '瓶', '规格7', '2233445566');
INSERT INTO `druginfo` VALUES ('药品H', '厂家H', '备注8', '库位8', '包', '规格8', '9988776655');
INSERT INTO `druginfo` VALUES ('药品I', '厂家I', '备注9', '库位9', '袋', '规格9', '7799885566');
INSERT INTO `druginfo` VALUES ('药品J', '厂家J', '备注10', '库位10', '盒', '规格10', '6655443322');
INSERT INTO `druginfo` VALUES ('药品A', '厂家A', '备注1', '库位1', '盒', '规格1', '1234567890');
INSERT INTO `druginfo` VALUES ('药品B', '厂家B', '备注2', '库位2', '瓶', '规格2', '0987654321');
INSERT INTO `druginfo` VALUES ('药品C', '厂家C', '备注3', '库位3', '包', '规格3', '1122334455');
INSERT INTO `druginfo` VALUES ('药品D', '厂家D', '备注4', '库位4', '袋', '规格4', '6677889900');
INSERT INTO `druginfo` VALUES ('药品E', '厂家E', '备注5', '库位5', '支', '规格5', '5566778899');
INSERT INTO `druginfo` VALUES ('药品F', '厂家F', '备注6', '库位6', '盒', '规格6', '4433221100');
INSERT INTO `druginfo` VALUES ('药品G', '厂家G', '备注7', '库位7', '瓶', '规格7', '2233445566');
INSERT INTO `druginfo` VALUES ('药品H', '厂家H', '备注8', '库位8', '包', '规格8', '9988776655');
INSERT INTO `druginfo` VALUES ('药品I', '厂家I', '备注9', '库位9', '袋', '规格9', '7799885566');
INSERT INTO `druginfo` VALUES ('药品J', '厂家J', '备注10', '库位10', '盒', '规格10', '6655443322');
INSERT INTO `druginfo` VALUES ('1', '1', '1', '1', '1', '1', '12324353453');

-- ----------------------------
-- Table structure for ghs
-- ----------------------------
DROP TABLE IF EXISTS `ghs`;
CREATE TABLE `ghs`  (
  `gonghuoshang` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ghs
-- ----------------------------
INSERT INTO `ghs` VALUES ('供货商A');
INSERT INTO `ghs` VALUES ('供货商B');
INSERT INTO `ghs` VALUES ('供货商C');
INSERT INTO `ghs` VALUES ('供货商D');
INSERT INTO `ghs` VALUES ('供货商E');
INSERT INTO `ghs` VALUES ('供货商F');
INSERT INTO `ghs` VALUES ('供货商G');
INSERT INTO `ghs` VALUES ('供货商H');
INSERT INTO `ghs` VALUES ('供货商I');
INSERT INTO `ghs` VALUES ('供货商J');
INSERT INTO `ghs` VALUES ('供货商A542542');

-- ----------------------------
-- Table structure for jinhuo
-- ----------------------------
DROP TABLE IF EXISTS `jinhuo`;
CREATE TABLE `jinhuo`  (
  `drugname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `changshang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beginprice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sum` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `begindate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pihao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beizhu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `guige` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tiaoxingma` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jinhuo_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gonghuoshang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jinhuo
-- ----------------------------
INSERT INTO `jinhuo` VALUES ('药品A', '厂家A', '10', '12', '1', '1200', '2024-06-01', '2024-06-15', '20240615', '进货备注1', '进货库位1', '盒', '规格1', '1234567890', '2024-06-15 08:00:00', '供货商A');
INSERT INTO `jinhuo` VALUES ('药品B', '厂家B', '15', '18', '150', '2700', '2024-06-02', '2024-06-16', '20240616', '进货备注2', '进货库位2', '瓶', '规格2', '0987654321', '2024-06-16 10:30:00', '供货商B');
INSERT INTO `jinhuo` VALUES ('药品C', '厂家C', '20', '25', '200', '5000', '2024-06-03', '2024-06-17', '20240617', '进货备注3', '进货库位3', '包', '规格3', '1122334455', '2024-06-17 14:45:00', '供货商C');
INSERT INTO `jinhuo` VALUES ('药品D', '厂家D', '8', '10', '80', '800', '2024-06-04', '2024-06-18', '20240618', '进货备注4', '进货库位4', '袋', '规格4', '6677889900', '2024-06-18 16:00:00', '供货商D');
INSERT INTO `jinhuo` VALUES ('药品E', '厂家E', '25', '30', '250', '7500', '2024-06-05', '2024-06-19', '20240619', '进货备注5', '进货库位5', '支', '规格5', '5566778899', '2024-06-19 18:15:00', '供货商E');
INSERT INTO `jinhuo` VALUES ('药品F', '厂家F', '18', '22', '180', '3960', '2024-06-06', '2024-06-20', '20240620', '进货备注6', '进货库位6', '盒', '规格6', '4433221100', '2024-06-20 20:30:00', '供货商F');
INSERT INTO `jinhuo` VALUES ('药品G', '厂家G', '12', '15', '120', '1800', '2024-06-07', '2024-06-21', '20240621', '进货备注7', '进货库位7', '瓶', '规格7', '2233445566', '2024-06-21 22:45:00', '供货商G');
INSERT INTO `jinhuo` VALUES ('药品H', '厂家H', '30', '35', '300', '10500', '2024-06-08', '2024-06-22', '20240622', '进货备注8', '进货库位8', '包', '规格8', '9988776655', '2024-06-22 08:00:00', '供货商H');
INSERT INTO `jinhuo` VALUES ('药品I', '厂家I', '22', '26', '220', '5720', '2024-06-09', '2024-06-23', '20240623', '进货备注9', '进货库位9', '袋', '规格9', '7799885566', '2024-06-23 10:15:00', '供货商I');

-- ----------------------------
-- Table structure for jinhuorecords
-- ----------------------------
DROP TABLE IF EXISTS `jinhuorecords`;
CREATE TABLE `jinhuorecords`  (
  `drugname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `changshang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beginprice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sum` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `begindate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pihao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beizhu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `guige` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tiaoxingma` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jinhuo_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gonghuoshang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jinhuorecords
-- ----------------------------
INSERT INTO `jinhuorecords` VALUES ('药品A', '厂家A', '10', '12', '100', '1200', '2024-06-01', '2024-06-15', '20240615', '进货备注1', '进货库位1', '盒', '规格1', '1234567890', '2024-06-15 08:00:00', '供货商A');
INSERT INTO `jinhuorecords` VALUES ('药品B', '厂家B', '15', '18', '150', '2700', '2024-06-02', '2024-06-16', '20240616', '进货备注2', '进货库位2', '瓶', '规格2', '0987654321', '2024-06-16 10:30:00', '供货商B');
INSERT INTO `jinhuorecords` VALUES ('药品C', '厂家C', '20', '25', '200', '5000', '2024-06-03', '2024-06-17', '20240617', '进货备注3', '进货库位3', '包', '规格3', '1122334455', '2024-06-17 14:45:00', '供货商C');
INSERT INTO `jinhuorecords` VALUES ('药品D', '厂家D', '8', '10', '80', '800', '2024-06-04', '2024-06-18', '20240618', '进货备注4', '进货库位4', '袋', '规格4', '6677889900', '2024-06-18 16:00:00', '供货商D');
INSERT INTO `jinhuorecords` VALUES ('药品E', '厂家E', '25', '30', '250', '7500', '2024-06-05', '2024-06-19', '20240619', '进货备注5', '进货库位5', '支', '规格5', '5566778899', '2024-06-19 18:15:00', '供货商E');
INSERT INTO `jinhuorecords` VALUES ('药品F', '厂家F', '18', '22', '180', '3960', '2024-06-06', '2024-06-20', '20240620', '进货备注6', '进货库位6', '盒', '规格6', '4433221100', '2024-06-20 20:30:00', '供货商F');
INSERT INTO `jinhuorecords` VALUES ('药品G', '厂家G', '12', '15', '120', '1800', '2024-06-07', '2024-06-21', '20240621', '进货备注7', '进货库位7', '瓶', '规格7', '2233445566', '2024-06-21 22:45:00', '供货商G');
INSERT INTO `jinhuorecords` VALUES ('药品H', '厂家H', '30', '35', '300', '10500', '2024-06-08', '2024-06-22', '20240622', '进货备注8', '进货库位8', '包', '规格8', '9988776655', '2024-06-22 08:00:00', '供货商H');
INSERT INTO `jinhuorecords` VALUES ('药品I', '厂家I', '22', '26', '220', '5720', '2024-06-09', '2024-06-23', '20240623', '进货备注9', '进货库位9', '袋', '规格9', '7799885566', '2024-06-23 10:15:00', '供货商I');
INSERT INTO `jinhuorecords` VALUES ('药品J', '厂家J', '16', '20', '160', '3200', '2024-06-10', '2024-06-24', '20240624', '进货备注10', '进货库位10', '盒', '规格10', '6655443322', '2024-06-24 12:30:00', '供货商J');

-- ----------------------------
-- Table structure for limitsell
-- ----------------------------
DROP TABLE IF EXISTS `limitsell`;
CREATE TABLE `limitsell`  (
  `drugname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `changshang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` int NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of limitsell
-- ----------------------------
INSERT INTO `limitsell` VALUES ('药品A', '厂家A', 100);
INSERT INTO `limitsell` VALUES ('药品B', '厂家B', 150);
INSERT INTO `limitsell` VALUES ('药品C', '厂家C', 200);
INSERT INTO `limitsell` VALUES ('药品D', '厂家D', 80);
INSERT INTO `limitsell` VALUES ('药品E', '厂家E', 250);
INSERT INTO `limitsell` VALUES ('药品F', '厂家F', 180);
INSERT INTO `limitsell` VALUES ('药品G', '厂家G', 120);

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES ('admin', 'admin', 1);
INSERT INTO `manager` VALUES ('user', 'user', 0);
INSERT INTO `manager` VALUES ('user2', 'user456', NULL);
INSERT INTO `manager` VALUES ('user3', 'user789', 0);
INSERT INTO `manager` VALUES ('user4', 'userabc', 0);
INSERT INTO `manager` VALUES ('444', '444', 0);
INSERT INTO `manager` VALUES ('1111111', '1111111', 0);

-- ----------------------------
-- Table structure for rxdrug
-- ----------------------------
DROP TABLE IF EXISTS `rxdrug`;
CREATE TABLE `rxdrug`  (
  `time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `drugname` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `changshang` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pihao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `count` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rxdrug
-- ----------------------------
INSERT INTO `rxdrug` VALUES ('2024-06-01 08:00:00', '药品A', '厂家A', '2024-06-15', '20240615', '10');
INSERT INTO `rxdrug` VALUES ('2024-06-02 10:00:00', '药品B', '厂家B', '2024-06-16', '20240616', '15');
INSERT INTO `rxdrug` VALUES ('2024-06-03 12:00:00', '药品C', '厂家C', '2024-06-17', '20240617', '20');
INSERT INTO `rxdrug` VALUES ('2024-06-04 14:00:00', '药品D', '厂家D', '2024-06-18', '20240618', '8');
INSERT INTO `rxdrug` VALUES ('2024-06-05 16:00:00', '药品E', '厂家E', '2024-06-19', '20240619', '25');
INSERT INTO `rxdrug` VALUES ('2024-06-06 18:00:00', '药品F', '厂家F', '2024-06-20', '20240620', '18');
INSERT INTO `rxdrug` VALUES ('2024-06-07 20:00:00', '药品G', '厂家G', '2024-06-21', '20240621', '12');
INSERT INTO `rxdrug` VALUES ('2024-06-08 22:00:00', '药品H', '厂家H', '2024-06-22', '20240622', '30');
INSERT INTO `rxdrug` VALUES ('2024-06-09 08:00:00', '药品I', '厂家I', '2024-06-23', '20240623', '22');
INSERT INTO `rxdrug` VALUES ('2024-06-10 10:00:00', '药品J', '厂家J', '2024-06-24', '20240624', '16');

-- ----------------------------
-- Table structure for rxperson
-- ----------------------------
DROP TABLE IF EXISTS `rxperson`;
CREATE TABLE `rxperson`  (
  `time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gendar` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hospital` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `htime` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `yz` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ysname` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `zdys` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rxperson
-- ----------------------------
INSERT INTO `rxperson` VALUES ('2024-06-01 08:00:00', '张三', '男', '30', '13812345678', '北京市', '人民医院', '2024-06-15', '处方1', '医生A', '主治医生A');
INSERT INTO `rxperson` VALUES ('2024-06-02 10:00:00', '李四', '女', '25', '13987654321', '上海市', '华山医院', '2024-06-16', '处方2', '医生B', '主治医生B');
INSERT INTO `rxperson` VALUES ('2024-06-03 12:00:00', '王五', '男', '40', '13611112222', '广州市', '中山医院', '2024-06-17', '处方3', '医生C', '主治医生C');
INSERT INTO `rxperson` VALUES ('2024-06-04 14:00:00', '赵六', '女', '35', '13544443333', '深圳市', '深圳医院', '2024-06-18', '处方4', '医生D', '主治医生D');
INSERT INTO `rxperson` VALUES ('2024-06-05 16:00:00', '钱七', '男', '45', '13755556666', '成都市', '华西医院', '2024-06-19', '处方5', '医生E', '主治医生E');
INSERT INTO `rxperson` VALUES ('2024-06-06 18:00:00', '孙八', '女', '28', '13266667777', '重庆市', '第一医院', '2024-06-20', '处方6', '医生F', '主治医生F');
INSERT INTO `rxperson` VALUES ('2024-06-07 20:00:00', '周九', '男', '38', '13188889999', '天津市', '天津医院', '2024-06-21', '处方7', '医生G', '主治医生G');
INSERT INTO `rxperson` VALUES ('2024-06-08 22:00:00', '吴十', '女', '32', '13000001111', '南京市', '南京医院', '2024-06-22', '处方8', '医生H', '主治医生H');
INSERT INTO `rxperson` VALUES ('2024-06-09 08:00:00', '郑十一', '男', '50', '13333334444', '苏州市', '苏州医院', '2024-06-23', '处方9', '医生I', '主治医生I');
INSERT INTO `rxperson` VALUES ('2024-06-10 10:00:00', '马十二', '女', '27', '13444445555', '杭州市', '杭州医院', '2024-06-24', '处方10', '医生J', '主治医生J');

-- ----------------------------
-- Table structure for sell
-- ----------------------------
DROP TABLE IF EXISTS `sell`;
CREATE TABLE `sell`  (
  `drugname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `changshang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pihao` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beizhu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `count` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `guige` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sum` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sell
-- ----------------------------
INSERT INTO `sell` VALUES ('药品J', '厂家J', '20', '2024-06-24', '20240624', '进货备注10', '160', '盒', '规格10', '2', '40');

-- ----------------------------
-- Table structure for sellover
-- ----------------------------
DROP TABLE IF EXISTS `sellover`;
CREATE TABLE `sellover`  (
  `drugname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `changshang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pihao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beizhu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `count` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `guige` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sellover
-- ----------------------------
INSERT INTO `sellover` VALUES ('药品A', '厂家A', '18', '2024-06-15', '20240615', '过期备注1', '15', '盒', '规格1');
INSERT INTO `sellover` VALUES ('药品B', '厂家B', '25', '2024-06-16', '20240616', '过期备注2', '18', '瓶', '规格2');
INSERT INTO `sellover` VALUES ('药品C', '厂家C', '30', '2024-06-17', '20240617', '过期备注3', '22', '包', '规格3');
INSERT INTO `sellover` VALUES ('药品D', '厂家D', '14', '2024-06-18', '20240618', '过期备注4', '12', '袋', '规格4');
INSERT INTO `sellover` VALUES ('药品E', '厂家E', '32', '2024-06-19', '20240619', '过期备注5', '28', '支', '规格5');
INSERT INTO `sellover` VALUES ('药品F', '厂家F', '26', '2024-06-20', '20240620', '过期备注6', '20', '盒', '规格6');
INSERT INTO `sellover` VALUES ('药品G', '厂家G', '20', '2024-06-21', '20240621', '过期备注7', '15', '瓶', '规格7');
INSERT INTO `sellover` VALUES ('药品H', '厂家H', '40', '2024-06-22', '20240622', '过期备注8', '35', '包', '规格8');

-- ----------------------------
-- Table structure for sellrecords
-- ----------------------------
DROP TABLE IF EXISTS `sellrecords`;
CREATE TABLE `sellrecords`  (
  `drugname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `changshang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beginprice` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pihao` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beizhu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `guige` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sum` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `selltime` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sellrecords
-- ----------------------------
INSERT INTO `sellrecords` VALUES ('药品A', '厂家A', '12', '15', '2024-06-15', '20240615', '销售记录备注1', '盒', '规格1', '20', '300', '2024-06-15 10:00:00');
INSERT INTO `sellrecords` VALUES ('药品B', '厂家B', '18', '20', '2024-06-16', '20240616', '销售记录备注2', '瓶', '规格2', '25', '500', '2024-06-16 12:00:00');
INSERT INTO `sellrecords` VALUES ('药品C', '厂家C', '22', '25', '2024-06-17', '20240617', '销售记录备注3', '包', '规格3', '30', '750', '2024-06-17 14:00:00');
INSERT INTO `sellrecords` VALUES ('药品D', '厂家D', '10', '12', '2024-06-18', '20240618', '销售记录备注4', '袋', '规格4', '15', '180', '2024-06-18 16:00:00');
INSERT INTO `sellrecords` VALUES ('药品E', '厂家E', '25', '30', '2024-06-19', '20240619', '销售记录备注5', '支', '规格5', '35', '1050', '2024-06-19 18:00:00');
INSERT INTO `sellrecords` VALUES ('药品F', '厂家F', '20', '22', '2024-06-20', '20240620', '销售记录备注6', '盒', '规格6', '28', '616', '2024-06-20 20:00:00');
INSERT INTO `sellrecords` VALUES ('药品G', '厂家G', '15', '18', '2024-06-21', '20240621', '销售记录备注7', '瓶', '规格7', '22', '396', '2024-06-21 22:00:00');
INSERT INTO `sellrecords` VALUES ('药品H', '厂家H', '30', '35', '2024-06-22', '20240622', '销售记录备注8', '包', '规格8', '40', '1400', '2024-06-22 08:00:00');
INSERT INTO `sellrecords` VALUES ('药品I', '厂家I', '25', '28', '2024-06-23', '20240623', '销售记录备注9', '袋', '规格9', '32', '896', '2024-06-23 10:00:00');
INSERT INTO `sellrecords` VALUES ('药品J', '厂家J', '18', '20', '2024-06-24', '20240624', '销售记录备注10', '盒', '规格10', '25', '500', '2024-06-24 12:00:00');
INSERT INTO `sellrecords` VALUES ('药品A', '厂家A', NULL, '15', '2024-06-15', '20240615', '销售备注1', '盒', '规格1', '100', '1500', '2024-06-25 23:39:19');
INSERT INTO `sellrecords` VALUES ('药品B', '厂家B', '15', '20', '2024-06-16', '20240616', '销售备注2', '瓶', '规格2', '150', '500', '2024-06-25 23:39:19');
INSERT INTO `sellrecords` VALUES ('药品C', '厂家C', '20', '25', '2024-06-17', '20240617', '销售备注3', '包', '规格3', '200', '750', '2024-06-25 23:39:19');
INSERT INTO `sellrecords` VALUES ('药品D', '厂家D', '8', '12', '2024-06-18', '20240618', '销售备注4', '袋', '规格4', '80', '180', '2024-06-25 23:39:19');
INSERT INTO `sellrecords` VALUES ('药品E', '厂家E', NULL, '30', '2024-06-19', '20240619', '销售备注5', '支', '规格5', '250', '1050', '2024-06-25 23:39:19');
INSERT INTO `sellrecords` VALUES ('药品F', '厂家F', '18', '22', '2024-06-20', '20240620', '销售备注6', '盒', '规格6', '180', '616', '2024-06-25 23:39:19');
INSERT INTO `sellrecords` VALUES ('药品G', '厂家G', '12', '18', '2024-06-21', '20240621', '销售备注7', '瓶', '规格7', '120', '396', '2024-06-25 23:39:19');
INSERT INTO `sellrecords` VALUES ('药品I', '厂家I', '22', '28', '2024-06-23', '20240623', '销售备注9', '袋', '规格9', '220', '896', '2024-06-25 23:39:19');
INSERT INTO `sellrecords` VALUES ('药品F', '厂家F', '18', '22', '2024-06-20', '20240620', '进货备注6', '盒', '规格6', '2', '44', '2024-06-25 23:52:52');
INSERT INTO `sellrecords` VALUES ('药品B', '厂家B', '15', '20', '2024-06-29', '20240616', '进货备注2', '瓶', '规格2', '2', '40', '2024-06-26 02:38:31');

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store`  (
  `drugname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `changshang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beginprice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `begindate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pihao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `beizhu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `count` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `guige` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tiaoxingma` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of store
-- ----------------------------
INSERT INTO `store` VALUES ('药品B', '厂家B', '15', '20', '2024-06-03', '2024-06-29', '20240616', '进货备注2', '进货库位2', '543', '瓶', '规格2', '2233445566');
INSERT INTO `store` VALUES ('药品C', '厂家C', '20', '25', '2024-06-03', '2024-06-17', '20240617', '进货备注3', '进货库位3', '47', '包', '规格3', '3344556677');
INSERT INTO `store` VALUES ('药品D', '厂家D', '8', '12', '2024-06-04', '2024-06-18', '20240618', '进货备注4', '进货库位4', '500', '袋', '规格4', '4455667788');
INSERT INTO `store` VALUES ('药品F', '厂家F', '18', '22', '2024-06-06', '2024-06-20', '20240620', '进货备注6', '进货库位6', '6', '盒', '规格6', '4433221100');
INSERT INTO `store` VALUES ('药品G', '厂家G', '12', '15', '2024-06-07', '2024-06-21', '20240621', '进货备注7', '进货库位7', '6', '瓶', '规格7', '2233445566');
INSERT INTO `store` VALUES ('药品H', '厂家H', '30', '35', '2024-06-08', '2024-06-22', '20240622', '进货备注8', '进货库位8', '6', '包', '规格8', '9988776655');
INSERT INTO `store` VALUES ('药品I', '厂家I', '22', '26', '2024-06-09', '2024-06-23', '20240623', '进货备注9', '进货库位9', '5', '袋', '规格9', '7799885566');
INSERT INTO `store` VALUES ('药品J', '厂家J', '16', '20', '2024-06-10', '2024-06-24', '20240624', '进货备注10', '进货库位10', '160', '盒', '规格10', '6655443322');

SET FOREIGN_KEY_CHECKS = 1;
