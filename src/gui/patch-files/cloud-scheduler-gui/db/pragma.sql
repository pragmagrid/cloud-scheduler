-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2017 at 12:44 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pragma`
--

-- --------------------------------------------------------

--
-- Table structure for table `canceled_reservation`
--

CREATE TABLE `canceled_reservation` (
  `reservation_id` bigint(20) UNSIGNED NOT NULL,
  `reason` varchar(2048) NOT NULL,
  `end` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `connection_type`
--

CREATE TABLE `connection_type` (
  `site_id` bigint(20) UNSIGNED NOT NULL,
  `connection_type_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `connection_type`
--

INSERT INTO `connection_type` (`site_id`, `connection_type_id`) VALUES
(1, 2),
(1, 1),
(2, 2),
(2, 1),
(3, 2),
(4, 1),
(5, 2),
(5, 1),
(6, 2),
(7, 1),
(8, 1);
(10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `connection_type_desc`
--

CREATE TABLE `connection_type_desc` (
  `connection_type_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(16) NOT NULL,
  `description` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `connection_type_desc`
--

INSERT INTO `connection_type_desc` (`connection_type_id`, `name`, `description`) VALUES
(1, 'ENT', 'pragma ent'),
(2, 'IPOP', 'ipop connection');

-- --------------------------------------------------------

--
-- Table structure for table `forget_password`
--

CREATE TABLE `forget_password` (
  `id` varchar(16) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `password` varchar(128) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `forget_password`
--

INSERT INTO `forget_password` (`id`, `user_id`, `password`, `timestamp`) VALUES
('QR6Q5C07NGRILYQ7', 1, '3627909a29c31381a071ec27f7c9ca97726182aed29a7ddd2e54353322cfb30abb9e3a6df2ac2c20fe23436311d678564d0c8d305930575f60e2d3d048184d79', '2017-06-03 16:47:03'),
('RXE6R4H2AEOY4J2X', 3, '3627909a29c31381a071ec27f7c9ca97726182aed29a7ddd2e54353322cfb30abb9e3a6df2ac2c20fe23436311d678564d0c8d305930575f60e2d3d048184d79', '2017-06-03 16:49:15');

-- --------------------------------------------------------

--
-- Table structure for table `image_type`
--

CREATE TABLE `image_type` (
  `site_id` bigint(20) UNSIGNED NOT NULL,
  `image_type_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image_type`
--

INSERT INTO `image_type` (`site_id`, `image_type_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(7, 1),
(7, 2),
(7, 3),
(7, 4),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(10, 1),
(10, 2),
(10, 3),
(10, 4);

-- --------------------------------------------------------

--
-- Table structure for table `image_type_desc`
--

CREATE TABLE `image_type_desc` (
  `image_type_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(16) NOT NULL,
  `description` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image_type_desc`
--

INSERT INTO `image_type_desc` (`image_type_id`, `name`, `description`) VALUES
(1, 'centos7', 'CentOS7'),
(2, 'hku_biolinux', '-'),
(3, 'rocks-basic', 'no description'),
(4, 'rocks-sge', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(32) DEFAULT NULL,
  `description` varchar(64) DEFAULT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `reference_number` varchar(32) NOT NULL,
  `image_type` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `site_id` bigint(20) UNSIGNED NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `cpu` int(11) NOT NULL,
  `memory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `session_id` varchar(16) NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `site`
--

CREATE TABLE `site` (
  `site_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(64) NOT NULL,
  `contact` varchar(32) NOT NULL,
  `location` varchar(64) NOT NULL,
  `pragma_boot_path` varchar(64) NOT NULL,
  `pragma_boot_version` int(11) NOT NULL,
  `python_path` varchar(64) NOT NULL,
  `temp_dir` varchar(64) NOT NULL,
  `username` varchar(16) NOT NULL,
  `deployment_type` varchar(16) NOT NULL,
  `site_hostname` varchar(32) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `total_cpu` int(11) NOT NULL,
  `total_memory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `site`
--

INSERT INTO `site` (`site_id`, `name`, `description`, `contact`, `location`, `pragma_boot_path`, `pragma_boot_version`, `python_path`, `temp_dir`, `username`, `deployment_type`, `site_hostname`, `latitude`, `longitude`, `total_cpu`, `total_memory`) VALUES
(1, 'NCHC cloud', 'Rocks. Hosting virtual clusters and virtual machines', 'serenapan@nchc.narl.org.tw', 'National Center for High-Performance Computing', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'pragma.nchc.org.tw', 24.81383, 120.967475, 16, 32),
(2, 'AIST Cloud', 'Cloudstack. Hosting Virtual clusters and virtual machines.', 'jh.haga@aist.go.jp', 'Cloudstack. Hosting Virtual clusters and virtual machines.', '/home/ssmallen/pragma_boot', 2, '/opt/python/bin/python', '/home/ssmallen/pcc', 'ssmallen', 'Rocks KVM', 'pragma.aist.org', 36.060839, 140.137303, 32, 64),
(3, 'Indiana University cloud', 'Rocks 6.2 KVM. Hosting Virtual clusters and virtual machines.', 'quzhou@umail.iu.edu', 'Indiana University', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'pragma8.cs.indiana.edu', 39.1704, -86.5143, 16, 64),
(4, 'NAIST cloud', 'Rocks 6.2 KVM. Hosting Virtual clusters and virtual machines.', 'sd-rocks00.naist.jp', 'NAIST', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'sd-rocks00.naist.jp', 34.6853, 135.8328, 92, 192),
(5, 'TOS cloud', 'Rocks. Hosting virtual clusters and virtual machines', 'serenapan@nchc.narl.org.tw', 'National Center for High-Performance Computing', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'pragma.nchc.org.tw', 30.5621124, -86.1100215, 64, 32),
(6, 'TP cloud', 'Rocks. Hosting virtual clusters and virtual machines', 'serenapan@nchc.narl.org.tw', 'National Center for High-Performance Computing', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'pragma.nchc.org.tw', 24.7849113, 90.3579546, 32, 64),
(7, 'UCSD cloud', 'Rocks. Hosting virtual clusters and virtual machines', 'serenapan@nchc.narl.org.tw', 'National Center for High-Performance Computing', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'calit2-119-121.ucsd.edu', 32.8248175, -115.1879546, 64, 128),
(8, 'TW cloud', 'Rocks. Hosting virtual clusters and virtual machines', 'serenapan@nchc.narl.org.tw', 'National Center for High-Performance Computing', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'pragma.nchc.org.tw', 23.4790323, 120.4142769, 64, 64),
(9, 'B1 cloud', 'Rocks. Hosting virtual clusters and virtual machines', 'serenapan@nchc.narl.org.tw', 'National Center for High-Performance Computing', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'pragma.nchc.org.tw', 55.1879546, 65.1879546, 32, 32),
(10, 'CC cloud', 'Rocks. Hosting virtual clusters and virtual machines', 'serenapan@nchc.narl.org.tw', 'National Center for High-Performance Computing', '/opt/pragma_boot', 2, '/opt/python/bin/python', '/var/run/pcc', 'root', 'Rocks KVM', 'pragma.nchc.org.tw', 47.1879546, 8.0834012, 128, 64);

-- --------------------------------------------------------

--
-- Table structure for table `site_reserved`
--

CREATE TABLE `site_reserved` (
  `reservation_id` bigint(20) UNSIGNED NOT NULL,
  `site_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(16) NOT NULL,
  `admin_description` longtext,
  `cpu` int(11) NOT NULL,
  `memory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(16) NOT NULL,
  `password` varchar(128) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(64) NOT NULL,
  `phone` varchar(24) DEFAULT NULL,
  `status` varchar(5) NOT NULL,
  `organization` varchar(16) NOT NULL,
  `position` varchar(16) NOT NULL,
  `language` varchar(3) NOT NULL,
  `timezone` varchar(32) NOT NULL,
  `public_key` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `firstname`, `lastname`, `email`, `phone`, `status`, `organization`, `position`, `language`, `timezone`, `public_key`) VALUES
(1, 'project401', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'nannapas', 'banluesombatkul', 'bamboojfc@gmail.com', NULL, 'admin', 'TU', 'student', 'TH', 'America/New_York', 'AAAAB3NzaC1yc2EAAAABJQAAAQEA2sl4a0TnLMUmqBUqOaiYiAq83aYwfvMFjekYOqHhS2O9jczt+8hbZsZo6FnwMec5SVpTSkh1R2BB+ForkhWK/XEhKIziGv3xoK3mc7ebAHptl5Uv8zUaittWIFH4AlZoLSmztcWM8MwWucpJ8cO67nZUn/07IVMOdIcjD0uYAdiWJ6HHu/EVJn9S4FegcaF76ha48sTZl9SXy2W0guVzazEjI6u47fPfK844ZLvd6J2XgYLcRuPMRm9Zii17YIdYQ9lr0HaPvidw1Gn920b1Rkz4HdMfwnhB1NDm4T3IXglAM0LZ/yvmlGAsRyAMSNdYMzBMP7Ep7WbUa+gPMojnJQ=='),
(2, 'admin', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'prapansak', 'kaewlamul', 'prapansak.kaew@gmail.com', NULL, 'admin', 'TU', 'student', 'TH', 'America/New_York', 'AAAAB3NzaC1yc2EAAAABJQAAAQEA2sl4a0TnLMUmqBUqOaiYiAq83aYwfvMFjekYOqHhS2O9jczt+8hbZsZo6FnwMec5SVpTSkh1R2BB+ForkhWK/XEhKIziGv3xoK3mc7ebAHptl5Uv8zUaittWIFH4AlZoLSmztcWM8MwWucpJ8cO67nZUn/07IVMOdIcjD0uYAdiWJ6HHu/EVJn9S4FegcaF76ha48sTZl9SXy2W0guVzazEjI6u47fPfK844ZLvd6J2XgYLcRuPMRm9Zii17YIdYQ9lr0HaPvidw1Gn920b1Rkz4HdMfwnhB1NDm4T3IXglAM0LZ/yvmlGAsRyAMSNdYMzBMP7Ep7WbUa+gPMojnJQ=='),
(3, 'test', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'pragma', '32', 'nannapas.blsbk@gmail.com', NULL, 'user', '-', 'professor', 'EN', 'America/New_York', 'AAAAB3NzaC1yc2EAAAABJQAAAQEA2sl4a0TnLMUmqBUqOaiYiAq83aYwfvMFjekYOqHhS2O9jczt+8hbZsZo6FnwMec5SVpTSkh1R2BB+ForkhWK/XEhKIziGv3xoK3mc7ebAHptl5Uv8zUaittWIFH4AlZoLSmztcWM8MwWucpJ8cO67nZUn/07IVMOdIcjD0uYAdiWJ6HHu/EVJn9S4FegcaF76ha48sTZl9SXy2W0guVzazEjI6u47fPfK844ZLvd6J2XgYLcRuPMRm9Zii17YIdYQ9lr0HaPvidw1Gn920b1Rkz4HdMfwnhB1NDm4T3IXglAM0LZ/yvmlGAsRyAMSNdYMzBMP7Ep7WbUa+gPMojnJQ=='),
(4, 'user1', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'USER-NUMBER1', 'TEST', 'snp_vsd_bam@icloud.com', NULL, 'user', '-', 'professor', 'EN', 'America/New_York', 'AAAAB3NzaC1yc2EAAAABJQAAAQEA2sl4a0TnLMUmqBUqOaiYiAq83aYwfvMFjekYOqHhS2O9jczt+8hbZsZo6FnwMec5SVpTSkh1R2BB+ForkhWK/XEhKIziGv3xoK3mc7ebAHptl5Uv8zUaittWIFH4AlZoLSmztcWM8MwWucpJ8cO67nZUn/07IVMOdIcjD0uYAdiWJ6HHu/EVJn9S4FegcaF76ha48sTZl9SXy2W0guVzazEjI6u47fPfK844ZLvd6J2XgYLcRuPMRm9Zii17YIdYQ9lr0HaPvidw1Gn920b1Rkz4HdMfwnhB1NDm4T3IXglAM0LZ/yvmlGAsRyAMSNdYMzBMP7Ep7WbUa+gPMojnJQ=='),
(5, 'user2', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'USER-NUMBER2', 'TEST', 'prapansak.kaew@hotmail.com', NULL, 'user', '-', 'professor', 'EN', 'America/New_York', 'AAAAB3NzaC1yc2EAAAABJQAAAQEA2sl4a0TnLMUmqBUqOaiYiAq83aYwfvMFjekYOqHhS2O9jczt+8hbZsZo6FnwMec5SVpTSkh1R2BB+ForkhWK/XEhKIziGv3xoK3mc7ebAHptl5Uv8zUaittWIFH4AlZoLSmztcWM8MwWucpJ8cO67nZUn/07IVMOdIcjD0uYAdiWJ6HHu/EVJn9S4FegcaF76ha48sTZl9SXy2W0guVzazEjI6u47fPfK844ZLvd6J2XgYLcRuPMRm9Zii17YIdYQ9lr0HaPvidw1Gn920b1Rkz4HdMfwnhB1NDm4T3IXglAM0LZ/yvmlGAsRyAMSNdYMzBMP7Ep7WbUa+gPMojnJQ=='),
(6, 'user3', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'USER-NUMBER3', 'TEST', 'nannapas.banl@dome.tu.ac.th', NULL, 'user', '-', 'professor', 'EN', 'America/New_York', 'AAAAB3NzaC1yc2EAAAABJQAAAQEA2sl4a0TnLMUmqBUqOaiYiAq83aYwfvMFjekYOqHhS2O9jczt+8hbZsZo6FnwMec5SVpTSkh1R2BB+ForkhWK/XEhKIziGv3xoK3mc7ebAHptl5Uv8zUaittWIFH4AlZoLSmztcWM8MwWucpJ8cO67nZUn/07IVMOdIcjD0uYAdiWJ6HHu/EVJn9S4FegcaF76ha48sTZl9SXy2W0guVzazEjI6u47fPfK844ZLvd6J2XgYLcRuPMRm9Zii17YIdYQ9lr0HaPvidw1Gn920b1Rkz4HdMfwnhB1NDm4T3IXglAM0LZ/yvmlGAsRyAMSNdYMzBMP7Ep7WbUa+gPMojnJQ==');
(7, 'pragmac', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'Pragma', 'Admin', 'root@localhost', NULL, 'admin', '-', '-', 'EN', 'America/Los_Angeles', 'AAAAAAA');


--
-- Indexes for dumped tables
--

--
-- Indexes for table `canceled_reservation`
--
ALTER TABLE `canceled_reservation`
  ADD PRIMARY KEY (`reservation_id`);

--
-- Indexes for table `connection_type`
--
ALTER TABLE `connection_type`
  ADD KEY `site_id` (`site_id`),
  ADD KEY `image_type_id` (`connection_type_id`),
  ADD KEY `site_id_2` (`site_id`);

--
-- Indexes for table `connection_type_desc`
--
ALTER TABLE `connection_type_desc`
  ADD PRIMARY KEY (`connection_type_id`),
  ADD UNIQUE KEY `connection_type_id` (`connection_type_id`);

--
-- Indexes for table `forget_password`
--
ALTER TABLE `forget_password`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `image_type`
--
ALTER TABLE `image_type`
  ADD KEY `site_id` (`site_id`),
  ADD KEY `image_type_id` (`image_type_id`);

--
-- Indexes for table `image_type_desc`
--
ALTER TABLE `image_type_desc`
  ADD PRIMARY KEY (`image_type_id`),
  ADD UNIQUE KEY `image_type_id_2` (`image_type_id`),
  ADD KEY `image_type_id` (`name`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD UNIQUE KEY `reference_number` (`reference_number`),
  ADD UNIQUE KEY `reservation_id` (`reservation_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD KEY `site_id` (`site_id`),
  ADD KEY `start` (`start`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD UNIQUE KEY `session_id` (`session_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `user_id_2` (`user_id`);

--
-- Indexes for table `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`site_id`),
  ADD UNIQUE KEY `site_id` (`site_id`);

--
-- Indexes for table `site_reserved`
--
ALTER TABLE `site_reserved`
  ADD KEY `site_id` (`site_id`),
  ADD KEY `reservation_id` (`reservation_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `connection_type_desc`
--
ALTER TABLE `connection_type_desc`
  MODIFY `connection_type_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `image_type_desc`
--
ALTER TABLE `image_type_desc`
  MODIFY `image_type_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `site`
--
ALTER TABLE `site`
  MODIFY `site_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `canceled_reservation`
--
ALTER TABLE `canceled_reservation`
  ADD CONSTRAINT `canceled_reservation_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON UPDATE NO ACTION;

--
-- Constraints for table `connection_type`
--
ALTER TABLE `connection_type`
  ADD CONSTRAINT `connection_type_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `site` (`site_id`);

--
-- Constraints for table `connection_type_desc`
--
ALTER TABLE `connection_type_desc`
  ADD CONSTRAINT `connection_type_desc_ibfk_1` FOREIGN KEY (`connection_type_id`) REFERENCES `connection_type` (`connection_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `forget_password`
--
ALTER TABLE `forget_password`
  ADD CONSTRAINT `forget_password_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `image_type`
--
ALTER TABLE `image_type`
  ADD CONSTRAINT `image_type_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `site` (`site_id`);

--
-- Constraints for table `image_type_desc`
--
ALTER TABLE `image_type_desc`
  ADD CONSTRAINT `image_type_desc_ibfk_1` FOREIGN KEY (`image_type_id`) REFERENCES `image_type` (`image_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `site` (`site_id`);

--
-- Constraints for table `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `session_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `site_reserved`
--
ALTER TABLE `site_reserved`
  ADD CONSTRAINT `site_reserved_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `site` (`site_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `site_reserved_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
