/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50529
 Source Host           : localhost:3306
 Source Schema         : ht

 Target Server Type    : MySQL
 Target Server Version : 50529
 File Encoding         : 65001

 Date: 15/01/2020 00:08:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dl_advertise
-- ----------------------------
DROP TABLE IF EXISTS `dl_advertise`;
CREATE TABLE `dl_advertise`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1微信2支付宝',
  `status` tinyint(1) NOT NULL,
  `create_at` int(11) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '平台收款二维码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_advertise
-- ----------------------------
INSERT INTO `dl_advertise` VALUES (4, '首页广告啊', 'http://baidu.com', 'cate_img/20191113\\9b0984ecda6f087fa339e4d4907e3f9a.jpg', 3, 0, 0);
INSERT INTO `dl_advertise` VALUES (7, '大神博客', 'http://www.123.com', '', 1, 0, 0);

-- ----------------------------
-- Table structure for dl_article
-- ----------------------------
DROP TABLE IF EXISTS `dl_article`;
CREATE TABLE `dl_article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(5) DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf32 COLLATE utf32_general_ci DEFAULT NULL,
  `keyword` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci DEFAULT NULL COMMENT '缩略图',
  `content` text CHARACTER SET utf32 COLLATE utf32_general_ci,
  `views` int(10) DEFAULT 1 COMMENT '点击率',
  `pubtime` datetime DEFAULT NULL COMMENT '发布时间',
  `dateline` timestamp DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf32 COLLATE = utf32_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_article
-- ----------------------------
INSERT INTO `dl_article` VALUES (1, 1, '标题', '阿萨德,阿萨德个,关键词啊你猜', '文章描述', '', '<p>阿萨德<img src=\"http://ht.cn/static/admin/js/umeditor/php/upload/20191231/15777217947234.jpg\" style=\"width: 109px; height: 97px;\"/></p><p><br/></p>', 1, '2019-12-31 00:00:00', '2019-12-31 23:25:44');

-- ----------------------------
-- Table structure for dl_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `dl_auth_group`;
CREATE TABLE `dl_auth_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `rules` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '规则id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_auth_group
-- ----------------------------
INSERT INTO `dl_auth_group` VALUES (31, '超级管理员', 1, '6,21,7,435,436,437,11,438,439,440,441,442,443,444,445,19,464,266,1,501,502,503,504,456,457,461,462,463,495,496,508,510,511,512,465,466,467,472,473,468,474,506,469,470,471,475,476,497,498,477,499,478,479,505,480,507,515,516,481,482,483,484,485,486,487,488,489,500,490,491,492,493,494,513,514');

-- ----------------------------
-- Table structure for dl_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `dl_auth_group_access`;
CREATE TABLE `dl_auth_group_access`  (
  `uid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `group_id` int(11) UNSIGNED NOT NULL COMMENT '用户组id',
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 99 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户组明细表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of dl_auth_group_access
-- ----------------------------
INSERT INTO `dl_auth_group_access` VALUES (78, 31);
INSERT INTO `dl_auth_group_access` VALUES (77, 31);
INSERT INTO `dl_auth_group_access` VALUES (65, 31);
INSERT INTO `dl_auth_group_access` VALUES (66, 31);
INSERT INTO `dl_auth_group_access` VALUES (96, 0);
INSERT INTO `dl_auth_group_access` VALUES (81, 31);
INSERT INTO `dl_auth_group_access` VALUES (95, 31);
INSERT INTO `dl_auth_group_access` VALUES (98, 31);
INSERT INTO `dl_auth_group_access` VALUES (1, 31);
INSERT INTO `dl_auth_group_access` VALUES (23, 30);

-- ----------------------------
-- Table structure for dl_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `dl_auth_rule`;
CREATE TABLE `dl_auth_rule`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级id',
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：为1正常，为0禁用',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `condition` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 517 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '规则表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of dl_auth_rule
-- ----------------------------
INSERT INTO `dl_auth_rule` VALUES (1, 266, 'Admin/nav/index', '菜单设置', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (21, 0, 'Admin/Rule', '权限控制', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (7, 21, 'Admin/Rule/index', '权限管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (11, 21, 'Admin/Rule/group', '用户组管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (19, 21, 'Admin/Rule/admin_user_list', '管理员列表', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (6, 0, 'Admin/Index/index', '后台首页', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (496, 456, 'admin/member/edit_unfreeze', '解冻用户', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (490, 0, 'admin/operation', '设置中心', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (492, 490, 'admin/operation/index', '参数设置', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (493, 490, 'admin/operation/get_addr', '获取IP对应地址', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (494, 490, 'admin/operation/edit', '参数设置保存', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (491, 490, 'admin/operation/showlist', '操作记录', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (445, 11, 'Admin/Rule/edit_admin', '修改管理员', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (444, 11, 'Admin/Rule/add_admin', '添加管理员', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (443, 11, 'Admin/Rule/add_user_to_group', '设置管理员', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (442, 11, 'Admin/Rule/check_user', '添加成员', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (441, 11, 'Admin/Rule/rule_group', '分配权限', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (440, 11, 'Admin/Rule/delete_group', '删除用户组', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (439, 11, 'Admin/Rule/edit_group', '修改用户组', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (438, 11, 'Admin/Rule/add_group', '添加用户组', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (437, 7, 'Admin/Rule/delete', '删除权限', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (436, 7, 'Admin/Rule/edit', '修改权限', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (435, 7, 'Admin/Rule/add', '添加权限管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (266, 0, 'admin/nav', '菜单管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (495, 456, 'admin/member/edit_frozen', '冻结用户', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (456, 0, 'Admin/member', '用户管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (457, 456, 'Admin/member/index', '用户信息', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (462, 456, 'Admin/Member/edit', '用户编辑', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (461, 456, 'Admin/Member/login_log', '登陆日志', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (465, 0, 'Admin/lottery', '彩票管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (463, 456, 'Admin/Member/del', '用户删除', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (464, 19, 'Admin/Rule/del', '删除管理员', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (466, 465, 'Admin/Lottery/index', '彩种管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (467, 465, 'Admin/Lottery/hall', '大厅设置', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (468, 465, 'Admin/lottery/eight_index', '玩法赔率设置', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (469, 465, 'Admin/lottery/play_rule', '游戏规则设置', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (470, 465, 'Admin/lottery/history', '开奖历史', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (471, 465, 'admin/lottery/edit', '编辑彩种', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (472, 467, 'admin/lottery/water_edit', '回水、流水设置', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (473, 467, 'admin/lottery/hall_edit', '大厅编辑', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (474, 468, 'admin/lottery/eight_pei', '赔率玩法显示', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (475, 0, 'admin/money/index', '金额管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (476, 475, 'admin/money/recharge', '充值记录', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (477, 475, 'admin/money/cash', '提现记录', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (478, 475, 'admin/money/betting', '投注记录', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (479, 475, 'admin/money/back_water', '代理返利', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (480, 475, 'admin/money/transaction', '金额流水', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (481, 0, 'admin/advertise', '广告管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (482, 481, 'admin/advertise/index', '广告设置', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (483, 481, 'admin/advertise/edit', '广告编辑', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (484, 0, 'admin/notice/index', '公告管理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (485, 484, 'admin/notice/personal', '个人公告', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (486, 484, 'admin/notice/personal_del', '删除个人公告', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (487, 484, 'admin/notice/system', '系统公告', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (488, 484, 'admin/notice/system_edit', '编辑系统公告', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (489, 484, 'admin/notice/system_del', '删除系统公告', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (497, 476, 'admin/money/addmoney', '后台充值', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (498, 476, 'admin/money/edit_status', '充值审核', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (499, 477, 'admin/money/edit_withdrawal_status', '提现审核', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (500, 484, 'admin/notice/add_system', '添加系统公告', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (501, 1, 'admin/nav/add', '添加菜单', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (502, 1, 'admin/nav/edit', '修改菜单', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (503, 1, 'admin/nav/delete', '删除菜单', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (504, 1, 'admin/nav/order', '菜单排序', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (505, 479, 'admin/moneyedit_water_status', '回水、流水审核', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (506, 468, 'admin/lottery/edit_pei', '具体赔率玩法设置', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (507, 475, 'Admin/Money/win_lose_all', '盈亏统计', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (508, 456, 'Admin/member/add', '添加会员', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (510, 456, 'Admin/member/add_agent', '添加代理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (511, 456, 'Admin/member/edit_agent', '修改代理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (512, 456, 'Admin/member/index_agent', '代理信息', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (513, 0, 'admin/proxy', '总代模块', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (514, 0, 'admin/lord', '二级代理', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (515, 475, 'Admin/Money/report', '今日报表', 1, 1, '');
INSERT INTO `dl_auth_rule` VALUES (516, 475, 'Admin/Money/proxy_cash', '代理提现', 1, 1, '');

-- ----------------------------
-- Table structure for dl_cate
-- ----------------------------
DROP TABLE IF EXISTS `dl_cate`;
CREATE TABLE `dl_cate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `keyword` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法',
  `desc` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制器',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_cate
-- ----------------------------
INSERT INTO `dl_cate` VALUES (1, '新闻', 0, '11', '22', '32', 1, '2017-11-09 14:28:10', 0);
INSERT INTO `dl_cate` VALUES (2, '热门', 0, '', '', '', 1, '2017-11-09 14:29:37', 1);
INSERT INTO `dl_cate` VALUES (3, '资源', 0, '', '', '', 1, '2017-11-29 06:22:30', 0);

-- ----------------------------
-- Table structure for dl_login_log
-- ----------------------------
DROP TABLE IF EXISTS `dl_login_log`;
CREATE TABLE `dl_login_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:会员登陆日志，2：管理员登陆日志',
  `ip` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登陆IP',
  `ip_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登陆IP对应的地址',
  `create_at` int(11) NOT NULL COMMENT '登陆时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1759 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户登陆记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_login_log
-- ----------------------------
INSERT INTO `dl_login_log` VALUES (1758, 1, 2, '127.0.0.1', '本地', 1576678235);
INSERT INTO `dl_login_log` VALUES (1757, 1, 2, '127.0.0.1', '本地', 1576415528);
INSERT INTO `dl_login_log` VALUES (1756, 1, 2, '127.0.0.1', '本地', 1574737103);
INSERT INTO `dl_login_log` VALUES (1755, 1, 2, '127.0.0.1', '本地', 1574736823);
INSERT INTO `dl_login_log` VALUES (1754, 1, 2, '127.0.0.1', '本地', 1573655724);
INSERT INTO `dl_login_log` VALUES (1753, 1, 2, '127.0.0.1', '本地', 1573397711);
INSERT INTO `dl_login_log` VALUES (1752, 1, 2, '127.0.0.1', '本地', 1573394051);
INSERT INTO `dl_login_log` VALUES (1751, 1, 2, '127.0.0.1', '本地', 1573367986);
INSERT INTO `dl_login_log` VALUES (1750, 1, 2, '127.0.0.1', '本地', 1573367667);
INSERT INTO `dl_login_log` VALUES (1749, 1, 2, '127.0.0.1', '本地', 1573367236);
INSERT INTO `dl_login_log` VALUES (1748, 1, 2, '127.0.0.1', '本地', 1573367106);
INSERT INTO `dl_login_log` VALUES (1747, 1, 2, '127.0.0.1', '本地', 1573366773);
INSERT INTO `dl_login_log` VALUES (1746, 1, 2, '127.0.0.1', '本地', 1573366083);
INSERT INTO `dl_login_log` VALUES (1745, 1, 2, '127.0.0.1', '本地', 1573365672);
INSERT INTO `dl_login_log` VALUES (1744, 1, 2, '127.0.0.1', '本地', 1573363370);
INSERT INTO `dl_login_log` VALUES (1743, 1, 2, '127.0.0.1', '本地', 1573363312);
INSERT INTO `dl_login_log` VALUES (1742, 1, 2, '127.0.0.1', '本地', 1573362456);
INSERT INTO `dl_login_log` VALUES (1741, 1, 2, '127.0.0.1', '本地', 1573361980);
INSERT INTO `dl_login_log` VALUES (1740, 1, 2, '127.0.0.1', '本地', 1573361372);
INSERT INTO `dl_login_log` VALUES (1739, 1, 2, '127.0.0.1', '本地', 1573354951);

-- ----------------------------
-- Table structure for dl_member
-- ----------------------------
DROP TABLE IF EXISTS `dl_member`;
CREATE TABLE `dl_member`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '昵称',
  `phone` int(11) DEFAULT NULL COMMENT '用户电话号码',
  `money` decimal(11, 2) DEFAULT 0.00 COMMENT '余额 ',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `nickname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '会员名称',
  `truename` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电子邮箱',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1正常0冻结',
  `head` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '/static/home/chat1/image/avatar.png' COMMENT '头像',
  `remark` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `ip` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '注册IP',
  `update_at` int(11) DEFAULT 0 COMMENT '更新时间',
  `create_at` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 551 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_member
-- ----------------------------
INSERT INTO `dl_member` VALUES (525, 'qqq888', NULL, 0.00, '96e79218965eb72c92a549dd5a330112', '', '', '12@asd.com', 0, '/static/home/chat1/image/avatar.png', NULL, '218.0.237.30', 1560392603, 1560392589);
INSERT INTO `dl_member` VALUES (538, 'cc174478', NULL, 0.00, 'e8ab74eb3b786fabb0e6b03c98bcbac6', '', '', '', 0, '/static/home/chat1/image/avatar.png', NULL, '115.206.243.84', 1561394672, 1561394656);
INSERT INTO `dl_member` VALUES (541, 'qq789', NULL, 10000.00, 'e10adc3949ba59abbe56e057f20f883e', '', '', '', 0, '/static/home/chat1/image/avatar.png', NULL, '112.96.194.148', 1561447513, 1561446982);
INSERT INTO `dl_member` VALUES (544, 'zxcvbnm', NULL, 1794.86, '02c75fb22c75b23dc963c7eb91a062cc', '', '', '', 0, '/static/home/chat1/image/avatar.png', NULL, '14.116.133.171', 1561517599, 1561517584);
INSERT INTO `dl_member` VALUES (550, 'jincon', 2147483647, 100.00, 'e10adc3949ba59abbe56e057f20f883e', '', '宝子', '123456@qq.com', 1, '/static/home/chat1/image/avatar.png', '备注', '127.0.0.1', 0, 1577800116);

-- ----------------------------
-- Table structure for dl_notice
-- ----------------------------
DROP TABLE IF EXISTS `dl_notice`;
CREATE TABLE `dl_notice`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `info` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `his_name_is_seth_rich` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `type` int(2) NOT NULL DEFAULT 1 COMMENT '1首页通告2弹窗3聊天室',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_notice
-- ----------------------------
INSERT INTO `dl_notice` VALUES (14, '通知', '公告内容公告内容公告内容', '2019-11-10 12:12:13', '', 1);
INSERT INTO `dl_notice` VALUES (16, '通知:', '公告内容公告内容公告内容公告内容公告内容', '2019-11-10 12:12:07', '', 1);

-- ----------------------------
-- Table structure for dl_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `dl_operation_log`;
CREATE TABLE `dl_operation_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `operation_uid` mediumint(4) NOT NULL DEFAULT 0,
  `operation_node` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作节点',
  `operation_ip` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `operation_addr` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '0' COMMENT '操作地址',
  `operation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `his_name_is_seth_rich` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_uid_node`(`operation_uid`, `operation_node`(255), `id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 865 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '操作记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_operation_log
-- ----------------------------
INSERT INTO `dl_operation_log` VALUES (770, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 21:53:52', '');
INSERT INTO `dl_operation_log` VALUES (769, 1, 'Member/edit_frozen', '127.0.0.1', '本地', '2019-11-10 21:47:47', '');
INSERT INTO `dl_operation_log` VALUES (768, 1, 'Member/edit_frozen', '127.0.0.1', '本地', '2019-11-10 21:47:35', '');
INSERT INTO `dl_operation_log` VALUES (767, 1, 'Member/edit_frozen', '127.0.0.1', '本地', '2019-11-10 21:47:34', '');
INSERT INTO `dl_operation_log` VALUES (766, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 14:39:19', '');
INSERT INTO `dl_operation_log` VALUES (765, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 14:39:16', '');
INSERT INTO `dl_operation_log` VALUES (764, 1, 'Rule/add_admin', '127.0.0.1', '本地', '2019-11-10 14:37:21', '');
INSERT INTO `dl_operation_log` VALUES (763, 1, 'Rule/add_admin', '127.0.0.1', '本地', '2019-11-10 14:37:21', '');
INSERT INTO `dl_operation_log` VALUES (762, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 14:34:12', '');
INSERT INTO `dl_operation_log` VALUES (761, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 14:25:49', '');
INSERT INTO `dl_operation_log` VALUES (760, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 14:24:37', '');
INSERT INTO `dl_operation_log` VALUES (759, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 14:22:41', '');
INSERT INTO `dl_operation_log` VALUES (758, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 14:18:29', '');
INSERT INTO `dl_operation_log` VALUES (757, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 14:07:51', '');
INSERT INTO `dl_operation_log` VALUES (756, 1, 'Advertise/del', '127.0.0.1', '本地', '2019-11-10 14:00:53', '');
INSERT INTO `dl_operation_log` VALUES (755, 1, 'Advertise/edit', '127.0.0.1', '本地', '2019-11-10 14:00:47', '');
INSERT INTO `dl_operation_log` VALUES (754, 1, 'Operation/qrcode_edit', '127.0.0.1', '本地', '2019-11-10 14:00:00', '');
INSERT INTO `dl_operation_log` VALUES (753, 1, 'Advertise/del', '127.0.0.1', '本地', '2019-11-10 13:55:28', '');
INSERT INTO `dl_operation_log` VALUES (752, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:53:48', '');
INSERT INTO `dl_operation_log` VALUES (751, 1, 'Advertise/edit', '127.0.0.1', '本地', '2019-11-10 13:33:49', '');
INSERT INTO `dl_operation_log` VALUES (750, 1, 'Advertise/edit', '127.0.0.1', '本地', '2019-11-10 13:33:49', '');
INSERT INTO `dl_operation_log` VALUES (749, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 13:26:50', '');
INSERT INTO `dl_operation_log` VALUES (748, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 13:26:34', '');
INSERT INTO `dl_operation_log` VALUES (747, 1, 'Advertise/edit', '127.0.0.1', '本地', '2019-11-10 13:23:46', '');
INSERT INTO `dl_operation_log` VALUES (746, 1, 'Advertise/edit', '127.0.0.1', '本地', '2019-11-10 13:23:46', '');
INSERT INTO `dl_operation_log` VALUES (745, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:22:33', '');
INSERT INTO `dl_operation_log` VALUES (744, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:22:28', '');
INSERT INTO `dl_operation_log` VALUES (743, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:22:20', '');
INSERT INTO `dl_operation_log` VALUES (742, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:22:14', '');
INSERT INTO `dl_operation_log` VALUES (741, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 13:22:04', '');
INSERT INTO `dl_operation_log` VALUES (740, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 13:21:43', '');
INSERT INTO `dl_operation_log` VALUES (739, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:16:13', '');
INSERT INTO `dl_operation_log` VALUES (738, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:06:55', '');
INSERT INTO `dl_operation_log` VALUES (737, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 13:06:43', '');
INSERT INTO `dl_operation_log` VALUES (736, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:06:22', '');
INSERT INTO `dl_operation_log` VALUES (735, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 13:06:18', '');
INSERT INTO `dl_operation_log` VALUES (734, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-10 13:06:07', '');
INSERT INTO `dl_operation_log` VALUES (733, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-10 13:06:07', '');
INSERT INTO `dl_operation_log` VALUES (732, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-10 13:03:40', '');
INSERT INTO `dl_operation_log` VALUES (731, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-10 13:03:39', '');
INSERT INTO `dl_operation_log` VALUES (730, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-10 13:00:19', '');
INSERT INTO `dl_operation_log` VALUES (729, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-10 13:00:18', '');
INSERT INTO `dl_operation_log` VALUES (728, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:58:46', '');
INSERT INTO `dl_operation_log` VALUES (727, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:58:38', '');
INSERT INTO `dl_operation_log` VALUES (726, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:58:32', '');
INSERT INTO `dl_operation_log` VALUES (725, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:58:16', '');
INSERT INTO `dl_operation_log` VALUES (724, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:58:10', '');
INSERT INTO `dl_operation_log` VALUES (723, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:58:04', '');
INSERT INTO `dl_operation_log` VALUES (722, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:57:51', '');
INSERT INTO `dl_operation_log` VALUES (721, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:57:26', '');
INSERT INTO `dl_operation_log` VALUES (720, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:57:18', '');
INSERT INTO `dl_operation_log` VALUES (719, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:57:10', '');
INSERT INTO `dl_operation_log` VALUES (718, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:57:04', '');
INSERT INTO `dl_operation_log` VALUES (717, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:56:56', '');
INSERT INTO `dl_operation_log` VALUES (716, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:56:35', '');
INSERT INTO `dl_operation_log` VALUES (715, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:45:57', '');
INSERT INTO `dl_operation_log` VALUES (714, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:42:24', '');
INSERT INTO `dl_operation_log` VALUES (713, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:42:12', '');
INSERT INTO `dl_operation_log` VALUES (712, 1, 'Operation/do_delete', '127.0.0.1', '本地', '2019-11-10 12:39:43', '');
INSERT INTO `dl_operation_log` VALUES (711, 1, 'Operation/do_delete', '127.0.0.1', '本地', '2019-11-10 12:39:39', '');
INSERT INTO `dl_operation_log` VALUES (710, 1, 'Operation/do_delete', '127.0.0.1', '本地', '2019-11-10 12:39:34', '');
INSERT INTO `dl_operation_log` VALUES (709, 1, 'Operation/do_delete', '127.0.0.1', '本地', '2019-11-10 12:39:29', '');
INSERT INTO `dl_operation_log` VALUES (708, 1, 'Operation/do_delete', '127.0.0.1', '本地', '2019-11-10 12:39:27', '');
INSERT INTO `dl_operation_log` VALUES (707, 1, 'Operation/do_delete', '127.0.0.1', '本地', '2019-11-10 12:39:25', '');
INSERT INTO `dl_operation_log` VALUES (699, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-10 11:02:44', '');
INSERT INTO `dl_operation_log` VALUES (700, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-10 11:02:44', '');
INSERT INTO `dl_operation_log` VALUES (701, 1, 'Notice/system_edit', '127.0.0.1', '本地', '2019-11-10 12:12:07', '');
INSERT INTO `dl_operation_log` VALUES (702, 1, 'Notice/system_edit', '127.0.0.1', '本地', '2019-11-10 12:12:13', '');
INSERT INTO `dl_operation_log` VALUES (703, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:35:11', '');
INSERT INTO `dl_operation_log` VALUES (704, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-11-10 12:35:20', '');
INSERT INTO `dl_operation_log` VALUES (705, 1, 'Operation/do_delete', '127.0.0.1', '本地', '2019-11-10 12:39:16', '');
INSERT INTO `dl_operation_log` VALUES (706, 1, 'Operation/do_delete', '127.0.0.1', '本地', '2019-11-10 12:39:22', '');
INSERT INTO `dl_operation_log` VALUES (771, 1, 'Rule/edit_group', '127.0.0.1', '本地', '2019-11-10 22:26:18', '');
INSERT INTO `dl_operation_log` VALUES (772, 1, 'Rule/edit_group', '127.0.0.1', '本地', '2019-11-10 22:26:23', '');
INSERT INTO `dl_operation_log` VALUES (773, 1, 'Member/del', '127.0.0.1', '本地', '2019-11-10 22:29:20', '');
INSERT INTO `dl_operation_log` VALUES (774, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 22:44:29', '');
INSERT INTO `dl_operation_log` VALUES (775, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-10 23:00:37', '');
INSERT INTO `dl_operation_log` VALUES (776, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-11 00:56:56', '');
INSERT INTO `dl_operation_log` VALUES (777, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-12 11:08:09', '');
INSERT INTO `dl_operation_log` VALUES (778, 1, 'Cate/edit', '127.0.0.1', '本地', '2019-11-12 11:08:44', '');
INSERT INTO `dl_operation_log` VALUES (779, 1, 'Cate/edit', '127.0.0.1', '本地', '2019-11-12 11:10:55', '');
INSERT INTO `dl_operation_log` VALUES (780, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:53:59', '');
INSERT INTO `dl_operation_log` VALUES (781, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:54:05', '');
INSERT INTO `dl_operation_log` VALUES (782, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:54:11', '');
INSERT INTO `dl_operation_log` VALUES (783, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:54:16', '');
INSERT INTO `dl_operation_log` VALUES (784, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:55:25', '');
INSERT INTO `dl_operation_log` VALUES (785, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:55:30', '');
INSERT INTO `dl_operation_log` VALUES (786, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:55:34', '');
INSERT INTO `dl_operation_log` VALUES (787, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:55:39', '');
INSERT INTO `dl_operation_log` VALUES (788, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:55:45', '');
INSERT INTO `dl_operation_log` VALUES (789, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:55:49', '');
INSERT INTO `dl_operation_log` VALUES (790, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:55:54', '');
INSERT INTO `dl_operation_log` VALUES (791, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:55:59', '');
INSERT INTO `dl_operation_log` VALUES (792, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:56:07', '');
INSERT INTO `dl_operation_log` VALUES (793, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:56:12', '');
INSERT INTO `dl_operation_log` VALUES (794, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:56:16', '');
INSERT INTO `dl_operation_log` VALUES (795, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:56:20', '');
INSERT INTO `dl_operation_log` VALUES (796, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 14:56:24', '');
INSERT INTO `dl_operation_log` VALUES (797, 1, 'Cate/edit', '127.0.0.1', '本地', '2019-11-12 15:00:37', '');
INSERT INTO `dl_operation_log` VALUES (798, 1, 'Cate/edit', '127.0.0.1', '本地', '2019-11-12 15:01:13', '');
INSERT INTO `dl_operation_log` VALUES (799, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 15:02:15', '');
INSERT INTO `dl_operation_log` VALUES (800, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 15:02:18', '');
INSERT INTO `dl_operation_log` VALUES (801, 1, 'Cate/delete', '127.0.0.1', '本地', '2019-11-12 15:02:22', '');
INSERT INTO `dl_operation_log` VALUES (802, 1, 'Advertise/edit', '127.0.0.1', '本地', '2019-11-13 00:58:59', '');
INSERT INTO `dl_operation_log` VALUES (803, 1, 'Operation/qrcode_add', '127.0.0.1', '本地', '2019-11-13 15:03:53', '');
INSERT INTO `dl_operation_log` VALUES (804, 1, 'Operation/qrcode_add', '127.0.0.1', '本地', '2019-11-13 15:04:41', '');
INSERT INTO `dl_operation_log` VALUES (805, 1, 'Advertise/add', '127.0.0.1', '本地', '2019-11-13 15:05:36', '');
INSERT INTO `dl_operation_log` VALUES (806, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-11-13 21:14:34', '');
INSERT INTO `dl_operation_log` VALUES (807, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-11-13 21:16:06', '');
INSERT INTO `dl_operation_log` VALUES (808, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-11-13 21:16:07', '');
INSERT INTO `dl_operation_log` VALUES (809, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-11-13 21:17:54', '');
INSERT INTO `dl_operation_log` VALUES (810, 1, 'Nav/add', '127.0.0.1', '本地', '2019-11-13 22:35:01', '');
INSERT INTO `dl_operation_log` VALUES (811, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-11-26 11:25:07', '');
INSERT INTO `dl_operation_log` VALUES (812, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-11-26 11:25:15', '');
INSERT INTO `dl_operation_log` VALUES (813, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-11-26 11:25:50', '');
INSERT INTO `dl_operation_log` VALUES (814, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-26 11:26:32', '');
INSERT INTO `dl_operation_log` VALUES (815, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-11-26 11:26:41', '');
INSERT INTO `dl_operation_log` VALUES (816, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-26 12:25:59', '');
INSERT INTO `dl_operation_log` VALUES (817, 1, 'Member/add', '127.0.0.1', '本地', '2019-11-26 12:26:00', '');
INSERT INTO `dl_operation_log` VALUES (818, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-12-18 22:11:22', '');
INSERT INTO `dl_operation_log` VALUES (819, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-12-18 22:11:30', '');
INSERT INTO `dl_operation_log` VALUES (820, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-12-18 22:15:12', '');
INSERT INTO `dl_operation_log` VALUES (821, 1, 'Operation/edit', '127.0.0.1', '本地', '2019-12-18 22:15:19', '');
INSERT INTO `dl_operation_log` VALUES (822, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-12-27 12:59:30', '');
INSERT INTO `dl_operation_log` VALUES (823, 1, 'Nav/edit', '127.0.0.1', '本地', '2019-12-27 13:16:00', '');
INSERT INTO `dl_operation_log` VALUES (824, 1, 'Cate/edit', '127.0.0.1', '本地', '2019-12-29 23:10:27', '');
INSERT INTO `dl_operation_log` VALUES (825, 1, 'Cate/edit', '127.0.0.1', '本地', '2019-12-29 23:10:34', '');
INSERT INTO `dl_operation_log` VALUES (826, 1, 'Cate/edit', '127.0.0.1', '本地', '2019-12-29 23:10:47', '');
INSERT INTO `dl_operation_log` VALUES (827, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-30 23:43:42', '');
INSERT INTO `dl_operation_log` VALUES (828, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 00:08:09', '');
INSERT INTO `dl_operation_log` VALUES (829, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 00:08:21', '');
INSERT INTO `dl_operation_log` VALUES (830, 1, 'Article/add', '127.0.0.1', '本地', '2019-12-31 00:24:14', '');
INSERT INTO `dl_operation_log` VALUES (831, 1, 'Article/add', '127.0.0.1', '本地', '2019-12-31 00:24:16', '');
INSERT INTO `dl_operation_log` VALUES (832, 1, 'Article/add', '127.0.0.1', '本地', '2019-12-31 00:26:03', '');
INSERT INTO `dl_operation_log` VALUES (833, 1, 'Article/add', '127.0.0.1', '本地', '2019-12-31 00:26:04', '');
INSERT INTO `dl_operation_log` VALUES (834, 1, 'Member/edit', '127.0.0.1', '本地', '2019-12-31 00:33:32', '');
INSERT INTO `dl_operation_log` VALUES (835, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 00:35:47', '');
INSERT INTO `dl_operation_log` VALUES (836, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 00:35:47', '');
INSERT INTO `dl_operation_log` VALUES (837, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 10:50:07', '');
INSERT INTO `dl_operation_log` VALUES (838, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 10:50:07', '');
INSERT INTO `dl_operation_log` VALUES (839, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 10:50:14', '');
INSERT INTO `dl_operation_log` VALUES (840, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 11:06:38', '');
INSERT INTO `dl_operation_log` VALUES (841, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 11:06:38', '');
INSERT INTO `dl_operation_log` VALUES (842, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:05:48', '');
INSERT INTO `dl_operation_log` VALUES (843, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:05:49', '');
INSERT INTO `dl_operation_log` VALUES (844, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-12-31 21:15:24', '');
INSERT INTO `dl_operation_log` VALUES (845, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-12-31 21:15:29', '');
INSERT INTO `dl_operation_log` VALUES (846, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-12-31 21:15:35', '');
INSERT INTO `dl_operation_log` VALUES (847, 1, 'Nav/delete', '127.0.0.1', '本地', '2019-12-31 21:15:41', '');
INSERT INTO `dl_operation_log` VALUES (848, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:30:52', '');
INSERT INTO `dl_operation_log` VALUES (849, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:30:52', '');
INSERT INTO `dl_operation_log` VALUES (850, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:46:54', '');
INSERT INTO `dl_operation_log` VALUES (851, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:46:54', '');
INSERT INTO `dl_operation_log` VALUES (852, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:48:12', '');
INSERT INTO `dl_operation_log` VALUES (853, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:48:13', '');
INSERT INTO `dl_operation_log` VALUES (854, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:48:36', '');
INSERT INTO `dl_operation_log` VALUES (855, 1, 'Member/edit', '127.0.0.1', '本地', '2019-12-31 21:50:31', '');
INSERT INTO `dl_operation_log` VALUES (856, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:53:05', '');
INSERT INTO `dl_operation_log` VALUES (857, 1, 'Member/add', '127.0.0.1', '本地', '2019-12-31 21:53:06', '');
INSERT INTO `dl_operation_log` VALUES (858, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 22:29:49', '');
INSERT INTO `dl_operation_log` VALUES (859, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 22:32:48', '');
INSERT INTO `dl_operation_log` VALUES (860, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 22:53:44', '');
INSERT INTO `dl_operation_log` VALUES (861, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 22:53:58', '');
INSERT INTO `dl_operation_log` VALUES (862, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 22:55:05', '');
INSERT INTO `dl_operation_log` VALUES (863, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 23:00:36', '');
INSERT INTO `dl_operation_log` VALUES (864, 1, 'Article/edit', '127.0.0.1', '本地', '2019-12-31 23:25:44', '');

-- ----------------------------
-- Table structure for dl_right
-- ----------------------------
DROP TABLE IF EXISTS `dl_right`;
CREATE TABLE `dl_right`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `act` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法',
  `control` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制器',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 86 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_right
-- ----------------------------
INSERT INTO `dl_right` VALUES (1, '控制台', 0, 'fa-flag', 'index', 'index', 1, '2017-11-09 14:28:10', 0);
INSERT INTO `dl_right` VALUES (3, '用户管理', 0, 'fa-frown-o', 'index', 'member', 1, '2017-11-09 14:29:37', 2);
INSERT INTO `dl_right` VALUES (4, '用户信息', 3, '', 'index', 'member', 1, '2017-11-09 14:30:05', 0);
INSERT INTO `dl_right` VALUES (7, '权限管理', 0, 'fa-lock', 'index', 'rule', 1, '2017-11-09 14:29:37', 7);
INSERT INTO `dl_right` VALUES (8, '权限管理', 7, '', 'index', 'rule', 1, '2017-11-09 14:29:37', 0);
INSERT INTO `dl_right` VALUES (9, '用户组管理', 7, '', 'group', 'rule', 1, '2017-11-09 14:29:37', 0);
INSERT INTO `dl_right` VALUES (10, '管理员列表', 7, '', 'admin_user_list', 'rule', 1, '2017-11-09 14:29:37', 0);
INSERT INTO `dl_right` VALUES (11, '设置中心', 0, 'fa-cog', 'showlist', 'operation', 1, '2017-11-09 14:29:37', 1);
INSERT INTO `dl_right` VALUES (12, '参数设置', 11, '', 'index', 'operation', 1, '2017-11-09 14:29:37', 0);
INSERT INTO `dl_right` VALUES (13, '菜单管理', 0, 'fa-cloud', 'index', 'nav', 1, '2017-11-09 14:29:37', 8);
INSERT INTO `dl_right` VALUES (15, '内容管理', 0, 'fa-magnet', 'index', 'cate', 1, '2017-11-22 07:02:34', 2);
INSERT INTO `dl_right` VALUES (17, '栏目管理', 15, '', 'index', 'cate', 1, '2017-11-23 02:29:24', 0);
INSERT INTO `dl_right` VALUES (18, '菜单设置', 13, '', 'index', 'nav', 1, '2017-11-23 15:11:59', 0);
INSERT INTO `dl_right` VALUES (26, '广告管理', 0, 'fa-picture-o', 'index', 'advertise', 1, '2017-11-25 06:30:00', 9);
INSERT INTO `dl_right` VALUES (27, '广告设置', 26, '', 'index', 'advertise', 1, '2017-11-25 06:30:50', 0);
INSERT INTO `dl_right` VALUES (28, '消息管理', 0, 'fa-bullhorn', 'index', 'notice', 1, '2017-11-25 06:31:58', 6);
INSERT INTO `dl_right` VALUES (30, '系统公告', 28, '', 'system', 'notice', 1, '2017-11-25 06:34:44', 0);
INSERT INTO `dl_right` VALUES (33, '操作记录', 11, '', 'showlist', 'operation', 1, '2017-11-29 06:22:30', 0);
INSERT INTO `dl_right` VALUES (85, '文章管理', 15, '', 'index', 'article', 1, '2019-11-13 22:35:01', 0);
INSERT INTO `dl_right` VALUES (42, '清理数据', 11, '', 'sc_show', 'operation', 1, '2017-12-13 09:26:30', 0);

-- ----------------------------
-- Table structure for dl_setting
-- ----------------------------
DROP TABLE IF EXISTS `dl_setting`;
CREATE TABLE `dl_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '0关闭1开启',
  `value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '0关闭1开启',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `key`(`key`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_setting
-- ----------------------------
INSERT INTO `dl_setting` VALUES (7, 'name', '管理系统');
INSERT INTO `dl_setting` VALUES (8, 'seotitle', '管理系统');
INSERT INTO `dl_setting` VALUES (9, 'keyword', '管理系统');
INSERT INTO `dl_setting` VALUES (10, 'desc', '管理系统');
INSERT INTO `dl_setting` VALUES (11, 'close', '1');
INSERT INTO `dl_setting` VALUES (12, 'redisclose', '1');
INSERT INTO `dl_setting` VALUES (13, 'redishost', '11');
INSERT INTO `dl_setting` VALUES (14, 'redisport', '22');
INSERT INTO `dl_setting` VALUES (15, 'redispass', '33');

-- ----------------------------
-- Table structure for dl_sys_msg
-- ----------------------------
DROP TABLE IF EXISTS `dl_sys_msg`;
CREATE TABLE `dl_sys_msg`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `sys_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '链接地址',
  `his_name_is_seth_rich` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统公告' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dl_user
-- ----------------------------
DROP TABLE IF EXISTS `dl_user`;
CREATE TABLE `dl_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '用户名',
  `money` decimal(10, 3) NOT NULL DEFAULT 0.000 COMMENT '代理余额',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '密码',
  `role` tinyint(1) DEFAULT 0 COMMENT '角色',
  `lg_ip` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '最后登入ip',
  `lg_time` int(11) DEFAULT 0 COMMENT '最后登入时间',
  `stime` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0禁用1使用',
  `identity` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1为管理员2为代理',
  `hand_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '盘口',
  `back_percent` decimal(10, 3) NOT NULL DEFAULT 0.000 COMMENT '抽成比例',
  `up_id` int(11) NOT NULL DEFAULT 0 COMMENT '上级id',
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '代理的令牌用户注册时候添加即为改代理的用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dl_user
-- ----------------------------
INSERT INTO `dl_user` VALUES (1, 'admin', 0.000, 'e10adc3949ba59abbe56e057f20f883e', 0, '127.0.0.1', 1576678235, 1504232368, 1, 1, '1', 0.000, 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
