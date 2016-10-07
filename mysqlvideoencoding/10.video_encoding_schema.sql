-- MySQL dump 10.13  Distrib 5.5.44, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: video_encoding
-- ------------------------------------------------------
-- Server version	5.5.44-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assets`
--

DROP DATABASE IF EXISTS `video_encoding`;
CREATE DATABASE video_encoding;
USE video_encoding;

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `assetId` int(11) NOT NULL AUTO_INCREMENT,
  `contentId` int(11) DEFAULT NULL,
  `presetId` int(11) DEFAULT NULL,
  `assetIdDependance` varchar(256) DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `doAnalyze` enum('yes','no') NOT NULL DEFAULT 'yes',
  `state` enum('scheduled','processing','ready','failed') DEFAULT 'scheduled',
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assetId`),
  KEY `contentId` (`contentId`),
  KEY `presetId` (`presetId`),
  CONSTRAINT `assets_ibfk_1` FOREIGN KEY (`contentId`) REFERENCES `contents` (`contentId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `assets_ibfk_2` FOREIGN KEY (`presetId`) REFERENCES `presets` (`presetId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68533 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetsStreams`
--

DROP TABLE IF EXISTS `assetsStreams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetsStreams` (
  `assetId` int(11) DEFAULT NULL,
  `mapId` smallint(6) NOT NULL,
  `type` enum('video','audio','subtitles') NOT NULL,
  `language` char(3) DEFAULT 'eng',
  `codec` varchar(16) NOT NULL,
  `codecInfo` varchar(32) NOT NULL,
  `codecProfile` varchar(32) DEFAULT NULL,
  `bitrate` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `width` smallint(6) DEFAULT NULL,
  `height` smallint(6) DEFAULT NULL,
  `fps` smallint(6) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `assetIdmapId` (`assetId`,`mapId`),
  CONSTRAINT `assetsStreams_ibfk_1` FOREIGN KEY (`assetId`) REFERENCES `assets` (`assetId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `broadcaster`
--

DROP TABLE IF EXISTS `broadcaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `broadcaster` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `profileId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contents`
--

DROP TABLE IF EXISTS `contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contents` (
  `contentId` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `md5Hash` varchar(32) DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `state` enum('initialized','scheduled','processing','packaging','ready','failed') DEFAULT 'initialized',
  `size` bigint(20) DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `uspPackage` enum('enabled','disabled') DEFAULT 'disabled',
  `drm` enum('disabled','enabled') DEFAULT 'disabled',
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`contentId`),
  UNIQUE KEY `md5Hash_filename_idx` (`md5Hash`,`filename`)
) ENGINE=InnoDB AUTO_INCREMENT=12486 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contentsProfiles`
--

DROP TABLE IF EXISTS `contentsProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contentsProfiles` (
  `contentId` int(11) NOT NULL,
  `profileId` int(11) NOT NULL,
  UNIQUE KEY `contentId_profileId_idx` (`contentId`,`profileId`),
  CONSTRAINT `contentsProfiles_ibfk_1` FOREIGN KEY (`contentId`) REFERENCES `contents` (`contentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contentsStreams`
--

DROP TABLE IF EXISTS `contentsStreams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contentsStreams` (
  `contentsStreamId` int(11) NOT NULL AUTO_INCREMENT,
  `contentId` int(11) DEFAULT NULL,
  `mapId` smallint(6) NOT NULL,
  `type` enum('video','audio','subtitles') NOT NULL,
  `language` char(3) DEFAULT 'eng',
  `codec` varchar(16) NOT NULL,
  `codecInfo` varchar(32) NOT NULL,
  `codecProfile` varchar(32) DEFAULT NULL,
  `bitrate` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `width` smallint(6) DEFAULT NULL,
  `height` smallint(6) DEFAULT NULL,
  `fps` smallint(6) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`contentsStreamId`),
  UNIQUE KEY `contentIdmapId` (`contentId`,`mapId`,`type`),
  CONSTRAINT `contentsStreams_ibfk_1` FOREIGN KEY (`contentId`) REFERENCES `contents` (`contentId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7964 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encoders`
--

DROP TABLE IF EXISTS `encoders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encoders` (
  `encoderId` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(32) NOT NULL,
  `activeTasks` smallint(6) NOT NULL DEFAULT '0',
  `maxTasks` smallint(6) DEFAULT '1',
  `load1` float NOT NULL DEFAULT '0',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`encoderId`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `hostname_2` (`hostname`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ffmpegLogs`
--

DROP TABLE IF EXISTS `ffmpegLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ffmpegLogs` (
  `assetId` int(11) DEFAULT NULL,
  `log` text,
  KEY `assetId` (`assetId`),
  CONSTRAINT `ffmpegLogs_ibfk_1` FOREIGN KEY (`assetId`) REFERENCES `assets` (`assetId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ffmpegProgress`
--

DROP TABLE IF EXISTS `ffmpegProgress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ffmpegProgress` (
  `assetId` int(11) DEFAULT NULL,
  `frame` int(11) DEFAULT NULL,
  `fps` int(11) DEFAULT NULL,
  `q` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `elapsed` time DEFAULT NULL,
  `bitrate` float DEFAULT NULL,
  KEY `assetId` (`assetId`),
  CONSTRAINT `ffmpegProgress_ibfk_1` FOREIGN KEY (`assetId`) REFERENCES `assets` (`assetId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presets`
--

DROP TABLE IF EXISTS `presets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presets` (
  `presetId` int(11) NOT NULL AUTO_INCREMENT,
  `profileId` int(11) DEFAULT NULL,
  `presetIdDependance` varchar(256) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `type` enum('ffmpeg','spumux','script') DEFAULT 'ffmpeg',
  `doAnalyze` enum('yes','no') NOT NULL DEFAULT 'yes',
  `cmdLine` varchar(4096) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`presetId`),
  KEY `profileId` (`profileId`),
  CONSTRAINT `presets_ibfk_1` FOREIGN KEY (`profileId`) REFERENCES `profiles` (`profileId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `profileId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `broadcaster` varchar(32) NOT NULL,
  `acceptSubtitles` enum('yes','no') NOT NULL DEFAULT 'no',
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`profileId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profilesParameters`
--

DROP TABLE IF EXISTS `profilesParameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profilesParameters` (
  `profileParameterId` int(11) NOT NULL AUTO_INCREMENT,
  `profileId` int(11) NOT NULL,
  `assetId` int(11) NOT NULL,
  `parameter` varchar(256) NOT NULL,
  `value` varchar(256) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`profileParameterId`),
  KEY `profileId` (`profileId`),
  KEY `assetId` (`assetId`),
  CONSTRAINT `profilesParameters_ibfk_1` FOREIGN KEY (`profileId`) REFERENCES `profiles` (`profileId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profilesParameters_ibfk_2` FOREIGN KEY (`assetId`) REFERENCES `assets` (`assetId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5660 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subtitles`
--

DROP TABLE IF EXISTS `subtitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subtitles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contentId` int(11) NOT NULL,
  `lang` char(3) NOT NULL,
  `url` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-06 16:20:35
