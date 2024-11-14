/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80037
 Source Host           : localhost:3306
 Source Schema         : filmsdb

 Target Server Type    : MySQL
 Target Server Version : 80037
 File Encoding         : 65001

 Date: 06/07/2024 00:22:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for discusjudges
-- ----------------------------
DROP TABLE IF EXISTS `discusjudges`;
CREATE TABLE `discusjudges`  (
  `djid` int NOT NULL AUTO_INCREMENT COMMENT '评价编号',
  `toplow` int NULL DEFAULT 0 COMMENT '评价标志（0-踩，1-顶）',
  `jdate` datetime NULL DEFAULT NULL COMMENT '评价时间',
  `uid` int NOT NULL COMMENT '用户编号',
  `did` int NOT NULL COMMENT '评论编号',
  PRIMARY KEY (`djid`) USING BTREE,
  INDEX `fk_disjudges_users1_idx`(`uid` ASC) USING BTREE,
  INDEX `fk_disjudges_discuss1_idx`(`did` ASC) USING BTREE,
  CONSTRAINT `fk_disjudges_discuss1` FOREIGN KEY (`did`) REFERENCES `discuss` (`did`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_disjudges_users1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '评论评价表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discusjudges
-- ----------------------------
INSERT INTO `discusjudges` VALUES (1, 1, '2024-07-05 14:27:08', 7, 1);
INSERT INTO `discusjudges` VALUES (2, 1, '2024-07-05 14:27:09', 7, 1);
INSERT INTO `discusjudges` VALUES (3, 1, '2024-07-05 23:35:44', 7, 3);
INSERT INTO `discusjudges` VALUES (4, 1, '2024-07-06 00:15:03', 7, 4);
INSERT INTO `discusjudges` VALUES (5, 1, '2024-07-06 00:15:04', 7, 4);
INSERT INTO `discusjudges` VALUES (6, 0, '2024-07-06 00:15:05', 7, 4);
INSERT INTO `discusjudges` VALUES (7, 0, '2024-07-06 00:16:37', 7, 3);

-- ----------------------------
-- Table structure for discuss
-- ----------------------------
DROP TABLE IF EXISTS `discuss`;
CREATE TABLE `discuss`  (
  `did` int NOT NULL AUTO_INCREMENT COMMENT '评论编号',
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT '影评内容',
  `cdate` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `topcount` int NULL DEFAULT 0 COMMENT '顶的数量',
  `lowcount` int NULL DEFAULT 0 COMMENT '踩的数量',
  `uid` int NOT NULL COMMENT '用户编号',
  `fid` int NOT NULL COMMENT '文学编号',
  PRIMARY KEY (`did`) USING BTREE,
  INDEX `fk_discuss_users_idx`(`uid` ASC) USING BTREE INVISIBLE,
  INDEX `fk_discuss_classics_idx`(`fid` ASC) USING BTREE INVISIBLE,
  CONSTRAINT `fk_discuss_films1` FOREIGN KEY (`fid`) REFERENCES `films` (`fid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_discuss_users` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '文学评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discuss
-- ----------------------------
INSERT INTO `discuss` VALUES (1, 'DTGXRR', '2024-07-05 14:27:06', 2, 0, 7, 21);
INSERT INTO `discuss` VALUES (3, '大师傅大师傅', '2024-07-05 23:35:43', 1, 1, 7, 3);
INSERT INTO `discuss` VALUES (4, '往往是特', '2024-07-06 00:15:00', 2, 1, 7, 6);
INSERT INTO `discuss` VALUES (5, '独特的让他', '2024-07-06 00:16:36', 0, 0, 7, 3);
INSERT INTO `discuss` VALUES (6, '热死热死人', '2024-07-06 00:16:43', 0, 0, 7, 6);

-- ----------------------------
-- Table structure for filmjudges
-- ----------------------------
DROP TABLE IF EXISTS `filmjudges`;
CREATE TABLE `filmjudges`  (
  `cjid` int NOT NULL AUTO_INCREMENT COMMENT '评价编号',
  `rating` int NULL DEFAULT 5 COMMENT '星级评价（1-5级）',
  `jdate` datetime NULL DEFAULT NULL COMMENT '评价时间',
  `fid` int NOT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`cjid`) USING BTREE,
  INDEX `fk_classicjudge_classics1_idx`(`fid` ASC) USING BTREE,
  INDEX `fk_classicjudge_users1_idx`(`uid` ASC) USING BTREE,
  CONSTRAINT `fk_classicjudge_classics1` FOREIGN KEY (`fid`) REFERENCES `films` (`fid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_classicjudge_users1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '文学评价表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of filmjudges
-- ----------------------------

-- ----------------------------
-- Table structure for films
-- ----------------------------
DROP TABLE IF EXISTS `films`;
CREATE TABLE `films`  (
  `fid` int NOT NULL AUTO_INCREMENT COMMENT '文学编号',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '名称',
  `cover` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '封面',
  `year` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '年代',
  `author` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '作者',
  `present` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '呈现形式',
  `describes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT '文学简介',
  `rating` int NULL DEFAULT 0 COMMENT '总评级（1-5星）',
  `commentscount` int NULL DEFAULT 0 COMMENT '评论人总数',
  `tid` int NOT NULL COMMENT '类型编号',
  PRIMARY KEY (`fid`) USING BTREE,
  INDEX `fk_classics_classictype1_idx`(`tid` ASC) USING BTREE,
  CONSTRAINT `fk_classics_classictype1` FOREIGN KEY (`tid`) REFERENCES `filmtype` (`tid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '古典文学表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of films
-- ----------------------------
INSERT INTO `films` VALUES (1, '芭比', 'bb.jpg', '2023', '格蕾塔·葛韦格', '电影', '　在梦幻浪漫的芭比乐园里，美丽自信的芭比们每日过着快乐无忧的生活，她们活跃在每一个工作岗位，肯是点缀，女孩的聚会才至关重要。直到某一天，我们的主角芭比（玛格特·罗比 Margot Robbie 饰）突然提到了生死，她的完美生活毫无征兆发生改变。她的口气不再清新，面容开始犹豫憔悴，也无法轻盈地从顶楼飘落下来。经前辈点播，她意识到人类世界某个人和她建立着联系，而那个人的心境似乎正投射到芭比的身上来。', 10, 2, 1);
INSERT INTO `films` VALUES (2, '哈利波特', 'hl.jpg', '2022', 'J.K.罗琳', '电影', '《哈利·波特》系列电影，是由美国华纳兄弟娱乐公司将JK罗琳所著的同名系列小说改拍成的八部电影，由丹尼尔·雷德克里夫、鲁伯特·格林特、艾玛·沃特森等主演的剧情片。讲述的是年轻的巫师学生哈利·波特在霍格沃茨魔法学校前后六年的学习生活和冒险故事；第七部讲述的是哈利·波特在第二次巫界大战中被迫逃亡在外寻找魂器并消灭伏地魔的故事。', 5, 3, 1);
INSERT INTO `films` VALUES (3, '复仇者联盟', 'fc.jpg', '2012', '乔斯·韦登', '电影', '《复仇者联盟》是由美国漫威影业公司出品的超级英雄电影，改编自漫威漫画旗下同名漫画，讲述了钢铁侠、美国队长、雷神、绿巨人、黑寡妇、鹰眼等超级英雄们联合抵御外星入侵的故事', 8, 2, 1);
INSERT INTO `films` VALUES (4, '泰坦尼克号', 'tt.jpg', '1997', '詹姆斯·卡梅隆', '电影', '《泰坦尼克号》是由詹姆斯·卡梅隆执导的一部浪漫爱情电影，故事以1912年泰坦尼克号沉船事件为背景，讲述了贫穷画家杰克和贵族少女露丝在船上的爱情故事。', 5, 5, 1);
INSERT INTO `films` VALUES (5, '盗梦空间', 'dm.jpg', '2010', '克里斯托弗·诺兰', '电影', '《盗梦空间》是一部由克里斯托弗·诺兰执导的科幻电影，讲述了一位专业从事潜意识盗取的盗贼通过梦境技术进入目标的大脑，并执行一次复杂的植入任务。', 3, 0, 1);
INSERT INTO `films` VALUES (6, '星球大战', 'xq.jpg', '1977', '乔治·卢卡斯\n', '电影', '《星球大战》是由乔治·卢卡斯创作的科幻电影系列，讲述了银河帝国与反抗军联盟之间的斗争，以及天行者家族的冒险经历。', 8, 3, 1);
INSERT INTO `films` VALUES (7, '指环王', 'zh.jpg', '2001', '彼得·杰克逊', '电影', '《指环王》三部曲是根据J.R.R.托尔金的同名小说改编的史诗奇幻电影，讲述了霍比特人弗罗多和他的伙伴们为了摧毁魔戒，阻止黑暗势力索伦的复兴而展开的冒险。', 5, 0, 1);
INSERT INTO `films` VALUES (8, '我的天才女友', 'wd.jpg', '2001', '埃莱娜·费兰特', '电视剧', '《我的天才女友》讲述了两个女主人公莉拉和埃莱娜的少女时代。莉拉和埃莱娜一起成长于那不勒斯一个破败的社区，从小形影不离，彼此信赖，但又都视对方为自己隐秘的镜子，暗暗角力。小说展现了以“我”和莉拉为代表的新一代女性身体与心灵的成长路径。', 3, 5, 1);
INSERT INTO `films` VALUES (9, '千与千寻', 'qy.jpg', '2001', '宫崎骏', '动漫', '《千与千寻》（千と千尋の神隠し）是2001年上映的日本彩色电影，由宫崎骏编剧并执导，久石让配乐，柊瑠美、入野自由、中村彰男、夏木麻里等配音的动画电影。于2001年7月20日在日本上映，2019年6月21日在中国大陆公映。2022年8月5日起，该片在中国台湾地区重映数字修复版本。该片主要讲述了千寻意外来到神灵世界后，为了救因惩罚而变成猪的家人，经历许多磨难的故事。', 0, 9, 2);
INSERT INTO `films` VALUES (10, '深海', 'sh.jpg', '2023', '田晓鹏', '动漫', '深海》是一部由田晓鹏执导，田晓鹏、田博编剧，苏鑫、王亭文、滕奎兴等配音演员演出的奇幻动画电影。该影片2023年1月22日在中国大陆上映 。 [35]\r\n影片讲述了一名少女参宿在神秘海底世界中追寻探索，邂逅南河船长开启一段独特生命旅程的故事 。', 3, 8, 2);
INSERT INTO `films` VALUES (11, '大雨', 'dy.jpg', '2024', '不思凡', '动漫', '《大雨》是由上海今涂影业有限公司、上海华人影业有限公司、霍尔果斯彩条屋影业有限公司出品 [24]，不思凡编剧及执导， 何梓骞、 杏林儿、 良生、陈浩等参与配音的水墨国风动画电影 [25-26]。该片于2024年1月12日在中国大陆上映；2024年1月25日在北美、澳新、英国及爱尔兰上映 [20]。\r\n该片讲述了蒙受冤屈的通缉犯大谷子与弃婴馒头之间的父子之爱和彼此救赎的故事', 5, 3, 2);
INSERT INTO `films` VALUES (12, '千与千寻', 'qy.jpg', '2001', '宫崎骏', '动漫', '《千与千寻》（千と千尋の神隠し）是2001年上映的日本彩色电影，由宫崎骏编剧并执导，久石让配乐，柊瑠美、入野自由、中村彰男、夏木麻里等配音的动画电影。于2001年7月20日在日本上映，2019年6月21日在中国大陆公映。2022年8月5日起，该片在中国台湾地区重映数字修复版本。该片主要讲述了千寻意外来到神灵世界后，为了救因惩罚而变成猪的家人，经历许多磨难的故事。', 0, 9, 2);
INSERT INTO `films` VALUES (13, '深海', 'sh.jpg', '2023', '田晓鹏', '动漫', '深海》是一部由田晓鹏执导，田晓鹏、田博编剧，苏鑫、王亭文、滕奎兴等配音演员演出的奇幻动画电影。该影片2023年1月22日在中国大陆上映 。 [35]\r\n影片讲述了一名少女参宿在神秘海底世界中追寻探索，邂逅南河船长开启一段独特生命旅程的故事 。', 3, 8, 2);
INSERT INTO `films` VALUES (14, '大雨', 'dy.jpg', '2024', '不思凡', '动漫', '《大雨》是由上海今涂影业有限公司、上海华人影业有限公司、霍尔果斯彩条屋影业有限公司出品 [24]，不思凡编剧及执导， 何梓骞、 杏林儿、 良生、陈浩等参与配音的水墨国风动画电影 [25-26]。该片于2024年1月12日在中国大陆上映；2024年1月25日在北美、澳新、英国及爱尔兰上映 [20]。\r\n该片讲述了蒙受冤屈的通缉犯大谷子与弃婴馒头之间的父子之爱和彼此救赎的故事', 5, 3, 2);
INSERT INTO `films` VALUES (15, '七宗罪', 'qz.jpg', ' 1995', ' 大卫·芬奇', '电影', ': 《七宗罪》是一部由大卫·芬奇执导的心理悬疑片，讲述了两位警探追踪一个以七宗罪为动机的连环杀手的故事。', 5, 5, 3);
INSERT INTO `films` VALUES (16, '禁闭岛', 'jb.jpg', '2010', '马丁·斯科塞斯', '电影', '《禁闭岛》是一部由马丁·斯科塞斯执导的心理悬疑片，讲述了两位警探在一座精神病院中调查失踪案，并逐渐揭开隐藏在医院背后的恐怖真相。', 0, 4, 3);
INSERT INTO `films` VALUES (17, '致命ID', 'zmid.jpg', '2003', '詹姆斯·曼高德', ' 电影', '《致命ID》是一部由詹姆斯·曼高德执导的悬疑惊悚片，讲述了十个陌生人在一个偏僻的汽车旅馆中相遇，并发现其中一个人是连环杀手的故事。', 4, 6, 3);
INSERT INTO `films` VALUES (18, '消失的爱人', 'xs.jpg', ' 2014', '大卫·芬奇', '电影', '《消失的爱人》是一部由大卫·芬奇执导的心理悬疑片，改编自吉莉安·弗琳的同名小说，讲述了一名男子在妻子失踪后，逐渐被怀疑为谋杀嫌疑人的故事。', 0, 0, 3);
INSERT INTO `films` VALUES (19, '银河护卫队', 'yh.jpg', '2014', '詹姆斯·古恩', '电影', '《银河护卫队》是一部由詹姆斯·古恩执导的科幻动作片，讲述了一群宇宙流浪者组成的团队，联合起来对抗威胁银河系的邪恶势力的故事。', 4, 2, 4);
INSERT INTO `films` VALUES (20, '冰雪奇缘', 'bx.jpg', '2013', '克里斯·巴克, 珍妮弗·李', '动画片', '西北有高楼，上与浮云齐。<br />交疏结绮窗，阿阁三重阶。<br />上有弦歌声，音响一何悲！<br />谁能为此曲，无乃杞梁妻。<br />清商随风发，中曲正徘徊。<br />一弹再三叹，慷慨有余哀。<br />不惜歌者苦，但伤知音稀。<br />愿为双鸿鹄，奋翅起高飞。(鸿鹄 一作：鸣鹤)', 0, 0, 4);
INSERT INTO `films` VALUES (21, '阿甘正传', 'ag.jpg', '1994', '罗伯特·泽米吉斯', '电影', '《阿甘正传》是一部由罗伯特·泽米吉斯执导的剧情片，讲述了一个智商不高但心地善良的男子福瑞斯特·甘普，经历了美国近现代史上多个重大事件的故事。', 4, 4, 4);
INSERT INTO `films` VALUES (22, '银河护卫队', 'yh.jpg', '2014', '詹姆斯·古恩', '电影', '《银河护卫队》是一部由詹姆斯·古恩执导的科幻动作片，讲述了一群宇宙流浪者组成的团队，联合起来对抗威胁银河系的邪恶势力的故事。', 4, 2, 4);
INSERT INTO `films` VALUES (23, '冰雪奇缘', 'bx.jpg', '2013', '克里斯·巴克, 珍妮弗·李', '动画片', '西北有高楼，上与浮云齐。<br />交疏结绮窗，阿阁三重阶。<br />上有弦歌声，音响一何悲！<br />谁能为此曲，无乃杞梁妻。<br />清商随风发，中曲正徘徊。<br />一弹再三叹，慷慨有余哀。<br />不惜歌者苦，但伤知音稀。<br />愿为双鸿鹄，奋翅起高飞。(鸿鹄 一作：鸣鹤)', 0, 0, 4);
INSERT INTO `films` VALUES (24, '阿甘正传', 'ag.jpg', '1994', '罗伯特·泽米吉斯', '电影', '《阿甘正传》是一部由罗伯特·泽米吉斯执导的剧情片，讲述了一个智商不高但心地善良的男子福瑞斯特·甘普，经历了美国近现代史上多个重大事件的故事。', 4, 4, 4);

-- ----------------------------
-- Table structure for filmtype
-- ----------------------------
DROP TABLE IF EXISTS `filmtype`;
CREATE TABLE `filmtype`  (
  `tid` int NOT NULL AUTO_INCREMENT COMMENT '类型编号',
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '类型名称',
  `cover` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '类型封面',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '文学类型备注',
  PRIMARY KEY (`tid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '古典文学类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of filmtype
-- ----------------------------
INSERT INTO `filmtype` VALUES (1, '欧美', 'logo.png', NULL);
INSERT INTO `filmtype` VALUES (2, '动漫', 'logo.png', NULL);
INSERT INTO `filmtype` VALUES (3, '悬疑', 'logo.png', NULL);
INSERT INTO `filmtype` VALUES (4, '其他', 'logo.png', NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `uid` int NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `uname` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '登录账号',
  `upwd` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '登录密码',
  `nikename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '头像',
  `sex` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '电话',
  `remark` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'xiaobai', '123456', '小白白', 'tx.png', '男', '16532658974', NULL);
INSERT INTO `users` VALUES (2, 'lisi', '123456', '李四哥', 'tx.png', '男', '15635698745', NULL);
INSERT INTO `users` VALUES (3, 'wangwu', '123456', '王武哥', 'tx.png', '男', '15698562354', NULL);
INSERT INTO `users` VALUES (6, 'xiaoli', '123456', '小李', 'tx.png', '男', NULL, NULL);
INSERT INTO `users` VALUES (7, 'admin', '111111', '423', 'tx.png', '男', '4232', NULL);

SET FOREIGN_KEY_CHECKS = 1;
