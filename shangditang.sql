/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50713
Source Host           : localhost:3306
Source Database       : shangditang

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2018-03-09 21:40:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for church_parish
-- ----------------------------
DROP TABLE IF EXISTS `church_parish`;
CREATE TABLE `church_parish` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '分堂名',
  `status` int(4) NOT NULL COMMENT '1、启用 2、禁用 -1、删除',
  `address` varchar(10) DEFAULT NULL COMMENT '地址',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of church_parish
-- ----------------------------
INSERT INTO `church_parish` VALUES ('1', '测试哈哈', '1', '北京哈哈', null, '2017-07-08 16:25:04', '2017-07-08 16:25:06');
INSERT INTO `church_parish` VALUES ('2', '踩踩踩踩', '1', '世界好大', '11111', '2017-07-08 16:25:04', '2017-11-03 13:58:37');

-- ----------------------------
-- Table structure for church_parish_lesson
-- ----------------------------
DROP TABLE IF EXISTS `church_parish_lesson`;
CREATE TABLE `church_parish_lesson` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT,
  `status` int(4) NOT NULL COMMENT '1、启用 2、禁用 -1、删除',
  `parish_id` bigint(18) NOT NULL DEFAULT '0' COMMENT '堂点id',
  `worship_date` datetime NOT NULL COMMENT '敬拜日期',
  `start` datetime DEFAULT NULL COMMENT '开始时间',
  `end` datetime DEFAULT NULL COMMENT '结束时间',
  `teacher` varchar(50) DEFAULT '' COMMENT '讲师',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of church_parish_lesson
-- ----------------------------
INSERT INTO `church_parish_lesson` VALUES ('1', '1', '1', '2017-01-01 00:00:00', '2017-01-01 09:00:00', '2017-01-01 12:00:00', '', '2017-07-08 16:43:51', '2017-07-08 16:45:38');
INSERT INTO `church_parish_lesson` VALUES ('2', '1', '1', '2017-01-08 00:00:00', '2017-01-08 09:00:00', '2017-01-08 12:00:00', '', '2017-07-08 16:43:51', '2017-07-08 16:45:39');
INSERT INTO `church_parish_lesson` VALUES ('3', '1', '1', '2017-01-15 00:00:00', '2017-01-15 09:00:00', '2017-01-15 12:00:00', '', '2017-07-08 16:26:34', '2017-07-08 16:45:31');
INSERT INTO `church_parish_lesson` VALUES ('4', '1', '1', '2017-01-22 00:00:00', '2017-01-22 09:00:00', '2017-01-22 12:00:00', '', '2017-07-08 16:37:41', '2017-07-08 16:45:31');
INSERT INTO `church_parish_lesson` VALUES ('5', '1', '1', '2017-01-29 00:00:00', '2017-01-29 09:00:00', '2017-01-29 12:00:00', '', '2017-07-08 16:38:14', '2017-07-08 16:45:31');


-- ----------------------------
-- Table structure for church_people
-- ----------------------------
DROP TABLE IF EXISTS `church_people`;
CREATE TABLE `church_people` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '登陆用户名',
  `status` int(4) NOT NULL COMMENT '1、启用 2、禁用 -1、删除',
  `mobile` varchar(18) DEFAULT NULL COMMENT '手机号',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `sort` int(6) NOT NULL DEFAULT '0' COMMENT '排序',
  `head_portrait` mediumblob COMMENT '头像',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `parish_id` bigint(18) NOT NULL DEFAULT '0' COMMENT '分堂id',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `age_group` tinyint(4) DEFAULT '0' COMMENT '年龄段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `church_people_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of church_people
-- ----------------------------
INSERT INTO `church_people` VALUES ('22', '是是是', '1', '', 'male', null, '22', null, '', '1', '2017-07-08 16:28:50', '2017-07-08 16:57:02', '0');
INSERT INTO `church_people` VALUES ('86', '李连杰', '1', '', 'male', null, '1000', null, '', '1', '2017-12-16 21:49:01', '2017-12-16 21:49:01', '0');

-- ----------------------------
-- Table structure for pr_lesson_people
-- ----------------------------
DROP TABLE IF EXISTS `pr_lesson_people`;
CREATE TABLE `pr_lesson_people` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT,
  `status` int(4) NOT NULL COMMENT '1、启用 2、禁用 -1、删除',
  `lesson_id` bigint(18) NOT NULL DEFAULT '0' COMMENT '主日id',
  `people_id` bigint(18) NOT NULL DEFAULT '0' COMMENT '人员id',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pr_lesson_people
-- ----------------------------
INSERT INTO `pr_lesson_people` VALUES ('1', '1', '1', '1', '2017-07-08 16:48:20', '2017-07-08 16:48:20');
INSERT INTO `pr_lesson_people` VALUES ('2', '1', '1', '2', '2017-07-08 16:57:44', '2017-07-08 16:57:44');

