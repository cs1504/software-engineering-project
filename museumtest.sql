-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-05-10 03:17:12
-- 服务器版本： 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `museumtest`
--
CREATE DATABASE IF NOT EXISTS `museumtest` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `museumtest`;

-- --------------------------------------------------------

--
-- 表的结构 `admin`
--

CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `loginname` varchar(20) NOT NULL COMMENT '登录名',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `role` tinyint(1) NOT NULL COMMENT '角色，0为超级管理员，1为普通管理员',
  `register_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0为正常，1为停用',
  `avatar` varchar(255) NOT NULL COMMENT '头像地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- --------------------------------------------------------

--
-- 表的结构 `audio`
--

CREATE TABLE `audio` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `museum_id` bigint(20) NOT NULL COMMENT '博物馆id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未审核，1审核通过，2审核未通过',
  `upload_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `pass_time` datetime DEFAULT NULL COMMENT '审核通过时间',
  `addr` varchar(255) NOT NULL COMMENT '地址',
  `description` text NOT NULL COMMENT '描述',
  `totext` text COMMENT '转文本',
  `taskId` varchar(255) DEFAULT NULL,
  `dataId` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `labeltext` varchar(255) DEFAULT NULL,
  `suggestion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='讲解音频数据表';

-- --------------------------------------------------------

--
-- 表的结构 `comment`
--

CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL,
  `coption` tinyint(1) NOT NULL COMMENT '1为评论博物馆，2为评论展览，3为评论新闻，4为评论讲解',
  `museum_id` bigint(20) DEFAULT NULL,
  `exhibition_id` bigint(20) DEFAULT NULL,
  `news_id` bigint(20) DEFAULT NULL,
  `audio_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL COMMENT '用户',
  `user_ip` varchar(255) NOT NULL COMMENT '记录评论者ip',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  `content` text NOT NULL COMMENT '评论正文',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '评论状态，0为正常，1为关闭',
  `parent` bigint(20) DEFAULT NULL COMMENT '父级评论'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- --------------------------------------------------------

--
-- 表的结构 `exhibition`
--

CREATE TABLE `exhibition` (
  `id` bigint(20) NOT NULL,
  `museum_id` bigint(20) NOT NULL COMMENT '博物馆id',
  `name` varchar(255) NOT NULL COMMENT '展览名称',
  `time` text COMMENT '展览时间',
  `address` text COMMENT '展览地点',
  `introduce` text COMMENT '展览介绍'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='展览表';

-- --------------------------------------------------------

--
-- 表的结构 `exhibits`
--

CREATE TABLE `exhibits` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `museum_id` bigint(20) NOT NULL,
  `introduce` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `logs`
--

CREATE TABLE `logs` (
  `id` bigint(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  `operator` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `operate_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

-- --------------------------------------------------------

--
-- 表的结构 `museum`
--

CREATE TABLE `museum` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '博物馆名',
  `introduce` text COMMENT '基本介绍',
  `open_time` text COMMENT '开放时间',
  `edu_activity` text COMMENT '教育活动',
  `collection` text COMMENT '经典藏品信息',
  `academic` text COMMENT '学术研究信息',
  `lng` double(10,6) DEFAULT NULL COMMENT '经度',
  `lat` double(10,6) DEFAULT NULL COMMENT '纬度',
  `city` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='博物馆表';

-- --------------------------------------------------------

--
-- 表的结构 `news`
--

CREATE TABLE `news` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '新闻标题',
  `titleindex` text COMMENT 'title全文索引',
  `author` varchar(255) DEFAULT NULL COMMENT '作者',
  `release_time` datetime NOT NULL COMMENT '发布时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `excerpt` text COMMENT '摘要',
  `excerptindex` text,
  `content` longtext COMMENT '新闻正文',
  `contentindex` text,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '新闻状态，0为默认的正常状态',
  `nature` tinyint(1) DEFAULT NULL COMMENT '0正面，1负面',
  `comment_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0可以评论，1不可以评论',
  `url` varchar(255) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='新闻表';

-- --------------------------------------------------------

--
-- 表的结构 `news_relationships`
--

CREATE TABLE `news_relationships` (
  `news_id` bigint(20) NOT NULL,
  `museum_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻与博物馆关系表';

-- --------------------------------------------------------

--
-- 表的结构 `options`
--

CREATE TABLE `options` (
  `id` bigint(20) NOT NULL,
  `option_name` varchar(255) NOT NULL,
  `option_value` varchar(255) NOT NULL,
  `autoload` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0为自动加载'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置选项';

-- --------------------------------------------------------

--
-- 表的结构 `star`
--

CREATE TABLE `star` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `comment_id` bigint(20) DEFAULT NULL COMMENT '评论id',
  `museum_id` bigint(20) NOT NULL COMMENT '博物馆id',
  `exhibition_star` tinyint(1) NOT NULL COMMENT '展览分数',
  `service_star` tinyint(1) NOT NULL COMMENT '服务分数',
  `environment_star` tinyint(1) NOT NULL COMMENT '环境分数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='博物馆打分表';

-- --------------------------------------------------------

--
-- 表的结构 `taxonomy`
--

CREATE TABLE `taxonomy` (
  `id` bigint(20) NOT NULL,
  `taxonomy` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `parent` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类表';

-- --------------------------------------------------------

--
-- 表的结构 `term_relationships`
--

CREATE TABLE `term_relationships` (
  `news_id` bigint(20) NOT NULL,
  `taxonomy_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻分类表';

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `loginname` varchar(20) NOT NULL COMMENT ' 登录名',
  `nickname` varchar(255) NOT NULL COMMENT '昵称',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(11) DEFAULT NULL COMMENT 'qq',
  `wechat` varchar(255) DEFAULT NULL COMMENT '微信',
  `register_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `avatar` varchar(255) DEFAULT 'https://i.loli.net/2018/04/01/5ac0c4b6f28c2.png' COMMENT '头像地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

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
  ADD KEY `musemu_id` (`museum_id`);

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
  ADD KEY `musemu_id` (`museum_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `exhibits`
--
ALTER TABLE `exhibits`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `lat` (`lat`),
  ADD KEY `city` (`city`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author` (`author`);
ALTER TABLE `news` ADD FULLTEXT KEY `titleindex` (`titleindex`);
ALTER TABLE `news` ADD FULLTEXT KEY `excerptindex` (`excerptindex`);
ALTER TABLE `news` ADD FULLTEXT KEY `commentindex` (`contentindex`);
ALTER TABLE `news` ADD FULLTEXT KEY `titleindex_2` (`titleindex`,`excerptindex`,`contentindex`);

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
  ADD KEY `musemu_id` (`museum_id`);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=5;
--
-- 使用表AUTO_INCREMENT `audio`
--
ALTER TABLE `audio`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=7;
--
-- 使用表AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- 使用表AUTO_INCREMENT `exhibition`
--
ALTER TABLE `exhibition`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- 使用表AUTO_INCREMENT `exhibits`
--
ALTER TABLE `exhibits`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `logs`
--
ALTER TABLE `logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;
--
-- 使用表AUTO_INCREMENT `museum`
--
ALTER TABLE `museum`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=426;
--
-- 使用表AUTO_INCREMENT `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;
--
-- 使用表AUTO_INCREMENT `options`
--
ALTER TABLE `options`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- 使用表AUTO_INCREMENT `star`
--
ALTER TABLE `star`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `taxonomy`
--
ALTER TABLE `taxonomy`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=18;
--
-- 限制导出的表
--

--
-- 限制表 `audio`
--
ALTER TABLE `audio`
  ADD CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- 限制表 `exhibition`
--
ALTER TABLE `exhibition`
  ADD CONSTRAINT `exhibition_ibfk_1` FOREIGN KEY (`museum_id`) REFERENCES `museum` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
