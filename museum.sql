-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-03-18 04:03:49
-- 服务器版本： 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `museum`
--
CREATE DATABASE IF NOT EXISTS `museum` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `museum`;

-- --------------------------------------------------------

--
-- 表的结构 `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `loginname` varchar(20) NOT NULL COMMENT '登录名',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `role` tinyint(1) NOT NULL COMMENT '角色，0为超级管理员，1为普通管理员',
  `register_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0为正常，1为停用',
  `avatar` varchar(255) NOT NULL COMMENT '头像地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';

--
-- 表的关联 `admin`:
--

--
-- 转存表中的数据 `admin`
--

INSERT INTO `admin` (`id`, `loginname`, `nickname`, `password`, `phone`, `email`, `role`, `register_time`, `status`, `avatar`) VALUES
(1, 'admin', '我是超级管理员', 'fe386210f3e642fe7ae8931bbede6fa9', '18811080655', 'buctcs1504@163.com', 0, '2018-03-18 10:34:31', 0, ''),
(2, 'wyh', '王永红', 'fe386210f3e642fe7ae8931bbede6fa9', '17600230655', '17600230655@163.com', 1, '2018-03-18 10:36:01', 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `audio`
--

DROP TABLE IF EXISTS `audio`;
CREATE TABLE `audio` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `musemu_id` bigint(20) NOT NULL COMMENT '博物馆id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未审核，1审核通过，2审核未通过',
  `upload_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `pass_time` datetime DEFAULT NULL COMMENT '审核通过时间',
  `addr` varchar(255) NOT NULL COMMENT '地址',
  `description` text NOT NULL COMMENT '描述',
  `totext` text COMMENT '转文本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='讲解音频数据表';

--
-- 表的关联 `audio`:
--   `user_id`
--       `user` -> `id`
--   `musemu_id`
--       `museum` -> `id`
--

--
-- 转存表中的数据 `audio`
--

INSERT INTO `audio` (`id`, `user_id`, `musemu_id`, `status`, `upload_time`, `pass_time`, `addr`, `description`, `totext`) VALUES
(1, 1, 1, 0, '2018-03-18 10:50:30', NULL, 'http://p4buh8sqx.bkt.clouddn.com/%E8%B5%B5%E9%9B%B7-%E6%88%90%E9%83%BD%20%28Live%29.mp3', '测试数据，这里放了一首歌的链接', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL,
  `coption` tinyint(1) NOT NULL COMMENT '1为评论博物馆，2为评论展览，3为评论新闻，4为评论讲解',
  `museum_id` bigint(20) DEFAULT NULL,
  `exhibition_id` bigint(20) DEFAULT NULL,
  `news_id` bigint(20) DEFAULT NULL,
  `audio_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL COMMENT '用户',
  `user_ip` varchar(255) NOT NULL COMMENT '记录评论者ip',
  `time` datetime NOT NULL COMMENT '评论时间',
  `content` text NOT NULL COMMENT '评论正文',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '评论状态，0为正常，1为关闭',
  `parent` bigint(20) DEFAULT NULL COMMENT '父级评论'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

--
-- 表的关联 `comment`:
--   `user_id`
--       `user` -> `id`
--   `parent`
--       `comment` -> `id`
--   `museum_id`
--       `museum` -> `id`
--   `exhibition_id`
--       `exhibition` -> `id`
--   `news_id`
--       `news` -> `id`
--   `audio_id`
--       `audio` -> `id`
--

-- --------------------------------------------------------

--
-- 表的结构 `exhibition`
--

DROP TABLE IF EXISTS `exhibition`;
CREATE TABLE `exhibition` (
  `id` bigint(20) NOT NULL,
  `musemu_id` bigint(20) NOT NULL COMMENT '博物馆id',
  `name` varchar(255) NOT NULL COMMENT '展览名称',
  `time` text COMMENT '展览时间',
  `address` text COMMENT '展览地点',
  `introduce` text COMMENT '展览介绍'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='展览表';

--
-- 表的关联 `exhibition`:
--   `musemu_id`
--       `museum` -> `id`
--

-- --------------------------------------------------------

--
-- 表的结构 `logs`
--

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `id` bigint(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  `operator` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

--
-- 表的关联 `logs`:
--   `operator`
--       `admin` -> `id`
--

-- --------------------------------------------------------

--
-- 表的结构 `museum`
--

DROP TABLE IF EXISTS `museum`;
CREATE TABLE `museum` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '博物馆名',
  `introduce` text COMMENT '基本介绍',
  `open_time` text COMMENT '开放时间',
  `edu_activity` text COMMENT '教育活动',
  `collection` text COMMENT '经典藏品信息',
  `academic` text COMMENT '学术研究信息',
  `lng` double(10,6) DEFAULT NULL COMMENT '经度',
  `lat` double(10,6) DEFAULT NULL COMMENT '纬度'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='博物馆表';

--
-- 表的关联 `museum`:
--

--
-- 转存表中的数据 `museum`
--

INSERT INTO `museum` (`id`, `name`, `introduce`, `open_time`, `edu_activity`, `collection`, `academic`, `lng`, `lat`) VALUES
(1, '测试中国国家博物馆1', '这是测试数据', '这是测试数据8：00-20：00', '', '', '', 0.000000, 0.000000),
(2, '测试中国国家博物馆', '这是测试数据', '8：00-20：00', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '新闻标题',
  `author` varchar(255) DEFAULT NULL COMMENT '作者',
  `release_time` datetime NOT NULL COMMENT '发布时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `excerpt` text COMMENT '摘要',
  `content` text NOT NULL COMMENT '新闻正文',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '新闻状态，0为默认的正常状态',
  `nature` tinyint(1) DEFAULT NULL COMMENT '0正面，1负面',
  `comment_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0可以评论，1不可以评论'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻表';

--
-- 表的关联 `news`:
--

-- --------------------------------------------------------

--
-- 表的结构 `news_relationships`
--

DROP TABLE IF EXISTS `news_relationships`;
CREATE TABLE `news_relationships` (
  `news_id` bigint(20) NOT NULL,
  `museum_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻与博物馆关系表';

--
-- 表的关联 `news_relationships`:
--   `news_id`
--       `news` -> `id`
--   `museum_id`
--       `museum` -> `id`
--

-- --------------------------------------------------------

--
-- 表的结构 `options`
--

DROP TABLE IF EXISTS `options`;
CREATE TABLE `options` (
  `id` bigint(20) NOT NULL,
  `option_name` varchar(255) NOT NULL,
  `option_value` varchar(255) NOT NULL,
  `autoload` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0为自动加载'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置选项';

--
-- 表的关联 `options`:
--

-- --------------------------------------------------------

--
-- 表的结构 `star`
--

DROP TABLE IF EXISTS `star`;
CREATE TABLE `star` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `comment_id` bigint(20) DEFAULT NULL COMMENT '评论id',
  `musemu_id` bigint(20) NOT NULL COMMENT '博物馆id',
  `exhibition_star` tinyint(1) NOT NULL COMMENT '展览分数',
  `service_star` tinyint(1) NOT NULL COMMENT '服务分数',
  `environment_star` tinyint(1) NOT NULL COMMENT '环境分数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='博物馆打分表';

--
-- 表的关联 `star`:
--   `user_id`
--       `user` -> `id`
--   `musemu_id`
--       `museum` -> `id`
--   `comment_id`
--       `comment` -> `id`
--

-- --------------------------------------------------------

--
-- 表的结构 `taxonomy`
--

DROP TABLE IF EXISTS `taxonomy`;
CREATE TABLE `taxonomy` (
  `id` bigint(20) NOT NULL,
  `taxonomy` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `parent` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类表';

--
-- 表的关联 `taxonomy`:
--   `parent`
--       `taxonomy` -> `id`
--

-- --------------------------------------------------------

--
-- 表的结构 `term_relationships`
--

DROP TABLE IF EXISTS `term_relationships`;
CREATE TABLE `term_relationships` (
  `news_id` bigint(20) NOT NULL,
  `taxonomy_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻分类表';

--
-- 表的关联 `term_relationships`:
--   `taxonomy_id`
--       `taxonomy` -> `id`
--   `news_id`
--       `news` -> `id`
--

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `loginname` varchar(20) NOT NULL COMMENT ' 登录名',
  `nickname` varchar(255) NOT NULL COMMENT '昵称',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(11) DEFAULT NULL COMMENT 'qq',
  `wechat` varchar(255) DEFAULT NULL COMMENT '微信',
  `register_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `avatar` varchar(255) NOT NULL COMMENT '头像地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

--
-- 表的关联 `user`:
--

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `loginname`, `nickname`, `password`, `phone`, `email`, `qq`, `wechat`, `register_time`, `status`, `avatar`) VALUES
(1, 'buctcs1504', '计科1504', 'fe386210f3e642fe7ae8931bbede6fa9', '', '', '', '', '2018-03-18 10:40:57', 0, ''),
(7, 'wyh0655', ' 王同学', 'fe386210f3e642fe7ae8931bbede6fa9', NULL, NULL, NULL, NULL, '2018-03-18 10:44:13', 0, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `loginname` (`loginname`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `nickname` (`nickname`),
  ADD KEY `register_time` (`register_time`);

--
-- Indexes for table `audio`
--
ALTER TABLE `audio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `musemu_id` (`musemu_id`);
ALTER TABLE `audio` ADD FULLTEXT KEY `description` (`description`);
ALTER TABLE `audio` ADD FULLTEXT KEY `totext` (`totext`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `parent` (`parent`),
  ADD KEY `museum_id` (`museum_id`),
  ADD KEY `exhibition_id` (`exhibition_id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `audio_id` (`audio_id`);

--
-- Indexes for table `exhibition`
--
ALTER TABLE `exhibition`
  ADD PRIMARY KEY (`id`),
  ADD KEY `musemu_id` (`musemu_id`),
  ADD KEY `name` (`name`);
ALTER TABLE `exhibition` ADD FULLTEXT KEY `time` (`time`);
ALTER TABLE `exhibition` ADD FULLTEXT KEY `address` (`address`);
ALTER TABLE `exhibition` ADD FULLTEXT KEY `introduce` (`introduce`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `operator` (`operator`);

--
-- Indexes for table `museum`
--
ALTER TABLE `museum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `lng` (`lng`),
  ADD KEY `lat` (`lat`);
ALTER TABLE `museum` ADD FULLTEXT KEY `introduce` (`introduce`);
ALTER TABLE `museum` ADD FULLTEXT KEY `open_time` (`open_time`);
ALTER TABLE `museum` ADD FULLTEXT KEY `edu_activity` (`edu_activity`);
ALTER TABLE `museum` ADD FULLTEXT KEY `collection` (`collection`);
ALTER TABLE `museum` ADD FULLTEXT KEY `academic` (`academic`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `title` (`title`),
  ADD KEY `author` (`author`);
ALTER TABLE `news` ADD FULLTEXT KEY `excerpt` (`excerpt`);
ALTER TABLE `news` ADD FULLTEXT KEY `content` (`content`);

--
-- Indexes for table `news_relationships`
--
ALTER TABLE `news_relationships`
  ADD KEY `news_id` (`news_id`),
  ADD KEY `museum_id` (`museum_id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `star`
--
ALTER TABLE `star`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `musemu_id` (`musemu_id`);

--
-- Indexes for table `taxonomy`
--
ALTER TABLE `taxonomy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent` (`parent`);

--
-- Indexes for table `term_relationships`
--
ALTER TABLE `term_relationships`
  ADD KEY `news_id` (`news_id`),
  ADD KEY `taxonomy_id` (`taxonomy_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `loginname` (`loginname`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `wechat` (`wechat`),
  ADD UNIQUE KEY `qq` (`qq`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `nickname` (`nickname`),
  ADD KEY `register_time` (`register_time`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `admin`
--
ALTER TABLE `admin`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `audio`
--
ALTER TABLE `audio`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `exhibition`
--
ALTER TABLE `exhibition`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `logs`
--
ALTER TABLE `logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `museum`
--
ALTER TABLE `museum`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `options`
--
ALTER TABLE `options`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `star`
--
ALTER TABLE `star`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `taxonomy`
--
ALTER TABLE `taxonomy`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=8;
--
-- 限制导出的表
--

--
-- 限制表 `audio`
--
ALTER TABLE `audio`
  ADD CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `audio_ibfk_1` FOREIGN KEY (`musemu_id`) REFERENCES `museum` (`id`);

--
-- 限制表 `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`parent`) REFERENCES `comment` (`id`),
  ADD CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`museum_id`) REFERENCES `museum` (`id`),
  ADD CONSTRAINT `comment_ibfk_4` FOREIGN KEY (`exhibition_id`) REFERENCES `exhibition` (`id`),
  ADD CONSTRAINT `comment_ibfk_5` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`),
  ADD CONSTRAINT `comment_ibfk_6` FOREIGN KEY (`audio_id`) REFERENCES `audio` (`id`);

--
-- 限制表 `exhibition`
--
ALTER TABLE `exhibition`
  ADD CONSTRAINT `exhibition_ibfk_1` FOREIGN KEY (`musemu_id`) REFERENCES `museum` (`id`);

--
-- 限制表 `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`operator`) REFERENCES `admin` (`id`);

--
-- 限制表 `news_relationships`
--
ALTER TABLE `news_relationships`
  ADD CONSTRAINT `news_relationships_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`),
  ADD CONSTRAINT `news_relationships_ibfk_2` FOREIGN KEY (`museum_id`) REFERENCES `museum` (`id`);

--
-- 限制表 `star`
--
ALTER TABLE `star`
  ADD CONSTRAINT `star_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `star_ibfk_2` FOREIGN KEY (`musemu_id`) REFERENCES `museum` (`id`),
  ADD CONSTRAINT `star_ibfk_3` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`);

--
-- 限制表 `taxonomy`
--
ALTER TABLE `taxonomy`
  ADD CONSTRAINT `taxonomy_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `taxonomy` (`id`);

--
-- 限制表 `term_relationships`
--
ALTER TABLE `term_relationships`
  ADD CONSTRAINT `term_relationships_ibfk_1` FOREIGN KEY (`taxonomy_id`) REFERENCES `taxonomy` (`id`),
  ADD CONSTRAINT `term_relationships_ibfk_2` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
