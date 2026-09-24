-- MySQL dump 10.13  Distrib 8.4.4, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: martfury
-- ------------------------------------------------------
-- Server version	8.4.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activations`
--

DROP TABLE IF EXISTS `activations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `code` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activations_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activations`
--

LOCK TABLES `activations` WRITE;
/*!40000 ALTER TABLE `activations` DISABLE KEYS */;
INSERT INTO `activations` VALUES (1,1,'ffEbPkGb3OiFbMLBtzS41lQ1jqRsVbGa',1,'2026-02-28 08:15:35','2026-02-28 08:15:35','2026-02-28 08:15:35');
/*!40000 ALTER TABLE `activations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_notifications`
--

DROP TABLE IF EXISTS `admin_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `permission` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_notifications`
--

LOCK TABLES `admin_notifications` WRITE;
/*!40000 ALTER TABLE `admin_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expired_at` datetime DEFAULT NULL,
  `location` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clicked` bigint NOT NULL DEFAULT '0',
  `order` int DEFAULT '0',
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `open_in_new_tab` tinyint(1) NOT NULL DEFAULT '1',
  `tablet_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ads_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_adsense_slot_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ads_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
INSERT INTO `ads` VALUES (1,'Top Slider Image 1','2031-02-28 00:00:00','not_set','VC2C8Q1UGCBG','promotion/1.jpg','/products',0,1,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL),(2,'Top Slider Image 2','2031-02-28 00:00:00','not_set','NBDWRXTSVZ8N','promotion/2.jpg','/products',0,2,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL),(3,'Homepage middle 1','2031-02-28 00:00:00','not_set','IZ6WU8KUALYD','promotion/3.jpg','/products',0,3,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL),(4,'Homepage middle 2','2031-02-28 00:00:00','not_set','ILSFJVYFGCPZ','promotion/4.jpg','/products',0,4,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL),(5,'Homepage middle 3','2031-02-28 00:00:00','not_set','ZDOZUZZIU7FT','promotion/5.jpg','/products',0,5,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL),(6,'Homepage big 1','2031-02-28 00:00:00','not_set','Q9YDUIC9HSWS','promotion/6.jpg','/products',0,6,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL),(7,'Homepage bottom small','2031-02-28 00:00:00','not_set','LDKFRL1TEDJI','promotion/7.jpg','/products',0,7,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL),(8,'Product sidebar','2031-02-28 00:00:00','product-sidebar','SA5CI0X26UIZ','promotion/8.jpg','/products',0,8,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL),(9,'Homepage big 2','2031-02-28 00:00:00','not_set','IZ6WU8KUALYE','promotion/9.jpg','/products',0,9,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads_translations`
--

DROP TABLE IF EXISTS `ads_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ads_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tablet_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ads_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads_translations`
--

LOCK TABLES `ads_translations` WRITE;
/*!40000 ALTER TABLE `ads_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ads_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_histories`
--

DROP TABLE IF EXISTS `audit_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Botble\\ACL\\Models\\User',
  `module` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `request` longtext COLLATE utf8mb4_unicode_ci,
  `action` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actor_id` bigint unsigned NOT NULL,
  `actor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Botble\\ACL\\Models\\User',
  `reference_id` bigint unsigned NOT NULL,
  `reference_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_histories_user_id_index` (`user_id`),
  KEY `audit_histories_module_index` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_histories`
--

LOCK TABLES `audit_histories` WRITE;
/*!40000 ALTER TABLE `audit_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint unsigned NOT NULL DEFAULT '0',
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `author_id` bigint unsigned DEFAULT NULL,
  `author_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `icon` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int unsigned NOT NULL DEFAULT '0',
  `is_featured` tinyint NOT NULL DEFAULT '0',
  `is_default` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_index` (`parent_id`),
  KEY `categories_status_index` (`status`),
  KEY `categories_created_at_index` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Ecommerce',0,'This is a sample description text for the category.','published',1,'Botble\\ACL\\Models\\User',NULL,0,0,1,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(2,'Fashion',0,'This is a sample description text for the category.','published',1,'Botble\\ACL\\Models\\User',NULL,0,1,0,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(3,'Electronic',0,'This is a sample description text for the category.','published',1,'Botble\\ACL\\Models\\User',NULL,0,1,0,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(4,'Commercial',0,'This is a sample description text for the category.','published',1,'Botble\\ACL\\Models\\User',NULL,0,1,0,'2026-02-28 08:15:36','2026-02-28 08:15:36');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_translations`
--

DROP TABLE IF EXISTS `categories_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categories_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`categories_id`),
  KEY `idx_categories_trans_categories_id` (`categories_id`),
  KEY `idx_categories_trans_category_lang` (`categories_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_translations`
--

LOCK TABLES `categories_translations` WRITE;
/*!40000 ALTER TABLE `categories_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_id` bigint unsigned DEFAULT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `record_id` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` tinyint NOT NULL DEFAULT '0',
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint unsigned NOT NULL DEFAULT '0',
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cities_slug_unique` (`slug`),
  KEY `idx_cities_name` (`name`),
  KEY `idx_cities_state_status` (`state_id`,`status`),
  KEY `idx_cities_status` (`status`),
  KEY `idx_cities_state_id` (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities_translations`
--

DROP TABLE IF EXISTS `cities_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cities_id` bigint unsigned NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`cities_id`),
  KEY `idx_cities_trans_city_lang` (`cities_id`,`lang_code`),
  KEY `idx_cities_trans_name` (`name`),
  KEY `idx_cities_trans_cities_id` (`cities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities_translations`
--

LOCK TABLES `cities_translations` WRITE;
/*!40000 ALTER TABLE `cities_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_custom_field_options`
--

DROP TABLE IF EXISTS `contact_custom_field_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_custom_field_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `custom_field_id` bigint unsigned NOT NULL,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL DEFAULT '999',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_custom_field_options`
--

LOCK TABLES `contact_custom_field_options` WRITE;
/*!40000 ALTER TABLE `contact_custom_field_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_custom_field_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_custom_field_options_translations`
--

DROP TABLE IF EXISTS `contact_custom_field_options_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_custom_field_options_translations` (
  `contact_custom_field_options_id` bigint unsigned NOT NULL,
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`contact_custom_field_options_id`),
  KEY `idx_contact_cfo_trans_cfo_id` (`contact_custom_field_options_id`),
  KEY `idx_contact_cfo_trans_cfo_lang` (`contact_custom_field_options_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_custom_field_options_translations`
--

LOCK TABLES `contact_custom_field_options_translations` WRITE;
/*!40000 ALTER TABLE `contact_custom_field_options_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_custom_field_options_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_custom_fields`
--

DROP TABLE IF EXISTS `contact_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_custom_fields` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `placeholder` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int NOT NULL DEFAULT '999',
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_custom_fields`
--

LOCK TABLES `contact_custom_fields` WRITE;
/*!40000 ALTER TABLE `contact_custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_custom_fields_translations`
--

DROP TABLE IF EXISTS `contact_custom_fields_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_custom_fields_translations` (
  `contact_custom_fields_id` bigint unsigned NOT NULL,
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placeholder` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`contact_custom_fields_id`),
  KEY `idx_contact_cf_trans_cf_id` (`contact_custom_fields_id`),
  KEY `idx_contact_cf_trans_cf_lang` (`contact_custom_fields_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_custom_fields_translations`
--

LOCK TABLES `contact_custom_fields_translations` WRITE;
/*!40000 ALTER TABLE `contact_custom_fields_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_custom_fields_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_replies`
--

DROP TABLE IF EXISTS `contact_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_replies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_replies`
--

LOCK TABLES `contact_replies` WRITE;
/*!40000 ALTER TABLE `contact_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom_fields` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unread',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,'Jane Smith','contact_1@example.com','+15559439626','123 Main St, New York, US','General Inquiry','This is a sample contact message content for testing purposes.',NULL,'unread','2026-02-28 08:15:35','2026-02-28 08:15:35'),(2,'John Doe','contact_2@example.com','+15551690738','123 Main St, New York, US','Support Request','This is a sample contact message content for testing purposes.',NULL,'unread','2026-02-28 08:15:35','2026-02-28 08:15:35'),(3,'Emily White','contact_3@example.com','+15557835811','123 Main St, New York, US','General Inquiry','This is a sample contact message content for testing purposes.',NULL,'read','2026-02-28 08:15:35','2026-02-28 08:15:35'),(4,'John Doe','contact_4@example.com','+15555774441','123 Main St, New York, US','Support Request','This is a sample contact message content for testing purposes.',NULL,'read','2026-02-28 08:15:35','2026-02-28 08:15:35'),(5,'John Doe','contact_5@example.com','+15552991346','123 Main St, New York, US','Other','This is a sample contact message content for testing purposes.',NULL,'read','2026-02-28 08:15:35','2026-02-28 08:15:35'),(6,'John Doe','contact_6@example.com','+15556429890','123 Main St, New York, US','General Inquiry','This is a sample contact message content for testing purposes.',NULL,'read','2026-02-28 08:15:35','2026-02-28 08:15:35'),(7,'Emily White','contact_7@example.com','+15552517911','123 Main St, New York, US','General Inquiry','This is a sample contact message content for testing purposes.',NULL,'read','2026-02-28 08:15:35','2026-02-28 08:15:35'),(8,'Robert Brown','contact_8@example.com','+15555890809','123 Main St, New York, US','Support Request','This is a sample contact message content for testing purposes.',NULL,'read','2026-02-28 08:15:35','2026-02-28 08:15:35'),(9,'Michael Green','contact_9@example.com','+15559173631','123 Main St, New York, US','Other','This is a sample contact message content for testing purposes.',NULL,'unread','2026-02-28 08:15:35','2026-02-28 08:15:35'),(10,'Emily White','contact_10@example.com','+15553436580','123 Main St, New York, US','General Inquiry','This is a sample contact message content for testing purposes.',NULL,'unread','2026-02-28 08:15:35','2026-02-28 08:15:35');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` tinyint NOT NULL DEFAULT '0',
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint unsigned NOT NULL DEFAULT '0',
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_countries_name` (`name`),
  KEY `idx_countries_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries_translations`
--

DROP TABLE IF EXISTS `countries_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `countries_id` bigint unsigned NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationality` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`countries_id`),
  KEY `idx_countries_trans_country_lang` (`countries_id`,`lang_code`),
  KEY `idx_countries_trans_name` (`name`),
  KEY `idx_countries_trans_countries_id` (`countries_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries_translations`
--

LOCK TABLES `countries_translations` WRITE;
/*!40000 ALTER TABLE `countries_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_widget_settings`
--

DROP TABLE IF EXISTS `dashboard_widget_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_widget_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `settings` text COLLATE utf8mb4_unicode_ci,
  `user_id` bigint unsigned NOT NULL,
  `widget_id` bigint unsigned NOT NULL,
  `order` tinyint unsigned NOT NULL DEFAULT '0',
  `status` tinyint unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_widget_settings_user_id_index` (`user_id`),
  KEY `dashboard_widget_settings_widget_id_index` (`widget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_widget_settings`
--

LOCK TABLES `dashboard_widget_settings` WRITE;
/*!40000 ALTER TABLE `dashboard_widget_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_widget_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_widgets`
--

DROP TABLE IF EXISTS `dashboard_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_widgets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_widgets`
--

LOCK TABLES `dashboard_widgets` WRITE;
/*!40000 ALTER TABLE `dashboard_widgets` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_tokens`
--

DROP TABLE IF EXISTS `device_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `platform` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `app_version` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_tokens_token_unique` (`token`),
  KEY `device_tokens_user_type_user_id_index` (`user_type`,`user_id`),
  KEY `device_tokens_platform_is_active_index` (`platform`,`is_active`),
  KEY `device_tokens_is_active_index` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_tokens`
--

LOCK TABLES `device_tokens` WRITE;
/*!40000 ALTER TABLE `device_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_abandoned_carts`
--

DROP TABLE IF EXISTS `ec_abandoned_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_abandoned_carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `session_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cart_data` json NOT NULL,
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `items_count` int NOT NULL DEFAULT '0',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `abandoned_at` timestamp NULL DEFAULT NULL,
  `reminder_sent_at` timestamp NULL DEFAULT NULL,
  `reminders_sent` int NOT NULL DEFAULT '0',
  `last_email_sequence` tinyint unsigned NOT NULL DEFAULT '0',
  `recovery_token` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clicked_at` timestamp NULL DEFAULT NULL,
  `unsubscribe_token` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unsubscribed_at` timestamp NULL DEFAULT NULL,
  `is_recovered` tinyint(1) NOT NULL DEFAULT '0',
  `recovered_at` timestamp NULL DEFAULT NULL,
  `recovered_order_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_abandoned_carts_recovery_token_unique` (`recovery_token`),
  UNIQUE KEY `ec_abandoned_carts_unsubscribe_token_unique` (`unsubscribe_token`),
  KEY `ec_abandoned_carts_abandoned_at_is_recovered_index` (`abandoned_at`,`is_recovered`),
  KEY `ec_abandoned_carts_created_at_is_recovered_index` (`created_at`,`is_recovered`),
  KEY `ec_abandoned_carts_customer_id_index` (`customer_id`),
  KEY `ec_abandoned_carts_session_id_index` (`session_id`),
  KEY `ec_abandoned_carts_email_index` (`email`),
  KEY `ec_abandoned_carts_recovered_order_id_index` (`recovered_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_abandoned_carts`
--

LOCK TABLES `ec_abandoned_carts` WRITE;
/*!40000 ALTER TABLE `ec_abandoned_carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_abandoned_carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_brands`
--

DROP TABLE IF EXISTS `ec_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_brands` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `order` tinyint unsigned NOT NULL DEFAULT '0',
  `is_featured` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_brands`
--

LOCK TABLES `ec_brands` WRITE;
/*!40000 ALTER TABLE `ec_brands` DISABLE KEYS */;
INSERT INTO `ec_brands` VALUES (1,'Fashion live',NULL,NULL,'brands/1.jpg','published',0,1,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(2,'Hand crafted',NULL,NULL,'brands/2.jpg','published',1,1,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(3,'Mestonix',NULL,NULL,'brands/3.jpg','published',2,1,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(4,'Sunshine',NULL,NULL,'brands/4.jpg','published',3,1,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(5,'Pure',NULL,NULL,'brands/5.jpg','published',4,1,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(6,'Anfold',NULL,NULL,'brands/6.jpg','published',5,1,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(7,'Automotive',NULL,NULL,'brands/7.jpg','published',6,1,'2026-02-28 08:15:11','2026-02-28 08:15:11');
/*!40000 ALTER TABLE `ec_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_brands_translations`
--

DROP TABLE IF EXISTS `ec_brands_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_brands_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_brands_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`lang_code`,`ec_brands_id`),
  KEY `idx_brands_fk` (`ec_brands_id`),
  KEY `idx_brands_brands_lang` (`ec_brands_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_brands_translations`
--

LOCK TABLES `ec_brands_translations` WRITE;
/*!40000 ALTER TABLE `ec_brands_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_brands_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_cart`
--

DROP TABLE IF EXISTS `ec_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_cart` (
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instance` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`identifier`,`instance`),
  KEY `ec_cart_customer_instance_index` (`customer_id`,`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_cart`
--

LOCK TABLES `ec_cart` WRITE;
/*!40000 ALTER TABLE `ec_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_currencies`
--

DROP TABLE IF EXISTS `ec_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_prefix_symbol` tinyint unsigned NOT NULL DEFAULT '0',
  `decimals` tinyint unsigned DEFAULT '0',
  `number_format_style` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'western',
  `space_between_price_and_currency` tinyint(1) NOT NULL DEFAULT '0',
  `order` int unsigned DEFAULT '0',
  `is_default` tinyint NOT NULL DEFAULT '0',
  `exchange_rate` double NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_currencies`
--

LOCK TABLES `ec_currencies` WRITE;
/*!40000 ALTER TABLE `ec_currencies` DISABLE KEYS */;
INSERT INTO `ec_currencies` VALUES (1,'USD','$',1,2,'western',0,0,1,1,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(2,'EUR','€',0,2,'western',0,1,0,0.84,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(3,'VND','₫',0,0,'western',0,2,0,23203,'2026-02-28 08:15:11','2026-02-28 08:15:11'),(4,'NGN','₦',1,2,'western',0,2,0,895.52,'2026-02-28 08:15:11','2026-02-28 08:15:11');
/*!40000 ALTER TABLE `ec_currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_addresses`
--

DROP TABLE IF EXISTS `ec_customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `is_default` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_addresses`
--

LOCK TABLES `ec_customer_addresses` WRITE;
/*!40000 ALTER TABLE `ec_customer_addresses` DISABLE KEYS */;
INSERT INTO `ec_customer_addresses` VALUES (1,'Robert Brown','customer@botble.com','+15555284738','AU','Florida','New York','456 Elm St',1,1,'2026-02-28 08:15:30','2026-02-28 08:15:30','50005'),(2,'Robert Brown','customer@botble.com','+15554903647','KR','Florida','Hanoi','456 Elm St',1,0,'2026-02-28 08:15:30','2026-02-28 08:15:30','30003'),(3,'Anna Orange','vendor@botble.com','+15551484746','VN','Washington','Hanoi','789 Pine St',2,1,'2026-02-28 08:15:31','2026-02-28 08:15:31','50005'),(4,'Anna Orange','vendor@botble.com','+15558160435','KR','Florida','Seoul','101 Oak St',2,0,'2026-02-28 08:15:31','2026-02-28 08:15:31','10001'),(5,'Michael Green','customer_1@example.com','+15559272153','AU','New York','Tokyo','789 Pine St',3,1,'2026-02-28 08:15:31','2026-02-28 08:15:31','40004'),(6,'Jennifer Red','customer_2@example.com','+15556533434','UK','California','Berlin','101 Oak St',4,1,'2026-02-28 08:15:31','2026-02-28 08:15:31','10001'),(7,'Robert Brown','customer_3@example.com','+15555961564','KR','Texas','New York','456 Elm St',5,1,'2026-02-28 08:15:31','2026-02-28 08:15:31','50005'),(8,'Emily White','customer_4@example.com','+15551715668','VN','California','Melbourne','202 Maple St',6,1,'2026-02-28 08:15:32','2026-02-28 08:15:32','30003'),(9,'Sarah Black','customer_5@example.com','+15558147341','KR','California','Berlin','789 Pine St',7,1,'2026-02-28 08:15:32','2026-02-28 08:15:32','20002'),(10,'Sarah Black','customer_6@example.com','+15551232822','JP','California','Seoul','101 Oak St',8,1,'2026-02-28 08:15:32','2026-02-28 08:15:32','40004'),(11,'Robert Brown','customer_7@example.com','+15553118854','VN','Washington','Berlin','456 Elm St',9,1,'2026-02-28 08:15:32','2026-02-28 08:15:32','40004'),(12,'Chris Mint','customer_8@example.com','+15559790400','AU','California','Melbourne','123 Main St',10,1,'2026-02-28 08:15:32','2026-02-28 08:15:32','10001');
/*!40000 ALTER TABLE `ec_customer_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_deletion_requests`
--

DROP TABLE IF EXISTS `ec_customer_deletion_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_deletion_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `customer_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verification_code` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_expires_at` timestamp NULL DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'waiting_for_confirmation',
  `reason` text COLLATE utf8mb4_unicode_ci,
  `confirmed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_customer_deletion_requests_token_unique` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_deletion_requests`
--

LOCK TABLES `ec_customer_deletion_requests` WRITE;
/*!40000 ALTER TABLE `ec_customer_deletion_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_customer_deletion_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_password_resets`
--

DROP TABLE IF EXISTS `ec_customer_password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `ec_customer_password_resets_email_index` (`email`),
  KEY `ec_customer_password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_password_resets`
--

LOCK TABLES `ec_customer_password_resets` WRITE;
/*!40000 ALTER TABLE `ec_customer_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_customer_password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_recently_viewed_products`
--

DROP TABLE IF EXISTS `ec_customer_recently_viewed_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_recently_viewed_products` (
  `customer_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`customer_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_recently_viewed_products`
--

LOCK TABLES `ec_customer_recently_viewed_products` WRITE;
/*!40000 ALTER TABLE `ec_customer_recently_viewed_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_customer_recently_viewed_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_used_coupons`
--

DROP TABLE IF EXISTS `ec_customer_used_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_used_coupons` (
  `discount_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_used_coupons`
--

LOCK TABLES `ec_customer_used_coupons` WRITE;
/*!40000 ALTER TABLE `ec_customer_used_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_customer_used_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customers`
--

DROP TABLE IF EXISTS `ec_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `tax_class` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'regular',
  `tax_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `email_verify_token` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activated',
  `block_reason` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `private_notes` text COLLATE utf8mb4_unicode_ci,
  `is_vendor` tinyint(1) NOT NULL DEFAULT '0',
  `vendor_verified_at` datetime DEFAULT NULL,
  `stripe_account_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_account_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ec_customers_is_vendor_index` (`is_vendor`),
  KEY `ec_customers_vendor_verified_at_index` (`vendor_verified_at`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customers`
--

LOCK TABLES `ec_customers` WRITE;
/*!40000 ALTER TABLE `ec_customers` DISABLE KEYS */;
INSERT INTO `ec_customers` VALUES (1,'Robert Brown','customer@botble.com','$2y$12$Nxv4ijA.CXkwj/SHA2sds.8uNhl/Q6ykKxcFSlj3aZGsDrmbQgNn2','customers/5.jpg','2002-02-19','regular',NULL,'+15559449667',NULL,'2026-02-28 08:15:30','2026-02-28 08:15:30','2026-02-28 15:15:30',NULL,'activated',NULL,NULL,0,NULL,NULL,0),(2,'Anna Orange','vendor@botble.com','$2y$12$CwU1K.ctYDGusQ4VuMK51.8rNHO769zmkIrIXHiVCCruRttDBN41.','customers/8.jpg','2000-02-12','regular',NULL,'+15552006517',NULL,'2026-02-28 08:15:31','2026-02-28 08:15:41','2026-02-28 15:15:31',NULL,'activated',NULL,NULL,1,'2026-02-28 15:15:41',NULL,0),(3,'Michael Green','customer_1@example.com','$2y$12$r0TM.3kIPZC5FJjpRbMw3.zLyarHzJGukSSFIyOCDY.qbx.it1ZXG','customers/1.jpg','1976-02-07','regular',NULL,'+15552426375',NULL,'2026-02-28 08:15:31','2026-02-28 08:15:41','2026-02-28 15:15:31',NULL,'activated',NULL,NULL,1,'2026-02-28 15:15:41',NULL,0),(4,'Jennifer Red','customer_2@example.com','$2y$12$1w2RLGSfQcgbpv0y8s8NVeL7kFlrSK7y1E9tBX2qAIwgZlLBL982K','customers/2.jpg','2004-02-17','regular',NULL,'+15555342752',NULL,'2026-02-28 08:15:31','2026-02-28 08:15:41','2026-02-28 15:15:31',NULL,'activated',NULL,NULL,1,'2026-02-28 15:15:41',NULL,0),(5,'Robert Brown','customer_3@example.com','$2y$12$skLlL7N4zD7FdjoBcSVvjO1s6huEz4RIn9A1H9227XxjZ5dw/Fjjq','customers/3.jpg','1991-02-09','regular',NULL,'+15558954001',NULL,'2026-02-28 08:15:31','2026-02-28 08:15:42','2026-02-28 15:15:31',NULL,'activated',NULL,NULL,1,'2026-02-28 15:15:41',NULL,0),(6,'Emily White','customer_4@example.com','$2y$12$q3VFF0N.ph1kxGBuQ9G6XOqxdBqGOIY2UFifgvk81KRG6aBoqVUrO','customers/4.jpg','1986-02-04','regular',NULL,'+15556633717',NULL,'2026-02-28 08:15:32','2026-02-28 08:15:42','2026-02-28 15:15:32',NULL,'activated',NULL,NULL,1,'2026-02-28 15:15:41',NULL,0),(7,'Sarah Black','customer_5@example.com','$2y$12$SAX3Yl6iQxPPtM8L2.I6te6FE8Wk2Shjn/DLg5C2klmtcst2o3fyq','customers/5.jpg','1987-02-18','regular',NULL,'+15556751680',NULL,'2026-02-28 08:15:32','2026-02-28 08:15:42','2026-02-28 15:15:32',NULL,'activated',NULL,NULL,1,'2026-02-28 15:15:41',NULL,0),(8,'Sarah Black','customer_6@example.com','$2y$12$Etkwe.gmADnNdeh2CyCUUOK7uh6D5yGVGK7T.eptX9sE0Cfp4uKgi','customers/6.jpg','2005-02-20','regular',NULL,'+15553033547',NULL,'2026-02-28 08:15:32','2026-02-28 08:15:42','2026-02-28 15:15:32',NULL,'activated',NULL,NULL,1,'2026-02-28 15:15:41',NULL,0),(9,'Robert Brown','customer_7@example.com','$2y$12$rFawBv4o4jsd9ljdHOHlMuIdUuNv/V4HzUqE4ngoRNDNM2d/zfOiS','customers/7.jpg','1995-02-22','regular',NULL,'+15555851941',NULL,'2026-02-28 08:15:32','2026-02-28 08:15:43','2026-02-28 15:15:32',NULL,'activated',NULL,NULL,1,'2026-02-28 15:15:41',NULL,0),(10,'Chris Mint','customer_8@example.com','$2y$12$oEdzP92vpsphdiWe5tQPT.eRdDUGgVFY1DU9vmydVaR3fJVb383Ma','customers/8.jpg','1984-02-09','regular',NULL,'+15553532054',NULL,'2026-02-28 08:15:32','2026-02-28 08:15:43','2026-02-28 15:15:32',NULL,'activated',NULL,NULL,0,NULL,NULL,0);
/*!40000 ALTER TABLE `ec_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discount_customers`
--

DROP TABLE IF EXISTS `ec_discount_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discount_customers` (
  `discount_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discount_customers`
--

LOCK TABLES `ec_discount_customers` WRITE;
/*!40000 ALTER TABLE `ec_discount_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discount_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discount_product_categories`
--

DROP TABLE IF EXISTS `ec_discount_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discount_product_categories` (
  `discount_id` bigint unsigned NOT NULL,
  `product_category_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`product_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discount_product_categories`
--

LOCK TABLES `ec_discount_product_categories` WRITE;
/*!40000 ALTER TABLE `ec_discount_product_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discount_product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discount_product_collections`
--

DROP TABLE IF EXISTS `ec_discount_product_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discount_product_collections` (
  `discount_id` bigint unsigned NOT NULL,
  `product_collection_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`product_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discount_product_collections`
--

LOCK TABLES `ec_discount_product_collections` WRITE;
/*!40000 ALTER TABLE `ec_discount_product_collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discount_product_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discount_products`
--

DROP TABLE IF EXISTS `ec_discount_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discount_products` (
  `discount_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discount_products`
--

LOCK TABLES `ec_discount_products` WRITE;
/*!40000 ALTER TABLE `ec_discount_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discount_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discounts`
--

DROP TABLE IF EXISTS `ec_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `total_used` int unsigned NOT NULL DEFAULT '0',
  `value` double DEFAULT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT 'coupon',
  `can_use_with_promotion` tinyint(1) NOT NULL DEFAULT '0',
  `can_use_with_flash_sale` tinyint(1) NOT NULL DEFAULT '0',
  `discount_on` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_quantity` int unsigned DEFAULT NULL,
  `type_option` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'amount',
  `target` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all-orders',
  `min_order_price` decimal(15,2) DEFAULT NULL,
  `apply_via_url` tinyint(1) NOT NULL DEFAULT '0',
  `display_at_checkout` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_discounts_code_unique` (`code`),
  KEY `ec_discounts_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discounts`
--

LOCK TABLES `ec_discounts` WRITE;
/*!40000 ALTER TABLE `ec_discounts` DISABLE KEYS */;
INSERT INTO `ec_discounts` VALUES (1,'Discount 1','ANXDWJFGFCEY','2026-02-27 15:15:35','2026-03-15 15:15:35',NULL,0,10,'coupon',0,0,NULL,NULL,'percentage','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(2,'Discount 2','5ZOZBMJFNAHR','2026-02-27 15:15:35',NULL,NULL,0,50,'coupon',0,0,NULL,NULL,'amount','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(3,'Discount 3','EB4SASH6AU4P','2026-02-27 15:15:35','2026-03-07 15:15:35',NULL,0,25,'coupon',0,0,NULL,NULL,'percentage','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(4,'Discount 4','0XSOYKX7GZQU','2026-02-27 15:15:35',NULL,NULL,0,100,'coupon',0,0,NULL,NULL,'amount','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(5,'Discount 5','TQK9KOD9PZVJ','2026-02-27 15:15:35','2026-03-20 15:15:35',NULL,0,50,'coupon',0,0,NULL,NULL,'percentage','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(6,'Discount 6','ZJE3DTS9E5PR','2026-02-27 15:15:35','2026-03-10 15:15:35',NULL,0,200,'coupon',0,0,NULL,NULL,'amount','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(7,'Discount 7','4PWXLFDNQ4B7','2026-02-27 15:15:35',NULL,NULL,0,15,'coupon',0,0,NULL,NULL,'percentage','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(8,'Discount 8','1VUWMJ9RLAPS','2026-02-27 15:15:35','2026-03-30 15:15:35',NULL,0,500,'coupon',0,0,NULL,NULL,'amount','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(9,'Discount 9','IY5ATT953OWL','2026-02-27 15:15:35','2026-03-05 15:15:35',NULL,0,75,'coupon',0,0,NULL,NULL,'percentage','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL),(10,'Discount 10','ZWPACCS6PCBI','2026-02-27 15:15:35',NULL,NULL,0,150,'coupon',0,0,NULL,NULL,'amount','all-orders',NULL,0,1,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,NULL);
/*!40000 ALTER TABLE `ec_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_flash_sale_products`
--

DROP TABLE IF EXISTS `ec_flash_sale_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_flash_sale_products` (
  `flash_sale_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `price` double unsigned DEFAULT NULL,
  `quantity` int unsigned DEFAULT NULL,
  `sold` int unsigned NOT NULL DEFAULT '0',
  KEY `ec_flash_sale_products_product_id_flash_sale_id_index` (`product_id`,`flash_sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_flash_sale_products`
--

LOCK TABLES `ec_flash_sale_products` WRITE;
/*!40000 ALTER TABLE `ec_flash_sale_products` DISABLE KEYS */;
INSERT INTO `ec_flash_sale_products` VALUES (1,1,357.3366,16,3),(1,2,367.693,18,4),(1,3,1058.717,20,1),(1,4,168.9948,20,1),(1,5,351.2192,19,4),(1,6,362.674,16,2),(1,7,413.376,13,3),(1,8,116.7628,7,2),(1,9,62.166,13,4),(1,10,61.8,14,2);
/*!40000 ALTER TABLE `ec_flash_sale_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_flash_sales`
--

DROP TABLE IF EXISTS `ec_flash_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_flash_sales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_date` datetime NOT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_flash_sales`
--

LOCK TABLES `ec_flash_sales` WRITE;
/*!40000 ALTER TABLE `ec_flash_sales` DISABLE KEYS */;
INSERT INTO `ec_flash_sales` VALUES (1,'Winter Sale','2026-11-27 00:00:00','published','2026-02-28 08:15:34','2026-02-28 08:15:34');
/*!40000 ALTER TABLE `ec_flash_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_flash_sales_translations`
--

DROP TABLE IF EXISTS `ec_flash_sales_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_flash_sales_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_flash_sales_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_flash_sales_id`),
  KEY `idx_flash_sales_fk` (`ec_flash_sales_id`),
  KEY `idx_flash_sales_flash_sales_lang` (`ec_flash_sales_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_flash_sales_translations`
--

LOCK TABLES `ec_flash_sales_translations` WRITE;
/*!40000 ALTER TABLE `ec_flash_sales_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_flash_sales_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_global_option_value`
--

DROP TABLE IF EXISTS `ec_global_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_global_option_value` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `option_id` bigint unsigned NOT NULL COMMENT 'option id',
  `option_value` tinytext COLLATE utf8mb4_unicode_ci COMMENT 'option value',
  `affect_price` double DEFAULT NULL COMMENT 'value of price of this option affect',
  `order` int NOT NULL DEFAULT '9999',
  `affect_type` tinyint NOT NULL DEFAULT '0' COMMENT '0. fixed 1. percent',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_global_option_value`
--

LOCK TABLES `ec_global_option_value` WRITE;
/*!40000 ALTER TABLE `ec_global_option_value` DISABLE KEYS */;
INSERT INTO `ec_global_option_value` VALUES (1,1,'1 Year',0,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(2,1,'2 Year',10,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(3,1,'3 Year',20,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(4,2,'4GB',0,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(5,2,'8GB',10,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(6,2,'16GB',20,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(7,3,'Core i5',0,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(8,3,'Core i7',10,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(9,3,'Core i9',20,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(10,4,'128GB',0,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(11,4,'256GB',10,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(12,4,'512GB',20,9999,0,'2026-02-28 08:15:40','2026-02-28 08:15:40');
/*!40000 ALTER TABLE `ec_global_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_global_option_value_translations`
--

DROP TABLE IF EXISTS `ec_global_option_value_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_global_option_value_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_global_option_value_id` bigint unsigned NOT NULL,
  `option_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_global_option_value_id`),
  KEY `idx_global_option_value_fk` (`ec_global_option_value_id`),
  KEY `idx_global_option_value_global_option_value_lang` (`ec_global_option_value_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_global_option_value_translations`
--

LOCK TABLES `ec_global_option_value_translations` WRITE;
/*!40000 ALTER TABLE `ec_global_option_value_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_global_option_value_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_global_options`
--

DROP TABLE IF EXISTS `ec_global_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_global_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Name of options',
  `option_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'option type',
  `required` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Checked if this option is required',
  `price_per_product` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_global_options`
--

LOCK TABLES `ec_global_options` WRITE;
/*!40000 ALTER TABLE `ec_global_options` DISABLE KEYS */;
INSERT INTO `ec_global_options` VALUES (1,'Warranty','Botble\\Ecommerce\\Option\\OptionType\\RadioButton',1,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(2,'RAM','Botble\\Ecommerce\\Option\\OptionType\\RadioButton',1,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(3,'CPU','Botble\\Ecommerce\\Option\\OptionType\\RadioButton',1,0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(4,'HDD','Botble\\Ecommerce\\Option\\OptionType\\Dropdown',0,0,'2026-02-28 08:15:40','2026-02-28 08:15:40');
/*!40000 ALTER TABLE `ec_global_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_global_options_translations`
--

DROP TABLE IF EXISTS `ec_global_options_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_global_options_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_global_options_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_global_options_id`),
  KEY `idx_global_options_fk` (`ec_global_options_id`),
  KEY `idx_global_options_global_options_lang` (`ec_global_options_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_global_options_translations`
--

LOCK TABLES `ec_global_options_translations` WRITE;
/*!40000 ALTER TABLE `ec_global_options_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_global_options_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_grouped_products`
--

DROP TABLE IF EXISTS `ec_grouped_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_grouped_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_product_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `fixed_qty` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_grouped_products`
--

LOCK TABLES `ec_grouped_products` WRITE;
/*!40000 ALTER TABLE `ec_grouped_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_grouped_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_invoice_item_tax_components`
--

DROP TABLE IF EXISTS `ec_invoice_item_tax_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_invoice_item_tax_components` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_item_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` decimal(8,4) NOT NULL DEFAULT '0.0000',
  `amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `jurisdiction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_iitc_invoice_item` (`invoice_item_id`),
  CONSTRAINT `ec_invoice_item_tax_components_invoice_item_id_foreign` FOREIGN KEY (`invoice_item_id`) REFERENCES `ec_invoice_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_invoice_item_tax_components`
--

LOCK TABLES `ec_invoice_item_tax_components` WRITE;
/*!40000 ALTER TABLE `ec_invoice_item_tax_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_invoice_item_tax_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_invoice_items`
--

DROP TABLE IF EXISTS `ec_invoice_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_invoice_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint unsigned NOT NULL,
  `reference_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` int unsigned NOT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `sub_total` decimal(15,2) unsigned NOT NULL,
  `tax_amount` decimal(15,2) unsigned NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) unsigned NOT NULL DEFAULT '0.00',
  `amount` decimal(15,2) unsigned NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_invoice_items_reference_type_reference_id_index` (`reference_type`,`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_invoice_items`
--

LOCK TABLES `ec_invoice_items` WRITE;
/*!40000 ALTER TABLE `ec_invoice_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_invoice_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_invoices`
--

DROP TABLE IF EXISTS `ec_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `reference_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint unsigned NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_zip_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_address_line` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_tax_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total` decimal(15,2) unsigned NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `shipping_amount` decimal(15,2) unsigned NOT NULL DEFAULT '0.00',
  `shipping_tax_amount` decimal(15,2) DEFAULT '0.00',
  `payment_fee` decimal(15,2) DEFAULT '0.00',
  `discount_amount` decimal(15,2) unsigned NOT NULL DEFAULT '0.00',
  `shipping_option` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `coupon_code` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(15,2) unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `payment_id` bigint unsigned DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_invoices_code_unique` (`code`),
  KEY `ec_invoices_reference_type_reference_id_index` (`reference_type`,`reference_id`),
  KEY `ec_invoices_payment_id_index` (`payment_id`),
  KEY `ec_invoices_status_index` (`status`),
  KEY `ec_invoices_reference_id_reference_type_index` (`reference_id`,`reference_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_invoices`
--

LOCK TABLES `ec_invoices` WRITE;
/*!40000 ALTER TABLE `ec_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_option_value`
--

DROP TABLE IF EXISTS `ec_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_option_value` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `option_id` bigint unsigned NOT NULL COMMENT 'option id',
  `option_value` tinytext COLLATE utf8mb4_unicode_ci COMMENT 'option value',
  `affect_price` double DEFAULT NULL COMMENT 'value of price of this option affect',
  `order` int NOT NULL DEFAULT '9999',
  `affect_type` tinyint NOT NULL DEFAULT '0' COMMENT '0. fixed 1. percent',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_option_value`
--

LOCK TABLES `ec_option_value` WRITE;
/*!40000 ALTER TABLE `ec_option_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_option_value_translations`
--

DROP TABLE IF EXISTS `ec_option_value_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_option_value_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_option_value_id` bigint unsigned NOT NULL,
  `option_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_option_value_id`),
  KEY `idx_option_value_fk` (`ec_option_value_id`),
  KEY `idx_option_value_option_value_lang` (`ec_option_value_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_option_value_translations`
--

LOCK TABLES `ec_option_value_translations` WRITE;
/*!40000 ALTER TABLE `ec_option_value_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_option_value_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_options`
--

DROP TABLE IF EXISTS `ec_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Name of options',
  `option_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'option type',
  `product_id` bigint unsigned NOT NULL DEFAULT '0',
  `order` int NOT NULL DEFAULT '9999',
  `required` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Checked if this option is required',
  `price_per_product` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_options`
--

LOCK TABLES `ec_options` WRITE;
/*!40000 ALTER TABLE `ec_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_options_translations`
--

DROP TABLE IF EXISTS `ec_options_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_options_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_options_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_options_id`),
  KEY `idx_options_fk` (`ec_options_id`),
  KEY `idx_options_options_lang` (`ec_options_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_options_translations`
--

LOCK TABLES `ec_options_translations` WRITE;
/*!40000 ALTER TABLE `ec_options_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_options_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_addresses`
--

DROP TABLE IF EXISTS `ec_order_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'shipping_address',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_order_addresses_order_id_type_unique` (`order_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_addresses`
--

LOCK TABLES `ec_order_addresses` WRITE;
/*!40000 ALTER TABLE `ec_order_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_histories`
--

DROP TABLE IF EXISTS `ec_order_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `extras` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_histories`
--

LOCK TABLES `ec_order_histories` WRITE;
/*!40000 ALTER TABLE `ec_order_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_metadata`
--

DROP TABLE IF EXISTS `ec_order_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_metadata` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `meta_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_order_metadata_order_id_meta_key_index` (`order_id`,`meta_key`),
  KEY `ec_order_metadata_order_id_index` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_metadata`
--

LOCK TABLES `ec_order_metadata` WRITE;
/*!40000 ALTER TABLE `ec_order_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_product`
--

DROP TABLE IF EXISTS `ec_order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `qty` int NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `tax_breakdown` json DEFAULT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `product_options` text COLLATE utf8mb4_unicode_ci COMMENT 'product option data',
  `product_id` bigint unsigned DEFAULT NULL,
  `product_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` double DEFAULT '0',
  `restock_quantity` int unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'physical',
  `times_downloaded` int NOT NULL DEFAULT '0',
  `license_code` text COLLATE utf8mb4_unicode_ci,
  `downloaded_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_order_product_order_id_product_id_index` (`order_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_product`
--

LOCK TABLES `ec_order_product` WRITE;
/*!40000 ALTER TABLE `ec_order_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_product_tax_components`
--

DROP TABLE IF EXISTS `ec_order_product_tax_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_product_tax_components` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_product_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` decimal(8,4) NOT NULL DEFAULT '0.0000',
  `amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `jurisdiction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_opt_order_product` (`order_product_id`),
  KEY `idx_opt_order_product_code` (`order_product_id`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_product_tax_components`
--

LOCK TABLES `ec_order_product_tax_components` WRITE;
/*!40000 ALTER TABLE `ec_order_product_tax_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_product_tax_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_referrals`
--

DROP TABLE IF EXISTS `ec_order_referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_referrals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(39) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `landing_domain` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `landing_page` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `landing_params` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referral` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gclid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fclid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_campaign` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_medium` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_term` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_content` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referrer_url` text COLLATE utf8mb4_unicode_ci,
  `referrer_domain` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_order_referrals_order_id_index` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_referrals`
--

LOCK TABLES `ec_order_referrals` WRITE;
/*!40000 ALTER TABLE `ec_order_referrals` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_referrals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_return_histories`
--

DROP TABLE IF EXISTS `ec_order_return_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_return_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `order_return_id` bigint unsigned NOT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_return_histories`
--

LOCK TABLES `ec_order_return_histories` WRITE;
/*!40000 ALTER TABLE `ec_order_return_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_return_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_return_items`
--

DROP TABLE IF EXISTS `ec_order_return_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_return_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_return_id` bigint unsigned NOT NULL COMMENT 'Order return id',
  `order_product_id` bigint unsigned NOT NULL COMMENT 'Order product id',
  `product_id` bigint unsigned NOT NULL COMMENT 'Product id',
  `product_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` int NOT NULL COMMENT 'Quantity return',
  `price` decimal(15,2) NOT NULL COMMENT 'Price Product',
  `reason` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `refund_amount` decimal(12,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_return_items`
--

LOCK TABLES `ec_order_return_items` WRITE;
/*!40000 ALTER TABLE `ec_order_return_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_return_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_returns`
--

DROP TABLE IF EXISTS `ec_order_returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_returns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL COMMENT 'Order ID',
  `store_id` bigint unsigned DEFAULT NULL COMMENT 'Store ID',
  `user_id` bigint unsigned NOT NULL COMMENT 'Customer ID',
  `reason` text COLLATE utf8mb4_unicode_ci COMMENT 'Reason return order',
  `images` json DEFAULT NULL,
  `order_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Order current status',
  `return_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Return status',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_order_returns_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_returns`
--

LOCK TABLES `ec_order_returns` WRITE;
/*!40000 ALTER TABLE `ec_order_returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_returns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_tax_information`
--

DROP TABLE IF EXISTS `ec_order_tax_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_tax_information` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `company_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_tax_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_order_tax_information_order_id_index` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_tax_information`
--

LOCK TABLES `ec_order_tax_information` WRITE;
/*!40000 ALTER TABLE `ec_order_tax_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_tax_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_orders`
--

DROP TABLE IF EXISTS `ec_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `shipping_option` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `status` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `amount` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `shipping_amount` decimal(15,2) DEFAULT NULL,
  `shipping_tax_amount` decimal(15,2) DEFAULT '0.00',
  `payment_fee` decimal(15,2) DEFAULT '0.00',
  `description` text COLLATE utf8mb4_unicode_ci,
  `coupon_code` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(15,2) DEFAULT NULL,
  `sub_total` decimal(15,2) NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `discount_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_finished` tinyint(1) DEFAULT '0',
  `cancellation_reason` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancellation_reason_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `token` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `proof_file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `private_notes` text COLLATE utf8mb4_unicode_ci,
  `store_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_orders_code_unique` (`code`),
  KEY `ec_orders_user_id_status_created_at_index` (`user_id`,`status`,`created_at`),
  KEY `ec_orders_status_created_at_index` (`status`,`created_at`),
  KEY `ec_orders_user_id_is_finished_index` (`user_id`,`is_finished`),
  KEY `ec_orders_store_id_index` (`store_id`),
  KEY `ec_orders_store_finished_index` (`store_id`,`is_finished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_orders`
--

LOCK TABLES `ec_orders` WRITE;
/*!40000 ALTER TABLE `ec_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_attribute_sets`
--

DROP TABLE IF EXISTS `ec_product_attribute_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_attribute_sets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_layout` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dropdown',
  `is_searchable` tinyint unsigned NOT NULL DEFAULT '1',
  `is_comparable` tinyint unsigned NOT NULL DEFAULT '1',
  `is_use_in_product_listing` tinyint unsigned NOT NULL DEFAULT '0',
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `order` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `use_image_from_product_variation` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_attribute_sets`
--

LOCK TABLES `ec_product_attribute_sets` WRITE;
/*!40000 ALTER TABLE `ec_product_attribute_sets` DISABLE KEYS */;
INSERT INTO `ec_product_attribute_sets` VALUES (1,'Color','color','visual',1,1,1,'published',0,'2026-02-28 08:15:12','2026-02-28 08:15:12',0),(2,'Size','size','text',1,1,1,'published',1,'2026-02-28 08:15:12','2026-02-28 08:15:12',0);
/*!40000 ALTER TABLE `ec_product_attribute_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_attribute_sets_translations`
--

DROP TABLE IF EXISTS `ec_product_attribute_sets_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_attribute_sets_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_product_attribute_sets_id` bigint unsigned NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_attribute_sets_id`),
  KEY `idx_product_attribute_sets_fk` (`ec_product_attribute_sets_id`),
  KEY `idx_product_attribute_sets_product_attribute_sets_lang` (`ec_product_attribute_sets_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_attribute_sets_translations`
--

LOCK TABLES `ec_product_attribute_sets_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_attribute_sets_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_attribute_sets_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_attributes`
--

DROP TABLE IF EXISTS `ec_product_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attribute_set_id` bigint unsigned NOT NULL,
  `title` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint unsigned NOT NULL DEFAULT '0',
  `order` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_set_status_index` (`attribute_set_id`),
  KEY `idx_attribute_set_id` (`attribute_set_id`),
  KEY `idx_attribute_set_order_id` (`attribute_set_id`,`order`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_attributes`
--

LOCK TABLES `ec_product_attributes` WRITE;
/*!40000 ALTER TABLE `ec_product_attributes` DISABLE KEYS */;
INSERT INTO `ec_product_attributes` VALUES (1,1,'Green','green','#5FB7D4',NULL,1,1,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(2,1,'Blue','blue','#333333',NULL,0,2,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(3,1,'Red','red','#DA323F',NULL,0,3,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(4,1,'Black','black','#2F366C',NULL,0,4,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(5,1,'Brown','brown','#87554B',NULL,0,5,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(6,2,'S','s',NULL,NULL,1,1,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(7,2,'M','m',NULL,NULL,0,2,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(8,2,'L','l',NULL,NULL,0,3,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(9,2,'XL','xl',NULL,NULL,0,4,'2026-02-28 08:15:12','2026-02-28 08:15:12'),(10,2,'XXL','xxl',NULL,NULL,0,5,'2026-02-28 08:15:12','2026-02-28 08:15:12');
/*!40000 ALTER TABLE `ec_product_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_attributes_translations`
--

DROP TABLE IF EXISTS `ec_product_attributes_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_attributes_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_product_attributes_id` bigint unsigned NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_attributes_id`),
  KEY `idx_product_attributes_fk` (`ec_product_attributes_id`),
  KEY `idx_product_attributes_product_attributes_lang` (`ec_product_attributes_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_attributes_translations`
--

LOCK TABLES `ec_product_attributes_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_attributes_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_attributes_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_categories`
--

DROP TABLE IF EXISTS `ec_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint unsigned NOT NULL DEFAULT '0',
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `order` int unsigned NOT NULL DEFAULT '0',
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_product_categories_parent_id_status_created_at_index` (`parent_id`,`status`,`created_at`),
  KEY `ec_product_categories_parent_id_status_index` (`parent_id`,`status`),
  KEY `idx_categories_status_order` (`status`,`order`),
  KEY `idx_categories_order` (`order`),
  KEY `ec_product_categories_slug_index` (`slug`),
  KEY `idx_ec_product_categories_status` (`status`),
  KEY `idx_ec_product_categories_parent_id` (`parent_id`),
  KEY `idx_ec_product_categories_status_parent_order` (`status`,`parent_id`,`order`),
  KEY `idx_ec_product_categories_is_featured` (`is_featured`),
  KEY `idx_ec_product_categories_name` (`name`),
  KEY `idx_ec_product_categories_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_categories`
--

LOCK TABLES `ec_product_categories` WRITE;
/*!40000 ALTER TABLE `ec_product_categories` DISABLE KEYS */;
INSERT INTO `ec_product_categories` VALUES (1,'Hot Promotions','hot-promotions',0,NULL,'published',0,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11','icon-star',NULL),(2,'Electronics','electronics',0,NULL,'published',1,'product-categories/1.jpg',1,'2026-02-28 08:15:11','2026-02-28 08:15:11','icon-laundry',NULL),(3,'Consumer Electronic','consumer-electronic',2,NULL,'published',0,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(4,'Home Audio & Theaters','home-audio-theaters',3,NULL,'published',0,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(5,'TV & Videos','tv-videos',3,NULL,'published',1,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(6,'Camera, Photos & Videos','camera-photos-videos',3,NULL,'published',2,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(7,'Cellphones & Accessories','cellphones-accessories',3,NULL,'published',3,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(8,'Headphones','headphones',3,NULL,'published',4,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(9,'Videos games','videos-games',3,NULL,'published',5,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(10,'Wireless Speakers','wireless-speakers',3,NULL,'published',6,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(11,'Office Electronic','office-electronic',3,NULL,'published',7,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,NULL),(12,'Accessories & Parts','accessories-parts',2,NULL,'published',1,NULL,0,'2026-02-28 08:15:11','2026-02-28 08:15:12',NULL,NULL),(13,'Digital Cables','digital-cables',12,NULL,'published',0,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(14,'Audio & Video Cables','audio-video-cables',12,NULL,'published',1,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(15,'Batteries','batteries',12,NULL,'published',2,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(16,'Clothing','clothing',0,NULL,'published',2,'product-categories/2.jpg',1,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-shirt',NULL),(17,'Computers','computers',0,NULL,'published',3,'product-categories/3.jpg',1,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-desktop',NULL),(18,'Computer & Technologies','computer-technologies',17,NULL,'published',0,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(19,'Computer & Tablets','computer-tablets',18,NULL,'published',0,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(20,'Laptop','laptop',18,NULL,'published',1,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(21,'Monitors','monitors',18,NULL,'published',2,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(22,'Computer Components','computer-components',18,NULL,'published',3,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(23,'Networking','networking',17,NULL,'published',1,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(24,'Drive & Storages','drive-storages',23,NULL,'published',0,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(25,'Gaming Laptop','gaming-laptop',23,NULL,'published',1,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(26,'Security & Protection','security-protection',23,NULL,'published',2,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(27,'Accessories','accessories',23,NULL,'published',3,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,NULL),(28,'Home & Kitchen','home-kitchen',0,NULL,'published',4,'product-categories/4.jpg',1,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-lampshade',NULL),(29,'Health & Beauty','health-beauty',0,NULL,'published',5,'product-categories/5.jpg',1,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-heart-pulse',NULL),(30,'Jewelry & Watch','jewelry-watch',0,NULL,'published',6,'product-categories/6.jpg',1,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-diamond2',NULL),(31,'Technology Toys','technology-toys',0,NULL,'published',7,'product-categories/7.jpg',1,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-desktop',NULL),(32,'Phones','phones',0,NULL,'published',8,'product-categories/8.jpg',1,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-smartphone',NULL),(33,'Babies & Moms','babies-moms',0,NULL,'published',9,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-baby-bottle',NULL),(34,'Sport & Outdoor','sport-outdoor',0,NULL,'published',10,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-baseball',NULL),(35,'Books & Office','books-office',0,NULL,'published',11,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-book2',NULL),(36,'Cars & Motorcycles','cars-motorcycles',0,NULL,'published',12,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-car-siren',NULL),(37,'Home Improvements','home-improvements',0,NULL,'published',13,NULL,0,'2026-02-28 08:15:12','2026-02-28 08:15:12','icon-wrench',NULL);
/*!40000 ALTER TABLE `ec_product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_categories_translations`
--

DROP TABLE IF EXISTS `ec_product_categories_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_categories_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_product_categories_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`lang_code`,`ec_product_categories_id`),
  KEY `idx_product_categories_fk` (`ec_product_categories_id`),
  KEY `idx_product_categories_product_categories_lang` (`ec_product_categories_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_categories_translations`
--

LOCK TABLES `ec_product_categories_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_categories_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_categories_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_categorizables`
--

DROP TABLE IF EXISTS `ec_product_categorizables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_categorizables` (
  `category_id` bigint unsigned NOT NULL,
  `reference_id` bigint unsigned NOT NULL,
  `reference_type` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`,`reference_id`,`reference_type`),
  KEY `ec_product_categorizables_category_id_index` (`category_id`),
  KEY `ec_product_categorizables_reference_id_index` (`reference_id`),
  KEY `ec_product_categorizables_reference_type_index` (`reference_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_categorizables`
--

LOCK TABLES `ec_product_categorizables` WRITE;
/*!40000 ALTER TABLE `ec_product_categorizables` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_categorizables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_category_product`
--

DROP TABLE IF EXISTS `ec_product_category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_category_product` (
  `category_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `ec_product_category_product_category_id_index` (`category_id`),
  KEY `ec_product_category_product_product_id_index` (`product_id`),
  KEY `idx_product_category` (`product_id`,`category_id`),
  KEY `idx_product_id_category_id` (`product_id`,`category_id`),
  KEY `idx_product_category_composite` (`product_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_category_product`
--

LOCK TABLES `ec_product_category_product` WRITE;
/*!40000 ALTER TABLE `ec_product_category_product` DISABLE KEYS */;
INSERT INTO `ec_product_category_product` VALUES (1,8),(1,21),(1,25),(2,4),(2,10),(2,11),(2,29),(2,37),(2,39),(3,4),(3,13),(3,15),(3,19),(3,24),(3,40),(3,46),(3,53),(4,17),(4,19),(4,24),(4,33),(4,39),(4,40),(4,41),(4,42),(4,52),(5,8),(5,20),(5,25),(5,32),(5,45),(5,48),(6,14),(6,16),(6,25),(6,31),(6,34),(6,47),(7,11),(7,15),(7,32),(7,33),(7,49),(8,5),(8,29),(8,34),(8,45),(8,53),(9,20),(9,24),(9,29),(9,50),(10,24),(10,35),(10,38),(10,45),(10,47),(10,50),(10,51),(11,8),(11,13),(11,16),(11,27),(11,35),(12,2),(12,4),(12,9),(12,21),(13,17),(13,21),(13,38),(13,46),(13,50),(14,20),(14,22),(14,30),(14,46),(14,48),(15,7),(15,9),(15,33),(15,42),(16,1),(16,2),(16,3),(16,6),(16,7),(16,8),(16,17),(16,18),(16,23),(16,43),(17,1),(17,7),(17,12),(17,15),(17,27),(17,47),(18,18),(18,28),(18,47),(18,53),(19,2),(19,36),(19,37),(19,41),(20,9),(20,13),(20,30),(21,5),(21,20),(21,22),(21,31),(21,38),(22,3),(22,4),(22,6),(22,12),(22,14),(22,25),(22,36),(22,41),(22,42),(22,51),(22,54),(23,1),(24,22),(24,26),(24,28),(24,40),(24,44),(24,51),(25,30),(25,44),(25,46),(25,49),(25,54),(26,3),(26,5),(26,10),(26,14),(26,29),(26,33),(26,52),(27,11),(27,14),(27,16),(27,35),(27,36),(27,37),(27,43),(27,44),(28,18),(28,27),(28,43),(28,53),(29,6),(29,13),(29,19),(29,26),(29,28),(29,31),(29,54),(30,9),(30,12),(30,21),(30,23),(30,39),(30,45),(31,1),(31,5),(31,10),(31,16),(31,19),(31,26),(31,32),(31,34),(31,48),(32,36),(32,37),(32,42),(32,50),(32,52),(32,54),(33,3),(33,6),(33,23),(33,32),(33,48),(33,49),(34,10),(34,31),(34,35),(34,40),(34,44),(34,49),(34,51),(34,52),(35,17),(35,41),(35,43),(36,2),(36,7),(36,11),(36,15),(36,22),(36,23),(36,26),(36,27),(37,12),(37,18),(37,28),(37,30),(37,34),(37,38),(37,39);
/*!40000 ALTER TABLE `ec_product_category_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_collection_products`
--

DROP TABLE IF EXISTS `ec_product_collection_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_collection_products` (
  `product_collection_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`product_collection_id`),
  KEY `ec_product_collection_products_product_collection_id_index` (`product_collection_id`),
  KEY `ec_product_collection_products_product_id_index` (`product_id`),
  KEY `idx_product_id_collection_id` (`product_id`,`product_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_collection_products`
--

LOCK TABLES `ec_product_collection_products` WRITE;
/*!40000 ALTER TABLE `ec_product_collection_products` DISABLE KEYS */;
INSERT INTO `ec_product_collection_products` VALUES (1,1),(1,6),(1,13),(1,15),(1,20),(1,27),(1,29),(1,30),(1,31),(1,33),(1,39),(1,41),(1,54),(2,2),(2,3),(2,4),(2,7),(2,8),(2,9),(2,10),(2,17),(2,18),(2,19),(2,22),(2,26),(2,32),(2,34),(2,35),(2,37),(2,38),(2,40),(2,42),(2,44),(2,45),(2,46),(2,47),(2,49),(2,50),(2,51),(2,52),(2,53),(3,5),(3,11),(3,12),(3,14),(3,16),(3,21),(3,23),(3,24),(3,25),(3,28),(3,36),(3,43),(3,48);
/*!40000 ALTER TABLE `ec_product_collection_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_collections`
--

DROP TABLE IF EXISTS `ec_product_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_collections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_featured` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_collections`
--

LOCK TABLES `ec_product_collections` WRITE;
/*!40000 ALTER TABLE `ec_product_collections` DISABLE KEYS */;
INSERT INTO `ec_product_collections` VALUES (1,'New Arrival','new-arrival',NULL,NULL,'published','2026-02-28 08:15:12','2026-02-28 08:15:12',0),(2,'Best Sellers','best-sellers',NULL,NULL,'published','2026-02-28 08:15:12','2026-02-28 08:15:12',0),(3,'Special Offer','special-offer',NULL,NULL,'published','2026-02-28 08:15:12','2026-02-28 08:15:12',0);
/*!40000 ALTER TABLE `ec_product_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_collections_translations`
--

DROP TABLE IF EXISTS `ec_product_collections_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_collections_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_product_collections_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_collections_id`),
  KEY `idx_product_collections_fk` (`ec_product_collections_id`),
  KEY `idx_product_collections_product_collections_lang` (`ec_product_collections_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_collections_translations`
--

LOCK TABLES `ec_product_collections_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_collections_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_collections_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_cross_sale_relations`
--

DROP TABLE IF EXISTS `ec_product_cross_sale_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_cross_sale_relations` (
  `from_product_id` bigint unsigned NOT NULL,
  `to_product_id` bigint unsigned NOT NULL,
  `is_variant` tinyint(1) NOT NULL DEFAULT '0',
  `price` decimal(15,2) DEFAULT '0.00',
  `price_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `apply_to_all_variations` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`from_product_id`,`to_product_id`),
  KEY `ec_product_cross_sale_relations_from_product_id_index` (`from_product_id`),
  KEY `ec_product_cross_sale_relations_to_product_id_index` (`to_product_id`),
  KEY `idx_product_cross_sale` (`from_product_id`,`to_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_cross_sale_relations`
--

LOCK TABLES `ec_product_cross_sale_relations` WRITE;
/*!40000 ALTER TABLE `ec_product_cross_sale_relations` DISABLE KEYS */;
INSERT INTO `ec_product_cross_sale_relations` VALUES (1,7,0,0.00,'fixed',1),(1,25,0,0.00,'fixed',1),(1,29,0,0.00,'fixed',1),(1,34,0,0.00,'fixed',1),(1,45,0,0.00,'fixed',1),(1,47,0,0.00,'fixed',1),(2,6,0,0.00,'fixed',1),(2,30,0,0.00,'fixed',1),(2,40,0,0.00,'fixed',1),(2,42,0,0.00,'fixed',1),(2,48,0,0.00,'fixed',1),(2,51,0,0.00,'fixed',1),(2,54,0,0.00,'fixed',1),(3,5,0,0.00,'fixed',1),(3,7,0,0.00,'fixed',1),(3,8,0,0.00,'fixed',1),(3,26,0,0.00,'fixed',1),(3,38,0,0.00,'fixed',1),(3,52,0,0.00,'fixed',1),(4,1,0,0.00,'fixed',1),(4,12,0,0.00,'fixed',1),(4,22,0,0.00,'fixed',1),(4,48,0,0.00,'fixed',1),(4,51,0,0.00,'fixed',1),(5,2,0,0.00,'fixed',1),(5,7,0,0.00,'fixed',1),(5,16,0,0.00,'fixed',1),(5,30,0,0.00,'fixed',1),(5,33,0,0.00,'fixed',1),(5,40,0,0.00,'fixed',1),(5,51,0,0.00,'fixed',1),(6,5,0,0.00,'fixed',1),(6,7,0,0.00,'fixed',1),(6,22,0,0.00,'fixed',1),(6,24,0,0.00,'fixed',1),(6,25,0,0.00,'fixed',1),(6,46,0,0.00,'fixed',1),(6,48,0,0.00,'fixed',1),(7,8,0,0.00,'fixed',1),(7,16,0,0.00,'fixed',1),(7,31,0,0.00,'fixed',1),(7,35,0,0.00,'fixed',1),(7,43,0,0.00,'fixed',1),(7,53,0,0.00,'fixed',1),(8,10,0,0.00,'fixed',1),(8,16,0,0.00,'fixed',1),(8,17,0,0.00,'fixed',1),(8,22,0,0.00,'fixed',1),(8,41,0,0.00,'fixed',1),(8,50,0,0.00,'fixed',1),(8,54,0,0.00,'fixed',1),(9,18,0,0.00,'fixed',1),(9,20,0,0.00,'fixed',1),(9,50,0,0.00,'fixed',1),(9,52,0,0.00,'fixed',1),(9,53,0,0.00,'fixed',1),(10,14,0,0.00,'fixed',1),(10,17,0,0.00,'fixed',1),(10,22,0,0.00,'fixed',1),(10,32,0,0.00,'fixed',1),(10,40,0,0.00,'fixed',1),(10,43,0,0.00,'fixed',1),(10,53,0,0.00,'fixed',1),(11,20,0,0.00,'fixed',1),(11,29,0,0.00,'fixed',1),(11,30,0,0.00,'fixed',1),(11,33,0,0.00,'fixed',1),(11,40,0,0.00,'fixed',1),(11,52,0,0.00,'fixed',1),(12,10,0,0.00,'fixed',1),(12,20,0,0.00,'fixed',1),(12,32,0,0.00,'fixed',1),(12,35,0,0.00,'fixed',1),(12,40,0,0.00,'fixed',1),(12,42,0,0.00,'fixed',1),(12,49,0,0.00,'fixed',1),(13,2,0,0.00,'fixed',1),(13,6,0,0.00,'fixed',1),(13,26,0,0.00,'fixed',1),(13,34,0,0.00,'fixed',1),(13,49,0,0.00,'fixed',1),(14,7,0,0.00,'fixed',1),(14,18,0,0.00,'fixed',1),(14,30,0,0.00,'fixed',1),(14,31,0,0.00,'fixed',1),(14,32,0,0.00,'fixed',1),(14,41,0,0.00,'fixed',1),(14,48,0,0.00,'fixed',1),(15,8,0,0.00,'fixed',1),(15,12,0,0.00,'fixed',1),(15,18,0,0.00,'fixed',1),(15,24,0,0.00,'fixed',1),(15,30,0,0.00,'fixed',1),(15,39,0,0.00,'fixed',1),(15,44,0,0.00,'fixed',1),(16,2,0,0.00,'fixed',1),(16,4,0,0.00,'fixed',1),(16,23,0,0.00,'fixed',1),(16,28,0,0.00,'fixed',1),(16,37,0,0.00,'fixed',1),(16,38,0,0.00,'fixed',1),(16,45,0,0.00,'fixed',1),(17,5,0,0.00,'fixed',1),(17,11,0,0.00,'fixed',1),(17,12,0,0.00,'fixed',1),(17,26,0,0.00,'fixed',1),(17,46,0,0.00,'fixed',1),(17,48,0,0.00,'fixed',1),(18,14,0,0.00,'fixed',1),(18,20,0,0.00,'fixed',1),(18,22,0,0.00,'fixed',1),(18,23,0,0.00,'fixed',1),(18,27,0,0.00,'fixed',1),(18,40,0,0.00,'fixed',1),(18,48,0,0.00,'fixed',1),(19,16,0,0.00,'fixed',1),(19,24,0,0.00,'fixed',1),(19,30,0,0.00,'fixed',1),(19,35,0,0.00,'fixed',1),(19,37,0,0.00,'fixed',1),(19,51,0,0.00,'fixed',1),(20,6,0,0.00,'fixed',1),(20,23,0,0.00,'fixed',1),(20,25,0,0.00,'fixed',1),(20,37,0,0.00,'fixed',1),(20,39,0,0.00,'fixed',1),(20,43,0,0.00,'fixed',1),(20,53,0,0.00,'fixed',1),(21,16,0,0.00,'fixed',1),(21,34,0,0.00,'fixed',1),(21,39,0,0.00,'fixed',1),(21,42,0,0.00,'fixed',1),(21,43,0,0.00,'fixed',1),(21,44,0,0.00,'fixed',1),(21,53,0,0.00,'fixed',1),(22,4,0,0.00,'fixed',1),(22,10,0,0.00,'fixed',1),(22,16,0,0.00,'fixed',1),(22,34,0,0.00,'fixed',1),(22,39,0,0.00,'fixed',1),(23,7,0,0.00,'fixed',1),(23,12,0,0.00,'fixed',1),(23,18,0,0.00,'fixed',1),(23,20,0,0.00,'fixed',1),(23,22,0,0.00,'fixed',1),(23,37,0,0.00,'fixed',1),(23,39,0,0.00,'fixed',1),(24,8,0,0.00,'fixed',1),(24,9,0,0.00,'fixed',1),(24,14,0,0.00,'fixed',1),(24,17,0,0.00,'fixed',1),(24,22,0,0.00,'fixed',1),(24,27,0,0.00,'fixed',1),(24,38,0,0.00,'fixed',1),(25,12,0,0.00,'fixed',1),(25,16,0,0.00,'fixed',1),(25,22,0,0.00,'fixed',1),(25,31,0,0.00,'fixed',1),(25,40,0,0.00,'fixed',1),(25,43,0,0.00,'fixed',1),(26,4,0,0.00,'fixed',1),(26,6,0,0.00,'fixed',1),(26,12,0,0.00,'fixed',1),(26,18,0,0.00,'fixed',1),(26,23,0,0.00,'fixed',1),(26,33,0,0.00,'fixed',1),(26,44,0,0.00,'fixed',1),(27,1,0,0.00,'fixed',1),(27,14,0,0.00,'fixed',1),(27,31,0,0.00,'fixed',1),(27,38,0,0.00,'fixed',1),(27,43,0,0.00,'fixed',1),(27,45,0,0.00,'fixed',1),(27,50,0,0.00,'fixed',1),(28,8,0,0.00,'fixed',1),(28,23,0,0.00,'fixed',1),(28,24,0,0.00,'fixed',1),(28,40,0,0.00,'fixed',1),(28,42,0,0.00,'fixed',1),(28,44,0,0.00,'fixed',1),(29,10,0,0.00,'fixed',1),(29,12,0,0.00,'fixed',1),(29,16,0,0.00,'fixed',1),(29,19,0,0.00,'fixed',1),(29,26,0,0.00,'fixed',1),(29,41,0,0.00,'fixed',1),(30,4,0,0.00,'fixed',1),(30,16,0,0.00,'fixed',1),(30,18,0,0.00,'fixed',1),(30,21,0,0.00,'fixed',1),(30,27,0,0.00,'fixed',1),(30,43,0,0.00,'fixed',1),(31,5,0,0.00,'fixed',1),(31,20,0,0.00,'fixed',1),(31,21,0,0.00,'fixed',1),(31,41,0,0.00,'fixed',1),(32,2,0,0.00,'fixed',1),(32,16,0,0.00,'fixed',1),(32,17,0,0.00,'fixed',1),(32,20,0,0.00,'fixed',1),(32,26,0,0.00,'fixed',1),(32,36,0,0.00,'fixed',1),(33,1,0,0.00,'fixed',1),(33,8,0,0.00,'fixed',1),(33,13,0,0.00,'fixed',1),(33,19,0,0.00,'fixed',1),(33,26,0,0.00,'fixed',1),(33,45,0,0.00,'fixed',1),(33,50,0,0.00,'fixed',1),(34,28,0,0.00,'fixed',1),(34,30,0,0.00,'fixed',1),(34,31,0,0.00,'fixed',1),(34,32,0,0.00,'fixed',1),(34,33,0,0.00,'fixed',1),(34,37,0,0.00,'fixed',1),(34,50,0,0.00,'fixed',1),(35,1,0,0.00,'fixed',1),(35,2,0,0.00,'fixed',1),(35,11,0,0.00,'fixed',1),(35,23,0,0.00,'fixed',1),(35,25,0,0.00,'fixed',1),(35,36,0,0.00,'fixed',1),(35,47,0,0.00,'fixed',1),(36,3,0,0.00,'fixed',1),(36,29,0,0.00,'fixed',1),(36,40,0,0.00,'fixed',1),(36,47,0,0.00,'fixed',1),(36,48,0,0.00,'fixed',1),(36,52,0,0.00,'fixed',1),(37,4,0,0.00,'fixed',1),(37,8,0,0.00,'fixed',1),(37,19,0,0.00,'fixed',1),(37,24,0,0.00,'fixed',1),(37,45,0,0.00,'fixed',1),(37,51,0,0.00,'fixed',1),(38,1,0,0.00,'fixed',1),(38,5,0,0.00,'fixed',1),(38,6,0,0.00,'fixed',1),(38,8,0,0.00,'fixed',1),(38,15,0,0.00,'fixed',1),(38,33,0,0.00,'fixed',1),(38,37,0,0.00,'fixed',1),(39,14,0,0.00,'fixed',1),(39,18,0,0.00,'fixed',1),(39,20,0,0.00,'fixed',1),(39,29,0,0.00,'fixed',1),(39,36,0,0.00,'fixed',1),(39,37,0,0.00,'fixed',1),(39,45,0,0.00,'fixed',1),(40,1,0,0.00,'fixed',1),(40,2,0,0.00,'fixed',1),(40,8,0,0.00,'fixed',1),(40,19,0,0.00,'fixed',1),(40,20,0,0.00,'fixed',1),(40,41,0,0.00,'fixed',1),(40,50,0,0.00,'fixed',1),(41,4,0,0.00,'fixed',1),(41,10,0,0.00,'fixed',1),(41,11,0,0.00,'fixed',1),(41,14,0,0.00,'fixed',1),(41,24,0,0.00,'fixed',1),(41,33,0,0.00,'fixed',1),(41,52,0,0.00,'fixed',1),(42,9,0,0.00,'fixed',1),(42,18,0,0.00,'fixed',1),(42,26,0,0.00,'fixed',1),(42,29,0,0.00,'fixed',1),(42,43,0,0.00,'fixed',1),(42,51,0,0.00,'fixed',1),(43,10,0,0.00,'fixed',1),(43,12,0,0.00,'fixed',1),(43,14,0,0.00,'fixed',1),(43,29,0,0.00,'fixed',1),(43,32,0,0.00,'fixed',1),(43,41,0,0.00,'fixed',1),(43,54,0,0.00,'fixed',1),(44,1,0,0.00,'fixed',1),(44,14,0,0.00,'fixed',1),(44,28,0,0.00,'fixed',1),(44,35,0,0.00,'fixed',1),(44,37,0,0.00,'fixed',1),(44,47,0,0.00,'fixed',1),(44,50,0,0.00,'fixed',1),(45,3,0,0.00,'fixed',1),(45,5,0,0.00,'fixed',1),(45,27,0,0.00,'fixed',1),(45,33,0,0.00,'fixed',1),(45,37,0,0.00,'fixed',1),(45,48,0,0.00,'fixed',1),(45,54,0,0.00,'fixed',1),(46,3,0,0.00,'fixed',1),(46,4,0,0.00,'fixed',1),(46,9,0,0.00,'fixed',1),(46,36,0,0.00,'fixed',1),(46,42,0,0.00,'fixed',1),(46,45,0,0.00,'fixed',1),(46,48,0,0.00,'fixed',1),(47,2,0,0.00,'fixed',1),(47,15,0,0.00,'fixed',1),(47,21,0,0.00,'fixed',1),(47,26,0,0.00,'fixed',1),(47,43,0,0.00,'fixed',1),(47,44,0,0.00,'fixed',1),(47,52,0,0.00,'fixed',1),(48,10,0,0.00,'fixed',1),(48,12,0,0.00,'fixed',1),(48,16,0,0.00,'fixed',1),(48,31,0,0.00,'fixed',1),(48,35,0,0.00,'fixed',1),(48,49,0,0.00,'fixed',1),(48,54,0,0.00,'fixed',1),(49,6,0,0.00,'fixed',1),(49,19,0,0.00,'fixed',1),(49,22,0,0.00,'fixed',1),(49,33,0,0.00,'fixed',1),(49,34,0,0.00,'fixed',1),(49,41,0,0.00,'fixed',1),(49,51,0,0.00,'fixed',1),(50,5,0,0.00,'fixed',1),(50,26,0,0.00,'fixed',1),(50,27,0,0.00,'fixed',1),(50,41,0,0.00,'fixed',1),(50,44,0,0.00,'fixed',1),(50,46,0,0.00,'fixed',1),(51,14,0,0.00,'fixed',1),(51,18,0,0.00,'fixed',1),(51,23,0,0.00,'fixed',1),(51,24,0,0.00,'fixed',1),(51,26,0,0.00,'fixed',1),(51,46,0,0.00,'fixed',1),(51,52,0,0.00,'fixed',1),(52,15,0,0.00,'fixed',1),(52,26,0,0.00,'fixed',1),(52,27,0,0.00,'fixed',1),(52,49,0,0.00,'fixed',1),(52,50,0,0.00,'fixed',1),(52,51,0,0.00,'fixed',1),(53,8,0,0.00,'fixed',1),(53,12,0,0.00,'fixed',1),(53,19,0,0.00,'fixed',1),(53,30,0,0.00,'fixed',1),(53,40,0,0.00,'fixed',1),(53,54,0,0.00,'fixed',1),(54,13,0,0.00,'fixed',1),(54,26,0,0.00,'fixed',1),(54,29,0,0.00,'fixed',1),(54,32,0,0.00,'fixed',1),(54,40,0,0.00,'fixed',1),(54,51,0,0.00,'fixed',1),(54,52,0,0.00,'fixed',1);
/*!40000 ALTER TABLE `ec_product_cross_sale_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_files`
--

DROP TABLE IF EXISTS `ec_product_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_files` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned DEFAULT NULL,
  `url` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extras` mediumtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_product_files_product_id_index` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_files`
--

LOCK TABLES `ec_product_files` WRITE;
/*!40000 ALTER TABLE `ec_product_files` DISABLE KEYS */;
INSERT INTO `ec_product_files` VALUES (1,4,'ecommerce/digital-product-files/4-1.jpg','{\"filename\":\"4-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/4-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"4-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(2,4,'ecommerce/digital-product-files/4-2.jpg','{\"filename\":\"4-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/4-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"4-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(3,8,'ecommerce/digital-product-files/8-1.jpg','{\"filename\":\"8-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/8-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"8-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(4,8,'ecommerce/digital-product-files/8-2.jpg','{\"filename\":\"8-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/8-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"8-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(5,12,'ecommerce/digital-product-files/12-1.jpg','{\"filename\":\"12-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/12-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"12-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(6,12,'ecommerce/digital-product-files/12-2.jpg','{\"filename\":\"12-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/12-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"12-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(7,16,'ecommerce/digital-product-files/16-1.jpg','{\"filename\":\"16-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/16-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"16-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(8,16,'ecommerce/digital-product-files/16-2.jpg','{\"filename\":\"16-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/16-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"16-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(9,20,'ecommerce/digital-product-files/20-1.jpg','{\"filename\":\"20-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/20-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"20-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(10,20,'ecommerce/digital-product-files/20-2.jpg','{\"filename\":\"20-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/20-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"20-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(11,24,'ecommerce/digital-product-files/24-1.jpg','{\"filename\":\"24-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/24-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"24-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(12,24,'ecommerce/digital-product-files/24-2.jpg','{\"filename\":\"24-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/24-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"24-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(13,28,'ecommerce/digital-product-files/28-1.jpg','{\"filename\":\"28-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/28-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"28-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(14,28,'ecommerce/digital-product-files/28-2.jpg','{\"filename\":\"28-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/28-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"28-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(15,32,'ecommerce/digital-product-files/32-1.jpg','{\"filename\":\"32-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/32-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"32-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(16,32,'ecommerce/digital-product-files/32-2.jpg','{\"filename\":\"32-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/32-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"32-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(17,36,'ecommerce/digital-product-files/36-1.jpg','{\"filename\":\"36-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/36-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"36-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(18,36,'ecommerce/digital-product-files/36-2.jpg','{\"filename\":\"36-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/36-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"36-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(19,40,'ecommerce/digital-product-files/40-1.jpg','{\"filename\":\"40-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/40-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"40-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(20,40,'ecommerce/digital-product-files/40-2.jpg','{\"filename\":\"40-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/40-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"40-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(21,44,'ecommerce/digital-product-files/44-1.jpg','{\"filename\":\"44-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/44-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"44-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(22,44,'ecommerce/digital-product-files/44-2.jpg','{\"filename\":\"44-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/44-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"44-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(23,48,'ecommerce/digital-product-files/48-1.jpg','{\"filename\":\"48-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/48-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"48-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(24,48,'ecommerce/digital-product-files/48-2.jpg','{\"filename\":\"48-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/48-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"48-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(25,52,'ecommerce/digital-product-files/52-1.jpg','{\"filename\":\"52-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/52-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"52-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(26,52,'ecommerce/digital-product-files/52-2.jpg','{\"filename\":\"52-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/52-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"52-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(27,65,'ecommerce/digital-product-files/16-2.jpg','{\"filename\":\"16-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/16-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"16-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(28,66,'ecommerce/digital-product-files/16-3.jpg','{\"filename\":\"16-3.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/16-3.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"16-3\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(29,67,'ecommerce/digital-product-files/16-4.jpg','{\"filename\":\"16-4.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/16-4.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"16-4\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(30,70,'ecommerce/digital-product-files/20-2.jpg','{\"filename\":\"20-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/20-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"20-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(31,71,'ecommerce/digital-product-files/20-3.jpg','{\"filename\":\"20-3.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/20-3.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"20-3\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(32,72,'ecommerce/digital-product-files/20-4.jpg','{\"filename\":\"20-4.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/20-4.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"20-4\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(33,73,'ecommerce/digital-product-files/20-1.jpg','{\"filename\":\"20-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/20-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"20-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(34,79,'ecommerce/digital-product-files/24-2.jpg','{\"filename\":\"24-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/24-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"24-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(35,80,'ecommerce/digital-product-files/24-3.jpg','{\"filename\":\"24-3.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/24-3.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"24-3\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(36,90,'ecommerce/digital-product-files/36-2.jpg','{\"filename\":\"36-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/36-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"36-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(37,91,'ecommerce/digital-product-files/36-3.jpg','{\"filename\":\"36-3.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/36-3.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"36-3\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(38,107,'ecommerce/digital-product-files/44-2.jpg','{\"filename\":\"44-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/44-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"44-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(39,108,'ecommerce/digital-product-files/44-3.jpg','{\"filename\":\"44-3.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/44-3.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:29\",\"name\":\"44-3\",\"extension\":\"jpg\"}','2026-02-28 08:15:29','2026-02-28 08:15:29'),(40,109,'ecommerce/digital-product-files/44-1.jpg','{\"filename\":\"44-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/44-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:30\",\"name\":\"44-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:30','2026-02-28 08:15:30'),(41,115,'ecommerce/digital-product-files/48-2.jpg','{\"filename\":\"48-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/48-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:30\",\"name\":\"48-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:30','2026-02-28 08:15:30'),(42,116,'ecommerce/digital-product-files/48-3.jpg','{\"filename\":\"48-3.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/48-3.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:30\",\"name\":\"48-3\",\"extension\":\"jpg\"}','2026-02-28 08:15:30','2026-02-28 08:15:30'),(43,117,'ecommerce/digital-product-files/48-4.jpg','{\"filename\":\"48-4.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/48-4.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:30\",\"name\":\"48-4\",\"extension\":\"jpg\"}','2026-02-28 08:15:30','2026-02-28 08:15:30'),(44,118,'ecommerce/digital-product-files/48-1.jpg','{\"filename\":\"48-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/48-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:30\",\"name\":\"48-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:30','2026-02-28 08:15:30'),(45,119,'ecommerce/digital-product-files/48-1.jpg','{\"filename\":\"48-1.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/48-1.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:30\",\"name\":\"48-1\",\"extension\":\"jpg\"}','2026-02-28 08:15:30','2026-02-28 08:15:30'),(46,126,'ecommerce/digital-product-files/52-2.jpg','{\"filename\":\"52-2.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/52-2.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:30\",\"name\":\"52-2\",\"extension\":\"jpg\"}','2026-02-28 08:15:30','2026-02-28 08:15:30'),(47,127,'ecommerce/digital-product-files/52-3.jpg','{\"filename\":\"52-3.jpg\",\"url\":\"ecommerce\\/digital-product-files\\/52-3.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":9803,\"modified\":\"2026-02-28 15:15:30\",\"name\":\"52-3\",\"extension\":\"jpg\"}','2026-02-28 08:15:30','2026-02-28 08:15:30');
/*!40000 ALTER TABLE `ec_product_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_label_products`
--

DROP TABLE IF EXISTS `ec_product_label_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_label_products` (
  `product_label_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`product_label_id`,`product_id`),
  KEY `ec_product_label_products_product_label_id_index` (`product_label_id`),
  KEY `ec_product_label_products_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_label_products`
--

LOCK TABLES `ec_product_label_products` WRITE;
/*!40000 ALTER TABLE `ec_product_label_products` DISABLE KEYS */;
INSERT INTO `ec_product_label_products` VALUES (1,3),(1,18),(1,21),(1,27),(1,30),(1,48),(1,51),(2,9),(2,15),(2,33),(2,39),(2,42),(2,45),(3,6),(3,12),(3,24),(3,36),(3,54);
/*!40000 ALTER TABLE `ec_product_label_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_labels`
--

DROP TABLE IF EXISTS `ec_product_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_labels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `text_color` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_product_labels_status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_labels`
--

LOCK TABLES `ec_product_labels` WRITE;
/*!40000 ALTER TABLE `ec_product_labels` DISABLE KEYS */;
INSERT INTO `ec_product_labels` VALUES (1,'Hot','#d71e2d','published','2026-02-28 08:15:12','2026-02-28 08:15:12','#ffffff'),(2,'New','#02856e','published','2026-02-28 08:15:12','2026-02-28 08:15:12','#ffffff'),(3,'Sale','#fe9931','published','2026-02-28 08:15:12','2026-02-28 08:15:12','#ffffff');
/*!40000 ALTER TABLE `ec_product_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_labels_translations`
--

DROP TABLE IF EXISTS `ec_product_labels_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_labels_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_product_labels_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_labels_id`),
  KEY `idx_product_labels_fk` (`ec_product_labels_id`),
  KEY `idx_product_labels_product_labels_lang` (`ec_product_labels_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_labels_translations`
--

LOCK TABLES `ec_product_labels_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_labels_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_labels_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_license_codes`
--

DROP TABLE IF EXISTS `ec_product_license_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_license_codes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `license_code` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `assigned_order_product_id` bigint unsigned DEFAULT NULL,
  `assigned_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_product_license_codes_product_id_status_index` (`product_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_license_codes`
--

LOCK TABLES `ec_product_license_codes` WRITE;
/*!40000 ALTER TABLE `ec_product_license_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_license_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_related_relations`
--

DROP TABLE IF EXISTS `ec_product_related_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_related_relations` (
  `from_product_id` bigint unsigned NOT NULL,
  `to_product_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`from_product_id`,`to_product_id`),
  KEY `ec_product_related_relations_from_product_id_index` (`from_product_id`),
  KEY `ec_product_related_relations_to_product_id_index` (`to_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_related_relations`
--

LOCK TABLES `ec_product_related_relations` WRITE;
/*!40000 ALTER TABLE `ec_product_related_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_related_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_specification_attribute`
--

DROP TABLE IF EXISTS `ec_product_specification_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_specification_attribute` (
  `product_id` bigint unsigned NOT NULL,
  `attribute_id` bigint unsigned NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `order` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_specification_attribute`
--

LOCK TABLES `ec_product_specification_attribute` WRITE;
/*!40000 ALTER TABLE `ec_product_specification_attribute` DISABLE KEYS */;
INSERT INTO `ec_product_specification_attribute` VALUES (1,6,'58.2 cm',0,0),(1,7,'27.51 cm',0,0),(1,8,'1920x1080',0,0),(2,6,'44.95 cm',0,0),(2,7,'63.25 cm',0,0),(2,8,'3840x2160',0,0),(3,1,'6.14 cm',0,0),(3,2,'31.05 cm',0,0),(3,3,'79.51 cm',0,0),(3,4,'74.82 cm',0,0),(3,5,'6.81 cm',0,0),(4,1,'97.62 cm',0,0),(4,2,'43.35 cm',0,0),(4,3,'78.29 cm',0,0),(4,4,'64.87 cm',0,0),(4,5,'22.11 cm',0,0),(5,6,'89.56 cm',0,0),(5,7,'61.6 cm',0,0),(5,8,'1920x1080',0,0),(6,6,'72.2 cm',0,0),(6,7,'81.67 cm',0,0),(6,8,'3840x2160',0,0),(7,6,'95.98 cm',0,0),(7,7,'19.76 cm',0,0),(7,8,'2560x1440',0,0),(8,1,'21 cm',0,0),(8,2,'69 cm',0,0),(8,3,'90.89 cm',0,0),(8,4,'42.97 cm',0,0),(8,5,'46.1 cm',0,0),(9,6,'30.9 cm',0,0),(9,7,'13.08 cm',0,0),(9,8,'1920x1080',0,0),(10,1,'94.06 cm',0,0),(10,2,'7.48 cm',0,0),(10,3,'35.87 cm',0,0),(10,4,'92.16 cm',0,0),(10,5,'45.54 cm',0,0),(11,6,'35.14 cm',0,0),(11,7,'28.75 cm',0,0),(11,8,'3840x2160',0,0),(12,1,'53.47 cm',0,0),(12,2,'8.11 cm',0,0),(12,3,'51.3 cm',0,0),(12,4,'8.58 cm',0,0),(12,5,'30.49 cm',0,0),(13,6,'41.44 cm',0,0),(13,7,'31.24 cm',0,0),(13,8,'1920x1080',0,0),(14,1,'65.17 cm',0,0),(14,2,'81.84 cm',0,0),(14,3,'66.26 cm',0,0),(14,4,'65.72 cm',0,0),(14,5,'92.19 cm',0,0),(15,1,'8.93 cm',0,0),(15,2,'94.99 cm',0,0),(15,3,'60.4 cm',0,0),(15,4,'38.5 cm',0,0),(15,5,'87.31 cm',0,0),(16,6,'64.54 cm',0,0),(16,7,'97.94 cm',0,0),(16,8,'2560x1440',0,0),(17,6,'70.63 cm',0,0),(17,7,'5.24 cm',0,0),(17,8,'2560x1440',0,0),(18,6,'88.35 cm',0,0),(18,7,'50.78 cm',0,0),(18,8,'3840x2160',0,0),(19,6,'37.62 cm',0,0),(19,7,'53.19 cm',0,0),(19,8,'1920x1080',0,0),(20,6,'72.8 cm',0,0),(20,7,'42.84 cm',0,0),(20,8,'1920x1080',0,0),(21,6,'47.77 cm',0,0),(21,7,'15.92 cm',0,0),(21,8,'2560x1440',0,0),(22,1,'89.33 cm',0,0),(22,2,'22.94 cm',0,0),(22,3,'94.85 cm',0,0),(22,4,'77.59 cm',0,0),(22,5,'93.19 cm',0,0),(23,1,'32.15 cm',0,0),(23,2,'44.5 cm',0,0),(23,3,'35.95 cm',0,0),(23,4,'80.72 cm',0,0),(23,5,'90.15 cm',0,0),(24,6,'55.48 cm',0,0),(24,7,'85.39 cm',0,0),(24,8,'1920x1080',0,0),(25,1,'71.08 cm',0,0),(25,2,'17.67 cm',0,0),(25,3,'77.87 cm',0,0),(25,4,'10.87 cm',0,0),(25,5,'82.43 cm',0,0),(26,1,'20.34 cm',0,0),(26,2,'56.71 cm',0,0),(26,3,'84.2 cm',0,0),(26,4,'11.24 cm',0,0),(26,5,'51.25 cm',0,0),(27,6,'31 cm',0,0),(27,7,'92.89 cm',0,0),(27,8,'1920x1080',0,0),(28,6,'9.25 cm',0,0),(28,7,'48.9 cm',0,0),(28,8,'2560x1440',0,0),(29,6,'93.51 cm',0,0),(29,7,'67.04 cm',0,0),(29,8,'2560x1440',0,0),(30,1,'30.24 cm',0,0),(30,2,'32.75 cm',0,0),(30,3,'82.12 cm',0,0),(30,4,'27.76 cm',0,0),(30,5,'30.16 cm',0,0),(31,1,'16.06 cm',0,0),(31,2,'81.28 cm',0,0),(31,3,'95.02 cm',0,0),(31,4,'61.84 cm',0,0),(31,5,'47.75 cm',0,0),(32,1,'28.37 cm',0,0),(32,2,'14.53 cm',0,0),(32,3,'20.48 cm',0,0),(32,4,'40.89 cm',0,0),(32,5,'14.27 cm',0,0),(33,1,'15.44 cm',0,0),(33,2,'50.18 cm',0,0),(33,3,'8.41 cm',0,0),(33,4,'80.11 cm',0,0),(33,5,'28.46 cm',0,0),(34,1,'79.11 cm',0,0),(34,2,'4.27 cm',0,0),(34,3,'48.28 cm',0,0),(34,4,'90.25 cm',0,0),(34,5,'78.71 cm',0,0),(35,1,'90.13 cm',0,0),(35,2,'47.22 cm',0,0),(35,3,'94.03 cm',0,0),(35,4,'59.54 cm',0,0),(35,5,'43.74 cm',0,0),(36,6,'19.37 cm',0,0),(36,7,'45.13 cm',0,0),(36,8,'1920x1080',0,0),(37,6,'87.84 cm',0,0),(37,7,'85.04 cm',0,0),(37,8,'3840x2160',0,0),(38,1,'39.25 cm',0,0),(38,2,'43.46 cm',0,0),(38,3,'2.95 cm',0,0),(38,4,'89.59 cm',0,0),(38,5,'31.55 cm',0,0),(39,6,'77.55 cm',0,0),(39,7,'2.44 cm',0,0),(39,8,'2560x1440',0,0),(40,6,'38.45 cm',0,0),(40,7,'22.35 cm',0,0),(40,8,'2560x1440',0,0),(41,1,'77.61 cm',0,0),(41,2,'18.43 cm',0,0),(41,3,'12.17 cm',0,0),(41,4,'64.84 cm',0,0),(41,5,'60.53 cm',0,0),(42,6,'63.93 cm',0,0),(42,7,'71.32 cm',0,0),(42,8,'3840x2160',0,0),(43,6,'25.12 cm',0,0),(43,7,'22.88 cm',0,0),(43,8,'1920x1080',0,0),(44,1,'90.2 cm',0,0),(44,2,'56.73 cm',0,0),(44,3,'70.67 cm',0,0),(44,4,'39.94 cm',0,0),(44,5,'44.22 cm',0,0),(45,6,'62.47 cm',0,0),(45,7,'21.38 cm',0,0),(45,8,'1920x1080',0,0),(46,1,'68.8 cm',0,0),(46,2,'17.7 cm',0,0),(46,3,'25.73 cm',0,0),(46,4,'50.44 cm',0,0),(46,5,'56.34 cm',0,0),(47,1,'30.98 cm',0,0),(47,2,'43.04 cm',0,0),(47,3,'31.9 cm',0,0),(47,4,'43.67 cm',0,0),(47,5,'98.35 cm',0,0),(48,1,'51.52 cm',0,0),(48,2,'6.77 cm',0,0),(48,3,'14.29 cm',0,0),(48,4,'83.42 cm',0,0),(48,5,'22.01 cm',0,0),(49,6,'11.3 cm',0,0),(49,7,'76.9 cm',0,0),(49,8,'1920x1080',0,0),(50,1,'23.58 cm',0,0),(50,2,'42.6 cm',0,0),(50,3,'28.28 cm',0,0),(50,4,'60.69 cm',0,0),(50,5,'96.48 cm',0,0),(51,1,'70.24 cm',0,0),(51,2,'17.86 cm',0,0),(51,3,'32.65 cm',0,0),(51,4,'26.84 cm',0,0),(51,5,'90.37 cm',0,0),(52,6,'62.76 cm',0,0),(52,7,'81.36 cm',0,0),(52,8,'2560x1440',0,0),(53,1,'78.52 cm',0,0),(53,2,'65.2 cm',0,0),(53,3,'1.9 cm',0,0),(53,4,'8.37 cm',0,0),(53,5,'77.51 cm',0,0),(54,6,'93.67 cm',0,0),(54,7,'28.2 cm',0,0),(54,8,'1920x1080',0,0);
/*!40000 ALTER TABLE `ec_product_specification_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_specification_attribute_translations`
--

DROP TABLE IF EXISTS `ec_product_specification_attribute_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_specification_attribute_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `attribute_id` bigint unsigned NOT NULL,
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `psat_unique` (`product_id`,`attribute_id`,`lang_code`),
  KEY `psat_product_attribute_index` (`product_id`,`attribute_id`),
  KEY `psat_product_id_index` (`product_id`),
  KEY `psat_attribute_id_index` (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_specification_attribute_translations`
--

LOCK TABLES `ec_product_specification_attribute_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_specification_attribute_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_specification_attribute_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_tag_product`
--

DROP TABLE IF EXISTS `ec_product_tag_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_tag_product` (
  `product_id` bigint unsigned NOT NULL,
  `tag_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`tag_id`),
  KEY `ec_product_tag_product_product_id_index` (`product_id`),
  KEY `ec_product_tag_product_tag_id_index` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_tag_product`
--

LOCK TABLES `ec_product_tag_product` WRITE;
/*!40000 ALTER TABLE `ec_product_tag_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_tag_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_tags`
--

DROP TABLE IF EXISTS `ec_product_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_tags`
--

LOCK TABLES `ec_product_tags` WRITE;
/*!40000 ALTER TABLE `ec_product_tags` DISABLE KEYS */;
INSERT INTO `ec_product_tags` VALUES (1,'Electronic',NULL,'published','2026-02-28 08:15:34','2026-02-28 08:15:34'),(2,'Mobile',NULL,'published','2026-02-28 08:15:34','2026-02-28 08:15:34'),(3,'Iphone',NULL,'published','2026-02-28 08:15:34','2026-02-28 08:15:34'),(4,'Printer',NULL,'published','2026-02-28 08:15:34','2026-02-28 08:15:34'),(5,'Office',NULL,'published','2026-02-28 08:15:34','2026-02-28 08:15:34'),(6,'IT',NULL,'published','2026-02-28 08:15:34','2026-02-28 08:15:34');
/*!40000 ALTER TABLE `ec_product_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_tags_translations`
--

DROP TABLE IF EXISTS `ec_product_tags_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_tags_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_product_tags_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_tags_id`),
  KEY `idx_product_tags_fk` (`ec_product_tags_id`),
  KEY `idx_product_tags_product_tags_lang` (`ec_product_tags_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_tags_translations`
--

LOCK TABLES `ec_product_tags_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_tags_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_tags_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_up_sale_relations`
--

DROP TABLE IF EXISTS `ec_product_up_sale_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_up_sale_relations` (
  `from_product_id` bigint unsigned NOT NULL,
  `to_product_id` bigint unsigned NOT NULL,
  `is_variant` tinyint(1) NOT NULL DEFAULT '0',
  `price` decimal(15,2) DEFAULT '0.00',
  `price_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `apply_to_all_variations` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`from_product_id`,`to_product_id`),
  KEY `ec_product_up_sale_relations_from_product_id_index` (`from_product_id`),
  KEY `ec_product_up_sale_relations_to_product_id_index` (`to_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_up_sale_relations`
--

LOCK TABLES `ec_product_up_sale_relations` WRITE;
/*!40000 ALTER TABLE `ec_product_up_sale_relations` DISABLE KEYS */;
INSERT INTO `ec_product_up_sale_relations` VALUES (1,25,0,5.00,'fixed',1),(1,53,0,20.00,'fixed',1),(2,15,0,10.00,'fixed',1),(2,20,0,20.00,'percent',1),(3,2,0,20.00,'percent',1),(3,28,0,50.00,'fixed',1),(4,29,0,20.00,'percent',1),(4,49,0,20.00,'percent',1),(5,22,0,20.00,'fixed',1),(6,2,0,10.00,'fixed',1),(6,4,0,20.00,'fixed',1),(7,11,0,50.00,'fixed',1),(7,50,0,20.00,'fixed',1),(8,36,0,5.00,'percent',1),(8,37,0,10.00,'fixed',1),(9,1,0,20.00,'percent',1),(9,20,0,5.00,'fixed',1),(10,28,0,50.00,'fixed',1),(10,32,0,10.00,'percent',1),(11,9,0,10.00,'percent',1),(11,25,0,15.00,'percent',1),(12,2,0,10.00,'fixed',1),(12,11,0,10.00,'fixed',1),(13,27,0,5.00,'fixed',1),(13,33,0,50.00,'fixed',1),(14,37,0,10.00,'fixed',1),(14,42,0,20.00,'fixed',1),(15,14,0,10.00,'percent',1),(15,28,0,20.00,'percent',1),(16,12,0,20.00,'fixed',1),(16,17,0,5.00,'percent',1),(17,24,0,50.00,'fixed',1),(17,31,0,10.00,'percent',1),(18,5,0,20.00,'percent',1),(18,39,0,10.00,'fixed',1),(19,14,0,20.00,'percent',1),(19,32,0,5.00,'fixed',1),(20,27,0,10.00,'percent',1),(20,46,0,5.00,'percent',1),(21,1,0,20.00,'fixed',1),(21,39,0,10.00,'percent',1),(22,46,0,50.00,'fixed',1),(22,52,0,5.00,'percent',1),(23,25,0,5.00,'fixed',1),(23,37,0,5.00,'fixed',1),(24,13,0,5.00,'percent',1),(24,16,0,20.00,'percent',1),(25,28,0,15.00,'percent',1),(25,51,0,50.00,'fixed',1),(26,1,0,10.00,'percent',1),(26,32,0,20.00,'percent',1),(27,11,0,20.00,'fixed',1),(27,46,0,20.00,'fixed',1),(28,25,0,10.00,'percent',1),(28,46,0,10.00,'fixed',1),(29,27,0,5.00,'percent',1),(29,50,0,20.00,'fixed',1),(30,23,0,20.00,'fixed',1),(30,43,0,5.00,'fixed',1),(31,20,0,20.00,'fixed',1),(31,25,0,10.00,'fixed',1),(32,31,0,20.00,'fixed',1),(32,49,0,10.00,'percent',1),(33,12,0,20.00,'percent',1),(33,37,0,20.00,'fixed',1),(34,17,0,50.00,'fixed',1),(34,41,0,15.00,'percent',1),(35,29,0,10.00,'fixed',1),(35,53,0,20.00,'percent',1),(36,6,0,20.00,'percent',1),(36,24,0,5.00,'percent',1),(37,31,0,20.00,'fixed',1),(37,33,0,20.00,'percent',1),(38,16,0,50.00,'fixed',1),(38,22,0,50.00,'fixed',1),(39,1,0,15.00,'percent',1),(39,44,0,10.00,'percent',1),(40,6,0,10.00,'fixed',1),(40,35,0,15.00,'percent',1),(41,10,0,5.00,'percent',1),(41,13,0,50.00,'fixed',1),(42,39,0,10.00,'fixed',1),(42,52,0,20.00,'percent',1),(43,22,0,15.00,'percent',1),(43,39,0,50.00,'fixed',1),(44,40,0,15.00,'percent',1),(44,41,0,10.00,'percent',1),(45,8,0,10.00,'fixed',1),(45,19,0,20.00,'fixed',1),(46,38,0,20.00,'fixed',1),(46,53,0,20.00,'fixed',1),(47,3,0,20.00,'fixed',1),(47,45,0,5.00,'percent',1),(48,36,0,10.00,'fixed',1),(48,40,0,20.00,'percent',1),(49,29,0,5.00,'fixed',1),(49,32,0,20.00,'fixed',1),(50,3,0,20.00,'percent',1),(50,25,0,50.00,'fixed',1),(51,12,0,20.00,'fixed',1),(51,54,0,20.00,'fixed',1),(52,8,0,10.00,'fixed',1),(52,50,0,5.00,'fixed',1),(53,11,0,10.00,'fixed',1),(53,54,0,5.00,'percent',1),(54,2,0,10.00,'fixed',1),(54,53,0,20.00,'fixed',1);
/*!40000 ALTER TABLE `ec_product_up_sale_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_variation_items`
--

DROP TABLE IF EXISTS `ec_product_variation_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_variation_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` bigint unsigned NOT NULL,
  `variation_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_product_variation_items_attribute_id_variation_id_unique` (`attribute_id`,`variation_id`),
  KEY `attribute_variation_index` (`attribute_id`,`variation_id`),
  KEY `idx_variation_id` (`variation_id`),
  KEY `idx_variation_attribute_covering` (`variation_id`,`attribute_id`),
  KEY `ec_product_variation_items_variation_id_attribute_id_index` (`variation_id`,`attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_variation_items`
--

LOCK TABLES `ec_product_variation_items` WRITE;
/*!40000 ALTER TABLE `ec_product_variation_items` DISABLE KEYS */;
INSERT INTO `ec_product_variation_items` VALUES (11,1,6),(15,1,8),(17,1,9),(31,1,16),(45,1,23),(53,1,27),(65,1,33),(69,1,35),(85,1,43),(123,1,62),(125,1,63),(131,1,66),(133,1,67),(139,1,70),(1,2,1),(5,2,3),(9,2,5),(21,2,11),(23,2,12),(35,2,18),(57,2,29),(63,2,32),(81,2,41),(83,2,42),(93,2,47),(95,2,48),(97,2,49),(99,2,50),(101,2,51),(103,2,52),(105,2,53),(107,2,54),(111,2,56),(115,2,58),(121,2,61),(145,2,73),(7,3,4),(19,3,10),(25,3,13),(27,3,14),(29,3,15),(37,3,19),(39,3,20),(43,3,22),(47,3,24),(51,3,26),(55,3,28),(75,3,38),(79,3,40),(87,3,44),(89,3,45),(91,3,46),(109,3,55),(127,3,64),(137,3,69),(13,4,7),(41,4,21),(49,4,25),(67,4,34),(71,4,36),(73,4,37),(77,4,39),(113,4,57),(117,4,59),(141,4,71),(147,4,74),(3,5,2),(33,5,17),(59,5,30),(61,5,31),(119,5,60),(129,5,65),(135,5,68),(143,5,72),(16,6,8),(18,6,9),(50,6,25),(68,6,34),(70,6,35),(76,6,38),(88,6,44),(98,6,49),(106,6,53),(114,6,57),(124,6,62),(134,6,67),(140,6,70),(144,6,72),(12,7,6),(22,7,11),(32,7,16),(40,7,20),(42,7,21),(56,7,28),(58,7,29),(62,7,31),(72,7,36),(96,7,48),(112,7,56),(120,7,60),(128,7,64),(142,7,71),(146,7,73),(148,7,74),(2,8,1),(8,8,4),(20,8,10),(24,8,12),(26,8,13),(46,8,23),(48,8,24),(52,8,26),(64,8,32),(74,8,37),(82,8,41),(94,8,47),(116,8,58),(126,8,63),(138,8,69),(6,9,3),(10,9,5),(14,9,7),(28,9,14),(54,9,27),(60,9,30),(80,9,40),(84,9,42),(100,9,50),(104,9,52),(108,9,54),(110,9,55),(130,9,65),(4,10,2),(30,10,15),(34,10,17),(36,10,18),(38,10,19),(44,10,22),(66,10,33),(78,10,39),(86,10,43),(90,10,45),(92,10,46),(102,10,51),(118,10,59),(122,10,61),(132,10,66),(136,10,68);
/*!40000 ALTER TABLE `ec_product_variation_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_variations`
--

DROP TABLE IF EXISTS `ec_product_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_variations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned DEFAULT NULL,
  `configurable_product_id` bigint unsigned NOT NULL,
  `is_default` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_product_variations_product_id_configurable_product_id_unique` (`product_id`,`configurable_product_id`),
  KEY `configurable_product_index` (`product_id`,`configurable_product_id`),
  KEY `idx_configurable_product_id` (`configurable_product_id`),
  KEY `idx_product_variations_config` (`configurable_product_id`,`is_default`),
  KEY `ec_product_variations_product_id_index` (`product_id`),
  KEY `ec_product_variations_configurable_product_id_index` (`configurable_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_variations`
--

LOCK TABLES `ec_product_variations` WRITE;
/*!40000 ALTER TABLE `ec_product_variations` DISABLE KEYS */;
INSERT INTO `ec_product_variations` VALUES (1,55,1,1),(2,56,2,1),(3,57,2,0),(4,58,2,0),(5,59,2,0),(6,60,3,1),(7,61,3,0),(8,62,3,0),(9,63,11,1),(10,64,13,1),(11,65,16,1),(12,66,16,0),(13,67,16,0),(14,68,18,1),(15,69,18,0),(16,70,20,1),(17,71,20,0),(18,72,20,0),(19,73,20,0),(20,74,22,1),(21,75,22,0),(22,76,22,0),(23,77,22,0),(24,78,23,1),(25,79,24,1),(26,80,24,0),(27,81,25,1),(28,82,25,0),(29,83,29,1),(30,84,29,0),(31,85,29,0),(32,86,30,1),(33,87,33,1),(34,88,34,1),(35,89,34,0),(36,90,36,1),(37,91,36,0),(38,92,37,1),(39,93,37,0),(40,94,37,0),(41,95,37,0),(42,96,37,0),(43,97,38,1),(44,98,38,0),(45,99,38,0),(46,100,38,0),(47,101,39,1),(48,102,42,1),(49,103,42,0),(50,104,43,1),(51,105,43,0),(52,106,43,0),(53,107,44,1),(54,108,44,0),(55,109,44,0),(56,110,45,1),(57,111,45,0),(58,112,45,0),(59,113,45,0),(60,114,47,1),(61,115,48,1),(62,116,48,0),(63,117,48,0),(64,118,48,0),(65,119,48,0),(66,120,50,1),(67,121,50,0),(68,122,50,0),(69,123,51,1),(70,124,51,0),(71,125,51,0),(72,126,52,1),(73,127,52,0),(74,128,54,1);
/*!40000 ALTER TABLE `ec_product_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_views`
--

DROP TABLE IF EXISTS `ec_product_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_views` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `views` int NOT NULL DEFAULT '1',
  `date` date NOT NULL DEFAULT '2026-02-28',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_product_views_product_id_date_unique` (`product_id`,`date`),
  KEY `ec_product_views_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_views`
--

LOCK TABLES `ec_product_views` WRITE;
/*!40000 ALTER TABLE `ec_product_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_with_attribute_set`
--

DROP TABLE IF EXISTS `ec_product_with_attribute_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_with_attribute_set` (
  `attribute_set_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `order` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`attribute_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_with_attribute_set`
--

LOCK TABLES `ec_product_with_attribute_set` WRITE;
/*!40000 ALTER TABLE `ec_product_with_attribute_set` DISABLE KEYS */;
INSERT INTO `ec_product_with_attribute_set` VALUES (1,1,0),(2,1,0),(1,2,0),(2,2,0),(1,3,0),(2,3,0),(1,11,0),(2,11,0),(1,13,0),(2,13,0),(1,16,0),(2,16,0),(1,18,0),(2,18,0),(1,20,0),(2,20,0),(1,22,0),(2,22,0),(1,23,0),(2,23,0),(1,24,0),(2,24,0),(1,25,0),(2,25,0),(1,29,0),(2,29,0),(1,30,0),(2,30,0),(1,33,0),(2,33,0),(1,34,0),(2,34,0),(1,36,0),(2,36,0),(1,37,0),(2,37,0),(1,38,0),(2,38,0),(1,39,0),(2,39,0),(1,42,0),(2,42,0),(1,43,0),(2,43,0),(1,44,0),(2,44,0),(1,45,0),(2,45,0),(1,47,0),(2,47,0),(1,48,0),(2,48,0),(1,50,0),(2,50,0),(1,51,0),(2,51,0),(1,52,0),(2,52,0),(1,54,0),(2,54,0);
/*!40000 ALTER TABLE `ec_product_with_attribute_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_products`
--

DROP TABLE IF EXISTS `ec_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `images` text COLLATE utf8mb4_unicode_ci,
  `video_media` text COLLATE utf8mb4_unicode_ci,
  `sku` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int unsigned NOT NULL DEFAULT '0',
  `quantity` int unsigned DEFAULT NULL,
  `allow_checkout_when_out_of_stock` tinyint unsigned NOT NULL DEFAULT '0',
  `with_storehouse_management` tinyint unsigned NOT NULL DEFAULT '0',
  `stock_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'in_stock',
  `is_featured` tinyint unsigned NOT NULL DEFAULT '0',
  `is_new_until` date DEFAULT NULL,
  `brand_id` bigint unsigned DEFAULT NULL,
  `is_variation` tinyint NOT NULL DEFAULT '0',
  `variations_count` int unsigned NOT NULL DEFAULT '0',
  `reviews_count` int unsigned NOT NULL DEFAULT '0',
  `reviews_avg` decimal(3,2) NOT NULL DEFAULT '0.00',
  `sale_type` tinyint NOT NULL DEFAULT '0',
  `price` double unsigned DEFAULT NULL,
  `sale_price` double unsigned DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `length` double DEFAULT NULL,
  `wide` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `tax_id` bigint unsigned DEFAULT NULL,
  `tax_class` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'standard',
  `views` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by_id` bigint unsigned DEFAULT '0',
  `created_by_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_type` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT 'physical',
  `barcode` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_per_item` double DEFAULT NULL,
  `currency_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_includes_tax` tinyint(1) NOT NULL DEFAULT '0',
  `generate_license_code` tinyint(1) NOT NULL DEFAULT '0',
  `license_code_type` enum('auto_generate','pick_from_list') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'auto_generate',
  `minimum_order_quantity` int unsigned DEFAULT '0',
  `maximum_order_quantity` int unsigned DEFAULT '0',
  `notify_attachment_updated` tinyint(1) NOT NULL DEFAULT '0',
  `specification_table_id` bigint unsigned DEFAULT NULL,
  `store_id` bigint unsigned DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ec_products_brand_id_status_is_variation_created_at_index` (`brand_id`,`status`,`is_variation`,`created_at`),
  KEY `sale_type_index` (`sale_type`),
  KEY `start_date_index` (`start_date`),
  KEY `end_date_index` (`end_date`),
  KEY `sale_price_index` (`sale_price`),
  KEY `is_variation_index` (`is_variation`),
  KEY `ec_products_sku_index` (`sku`),
  KEY `idx_products_export` (`id`,`is_variation`),
  KEY `idx_variation_name_id` (`is_variation`,`name`,`id`),
  KEY `ec_products_variations_count_index` (`variations_count`),
  KEY `ec_products_slug_index` (`slug`),
  KEY `idx_products_status_variation` (`status`,`is_variation`,`id`),
  KEY `idx_products_price_sale` (`sale_type`,`sale_price`,`price`),
  KEY `idx_products_order_created` (`order`,`created_at`),
  KEY `idx_products_stock` (`with_storehouse_management`,`stock_status`,`quantity`),
  KEY `ec_products_reviews_count_index` (`reviews_count`),
  KEY `ec_products_reviews_avg_index` (`reviews_avg`),
  KEY `ec_products_status_is_variation_index` (`status`,`is_variation`),
  KEY `ec_products_storehouse_quantity_index` (`with_storehouse_management`,`quantity`),
  KEY `ec_products_currency_code_index` (`currency_code`),
  KEY `idx_store_variation_status` (`store_id`,`is_variation`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_products`
--

LOCK TABLES `ec_products` WRITE;
/*!40000 ALTER TABLE `ec_products` DISABLE KEYS */;
INSERT INTO `ec_products` VALUES (1,'Smart Home Speaker','smart-home-speaker','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/1-1.jpg\",\"products\\/1-2.jpg\",\"products\\/1-3.jpg\",\"products\\/1-4.jpg\"]',NULL,'2L-192-A1',0,13,0,1,'in_stock',0,NULL,3,0,1,10,3.10,0,700.66,NULL,NULL,NULL,15,20,14,740,NULL,'standard',9337,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','7018211326560',NULL,NULL,0,0,'auto_generate',0,0,0,2,6,0),(2,'Headphone Ultra Bass','headphone-ultra-bass','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/2-1.jpg\",\"products\\/2-2.jpg\",\"products\\/2-3.jpg\",\"products\\/2-4.jpg\"]',NULL,'Q4-198-A1',0,20,0,1,'in_stock',0,NULL,5,0,4,10,2.90,0,427.55,NULL,NULL,NULL,15,15,16,620,NULL,'standard',110584,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','6729417245265',NULL,NULL,0,0,'auto_generate',0,0,0,2,1,0),(3,'Boxed - Bluetooth Headphone','boxed-bluetooth-headphone','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/3-1.jpg\",\"products\\/3-2.jpg\",\"products\\/3-3.jpg\",\"products\\/3-4.jpg\"]',NULL,'HV-119-A1',0,19,0,1,'in_stock',1,NULL,7,0,3,10,2.60,0,1924.94,NULL,NULL,NULL,13,13,19,518,NULL,'standard',7552,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','7870991224524',NULL,NULL,0,0,'auto_generate',0,0,0,1,3,0),(4,'Camera Samsung SS-24 (Digital)','camera-samsung-ss-24','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/4-1.jpg\",\"products\\/4-2.jpg\",\"products\\/4-3.jpg\",\"products\\/4-4.jpg\"]',NULL,'JR-150',0,16,0,1,'in_stock',0,NULL,5,0,0,8,3.13,0,704.43,469.43,NULL,NULL,10,19,19,605,NULL,'standard',47516,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'digital','2033279452834',NULL,NULL,0,0,'auto_generate',0,0,0,1,2,0),(5,'Macbook Pro 2015','macbook-pro-2015','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/5-1.jpg\",\"products\\/5-2.jpg\",\"products\\/5-3.jpg\",\"products\\/5-4.jpg\"]',NULL,'34-127',0,20,0,1,'in_stock',0,NULL,3,0,0,10,2.40,0,1218.52,763.52,NULL,NULL,11,19,13,521,NULL,'standard',15845,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','6964739464943',NULL,NULL,0,0,'auto_generate',0,0,0,2,6,0),(6,'Apple Watch Serial 7','apple-watch-serial-7','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/6-1.jpg\",\"products\\/6-2.jpg\",\"products\\/6-3.jpg\",\"products\\/6-4.jpg\"]',NULL,'99-170',0,18,0,1,'in_stock',0,NULL,4,0,0,10,2.70,0,721.1,490.1,NULL,NULL,19,10,11,802,NULL,'standard',84530,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','9773357397185',NULL,NULL,0,0,'auto_generate',0,0,0,2,7,0),(7,'Macbook Pro 13 inch','macbook-pro-13-inch','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/7-1.jpg\",\"products\\/7-2.jpg\",\"products\\/7-3.jpg\"]',NULL,'FD-191',0,13,0,1,'in_stock',0,NULL,7,0,0,9,2.67,0,1343.44,1033.44,NULL,NULL,13,12,19,680,NULL,'standard',194920,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','2181197032987',NULL,NULL,0,0,'auto_generate',0,0,0,2,8,0),(8,'Apple Keyboard (Digital)','apple-keyboard','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/8-1.jpg\",\"products\\/8-2.jpg\",\"products\\/8-3.jpg\",\"products\\/8-4.jpg\"]',NULL,'1P-133',0,12,0,1,'in_stock',0,NULL,7,0,0,10,3.40,0,574.37,265.37,NULL,NULL,13,16,19,612,NULL,'standard',8924,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'digital','6155058843469',NULL,NULL,0,0,'auto_generate',0,0,0,1,5,0),(9,'MacSafe 80W','macsafe-80w','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/9-1.jpg\",\"products\\/9-2.jpg\",\"products\\/9-3.jpg\"]',NULL,'EO-173',0,15,0,1,'in_stock',1,NULL,4,0,0,9,3.22,0,1197.55,119.55,NULL,NULL,13,10,15,696,NULL,'standard',67789,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','0064663561124',NULL,NULL,0,0,'auto_generate',0,0,0,2,9,0),(10,'Hand playstation','hand-playstation','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/10-1.jpg\",\"products\\/10-2.jpg\",\"products\\/10-3.jpg\",\"products\\/10-4.jpg\"]',NULL,'VQ-158',0,19,0,1,'in_stock',0,NULL,7,0,0,9,3.00,0,336.25,77.25,NULL,NULL,10,16,11,783,NULL,'standard',188384,'2026-02-28 08:15:24','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','4389783789613',NULL,NULL,0,0,'auto_generate',0,0,0,1,8,0),(11,'Apple Airpods Serial 3','apple-airpods-serial-3','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/11-1.jpg\",\"products\\/11-2.jpg\",\"products\\/11-3.jpg\",\"products\\/11-4.jpg\"]',NULL,'3I-156-A1',0,12,0,1,'in_stock',0,NULL,4,0,1,10,3.10,0,240.21,NULL,NULL,NULL,15,18,11,534,NULL,'standard',128430,'2026-02-28 08:15:25','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','7733744457726',NULL,NULL,0,0,'auto_generate',0,0,0,2,3,0),(12,'Cool Smart Watches (Digital)','cool-smart-watches','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/12-1.jpg\",\"products\\/12-2.jpg\",\"products\\/12-3.jpg\",\"products\\/12-4.jpg\"]',NULL,'SD-152',0,10,0,1,'in_stock',0,NULL,7,0,0,9,2.89,0,972.65,246.65,NULL,NULL,10,11,12,578,NULL,'standard',119207,'2026-02-28 08:15:25','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'digital','4025490054230',NULL,NULL,0,0,'auto_generate',0,0,0,1,9,0),(13,'Black Smart Watches','black-smart-watches','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/13-1.jpg\",\"products\\/13-2.jpg\",\"products\\/13-3.jpg\",\"products\\/13-4.jpg\"]',NULL,'OG-118-A1',0,11,0,1,'in_stock',0,NULL,7,0,1,9,2.44,0,1098.63,NULL,NULL,NULL,14,18,12,900,NULL,'standard',190720,'2026-02-28 08:15:25','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','2827190422836',NULL,NULL,0,0,'auto_generate',0,0,0,2,5,0),(14,'Leather Watch In Black','leather-watch-in-black','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/14-1.jpg\",\"products\\/14-2.jpg\",\"products\\/14-3.jpg\",\"products\\/14-4.jpg\"]',NULL,'YA-131',0,17,0,1,'in_stock',0,NULL,6,0,0,9,3.22,0,1040.18,732.18,NULL,NULL,16,10,13,788,NULL,'standard',169154,'2026-02-28 08:15:25','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','9539962497982',NULL,NULL,0,0,'auto_generate',0,0,0,1,5,0),(15,'Macbook Pro 2015 13 inch','macbook-pro-2015-13-inch','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/15-1.jpg\",\"products\\/15-2.jpg\",\"products\\/15-3.jpg\",\"products\\/15-4.jpg\"]',NULL,'YZ-171',0,10,0,1,'in_stock',0,NULL,7,0,0,10,3.30,0,919.85,95.85,NULL,NULL,12,20,11,585,NULL,'standard',171231,'2026-02-28 08:15:25','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','3958866798340',NULL,NULL,0,0,'auto_generate',0,0,0,1,3,0),(16,'Historic Alarm Clock (Digital)','historic-alarm-clock','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/16-1.jpg\",\"products\\/16-2.jpg\",\"products\\/16-3.jpg\",\"products\\/16-4.jpg\"]',NULL,'3B-124-A1',0,20,0,1,'in_stock',0,NULL,5,0,3,10,3.40,0,1881.39,1693.251,NULL,NULL,20,17,14,691,NULL,'standard',162892,'2026-02-28 08:15:25','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'digital','2324944288101',NULL,NULL,0,0,'auto_generate',0,0,0,2,9,0),(17,'Black Glasses','black-glasses','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/17-1.jpg\",\"products\\/17-2.jpg\",\"products\\/17-3.jpg\",\"products\\/17-4.jpg\"]',NULL,'QE-117',0,15,0,1,'in_stock',0,NULL,3,0,0,10,2.90,0,311.53,271.0311,NULL,NULL,20,16,12,504,NULL,'standard',19615,'2026-02-28 08:15:25','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','6700002835672',NULL,NULL,0,0,'auto_generate',0,0,0,2,4,0),(18,'Phillips Mouse','phillips-mouse','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/18-1.jpg\",\"products\\/18-2.jpg\",\"products\\/18-3.jpg\",\"products\\/18-4.jpg\"]',NULL,'G9-154-A1',0,19,0,1,'in_stock',0,NULL,5,0,2,10,2.70,0,712.88,NULL,NULL,NULL,17,17,15,626,NULL,'standard',137175,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','8704383488920',NULL,NULL,0,0,'auto_generate',0,0,0,2,5,0),(19,'Gaming Keyboard','gaming-keyboard','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/19-1.jpg\",\"products\\/19-2.jpg\",\"products\\/19-3.jpg\",\"products\\/19-4.jpg\"]',NULL,'IT-147',0,13,0,1,'in_stock',0,NULL,3,0,0,10,2.80,0,1352.85,64.85,NULL,NULL,17,18,16,865,NULL,'standard',175749,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1945518116531',NULL,NULL,0,0,'auto_generate',0,0,0,2,2,0),(20,'Wireless Keyboard (Digital)','wireless-keyboard','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/20-1.jpg\",\"products\\/20-2.jpg\",\"products\\/20-3.jpg\",\"products\\/20-4.jpg\"]',NULL,'EY-177-A1',0,20,0,1,'in_stock',0,NULL,6,0,4,10,2.60,0,1776.06,1332.045,NULL,NULL,10,11,18,566,NULL,'standard',193712,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','5995423149410',NULL,NULL,0,0,'auto_generate',0,0,0,2,2,0),(21,'Black Smart Watches','black-smart-watches','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/21-1.jpg\",\"products\\/21-2.jpg\",\"products\\/21-3.jpg\",\"products\\/21-4.jpg\"]',NULL,'RJ-155',0,14,0,1,'in_stock',0,NULL,1,0,0,10,2.50,0,656.58,405.58,NULL,NULL,13,16,14,839,NULL,'standard',141417,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4338851929376',NULL,NULL,0,0,'auto_generate',0,0,0,2,4,0),(22,'Smart Home Speaker','smart-home-speaker','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/22-1.jpg\",\"products\\/22-2.jpg\",\"products\\/22-3.jpg\",\"products\\/22-4.jpg\"]',NULL,'LR-173-A1',0,11,0,1,'in_stock',0,NULL,5,0,4,10,3.00,0,1510,NULL,NULL,NULL,16,19,14,529,NULL,'standard',18286,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','0240249926451',NULL,NULL,0,0,'auto_generate',0,0,0,1,8,0),(23,'Headphone Ultra Bass','headphone-ultra-bass','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/23-1.jpg\",\"products\\/23-2.jpg\",\"products\\/23-3.jpg\",\"products\\/23-4.jpg\"]',NULL,'SA-170-A1',0,19,0,1,'in_stock',0,NULL,4,0,1,10,3.60,0,1290.99,NULL,NULL,NULL,14,17,16,776,NULL,'standard',190523,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','2691699409311',NULL,NULL,0,0,'auto_generate',0,0,0,1,5,0),(24,'Boxed - Bluetooth Headphone (Digital)','boxed-bluetooth-headphone','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/24-1.jpg\",\"products\\/24-2.jpg\",\"products\\/24-3.jpg\",\"products\\/24-4.jpg\"]',NULL,'0L-125-A1',0,19,0,1,'in_stock',0,NULL,6,0,2,10,3.80,0,1416.66,1189.9944,NULL,NULL,13,17,13,838,NULL,'standard',199122,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','0845245438191',NULL,NULL,0,0,'auto_generate',0,0,0,2,6,0),(25,'Camera Samsung SS-24','camera-samsung-ss-24','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/25-1.jpg\",\"products\\/25-2.jpg\",\"products\\/25-3.jpg\",\"products\\/25-4.jpg\"]',NULL,'ZM-195-A1',0,19,0,1,'in_stock',0,NULL,3,0,2,10,2.70,0,146.29,NULL,NULL,NULL,14,18,18,546,NULL,'standard',184712,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','2622935611755',NULL,NULL,0,0,'auto_generate',0,0,0,1,4,0),(26,'Leather Watch In Black','leather-watch-in-black','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/26-1.jpg\",\"products\\/26-2.jpg\",\"products\\/26-3.jpg\",\"products\\/26-4.jpg\"]',NULL,'BS-140',0,10,0,1,'in_stock',1,NULL,3,0,0,10,2.80,0,1599.61,106.61,NULL,NULL,18,11,18,796,NULL,'standard',173450,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4817058610473',NULL,NULL,0,0,'auto_generate',0,0,0,1,9,0),(27,'Apple iPhone 13 Plus','apple-iphone-13-plus','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/27-1.jpg\",\"products\\/27-2.jpg\",\"products\\/27-3.jpg\",\"products\\/27-4.jpg\"]',NULL,'N0-117',0,20,0,1,'in_stock',0,NULL,7,0,0,10,2.50,0,1028.4,306.4,NULL,NULL,14,13,16,752,NULL,'standard',62798,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6137773146254',NULL,NULL,0,0,'auto_generate',0,0,0,2,8,0),(28,'Macbook Pro 2015 (Digital)','macbook-pro-2015','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/28-1.jpg\",\"products\\/28-2.jpg\",\"products\\/28-3.jpg\",\"products\\/28-4.jpg\"]',NULL,'E9-144',0,19,0,1,'in_stock',0,NULL,6,0,0,10,2.90,0,475.81,404.81,NULL,NULL,12,18,19,835,NULL,'standard',184553,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','8170131813007',NULL,NULL,0,0,'auto_generate',0,0,0,2,7,0),(29,'Apple Watch Serial 7','apple-watch-serial-7','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/29-1.jpg\",\"products\\/29-2.jpg\",\"products\\/29-3.jpg\"]',NULL,'MC-114-A1',0,14,0,1,'in_stock',0,NULL,5,0,3,10,3.20,0,1297.95,NULL,NULL,NULL,10,20,15,532,NULL,'standard',131661,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','2286316086350',NULL,NULL,0,0,'auto_generate',0,0,0,2,7,0),(30,'Macbook Pro 13 inch','macbook-pro-13-inch','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/30-1.jpg\",\"products\\/30-2.jpg\",\"products\\/30-3.jpg\",\"products\\/30-4.jpg\"]',NULL,'JB-169-A1',0,18,0,1,'in_stock',0,NULL,1,0,1,10,3.80,0,1068.86,NULL,NULL,NULL,10,12,12,780,NULL,'standard',23751,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','0561557536546',NULL,NULL,0,0,'auto_generate',0,0,0,1,1,0),(31,'Apple Keyboard','apple-keyboard','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/31-1.jpg\",\"products\\/31-2.jpg\",\"products\\/31-3.jpg\",\"products\\/31-4.jpg\"]',NULL,'WR-193',0,11,0,1,'in_stock',0,NULL,2,0,0,10,3.40,0,1357.78,473.78,NULL,NULL,11,15,14,892,NULL,'standard',19881,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6875105156785',NULL,NULL,0,0,'auto_generate',0,0,0,1,2,0),(32,'MacSafe 80W (Digital)','macsafe-80w','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/32-1.jpg\",\"products\\/32-2.jpg\",\"products\\/32-3.jpg\",\"products\\/32-4.jpg\"]',NULL,'JA-140',0,15,0,1,'in_stock',0,NULL,3,0,0,10,2.90,0,1286.54,461.54,NULL,NULL,18,16,20,584,NULL,'standard',118466,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','7149505115598',NULL,NULL,0,0,'auto_generate',0,0,0,1,1,0),(33,'Hand playstation','hand-playstation','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/33-1.jpg\",\"products\\/33-2.jpg\",\"products\\/33-3.jpg\",\"products\\/33-4.jpg\"]',NULL,'NV-109-A1',0,15,0,1,'in_stock',0,NULL,2,0,1,9,3.44,0,1511.61,NULL,NULL,NULL,18,14,15,898,NULL,'standard',82797,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','9849082732048',NULL,NULL,0,0,'auto_generate',0,0,0,1,3,0),(34,'Apple Airpods Serial 3','apple-airpods-serial-3','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/34-1.jpg\",\"products\\/34-2.jpg\",\"products\\/34-3.jpg\",\"products\\/34-4.jpg\"]',NULL,'UB-173-A1',0,18,0,1,'in_stock',0,NULL,5,0,2,10,3.20,0,1013.42,NULL,NULL,NULL,11,11,16,529,NULL,'standard',105836,'2026-02-28 08:15:25','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','5084715866217',NULL,NULL,0,0,'auto_generate',0,0,0,1,3,0),(35,'Cool Smart Watches','cool-smart-watches','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/35-1.jpg\",\"products\\/35-2.jpg\",\"products\\/35-3.jpg\",\"products\\/35-4.jpg\"]',NULL,'JD-121',0,13,0,1,'in_stock',0,NULL,7,0,0,10,2.60,0,449.44,77.44,NULL,NULL,16,17,11,837,NULL,'standard',66036,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4708794117077',NULL,NULL,0,0,'auto_generate',0,0,0,1,2,0),(36,'Black Smart Watches (Digital)','black-smart-watches','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/36-1.jpg\",\"products\\/36-2.jpg\",\"products\\/36-3.jpg\"]',NULL,'YG-188-A1',0,17,0,1,'in_stock',0,NULL,3,0,2,10,3.30,0,1434.56,1205.0304,NULL,NULL,18,11,13,857,NULL,'standard',192074,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','2987869227299',NULL,NULL,0,0,'auto_generate',0,0,0,2,9,0),(37,'Leather Watch In Black','leather-watch-in-black','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/37-1.jpg\",\"products\\/37-2.jpg\",\"products\\/37-3.jpg\"]',NULL,'6U-156-A1',0,10,0,1,'in_stock',0,NULL,5,0,5,9,4.00,0,1726.4,NULL,NULL,NULL,12,17,16,868,NULL,'standard',113819,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6196270308954',NULL,NULL,0,0,'auto_generate',0,0,0,2,1,0),(38,'Macbook Pro 2015 13 inch','macbook-pro-2015-13-inch','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/38-1.jpg\",\"products\\/38-2.jpg\",\"products\\/38-3.jpg\",\"products\\/38-4.jpg\"]',NULL,'U1-192-A1',0,19,0,1,'in_stock',1,NULL,6,0,4,10,3.20,0,1345.32,NULL,NULL,NULL,18,17,12,600,NULL,'standard',87621,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1610016966161',NULL,NULL,0,0,'auto_generate',0,0,0,1,9,0),(39,'Sony WH-1000XM4 Wireless Headphones','sony-wh-1000xm4-wireless-headphones','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/39-1.jpg\",\"products\\/39-2.jpg\",\"products\\/39-3.jpg\",\"products\\/39-4.jpg\"]',NULL,'OR-194-A1',0,17,0,1,'in_stock',0,NULL,4,0,1,10,3.40,0,698.35,NULL,NULL,NULL,18,15,14,553,NULL,'standard',63612,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','3773156988368',NULL,NULL,0,0,'auto_generate',0,0,0,2,2,0),(40,'Samsung Galaxy S22 Ultra (Digital)','samsung-galaxy-s22-ultra','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/40-1.jpg\",\"products\\/40-2.jpg\",\"products\\/40-3.jpg\",\"products\\/40-4.jpg\"]',NULL,'XX-190',0,13,0,1,'in_stock',0,NULL,6,0,0,10,2.70,0,1032.15,570.15,NULL,NULL,18,17,18,606,NULL,'standard',161097,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','1454288795278',NULL,NULL,0,0,'auto_generate',0,0,0,2,3,0),(41,'Dell XPS 15 Laptop','dell-xps-15-laptop','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/41-1.jpg\",\"products\\/41-2.jpg\",\"products\\/41-3.jpg\",\"products\\/41-4.jpg\"]',NULL,'ST-199',0,12,0,1,'in_stock',0,NULL,7,0,0,10,3.30,0,617.57,537.2859,NULL,NULL,20,11,16,698,NULL,'standard',162399,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','2047483012388',NULL,NULL,0,0,'auto_generate',0,0,0,1,4,0),(42,'iPad Pro 12.9-inch','ipad-pro-129-inch','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/42-1.jpg\",\"products\\/42-2.jpg\",\"products\\/42-3.jpg\"]',NULL,'ET-130-A1',0,10,0,1,'in_stock',1,NULL,5,0,2,9,3.56,0,1727.43,NULL,NULL,NULL,13,10,11,762,NULL,'standard',28299,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4373047843081',NULL,NULL,0,0,'auto_generate',0,0,0,2,6,0),(43,'Bose QuietComfort Earbuds','bose-quietcomfort-earbuds','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/43-1.jpg\",\"products\\/43-2.jpg\",\"products\\/43-3.jpg\"]',NULL,'DC-110-A1',0,16,0,1,'in_stock',0,NULL,1,0,3,10,3.50,0,359.84,NULL,NULL,NULL,18,13,16,735,NULL,'standard',173204,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4919228250431',NULL,NULL,0,0,'auto_generate',0,0,0,2,9,0),(44,'LG OLED C1 Series TV (Digital)','lg-oled-c1-series-tv','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/44-1.jpg\",\"products\\/44-2.jpg\",\"products\\/44-3.jpg\"]',NULL,'3N-186-A1',0,20,0,1,'in_stock',0,NULL,5,0,3,10,3.20,0,860.63,602.441,NULL,NULL,14,17,15,621,NULL,'standard',186691,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','1078541837064',NULL,NULL,0,0,'auto_generate',0,0,0,1,4,0),(45,'Dyson V11 Vacuum Cleaner','dyson-v11-vacuum-cleaner','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/45-1.jpg\",\"products\\/45-2.jpg\",\"products\\/45-3.jpg\",\"products\\/45-4.jpg\"]',NULL,'HY-160-A1',0,11,0,1,'in_stock',0,NULL,7,0,4,9,3.78,0,770.21,NULL,NULL,NULL,20,17,19,689,NULL,'standard',142044,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','9007078294035',NULL,NULL,0,0,'auto_generate',0,0,0,2,7,0),(46,'Nintendo Switch OLED Model','nintendo-switch-oled-model','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/46-1.jpg\",\"products\\/46-2.jpg\",\"products\\/46-3.jpg\",\"products\\/46-4.jpg\"]',NULL,'WS-194',0,15,0,1,'in_stock',0,NULL,2,0,0,10,3.40,0,973.25,675.25,NULL,NULL,19,20,19,713,NULL,'standard',140925,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6683297574221',NULL,NULL,0,0,'auto_generate',0,0,0,1,8,0),(47,'Canon EOS R5 Camera','canon-eos-r5-camera','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/47-1.jpg\",\"products\\/47-2.jpg\",\"products\\/47-3.jpg\"]',NULL,'VB-166-A1',0,19,0,1,'in_stock',0,NULL,6,0,1,10,2.50,0,407.89,NULL,NULL,NULL,15,13,10,896,NULL,'standard',191624,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4894802240223',NULL,NULL,0,0,'auto_generate',0,0,0,1,6,0),(48,'Fitbit Sense Smartwatch (Digital)','fitbit-sense-smartwatch','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/48-1.jpg\",\"products\\/48-2.jpg\",\"products\\/48-3.jpg\",\"products\\/48-4.jpg\"]',NULL,'RZ-192-A1',0,20,0,1,'in_stock',0,NULL,5,0,5,10,2.70,0,1974.4,1461.056,NULL,NULL,18,15,11,859,NULL,'standard',67578,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','0717503537130',NULL,NULL,0,0,'auto_generate',0,0,0,1,7,0),(49,'Sonos Beam Soundbar','sonos-beam-soundbar','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/49-1.jpg\",\"products\\/49-2.jpg\",\"products\\/49-3.jpg\",\"products\\/49-4.jpg\"]',NULL,'H1-101',0,16,0,1,'in_stock',1,NULL,3,0,0,10,2.50,0,270.94,164.94,NULL,NULL,13,10,10,746,NULL,'standard',22675,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1761593230791',NULL,NULL,0,0,'auto_generate',0,0,0,2,3,0),(50,'Logitech MX Master 3 Mouse','logitech-mx-master-3-mouse','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/50-1.jpg\",\"products\\/50-2.jpg\",\"products\\/50-3.jpg\",\"products\\/50-4.jpg\"]',NULL,'26-127-A1',0,12,0,1,'in_stock',1,NULL,7,0,3,10,2.80,0,1403.89,NULL,NULL,NULL,10,13,19,524,NULL,'standard',20120,'2026-02-28 08:15:26','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','9181069446181',NULL,NULL,0,0,'auto_generate',0,0,0,1,4,0),(51,'Kindle Paperwhite E-reader','kindle-paperwhite-e-reader','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/51-1.jpg\",\"products\\/51-2.jpg\",\"products\\/51-3.jpg\",\"products\\/51-4.jpg\"]',NULL,'43-119-A1',0,14,0,1,'in_stock',0,NULL,3,0,3,10,2.30,0,884.68,NULL,NULL,NULL,10,13,15,722,NULL,'standard',108237,'2026-02-28 08:15:26','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'physical','2947168230987',NULL,NULL,0,0,'auto_generate',0,0,0,1,5,0),(52,'GoPro HERO10 Black (Digital)','gopro-hero10-black','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/52-1.jpg\",\"products\\/52-2.jpg\",\"products\\/52-3.jpg\"]',NULL,'PS-197-A1',0,18,0,1,'in_stock',0,NULL,6,0,2,10,2.90,0,1631.7,1435.896,NULL,NULL,14,17,20,842,NULL,'standard',114585,'2026-02-28 08:15:26','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'digital','4184969129678',NULL,NULL,0,0,'auto_generate',0,0,0,2,3,0),(53,'Anker PowerCore Power Bank','anker-powercore-power-bank','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/53-1.jpg\",\"products\\/53-2.jpg\",\"products\\/53-3.jpg\",\"products\\/53-4.jpg\"]',NULL,'TC-124',0,14,0,1,'in_stock',0,NULL,4,0,0,9,4.00,0,1721.36,438.36,NULL,NULL,19,19,12,800,NULL,'standard',155245,'2026-02-28 08:15:26','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'physical','8977523613388',NULL,NULL,0,0,'auto_generate',0,0,0,1,4,0),(54,'Samsung Galaxy Buds Pro','samsung-galaxy-buds-pro','<ul><li> Unrestrained and portable active stereo speaker</li>\n            <li> Free from the confines of wires and chords</li>\n            <li> 20 hours of portable capabilities</li>\n            <li> Double-ended Coil Cord with 3.5mm Stereo Plugs Included</li>\n            <li> 3/4″ Dome Tweeters: 2X and 4″ Woofer: 1X</li></ul>','<p>Short Hooded Coat features a straight body, large pockets with button flaps, ventilation air holes, and a string detail along the hemline. The style is completed with a drawstring hood, featuring Rains’ signature built-in cap. Made from waterproof, matte PU, this lightweight unisex rain jacket is an ode to nostalgia through its classic silhouette and utilitarian design details.</p>\n                                <p>- Casual unisex fit</p>\n\n                                <p>- 64% polyester, 36% polyurethane</p>\n\n                                <p>- Water column pressure: 4000 mm</p>\n\n                                <p>- Model is 187cm tall and wearing a size S / M</p>\n\n                                <p>- Unisex fit</p>\n\n                                <p>- Drawstring hood with built-in cap</p>\n\n                                <p>- Front placket with snap buttons</p>\n\n                                <p>- Ventilation under armpit</p>\n\n                                <p>- Adjustable cuffs</p>\n\n                                <p>- Double welted front pockets</p>\n\n                                <p>- Adjustable elastic string at hempen</p>\n\n                                <p>- Ultrasonically welded seams</p>\n\n                                <p>This is a unisex item, please check our clothing &amp; footwear sizing guide for specific Rains jacket sizing information. RAINS comes from the rainy nation of Denmark at the edge of the European continent, close to the ocean and with prevailing westerly winds; all factors that contribute to an average of 121 rain days each year. Arising from these rainy weather conditions comes the attitude that a quick rain shower may be beautiful, as well as moody- but first and foremost requires the right outfit. Rains focus on the whole experience of going outside on rainy days, issuing an invitation to explore even in the most mercurial weather.</p>','published','[\"products\\/54-1.jpg\",\"products\\/54-2.jpg\",\"products\\/54-3.jpg\"]',NULL,'NN-118-A1',0,12,0,1,'in_stock',1,NULL,5,0,1,10,2.80,0,418.9,NULL,NULL,NULL,13,11,19,610,NULL,'standard',160292,'2026-02-28 08:15:26','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'physical','2119102082840',NULL,NULL,0,0,'auto_generate',0,0,0,2,4,0),(55,'Smart Home Speaker',NULL,NULL,NULL,'published','[\"products\\/1-2.jpg\"]',NULL,'2L-192-A1',0,13,0,1,'in_stock',0,NULL,3,1,0,0,0.00,0,700.66,NULL,NULL,NULL,15,20,14,740,NULL,'standard',0,'2026-02-28 08:15:26','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','9809016551916',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(56,'Headphone Ultra Bass',NULL,NULL,NULL,'published','[\"products\\/2-2.jpg\"]',NULL,'Q4-198-A1',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,427.55,NULL,NULL,NULL,15,15,16,620,NULL,'standard',0,'2026-02-28 08:15:26','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','5641949072731',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(57,'Headphone Ultra Bass',NULL,NULL,NULL,'published','[\"products\\/2-3.jpg\"]',NULL,'Q4-198-A1-A2',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,427.55,NULL,NULL,NULL,15,15,16,620,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','8344847962704',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(58,'Headphone Ultra Bass',NULL,NULL,NULL,'published','[\"products\\/2-4.jpg\"]',NULL,'Q4-198-A1-A3',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,427.55,NULL,NULL,NULL,15,15,16,620,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','4066209176652',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(59,'Headphone Ultra Bass',NULL,NULL,NULL,'published','[\"products\\/2-1.jpg\"]',NULL,'Q4-198-A1-A4',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,427.55,NULL,NULL,NULL,15,15,16,620,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','1344989584878',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(60,'Boxed - Bluetooth Headphone',NULL,NULL,NULL,'published','[\"products\\/3-2.jpg\"]',NULL,'HV-119-A1',0,19,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,1924.94,NULL,NULL,NULL,13,13,19,518,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','4174919789823',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(61,'Boxed - Bluetooth Headphone',NULL,NULL,NULL,'published','[\"products\\/3-3.jpg\"]',NULL,'HV-119-A1-A2',0,19,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,1924.94,NULL,NULL,NULL,13,13,19,518,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','2779691494617',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(62,'Boxed - Bluetooth Headphone',NULL,NULL,NULL,'published','[\"products\\/3-4.jpg\"]',NULL,'HV-119-A1-A3',0,19,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,1924.94,NULL,NULL,NULL,13,13,19,518,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','6796224331429',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(63,'Apple Airpods Serial 3',NULL,NULL,NULL,'published','[\"products\\/11-2.jpg\"]',NULL,'3I-156-A1',0,12,0,1,'in_stock',0,NULL,4,1,0,0,0.00,0,240.21,NULL,NULL,NULL,15,18,11,534,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','8081405486394',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(64,'Black Smart Watches',NULL,NULL,NULL,'published','[\"products\\/13-2.jpg\"]',NULL,'OG-118-A1',0,11,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,1098.63,NULL,NULL,NULL,14,18,12,900,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'physical','8592388298534',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(65,'Historic Alarm Clock (Digital)',NULL,NULL,NULL,'published','[\"products\\/16-2.jpg\"]',NULL,'3B-124-A1',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1881.39,1693.251,NULL,NULL,20,17,14,691,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'digital','5041472891289',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(66,'Historic Alarm Clock (Digital)',NULL,NULL,NULL,'published','[\"products\\/16-3.jpg\"]',NULL,'3B-124-A1-A2',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1881.39,1599.1815,NULL,NULL,20,17,14,691,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'digital','4804067498482',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(67,'Historic Alarm Clock (Digital)',NULL,NULL,NULL,'published','[\"products\\/16-4.jpg\"]',NULL,'3B-124-A1-A3',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1881.39,1655.6232,NULL,NULL,20,17,14,691,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:43',0,'Botble\\ACL\\Models\\User',NULL,'digital','2609461046732',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(68,'Phillips Mouse',NULL,NULL,NULL,'published','[\"products\\/18-2.jpg\"]',NULL,'G9-154-A1',0,19,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,712.88,NULL,NULL,NULL,17,17,15,626,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6392334831776',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(69,'Phillips Mouse',NULL,NULL,NULL,'published','[\"products\\/18-3.jpg\"]',NULL,'G9-154-A1-A2',0,19,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,712.88,NULL,NULL,NULL,17,17,15,626,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6781706258783',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(70,'Wireless Keyboard (Digital)',NULL,NULL,NULL,'published','[\"products\\/20-2.jpg\"]',NULL,'EY-177-A1',0,20,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1776.06,1332.045,NULL,NULL,10,11,18,566,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','2445404938166',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(71,'Wireless Keyboard (Digital)',NULL,NULL,NULL,'published','[\"products\\/20-3.jpg\"]',NULL,'EY-177-A1-A2',0,20,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1776.06,1474.1298,NULL,NULL,10,11,18,566,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','3773853108915',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(72,'Wireless Keyboard (Digital)',NULL,NULL,NULL,'published','[\"products\\/20-4.jpg\"]',NULL,'EY-177-A1-A3',0,20,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1776.06,1545.1722,NULL,NULL,10,11,18,566,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','2013847049468',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(73,'Wireless Keyboard (Digital)',NULL,NULL,NULL,'published','[\"products\\/20-1.jpg\"]',NULL,'EY-177-A1-A4',0,20,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1776.06,1491.8904,NULL,NULL,10,11,18,566,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','5957810126824',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(74,'Smart Home Speaker',NULL,NULL,NULL,'published','[\"products\\/22-2.jpg\"]',NULL,'LR-173-A1',0,11,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1510,NULL,NULL,NULL,16,19,14,529,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4378681770380',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(75,'Smart Home Speaker',NULL,NULL,NULL,'published','[\"products\\/22-3.jpg\"]',NULL,'LR-173-A1-A2',0,11,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1510,NULL,NULL,NULL,16,19,14,529,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','2901862732864',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(76,'Smart Home Speaker',NULL,NULL,NULL,'published','[\"products\\/22-4.jpg\"]',NULL,'LR-173-A1-A3',0,11,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1510,NULL,NULL,NULL,16,19,14,529,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','8907835693785',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(77,'Smart Home Speaker',NULL,NULL,NULL,'published','[\"products\\/22-1.jpg\"]',NULL,'LR-173-A1-A4',0,11,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1510,NULL,NULL,NULL,16,19,14,529,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','7671460349058',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(78,'Headphone Ultra Bass',NULL,NULL,NULL,'published','[\"products\\/23-2.jpg\"]',NULL,'SA-170-A1',0,19,0,1,'in_stock',0,NULL,4,1,0,0,0.00,0,1290.99,NULL,NULL,NULL,14,17,16,776,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1574756989005',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(79,'Boxed - Bluetooth Headphone (Digital)',NULL,NULL,NULL,'published','[\"products\\/24-2.jpg\"]',NULL,'0L-125-A1',0,19,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1416.66,1189.9944,NULL,NULL,13,17,13,838,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','7703133540346',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(80,'Boxed - Bluetooth Headphone (Digital)',NULL,NULL,NULL,'published','[\"products\\/24-3.jpg\"]',NULL,'0L-125-A1-A2',0,19,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1416.66,1147.4946,NULL,NULL,13,17,13,838,NULL,'standard',0,'2026-02-28 08:15:27','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','8217818240982',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(81,'Camera Samsung SS-24',NULL,NULL,NULL,'published','[\"products\\/25-2.jpg\"]',NULL,'ZM-195-A1',0,19,0,1,'in_stock',0,NULL,3,1,0,0,0.00,0,146.29,NULL,NULL,NULL,14,18,18,546,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1315915862902',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(82,'Camera Samsung SS-24',NULL,NULL,NULL,'published','[\"products\\/25-3.jpg\"]',NULL,'ZM-195-A1-A2',0,19,0,1,'in_stock',0,NULL,3,1,0,0,0.00,0,146.29,NULL,NULL,NULL,14,18,18,546,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','3299150286762',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(83,'Apple Watch Serial 7',NULL,NULL,NULL,'published','[\"products\\/29-2.jpg\"]',NULL,'MC-114-A1',0,14,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1297.95,NULL,NULL,NULL,10,20,15,532,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4880917931507',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(84,'Apple Watch Serial 7',NULL,NULL,NULL,'published','[\"products\\/29-3.jpg\"]',NULL,'MC-114-A1-A2',0,14,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1297.95,NULL,NULL,NULL,10,20,15,532,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6064424723260',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(85,'Apple Watch Serial 7',NULL,NULL,NULL,'published','[\"products\\/29-1.jpg\"]',NULL,'MC-114-A1-A3',0,14,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1297.95,NULL,NULL,NULL,10,20,15,532,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1645186713413',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(86,'Macbook Pro 13 inch',NULL,NULL,NULL,'published','[\"products\\/30-2.jpg\"]',NULL,'JB-169-A1',0,18,0,1,'in_stock',0,NULL,1,1,0,0,0.00,0,1068.86,NULL,NULL,NULL,10,12,12,780,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','0817415189233',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(87,'Hand playstation',NULL,NULL,NULL,'published','[\"products\\/33-2.jpg\"]',NULL,'NV-109-A1',0,15,0,1,'in_stock',0,NULL,2,1,0,0,0.00,0,1511.61,NULL,NULL,NULL,18,14,15,898,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','5638747181413',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(88,'Apple Airpods Serial 3',NULL,NULL,NULL,'published','[\"products\\/34-2.jpg\"]',NULL,'UB-173-A1',0,18,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1013.42,NULL,NULL,NULL,11,11,16,529,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4880489679920',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(89,'Apple Airpods Serial 3',NULL,NULL,NULL,'published','[\"products\\/34-3.jpg\"]',NULL,'UB-173-A1-A2',0,18,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1013.42,NULL,NULL,NULL,11,11,16,529,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1532943811751',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(90,'Black Smart Watches (Digital)',NULL,NULL,NULL,'published','[\"products\\/36-2.jpg\"]',NULL,'YG-188-A1',0,17,0,1,'in_stock',0,NULL,3,1,0,0,0.00,0,1434.56,1205.0304,NULL,NULL,18,11,13,857,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','9179379987425',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(91,'Black Smart Watches (Digital)',NULL,NULL,NULL,'published','[\"products\\/36-3.jpg\"]',NULL,'YG-188-A1-A2',0,17,0,1,'in_stock',0,NULL,3,1,0,0,0.00,0,1434.56,1248.0672,NULL,NULL,18,11,13,857,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','7987502325905',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(92,'Leather Watch In Black',NULL,NULL,NULL,'published','[\"products\\/37-2.jpg\"]',NULL,'6U-156-A1',0,10,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1726.4,NULL,NULL,NULL,12,17,16,868,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1849135736359',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(93,'Leather Watch In Black',NULL,NULL,NULL,'published','[\"products\\/37-3.jpg\"]',NULL,'6U-156-A1-A2',0,10,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1726.4,NULL,NULL,NULL,12,17,16,868,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','7236644956783',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(94,'Leather Watch In Black',NULL,NULL,NULL,'published','[\"products\\/37-1.jpg\"]',NULL,'6U-156-A1-A3',0,10,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1726.4,NULL,NULL,NULL,12,17,16,868,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4026710608455',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(95,'Leather Watch In Black',NULL,NULL,NULL,'published','[\"products\\/37-1.jpg\"]',NULL,'6U-156-A1-A4',0,10,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1726.4,NULL,NULL,NULL,12,17,16,868,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1918760723772',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(96,'Leather Watch In Black',NULL,NULL,NULL,'published','[\"products\\/37-1.jpg\"]',NULL,'6U-156-A1-A5',0,10,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1726.4,NULL,NULL,NULL,12,17,16,868,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','8253944077252',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(97,'Macbook Pro 2015 13 inch',NULL,NULL,NULL,'published','[\"products\\/38-2.jpg\"]',NULL,'U1-192-A1',0,19,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1345.32,NULL,NULL,NULL,18,17,12,600,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','0304493112074',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(98,'Macbook Pro 2015 13 inch',NULL,NULL,NULL,'published','[\"products\\/38-3.jpg\"]',NULL,'U1-192-A1-A2',0,19,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1345.32,NULL,NULL,NULL,18,17,12,600,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6447445288756',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(99,'Macbook Pro 2015 13 inch',NULL,NULL,NULL,'published','[\"products\\/38-4.jpg\"]',NULL,'U1-192-A1-A3',0,19,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1345.32,NULL,NULL,NULL,18,17,12,600,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1843424713281',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(100,'Macbook Pro 2015 13 inch',NULL,NULL,NULL,'published','[\"products\\/38-1.jpg\"]',NULL,'U1-192-A1-A4',0,19,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1345.32,NULL,NULL,NULL,18,17,12,600,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','1572630158554',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(101,'Sony WH-1000XM4 Wireless Headphones',NULL,NULL,NULL,'published','[\"products\\/39-2.jpg\"]',NULL,'OR-194-A1',0,17,0,1,'in_stock',0,NULL,4,1,0,0,0.00,0,698.35,NULL,NULL,NULL,18,15,14,553,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','0651738611022',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(102,'iPad Pro 12.9-inch',NULL,NULL,NULL,'published','[\"products\\/42-2.jpg\"]',NULL,'ET-130-A1',0,10,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1727.43,NULL,NULL,NULL,13,10,11,762,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6893006865728',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(103,'iPad Pro 12.9-inch',NULL,NULL,NULL,'published','[\"products\\/42-3.jpg\"]',NULL,'ET-130-A1-A2',0,10,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1727.43,NULL,NULL,NULL,13,10,11,762,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','7293916305663',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(104,'Bose QuietComfort Earbuds',NULL,NULL,NULL,'published','[\"products\\/43-2.jpg\"]',NULL,'DC-110-A1',0,16,0,1,'in_stock',0,NULL,1,1,0,0,0.00,0,359.84,NULL,NULL,NULL,18,13,16,735,NULL,'standard',0,'2026-02-28 08:15:28','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6674542614434',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(105,'Bose QuietComfort Earbuds',NULL,NULL,NULL,'published','[\"products\\/43-3.jpg\"]',NULL,'DC-110-A1-A2',0,16,0,1,'in_stock',0,NULL,1,1,0,0,0.00,0,359.84,NULL,NULL,NULL,18,13,16,735,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','7860821603506',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(106,'Bose QuietComfort Earbuds',NULL,NULL,NULL,'published','[\"products\\/43-1.jpg\"]',NULL,'DC-110-A1-A3',0,16,0,1,'in_stock',0,NULL,1,1,0,0,0.00,0,359.84,NULL,NULL,NULL,18,13,16,735,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','4254189668841',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(107,'LG OLED C1 Series TV (Digital)',NULL,NULL,NULL,'published','[\"products\\/44-2.jpg\"]',NULL,'3N-186-A1',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,860.63,602.441,NULL,NULL,14,17,15,621,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','6641878985422',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(108,'LG OLED C1 Series TV (Digital)',NULL,NULL,NULL,'published','[\"products\\/44-3.jpg\"]',NULL,'3N-186-A1-A2',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,860.63,714.3229,NULL,NULL,14,17,15,621,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','6137030082271',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(109,'LG OLED C1 Series TV (Digital)',NULL,NULL,NULL,'published','[\"products\\/44-1.jpg\"]',NULL,'3N-186-A1-A3',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,860.63,628.2599,NULL,NULL,14,17,15,621,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','7282434581611',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(110,'Dyson V11 Vacuum Cleaner',NULL,NULL,NULL,'published','[\"products\\/45-2.jpg\"]',NULL,'HY-160-A1',0,11,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,770.21,NULL,NULL,NULL,20,17,19,689,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','8107210139895',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(111,'Dyson V11 Vacuum Cleaner',NULL,NULL,NULL,'published','[\"products\\/45-3.jpg\"]',NULL,'HY-160-A1-A2',0,11,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,770.21,NULL,NULL,NULL,20,17,19,689,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','0874269196640',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(112,'Dyson V11 Vacuum Cleaner',NULL,NULL,NULL,'published','[\"products\\/45-4.jpg\"]',NULL,'HY-160-A1-A3',0,11,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,770.21,NULL,NULL,NULL,20,17,19,689,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','6234999124711',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(113,'Dyson V11 Vacuum Cleaner',NULL,NULL,NULL,'published','[\"products\\/45-1.jpg\"]',NULL,'HY-160-A1-A4',0,11,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,770.21,NULL,NULL,NULL,20,17,19,689,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','8490367699429',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(114,'Canon EOS R5 Camera',NULL,NULL,NULL,'published','[\"products\\/47-2.jpg\"]',NULL,'VB-166-A1',0,19,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,407.89,NULL,NULL,NULL,15,13,10,896,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','7864887764348',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(115,'Fitbit Sense Smartwatch (Digital)',NULL,NULL,NULL,'published','[\"products\\/48-2.jpg\"]',NULL,'RZ-192-A1',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1974.4,1461.056,NULL,NULL,18,15,11,859,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','6472191847827',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(116,'Fitbit Sense Smartwatch (Digital)',NULL,NULL,NULL,'published','[\"products\\/48-3.jpg\"]',NULL,'RZ-192-A1-A2',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1974.4,1520.288,NULL,NULL,18,15,11,859,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','2832521532092',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(117,'Fitbit Sense Smartwatch (Digital)',NULL,NULL,NULL,'published','[\"products\\/48-4.jpg\"]',NULL,'RZ-192-A1-A3',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1974.4,1559.776,NULL,NULL,18,15,11,859,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','6283692917595',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(118,'Fitbit Sense Smartwatch (Digital)',NULL,NULL,NULL,'published','[\"products\\/48-1.jpg\"]',NULL,'RZ-192-A1-A4',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1974.4,1579.52,NULL,NULL,18,15,11,859,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','7885504986912',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(119,'Fitbit Sense Smartwatch (Digital)',NULL,NULL,NULL,'published','[\"products\\/48-1.jpg\"]',NULL,'RZ-192-A1-A5',0,20,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,1974.4,1401.824,NULL,NULL,18,15,11,859,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'digital','6192312955285',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(120,'Logitech MX Master 3 Mouse',NULL,NULL,NULL,'published','[\"products\\/50-2.jpg\"]',NULL,'26-127-A1',0,12,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,1403.89,NULL,NULL,NULL,10,13,19,524,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','9423853200150',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(121,'Logitech MX Master 3 Mouse',NULL,NULL,NULL,'published','[\"products\\/50-3.jpg\"]',NULL,'26-127-A1-A2',0,12,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,1403.89,NULL,NULL,NULL,10,13,19,524,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','7441800488040',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(122,'Logitech MX Master 3 Mouse',NULL,NULL,NULL,'published','[\"products\\/50-4.jpg\"]',NULL,'26-127-A1-A3',0,12,0,1,'in_stock',0,NULL,7,1,0,0,0.00,0,1403.89,NULL,NULL,NULL,10,13,19,524,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:44',0,'Botble\\ACL\\Models\\User',NULL,'physical','0184982208422',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(123,'Kindle Paperwhite E-reader',NULL,NULL,NULL,'published','[\"products\\/51-2.jpg\"]',NULL,'43-119-A1',0,14,0,1,'in_stock',0,NULL,3,1,0,0,0.00,0,884.68,NULL,NULL,NULL,10,13,15,722,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'physical','3990969089192',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(124,'Kindle Paperwhite E-reader',NULL,NULL,NULL,'published','[\"products\\/51-3.jpg\"]',NULL,'43-119-A1-A2',0,14,0,1,'in_stock',0,NULL,3,1,0,0,0.00,0,884.68,NULL,NULL,NULL,10,13,15,722,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'physical','5791486861180',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(125,'Kindle Paperwhite E-reader',NULL,NULL,NULL,'published','[\"products\\/51-4.jpg\"]',NULL,'43-119-A1-A3',0,14,0,1,'in_stock',0,NULL,3,1,0,0,0.00,0,884.68,NULL,NULL,NULL,10,13,15,722,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'physical','6186753325646',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(126,'GoPro HERO10 Black (Digital)',NULL,NULL,NULL,'published','[\"products\\/52-2.jpg\"]',NULL,'PS-197-A1',0,18,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1631.7,1435.896,NULL,NULL,14,17,20,842,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'digital','1152604538232',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(127,'GoPro HERO10 Black (Digital)',NULL,NULL,NULL,'published','[\"products\\/52-3.jpg\"]',NULL,'PS-197-A1-A2',0,18,0,1,'in_stock',0,NULL,6,1,0,0,0.00,0,1631.7,1468.53,NULL,NULL,14,17,20,842,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'digital','9495993256441',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0),(128,'Samsung Galaxy Buds Pro',NULL,NULL,NULL,'published','[\"products\\/54-2.jpg\"]',NULL,'NN-118-A1',0,12,0,1,'in_stock',0,NULL,5,1,0,0,0.00,0,418.9,NULL,NULL,NULL,13,11,19,610,NULL,'standard',0,'2026-02-28 08:15:29','2026-02-28 08:15:45',0,'Botble\\ACL\\Models\\User',NULL,'physical','7313155089893',NULL,NULL,0,0,'auto_generate',0,0,0,NULL,NULL,0);
/*!40000 ALTER TABLE `ec_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_products_translations`
--

DROP TABLE IF EXISTS `ec_products_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_products_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_products_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `content` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`lang_code`,`ec_products_id`),
  KEY `idx_products_fk` (`ec_products_id`),
  KEY `idx_products_products_lang` (`ec_products_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_products_translations`
--

LOCK TABLES `ec_products_translations` WRITE;
/*!40000 ALTER TABLE `ec_products_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_products_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_review_replies`
--

DROP TABLE IF EXISTS `ec_review_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_review_replies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `review_id` bigint unsigned NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_review_replies_review_id_unique` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_review_replies`
--

LOCK TABLES `ec_review_replies` WRITE;
/*!40000 ALTER TABLE `ec_review_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_review_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_reviews`
--

DROP TABLE IF EXISTS `ec_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_reviews` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `customer_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` bigint unsigned NOT NULL,
  `star` double NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `images` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_reviews_product_id_customer_id_unique` (`product_id`,`customer_id`),
  KEY `ec_reviews_product_id_customer_id_status_created_at_index` (`product_id`,`customer_id`,`status`,`created_at`),
  KEY `review_relation_index` (`product_id`,`customer_id`,`status`),
  KEY `ec_reviews_product_id_status_index` (`product_id`,`status`),
  KEY `ec_reviews_customer_id_status_index` (`customer_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=528 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_reviews`
--

LOCK TABLES `ec_reviews` WRITE;
/*!40000 ALTER TABLE `ec_reviews` DISABLE KEYS */;
INSERT INTO `ec_reviews` VALUES (1,4,NULL,NULL,33,1,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(2,5,NULL,NULL,7,5,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(3,2,NULL,NULL,1,3,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(4,2,NULL,NULL,36,4,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(5,2,NULL,NULL,47,4,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(6,6,NULL,NULL,52,2,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(7,4,NULL,NULL,22,5,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(8,1,NULL,NULL,11,1,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(9,1,NULL,NULL,6,3,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(10,9,NULL,NULL,1,2,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(11,10,NULL,NULL,35,3,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(12,1,NULL,NULL,2,1,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(13,4,NULL,NULL,10,4,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(14,7,NULL,NULL,25,2,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(15,9,NULL,NULL,28,1,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(16,7,NULL,NULL,6,4,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(17,6,NULL,NULL,36,4,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(18,3,NULL,NULL,21,3,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(19,1,NULL,NULL,23,5,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(20,5,NULL,NULL,22,5,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(21,3,NULL,NULL,29,1,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(22,3,NULL,NULL,27,5,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(23,1,NULL,NULL,12,1,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(24,10,NULL,NULL,38,3,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(25,4,NULL,NULL,45,4,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(26,1,NULL,NULL,54,2,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(27,3,NULL,NULL,11,1,'Best ecommerce CMS online store!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(28,8,NULL,NULL,31,4,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(29,10,NULL,NULL,5,2,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(30,1,NULL,NULL,21,1,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(31,10,NULL,NULL,10,4,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(32,4,NULL,NULL,14,2,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(33,4,NULL,NULL,7,2,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(34,9,NULL,NULL,2,3,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(35,9,NULL,NULL,49,2,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(36,8,NULL,NULL,22,5,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(37,9,NULL,NULL,26,4,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(38,6,NULL,NULL,25,4,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(39,2,NULL,NULL,41,3,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(40,1,NULL,NULL,1,5,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(41,2,NULL,NULL,45,5,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(42,9,NULL,NULL,4,1,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(43,7,NULL,NULL,4,5,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(44,4,NULL,NULL,25,3,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(45,3,NULL,NULL,2,3,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(46,1,NULL,NULL,19,2,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(47,2,NULL,NULL,26,2,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(48,6,NULL,NULL,8,4,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(49,2,NULL,NULL,28,5,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(50,5,NULL,NULL,35,5,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(51,7,NULL,NULL,15,3,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(52,2,NULL,NULL,4,3,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(53,10,NULL,NULL,2,2,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(54,7,NULL,NULL,33,1,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(55,10,NULL,NULL,16,3,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(56,5,NULL,NULL,19,4,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(57,6,NULL,NULL,50,5,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(58,1,NULL,NULL,8,3,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(59,7,NULL,NULL,51,2,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(60,3,NULL,NULL,4,4,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(61,5,NULL,NULL,10,2,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(62,6,NULL,NULL,11,2,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(63,8,NULL,NULL,43,5,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(64,2,NULL,NULL,14,4,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(65,3,NULL,NULL,37,3,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(66,5,NULL,NULL,43,4,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(67,1,NULL,NULL,9,5,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(68,1,NULL,NULL,47,1,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(69,4,NULL,NULL,15,4,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(70,10,NULL,NULL,20,2,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(71,3,NULL,NULL,30,5,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(72,5,NULL,NULL,42,3,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(73,4,NULL,NULL,39,5,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(74,1,NULL,NULL,49,1,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(75,6,NULL,NULL,14,2,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(76,3,NULL,NULL,24,4,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(77,10,NULL,NULL,19,1,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(78,7,NULL,NULL,3,1,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(79,2,NULL,NULL,3,1,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(80,1,NULL,NULL,29,5,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(81,7,NULL,NULL,20,2,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(82,5,NULL,NULL,54,5,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(83,2,NULL,NULL,31,2,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(84,2,NULL,NULL,53,4,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(85,3,NULL,NULL,36,2,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(86,3,NULL,NULL,46,5,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(87,10,NULL,NULL,23,5,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(88,8,NULL,NULL,28,2,'Best ecommerce CMS online store!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(89,5,NULL,NULL,26,3,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(90,3,NULL,NULL,48,1,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(91,7,NULL,NULL,23,3,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(92,4,NULL,NULL,32,5,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(93,1,NULL,NULL,13,1,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(94,3,NULL,NULL,20,1,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(95,2,NULL,NULL,22,3,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(96,9,NULL,NULL,42,2,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(97,5,NULL,NULL,39,4,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(98,7,NULL,NULL,49,4,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(99,2,NULL,NULL,39,1,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(100,8,NULL,NULL,46,3,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(101,6,NULL,NULL,6,2,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(102,10,NULL,NULL,54,5,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(103,7,NULL,NULL,1,1,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(104,6,NULL,NULL,46,4,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(105,5,NULL,NULL,38,5,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(106,2,NULL,NULL,2,1,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(107,1,NULL,NULL,27,1,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(108,3,NULL,NULL,31,1,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(109,7,NULL,NULL,50,3,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(110,4,NULL,NULL,1,3,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(111,6,NULL,NULL,26,2,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(112,2,NULL,NULL,32,2,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(113,4,NULL,NULL,3,5,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(114,8,NULL,NULL,35,1,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(115,9,NULL,NULL,15,1,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(116,3,NULL,NULL,35,5,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(117,3,NULL,NULL,50,4,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(118,4,NULL,NULL,37,5,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(119,2,NULL,NULL,33,5,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(120,6,NULL,NULL,18,1,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(121,7,NULL,NULL,54,1,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(122,7,NULL,NULL,11,3,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(123,10,NULL,NULL,44,4,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(124,3,NULL,NULL,26,1,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(125,2,NULL,NULL,34,1,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(126,9,NULL,NULL,12,4,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(127,8,NULL,NULL,19,2,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(128,10,NULL,NULL,9,4,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(129,10,NULL,NULL,6,5,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(130,8,NULL,NULL,17,2,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(131,7,NULL,NULL,45,4,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(132,10,NULL,NULL,51,5,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(133,9,NULL,NULL,34,4,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(134,7,NULL,NULL,35,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(135,2,NULL,NULL,7,2,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(136,7,NULL,NULL,47,1,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(137,6,NULL,NULL,9,5,'Best ecommerce CMS online store!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(138,9,NULL,NULL,47,4,'Best ecommerce CMS online store!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(139,4,NULL,NULL,31,5,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(140,7,NULL,NULL,13,2,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(141,4,NULL,NULL,16,1,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(142,10,NULL,NULL,50,2,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(143,7,NULL,NULL,41,1,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(144,6,NULL,NULL,1,3,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(145,5,NULL,NULL,18,5,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(146,1,NULL,NULL,32,3,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(147,8,NULL,NULL,33,5,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(148,10,NULL,NULL,29,5,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(149,2,NULL,NULL,29,1,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(150,6,NULL,NULL,45,5,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(151,10,NULL,NULL,8,1,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(152,8,NULL,NULL,29,3,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(153,7,NULL,NULL,28,2,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(154,3,NULL,NULL,38,5,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(155,9,NULL,NULL,17,4,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(156,10,NULL,NULL,41,4,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(157,8,NULL,NULL,50,2,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(158,7,NULL,NULL,39,4,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(159,5,NULL,NULL,33,3,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(160,10,NULL,NULL,3,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(161,5,NULL,NULL,9,3,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(162,5,NULL,NULL,3,2,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(163,9,NULL,NULL,35,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(164,10,NULL,NULL,37,5,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(165,3,NULL,NULL,42,5,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(166,6,NULL,NULL,34,5,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(167,5,NULL,NULL,1,5,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(168,10,NULL,NULL,28,5,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(169,10,NULL,NULL,47,2,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(170,9,NULL,NULL,10,5,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(171,4,NULL,NULL,43,4,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(172,3,NULL,NULL,15,4,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(173,9,NULL,NULL,9,1,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(174,8,NULL,NULL,27,2,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(175,2,NULL,NULL,21,1,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(176,1,NULL,NULL,37,3,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(177,9,NULL,NULL,37,5,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(178,1,NULL,NULL,42,5,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(179,6,NULL,NULL,42,4,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(180,6,NULL,NULL,37,4,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(181,8,NULL,NULL,39,4,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(182,8,NULL,NULL,37,4,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(183,4,NULL,NULL,17,5,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(184,9,NULL,NULL,39,2,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(185,3,NULL,NULL,47,3,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(186,4,NULL,NULL,35,3,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(187,5,NULL,NULL,41,1,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(188,3,NULL,NULL,5,1,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(189,1,NULL,NULL,5,3,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(190,9,NULL,NULL,3,4,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(191,9,NULL,NULL,16,5,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(192,2,NULL,NULL,25,5,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(193,6,NULL,NULL,17,4,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(194,2,NULL,NULL,5,5,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(195,9,NULL,NULL,38,3,'Best ecommerce CMS online store!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(196,5,NULL,NULL,2,3,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(197,1,NULL,NULL,7,1,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(198,7,NULL,NULL,7,2,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(199,7,NULL,NULL,24,4,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(200,3,NULL,NULL,45,4,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(201,1,NULL,NULL,40,2,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(202,10,NULL,NULL,34,5,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(203,2,NULL,NULL,49,2,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(204,3,NULL,NULL,54,1,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(205,10,NULL,NULL,40,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(206,4,NULL,NULL,21,3,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(207,5,NULL,NULL,14,3,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(208,2,NULL,NULL,15,1,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(209,9,NULL,NULL,8,5,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(210,4,NULL,NULL,40,4,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(211,9,NULL,NULL,32,2,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(212,3,NULL,NULL,52,3,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(213,4,NULL,NULL,51,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(214,10,NULL,NULL,46,3,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(215,4,NULL,NULL,20,3,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(216,1,NULL,NULL,15,4,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(217,5,NULL,NULL,6,1,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(218,10,NULL,NULL,52,1,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(219,10,NULL,NULL,11,5,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(220,3,NULL,NULL,22,3,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(221,5,NULL,NULL,30,5,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(222,7,NULL,NULL,29,5,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(223,3,NULL,NULL,51,2,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(224,7,NULL,NULL,10,2,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(225,6,NULL,NULL,19,2,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(226,5,NULL,NULL,32,4,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(227,5,NULL,NULL,53,5,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(228,3,NULL,NULL,25,2,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(229,1,NULL,NULL,34,2,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(230,3,NULL,NULL,16,4,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(231,1,NULL,NULL,38,2,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(232,8,NULL,NULL,34,2,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(233,8,NULL,NULL,38,5,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(234,2,NULL,NULL,51,2,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(235,2,NULL,NULL,38,5,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(236,8,NULL,NULL,54,2,'Best ecommerce CMS online store!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(237,10,NULL,NULL,36,4,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(238,10,NULL,NULL,42,5,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(239,9,NULL,NULL,13,4,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(240,6,NULL,NULL,38,2,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(241,10,NULL,NULL,18,1,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(242,4,NULL,NULL,11,4,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(243,9,NULL,NULL,44,4,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(244,5,NULL,NULL,12,1,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(245,6,NULL,NULL,10,2,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(246,8,NULL,NULL,11,4,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(247,5,NULL,NULL,13,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(248,8,NULL,NULL,1,4,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(249,7,NULL,NULL,32,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(250,4,NULL,NULL,12,1,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(251,6,NULL,NULL,3,1,'Best ecommerce CMS online store!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(252,7,NULL,NULL,27,1,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(253,2,NULL,NULL,17,2,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(254,3,NULL,NULL,32,5,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(255,1,NULL,NULL,30,2,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(256,1,NULL,NULL,31,4,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(257,10,NULL,NULL,21,3,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(258,7,NULL,NULL,22,1,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(259,6,NULL,NULL,23,3,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(260,8,NULL,NULL,14,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(261,7,NULL,NULL,46,2,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(262,7,NULL,NULL,18,4,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(263,4,NULL,NULL,29,4,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(264,10,NULL,NULL,39,5,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(265,7,NULL,NULL,19,4,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(266,7,NULL,NULL,5,2,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(267,9,NULL,NULL,29,1,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(268,6,NULL,NULL,5,4,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(269,4,NULL,NULL,48,3,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(270,8,NULL,NULL,32,1,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(271,9,NULL,NULL,11,1,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(272,3,NULL,NULL,40,5,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(273,1,NULL,NULL,18,1,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(274,4,NULL,NULL,44,5,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(275,10,NULL,NULL,31,5,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(276,4,NULL,NULL,50,4,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(277,7,NULL,NULL,37,3,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(278,6,NULL,NULL,2,5,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(279,1,NULL,NULL,36,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(280,7,NULL,NULL,38,1,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(281,7,NULL,NULL,17,3,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(282,5,NULL,NULL,31,3,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(283,1,NULL,NULL,35,2,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(284,2,NULL,NULL,11,5,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(285,9,NULL,NULL,33,5,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(286,6,NULL,NULL,16,4,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(287,5,NULL,NULL,36,3,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(288,9,NULL,NULL,21,4,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(289,7,NULL,NULL,48,2,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(290,7,NULL,NULL,40,3,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(291,6,NULL,NULL,47,4,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(292,6,NULL,NULL,12,4,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(293,6,NULL,NULL,48,1,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(294,6,NULL,NULL,27,2,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(295,10,NULL,NULL,4,2,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(296,6,NULL,NULL,43,5,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(297,7,NULL,NULL,34,3,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(298,5,NULL,NULL,50,2,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(299,5,NULL,NULL,47,1,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(300,2,NULL,NULL,19,5,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(301,7,NULL,NULL,43,2,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(302,5,NULL,NULL,29,4,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(303,5,NULL,NULL,20,5,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(304,9,NULL,NULL,54,3,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(305,6,NULL,NULL,30,5,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(306,8,NULL,NULL,26,4,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(307,7,NULL,NULL,30,3,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(308,6,NULL,NULL,41,3,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(309,6,NULL,NULL,31,5,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(310,8,NULL,NULL,21,3,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(311,4,NULL,NULL,41,5,'Clean & perfect source code','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(312,8,NULL,NULL,53,4,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(313,10,NULL,NULL,25,2,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(314,9,NULL,NULL,20,1,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(315,10,NULL,NULL,17,1,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(316,8,NULL,NULL,8,3,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(317,2,NULL,NULL,43,3,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(318,8,NULL,NULL,24,5,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(319,5,NULL,NULL,34,4,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(320,9,NULL,NULL,25,1,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(321,2,NULL,NULL,35,1,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(322,1,NULL,NULL,20,1,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(323,5,NULL,NULL,28,2,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(324,8,NULL,NULL,40,2,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(325,10,NULL,NULL,12,4,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(326,6,NULL,NULL,15,2,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(327,7,NULL,NULL,21,2,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(328,9,NULL,NULL,5,2,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(329,3,NULL,NULL,10,3,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:33','2026-02-28 08:15:33',NULL),(330,5,NULL,NULL,15,4,'This script is well coded and is super fast. The support is pretty quick. Very patient and helpful team. I strongly recommend it and they deserve more than 5 stars.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(331,5,NULL,NULL,48,5,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(332,5,NULL,NULL,52,3,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(333,1,NULL,NULL,28,3,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(334,8,NULL,NULL,51,1,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(335,10,NULL,NULL,30,1,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(336,8,NULL,NULL,48,3,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(337,3,NULL,NULL,53,4,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(338,1,NULL,NULL,16,3,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(339,3,NULL,NULL,9,2,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(340,10,NULL,NULL,13,3,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(341,8,NULL,NULL,6,3,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(342,8,NULL,NULL,23,5,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(343,7,NULL,NULL,44,3,'Best ecommerce CMS online store!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(344,1,NULL,NULL,33,4,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(345,3,NULL,NULL,1,4,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(346,5,NULL,NULL,17,3,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(347,8,NULL,NULL,18,3,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(348,5,NULL,NULL,5,1,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(349,7,NULL,NULL,14,5,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(350,5,NULL,NULL,46,2,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(351,4,NULL,NULL,52,2,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(352,8,NULL,NULL,3,3,'Clean & perfect source code','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(353,10,NULL,NULL,15,5,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(354,5,NULL,NULL,40,1,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(355,10,NULL,NULL,24,5,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(356,1,NULL,NULL,3,2,'Clean & perfect source code','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(357,5,NULL,NULL,16,4,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(358,4,NULL,NULL,53,4,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(359,3,NULL,NULL,3,4,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(360,6,NULL,NULL,7,4,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(361,6,NULL,NULL,40,2,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(362,3,NULL,NULL,34,1,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(363,9,NULL,NULL,52,4,'Best ecommerce CMS online store!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(364,1,NULL,NULL,39,5,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(365,2,NULL,NULL,9,4,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(366,3,NULL,NULL,19,1,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(367,2,NULL,NULL,20,4,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(368,6,NULL,NULL,49,2,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(369,7,NULL,NULL,31,1,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(370,6,NULL,NULL,28,5,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(371,9,NULL,NULL,6,1,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(372,7,NULL,NULL,16,5,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(373,4,NULL,NULL,5,3,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(374,2,NULL,NULL,40,3,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(375,8,NULL,NULL,2,5,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(376,4,NULL,NULL,19,2,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(377,8,NULL,NULL,12,5,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(378,1,NULL,NULL,10,2,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(379,2,NULL,NULL,46,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(380,8,NULL,NULL,13,2,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(381,1,NULL,NULL,41,2,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(382,7,NULL,NULL,42,4,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(383,7,NULL,NULL,36,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(384,6,NULL,NULL,54,2,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(385,7,NULL,NULL,8,5,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(386,4,NULL,NULL,18,3,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(387,5,NULL,NULL,45,3,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(388,1,NULL,NULL,52,5,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(389,4,NULL,NULL,47,3,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(390,8,NULL,NULL,20,4,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(391,8,NULL,NULL,15,5,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(392,3,NULL,NULL,44,1,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(393,5,NULL,NULL,21,4,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(394,1,NULL,NULL,53,4,'Clean & perfect source code','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(395,5,NULL,NULL,23,1,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(396,6,NULL,NULL,13,1,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(397,8,NULL,NULL,7,1,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(398,4,NULL,NULL,36,4,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(399,5,NULL,NULL,8,3,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(400,5,NULL,NULL,24,4,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(401,6,NULL,NULL,20,3,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(402,2,NULL,NULL,30,5,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(403,4,NULL,NULL,27,3,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(404,1,NULL,NULL,25,2,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(405,7,NULL,NULL,2,5,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(406,2,NULL,NULL,6,2,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(407,3,NULL,NULL,18,3,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(408,2,NULL,NULL,12,1,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(409,9,NULL,NULL,18,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(410,4,NULL,NULL,26,4,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(411,9,NULL,NULL,53,3,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(412,3,NULL,NULL,23,3,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(413,6,NULL,NULL,44,3,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(414,4,NULL,NULL,8,3,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(415,6,NULL,NULL,24,5,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(416,4,NULL,NULL,24,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(417,4,NULL,NULL,9,4,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(418,3,NULL,NULL,49,1,'Clean & perfect source code','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(419,9,NULL,NULL,27,1,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(420,8,NULL,NULL,41,5,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(421,2,NULL,NULL,44,4,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(422,4,NULL,NULL,38,1,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(423,9,NULL,NULL,41,5,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(424,8,NULL,NULL,25,2,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(425,1,NULL,NULL,51,1,'Best ecommerce CMS online store!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(426,2,NULL,NULL,18,3,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(427,4,NULL,NULL,2,1,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(428,2,NULL,NULL,27,5,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(429,2,NULL,NULL,52,2,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(430,6,NULL,NULL,21,1,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(431,8,NULL,NULL,9,1,'Clean & perfect source code','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(432,8,NULL,NULL,45,4,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(433,1,NULL,NULL,45,1,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(434,6,NULL,NULL,33,2,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(435,5,NULL,NULL,51,4,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(436,9,NULL,NULL,31,4,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(437,4,NULL,NULL,49,4,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(438,5,NULL,NULL,25,4,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(439,9,NULL,NULL,43,1,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(440,5,NULL,NULL,37,4,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(441,3,NULL,NULL,8,5,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(442,6,NULL,NULL,22,4,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(443,3,NULL,NULL,13,5,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(444,4,NULL,NULL,34,5,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(445,4,NULL,NULL,28,2,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(446,7,NULL,NULL,26,3,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(447,3,NULL,NULL,7,5,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(448,9,NULL,NULL,50,2,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(449,8,NULL,NULL,10,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(450,4,NULL,NULL,42,1,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(451,10,NULL,NULL,49,4,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(452,10,NULL,NULL,43,4,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(453,6,NULL,NULL,53,4,'Best ecommerce CMS online store!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(454,1,NULL,NULL,22,2,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(455,2,NULL,NULL,50,2,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(456,2,NULL,NULL,8,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(457,4,NULL,NULL,6,2,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(458,9,NULL,NULL,51,1,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(459,2,NULL,NULL,24,2,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(460,3,NULL,NULL,28,2,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(461,10,NULL,NULL,53,4,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(462,4,NULL,NULL,30,4,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(463,2,NULL,NULL,48,5,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(464,6,NULL,NULL,35,2,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(465,1,NULL,NULL,17,1,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(466,10,NULL,NULL,1,1,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(467,2,NULL,NULL,42,3,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(468,3,NULL,NULL,41,4,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(469,8,NULL,NULL,52,5,'Best ecommerce CMS online store!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(470,5,NULL,NULL,44,4,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(471,4,NULL,NULL,54,3,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(472,10,NULL,NULL,26,1,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(473,9,NULL,NULL,14,3,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(474,9,NULL,NULL,19,5,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(475,3,NULL,NULL,39,2,'These guys are amazing! Responses immediately, amazing support and help... I immediately feel at ease after Purchasing..','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(476,4,NULL,NULL,46,5,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(477,9,NULL,NULL,46,5,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(478,9,NULL,NULL,48,2,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(479,9,NULL,NULL,45,4,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(480,2,NULL,NULL,54,4,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(481,1,NULL,NULL,50,2,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(482,8,NULL,NULL,5,1,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(483,10,NULL,NULL,32,2,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(484,9,NULL,NULL,22,1,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(485,9,NULL,NULL,30,5,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(486,4,NULL,NULL,23,2,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(487,8,NULL,NULL,4,5,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(488,6,NULL,NULL,32,2,'Clean & perfect source code','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(489,10,NULL,NULL,48,1,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(490,1,NULL,NULL,4,2,'Solution is too robust for our purpose so we didn\'t use it at the end. But I appreciate customer support during initial configuration.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(491,6,NULL,NULL,39,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(492,4,NULL,NULL,13,1,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(493,3,NULL,NULL,14,3,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(494,4,NULL,NULL,4,3,'This web app is really good in design, code quality & features. Besides, the customer support provided by the Botble team was really fast & helpful. You guys are awesome!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(495,6,NULL,NULL,29,3,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(496,1,NULL,NULL,43,3,'The code is good, in general, if you like it, can you give it 5 stars?','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(497,8,NULL,NULL,47,2,'Clean & perfect source code','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(498,10,NULL,NULL,22,1,'Clean & perfect source code','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(499,9,NULL,NULL,36,2,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(500,1,NULL,NULL,26,4,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(501,3,NULL,NULL,17,4,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(502,3,NULL,NULL,6,4,'Good app, good backup service and support. Good documentation.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(503,8,NULL,NULL,16,1,'The script is the best of its class, fast, easy to implement and work with , and the most important thing is the great support team , Recommend with no doubt.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(504,5,NULL,NULL,49,2,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(505,8,NULL,NULL,44,2,'Very enthusiastic support! Excellent code is written. It\'s a true pleasure working with.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(506,8,NULL,NULL,30,3,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(507,10,NULL,NULL,27,3,'Those guys now what they are doing, the release such a good product that it\'s a pleasure to work with ! Even when I was stuck on the project, I created a ticket and the next day it was replied by the team. GOOD JOB guys. I love working with them :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(508,10,NULL,NULL,7,2,'Great system, great support, good job Botble. I\'m looking forward to more great functional plugins.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(509,7,NULL,NULL,52,2,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(510,1,NULL,NULL,48,4,'Perfect +++++++++ i love it really also i get to fast ticket answers... Thanks Lot BOTBLE Teams','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(511,5,NULL,NULL,27,2,'Cool template. Excellent code quality. The support responds very quickly, which is very rare on themeforest and Our Team.net, I buy a lot of templates, and everyone will have a response from technical support for two or three days. Thanks to tech support. I recommend to buy.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(512,9,NULL,NULL,24,3,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(513,9,NULL,NULL,23,5,'Customer Support are grade (A*), however the code is a way too over engineered for it\'s purpose.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(514,3,NULL,NULL,12,5,'As a developer I reviewed this script. This is really awesome ecommerce script. I have convinced when I noticed that it\'s built on fully WordPress concept.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(515,1,NULL,NULL,44,2,'Ok good product. I have some issues in customizations. But its not correct to blame the developer. The product is good. Good luck for your business.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(516,8,NULL,NULL,49,3,'It\'s not my first experience here on Our Team and I can honestly tell you all that Botble puts a LOT of effort into the support. They answer so fast, they helped me tons of times. REALLY by far THE BEST EXPERIENCE on Our Team. Those guys at Botble are so good that they deserve 5 stars. I recommend them, I trust them and I can\'t wait to see what they will sell in a near future. Thank you Botble :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(517,1,NULL,NULL,24,4,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(518,10,NULL,NULL,33,5,'I Love this Script. I also found how to add other fees. Now I just wait the BIG update for the Marketplace with the Bulk Import. Just do not forget to make it to be Multi-language for us the Botble Fans.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(519,6,NULL,NULL,51,3,'We have received brilliant service support and will be expanding the features with the developer. Nice product!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(520,10,NULL,NULL,14,4,'The best ecommerce CMS! Excellent coding! best support service! Thank you so much..... I really like your hard work.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(521,9,NULL,NULL,40,3,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(522,2,NULL,NULL,16,4,'Great E-commerce system. And much more : Wonderful Customer Support.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(523,8,NULL,NULL,36,5,'The best store template! Excellent coding! Very good support! Thank you so much for all the help, I really appreciated.','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(524,5,NULL,NULL,11,5,'Amazing code, amazing support. Overall, im really confident in Botble and im happy I made the right choice! Thank you so much guys Our Team','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(525,2,NULL,NULL,23,4,'Second or third time that I buy a Our Team, happy with the products and support. You guys do a good job :)','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(526,3,NULL,NULL,43,4,'Best ecommerce CMS online store!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL),(527,1,NULL,NULL,46,2,'For me the best eCommerce script on Our Team at this moment: modern, clean code, a lot of great features. The customer support is great too: I always get an answer within hours!','published','2026-02-28 08:15:34','2026-02-28 08:15:34',NULL);
/*!40000 ALTER TABLE `ec_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shared_wishlists`
--

DROP TABLE IF EXISTS `ec_shared_wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shared_wishlists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_ids` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_shared_wishlists_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shared_wishlists`
--

LOCK TABLES `ec_shared_wishlists` WRITE;
/*!40000 ALTER TABLE `ec_shared_wishlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_shared_wishlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipment_histories`
--

DROP TABLE IF EXISTS `ec_shipment_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipment_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `shipment_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipment_histories`
--

LOCK TABLES `ec_shipment_histories` WRITE;
/*!40000 ALTER TABLE `ec_shipment_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_shipment_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipments`
--

DROP TABLE IF EXISTS `ec_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `weight` double DEFAULT '0',
  `shipment_id` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate_id` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `cod_amount` decimal(15,2) DEFAULT '0.00',
  `cod_status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `cross_checking_status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `price` decimal(15,2) DEFAULT '0.00',
  `store_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tracking_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_company_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tracking_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estimate_date_shipped` datetime DEFAULT NULL,
  `date_shipped` datetime DEFAULT NULL,
  `customer_delivered_confirmed_at` timestamp NULL DEFAULT NULL,
  `label_url` text COLLATE utf8mb4_unicode_ci,
  `metadata` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_shipments_order_id_unique` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipments`
--

LOCK TABLES `ec_shipments` WRITE;
/*!40000 ALTER TABLE `ec_shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipping`
--

DROP TABLE IF EXISTS `ec_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipping`
--

LOCK TABLES `ec_shipping` WRITE;
/*!40000 ALTER TABLE `ec_shipping` DISABLE KEYS */;
INSERT INTO `ec_shipping` VALUES (1,'All',NULL,'2026-02-28 08:15:35','2026-02-28 08:15:35');
/*!40000 ALTER TABLE `ec_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipping_rule_items`
--

DROP TABLE IF EXISTS `ec_shipping_rule_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipping_rule_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipping_rule_id` bigint unsigned NOT NULL,
  `country` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code_from` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code_to` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjustment_price` decimal(15,2) DEFAULT '0.00',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_zip_range` (`zip_code_from`,`zip_code_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipping_rule_items`
--

LOCK TABLES `ec_shipping_rule_items` WRITE;
/*!40000 ALTER TABLE `ec_shipping_rule_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_shipping_rule_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipping_rules`
--

DROP TABLE IF EXISTS `ec_shipping_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipping_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_id` bigint unsigned NOT NULL,
  `type` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT 'based_on_price',
  `from` decimal(15,2) DEFAULT '0.00',
  `to` decimal(15,2) DEFAULT '0.00',
  `price` decimal(15,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipping_rules`
--

LOCK TABLES `ec_shipping_rules` WRITE;
/*!40000 ALTER TABLE `ec_shipping_rules` DISABLE KEYS */;
INSERT INTO `ec_shipping_rules` VALUES (1,'Free delivery',1,'based_on_price',1000.00,NULL,0.00,'2026-02-28 08:15:35','2026-02-28 08:15:35'),(2,'Flat Rate',1,'based_on_price',0.00,NULL,20.00,'2026-02-28 08:15:35','2026-02-28 08:15:35'),(3,'Local Pickup',1,'based_on_price',0.00,NULL,0.00,'2026-02-28 08:15:35','2026-02-28 08:15:35');
/*!40000 ALTER TABLE `ec_shipping_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_specification_attributes`
--

DROP TABLE IF EXISTS `ec_specification_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_specification_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `default_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `author_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_specification_attributes_author_type_author_id_index` (`author_type`,`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_specification_attributes`
--

LOCK TABLES `ec_specification_attributes` WRITE;
/*!40000 ALTER TABLE `ec_specification_attributes` DISABLE KEYS */;
INSERT INTO `ec_specification_attributes` VALUES (1,1,'Height','text',NULL,NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(2,1,'Width','text',NULL,NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(3,1,'Weight','text',NULL,NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(4,2,'Power','text',NULL,NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(5,2,'Speed','text',NULL,NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(6,3,'Battery Life','text',NULL,NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(7,4,'Screen Size','text',NULL,NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(8,4,'Resolution','select','[\"1920x1080\",\"2560x1440\",\"3840x2160\"]',NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL);
/*!40000 ALTER TABLE `ec_specification_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_specification_attributes_translations`
--

DROP TABLE IF EXISTS `ec_specification_attributes_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_specification_attributes_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_specification_attributes_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `default_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_specification_attributes_id`),
  KEY `idx_specification_attributes_fk` (`ec_specification_attributes_id`),
  KEY `idx_specification_attributes_specification_attributes_lang` (`ec_specification_attributes_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_specification_attributes_translations`
--

LOCK TABLES `ec_specification_attributes_translations` WRITE;
/*!40000 ALTER TABLE `ec_specification_attributes_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_specification_attributes_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_specification_groups`
--

DROP TABLE IF EXISTS `ec_specification_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_specification_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `author_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_specification_groups_author_type_author_id_index` (`author_type`,`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_specification_groups`
--

LOCK TABLES `ec_specification_groups` WRITE;
/*!40000 ALTER TABLE `ec_specification_groups` DISABLE KEYS */;
INSERT INTO `ec_specification_groups` VALUES (1,'Dimensions',NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(2,'Performance',NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(3,'Battery',NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(4,'Display',NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL);
/*!40000 ALTER TABLE `ec_specification_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_specification_groups_translations`
--

DROP TABLE IF EXISTS `ec_specification_groups_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_specification_groups_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_specification_groups_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_specification_groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_specification_groups_translations`
--

LOCK TABLES `ec_specification_groups_translations` WRITE;
/*!40000 ALTER TABLE `ec_specification_groups_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_specification_groups_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_specification_table_group`
--

DROP TABLE IF EXISTS `ec_specification_table_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_specification_table_group` (
  `table_id` bigint unsigned NOT NULL,
  `group_id` bigint unsigned NOT NULL,
  `order` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`table_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_specification_table_group`
--

LOCK TABLES `ec_specification_table_group` WRITE;
/*!40000 ALTER TABLE `ec_specification_table_group` DISABLE KEYS */;
INSERT INTO `ec_specification_table_group` VALUES (1,1,0),(1,2,0),(2,3,0),(2,4,0);
/*!40000 ALTER TABLE `ec_specification_table_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_specification_tables`
--

DROP TABLE IF EXISTS `ec_specification_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_specification_tables` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `author_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_specification_tables_author_type_author_id_index` (`author_type`,`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_specification_tables`
--

LOCK TABLES `ec_specification_tables` WRITE;
/*!40000 ALTER TABLE `ec_specification_tables` DISABLE KEYS */;
INSERT INTO `ec_specification_tables` VALUES (1,'General Specification',NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL),(2,'Technical Specification',NULL,'2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,NULL);
/*!40000 ALTER TABLE `ec_specification_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_specification_tables_translations`
--

DROP TABLE IF EXISTS `ec_specification_tables_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_specification_tables_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_specification_tables_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_specification_tables_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_specification_tables_translations`
--

LOCK TABLES `ec_specification_tables_translations` WRITE;
/*!40000 ALTER TABLE `ec_specification_tables_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_specification_tables_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_store_locators`
--

DROP TABLE IF EXISTS `ec_store_locators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_store_locators` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `is_shipping_location` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_store_locators`
--

LOCK TABLES `ec_store_locators` WRITE;
/*!40000 ALTER TABLE `ec_store_locators` DISABLE KEYS */;
INSERT INTO `ec_store_locators` VALUES (1,'Martfury','sales@botble.com','1800979769','502 New Street','AU','Brighton VIC','Brighton VIC',1,1,'2026-02-28 08:15:40','2026-02-28 08:15:40',NULL);
/*!40000 ALTER TABLE `ec_store_locators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_tax_products`
--

DROP TABLE IF EXISTS `ec_tax_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_tax_products` (
  `tax_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`tax_id`),
  KEY `ec_tax_products_tax_id_index` (`tax_id`),
  KEY `ec_tax_products_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_tax_products`
--

LOCK TABLES `ec_tax_products` WRITE;
/*!40000 ALTER TABLE `ec_tax_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_tax_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_tax_rules`
--

DROP TABLE IF EXISTS `ec_tax_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_tax_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_id` bigint unsigned NOT NULL,
  `country` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `percentage` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_tax_rules`
--

LOCK TABLES `ec_tax_rules` WRITE;
/*!40000 ALTER TABLE `ec_tax_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_tax_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_taxes`
--

DROP TABLE IF EXISTS `ec_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_taxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentage` float DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_taxes`
--

LOCK TABLES `ec_taxes` WRITE;
/*!40000 ALTER TABLE `ec_taxes` DISABLE KEYS */;
INSERT INTO `ec_taxes` VALUES (1,'VAT',10,1,'published','2026-02-28 08:15:34','2026-02-28 08:15:34'),(2,'None',0,2,'published','2026-02-28 08:15:34','2026-02-28 08:15:34'),(3,'Import Tax',15,3,'published','2026-02-28 08:15:34','2026-02-28 08:15:34');
/*!40000 ALTER TABLE `ec_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_taxes_translations`
--

DROP TABLE IF EXISTS `ec_taxes_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_taxes_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ec_taxes_id` bigint unsigned NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_taxes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_taxes_translations`
--

LOCK TABLES `ec_taxes_translations` WRITE;
/*!40000 ALTER TABLE `ec_taxes_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_taxes_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_wish_lists`
--

DROP TABLE IF EXISTS `ec_wish_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_wish_lists` (
  `customer_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`product_id`),
  KEY `wishlist_relation_index` (`product_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_wish_lists`
--

LOCK TABLES `ec_wish_lists` WRITE;
/*!40000 ALTER TABLE `ec_wish_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_wish_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq_categories`
--

DROP TABLE IF EXISTS `faq_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` tinyint NOT NULL DEFAULT '0',
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq_categories`
--

LOCK TABLES `faq_categories` WRITE;
/*!40000 ALTER TABLE `faq_categories` DISABLE KEYS */;
INSERT INTO `faq_categories` VALUES (1,'SHIPPING',0,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL),(2,'PAYMENT',1,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL),(3,'ORDER &amp; RETURNS',2,'published','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL);
/*!40000 ALTER TABLE `faq_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq_categories_translations`
--

DROP TABLE IF EXISTS `faq_categories_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_categories_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `faq_categories_id` bigint unsigned NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`faq_categories_id`),
  KEY `idx_faq_cat_trans_faq_cat_id` (`faq_categories_id`),
  KEY `idx_faq_cat_trans_faq_cat_lang` (`faq_categories_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq_categories_translations`
--

LOCK TABLES `faq_categories_translations` WRITE;
/*!40000 ALTER TABLE `faq_categories_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `faq_categories_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES (1,'What Shipping Methods Are Available?','We offer several shipping methods including Standard Shipping, Express Shipping, and Overnight Delivery. You can select your preferred method at checkout.',1,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(2,'Do You Ship Internationally?','Yes, we ship to over 200 countries worldwide. International shipping rates and delivery times vary by location.',1,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(3,'How Long Will It Take To Get My Package?','Standard shipping typically takes 3-5 business days. Express shipping takes 1-2 business days. International orders may take 7-14 business days depending on customs.',1,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(4,'What Payment Methods Are Accepted?','We accept all major credit cards (Visa, MasterCard, American Express), PayPal, and Apple Pay. We also support local payment methods depending on your region.',2,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(5,'Is Buying On-Line Safe?','Yes, buying online with us is completely safe. We use SSL encryption to protect your personal and payment information. We do not store your credit card details.',2,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(6,'How do I place an Order?','To place an order, browse our catalog, select the items you like, and add them to your cart. Then proceed to checkout, enter your shipping and payment details, and confirm your order.',3,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(7,'How Can I Cancel Or Change My Order?','You can cancel or change your order within 1 hour of placing it by contacting our customer support. After that, we may have already processed it, but we will do our best to assist you.',3,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(8,'Do I need an account to place an order?','No, you can place an order as a guest. However, creating an account allows you to track your orders, save your address for faster checkout, and access exclusive offers.',3,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(9,'How Do I Track My Order?','Once your order is shipped, we will send you a tracking number via email. You can use this number to track your package on our website or the carrier\'s tracking page.',3,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(10,'How Can I Return a Product?','We accept returns within 30 days of purchase. The item must be unused and in its original packaging. Please contact our support team to initiate a return and get a return shipping label.',3,'published','2026-02-28 08:15:37','2026-02-28 08:15:37');
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs_translations`
--

DROP TABLE IF EXISTS `faqs_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `faqs_id` bigint unsigned NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci,
  `answer` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`lang_code`,`faqs_id`),
  KEY `idx_faqs_trans_faqs_id` (`faqs_id`),
  KEY `idx_faqs_trans_faq_lang` (`faqs_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs_translations`
--

LOCK TABLES `faqs_translations` WRITE;
/*!40000 ALTER TABLE `faqs_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `faqs_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_meta`
--

DROP TABLE IF EXISTS `language_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language_meta` (
  `lang_meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `lang_meta_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang_meta_origin` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint unsigned NOT NULL,
  `reference_type` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`lang_meta_id`),
  KEY `language_meta_reference_id_index` (`reference_id`),
  KEY `meta_code_index` (`lang_meta_code`),
  KEY `meta_origin_index` (`lang_meta_origin`),
  KEY `meta_reference_type_index` (`reference_type`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_meta`
--

LOCK TABLES `language_meta` WRITE;
/*!40000 ALTER TABLE `language_meta` DISABLE KEYS */;
INSERT INTO `language_meta` VALUES (1,'en_US','5a932373f864d0c544a7d3fd27bd8e0d',1,'Botble\\SimpleSlider\\Models\\SimpleSlider'),(2,'en_US','96a44ca509567b48f00a007b5e62347b',1,'Botble\\Menu\\Models\\MenuLocation'),(3,'en_US','49a02df9d15c6e97d160bde2339a2c47',1,'Botble\\Menu\\Models\\Menu'),(4,'en_US','4acd30e72d7e6eea7ba3a8816f54adaf',2,'Botble\\Menu\\Models\\Menu'),(5,'en_US','950fbed8c661e1d27641f10e1ff095f3',3,'Botble\\Menu\\Models\\Menu'),(6,'en_US','79e6a17eda7c073021b2719127c7ca75',4,'Botble\\Menu\\Models\\Menu'),(7,'ar','96a44ca509567b48f00a007b5e62347b',2,'Botble\\Menu\\Models\\MenuLocation'),(8,'ar','49a02df9d15c6e97d160bde2339a2c47',5,'Botble\\Menu\\Models\\Menu'),(9,'ar','4acd30e72d7e6eea7ba3a8816f54adaf',6,'Botble\\Menu\\Models\\Menu'),(10,'ar','950fbed8c661e1d27641f10e1ff095f3',7,'Botble\\Menu\\Models\\Menu'),(11,'ar','79e6a17eda7c073021b2719127c7ca75',8,'Botble\\Menu\\Models\\Menu'),(12,'vi','96a44ca509567b48f00a007b5e62347b',3,'Botble\\Menu\\Models\\MenuLocation'),(13,'vi','49a02df9d15c6e97d160bde2339a2c47',9,'Botble\\Menu\\Models\\Menu'),(14,'vi','4acd30e72d7e6eea7ba3a8816f54adaf',10,'Botble\\Menu\\Models\\Menu'),(15,'vi','950fbed8c661e1d27641f10e1ff095f3',11,'Botble\\Menu\\Models\\Menu'),(16,'vi','79e6a17eda7c073021b2719127c7ca75',12,'Botble\\Menu\\Models\\Menu'),(17,'fr','96a44ca509567b48f00a007b5e62347b',4,'Botble\\Menu\\Models\\MenuLocation'),(18,'fr','49a02df9d15c6e97d160bde2339a2c47',13,'Botble\\Menu\\Models\\Menu'),(19,'fr','4acd30e72d7e6eea7ba3a8816f54adaf',14,'Botble\\Menu\\Models\\Menu'),(20,'fr','950fbed8c661e1d27641f10e1ff095f3',15,'Botble\\Menu\\Models\\Menu'),(21,'fr','79e6a17eda7c073021b2719127c7ca75',16,'Botble\\Menu\\Models\\Menu'),(22,'id','96a44ca509567b48f00a007b5e62347b',5,'Botble\\Menu\\Models\\MenuLocation'),(23,'id','49a02df9d15c6e97d160bde2339a2c47',17,'Botble\\Menu\\Models\\Menu'),(24,'id','4acd30e72d7e6eea7ba3a8816f54adaf',18,'Botble\\Menu\\Models\\Menu'),(25,'id','950fbed8c661e1d27641f10e1ff095f3',19,'Botble\\Menu\\Models\\Menu'),(26,'id','79e6a17eda7c073021b2719127c7ca75',20,'Botble\\Menu\\Models\\Menu'),(27,'tr','96a44ca509567b48f00a007b5e62347b',6,'Botble\\Menu\\Models\\MenuLocation'),(28,'tr','49a02df9d15c6e97d160bde2339a2c47',21,'Botble\\Menu\\Models\\Menu'),(29,'tr','4acd30e72d7e6eea7ba3a8816f54adaf',22,'Botble\\Menu\\Models\\Menu'),(30,'tr','950fbed8c661e1d27641f10e1ff095f3',23,'Botble\\Menu\\Models\\Menu'),(31,'tr','79e6a17eda7c073021b2719127c7ca75',24,'Botble\\Menu\\Models\\Menu'),(32,'ar','5a932373f864d0c544a7d3fd27bd8e0d',2,'Botble\\SimpleSlider\\Models\\SimpleSlider'),(33,'vi','5a932373f864d0c544a7d3fd27bd8e0d',3,'Botble\\SimpleSlider\\Models\\SimpleSlider'),(34,'fr','5a932373f864d0c544a7d3fd27bd8e0d',4,'Botble\\SimpleSlider\\Models\\SimpleSlider'),(35,'id','5a932373f864d0c544a7d3fd27bd8e0d',5,'Botble\\SimpleSlider\\Models\\SimpleSlider'),(36,'tr','5a932373f864d0c544a7d3fd27bd8e0d',6,'Botble\\SimpleSlider\\Models\\SimpleSlider');
/*!40000 ALTER TABLE `language_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `lang_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `lang_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang_locale` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang_flag` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang_is_default` tinyint unsigned NOT NULL DEFAULT '0',
  `lang_order` int NOT NULL DEFAULT '0',
  `lang_is_rtl` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`lang_id`),
  KEY `lang_locale_index` (`lang_locale`),
  KEY `lang_code_index` (`lang_code`),
  KEY `lang_is_default_index` (`lang_is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'English','en','en_US','us',1,0,0),(2,'Arabic','ar','ar','sa',0,1,1),(3,'Tiếng Việt','vi','vi','vn',0,2,0),(4,'Français','fr','fr','fr',0,3,0),(5,'Bahasa Indonesia','id','id','id',0,4,0),(6,'Türkçe','tr','tr','tr',0,5,0);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_files`
--

DROP TABLE IF EXISTS `media_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_files` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` bigint unsigned NOT NULL DEFAULT '0',
  `mime_type` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `visibility` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  PRIMARY KEY (`id`),
  KEY `media_files_user_id_index` (`user_id`),
  KEY `media_files_index` (`folder_id`,`user_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_files`
--

LOCK TABLES `media_files` WRITE;
/*!40000 ALTER TABLE `media_files` DISABLE KEYS */;
INSERT INTO `media_files` VALUES (1,0,'1','1',1,'image/jpeg',1613,'brands/1.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(2,0,'2','2',1,'image/jpeg',1613,'brands/2.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(3,0,'3','3',1,'image/jpeg',1613,'brands/3.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(4,0,'4','4',1,'image/jpeg',1613,'brands/4.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(5,0,'5','5',1,'image/jpeg',1613,'brands/5.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(6,0,'6','6',1,'image/jpeg',1613,'brands/6.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(7,0,'7','7',1,'image/jpeg',1613,'brands/7.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(8,0,'1','1',2,'image/jpeg',9803,'product-categories/1.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(9,0,'2','2',2,'image/jpeg',9803,'product-categories/2.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(10,0,'3','3',2,'image/jpeg',9803,'product-categories/3.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(11,0,'4','4',2,'image/jpeg',9803,'product-categories/4.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(12,0,'5','5',2,'image/jpeg',9803,'product-categories/5.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(13,0,'6','6',2,'image/jpeg',9803,'product-categories/6.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(14,0,'7','7',2,'image/jpeg',9803,'product-categories/7.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(15,0,'8','8',2,'image/jpeg',9803,'product-categories/8.jpg','[]','2026-02-28 08:15:11','2026-02-28 08:15:11',NULL,'public'),(16,0,'1-1','1-1',3,'image/jpeg',9803,'products/1-1.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(17,0,'1-2','1-2',3,'image/jpeg',9803,'products/1-2.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(18,0,'1-3','1-3',3,'image/jpeg',9803,'products/1-3.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(19,0,'1-4','1-4',3,'image/jpeg',9803,'products/1-4.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(20,0,'10-1','10-1',3,'image/jpeg',9803,'products/10-1.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(21,0,'10-2','10-2',3,'image/jpeg',9803,'products/10-2.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(22,0,'10-3','10-3',3,'image/jpeg',9803,'products/10-3.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(23,0,'10-4','10-4',3,'image/jpeg',9803,'products/10-4.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(24,0,'11-1','11-1',3,'image/jpeg',9803,'products/11-1.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(25,0,'11-2','11-2',3,'image/jpeg',9803,'products/11-2.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(26,0,'11-3','11-3',3,'image/jpeg',9803,'products/11-3.jpg','[]','2026-02-28 08:15:12','2026-02-28 08:15:12',NULL,'public'),(27,0,'11-4','11-4',3,'image/jpeg',9803,'products/11-4.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(28,0,'12-1','12-1',3,'image/jpeg',9803,'products/12-1.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(29,0,'12-2','12-2',3,'image/jpeg',9803,'products/12-2.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(30,0,'12-3','12-3',3,'image/jpeg',9803,'products/12-3.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(31,0,'12-4','12-4',3,'image/jpeg',9803,'products/12-4.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(32,0,'13-1','13-1',3,'image/jpeg',9803,'products/13-1.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(33,0,'13-2','13-2',3,'image/jpeg',9803,'products/13-2.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(34,0,'13-3','13-3',3,'image/jpeg',9803,'products/13-3.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(35,0,'13-4','13-4',3,'image/jpeg',9803,'products/13-4.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(36,0,'14-1','14-1',3,'image/jpeg',9803,'products/14-1.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(37,0,'14-2','14-2',3,'image/jpeg',9803,'products/14-2.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(38,0,'14-3','14-3',3,'image/jpeg',9803,'products/14-3.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(39,0,'14-4','14-4',3,'image/jpeg',9803,'products/14-4.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(40,0,'15-1','15-1',3,'image/jpeg',9803,'products/15-1.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(41,0,'15-2','15-2',3,'image/jpeg',9803,'products/15-2.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(42,0,'15-3','15-3',3,'image/jpeg',9803,'products/15-3.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(43,0,'15-4','15-4',3,'image/jpeg',9803,'products/15-4.jpg','[]','2026-02-28 08:15:13','2026-02-28 08:15:13',NULL,'public'),(44,0,'16-1','16-1',3,'image/jpeg',9803,'products/16-1.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(45,0,'16-2','16-2',3,'image/jpeg',9803,'products/16-2.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(46,0,'16-3','16-3',3,'image/jpeg',9803,'products/16-3.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(47,0,'16-4','16-4',3,'image/jpeg',9803,'products/16-4.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(48,0,'17-1','17-1',3,'image/jpeg',9803,'products/17-1.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(49,0,'17-2','17-2',3,'image/jpeg',9803,'products/17-2.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(50,0,'17-3','17-3',3,'image/jpeg',9803,'products/17-3.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(51,0,'17-4','17-4',3,'image/jpeg',9803,'products/17-4.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(52,0,'17-5','17-5',3,'image/jpeg',9803,'products/17-5.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(53,0,'18-1','18-1',3,'image/jpeg',9803,'products/18-1.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(54,0,'18-2','18-2',3,'image/jpeg',9803,'products/18-2.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(55,0,'18-3','18-3',3,'image/jpeg',9803,'products/18-3.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(56,0,'18-4','18-4',3,'image/jpeg',9803,'products/18-4.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(57,0,'19-1','19-1',3,'image/jpeg',9803,'products/19-1.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(58,0,'19-2','19-2',3,'image/jpeg',9803,'products/19-2.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(59,0,'19-3','19-3',3,'image/jpeg',9803,'products/19-3.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(60,0,'19-4','19-4',3,'image/jpeg',9803,'products/19-4.jpg','[]','2026-02-28 08:15:14','2026-02-28 08:15:14',NULL,'public'),(61,0,'2-1','2-1',3,'image/jpeg',9803,'products/2-1.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(62,0,'2-2','2-2',3,'image/jpeg',9803,'products/2-2.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(63,0,'2-3','2-3',3,'image/jpeg',9803,'products/2-3.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(64,0,'2-4','2-4',3,'image/jpeg',9803,'products/2-4.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(65,0,'20-1','20-1',3,'image/jpeg',9803,'products/20-1.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(66,0,'20-2','20-2',3,'image/jpeg',9803,'products/20-2.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(67,0,'20-3','20-3',3,'image/jpeg',9803,'products/20-3.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(68,0,'20-4','20-4',3,'image/jpeg',9803,'products/20-4.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(69,0,'21-1','21-1',3,'image/jpeg',9803,'products/21-1.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(70,0,'21-2','21-2',3,'image/jpeg',9803,'products/21-2.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(71,0,'21-3','21-3',3,'image/jpeg',9803,'products/21-3.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(72,0,'21-4','21-4',3,'image/jpeg',9803,'products/21-4.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(73,0,'22-1','22-1',3,'image/jpeg',9803,'products/22-1.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(74,0,'22-2','22-2',3,'image/jpeg',9803,'products/22-2.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(75,0,'22-3','22-3',3,'image/jpeg',9803,'products/22-3.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(76,0,'22-4','22-4',3,'image/jpeg',9803,'products/22-4.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(77,0,'23-1','23-1',3,'image/jpeg',9803,'products/23-1.jpg','[]','2026-02-28 08:15:15','2026-02-28 08:15:15',NULL,'public'),(78,0,'23-2','23-2',3,'image/jpeg',9803,'products/23-2.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(79,0,'23-3','23-3',3,'image/jpeg',9803,'products/23-3.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(80,0,'23-4','23-4',3,'image/jpeg',9803,'products/23-4.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(81,0,'24-1','24-1',3,'image/jpeg',9803,'products/24-1.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(82,0,'24-2','24-2',3,'image/jpeg',9803,'products/24-2.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(83,0,'24-3','24-3',3,'image/jpeg',9803,'products/24-3.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(84,0,'24-4','24-4',3,'image/jpeg',9803,'products/24-4.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(85,0,'25-1','25-1',3,'image/jpeg',9803,'products/25-1.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(86,0,'25-2','25-2',3,'image/jpeg',9803,'products/25-2.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(87,0,'25-3','25-3',3,'image/jpeg',9803,'products/25-3.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(88,0,'25-4','25-4',3,'image/jpeg',9803,'products/25-4.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(89,0,'26-1','26-1',3,'image/jpeg',9803,'products/26-1.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(90,0,'26-2','26-2',3,'image/jpeg',9803,'products/26-2.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(91,0,'26-3','26-3',3,'image/jpeg',9803,'products/26-3.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(92,0,'26-4','26-4',3,'image/jpeg',9803,'products/26-4.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(93,0,'27-1','27-1',3,'image/jpeg',9803,'products/27-1.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(94,0,'27-2','27-2',3,'image/jpeg',9803,'products/27-2.jpg','[]','2026-02-28 08:15:16','2026-02-28 08:15:16',NULL,'public'),(95,0,'27-3','27-3',3,'image/jpeg',9803,'products/27-3.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(96,0,'27-4','27-4',3,'image/jpeg',9803,'products/27-4.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(97,0,'28-1','28-1',3,'image/jpeg',9803,'products/28-1.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(98,0,'28-2','28-2',3,'image/jpeg',9803,'products/28-2.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(99,0,'28-3','28-3',3,'image/jpeg',9803,'products/28-3.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(100,0,'28-4','28-4',3,'image/jpeg',9803,'products/28-4.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(101,0,'29-1','29-1',3,'image/jpeg',9803,'products/29-1.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(102,0,'29-2','29-2',3,'image/jpeg',9803,'products/29-2.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(103,0,'29-3','29-3',3,'image/jpeg',9803,'products/29-3.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(104,0,'3-1','3-1',3,'image/jpeg',9803,'products/3-1.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(105,0,'3-2','3-2',3,'image/jpeg',9803,'products/3-2.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(106,0,'3-3','3-3',3,'image/jpeg',9803,'products/3-3.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(107,0,'3-4','3-4',3,'image/jpeg',9803,'products/3-4.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(108,0,'30-1','30-1',3,'image/jpeg',9803,'products/30-1.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(109,0,'30-2','30-2',3,'image/jpeg',9803,'products/30-2.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(110,0,'30-3','30-3',3,'image/jpeg',9803,'products/30-3.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(111,0,'30-4','30-4',3,'image/jpeg',9803,'products/30-4.jpg','[]','2026-02-28 08:15:17','2026-02-28 08:15:17',NULL,'public'),(112,0,'31-1','31-1',3,'image/jpeg',9803,'products/31-1.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(113,0,'31-2','31-2',3,'image/jpeg',9803,'products/31-2.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(114,0,'31-3','31-3',3,'image/jpeg',9803,'products/31-3.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(115,0,'31-4','31-4',3,'image/jpeg',9803,'products/31-4.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(116,0,'32-1','32-1',3,'image/jpeg',9803,'products/32-1.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(117,0,'32-2','32-2',3,'image/jpeg',9803,'products/32-2.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(118,0,'32-3','32-3',3,'image/jpeg',9803,'products/32-3.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(119,0,'32-4','32-4',3,'image/jpeg',9803,'products/32-4.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(120,0,'33-1','33-1',3,'image/jpeg',9803,'products/33-1.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(121,0,'33-2','33-2',3,'image/jpeg',9803,'products/33-2.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(122,0,'33-3','33-3',3,'image/jpeg',9803,'products/33-3.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(123,0,'33-4','33-4',3,'image/jpeg',9803,'products/33-4.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(124,0,'34-1','34-1',3,'image/jpeg',9803,'products/34-1.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(125,0,'34-2','34-2',3,'image/jpeg',9803,'products/34-2.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(126,0,'34-3','34-3',3,'image/jpeg',9803,'products/34-3.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(127,0,'34-4','34-4',3,'image/jpeg',9803,'products/34-4.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(128,0,'35-1','35-1',3,'image/jpeg',9803,'products/35-1.jpg','[]','2026-02-28 08:15:18','2026-02-28 08:15:18',NULL,'public'),(129,0,'35-2','35-2',3,'image/jpeg',9803,'products/35-2.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(130,0,'35-3','35-3',3,'image/jpeg',9803,'products/35-3.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(131,0,'35-4','35-4',3,'image/jpeg',9803,'products/35-4.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(132,0,'36-1','36-1',3,'image/jpeg',9803,'products/36-1.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(133,0,'36-2','36-2',3,'image/jpeg',9803,'products/36-2.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(134,0,'36-3','36-3',3,'image/jpeg',9803,'products/36-3.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(135,0,'37-1','37-1',3,'image/jpeg',9803,'products/37-1.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(136,0,'37-2','37-2',3,'image/jpeg',9803,'products/37-2.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(137,0,'37-3','37-3',3,'image/jpeg',9803,'products/37-3.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(138,0,'38-1','38-1',3,'image/jpeg',9803,'products/38-1.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(139,0,'38-2','38-2',3,'image/jpeg',9803,'products/38-2.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(140,0,'38-3','38-3',3,'image/jpeg',9803,'products/38-3.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(141,0,'38-4','38-4',3,'image/jpeg',9803,'products/38-4.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(142,0,'39-1','39-1',3,'image/jpeg',9803,'products/39-1.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(143,0,'39-2','39-2',3,'image/jpeg',9803,'products/39-2.jpg','[]','2026-02-28 08:15:19','2026-02-28 08:15:19',NULL,'public'),(144,0,'39-3','39-3',3,'image/jpeg',9803,'products/39-3.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(145,0,'39-4','39-4',3,'image/jpeg',9803,'products/39-4.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(146,0,'4-1','4-1',3,'image/jpeg',9803,'products/4-1.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(147,0,'4-2','4-2',3,'image/jpeg',9803,'products/4-2.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(148,0,'4-3','4-3',3,'image/jpeg',9803,'products/4-3.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(149,0,'4-4','4-4',3,'image/jpeg',9803,'products/4-4.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(150,0,'40-1','40-1',3,'image/jpeg',9803,'products/40-1.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(151,0,'40-2','40-2',3,'image/jpeg',9803,'products/40-2.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(152,0,'40-3','40-3',3,'image/jpeg',9803,'products/40-3.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(153,0,'40-4','40-4',3,'image/jpeg',9803,'products/40-4.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(154,0,'41-1','41-1',3,'image/jpeg',9803,'products/41-1.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(155,0,'41-2','41-2',3,'image/jpeg',9803,'products/41-2.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(156,0,'41-3','41-3',3,'image/jpeg',9803,'products/41-3.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(157,0,'41-4','41-4',3,'image/jpeg',9803,'products/41-4.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(158,0,'42-1','42-1',3,'image/jpeg',9803,'products/42-1.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(159,0,'42-2','42-2',3,'image/jpeg',9803,'products/42-2.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(160,0,'42-3','42-3',3,'image/jpeg',9803,'products/42-3.jpg','[]','2026-02-28 08:15:20','2026-02-28 08:15:20',NULL,'public'),(161,0,'43-1','43-1',3,'image/jpeg',9803,'products/43-1.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(162,0,'43-2','43-2',3,'image/jpeg',9803,'products/43-2.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(163,0,'43-3','43-3',3,'image/jpeg',9803,'products/43-3.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(164,0,'44-1','44-1',3,'image/jpeg',9803,'products/44-1.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(165,0,'44-2','44-2',3,'image/jpeg',9803,'products/44-2.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(166,0,'44-3','44-3',3,'image/jpeg',9803,'products/44-3.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(167,0,'45-1','45-1',3,'image/jpeg',9803,'products/45-1.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(168,0,'45-2','45-2',3,'image/jpeg',9803,'products/45-2.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(169,0,'45-3','45-3',3,'image/jpeg',9803,'products/45-3.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(170,0,'45-4','45-4',3,'image/jpeg',9803,'products/45-4.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(171,0,'46-1','46-1',3,'image/jpeg',9803,'products/46-1.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(172,0,'46-2','46-2',3,'image/jpeg',9803,'products/46-2.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(173,0,'46-3','46-3',3,'image/jpeg',9803,'products/46-3.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(174,0,'46-4','46-4',3,'image/jpeg',9803,'products/46-4.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(175,0,'47-1','47-1',3,'image/jpeg',9803,'products/47-1.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(176,0,'47-2','47-2',3,'image/jpeg',9803,'products/47-2.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(177,0,'47-3','47-3',3,'image/jpeg',9803,'products/47-3.jpg','[]','2026-02-28 08:15:21','2026-02-28 08:15:21',NULL,'public'),(178,0,'48-1','48-1',3,'image/jpeg',9803,'products/48-1.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(179,0,'48-2','48-2',3,'image/jpeg',9803,'products/48-2.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(180,0,'48-3','48-3',3,'image/jpeg',9803,'products/48-3.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(181,0,'48-4','48-4',3,'image/jpeg',9803,'products/48-4.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(182,0,'49-1','49-1',3,'image/jpeg',9803,'products/49-1.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(183,0,'49-2','49-2',3,'image/jpeg',9803,'products/49-2.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(184,0,'49-3','49-3',3,'image/jpeg',9803,'products/49-3.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(185,0,'49-4','49-4',3,'image/jpeg',9803,'products/49-4.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(186,0,'5-1','5-1',3,'image/jpeg',9803,'products/5-1.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(187,0,'5-2','5-2',3,'image/jpeg',9803,'products/5-2.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(188,0,'5-3','5-3',3,'image/jpeg',9803,'products/5-3.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(189,0,'5-4','5-4',3,'image/jpeg',9803,'products/5-4.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(190,0,'50-1','50-1',3,'image/jpeg',9803,'products/50-1.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(191,0,'50-2','50-2',3,'image/jpeg',9803,'products/50-2.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(192,0,'50-3','50-3',3,'image/jpeg',9803,'products/50-3.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(193,0,'50-4','50-4',3,'image/jpeg',9803,'products/50-4.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(194,0,'51-1','51-1',3,'image/jpeg',9803,'products/51-1.jpg','[]','2026-02-28 08:15:22','2026-02-28 08:15:22',NULL,'public'),(195,0,'51-2','51-2',3,'image/jpeg',9803,'products/51-2.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(196,0,'51-3','51-3',3,'image/jpeg',9803,'products/51-3.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(197,0,'51-4','51-4',3,'image/jpeg',9803,'products/51-4.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(198,0,'52-1','52-1',3,'image/jpeg',9803,'products/52-1.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(199,0,'52-2','52-2',3,'image/jpeg',9803,'products/52-2.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(200,0,'52-3','52-3',3,'image/jpeg',9803,'products/52-3.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(201,0,'53-1','53-1',3,'image/jpeg',9803,'products/53-1.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(202,0,'53-2','53-2',3,'image/jpeg',9803,'products/53-2.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(203,0,'53-3','53-3',3,'image/jpeg',9803,'products/53-3.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(204,0,'53-4','53-4',3,'image/jpeg',9803,'products/53-4.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(205,0,'54-1','54-1',3,'image/jpeg',9803,'products/54-1.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(206,0,'54-2','54-2',3,'image/jpeg',9803,'products/54-2.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(207,0,'54-3','54-3',3,'image/jpeg',9803,'products/54-3.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(208,0,'6-1','6-1',3,'image/jpeg',9803,'products/6-1.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(209,0,'6-2','6-2',3,'image/jpeg',9803,'products/6-2.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(210,0,'6-3','6-3',3,'image/jpeg',9803,'products/6-3.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(211,0,'6-4','6-4',3,'image/jpeg',9803,'products/6-4.jpg','[]','2026-02-28 08:15:23','2026-02-28 08:15:23',NULL,'public'),(212,0,'7-1','7-1',3,'image/jpeg',9803,'products/7-1.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(213,0,'7-2','7-2',3,'image/jpeg',9803,'products/7-2.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(214,0,'7-3','7-3',3,'image/jpeg',9803,'products/7-3.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(215,0,'8-1','8-1',3,'image/jpeg',9803,'products/8-1.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(216,0,'8-2','8-2',3,'image/jpeg',9803,'products/8-2.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(217,0,'8-3','8-3',3,'image/jpeg',9803,'products/8-3.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(218,0,'8-4','8-4',3,'image/jpeg',9803,'products/8-4.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(219,0,'9-1','9-1',3,'image/jpeg',9803,'products/9-1.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(220,0,'9-2','9-2',3,'image/jpeg',9803,'products/9-2.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(221,0,'9-3','9-3',3,'image/jpeg',9803,'products/9-3.jpg','[]','2026-02-28 08:15:24','2026-02-28 08:15:24',NULL,'public'),(222,0,'1','1',4,'image/jpeg',9803,'customers/1.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(223,0,'10','10',4,'image/jpeg',9803,'customers/10.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(224,0,'2','2',4,'image/jpeg',9803,'customers/2.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(225,0,'3','3',4,'image/jpeg',9803,'customers/3.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(226,0,'4','4',4,'image/jpeg',9803,'customers/4.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(227,0,'5','5',4,'image/jpeg',9803,'customers/5.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(228,0,'6','6',4,'image/jpeg',9803,'customers/6.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(229,0,'7','7',4,'image/jpeg',9803,'customers/7.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(230,0,'8','8',4,'image/jpeg',9803,'customers/8.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(231,0,'9','9',4,'image/jpeg',9803,'customers/9.jpg','[]','2026-02-28 08:15:30','2026-02-28 08:15:30',NULL,'public'),(232,0,'1','1',5,'image/jpeg',9803,'news/1.jpg','[]','2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,'public'),(233,0,'10','10',5,'image/jpeg',9803,'news/10.jpg','[]','2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,'public'),(234,0,'11','11',5,'image/jpeg',9803,'news/11.jpg','[]','2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,'public'),(235,0,'2','2',5,'image/jpeg',9803,'news/2.jpg','[]','2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,'public'),(236,0,'3','3',5,'image/jpeg',9803,'news/3.jpg','[]','2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,'public'),(237,0,'4','4',5,'image/jpeg',9803,'news/4.jpg','[]','2026-02-28 08:15:35','2026-02-28 08:15:35',NULL,'public'),(238,0,'5','5',5,'image/jpeg',9803,'news/5.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(239,0,'6','6',5,'image/jpeg',9803,'news/6.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(240,0,'7','7',5,'image/jpeg',9803,'news/7.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(241,0,'8','8',5,'image/jpeg',9803,'news/8.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(242,0,'9','9',5,'image/jpeg',9803,'news/9.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(243,0,'1-lg','1-lg',6,'image/jpeg',8828,'sliders/1-lg.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(244,0,'1-md','1-md',6,'image/jpeg',8828,'sliders/1-md.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(245,0,'1-sm','1-sm',6,'image/jpeg',8828,'sliders/1-sm.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(246,0,'2-lg','2-lg',6,'image/jpeg',8828,'sliders/2-lg.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(247,0,'2-md','2-md',6,'image/jpeg',8828,'sliders/2-md.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(248,0,'2-sm','2-sm',6,'image/jpeg',8828,'sliders/2-sm.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(249,0,'3-lg','3-lg',6,'image/jpeg',8828,'sliders/3-lg.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(250,0,'3-md','3-md',6,'image/jpeg',8828,'sliders/3-md.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(251,0,'3-sm','3-sm',6,'image/jpeg',8828,'sliders/3-sm.jpg','[]','2026-02-28 08:15:36','2026-02-28 08:15:36',NULL,'public'),(252,0,'1','1',7,'image/jpeg',3613,'promotion/1.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(253,0,'2','2',7,'image/jpeg',3613,'promotion/2.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(254,0,'3','3',7,'image/jpeg',5391,'promotion/3.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(255,0,'4','4',7,'image/jpeg',5391,'promotion/4.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(256,0,'5','5',7,'image/jpeg',5391,'promotion/5.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(257,0,'6','6',7,'image/jpeg',5391,'promotion/6.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(258,0,'7','7',7,'image/jpeg',5391,'promotion/7.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(259,0,'8','8',7,'image/jpeg',5391,'promotion/8.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(260,0,'9','9',7,'image/jpeg',5391,'promotion/9.jpg','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(261,0,'cod','cod',8,'image/png',12121,'payments/cod.png','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(262,0,'bank-transfer','bank-transfer',8,'image/png',29089,'payments/bank-transfer.png','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(263,0,'stripe','stripe',8,'image/webp',7516,'payments/stripe.webp','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(264,0,'paypal','paypal',8,'image/png',3001,'payments/paypal.png','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(265,0,'mollie','mollie',8,'image/png',8968,'payments/mollie.png','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(266,0,'paystack','paystack',8,'image/png',31015,'payments/paystack.png','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(267,0,'razorpay','razorpay',8,'image/png',8489,'payments/razorpay.png','[]','2026-02-28 08:15:37','2026-02-28 08:15:37',NULL,'public'),(268,0,'sslcommerz','sslcommerz',8,'image/png',3482,'payments/sslcommerz.png','[]','2026-02-28 08:15:38','2026-02-28 08:15:38',NULL,'public'),(269,0,'app','app',9,'image/png',8667,'general/app.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(270,0,'coming-soon','coming-soon',9,'image/jpeg',22253,'general/coming-soon.jpg','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(271,0,'favicon','favicon',9,'image/png',5047,'general/favicon.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(272,0,'logo-dark','logo-dark',9,'image/png',1562,'general/logo-dark.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(273,0,'logo-light','logo-light',9,'image/png',1529,'general/logo-light.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(274,0,'logo','logo',9,'image/png',1441,'general/logo.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(275,0,'newsletter','newsletter',9,'image/jpeg',9778,'general/newsletter.jpg','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(276,0,'payment-method-1','payment-method-1',9,'image/jpeg',1128,'general/payment-method-1.jpg','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(277,0,'payment-method-2','payment-method-2',9,'image/jpeg',1184,'general/payment-method-2.jpg','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(278,0,'payment-method-3','payment-method-3',9,'image/jpeg',1109,'general/payment-method-3.jpg','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(279,0,'payment-method-4','payment-method-4',9,'image/jpeg',944,'general/payment-method-4.jpg','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(280,0,'payment-method-5','payment-method-5',9,'image/jpeg',964,'general/payment-method-5.jpg','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(281,0,'placeholder','placeholder',9,'image/png',12344,'general/placeholder.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(282,0,'1','1',10,'image/png',9022,'stores/1.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(283,0,'10','10',10,'image/png',4384,'stores/10.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(284,0,'11','11',10,'image/png',4706,'stores/11.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(285,0,'12','12',10,'image/png',5075,'stores/12.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(286,0,'13','13',10,'image/png',3700,'stores/13.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(287,0,'14','14',10,'image/png',4239,'stores/14.png','[]','2026-02-28 08:15:40','2026-02-28 08:15:40',NULL,'public'),(288,0,'15','15',10,'image/png',5304,'stores/15.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(289,0,'16','16',10,'image/png',4796,'stores/16.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(290,0,'17','17',10,'image/png',4919,'stores/17.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(291,0,'2','2',10,'image/png',8598,'stores/2.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(292,0,'3','3',10,'image/png',7888,'stores/3.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(293,0,'4','4',10,'image/png',8393,'stores/4.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(294,0,'5','5',10,'image/png',10159,'stores/5.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(295,0,'6','6',10,'image/png',10312,'stores/6.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(296,0,'7','7',10,'image/png',3764,'stores/7.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(297,0,'8','8',10,'image/png',4237,'stores/8.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public'),(298,0,'9','9',10,'image/png',4096,'stores/9.png','[]','2026-02-28 08:15:41','2026-02-28 08:15:41',NULL,'public');
/*!40000 ALTER TABLE `media_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_folders`
--

DROP TABLE IF EXISTS `media_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_folders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_folders_user_id_index` (`user_id`),
  KEY `media_folders_index` (`parent_id`,`user_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_folders`
--

LOCK TABLES `media_folders` WRITE;
/*!40000 ALTER TABLE `media_folders` DISABLE KEYS */;
INSERT INTO `media_folders` VALUES (1,0,'brands',NULL,'brands',0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL),(2,0,'product-categories',NULL,'product-categories',0,'2026-02-28 08:15:11','2026-02-28 08:15:11',NULL),(3,0,'products',NULL,'products',0,'2026-02-28 08:15:12','2026-02-28 08:15:12',NULL),(4,0,'customers',NULL,'customers',0,'2026-02-28 08:15:30','2026-02-28 08:15:30',NULL),(5,0,'news',NULL,'news',0,'2026-02-28 08:15:35','2026-02-28 08:15:35',NULL),(6,0,'sliders',NULL,'sliders',0,'2026-02-28 08:15:36','2026-02-28 08:15:36',NULL),(7,0,'promotion',NULL,'promotion',0,'2026-02-28 08:15:37','2026-02-28 08:15:37',NULL),(8,0,'payments',NULL,'payments',0,'2026-02-28 08:15:37','2026-02-28 08:15:37',NULL),(9,0,'general',NULL,'general',0,'2026-02-28 08:15:40','2026-02-28 08:15:40',NULL),(10,0,'stores',NULL,'stores',0,'2026-02-28 08:15:40','2026-02-28 08:15:40',NULL);
/*!40000 ALTER TABLE `media_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_settings`
--

DROP TABLE IF EXISTS `media_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `media_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_settings`
--

LOCK TABLES `media_settings` WRITE;
/*!40000 ALTER TABLE `media_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_locations`
--

DROP TABLE IF EXISTS `menu_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_locations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint unsigned NOT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_locations_menu_id_created_at_index` (`menu_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_locations`
--

LOCK TABLES `menu_locations` WRITE;
/*!40000 ALTER TABLE `menu_locations` DISABLE KEYS */;
INSERT INTO `menu_locations` VALUES (1,1,'main-menu','2026-02-28 08:15:40','2026-02-28 08:15:40'),(2,5,'main-menu','2026-02-28 08:15:45','2026-02-28 08:15:45'),(3,9,'main-menu','2026-02-28 08:15:45','2026-02-28 08:15:45'),(4,13,'main-menu','2026-02-28 08:15:45','2026-02-28 08:15:45'),(5,17,'main-menu','2026-02-28 08:15:45','2026-02-28 08:15:45'),(6,21,'main-menu','2026-02-28 08:15:45','2026-02-28 08:15:45');
/*!40000 ALTER TABLE `menu_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_nodes`
--

DROP TABLE IF EXISTS `menu_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_nodes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint unsigned NOT NULL,
  `parent_id` bigint unsigned NOT NULL DEFAULT '0',
  `reference_id` bigint unsigned DEFAULT NULL,
  `reference_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_font` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` tinyint unsigned NOT NULL DEFAULT '0',
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `css_class` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `has_child` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_nodes_menu_id_index` (`menu_id`),
  KEY `menu_nodes_parent_id_index` (`parent_id`),
  KEY `reference_id` (`reference_id`),
  KEY `reference_type` (`reference_type`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_nodes`
--

LOCK TABLES `menu_nodes` WRITE;
/*!40000 ALTER TABLE `menu_nodes` DISABLE KEYS */;
INSERT INTO `menu_nodes` VALUES (1,1,0,NULL,NULL,'/',NULL,0,'Home',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(2,1,0,NULL,NULL,'#',NULL,1,'Pages',NULL,'_self',1,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(3,1,2,2,'Botble\\Page\\Models\\Page','/about-us',NULL,0,'About us',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(4,1,2,3,'Botble\\Page\\Models\\Page','/terms-of-use',NULL,1,'Terms Of Use',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(5,1,2,4,'Botble\\Page\\Models\\Page','/terms-conditions',NULL,2,'Terms & Conditions',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(6,1,2,5,'Botble\\Page\\Models\\Page','/refund-policy',NULL,3,'Refund Policy',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(7,1,2,12,'Botble\\Page\\Models\\Page','/coming-soon',NULL,4,'Coming soon',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(8,1,0,NULL,NULL,'/products',NULL,2,'Products',NULL,'_self',1,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(9,1,8,NULL,NULL,'/products',NULL,0,'All products',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(10,1,8,15,'Botble\\Ecommerce\\Models\\ProductCategory',NULL,NULL,1,'Products Of Category',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(11,1,8,NULL,NULL,'/products/headphone-ultra-bass',NULL,2,'Product Single',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(12,1,0,NULL,NULL,'/stores',NULL,3,'Stores',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(13,1,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Blog',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(14,1,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,5,'FAQs',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(15,1,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,6,'Contact',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(16,2,0,3,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Terms Of Use',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(17,2,0,4,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Terms & Conditions',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(18,2,0,5,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Refund Policy',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(19,2,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,3,'FAQs',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(20,2,0,NULL,NULL,'/nothing',NULL,4,'404 Page',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(21,3,0,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'About us',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(22,3,0,10,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Affiliate',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(23,3,0,11,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Career',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(24,3,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Contact us',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(25,4,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Our blog',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(26,4,0,NULL,NULL,'/cart',NULL,1,'Cart',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(27,4,0,NULL,NULL,'/customer/overview',NULL,2,'My account',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(28,4,0,NULL,NULL,'/products',NULL,3,'Shop',NULL,'_self',0,'2026-02-28 08:15:40','2026-02-28 08:15:40'),(29,5,0,NULL,NULL,'/',NULL,0,'الرئيسية',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(30,5,0,NULL,NULL,'#',NULL,1,'الصفحات',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(31,5,30,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'من نحن',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(32,5,30,3,'Botble\\Page\\Models\\Page',NULL,NULL,1,'شروط الاستخدام',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(33,5,30,4,'Botble\\Page\\Models\\Page',NULL,NULL,2,'الشروط والأحكام',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(34,5,30,5,'Botble\\Page\\Models\\Page',NULL,NULL,3,'سياسة الاسترجاع',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(35,5,30,12,'Botble\\Page\\Models\\Page',NULL,NULL,4,'قريباً',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(36,5,0,NULL,NULL,'/products',NULL,2,'المنتجات',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(37,5,36,NULL,NULL,'/products',NULL,0,'جميع المنتجات',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(38,5,36,15,'Botble\\Ecommerce\\Models\\ProductCategory',NULL,NULL,1,'منتجات الفئة',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(39,5,36,NULL,NULL,'/products/headphone-ultra-bass',NULL,2,'منتج واحد',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(40,5,0,NULL,NULL,'/stores',NULL,3,'المتاجر',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(41,5,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,4,'المدونة',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(42,5,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,5,'الأسئلة الشائعة',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(43,5,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,6,'اتصل بنا',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(44,6,0,3,'Botble\\Page\\Models\\Page',NULL,NULL,0,'شروط الاستخدام',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(45,6,0,4,'Botble\\Page\\Models\\Page',NULL,NULL,1,'الشروط والأحكام',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(46,6,0,5,'Botble\\Page\\Models\\Page',NULL,NULL,2,'سياسة الاسترجاع',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(47,6,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,3,'الأسئلة الشائعة',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(48,6,0,NULL,NULL,'/nothing',NULL,4,'صفحة 404',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(49,7,0,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'من نحن',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(50,7,0,10,'Botble\\Page\\Models\\Page',NULL,NULL,1,'الشركاء',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(51,7,0,11,'Botble\\Page\\Models\\Page',NULL,NULL,2,'الوظائف',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(52,7,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,3,'اتصل بنا',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(53,8,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,0,'مدونتنا',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(54,8,0,NULL,NULL,'/cart',NULL,1,'السلة',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(55,8,0,NULL,NULL,'/customer/overview',NULL,2,'حسابي',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(56,8,0,NULL,NULL,'/products',NULL,3,'المتجر',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(57,9,0,NULL,NULL,'/',NULL,0,'Trang chủ',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(58,9,0,NULL,NULL,'#',NULL,1,'Trang',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(59,9,58,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Về chúng tôi',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(60,9,58,3,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Điều khoản sử dụng',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(61,9,58,4,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Điều khoản và điều kiện',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(62,9,58,5,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Chính sách hoàn tiền',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(63,9,58,12,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Sắp ra mắt',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(64,9,0,NULL,NULL,'/products',NULL,2,'Sản phẩm',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(65,9,64,NULL,NULL,'/products',NULL,0,'Tất cả sản phẩm',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(66,9,64,15,'Botble\\Ecommerce\\Models\\ProductCategory',NULL,NULL,1,'Sản phẩm theo danh mục',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(67,9,64,NULL,NULL,'/products/headphone-ultra-bass',NULL,2,'Sản phẩm đơn',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(68,9,0,NULL,NULL,'/stores',NULL,3,'Cửa hàng',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(69,9,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Tin tức',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(70,9,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,5,'Hỏi đáp',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(71,9,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,6,'Liên hệ',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(72,10,0,3,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Điều khoản sử dụng',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(73,10,0,4,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Điều khoản và điều kiện',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(74,10,0,5,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Chính sách hoàn tiền',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(75,10,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Hỏi đáp',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(76,10,0,NULL,NULL,'/nothing',NULL,4,'Trang 404',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(77,11,0,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Về chúng tôi',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(78,11,0,10,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Đối tác',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(79,11,0,11,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Tuyển dụng',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(80,11,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Liên hệ chúng tôi',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(81,12,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Blog của chúng tôi',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(82,12,0,NULL,NULL,'/cart',NULL,1,'Giỏ hàng',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(83,12,0,NULL,NULL,'/customer/overview',NULL,2,'Tài khoản của tôi',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(84,12,0,NULL,NULL,'/products',NULL,3,'Cửa hàng',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(85,13,0,NULL,NULL,'/',NULL,0,'Accueil',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(86,13,0,NULL,NULL,'#',NULL,1,'Pages',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(87,13,86,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'À propos',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(88,13,86,3,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Conditions d\'utilisation',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(89,13,86,4,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Termes et conditions',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(90,13,86,5,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Politique de remboursement',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(91,13,86,12,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Bientôt disponible',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(92,13,0,NULL,NULL,'/products',NULL,2,'Produits',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(93,13,92,NULL,NULL,'/products',NULL,0,'Tous les produits',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(94,13,92,15,'Botble\\Ecommerce\\Models\\ProductCategory',NULL,NULL,1,'Produits de la catégorie',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(95,13,92,NULL,NULL,'/products/headphone-ultra-bass',NULL,2,'Produit unique',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(96,13,0,NULL,NULL,'/stores',NULL,3,'Boutiques',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(97,13,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Blog',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(98,13,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,5,'FAQ',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(99,13,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,6,'Contact',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(100,14,0,3,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Conditions d\'utilisation',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(101,14,0,4,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Termes et conditions',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(102,14,0,5,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Politique de remboursement',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(103,14,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,3,'FAQ',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(104,14,0,NULL,NULL,'/nothing',NULL,4,'Page 404',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(105,15,0,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'À propos',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(106,15,0,10,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Affilié',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(107,15,0,11,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Carrière',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(108,15,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Contactez-nous',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(109,16,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Notre blog',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(110,16,0,NULL,NULL,'/cart',NULL,1,'Panier',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(111,16,0,NULL,NULL,'/customer/overview',NULL,2,'Mon compte',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(112,16,0,NULL,NULL,'/products',NULL,3,'Boutique',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(113,17,0,NULL,NULL,'/',NULL,0,'Beranda',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(114,17,0,NULL,NULL,'#',NULL,1,'Halaman',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(115,17,114,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Tentang kami',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(116,17,114,3,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Syarat penggunaan',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(117,17,114,4,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Syarat dan ketentuan',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(118,17,114,5,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Kebijakan pengembalian dana',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(119,17,114,12,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Segera hadir',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(120,17,0,NULL,NULL,'/products',NULL,2,'Produk',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(121,17,120,NULL,NULL,'/products',NULL,0,'Semua produk',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(122,17,120,15,'Botble\\Ecommerce\\Models\\ProductCategory',NULL,NULL,1,'Produk berdasarkan kategori',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(123,17,120,NULL,NULL,'/products/headphone-ultra-bass',NULL,2,'Produk tunggal',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(124,17,0,NULL,NULL,'/stores',NULL,3,'Toko',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(125,17,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Blog',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(126,17,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,5,'FAQ',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(127,17,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,6,'Kontak',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(128,18,0,3,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Syarat penggunaan',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(129,18,0,4,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Syarat dan ketentuan',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(130,18,0,5,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Kebijakan pengembalian dana',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(131,18,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,3,'FAQ',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(132,18,0,NULL,NULL,'/nothing',NULL,4,'Halaman 404',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(133,19,0,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Tentang kami',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(134,19,0,10,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Afiliasi',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(135,19,0,11,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Karir',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(136,19,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Hubungi kami',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(137,20,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Blog kami',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(138,20,0,NULL,NULL,'/cart',NULL,1,'Keranjang',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(139,20,0,NULL,NULL,'/customer/overview',NULL,2,'Akun saya',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(140,20,0,NULL,NULL,'/products',NULL,3,'Toko',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(141,21,0,NULL,NULL,'/',NULL,0,'Ana Sayfa',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(142,21,0,NULL,NULL,'#',NULL,1,'Sayfalar',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(143,21,142,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Hakkımızda',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(144,21,142,3,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Kullanım Şartları',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(145,21,142,4,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Şartlar ve Koşullar',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(146,21,142,5,'Botble\\Page\\Models\\Page',NULL,NULL,3,'İade Politikası',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(147,21,142,12,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Yakında',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(148,21,0,NULL,NULL,'/products',NULL,2,'Ürünler',NULL,'_self',1,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(149,21,148,NULL,NULL,'/products',NULL,0,'Tüm ürünler',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(150,21,148,15,'Botble\\Ecommerce\\Models\\ProductCategory',NULL,NULL,1,'Kategoriye göre ürünler',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(151,21,148,NULL,NULL,'/products/headphone-ultra-bass',NULL,2,'Tekli ürün',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(152,21,0,NULL,NULL,'/stores',NULL,3,'Mağazalar',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(153,21,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,4,'Blog',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(154,21,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,5,'SSS',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(155,21,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,6,'İletişim',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(156,22,0,3,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Kullanım Şartları',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(157,22,0,4,'Botble\\Page\\Models\\Page',NULL,NULL,1,'Şartlar ve Koşullar',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(158,22,0,5,'Botble\\Page\\Models\\Page',NULL,NULL,2,'İade Politikası',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(159,22,0,7,'Botble\\Page\\Models\\Page',NULL,NULL,3,'SSS',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(160,22,0,NULL,NULL,'/nothing',NULL,4,'404 Sayfası',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(161,23,0,2,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Hakkımızda',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(162,23,0,10,'Botble\\Page\\Models\\Page',NULL,NULL,1,'İş Ortakları',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(163,23,0,11,'Botble\\Page\\Models\\Page',NULL,NULL,2,'Kariyer',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(164,23,0,8,'Botble\\Page\\Models\\Page',NULL,NULL,3,'Bize ulaşın',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(165,24,0,6,'Botble\\Page\\Models\\Page',NULL,NULL,0,'Blogumuz',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(166,24,0,NULL,NULL,'/cart',NULL,1,'Sepet',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(167,24,0,NULL,NULL,'/customer/overview',NULL,2,'Hesabım',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45'),(168,24,0,NULL,NULL,'/products',NULL,3,'Mağaza',NULL,'_self',0,'2026-02-28 08:15:45','2026-02-28 08:15:45');
/*!40000 ALTER TABLE `menu_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'Main menu','main-menu','published','2026-02-28 08:15:40','2026-02-28 08:15:40'),(2,'Quick links','quick-links','published','2026-02-28 08:15:40','2026-02-28 08:15:40'),(3,'Company','company','published','2026-02-28 08:15:40','2026-02-28 08:15:40'),(4,'Business','business','published','2026-02-28 08:15:40','2026-02-28 08:15:40'),(5,'القائمة الرئيسية','main-menu-ar','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(6,'روابط سريعة','quick-links-ar','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(7,'الشركة','company-ar','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(8,'الأعمال','business-ar','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(9,'Menu chính','main-menu-vi','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(10,'Liên kết nhanh','quick-links-vi','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(11,'Công ty','company-vi','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(12,'Kinh doanh','business-vi','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(13,'Menu principal','main-menu-fr','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(14,'Liens rapides','quick-links-fr','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(15,'Entreprise','company-fr','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(16,'Affaires','business-fr','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(17,'Menu utama','main-menu-id','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(18,'Tautan cepat','quick-links-id','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(19,'Perusahaan','company-id','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(20,'Bisnis','business-id','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(21,'Ana menü','main-menu-tr','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(22,'Hızlı bağlantılar','quick-links-tr','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(23,'Şirket','company-tr','published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(24,'İş','business-tr','published','2026-02-28 08:15:45','2026-02-28 08:15:45');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_boxes`
--

DROP TABLE IF EXISTS `meta_boxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meta_boxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `meta_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` text COLLATE utf8mb4_unicode_ci,
  `reference_id` bigint unsigned NOT NULL,
  `reference_type` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meta_boxes_reference_id_index` (`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_boxes`
--

LOCK TABLES `meta_boxes` WRITE;
/*!40000 ALTER TABLE `meta_boxes` DISABLE KEYS */;
INSERT INTO `meta_boxes` VALUES (1,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',1,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(2,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',2,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(3,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',3,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(4,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',4,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(5,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',5,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(6,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',6,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(7,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',7,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(8,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',8,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(9,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',9,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(10,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',10,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:24','2026-02-28 08:15:24'),(11,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',11,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(12,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',12,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(13,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',13,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(14,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',14,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(15,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',15,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(16,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',16,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(17,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',17,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(18,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',18,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(19,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',19,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(20,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',20,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(21,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',21,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(22,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',22,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(23,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',23,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(24,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',24,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(25,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',25,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(26,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',26,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(27,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',27,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(28,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',28,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(29,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',29,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(30,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',30,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(31,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',31,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(32,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',32,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(33,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',33,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(34,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',34,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:25','2026-02-28 08:15:25'),(35,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',35,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(36,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',36,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(37,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',37,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(38,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',38,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(39,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',39,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(40,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',40,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(41,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',41,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(42,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',42,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(43,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',43,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(44,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',44,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(45,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',45,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(46,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',46,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(47,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',47,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(48,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',48,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(49,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',49,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(50,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',50,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(51,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',51,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(52,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',52,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(53,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',53,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(54,'faq_schema_config','[[[{\"key\":\"question\",\"value\":\"What is the warranty period?\"},{\"key\":\"answer\",\"value\":\"This product comes with a 1-year manufacturer warranty covering defects in materials and workmanship.\"}],[{\"key\":\"question\",\"value\":\"Is this item compatible with Mac and Windows?\"},{\"key\":\"answer\",\"value\":\"Yes, this product is fully compatible with both macOS and Windows operating systems out of the box.\"}],[{\"key\":\"question\",\"value\":\"How long does the battery last?\"},{\"key\":\"answer\",\"value\":\"The battery life is approximately 10 hours on a full charge, depending on usage conditions.\"}],[{\"key\":\"question\",\"value\":\"Does it come with a carrying case?\"},{\"key\":\"answer\",\"value\":\"Yes, a protective carrying case is included in the box to keep your device safe during travel.\"}],[{\"key\":\"question\",\"value\":\"Can I return it if I don\'t like it?\"},{\"key\":\"answer\",\"value\":\"Absolutely! We offer a hassle-free 30-day return policy. If you are not satisfied, you can return it for a full refund.\"}]]]',54,'Botble\\Ecommerce\\Models\\Product','2026-02-28 08:15:26','2026-02-28 08:15:26'),(55,'tablet_image','[\"sliders\\/1-md.jpg\"]',1,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2026-02-28 08:15:37','2026-02-28 08:15:37'),(56,'mobile_image','[\"sliders\\/1-sm.jpg\"]',1,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2026-02-28 08:15:37','2026-02-28 08:15:37'),(57,'tablet_image','[\"sliders\\/2-md.jpg\"]',2,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2026-02-28 08:15:37','2026-02-28 08:15:37'),(58,'mobile_image','[\"sliders\\/2-sm.jpg\"]',2,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2026-02-28 08:15:37','2026-02-28 08:15:37'),(59,'tablet_image','[\"sliders\\/3-md.jpg\"]',3,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2026-02-28 08:15:37','2026-02-28 08:15:37'),(60,'mobile_image','[\"sliders\\/3-sm.jpg\"]',3,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2026-02-28 08:15:37','2026-02-28 08:15:37');
/*!40000 ALTER TABLE `meta_boxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000001_create_cache_table',1),(2,'2013_04_09_032329_create_base_tables',1),(3,'2013_04_09_062329_create_revisions_table',1),(4,'2014_10_12_000000_create_users_table',1),(5,'2014_10_12_100000_create_password_reset_tokens_table',1),(6,'2016_06_10_230148_create_acl_tables',1),(7,'2016_06_14_230857_create_menus_table',1),(8,'2016_06_28_221418_create_pages_table',1),(9,'2016_10_05_074239_create_setting_table',1),(10,'2016_11_28_032840_create_dashboard_widget_tables',1),(11,'2016_12_16_084601_create_widgets_table',1),(12,'2017_05_09_070343_create_media_tables',1),(13,'2017_11_03_070450_create_slug_table',1),(14,'2019_01_05_053554_create_jobs_table',1),(15,'2019_08_19_000000_create_failed_jobs_table',1),(16,'2019_12_14_000001_create_personal_access_tokens_table',1),(17,'2021_08_02_084121_fix_old_shortcode',1),(18,'2022_04_20_100851_add_index_to_media_table',1),(19,'2022_04_20_101046_add_index_to_menu_table',1),(20,'2022_07_10_034813_move_lang_folder_to_root',1),(21,'2022_08_04_051940_add_missing_column_expires_at',1),(22,'2022_09_01_000001_create_admin_notifications_tables',1),(23,'2022_10_14_024629_drop_column_is_featured',1),(24,'2022_11_18_063357_add_missing_timestamp_in_table_settings',1),(25,'2022_12_02_093615_update_slug_index_columns',1),(26,'2023_01_30_024431_add_alt_to_media_table',1),(27,'2023_02_16_042611_drop_table_password_resets',1),(28,'2023_04_23_005903_add_column_permissions_to_admin_notifications',1),(29,'2023_05_10_075124_drop_column_id_in_role_users_table',1),(30,'2023_08_21_090810_make_page_content_nullable',1),(31,'2023_09_14_021936_update_index_for_slugs_table',1),(32,'2023_12_07_095130_add_color_column_to_media_folders_table',1),(33,'2023_12_17_162208_make_sure_column_color_in_media_folders_nullable',1),(34,'2024_04_04_110758_update_value_column_in_user_meta_table',1),(35,'2024_05_04_030654_improve_social_links',1),(36,'2024_05_12_091229_add_column_visibility_to_table_media_files',1),(37,'2024_07_07_091316_fix_column_url_in_menu_nodes_table',1),(38,'2024_07_12_100000_change_random_hash_for_media',1),(39,'2024_09_30_024515_create_sessions_table',1),(40,'2024_12_01_000000_add_indexes_to_pages_translations_table',1),(41,'2024_12_01_000000_add_key_prefix_index_to_slugs_table',1),(42,'2024_12_19_000001_create_device_tokens_table',1),(43,'2024_12_19_000002_create_push_notifications_table',1),(44,'2024_12_19_000003_create_push_notification_recipients_table',1),(45,'2024_12_30_000001_create_user_settings_table',1),(46,'2025_07_06_030754_add_phone_to_users_table',1),(47,'2025_07_31_add_performance_indexes_to_slugs_table',1),(48,'2025_11_10_000000_cleanup_duplicate_widgets',1),(49,'2025_11_30_100000_add_sessions_invalidated_at_to_users_table',1),(50,'2020_11_18_150916_ads_create_ads_table',2),(51,'2021_12_02_035301_add_ads_translations_table',2),(52,'2023_04_17_062645_add_open_in_new_tab',2),(53,'2023_11_07_023805_add_tablet_mobile_image',2),(54,'2024_04_01_043317_add_google_adsense_slot_id_to_ads_table',2),(55,'2025_04_21_000000_add_tablet_mobile_image_to_ads_translations_table',2),(56,'2024_04_27_100730_improve_analytics_setting',3),(57,'2015_06_29_025744_create_audit_history',4),(58,'2023_11_14_033417_change_request_column_in_table_audit_histories',4),(59,'2025_05_05_000001_add_user_type_to_audit_histories_table',4),(60,'2025_11_07_000001_add_actor_type_to_audit_histories_table',4),(61,'2015_06_18_033822_create_blog_table',5),(62,'2021_02_16_092633_remove_default_value_for_author_type',5),(63,'2021_12_03_030600_create_blog_translations',5),(64,'2022_04_19_113923_add_index_to_table_posts',5),(65,'2023_08_29_074620_make_column_author_id_nullable',5),(66,'2024_07_30_091615_fix_order_column_in_categories_table',5),(67,'2024_12_01_000000_add_indexes_to_blog_translations_tables',5),(68,'2025_01_06_033807_add_default_value_for_categories_author_type',5),(69,'2016_06_17_091537_create_contacts_table',6),(70,'2023_11_10_080225_migrate_contact_blacklist_email_domains_to_core',6),(71,'2024_03_20_080001_migrate_change_attribute_email_to_nullable_form_contacts_table',6),(72,'2024_03_25_000001_update_captcha_settings_for_contact',6),(73,'2024_04_19_063914_create_custom_fields_table',6),(74,'2024_12_01_000000_add_indexes_to_contact_translations_tables',6),(75,'2020_03_05_041139_create_ecommerce_tables',7),(76,'2021_01_01_044147_ecommerce_create_flash_sale_table',7),(77,'2021_01_17_082713_add_column_is_featured_to_product_collections_table',7),(78,'2021_01_18_024333_add_zip_code_into_table_customer_addresses',7),(79,'2021_02_18_073505_update_table_ec_reviews',7),(80,'2021_03_10_024419_add_column_confirmed_at_to_table_ec_customers',7),(81,'2021_03_10_025153_change_column_tax_amount',7),(82,'2021_03_20_033103_add_column_availability_to_table_ec_products',7),(83,'2021_04_28_074008_ecommerce_create_product_label_table',7),(84,'2021_05_31_173037_ecommerce_create_ec_products_translations',7),(85,'2021_08_17_105016_remove_column_currency_id_in_some_tables',7),(86,'2021_08_30_142128_add_images_column_to_ec_reviews_table',7),(87,'2021_10_04_030050_add_column_created_by_to_table_ec_products',7),(88,'2021_10_05_122616_add_status_column_to_ec_customers_table',7),(89,'2021_11_03_025806_nullable_phone_number_in_ec_customer_addresses',7),(90,'2021_11_23_071403_correct_languages_for_product_variations',7),(91,'2021_11_28_031808_add_product_tags_translations',7),(92,'2021_12_01_031123_add_featured_image_to_ec_products',7),(93,'2022_01_01_033107_update_table_ec_shipments',7),(94,'2022_02_16_042457_improve_product_attribute_sets',7),(95,'2022_03_22_075758_correct_product_name',7),(96,'2022_04_19_113334_add_index_to_ec_products',7),(97,'2022_04_28_144405_remove_unused_table',7),(98,'2022_05_05_115015_create_ec_customer_recently_viewed_products_table',7),(99,'2022_05_18_143720_add_index_to_table_ec_product_categories',7),(100,'2022_06_16_095633_add_index_to_some_tables',7),(101,'2022_06_30_035148_create_order_referrals_table',7),(102,'2022_07_24_153815_add_completed_at_to_ec_orders_table',7),(103,'2022_08_14_032836_create_ec_order_returns_table',7),(104,'2022_08_14_033554_create_ec_order_return_items_table',7),(105,'2022_08_15_040324_add_billing_address',7),(106,'2022_08_30_091114_support_digital_products_table',7),(107,'2022_09_13_095744_create_options_table',7),(108,'2022_09_13_104347_create_option_value_table',7),(109,'2022_10_05_163518_alter_table_ec_order_product',7),(110,'2022_10_12_041517_create_invoices_table',7),(111,'2022_10_12_142226_update_orders_table',7),(112,'2022_10_13_024916_update_table_order_returns',7),(113,'2022_10_21_030830_update_columns_in_ec_shipments_table',7),(114,'2022_10_28_021046_update_columns_in_ec_shipments_table',7),(115,'2022_11_16_034522_update_type_column_in_ec_shipping_rules_table',7),(116,'2022_11_19_041643_add_ec_tax_product_table',7),(117,'2022_12_12_063830_update_tax_defadult_in_ec_tax_products_table',7),(118,'2022_12_17_041532_fix_address_in_order_invoice',7),(119,'2022_12_26_070329_create_ec_product_views_table',7),(120,'2023_01_04_033051_fix_product_categories',7),(121,'2023_01_09_050400_add_ec_global_options_translations_table',7),(122,'2023_01_10_093754_add_missing_option_value_id',7),(123,'2023_01_17_082713_add_column_barcode_and_cost_per_item_to_product_table',7),(124,'2023_01_26_021854_add_ec_customer_used_coupons_table',7),(125,'2023_02_08_015900_update_options_column_in_ec_order_product_table',7),(126,'2023_02_27_095752_remove_duplicate_reviews',7),(127,'2023_03_20_115757_add_user_type_column_to_ec_shipment_histories_table',7),(128,'2023_04_21_082427_create_ec_product_categorizables_table',7),(129,'2023_05_03_011331_add_missing_column_price_into_invoice_items_table',7),(130,'2023_05_17_025812_fix_invoice_issue',7),(131,'2023_05_26_073140_move_option_make_phone_field_optional_at_checkout_page_to_mandatory_fields',7),(132,'2023_05_27_144611_fix_exchange_rate_setting',7),(133,'2023_06_22_084331_add_generate_license_code_to_ec_products_table',7),(134,'2023_06_30_042512_create_ec_order_tax_information_table',7),(135,'2023_07_14_022724_remove_column_id_from_ec_product_collection_products',7),(136,'2023_08_09_012940_remove_column_status_in_ec_product_attributes',7),(137,'2023_08_15_064505_create_ec_tax_rules_table',7),(138,'2023_08_21_021819_make_column_address_in_ec_customer_addresses_nullable',7),(139,'2023_08_22_094114_drop_unique_for_barcode',7),(140,'2023_08_30_031811_add_apply_via_url_column_to_ec_discounts_table',7),(141,'2023_09_07_094312_add_index_to_product_sku_and_translations',7),(142,'2023_09_19_024955_create_discount_product_categories_table',7),(143,'2023_10_17_070728_add_icon_and_icon_image_to_product_categories_table',7),(144,'2023_11_22_154643_add_unique_in_table_ec_products_variations',7),(145,'2023_11_27_032313_add_price_columns_to_ec_product_cross_sale_relations_table',7),(146,'2023_12_06_023945_add_display_on_checkout_column_to_ec_discounts_table',7),(147,'2023_12_25_040604_ec_create_review_replies_table',7),(148,'2023_12_26_090340_add_private_notes_column_to_ec_customers_table',7),(149,'2024_01_16_070706_fix_translation_tables',7),(150,'2024_01_23_075227_add_proof_file_to_ec_orders_table',7),(151,'2024_03_26_041531_add_cancel_reason_to_ec_orders_table',7),(152,'2024_03_27_062402_create_ec_customer_deletion_requests_table',7),(153,'2024_03_29_042242_migrate_old_captcha_settings',7),(154,'2024_03_29_093946_create_ec_order_return_histories_table',7),(155,'2024_04_01_063523_add_customer_columns_to_ec_reviews_table',7),(156,'2024_04_15_092654_migrate_ecommerce_google_tag_manager_code_setting',7),(157,'2024_04_16_035713_add_min_max_order_quantity_columns_to_products_table',7),(158,'2024_05_07_073153_improve_table_wishlist',7),(159,'2024_05_07_093703_add_missing_zip_code_into_table_store_locators',7),(160,'2024_05_15_021503_fix_invoice_path',7),(161,'2024_06_20_160724_create_ec_shared_wishlists_table',7),(162,'2024_06_28_025104_add_notify_attachment_updated_column_to_ec_products_table',7),(163,'2024_07_03_030900_add_downloaded_at_column_to_ec_order_product_table',7),(164,'2024_07_14_071826_make_customer_email_nullable',7),(165,'2024_07_15_104916_add_video_media_column_to_ec_products_table',7),(166,'2024_07_26_052530_add_percentage_to_tax_rules_table',7),(167,'2024_08_14_123028_add_customer_delivered_confirmed_at_column_to_ec_shipments_table',7),(168,'2024_08_19_132849_create_specification_tables',7),(169,'2024_09_07_060744_add_author_column_to_specification_tables',7),(170,'2024_09_14_064023_add_can_use_with_flash_sale_column_to_ec_discounts_table',7),(171,'2024_09_25_073928_remove_wrong_product_slugs',7),(172,'2024_12_01_000000_add_indexes_to_ecommerce_translations_tables',7),(173,'2025_01_10_000000_fix_order_invoice_rounding_issues',7),(174,'2025_01_15_050230_migrate_old_theme_options',7),(175,'2025_01_15_optimize_products_export_index',7),(176,'2025_01_17_082713_correct_column_barcode_and_cost_per_item_to_product_table',7),(177,'2025_01_24_044641_migrate_old_country_data',7),(178,'2025_01_28_233602_add_private_notes_into_ec_orders_table',7),(179,'2025_02_13_021247_add_tax_translations',7),(180,'2025_02_24_152621_add_text_color_to_product_labels_table',7),(181,'2025_04_12_000001_add_payment_fee_to_ec_orders_table',7),(182,'2025_04_12_000002_add_payment_fee_to_ec_invoices_table',7),(183,'2025_05_05_092036_make_user_id_and_tax_amount_nullable',7),(184,'2025_05_15_082342_drop_email_unique_index_in_ec_customers_table',7),(185,'2025_06_07_081731_add_translations_for_specification_groups_and_tables',7),(186,'2025_06_17_091813_increase_note_in_shipments_table',7),(187,'2025_06_24_000001_create_ec_product_license_codes_table',7),(188,'2025_06_24_080427_add_license_code_type_to_products_table',7),(189,'2025_07_06_062402_create_ec_customer_deletion_requests_table',7),(190,'2025_07_07_161729_change_license_code_to_text_in_ec_product_license_codes_table',7),(191,'2025_07_08_162756_increase_license_code_column_size_in_ec_order_product_table',7),(192,'2025_07_09_000001_add_customer_address_fields_to_ec_invoices_table',7),(193,'2025_07_15_090809_create_ec_abandoned_carts_table',7),(194,'2025_07_24_120510_increase_barcode_column_length_in_ec_products_table',7),(195,'2025_07_31_133600_add_performance_indexes_to_ec_product_categories_table',7),(196,'2025_08_01_161205_optimize_product_variation_query_indexes',7),(197,'2025_08_08_145059_correct_tax_amount_in_order_and_invoice_tables',7),(198,'2025_09_05_025247_create_ec_product_specification_attribute_translations_table',7),(199,'2025_09_08_025516_add_variations_count_to_ec_products_table',7),(200,'2025_09_08_080248_add_slug_column_to_ec_product_categories_table',7),(201,'2025_09_08_080330_add_slug_column_to_ec_product_categories_translations_table',7),(202,'2025_09_08_080443_populate_slug_column_for_product_categories',7),(203,'2025_09_08_081216_add_slug_column_to_ec_products_table',7),(204,'2025_09_08_081237_add_slug_column_to_ec_products_translations_table',7),(205,'2025_09_08_081321_populate_slug_column_for_products',7),(206,'2025_09_10_073321_add_performance_indexes_to_ecommerce_tables',7),(207,'2025_09_18_093922_fix_tax_rounding_in_order_products_and_invoices',7),(208,'2025_09_21_030756_add_reviews_cache_to_ec_products_table',7),(209,'2025_09_30_090432_add_performance_indexes_to_ec_product_categories_table',7),(210,'2025_10_10_090331_add_number_format_style_to_ec_currencies_table',7),(211,'2025_10_10_092235_add_space_between_price_and_currency_to_ec_currencies_table',7),(212,'2025_10_11_074318_add_price_includes_tax_to_ec_products_table',7),(213,'2025_10_13_043527_generate_slugs_for_product_collections',7),(214,'2025_10_22_020518_add_verification_code_to_ec_customer_deletion_requests_table',7),(215,'2025_10_22_090000_remove_duplicate_order_addresses',7),(216,'2025_10_28_133220_add_unique_order_id_to_shipments_table',7),(217,'2025_10_28_134738_fix_order_payment_shipment_discount_data_issues',7),(218,'2025_11_05_032148_add_performance_indexes_to_ecommerce_tables',7),(219,'2025_11_10_100000_create_ec_order_metadata_table',7),(220,'2025_11_12_100000_improve_ec_customer_recently_viewed_products_table',7),(221,'2025_11_18_214150_add_covering_indexes_to_product_relation_tables',7),(222,'2025_12_02_045049_add_index_to_product_labels_table',7),(223,'2025_12_12_150000_add_sequence_columns_to_abandoned_carts',7),(224,'2025_12_16_160000_add_is_new_until_to_ec_products_table',7),(225,'2025_12_28_000628_add_images_column_to_ec_order_returns_table',7),(226,'2026_01_05_162601_update_missing_slugs_for_ec_product_categories_table',7),(227,'2026_01_09_024811_add_currency_code_to_ec_products_table',7),(228,'2026_01_11_221755_add_price_columns_to_ec_product_up_sale_relations_table',7),(229,'2026_01_14_035001_add_customer_id_to_ec_cart_table',7),(230,'2026_01_26_084750_add_customer_id_to_ec_review_replies_table',7),(231,'2026_01_31_144854_add_zip_code_range_to_ec_shipping_rule_items_table',7),(232,'2026_02_02_090000_create_ec_order_product_tax_components_table',7),(233,'2026_02_02_090001_create_ec_invoice_item_tax_components_table',7),(234,'2026_02_02_090002_add_tax_class_to_ec_customers_table',7),(235,'2026_02_02_090003_add_tax_class_to_ec_products_table',7),(236,'2026_02_02_090004_add_tax_breakdown_to_ec_order_product_table',7),(237,'2026_02_03_090000_drop_foreign_key_from_ec_order_product_tax_components_table',7),(238,'2026_02_07_090000_remove_duplicate_product_variation_records',7),(239,'2026_02_11_090000_add_price_per_product_to_options_tables',7),(240,'2026_02_11_090000_add_shipping_tax_amount_to_ec_orders_and_invoices_table',7),(241,'2018_07_09_221238_create_faq_table',8),(242,'2021_12_03_082134_create_faq_translations',8),(243,'2023_11_17_063408_add_description_column_to_faq_categories_table',8),(244,'2024_12_01_000000_add_indexes_to_faq_translations_tables',8),(245,'2016_10_03_032336_create_languages_table',9),(246,'2023_09_14_022423_add_index_for_language_table',9),(247,'2021_10_25_021023_fix-priority-load-for-language-advanced',10),(248,'2021_12_03_075608_create_page_translations',10),(249,'2023_07_06_011444_create_slug_translations_table',10),(250,'2024_12_01_000000_add_indexes_to_slugs_translations_table',10),(251,'2019_11_18_061011_create_country_table',11),(252,'2021_12_03_084118_create_location_translations',11),(253,'2021_12_03_094518_migrate_old_location_data',11),(254,'2021_12_10_034440_switch_plugin_location_to_use_language_advanced',11),(255,'2022_01_16_085908_improve_plugin_location',11),(256,'2022_08_04_052122_delete_location_backup_tables',11),(257,'2023_04_23_061847_increase_state_translations_abbreviation_column',11),(258,'2023_07_26_041451_add_more_columns_to_location_table',11),(259,'2023_07_27_041451_add_more_columns_to_location_translation_table',11),(260,'2023_08_15_073307_drop_unique_in_states_cities_translations',11),(261,'2023_10_21_065016_make_state_id_in_table_cities_nullable',11),(262,'2024_08_17_094600_add_image_into_countries',11),(263,'2025_01_08_093652_add_zip_code_to_cities',11),(264,'2025_07_31_083459_add_indexes_for_location_search_performance',11),(265,'2021_07_06_030002_create_marketplace_table',12),(266,'2021_09_04_150137_add_vendor_verified_at_to_ec_customers_table',12),(267,'2021_10_04_033903_add_column_approved_by_into_table_ec_products',12),(268,'2021_10_06_124943_add_transaction_id_column_to_mp_customer_withdrawals_table',12),(269,'2021_10_10_054216_add_columns_to_mp_customer_revenues_table',12),(270,'2021_12_06_031304_update_table_mp_customer_revenues',12),(271,'2022_10_19_152916_add_columns_to_mp_stores_table',12),(272,'2022_10_20_062849_create_mp_category_sale_commissions_table',12),(273,'2022_11_02_071413_add_more_info_for_store',12),(274,'2022_11_02_080444_add_tax_info',12),(275,'2023_02_01_062030_add_store_translations',12),(276,'2023_02_13_032133_update_fee_column_mp_customer_revenues_table',12),(277,'2023_02_17_023648_fix_store_prefix',12),(278,'2024_04_03_062451_add_cover_image_to_table_mp_stores',12),(279,'2024_05_07_082630_create_mp_messages_table',12),(280,'2024_07_19_131849_add_documents_to_mp_stores_table',12),(281,'2024_08_18_083119_add_tax_id_column_to_mp_stores_table',12),(282,'2024_08_27_141244_add_block_reason_to_ec_customers_table',12),(283,'2024_09_17_125408_add_square_logo_to_stores_table',12),(284,'2025_07_31_021805_add_indexes_for_vendor_categories_optimization',12),(285,'2025_08_07_073854_add_verification_fields_to_mp_stores_table',12),(286,'2025_11_05_000001_add_indexes_for_marketplace_performance_optimization',12),(287,'2026_02_02_090000_add_tax_location_to_mp_stores_table',12),(288,'2017_10_24_154832_create_newsletter_table',13),(289,'2024_03_25_000001_update_captcha_settings_for_newsletter',13),(290,'2017_05_18_080441_create_payment_tables',14),(291,'2021_03_27_144913_add_customer_type_into_table_payments',14),(292,'2021_05_24_034720_make_column_currency_nullable',14),(293,'2021_08_09_161302_add_metadata_column_to_payments_table',14),(294,'2021_10_19_020859_update_metadata_field',14),(295,'2022_06_28_151901_activate_paypal_stripe_plugin',14),(296,'2022_07_07_153354_update_charge_id_in_table_payments',14),(297,'2024_07_04_083133_create_payment_logs_table',14),(298,'2025_04_12_000003_add_payment_fee_to_payments_table',14),(299,'2025_05_22_000001_add_payment_fee_type_to_settings_table',14),(300,'2017_07_11_140018_create_simple_slider_table',15),(301,'2026_01_10_000001_add_status_to_simple_slider_items_table',15),(302,'2025_04_08_040931_create_social_logins_table',16),(303,'2024_09_14_100108_add_stripe_connect_details_to_ec_customers_table',17),(304,'2018_07_09_214610_create_testimonial_table',18),(305,'2021_12_03_083642_create_testimonials_translations',18),(306,'2024_12_01_000000_add_indexes_to_testimonials_translations_table',18),(307,'2016_10_07_193005_create_translations_table',19),(308,'2023_12_12_105220_drop_translations_table',19);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_category_sale_commissions`
--

DROP TABLE IF EXISTS `mp_category_sale_commissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_category_sale_commissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_category_id` bigint unsigned NOT NULL,
  `commission_percentage` decimal(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mp_category_sale_commissions_product_category_id_unique` (`product_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_category_sale_commissions`
--

LOCK TABLES `mp_category_sale_commissions` WRITE;
/*!40000 ALTER TABLE `mp_category_sale_commissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_category_sale_commissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_customer_revenues`
--

DROP TABLE IF EXISTS `mp_customer_revenues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_customer_revenues` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `sub_amount` decimal(15,2) DEFAULT '0.00',
  `fee` decimal(15,2) unsigned DEFAULT '0.00',
  `amount` decimal(15,2) DEFAULT '0.00',
  `current_balance` decimal(15,2) DEFAULT '0.00',
  `currency` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  `type` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mp_customer_revenues_customer_id_index` (`customer_id`),
  KEY `mp_customer_revenues_order_id_index` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_customer_revenues`
--

LOCK TABLES `mp_customer_revenues` WRITE;
/*!40000 ALTER TABLE `mp_customer_revenues` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_customer_revenues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_customer_withdrawals`
--

DROP TABLE IF EXISTS `mp_customer_withdrawals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_customer_withdrawals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `fee` decimal(15,2) unsigned DEFAULT '0.00',
  `amount` decimal(15,2) unsigned DEFAULT '0.00',
  `current_balance` decimal(15,2) unsigned DEFAULT '0.00',
  `currency` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `bank_info` text COLLATE utf8mb4_unicode_ci,
  `payment_channel` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `images` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `transaction_id` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mp_customer_withdrawals_customer_id_index` (`customer_id`),
  KEY `mp_customer_withdrawals_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_customer_withdrawals`
--

LOCK TABLES `mp_customer_withdrawals` WRITE;
/*!40000 ALTER TABLE `mp_customer_withdrawals` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_customer_withdrawals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_messages`
--

DROP TABLE IF EXISTS `mp_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `store_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_messages`
--

LOCK TABLES `mp_messages` WRITE;
/*!40000 ALTER TABLE `mp_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_stores`
--

DROP TABLE IF EXISTS `mp_stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_stores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_square` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `verified_at` timestamp NULL DEFAULT NULL,
  `verified_by` bigint unsigned DEFAULT NULL,
  `verification_note` text COLLATE utf8mb4_unicode_ci,
  `vendor_verified_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_country` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_state` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate_file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `government_id_file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mp_stores_customer_id_index` (`customer_id`),
  KEY `mp_stores_status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_stores`
--

LOCK TABLES `mp_stores` WRITE;
/*!40000 ALTER TABLE `mp_stores` DISABLE KEYS */;
INSERT INTO `mp_stores` VALUES (1,'GoPro','pbuckridge@example.org','+14344547939','950 Abshire Islands','RO','Mississippi','East Phyllisberg',2,'stores/1.png',NULL,NULL,'Sunt cumque quam qui consequatur ut. Quis voluptatem ad ut accusantium dicta et aut. Architecto possimus soluta aut architecto animi ut atque veniam. Maxime eaque dolore fugit in itaque aspernatur. Consequatur aut deserunt dolores impedit qui perspiciatis earum. Porro non eum aut culpa. Voluptas fugiat consequuntur deleniti itaque suscipit sit. Dicta vel facilis quos doloremque.','Founded in 2002, GoPro has grown into a global brand known for its action cameras and versatile accessories.','published',1,'2025-12-15 08:15:41',NULL,'Verified business with valid documentation',NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Global Office','jordi.gleason@example.net','+17869354133','86635 Elias Passage Apt. 114','MH','Virginia','New Abraham',7,'stores/2.png',NULL,NULL,'Id quibusdam et consequatur. Cum blanditiis illum voluptate alias. Dolorem tempora dignissimos aut illum id. Soluta voluptatem sed et illum repudiandae ut. Sed illum consequatur voluptatem. Est numquam quisquam tempora. Asperiores ipsum quos eveniet delectus consequatur saepe quam. Labore distinctio quia ut quaerat qui cumque. Vero pariatur distinctio deserunt aut.','Global Office provides high-quality office supplies and equipment for businesses of all sizes.','published',1,'2025-11-25 08:15:41',NULL,'Established vendor with proven track record',NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'Young Shop','amalia14@example.net','+13605779828','9315 Ziemann Ports Suite 125','GD','Arkansas','Port Kaleigh',2,'stores/3.png',NULL,NULL,'Minima aperiam dolorem voluptates in mollitia non autem. Expedita consequatur sint quia dignissimos. Commodi consequatur maxime occaecati ea temporibus consequatur culpa. Reiciendis in quo quisquam. Soluta et rem et omnis. Sed quos quia quaerat repellat similique voluptatem ullam. Dolor pariatur rerum dicta aut in voluptas.','Young Shop specializes in trendy fashion and accessories for the youth market.','published',0,NULL,NULL,NULL,NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'Global Store','martine.rath@example.com','+14586594216','47325 Eldridge Glens','LY','South Dakota','Antoniettatown',2,'stores/4.png',NULL,NULL,'Nulla dolorem excepturi ratione facilis rerum. Omnis corporis autem suscipit repellendus nisi. Excepturi ratione vero commodi a. Quia omnis quia provident repellat laudantium ratione quia. Quis dolor ipsam officiis. Enim id unde ab soluta. Id sunt qui est sit quis excepturi quis et.','Global Store offers a wide range of products from electronics to home goods at competitive prices.','published',1,'2025-09-28 08:15:41',NULL,'Authentic products and reliable service confirmed',NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Robert\'s Store','nils18@example.com','+18704551421','24462 Pinkie Club Suite 108','PR','Connecticut','South Maybell',8,'stores/5.png',NULL,NULL,'Sint omnis blanditiis excepturi assumenda dignissimos accusantium. Rem quo aut est. Consequuntur voluptatem aut aut qui cupiditate fuga. Pariatur in enim dolorem sit illo. Molestiae natus distinctio dolorem recusandae. Et odio nemo qui eius. Consequatur optio quaerat pariatur. Autem rerum quaerat harum omnis. Officia nemo qui sed.','Robert\'s Store is your destination for premium quality clothing and accessories.','published',0,NULL,NULL,NULL,NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'Stouffer','bashirian.horacio@example.com','+14356190236','5598 Jackson Center Apt. 723','GB','South Dakota','East Claudiemouth',6,'stores/6.png',NULL,NULL,'Et cupiditate hic adipisci sequi tenetur. Aut quis sit non eos quisquam dolorem blanditiis. Minus eius ab enim necessitatibus distinctio libero. Quae laudantium autem quisquam error. Et explicabo maiores eligendi rerum omnis officiis. Tenetur ratione sit molestiae et quo. Cupiditate laboriosam distinctio nobis. Id perspiciatis amet velit molestias.','Stouffer brings you delicious, ready-to-eat meals that are perfect for busy lifestyles.','published',0,NULL,NULL,NULL,NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'StarKist','enola.kemmer@example.org','+16306077042','979 Lehner Terrace','MR','North Dakota','Josephmouth',5,'stores/7.png',NULL,NULL,'Animi recusandae molestias sed id quo minima non. Consequatur assumenda qui enim est reprehenderit cumque eos. Sed perferendis est odit. Totam sint corporis sed aut quia illo iste. Quibusdam voluptatem sit et consectetur tempore. Ullam ut occaecati consequatur animi ipsam. Dolorem maiores vitae asperiores minus dolorem et dolore molestiae. Atque sed magni enim dicta.','StarKist is committed to providing sustainable seafood products of the highest quality.','published',0,NULL,NULL,NULL,NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'Old El Paso','daniel.hosea@example.com','+16187430196','59329 Providenci Knoll','BD','Texas','Georgiannaburgh',9,'stores/8.png',NULL,NULL,'Laudantium ratione voluptas optio rerum laboriosam magnam consequatur. Omnis eos consequuntur fuga omnis numquam optio sed. Dolor voluptatem omnis aliquam sed ipsa ut animi. Fuga consequuntur vitae et maxime. Qui asperiores ut et numquam. Cupiditate in nihil aut natus modi ipsa. Non libero facere ea officiis at voluptas. Et sed sit velit modi sint atque accusamus.','Old El Paso brings the flavors of Mexico to your table with authentic ingredients and recipes.','published',0,NULL,NULL,NULL,NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'Tyson','ericka57@example.com','+17434413075','554 Keebler Fork Apt. 562','TN','Louisiana','Windlerside',3,'stores/9.png',NULL,NULL,'Labore quia error enim numquam esse aut nisi. Qui totam quisquam aut non. Est consequatur sapiente deserunt a perspiciatis non. Illum nostrum dolor a iusto aliquid sequi. Ducimus eos in in odit qui error quis. Ut sunt laboriosam possimus necessitatibus qui velit. Et enim consequatur fugiat velit aut laudantium esse.','Tyson offers a variety of protein products to help you create delicious meals for your family.','published',0,NULL,NULL,NULL,NULL,'2026-02-28 08:15:43','2026-02-28 08:15:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mp_stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_stores_translations`
--

DROP TABLE IF EXISTS `mp_stores_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_stores_translations` (
  `lang_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mp_stores_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`mp_stores_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_stores_translations`
--

LOCK TABLES `mp_stores_translations` WRITE;
/*!40000 ALTER TABLE `mp_stores_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_stores_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_vendor_info`
--

DROP TABLE IF EXISTS `mp_vendor_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_vendor_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL DEFAULT '0',
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_fee` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_revenue` decimal(15,2) NOT NULL DEFAULT '0.00',
  `signature` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_info` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payout_payment_method` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT 'bank_transfer',
  `tax_info` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `mp_vendor_info_customer_id_index` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_vendor_info`
--

LOCK TABLES `mp_vendor_info` WRITE;
/*!40000 ALTER TABLE `mp_vendor_info` DISABLE KEYS */;
INSERT INTO `mp_vendor_info` VALUES (1,2,0.00,0.00,0.00,'$2y$12$E9.WDEWpuRshT3.g5gpAf.rrwjIZ6B3prjKHdT42MU4vQXT9mS9SK','{\"name\":\"Jessica Kiehn\",\"number\":\"+13392417006\",\"full_name\":\"Mr. Carmel Mitchell\",\"description\":\"Romaine Bosco\"}','2026-02-28 08:15:41','2026-02-28 08:15:41','bank_transfer',NULL),(2,3,0.00,0.00,0.00,'$2y$12$gmaHlleGfuTXPkEjodeJwOTMlY2FDN6gx9vwPE8P60BP5gH.d0IZW','{\"name\":\"Johanna Koss\",\"number\":\"+18189142417\",\"full_name\":\"Prof. Johanna Senger\",\"description\":\"Mrs. Angela Berge\"}','2026-02-28 08:15:41','2026-02-28 08:15:41','bank_transfer',NULL),(3,4,0.00,0.00,0.00,'$2y$12$uffsB2Ws42JhoZogjkV9CO7fz3Suwvtf5maYhCls8aNvC5QjTi1nW','{\"name\":\"Fabiola Renner\",\"number\":\"+12833516902\",\"full_name\":\"Miss Kelsie McCullough IV\",\"description\":\"Daisy Larson II\"}','2026-02-28 08:15:42','2026-02-28 08:15:42','bank_transfer',NULL),(4,5,0.00,0.00,0.00,'$2y$12$G0y4OHphG1yhb2xi4r./a.rK9jGyeWVaPhL56VXf59lkmWrX7AbCG','{\"name\":\"Natasha Kilback\",\"number\":\"+16515253393\",\"full_name\":\"Sylvan Kutch\",\"description\":\"Devan Wolff\"}','2026-02-28 08:15:42','2026-02-28 08:15:42','bank_transfer',NULL),(5,6,0.00,0.00,0.00,'$2y$12$Jr0WwL4zB2v4guh8qMq3DuWSikyCCZIoXSJ152EuXOebzICB8Nms.','{\"name\":\"Dr. Brionna Weber II\",\"number\":\"+16055957488\",\"full_name\":\"Jaclyn Little IV\",\"description\":\"Terence Mohr\"}','2026-02-28 08:15:42','2026-02-28 08:15:42','bank_transfer',NULL),(6,7,0.00,0.00,0.00,'$2y$12$wHswWXRF2NGe9XHECd.wceqWSh7J5wwt0HrfvgnNX.GYeojZmuRIW','{\"name\":\"Dr. Sim Wehner\",\"number\":\"+13038365050\",\"full_name\":\"Ceasar Gibson\",\"description\":\"Miss Karlie Bechtelar Sr.\"}','2026-02-28 08:15:42','2026-02-28 08:15:42','bank_transfer',NULL),(7,8,0.00,0.00,0.00,'$2y$12$HRM2z9WMWxh/fk7Q8J5iyOod9hQilFUwUSihUFk/F55FA1l0gnyr6','{\"name\":\"Yazmin Huels\",\"number\":\"+14306386439\",\"full_name\":\"Prof. Jermain Schimmel\",\"description\":\"Francis Zieme MD\"}','2026-02-28 08:15:43','2026-02-28 08:15:43','bank_transfer',NULL),(8,9,0.00,0.00,0.00,'$2y$12$bgFlcKygeELlEQ3WOBPwZuTo96m17w9MPvWh2Z1U.Xi4Faj9mK352','{\"name\":\"Devonte Jaskolski\",\"number\":\"+13026500515\",\"full_name\":\"Dr. Greg Walter DDS\",\"description\":\"Prof. Icie Zieme\"}','2026-02-28 08:15:43','2026-02-28 08:15:43','bank_transfer',NULL);
/*!40000 ALTER TABLE `mp_vendor_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsletters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'subscribed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletters`
--

LOCK TABLES `newsletters` WRITE;
/*!40000 ALTER TABLE `newsletters` DISABLE KEYS */;
/*!40000 ALTER TABLE `newsletters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `user_id` bigint unsigned DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pages_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'Home','<div>[simple-slider key=\"home-slider\" ads_1=\"VC2C8Q1UGCBG\" ads_2=\"NBDWRXTSVZ8N\"][/simple-slider]</div><div>[site-features icon1=\"icon-rocket\" title1=\"Free Delivery\" subtitle1=\"For all orders over $99\" icon2=\"icon-sync\" title2=\"90 Days Return\" subtitle2=\"If goods have problems\" icon3=\"icon-credit-card\" title3=\"Secure Payment\" subtitle3=\"100% secure payment\" icon4=\"icon-bubbles\" title4=\"24/7 Support\" subtitle4=\"Dedicated support\" icon5=\"icon-gift\" title5=\"Gift Service\" subtitle5=\"Support gift service\" enable_lazy_loading=\"yes\"][/site-features]</div><div>[flash-sale title=\"Deal of the day\" flash_sale_id=\"1\" enable_lazy_loading=\"yes\"][/flash-sale]</div><div>[featured-product-categories title=\"Top Categories\" enable_lazy_loading=\"yes\"][/featured-product-categories]</div><div>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[featured-products title=\"Featured products\" enable_lazy_loading=\"yes\"][/featured-products]</div><div>[theme-ads key_1=\"Q9YDUIC9HSWS\" key_2=\"IZ6WU8KUALYE\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[product-collections title=\"Exclusive Products\" enable_lazy_loading=\"yes\"][/product-collections]</div><div>[product-category-products category_id=\"18\" enable_lazy_loading=\"yes\"][/product-category-products]</div>[testimonials title=\"What our Clients say\" subtitle=\"Customers Review\" testimonial_ids=\"1,2,3,4\" enable_lazy_loading=\"yes\"][/testimonials]<div>[download-app title=\"Download Martfury App Now!\" subtitle=\"Shopping fastly and easily more with our app. Get a link to download the app on your phone.\" screenshot=\"general/app.png\" android_app_url=\"https://www.appstore.com\" ios_app_url=\"https://play.google.com/store\" enable_lazy_loading=\"yes\"][/download-app]</div><div>[product-category-products category_id=\"23\" enable_lazy_loading=\"yes\"][/product-category-products]</div><div>[newsletter-form title=\"Join Our Newsletter Now\" subtitle=\"Subscribe to get information about products and coupons\" enable_lazy_loading=\"yes\"][/newsletter-form]</div>',1,NULL,'homepage',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(2,'About us','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',1,NULL,'default',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(3,'Terms Of Use','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',1,NULL,'default',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(4,'Terms &amp; Conditions','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',1,NULL,'default',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(5,'Refund Policy','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',1,NULL,'default',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(6,'Blog','<p>---</p>',1,NULL,'blog-sidebar',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(7,'FAQs','<div>[faq title=\"Frequently Asked Questions\"][/faq]</div>',1,NULL,'default',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(8,'Contact','<div>[google-map]502 New Street, Brighton VIC, Australia[/google-map]</div><div>[contact-info-boxes title=\"Contact Us For Any Questions\"][/contact-info-boxes]</div><div>[contact-form][/contact-form]</div>',1,NULL,'full-width',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(9,'Cookie Policy','<h3>EU Cookie Consent</h3><p>To use this Website we are using Cookies and collecting some Data. To be compliant with the EU GDPR we give you to choose if you allow us to use certain Cookies and to collect some Data.</p><h4>Essential Data</h4><p>The Essential Data is needed to run the Site you are visiting technically. You can not deactivate them.</p><p>- Session Cookie: PHP uses a Cookie to identify user sessions. Without this Cookie the Website is not working.</p><p>- XSRF-Token Cookie: Laravel automatically generates a CSRF \"token\" for each active user session managed by the application. This token is used to verify that the authenticated user is the one actually making the requests to the application.</p>',1,NULL,'default',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(10,'Affiliate','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',1,NULL,'default',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(11,'Career','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',1,NULL,'default',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(12,'Coming soon','<p>Condimentum ipsum a adipiscing hac dolor set consectetur urna commodo elit parturient <br/>molestie ut nisl partu convallier ullamcorpe.</p><div>[coming-soon time=\"2027-02-28 15:15:37\" image=\"general/coming-soon.jpg\"][/coming-soon]</div>',1,NULL,'coming-soon',NULL,'published','2026-02-28 08:15:37','2026-02-28 08:15:37');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages_translations`
--

DROP TABLE IF EXISTS `pages_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pages_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`lang_code`,`pages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages_translations`
--

LOCK TABLES `pages_translations` WRITE;
/*!40000 ALTER TABLE `pages_translations` DISABLE KEYS */;
INSERT INTO `pages_translations` VALUES ('ar',1,'الصفحة الرئيسية',NULL,'<div>[simple-slider key=\"home-slider-ar\" ads_1=\"VC2C8Q1UGCBG\" ads_2=\"NBDWRXTSVZ8N\"][/simple-slider]</div><div>[site-features icon1=\"icon-rocket\" title1=\"التوصيل المجاني\" subtitle1=\"لجميع الطلبات التي تزيد عن 99 دولارًا\" icon2=\"icon-sync\" title2=\"الإرجاع خلال 90 يومًا\" subtitle2=\"إذا كانت البضائع بها مشاكل\" icon3=\"icon-credit-card\" title3=\"الدفع الآمن\" subtitle3=\"دفع آمن 100٪\" icon4=\"icon-bubbles\" title4=\"الدعم على مدار الساعة\" subtitle4=\"دعم مخصص\" icon5=\"icon-gift\" title5=\"خدمة الهدايا\" subtitle5=\"دعم خدمة الهدايا\" enable_lazy_loading=\"yes\"][/site-features]</div><div>[flash-sale title=\"صفقة اليوم\" flash_sale_id=\"1\" enable_lazy_loading=\"yes\"][/flash-sale]</div><div>[featured-product-categories title=\"الفئات الأعلى\" enable_lazy_loading=\"yes\"][/featured-product-categories]</div><div>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[featured-products title=\"المنتجات المميزة\" enable_lazy_loading=\"yes\"][/featured-products]</div><div>[theme-ads key_1=\"Q9YDUIC9HSWS\" key_2=\"IZ6WU8KUALYE\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[product-collections title=\"المنتجات الحصرية\" enable_lazy_loading=\"yes\"][/product-collections]</div><div>[product-category-products category_id=\"18\" enable_lazy_loading=\"yes\"][/product-category-products]</div>[testimonials title=\"ماذا يقول عملاؤنا\" subtitle=\"تقييم العملاء\" testimonial_ids=\"1,2,3,4\" enable_lazy_loading=\"yes\"][/testimonials]<div>[download-app title=\"قم بتنزيل تطبيق Martfury الآن!\" subtitle=\"تسوق بسرعة وسهولة أكثر مع تطبيقنا. احصل على رابط لتنزيل التطبيق على هاتفك.\" screenshot=\"general/app.png\" android_app_url=\"https://www.appstore.com\" ios_app_url=\"https://play.google.com/store\" enable_lazy_loading=\"yes\"][/download-app]</div><div>[product-category-products category_id=\"23\" enable_lazy_loading=\"yes\"][/product-category-products]</div><div>[newsletter-form title=\"انضم إلى نشرتنا الإخبارية الآن\" subtitle=\"اشترك للحصول على معلومات حول المنتجات والكوبونات\" enable_lazy_loading=\"yes\"][/newsletter-form]</div>'),('ar',2,'من نحن',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('ar',3,'شروط الاستخدام',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('ar',4,'الشروط والأحكام',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('ar',5,'سياسة الاسترجاع',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('ar',6,'المدونة',NULL,'<p>---</p>'),('ar',7,'الأسئلة الشائعة',NULL,'<div>[faq title=\"Frequently Asked Questions\"][/faq]</div>'),('ar',8,'اتصل بنا',NULL,'<div>[google-map]502 New Street, Brighton VIC, Australia[/google-map]</div><div>[contact-info-boxes title=\"Contact Us For Any Questions\"][/contact-info-boxes]</div><div>[contact-form][/contact-form]</div>'),('ar',9,'سياسة ملفات تعريف الارتباط',NULL,'<h3>EU Cookie Consent</h3><p>To use this Website we are using Cookies and collecting some Data. To be compliant with the EU GDPR we give you to choose if you allow us to use certain Cookies and to collect some Data.</p><h4>Essential Data</h4><p>The Essential Data is needed to run the Site you are visiting technically. You can not deactivate them.</p><p>- Session Cookie: PHP uses a Cookie to identify user sessions. Without this Cookie the Website is not working.</p><p>- XSRF-Token Cookie: Laravel automatically generates a CSRF \"token\" for each active user session managed by the application. This token is used to verify that the authenticated user is the one actually making the requests to the application.</p>'),('ar',10,'الشركاء',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('ar',11,'الوظائف',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('ar',12,'قريباً',NULL,'<p>Condimentum ipsum a adipiscing hac dolor set consectetur urna commodo elit parturient <br/>molestie ut nisl partu convallier ullamcorpe.</p><div>[coming-soon time=\"2027-02-28 15:15:37\" image=\"general/coming-soon.jpg\"][/coming-soon]</div>'),('fr',1,'Accueil',NULL,'<div>[simple-slider key=\"home-slider-fr\" ads_1=\"VC2C8Q1UGCBG\" ads_2=\"NBDWRXTSVZ8N\"][/simple-slider]</div><div>[site-features icon1=\"icon-rocket\" title1=\"Livraison gratuite\" subtitle1=\"Pour toutes les commandes supérieures à 99 $\" icon2=\"icon-sync\" title2=\"Retour sous 90 jours\" subtitle2=\"Si les produits ont des problèmes\" icon3=\"icon-credit-card\" title3=\"Paiement sécurisé\" subtitle3=\"Paiement 100% sécurisé\" icon4=\"icon-bubbles\" title4=\"Support 24/7\" subtitle4=\"Support dédié\" icon5=\"icon-gift\" title5=\"Service cadeau\" subtitle5=\"Support service cadeau\" enable_lazy_loading=\"yes\"][/site-features]</div><div>[flash-sale title=\"Offre du jour\" flash_sale_id=\"1\" enable_lazy_loading=\"yes\"][/flash-sale]</div><div>[featured-product-categories title=\"Catégories principales\" enable_lazy_loading=\"yes\"][/featured-product-categories]</div><div>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[featured-products title=\"Produits en vedette\" enable_lazy_loading=\"yes\"][/featured-products]</div><div>[theme-ads key_1=\"Q9YDUIC9HSWS\" key_2=\"IZ6WU8KUALYE\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[product-collections title=\"Produits exclusifs\" enable_lazy_loading=\"yes\"][/product-collections]</div><div>[product-category-products category_id=\"18\" enable_lazy_loading=\"yes\"][/product-category-products]</div>[testimonials title=\"Ce que disent nos clients\" subtitle=\"Avis des clients\" testimonial_ids=\"1,2,3,4\" enable_lazy_loading=\"yes\"][/testimonials]<div>[download-app title=\"Téléchargez l\'application Martfury maintenant !\" subtitle=\"Achetez rapidement et facilement avec notre application. Obtenez un lien pour télécharger l\'application sur votre téléphone.\" screenshot=\"general/app.png\" android_app_url=\"https://www.appstore.com\" ios_app_url=\"https://play.google.com/store\" enable_lazy_loading=\"yes\"][/download-app]</div><div>[product-category-products category_id=\"23\" enable_lazy_loading=\"yes\"][/product-category-products]</div><div>[newsletter-form title=\"Rejoignez notre newsletter maintenant\" subtitle=\"Abonnez-vous pour recevoir des informations sur les produits et les coupons\" enable_lazy_loading=\"yes\"][/newsletter-form]</div>'),('fr',2,'À propos',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('fr',3,'Conditions d\'utilisation',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('fr',4,'Termes et conditions',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('fr',5,'Politique de remboursement',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('fr',6,'Blog',NULL,'<p>---</p>'),('fr',7,'FAQ',NULL,'<div>[faq title=\"Frequently Asked Questions\"][/faq]</div>'),('fr',8,'Contact',NULL,'<div>[google-map]502 New Street, Brighton VIC, Australia[/google-map]</div><div>[contact-info-boxes title=\"Contact Us For Any Questions\"][/contact-info-boxes]</div><div>[contact-form][/contact-form]</div>'),('fr',9,'Politique des cookies',NULL,'<h3>EU Cookie Consent</h3><p>To use this Website we are using Cookies and collecting some Data. To be compliant with the EU GDPR we give you to choose if you allow us to use certain Cookies and to collect some Data.</p><h4>Essential Data</h4><p>The Essential Data is needed to run the Site you are visiting technically. You can not deactivate them.</p><p>- Session Cookie: PHP uses a Cookie to identify user sessions. Without this Cookie the Website is not working.</p><p>- XSRF-Token Cookie: Laravel automatically generates a CSRF \"token\" for each active user session managed by the application. This token is used to verify that the authenticated user is the one actually making the requests to the application.</p>'),('fr',10,'Affilié',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('fr',11,'Carrière',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('fr',12,'Bientôt disponible',NULL,'<p>Condimentum ipsum a adipiscing hac dolor set consectetur urna commodo elit parturient <br/>molestie ut nisl partu convallier ullamcorpe.</p><div>[coming-soon time=\"2027-02-28 15:15:37\" image=\"general/coming-soon.jpg\"][/coming-soon]</div>'),('id',1,'Beranda',NULL,'<div>[simple-slider key=\"home-slider-id\" ads_1=\"VC2C8Q1UGCBG\" ads_2=\"NBDWRXTSVZ8N\"][/simple-slider]</div><div>[site-features icon1=\"icon-rocket\" title1=\"Pengiriman gratis\" subtitle1=\"Untuk semua pesanan di atas $99\" icon2=\"icon-sync\" title2=\"Pengembalian 90 hari\" subtitle2=\"Jika barang bermasalah\" icon3=\"icon-credit-card\" title3=\"Pembayaran aman\" subtitle3=\"Pembayaran 100% aman\" icon4=\"icon-bubbles\" title4=\"Dukungan 24/7\" subtitle4=\"Dukungan khusus\" icon5=\"icon-gift\" title5=\"Layanan hadiah\" subtitle5=\"Dukungan layanan hadiah\" enable_lazy_loading=\"yes\"][/site-features]</div><div>[flash-sale title=\"Penawaran hari ini\" flash_sale_id=\"1\" enable_lazy_loading=\"yes\"][/flash-sale]</div><div>[featured-product-categories title=\"Kategori teratas\" enable_lazy_loading=\"yes\"][/featured-product-categories]</div><div>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[featured-products title=\"Produk unggulan\" enable_lazy_loading=\"yes\"][/featured-products]</div><div>[theme-ads key_1=\"Q9YDUIC9HSWS\" key_2=\"IZ6WU8KUALYE\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[product-collections title=\"Produk eksklusif\" enable_lazy_loading=\"yes\"][/product-collections]</div><div>[product-category-products category_id=\"18\" enable_lazy_loading=\"yes\"][/product-category-products]</div>[testimonials title=\"Apa kata klien kami\" subtitle=\"Ulasan pelanggan\" testimonial_ids=\"1,2,3,4\" enable_lazy_loading=\"yes\"][/testimonials]<div>[download-app title=\"Unduh aplikasi Martfury sekarang!\" subtitle=\"Berbelanja dengan cepat dan mudah dengan aplikasi kami. Dapatkan tautan untuk mengunduh aplikasi di ponsel Anda.\" screenshot=\"general/app.png\" android_app_url=\"https://www.appstore.com\" ios_app_url=\"https://play.google.com/store\" enable_lazy_loading=\"yes\"][/download-app]</div><div>[product-category-products category_id=\"23\" enable_lazy_loading=\"yes\"][/product-category-products]</div><div>[newsletter-form title=\"Bergabunglah dengan buletin kami sekarang\" subtitle=\"Berlangganan untuk mendapatkan informasi tentang produk dan kupon\" enable_lazy_loading=\"yes\"][/newsletter-form]</div>'),('id',2,'Tentang kami',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('id',3,'Syarat penggunaan',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('id',4,'Syarat dan ketentuan',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('id',5,'Kebijakan pengembalian dana',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('id',6,'Blog',NULL,'<p>---</p>'),('id',7,'FAQ',NULL,'<div>[faq title=\"Frequently Asked Questions\"][/faq]</div>'),('id',8,'Kontak',NULL,'<div>[google-map]502 New Street, Brighton VIC, Australia[/google-map]</div><div>[contact-info-boxes title=\"Contact Us For Any Questions\"][/contact-info-boxes]</div><div>[contact-form][/contact-form]</div>'),('id',9,'Kebijakan cookie',NULL,'<h3>EU Cookie Consent</h3><p>To use this Website we are using Cookies and collecting some Data. To be compliant with the EU GDPR we give you to choose if you allow us to use certain Cookies and to collect some Data.</p><h4>Essential Data</h4><p>The Essential Data is needed to run the Site you are visiting technically. You can not deactivate them.</p><p>- Session Cookie: PHP uses a Cookie to identify user sessions. Without this Cookie the Website is not working.</p><p>- XSRF-Token Cookie: Laravel automatically generates a CSRF \"token\" for each active user session managed by the application. This token is used to verify that the authenticated user is the one actually making the requests to the application.</p>'),('id',10,'Afiliasi',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('id',11,'Karir',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('id',12,'Segera hadir',NULL,'<p>Condimentum ipsum a adipiscing hac dolor set consectetur urna commodo elit parturient <br/>molestie ut nisl partu convallier ullamcorpe.</p><div>[coming-soon time=\"2027-02-28 15:15:37\" image=\"general/coming-soon.jpg\"][/coming-soon]</div>'),('tr',1,'Ana Sayfa',NULL,'<div>[simple-slider key=\"home-slider-tr\" ads_1=\"VC2C8Q1UGCBG\" ads_2=\"NBDWRXTSVZ8N\"][/simple-slider]</div><div>[site-features icon1=\"icon-rocket\" title1=\"Ücretsiz teslimat\" subtitle1=\"99 $\'ın üzerindeki tüm siparişler için\" icon2=\"icon-sync\" title2=\"90 gün iade\" subtitle2=\"Ürünlerde sorun varsa\" icon3=\"icon-credit-card\" title3=\"Güvenli ödeme\" subtitle3=\"%100 güvenli ödeme\" icon4=\"icon-bubbles\" title4=\"7/24 destek\" subtitle4=\"Özel destek\" icon5=\"icon-gift\" title5=\"Hediye hizmeti\" subtitle5=\"Hediye hizmeti desteği\" enable_lazy_loading=\"yes\"][/site-features]</div><div>[flash-sale title=\"Günün fırsatı\" flash_sale_id=\"1\" enable_lazy_loading=\"yes\"][/flash-sale]</div><div>[featured-product-categories title=\"En iyi kategoriler\" enable_lazy_loading=\"yes\"][/featured-product-categories]</div><div>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[featured-products title=\"Öne çıkan ürünler\" enable_lazy_loading=\"yes\"][/featured-products]</div><div>[theme-ads key_1=\"Q9YDUIC9HSWS\" key_2=\"IZ6WU8KUALYE\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[product-collections title=\"Özel ürünler\" enable_lazy_loading=\"yes\"][/product-collections]</div><div>[product-category-products category_id=\"18\" enable_lazy_loading=\"yes\"][/product-category-products]</div>[testimonials title=\"Müşterilerimiz ne diyor\" subtitle=\"Müşteri yorumları\" testimonial_ids=\"1,2,3,4\" enable_lazy_loading=\"yes\"][/testimonials]<div>[download-app title=\"Martfury uygulamasını şimdi indirin!\" subtitle=\"Uygulamamızla daha hızlı ve kolay alışveriş yapın. Uygulamayı telefonunuza indirmek için bir bağlantı alın.\" screenshot=\"general/app.png\" android_app_url=\"https://www.appstore.com\" ios_app_url=\"https://play.google.com/store\" enable_lazy_loading=\"yes\"][/download-app]</div><div>[product-category-products category_id=\"23\" enable_lazy_loading=\"yes\"][/product-category-products]</div><div>[newsletter-form title=\"Bültenimize şimdi katılın\" subtitle=\"Ürünler ve kuponlar hakkında bilgi almak için abone olun\" enable_lazy_loading=\"yes\"][/newsletter-form]</div>'),('tr',2,'Hakkımızda',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('tr',3,'Kullanım Şartları',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('tr',4,'Şartlar ve Koşullar',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('tr',5,'İade Politikası',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('tr',6,'Blog',NULL,'<p>---</p>'),('tr',7,'SSS',NULL,'<div>[faq title=\"Frequently Asked Questions\"][/faq]</div>'),('tr',8,'İletişim',NULL,'<div>[google-map]502 New Street, Brighton VIC, Australia[/google-map]</div><div>[contact-info-boxes title=\"Contact Us For Any Questions\"][/contact-info-boxes]</div><div>[contact-form][/contact-form]</div>'),('tr',9,'Çerez Politikası',NULL,'<h3>EU Cookie Consent</h3><p>To use this Website we are using Cookies and collecting some Data. To be compliant with the EU GDPR we give you to choose if you allow us to use certain Cookies and to collect some Data.</p><h4>Essential Data</h4><p>The Essential Data is needed to run the Site you are visiting technically. You can not deactivate them.</p><p>- Session Cookie: PHP uses a Cookie to identify user sessions. Without this Cookie the Website is not working.</p><p>- XSRF-Token Cookie: Laravel automatically generates a CSRF \"token\" for each active user session managed by the application. This token is used to verify that the authenticated user is the one actually making the requests to the application.</p>'),('tr',10,'İş Ortakları',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('tr',11,'Kariyer',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('tr',12,'Yakında',NULL,'<p>Condimentum ipsum a adipiscing hac dolor set consectetur urna commodo elit parturient <br/>molestie ut nisl partu convallier ullamcorpe.</p><div>[coming-soon time=\"2027-02-28 15:15:37\" image=\"general/coming-soon.jpg\"][/coming-soon]</div>'),('vi',1,'Trang chủ',NULL,'<div>[simple-slider key=\"home-slider-vi\" ads_1=\"VC2C8Q1UGCBG\" ads_2=\"NBDWRXTSVZ8N\"][/simple-slider]</div><div>[site-features icon1=\"icon-rocket\" title1=\"Giao hàng miễn phí\" subtitle1=\"Cho tất cả đơn hàng trên 99 đô la\" icon2=\"icon-sync\" title2=\"Đổi trả trong 90 ngày\" subtitle2=\"Nếu hàng hóa có vấn đề\" icon3=\"icon-credit-card\" title3=\"Thanh toán an toàn\" subtitle3=\"Thanh toán an toàn 100%\" icon4=\"icon-bubbles\" title4=\"Hỗ trợ 24/7\" subtitle4=\"Hỗ trợ tận tâm\" icon5=\"icon-gift\" title5=\"Dịch vụ quà tặng\" subtitle5=\"Hỗ trợ dịch vụ quà tặng\" enable_lazy_loading=\"yes\"][/site-features]</div><div>[flash-sale title=\"Ưu đãi trong ngày\" flash_sale_id=\"1\" enable_lazy_loading=\"yes\"][/flash-sale]</div><div>[featured-product-categories title=\"Danh mục hàng đầu\" enable_lazy_loading=\"yes\"][/featured-product-categories]</div><div>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[featured-products title=\"Sản phẩm nổi bật\" enable_lazy_loading=\"yes\"][/featured-products]</div><div>[theme-ads key_1=\"Q9YDUIC9HSWS\" key_2=\"IZ6WU8KUALYE\" enable_lazy_loading=\"yes\"][/theme-ads]</div><div>[product-collections title=\"Sản phẩm độc quyền\" enable_lazy_loading=\"yes\"][/product-collections]</div><div>[product-category-products category_id=\"18\" enable_lazy_loading=\"yes\"][/product-category-products]</div>[testimonials title=\"Khách hàng nói gì về chúng tôi\" subtitle=\"Đánh giá của khách hàng\" testimonial_ids=\"1,2,3,4\" enable_lazy_loading=\"yes\"][/testimonials]<div>[download-app title=\"Tải ứng dụng Martfury ngay bây giờ!\" subtitle=\"Mua sắm nhanh chóng và dễ dàng hơn với ứng dụng của chúng tôi. Nhận liên kết để tải ứng dụng trên điện thoại của bạn.\" screenshot=\"general/app.png\" android_app_url=\"https://www.appstore.com\" ios_app_url=\"https://play.google.com/store\" enable_lazy_loading=\"yes\"][/download-app]</div><div>[product-category-products category_id=\"23\" enable_lazy_loading=\"yes\"][/product-category-products]</div><div>[newsletter-form title=\"Tham gia bản tin của chúng tôi ngay bây giờ\" subtitle=\"Đăng ký để nhận thông tin về sản phẩm và phiếu giảm giá\" enable_lazy_loading=\"yes\"][/newsletter-form]</div>'),('vi',2,'Về chúng tôi',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('vi',3,'Điều khoản sử dụng',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('vi',4,'Điều khoản và điều kiện',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('vi',5,'Chính sách hoàn tiền',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('vi',6,'Tin tức',NULL,'<p>---</p>'),('vi',7,'Câu hỏi thường gặp',NULL,'<div>[faq title=\"Frequently Asked Questions\"][/faq]</div>'),('vi',8,'Liên hệ',NULL,'<div>[google-map]502 New Street, Brighton VIC, Australia[/google-map]</div><div>[contact-info-boxes title=\"Contact Us For Any Questions\"][/contact-info-boxes]</div><div>[contact-form][/contact-form]</div>'),('vi',9,'Chính sách cookie',NULL,'<h3>EU Cookie Consent</h3><p>To use this Website we are using Cookies and collecting some Data. To be compliant with the EU GDPR we give you to choose if you allow us to use certain Cookies and to collect some Data.</p><h4>Essential Data</h4><p>The Essential Data is needed to run the Site you are visiting technically. You can not deactivate them.</p><p>- Session Cookie: PHP uses a Cookie to identify user sessions. Without this Cookie the Website is not working.</p><p>- XSRF-Token Cookie: Laravel automatically generates a CSRF \"token\" for each active user session managed by the application. This token is used to verify that the authenticated user is the one actually making the requests to the application.</p>'),('vi',10,'Đối tác',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('vi',11,'Tuyển dụng',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'),('vi',12,'Sắp ra mắt',NULL,'<p>Condimentum ipsum a adipiscing hac dolor set consectetur urna commodo elit parturient <br/>molestie ut nisl partu convallier ullamcorpe.</p><div>[coming-soon time=\"2027-02-28 15:15:37\" image=\"general/coming-soon.jpg\"][/coming-soon]</div>');
/*!40000 ALTER TABLE `pages_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_logs`
--

DROP TABLE IF EXISTS `payment_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `request` longtext COLLATE utf8mb4_unicode_ci,
  `response` longtext COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_logs`
--

LOCK TABLES `payment_logs` WRITE;
/*!40000 ALTER TABLE `payment_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `currency` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  `charge_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_channel` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(15,2) unsigned NOT NULL,
  `payment_fee` decimal(15,2) DEFAULT '0.00',
  `order_id` bigint unsigned DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `payment_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'confirm',
  `customer_id` bigint unsigned DEFAULT NULL,
  `refunded_amount` decimal(15,2) unsigned DEFAULT NULL,
  `refund_note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_categories`
--

DROP TABLE IF EXISTS `post_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_categories` (
  `category_id` bigint unsigned NOT NULL,
  `post_id` bigint unsigned NOT NULL,
  KEY `post_categories_category_id_index` (`category_id`),
  KEY `post_categories_post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_categories`
--

LOCK TABLES `post_categories` WRITE;
/*!40000 ALTER TABLE `post_categories` DISABLE KEYS */;
INSERT INTO `post_categories` VALUES (2,1),(4,1),(1,2),(4,2),(2,3),(3,3),(1,4),(3,4),(2,5),(3,5),(1,6),(4,6),(1,7),(4,7),(1,8),(3,8),(1,9),(3,9),(1,10),(3,10),(1,11),(4,11);
/*!40000 ALTER TABLE `post_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_tags`
--

DROP TABLE IF EXISTS `post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_tags` (
  `tag_id` bigint unsigned NOT NULL,
  `post_id` bigint unsigned NOT NULL,
  KEY `post_tags_tag_id_index` (`tag_id`),
  KEY `post_tags_post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_tags`
--

LOCK TABLES `post_tags` WRITE;
/*!40000 ALTER TABLE `post_tags` DISABLE KEYS */;
INSERT INTO `post_tags` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(1,2),(2,2),(3,2),(4,2),(5,2),(1,3),(2,3),(3,3),(4,3),(5,3),(1,4),(2,4),(3,4),(4,4),(5,4),(1,5),(2,5),(3,5),(4,5),(5,5),(1,6),(2,6),(3,6),(4,6),(5,6),(1,7),(2,7),(3,7),(4,7),(5,7),(1,8),(2,8),(3,8),(4,8),(5,8),(1,9),(2,9),(3,9),(4,9),(5,9),(1,10),(2,10),(3,10),(4,10),(5,10),(1,11),(2,11),(3,11),(4,11),(5,11);
/*!40000 ALTER TABLE `post_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `author_id` bigint unsigned DEFAULT NULL,
  `author_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_featured` tinyint unsigned NOT NULL DEFAULT '0',
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `views` int unsigned NOT NULL DEFAULT '0',
  `format_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_status_index` (`status`),
  KEY `posts_author_id_index` (`author_id`),
  KEY `posts_author_type_index` (`author_type`),
  KEY `posts_created_at_index` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'4 Expert Tips On How To Choose The Right Men’s Wallet','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/1.jpg',2423,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(2,'Sexy Clutches: How to Buy &amp; Wear a Designer Clutch Bag','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/2.jpg',1168,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(3,'The Top 2020 Handbag Trends to Know','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/3.jpg',616,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(4,'How to Match the Color of Your Handbag With an Outfit','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/4.jpg',602,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(5,'How to Care for Leather Bags','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/5.jpg',357,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(6,'We\'re Crushing Hard on Summer\'s 10 Biggest Bag Trends','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/6.jpg',1013,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(7,'Essential Qualities of Highly Successful Music','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/7.jpg',975,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(8,'9 Things I Love About Shaving My Head','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/8.jpg',1595,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(9,'Why Teamwork Really Makes The Dream Work','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/9.jpg',478,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(10,'The World Caters to Average People','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',1,'news/10.jpg',1496,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36'),(11,'The litigants on the screen are not actors','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all of the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all of the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" height=\"375\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" height=\"400\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',1,'Botble\\ACL\\Models\\User',0,'news/11.jpg',1368,NULL,'2026-02-28 08:15:36','2026-02-28 08:15:36');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_translations`
--

DROP TABLE IF EXISTS `posts_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `posts_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`lang_code`,`posts_id`),
  KEY `idx_posts_trans_posts_id` (`posts_id`),
  KEY `idx_posts_trans_post_lang` (`posts_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_translations`
--

LOCK TABLES `posts_translations` WRITE;
/*!40000 ALTER TABLE `posts_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_recipients`
--

DROP TABLE IF EXISTS `push_notification_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_notification_recipients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `push_notification_id` bigint unsigned NOT NULL,
  `user_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `device_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `platform` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sent',
  `sent_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `clicked_at` timestamp NULL DEFAULT NULL,
  `fcm_response` json DEFAULT NULL,
  `error_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pnr_notification_user_index` (`push_notification_id`,`user_type`,`user_id`),
  KEY `pnr_user_status_index` (`user_type`,`user_id`,`status`),
  KEY `pnr_user_read_index` (`user_type`,`user_id`,`read_at`),
  KEY `pnr_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_recipients`
--

LOCK TABLES `push_notification_recipients` WRITE;
/*!40000 ALTER TABLE `push_notification_recipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notifications`
--

DROP TABLE IF EXISTS `push_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `target_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` json DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sent',
  `sent_count` int NOT NULL DEFAULT '0',
  `failed_count` int NOT NULL DEFAULT '0',
  `delivered_count` int NOT NULL DEFAULT '0',
  `read_count` int NOT NULL DEFAULT '0',
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `push_notifications_type_created_at_index` (`type`,`created_at`),
  KEY `push_notifications_status_scheduled_at_index` (`status`,`scheduled_at`),
  KEY `push_notifications_created_by_index` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notifications`
--

LOCK TABLES `push_notifications` WRITE;
/*!40000 ALTER TABLE `push_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revisions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `revisionable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revisionable_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `key` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_value` text COLLATE utf8mb4_unicode_ci,
  `new_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revisions_revisionable_id_revisionable_type_index` (`revisionable_id`,`revisionable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_users`
--

DROP TABLE IF EXISTS `role_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_users` (
  `user_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_users_user_id_index` (`user_id`),
  KEY `role_users_role_id_index` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_users`
--

LOCK TABLES `role_users` WRITE;
/*!40000 ALTER TABLE `role_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint unsigned NOT NULL DEFAULT '0',
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`),
  KEY `roles_created_by_index` (`created_by`),
  KEY `roles_updated_by_index` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Admin','{\"users.index\":true,\"users.create\":true,\"users.edit\":true,\"users.destroy\":true,\"roles.index\":true,\"roles.create\":true,\"roles.edit\":true,\"roles.destroy\":true,\"core.system\":true,\"core.cms\":true,\"core.manage.license\":true,\"systems.cronjob\":true,\"core.tools\":true,\"tools.data-synchronize\":true,\"media.index\":true,\"files.index\":true,\"files.create\":true,\"files.edit\":true,\"files.trash\":true,\"files.destroy\":true,\"folders.index\":true,\"folders.create\":true,\"folders.edit\":true,\"folders.trash\":true,\"folders.destroy\":true,\"settings.index\":true,\"settings.common\":true,\"settings.options\":true,\"settings.email\":true,\"settings.media\":true,\"settings.admin-appearance\":true,\"settings.cache\":true,\"settings.datatables\":true,\"settings.email.rules\":true,\"settings.phone-number\":true,\"settings.others\":true,\"menus.index\":true,\"menus.create\":true,\"menus.edit\":true,\"menus.destroy\":true,\"optimize.settings\":true,\"pages.index\":true,\"pages.create\":true,\"pages.edit\":true,\"pages.destroy\":true,\"plugins.index\":true,\"plugins.edit\":true,\"plugins.remove\":true,\"plugins.marketplace\":true,\"sitemap.settings\":true,\"core.appearance\":true,\"theme.index\":true,\"theme.activate\":true,\"theme.remove\":true,\"theme.options\":true,\"theme.custom-css\":true,\"theme.custom-js\":true,\"theme.custom-html\":true,\"theme.robots-txt\":true,\"settings.website-tracking\":true,\"widgets.index\":true,\"ads.index\":true,\"ads.create\":true,\"ads.edit\":true,\"ads.destroy\":true,\"ads.settings\":true,\"analytics.general\":true,\"analytics.page\":true,\"analytics.browser\":true,\"analytics.referrer\":true,\"analytics.settings\":true,\"audit-log.index\":true,\"audit-log.destroy\":true,\"backups.index\":true,\"backups.create\":true,\"backups.restore\":true,\"backups.destroy\":true,\"plugins.blog\":true,\"posts.index\":true,\"posts.create\":true,\"posts.edit\":true,\"posts.destroy\":true,\"categories.index\":true,\"categories.create\":true,\"categories.edit\":true,\"categories.destroy\":true,\"tags.index\":true,\"blog.reports\":true,\"tags.create\":true,\"tags.edit\":true,\"tags.destroy\":true,\"blog.settings\":true,\"posts.export\":true,\"posts.import\":true,\"captcha.settings\":true,\"contacts.index\":true,\"contacts.edit\":true,\"contacts.destroy\":true,\"contact.custom-fields\":true,\"contact.settings\":true,\"plugins.ecommerce\":true,\"ecommerce.report.index\":true,\"products.index\":true,\"products.create\":true,\"products.edit\":true,\"products.destroy\":true,\"products.duplicate\":true,\"ecommerce.product-prices.index\":true,\"ecommerce.product-prices.edit\":true,\"ecommerce.product-inventory.index\":true,\"ecommerce.product-inventory.edit\":true,\"product-categories.index\":true,\"product-categories.create\":true,\"product-categories.edit\":true,\"product-categories.destroy\":true,\"product-tag.index\":true,\"product-tag.create\":true,\"product-tag.edit\":true,\"product-tag.destroy\":true,\"brands.index\":true,\"brands.create\":true,\"brands.edit\":true,\"brands.destroy\":true,\"product-collections.index\":true,\"product-collections.create\":true,\"product-collections.edit\":true,\"product-collections.destroy\":true,\"product-attribute-sets.index\":true,\"product-attribute-sets.create\":true,\"product-attribute-sets.edit\":true,\"product-attribute-sets.destroy\":true,\"product-attributes.index\":true,\"product-attributes.create\":true,\"product-attributes.edit\":true,\"product-attributes.destroy\":true,\"tax.index\":true,\"tax.create\":true,\"tax.edit\":true,\"tax.destroy\":true,\"reviews.index\":true,\"reviews.create\":true,\"reviews.destroy\":true,\"reviews.publish\":true,\"reviews.reply\":true,\"ecommerce.shipments.index\":true,\"ecommerce.shipments.create\":true,\"ecommerce.shipments.edit\":true,\"ecommerce.shipments.destroy\":true,\"orders.index\":true,\"orders.create\":true,\"orders.edit\":true,\"orders.destroy\":true,\"discounts.index\":true,\"discounts.create\":true,\"discounts.edit\":true,\"discounts.destroy\":true,\"customers.index\":true,\"customers.create\":true,\"customers.edit\":true,\"customers.destroy\":true,\"ecommerce.customers.import\":true,\"ecommerce.customers.export\":true,\"ecommerce.customer-carts.index\":true,\"ecommerce.customer-carts.destroy\":true,\"flash-sale.index\":true,\"flash-sale.create\":true,\"flash-sale.edit\":true,\"flash-sale.destroy\":true,\"product-label.index\":true,\"product-label.create\":true,\"product-label.edit\":true,\"product-label.destroy\":true,\"ecommerce.import.products.index\":true,\"ecommerce.export.products.index\":true,\"order_returns.index\":true,\"order_returns.edit\":true,\"order_returns.destroy\":true,\"global-option.index\":true,\"global-option.create\":true,\"global-option.edit\":true,\"global-option.destroy\":true,\"ecommerce.invoice.index\":true,\"ecommerce.invoice.edit\":true,\"ecommerce.invoice.destroy\":true,\"ecommerce.settings\":true,\"ecommerce.settings.general\":true,\"ecommerce.invoice-template.index\":true,\"ecommerce.settings.currencies\":true,\"ecommerce.settings.products\":true,\"ecommerce.settings.product-search\":true,\"ecommerce.settings.digital-products\":true,\"ecommerce.settings.store-locators\":true,\"ecommerce.settings.invoices\":true,\"ecommerce.settings.product-reviews\":true,\"ecommerce.settings.customers\":true,\"ecommerce.settings.shopping\":true,\"ecommerce.settings.taxes\":true,\"ecommerce.settings.shipping\":true,\"ecommerce.shipping-rule-items.index\":true,\"ecommerce.shipping-rule-items.create\":true,\"ecommerce.shipping-rule-items.edit\":true,\"ecommerce.shipping-rule-items.destroy\":true,\"ecommerce.shipping-rule-items.bulk-import\":true,\"ecommerce.settings.tracking\":true,\"ecommerce.settings.standard-and-format\":true,\"ecommerce.settings.checkout\":true,\"ecommerce.settings.return\":true,\"ecommerce.settings.flash-sale\":true,\"ecommerce.settings.product-specification\":true,\"product-categories.export\":true,\"product-categories.import\":true,\"product-license-codes.import\":true,\"orders.export\":true,\"ecommerce.product-specification.index\":true,\"ecommerce.specification-groups.index\":true,\"ecommerce.specification-groups.create\":true,\"ecommerce.specification-groups.edit\":true,\"ecommerce.specification-groups.destroy\":true,\"ecommerce.specification-attributes.index\":true,\"ecommerce.specification-attributes.create\":true,\"ecommerce.specification-attributes.edit\":true,\"ecommerce.specification-attributes.destroy\":true,\"ecommerce.specification-tables.index\":true,\"ecommerce.specification-tables.create\":true,\"ecommerce.specification-tables.edit\":true,\"ecommerce.specification-tables.destroy\":true,\"ecommerce.product-specifications.import\":true,\"ecommerce.product-specifications.export\":true,\"plugin.faq\":true,\"faq.index\":true,\"faq.create\":true,\"faq.edit\":true,\"faq.destroy\":true,\"faq_category.index\":true,\"faq_category.create\":true,\"faq_category.edit\":true,\"faq_category.destroy\":true,\"faqs.settings\":true,\"languages.index\":true,\"languages.create\":true,\"languages.edit\":true,\"languages.destroy\":true,\"translations.import\":true,\"translations.export\":true,\"property-translations.import\":true,\"property-translations.export\":true,\"plugin.location\":true,\"country.index\":true,\"country.create\":true,\"country.edit\":true,\"country.destroy\":true,\"state.index\":true,\"state.create\":true,\"state.edit\":true,\"state.destroy\":true,\"city.index\":true,\"city.create\":true,\"city.edit\":true,\"city.destroy\":true,\"marketplace.index\":true,\"marketplace.store.index\":true,\"marketplace.store.create\":true,\"marketplace.store.edit\":true,\"marketplace.store.destroy\":true,\"marketplace.store.view\":true,\"marketplace.store.revenue.create\":true,\"marketplace.withdrawal.index\":true,\"marketplace.withdrawal.edit\":true,\"marketplace.withdrawal.destroy\":true,\"marketplace.withdrawal.invoice\":true,\"marketplace.vendors.index\":true,\"marketplace.unverified-vendors.index\":true,\"marketplace.vendors.control\":true,\"marketplace.unverified-vendors.edit\":true,\"marketplace.reports\":true,\"marketplace.settings\":true,\"marketplace.messages.index\":true,\"marketplace.messages.edit\":true,\"marketplace.messages.destroy\":true,\"newsletter.index\":true,\"newsletter.destroy\":true,\"newsletter.settings\":true,\"payment.index\":true,\"payments.settings\":true,\"payment.destroy\":true,\"payments.logs\":true,\"payments.logs.show\":true,\"payments.logs.destroy\":true,\"simple-slider.index\":true,\"simple-slider.create\":true,\"simple-slider.edit\":true,\"simple-slider.destroy\":true,\"simple-slider-item.index\":true,\"simple-slider-item.create\":true,\"simple-slider-item.edit\":true,\"simple-slider-item.destroy\":true,\"social-login.settings\":true,\"testimonial.index\":true,\"testimonial.create\":true,\"testimonial.edit\":true,\"testimonial.destroy\":true,\"plugins.translation\":true,\"translations.locales\":true,\"translations.theme-translations\":true,\"translations.index\":true,\"theme-translations.export\":true,\"other-translations.export\":true,\"theme-translations.import\":true,\"other-translations.import\":true,\"api.settings\":true,\"api.sanctum-token.index\":true,\"api.sanctum-token.create\":true,\"api.sanctum-token.destroy\":true}','Admin users role',1,1,1,'2026-02-28 08:15:35','2026-02-28 08:15:35');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'media_random_hash','6c1b8fa262ab322c87cd44fc0fe1e931',NULL,'2026-02-28 08:15:45'),(2,'api_enabled','0',NULL,'2026-02-28 08:15:45'),(3,'activated_plugins','[\"language\",\"language-advanced\",\"ads\",\"analytics\",\"audit-log\",\"backup\",\"blog\",\"captcha\",\"contact\",\"cookie-consent\",\"ecommerce\",\"faq\",\"location\",\"marketplace\",\"mollie\",\"newsletter\",\"payment\",\"paypal\",\"paypal-payout\",\"paystack\",\"razorpay\",\"shippo\",\"simple-slider\",\"social-login\",\"sslcommerz\",\"stripe\",\"stripe-connect\",\"testimonial\",\"translation\"]',NULL,'2026-02-28 08:15:45'),(4,'analytics_dashboard_widgets','0','2026-02-28 08:15:06','2026-02-28 08:15:06'),(5,'enable_recaptcha_botble_contact_forms_fronts_contact_form','1','2026-02-28 08:15:06','2026-02-28 08:15:06'),(6,'api_layer_api_key','',NULL,'2026-02-28 08:15:45'),(9,'enable_recaptcha_botble_newsletter_forms_fronts_newsletter_form','1','2026-02-28 08:15:10','2026-02-28 08:15:10'),(10,'payment_cod_fee_type','fixed',NULL,'2026-02-28 08:15:45'),(11,'payment_bank_transfer_fee_type','fixed',NULL,'2026-02-28 08:15:45'),(12,'theme','martfury',NULL,'2026-02-28 08:15:45'),(13,'show_admin_bar','1',NULL,'2026-02-28 08:15:45'),(14,'language_hide_default','1',NULL,'2026-02-28 08:15:45'),(15,'language_switcher_display','dropdown',NULL,'2026-02-28 08:15:45'),(16,'language_display','all',NULL,'2026-02-28 08:15:45'),(17,'language_hide_languages','[]',NULL,'2026-02-28 08:15:45'),(18,'simple_slider_using_assets','0',NULL,NULL),(19,'admin_favicon','general/favicon.png',NULL,'2026-02-28 08:15:45'),(20,'admin_logo','general/logo-light.png',NULL,'2026-02-28 08:15:45'),(21,'payment_cod_status','1',NULL,'2026-02-28 08:15:45'),(22,'payment_bank_transfer_status','1',NULL,'2026-02-28 08:15:45'),(23,'payment_cod_description','Please pay money directly to the postman, if you choose cash on delivery method (COD).',NULL,'2026-02-28 08:15:45'),(24,'payment_bank_transfer_description','Please send money to our bank account: ACB - 69270 213 19.',NULL,'2026-02-28 08:15:45'),(25,'payment_stripe_payment_type','stripe_checkout',NULL,'2026-02-28 08:15:45'),(26,'plugins_ecommerce_customer_new_order_status','0',NULL,'2026-02-28 08:15:45'),(27,'plugins_ecommerce_admin_new_order_status','0',NULL,'2026-02-28 08:15:45'),(28,'ecommerce_is_enabled_support_digital_products','1',NULL,'2026-02-28 08:15:45'),(29,'ecommerce_enable_license_codes_for_digital_products','1',NULL,'2026-02-28 08:15:45'),(30,'ecommerce_auto_complete_digital_orders_after_payment','1',NULL,'2026-02-28 08:15:45'),(31,'ecommerce_load_countries_states_cities_from_location_plugin','0',NULL,'2026-02-28 08:15:45'),(32,'ecommerce_product_sku_format','SF-2443-%s%s%s%s',NULL,'2026-02-28 08:15:45'),(33,'ecommerce_store_order_prefix','SF',NULL,'2026-02-28 08:15:45'),(34,'ecommerce_enable_product_specification','1',NULL,'2026-02-28 08:15:45'),(35,'payment_bank_transfer_display_bank_info_at_the_checkout_success_page','1',NULL,'2026-02-28 08:15:45'),(36,'payment_cod_logo','payments/cod.png',NULL,'2026-02-28 08:15:45'),(37,'payment_bank_transfer_logo','payments/bank-transfer.png',NULL,'2026-02-28 08:15:45'),(38,'payment_stripe_logo','payments/stripe.webp',NULL,'2026-02-28 08:15:45'),(39,'payment_paypal_logo','payments/paypal.png',NULL,'2026-02-28 08:15:45'),(40,'payment_mollie_logo','payments/mollie.png',NULL,'2026-02-28 08:15:45'),(41,'payment_paystack_logo','payments/paystack.png',NULL,'2026-02-28 08:15:45'),(42,'payment_razorpay_logo','payments/razorpay.png',NULL,'2026-02-28 08:15:45'),(43,'payment_sslcommerz_logo','payments/sslcommerz.png',NULL,'2026-02-28 08:15:45'),(44,'permalink-botble-blog-models-post','blog',NULL,'2026-02-28 08:15:45'),(45,'permalink-botble-blog-models-category','blog',NULL,'2026-02-28 08:15:45'),(46,'ecommerce_store_name','Martfury',NULL,NULL),(47,'ecommerce_store_phone','1800979769',NULL,NULL),(48,'ecommerce_store_address','502 New Street',NULL,NULL),(49,'ecommerce_store_state','Brighton VIC',NULL,NULL),(50,'ecommerce_store_city','Brighton VIC',NULL,NULL),(51,'ecommerce_store_country','AU',NULL,NULL),(52,'theme-martfury-site_title','MartFury - Laravel Ecommerce system',NULL,'2026-02-28 08:15:45'),(53,'theme-martfury-seo_description','MartFury is a clean & modern Laravel Ecommerce System for multipurpose online stores. With design clean and trendy, MartFury will make your online store look more impressive and attractive to viewers.',NULL,'2026-02-28 08:15:45'),(54,'theme-martfury-copyright','© %Y MartFury. All Rights Reserved.',NULL,'2026-02-28 08:15:45'),(55,'theme-martfury-favicon','general/favicon.png',NULL,'2026-02-28 08:15:45'),(56,'theme-martfury-logo','general/logo.png',NULL,'2026-02-28 08:15:45'),(57,'theme-martfury-welcome_message','Welcome to MartFury Online Shopping Store!',NULL,'2026-02-28 08:15:45'),(58,'theme-martfury-address','502 New Street, Brighton VIC, Australia',NULL,'2026-02-28 08:15:45'),(59,'theme-martfury-hotline','1800 97 97 69',NULL,'2026-02-28 08:15:45'),(60,'theme-martfury-email','contact@martfury.co',NULL,'2026-02-28 08:15:45'),(61,'theme-martfury-newsletter_image','general/newsletter.jpg',NULL,'2026-02-28 08:15:45'),(62,'theme-martfury-homepage_id','1',NULL,'2026-02-28 08:15:45'),(63,'theme-martfury-blog_page_id','6',NULL,'2026-02-28 08:15:45'),(64,'theme-martfury-cookie_consent_message','Your experience on this site will be improved by allowing cookies ',NULL,'2026-02-28 08:15:45'),(65,'theme-martfury-cookie_consent_learn_more_url','/cookie-policy',NULL,'2026-02-28 08:15:45'),(66,'theme-martfury-cookie_consent_learn_more_text','Cookie Policy',NULL,'2026-02-28 08:15:45'),(67,'theme-martfury-number_of_products_per_page','42',NULL,'2026-02-28 08:15:45'),(68,'theme-martfury-product_feature_1_title','Shipping worldwide',NULL,'2026-02-28 08:15:45'),(69,'theme-martfury-product_feature_1_icon','icon-network',NULL,'2026-02-28 08:15:45'),(70,'theme-martfury-product_feature_2_title','Free 7-day return if eligible, so easy',NULL,'2026-02-28 08:15:45'),(71,'theme-martfury-product_feature_2_icon','icon-3d-rotate',NULL,'2026-02-28 08:15:45'),(72,'theme-martfury-product_feature_3_title','Supplier give bills for this product.',NULL,'2026-02-28 08:15:45'),(73,'theme-martfury-product_feature_3_icon','icon-receipt',NULL,'2026-02-28 08:15:45'),(74,'theme-martfury-product_feature_4_title','Pay online or when receiving goods',NULL,'2026-02-28 08:15:45'),(75,'theme-martfury-product_feature_4_icon','icon-credit-card',NULL,'2026-02-28 08:15:45'),(76,'theme-martfury-contact_info_box_1_title','Contact Directly',NULL,'2026-02-28 08:15:45'),(77,'theme-martfury-contact_info_box_1_subtitle','contact@martfury.com',NULL,'2026-02-28 08:15:45'),(78,'theme-martfury-contact_info_box_1_details','(+004) 912-3548-07',NULL,'2026-02-28 08:15:45'),(79,'theme-martfury-contact_info_box_2_title','Headquarters',NULL,'2026-02-28 08:15:45'),(80,'theme-martfury-contact_info_box_2_subtitle','17 Queen St, South bank, Melbourne 10560, Australia',NULL,'2026-02-28 08:15:45'),(81,'theme-martfury-contact_info_box_2_details','',NULL,'2026-02-28 08:15:45'),(82,'theme-martfury-contact_info_box_3_title','Work With Us',NULL,'2026-02-28 08:15:45'),(83,'theme-martfury-contact_info_box_3_subtitle','Send your CV to our email:',NULL,'2026-02-28 08:15:45'),(84,'theme-martfury-contact_info_box_3_details','career@martfury.com',NULL,'2026-02-28 08:15:45'),(85,'theme-martfury-contact_info_box_4_title','Customer Service',NULL,'2026-02-28 08:15:45'),(86,'theme-martfury-contact_info_box_4_subtitle','customercare@martfury.com',NULL,'2026-02-28 08:15:45'),(87,'theme-martfury-contact_info_box_4_details','(800) 843-2446',NULL,'2026-02-28 08:15:45'),(88,'theme-martfury-contact_info_box_5_title','Media Relations',NULL,'2026-02-28 08:15:45'),(89,'theme-martfury-contact_info_box_5_subtitle','media@martfury.com',NULL,'2026-02-28 08:15:45'),(90,'theme-martfury-contact_info_box_5_details','(801) 947-3564',NULL,'2026-02-28 08:15:45'),(91,'theme-martfury-contact_info_box_6_title','Vendor Support',NULL,'2026-02-28 08:15:45'),(92,'theme-martfury-contact_info_box_6_subtitle','vendorsupport@martfury.com',NULL,'2026-02-28 08:15:45'),(93,'theme-martfury-contact_info_box_6_details','(801) 947-3100',NULL,'2026-02-28 08:15:45'),(94,'theme-martfury-number_of_cross_sale_product','7',NULL,'2026-02-28 08:15:45'),(95,'theme-martfury-logo_in_the_checkout_page','general/logo-dark.png',NULL,'2026-02-28 08:15:45'),(96,'theme-martfury-logo_in_invoices','general/logo-dark.png',NULL,'2026-02-28 08:15:45'),(97,'theme-martfury-logo_vendor_dashboard','general/logo-dark.png',NULL,'2026-02-28 08:15:45'),(98,'theme-martfury-primary_font','Work Sans',NULL,'2026-02-28 08:15:45'),(99,'theme-martfury-payment_methods','[\"general\\/payment-method-1.jpg\",\"general\\/payment-method-2.jpg\",\"general\\/payment-method-3.jpg\",\"general\\/payment-method-4.jpg\",\"general\\/payment-method-5.jpg\"]',NULL,'2026-02-28 08:15:45'),(100,'theme-martfury-social_links','[[{\"key\":\"name\",\"value\":\"Facebook\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-facebook\"},{\"key\":\"url\",\"value\":\"https:\\/\\/www.facebook.com\"}],[{\"key\":\"name\",\"value\":\"X (Twitter)\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-x\"},{\"key\":\"url\",\"value\":\"https:\\/\\/x.com\"}],[{\"key\":\"name\",\"value\":\"YouTube\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-youtube\"},{\"key\":\"url\",\"value\":\"https:\\/\\/www.youtube.com\"}],[{\"key\":\"name\",\"value\":\"Instagram\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-linkedin\"},{\"key\":\"url\",\"value\":\"https:\\/\\/www.linkedin.com\"}]]',NULL,'2026-02-28 08:15:45'),(101,'theme-martfury-social_sharing','[[{\"key\":\"social\",\"value\":\"facebook\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-facebook\"}],[{\"key\":\"social\",\"value\":\"x\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-x\"}],[{\"key\":\"social\",\"value\":\"pinterest\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-pinterest\"}],[{\"key\":\"social\",\"value\":\"linkedin\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-linkedin\"}],[{\"key\":\"social\",\"value\":\"whatsapp\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-whatsapp\"}],[{\"key\":\"social\",\"value\":\"email\"},{\"key\":\"icon\",\"value\":\"ti ti-mail\"}]]',NULL,'2026-02-28 08:15:45'),(102,'theme-martfury-lazy_load_images','1',NULL,'2026-02-28 08:15:45'),(103,'theme-martfury-lazy_load_placeholder_image','general/placeholder.png',NULL,'2026-02-28 08:15:45'),(104,'theme-martfury-ar-site_title','مارت فيوري - التسوق عبر الإنترنت',NULL,NULL),(105,'theme-martfury-ar-seo_description','تسوق عبر الإنترنت للإلكترونيات والأزياء والأجهزة المنزلية والمزيد. أفضل الأسعار وشحن سريع وخدمة عملاء ممتازة.',NULL,NULL),(106,'theme-martfury-ar-copyright','© %Y مارت فيوري. جميع الحقوق محفوظة.',NULL,NULL),(107,'theme-martfury-ar-welcome_message','مرحباً بك في مارت فيوري!',NULL,NULL),(108,'theme-martfury-ar-address','502 New Street, Brighton VIC, Australia',NULL,NULL),(109,'theme-martfury-ar-cookie_consent_message','تجربتك على هذا الموقع ستتحسن باستخدام ملفات تعريف الارتباط.',NULL,NULL),(110,'theme-martfury-ar-cookie_consent_learn_more_text','سياسة ملفات تعريف الارتباط',NULL,NULL),(111,'theme-martfury-ar-product_feature_1_title','شحن في جميع أنحاء العالم',NULL,NULL),(112,'theme-martfury-ar-product_feature_2_title','إرجاع مجاني لمدة 7 أيام',NULL,NULL),(113,'theme-martfury-ar-product_feature_3_title','يقدم المورد الفواتير',NULL,NULL),(114,'theme-martfury-ar-product_feature_4_title','الدفع عبر الإنترنت أو عند الاستلام',NULL,NULL),(115,'theme-martfury-ar-contact_info_box_1_title','اتصل مباشرة',NULL,NULL),(116,'theme-martfury-ar-contact_info_box_1_subtitle','contact@martfury.com',NULL,NULL),(117,'theme-martfury-ar-contact_info_box_1_details','(+004) 912-3548-07',NULL,NULL),(118,'theme-martfury-ar-contact_info_box_2_title','المقر الرئيسي',NULL,NULL),(119,'theme-martfury-ar-contact_info_box_2_subtitle','17 Queen St, Melbourne VIC 3000, Australia',NULL,NULL),(120,'theme-martfury-ar-contact_info_box_3_title','اعمل معنا',NULL,NULL),(121,'theme-martfury-ar-contact_info_box_3_subtitle','أرسل سيرتك الذاتية إلى بريدنا الإلكتروني',NULL,NULL),(122,'theme-martfury-ar-contact_info_box_4_title','خدمة العملاء',NULL,NULL),(123,'theme-martfury-ar-contact_info_box_5_title','العلاقات الإعلامية',NULL,NULL),(124,'theme-martfury-ar-contact_info_box_6_title','دعم البائعين',NULL,NULL),(125,'theme-martfury-vi-site_title','MartFury - Mua sắm trực tuyến',NULL,NULL),(126,'theme-martfury-vi-seo_description','Mua sắm trực tuyến điện tử, thời trang, đồ gia dụng và nhiều hơn nữa. Giá tốt nhất, vận chuyển nhanh và dịch vụ khách hàng xuất sắc.',NULL,NULL),(127,'theme-martfury-vi-copyright','© %Y MartFury. Bảo lưu mọi quyền.',NULL,NULL),(128,'theme-martfury-vi-welcome_message','Chào mừng đến với MartFury!',NULL,NULL),(129,'theme-martfury-vi-address','502 New Street, Brighton VIC, Australia',NULL,NULL),(130,'theme-martfury-vi-cookie_consent_message','Trải nghiệm của bạn trên trang web này sẽ được cải thiện bằng cách cho phép cookie.',NULL,NULL),(131,'theme-martfury-vi-cookie_consent_learn_more_text','Chính sách cookie',NULL,NULL),(132,'theme-martfury-vi-product_feature_1_title','Vận chuyển toàn cầu',NULL,NULL),(133,'theme-martfury-vi-product_feature_2_title','Hoàn trả miễn phí trong 7 ngày',NULL,NULL),(134,'theme-martfury-vi-product_feature_3_title','Nhà cung cấp cung cấp hóa đơn',NULL,NULL),(135,'theme-martfury-vi-product_feature_4_title','Thanh toán trực tuyến hoặc khi nhận hàng',NULL,NULL),(136,'theme-martfury-vi-contact_info_box_1_title','Liên hệ trực tiếp',NULL,NULL),(137,'theme-martfury-vi-contact_info_box_1_subtitle','contact@martfury.com',NULL,NULL),(138,'theme-martfury-vi-contact_info_box_1_details','(+004) 912-3548-07',NULL,NULL),(139,'theme-martfury-vi-contact_info_box_2_title','Trụ sở chính',NULL,NULL),(140,'theme-martfury-vi-contact_info_box_2_subtitle','17 Queen St, Melbourne VIC 3000, Australia',NULL,NULL),(141,'theme-martfury-vi-contact_info_box_3_title','Làm việc với chúng tôi',NULL,NULL),(142,'theme-martfury-vi-contact_info_box_3_subtitle','Gửi CV của bạn đến email của chúng tôi',NULL,NULL),(143,'theme-martfury-vi-contact_info_box_4_title','Dịch vụ khách hàng',NULL,NULL),(144,'theme-martfury-vi-contact_info_box_5_title','Quan hệ truyền thông',NULL,NULL),(145,'theme-martfury-vi-contact_info_box_6_title','Hỗ trợ nhà cung cấp',NULL,NULL),(146,'theme-martfury-fr-site_title','MartFury - Achats en ligne',NULL,NULL),(147,'theme-martfury-fr-seo_description','Achetez en ligne de l\'électronique, de la mode, des articles ménagers et bien plus encore. Les meilleurs prix, livraison rapide et excellent service client.',NULL,NULL),(148,'theme-martfury-fr-copyright','© %Y MartFury. Tous droits réservés.',NULL,NULL),(149,'theme-martfury-fr-welcome_message','Bienvenue chez MartFury !',NULL,NULL),(150,'theme-martfury-fr-address','502 New Street, Brighton VIC, Australia',NULL,NULL),(151,'theme-martfury-fr-cookie_consent_message','Votre expérience sur ce site sera améliorée en autorisant les cookies.',NULL,NULL),(152,'theme-martfury-fr-cookie_consent_learn_more_text','Politique des cookies',NULL,NULL),(153,'theme-martfury-fr-product_feature_1_title','Livraison dans le monde entier',NULL,NULL),(154,'theme-martfury-fr-product_feature_2_title','Retour gratuit sous 7 jours',NULL,NULL),(155,'theme-martfury-fr-product_feature_3_title','Le fournisseur fournit les factures',NULL,NULL),(156,'theme-martfury-fr-product_feature_4_title','Payer en ligne ou à la réception',NULL,NULL),(157,'theme-martfury-fr-contact_info_box_1_title','Contactez directement',NULL,NULL),(158,'theme-martfury-fr-contact_info_box_1_subtitle','contact@martfury.com',NULL,NULL),(159,'theme-martfury-fr-contact_info_box_1_details','(+004) 912-3548-07',NULL,NULL),(160,'theme-martfury-fr-contact_info_box_2_title','Siège social',NULL,NULL),(161,'theme-martfury-fr-contact_info_box_2_subtitle','17 Queen St, Melbourne VIC 3000, Australia',NULL,NULL),(162,'theme-martfury-fr-contact_info_box_3_title','Travaillez avec nous',NULL,NULL),(163,'theme-martfury-fr-contact_info_box_3_subtitle','Envoyez votre CV à notre adresse e-mail',NULL,NULL),(164,'theme-martfury-fr-contact_info_box_4_title','Service client',NULL,NULL),(165,'theme-martfury-fr-contact_info_box_5_title','Relations avec les médias',NULL,NULL),(166,'theme-martfury-fr-contact_info_box_6_title','Support fournisseur',NULL,NULL),(167,'theme-martfury-id-site_title','MartFury - Belanja online',NULL,NULL),(168,'theme-martfury-id-seo_description','Belanja online untuk elektronik, fashion, peralatan rumah tangga, dan banyak lagi. Harga terbaik, pengiriman cepat, dan layanan pelanggan yang sangat baik.',NULL,NULL),(169,'theme-martfury-id-copyright','© %Y MartFury. Semua hak dilindungi.',NULL,NULL),(170,'theme-martfury-id-welcome_message','Selamat datang di MartFury!',NULL,NULL),(171,'theme-martfury-id-address','502 New Street, Brighton VIC, Australia',NULL,NULL),(172,'theme-martfury-id-cookie_consent_message','Pengalaman Anda di situs ini akan ditingkatkan dengan mengizinkan cookie.',NULL,NULL),(173,'theme-martfury-id-cookie_consent_learn_more_text','Kebijakan cookie',NULL,NULL),(174,'theme-martfury-id-product_feature_1_title','Pengiriman ke seluruh dunia',NULL,NULL),(175,'theme-martfury-id-product_feature_2_title','Pengembalian gratis 7 hari',NULL,NULL),(176,'theme-martfury-id-product_feature_3_title','Pemasok memberikan tagihan',NULL,NULL),(177,'theme-martfury-id-product_feature_4_title','Bayar online atau saat menerima',NULL,NULL),(178,'theme-martfury-id-contact_info_box_1_title','Hubungi langsung',NULL,NULL),(179,'theme-martfury-id-contact_info_box_1_subtitle','contact@martfury.com',NULL,NULL),(180,'theme-martfury-id-contact_info_box_1_details','(+004) 912-3548-07',NULL,NULL),(181,'theme-martfury-id-contact_info_box_2_title','Kantor pusat',NULL,NULL),(182,'theme-martfury-id-contact_info_box_2_subtitle','17 Queen St, Melbourne VIC 3000, Australia',NULL,NULL),(183,'theme-martfury-id-contact_info_box_3_title','Bekerja dengan kami',NULL,NULL),(184,'theme-martfury-id-contact_info_box_3_subtitle','Kirim CV Anda ke email kami',NULL,NULL),(185,'theme-martfury-id-contact_info_box_4_title','Layanan pelanggan',NULL,NULL),(186,'theme-martfury-id-contact_info_box_5_title','Hubungan media',NULL,NULL),(187,'theme-martfury-id-contact_info_box_6_title','Dukungan vendor',NULL,NULL),(188,'theme-martfury-tr-site_title','MartFury - Çevrimiçi Alışveriş',NULL,NULL),(189,'theme-martfury-tr-seo_description','Elektronik, moda, ev eşyaları ve daha fazlası için çevrimiçi alışveriş yapın. En iyi fiyatlar, hızlı kargo ve mükemmel müşteri hizmeti.',NULL,NULL),(190,'theme-martfury-tr-copyright','© %Y MartFury. Tüm hakları saklıdır.',NULL,NULL),(191,'theme-martfury-tr-welcome_message','MartFury\'ye hoş geldiniz!',NULL,NULL),(192,'theme-martfury-tr-address','502 New Street, Brighton VIC, Australia',NULL,NULL),(193,'theme-martfury-tr-cookie_consent_message','Bu sitedeki deneyiminiz çerezlere izin vererek geliştirilecektir.',NULL,NULL),(194,'theme-martfury-tr-cookie_consent_learn_more_text','Çerez Politikası',NULL,NULL),(195,'theme-martfury-tr-product_feature_1_title','Dünya çapında kargo',NULL,NULL),(196,'theme-martfury-tr-product_feature_2_title','7 gün ücretsiz iade',NULL,NULL),(197,'theme-martfury-tr-product_feature_3_title','Tedarikçi fatura verir',NULL,NULL),(198,'theme-martfury-tr-product_feature_4_title','Çevrimiçi veya teslimatta ödeyin',NULL,NULL),(199,'theme-martfury-tr-contact_info_box_1_title','Doğrudan iletişim',NULL,NULL),(200,'theme-martfury-tr-contact_info_box_1_subtitle','contact@martfury.com',NULL,NULL),(201,'theme-martfury-tr-contact_info_box_1_details','(+004) 912-3548-07',NULL,NULL),(202,'theme-martfury-tr-contact_info_box_2_title','Genel merkez',NULL,NULL),(203,'theme-martfury-tr-contact_info_box_2_subtitle','17 Queen St, Melbourne VIC 3000, Australia',NULL,NULL),(204,'theme-martfury-tr-contact_info_box_3_title','Bizimle çalışın',NULL,NULL),(205,'theme-martfury-tr-contact_info_box_3_subtitle','CV\'nizi e-posta adresimize gönderin',NULL,NULL),(206,'theme-martfury-tr-contact_info_box_4_title','Müşteri hizmetleri',NULL,NULL),(207,'theme-martfury-tr-contact_info_box_5_title','Medya ilişkileri',NULL,NULL),(208,'theme-martfury-tr-contact_info_box_6_title','Satıcı desteği',NULL,NULL);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simple_slider_items`
--

DROP TABLE IF EXISTS `simple_slider_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `simple_slider_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `simple_slider_id` bigint unsigned NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `order` int unsigned NOT NULL DEFAULT '0',
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simple_slider_items`
--

LOCK TABLES `simple_slider_items` WRITE;
/*!40000 ALTER TABLE `simple_slider_items` DISABLE KEYS */;
INSERT INTO `simple_slider_items` VALUES (1,1,'Slider 1','sliders/1-lg.jpg','/products',NULL,1,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(2,1,'Slider 2','sliders/2-lg.jpg','/products',NULL,2,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(3,1,'Slider 3','sliders/3-lg.jpg','/products',NULL,3,'published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(4,2,'سلايدر 1','sliders/1-lg.jpg','/products',NULL,1,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(5,2,'سلايدر 2','sliders/2-lg.jpg','/products',NULL,2,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(6,2,'سلايدر 3','sliders/3-lg.jpg','/products',NULL,3,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(7,3,'Slider 1','sliders/1-lg.jpg','/products',NULL,1,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(8,3,'Slider 2','sliders/2-lg.jpg','/products',NULL,2,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(9,3,'Slider 3','sliders/3-lg.jpg','/products',NULL,3,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(10,4,'Slider 1','sliders/1-lg.jpg','/products',NULL,1,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(11,4,'Slider 2','sliders/2-lg.jpg','/products',NULL,2,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(12,4,'Slider 3','sliders/3-lg.jpg','/products',NULL,3,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(13,5,'Slider 1','sliders/1-lg.jpg','/products',NULL,1,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(14,5,'Slider 2','sliders/2-lg.jpg','/products',NULL,2,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(15,5,'Slider 3','sliders/3-lg.jpg','/products',NULL,3,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(16,6,'Slider 1','sliders/1-lg.jpg','/products',NULL,1,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(17,6,'Slider 2','sliders/2-lg.jpg','/products',NULL,2,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(18,6,'Slider 3','sliders/3-lg.jpg','/products',NULL,3,'published','2026-02-28 08:15:45','2026-02-28 08:15:45');
/*!40000 ALTER TABLE `simple_slider_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simple_sliders`
--

DROP TABLE IF EXISTS `simple_sliders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `simple_sliders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simple_sliders`
--

LOCK TABLES `simple_sliders` WRITE;
/*!40000 ALTER TABLE `simple_sliders` DISABLE KEYS */;
INSERT INTO `simple_sliders` VALUES (1,'Home slider','home-slider','The main slider on homepage','published','2026-02-28 08:15:37','2026-02-28 08:15:37'),(2,'سلايدر الرئيسية','home-slider-ar',NULL,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(3,'Slider trang chủ','home-slider-vi',NULL,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(4,'Slider accueil','home-slider-fr',NULL,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(5,'Slider beranda','home-slider-id',NULL,'published','2026-02-28 08:15:45','2026-02-28 08:15:45'),(6,'Ana sayfa slider','home-slider-tr',NULL,'published','2026-02-28 08:15:45','2026-02-28 08:15:45');
/*!40000 ALTER TABLE `simple_sliders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slugs`
--

DROP TABLE IF EXISTS `slugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slugs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint unsigned NOT NULL,
  `reference_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `slugs_reference_id_index` (`reference_id`),
  KEY `slugs_key_index` (`key`),
  KEY `slugs_prefix_index` (`prefix`),
  KEY `slugs_reference_index` (`reference_id`,`reference_type`),
  KEY `idx_key_prefix` (`key`,`prefix`),
  KEY `idx_slugs_reference` (`reference_type`,`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slugs`
--

LOCK TABLES `slugs` WRITE;
/*!40000 ALTER TABLE `slugs` DISABLE KEYS */;
INSERT INTO `slugs` VALUES (1,'fashion-live',1,'Botble\\Ecommerce\\Models\\Brand','brands','2026-02-28 08:15:11','2026-02-28 08:15:11'),(2,'hand-crafted',2,'Botble\\Ecommerce\\Models\\Brand','brands','2026-02-28 08:15:11','2026-02-28 08:15:11'),(3,'mestonix',3,'Botble\\Ecommerce\\Models\\Brand','brands','2026-02-28 08:15:11','2026-02-28 08:15:11'),(4,'sunshine',4,'Botble\\Ecommerce\\Models\\Brand','brands','2026-02-28 08:15:11','2026-02-28 08:15:11'),(5,'pure',5,'Botble\\Ecommerce\\Models\\Brand','brands','2026-02-28 08:15:11','2026-02-28 08:15:11'),(6,'anfold',6,'Botble\\Ecommerce\\Models\\Brand','brands','2026-02-28 08:15:11','2026-02-28 08:15:11'),(7,'automotive',7,'Botble\\Ecommerce\\Models\\Brand','brands','2026-02-28 08:15:11','2026-02-28 08:15:11'),(8,'hot-promotions',1,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(9,'electronics',2,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(10,'consumer-electronic',3,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(11,'home-audio-theaters',4,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(12,'tv-videos',5,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(13,'camera-photos-videos',6,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(14,'cellphones-accessories',7,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(15,'headphones',8,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(16,'videos-games',9,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(17,'wireless-speakers',10,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(18,'office-electronic',11,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:11','2026-02-28 08:15:11'),(19,'accessories-parts',12,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(20,'digital-cables',13,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(21,'audio-video-cables',14,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(22,'batteries',15,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(23,'clothing',16,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(24,'computers',17,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(25,'computer-technologies',18,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(26,'computer-tablets',19,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(27,'laptop',20,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(28,'monitors',21,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(29,'computer-components',22,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(30,'networking',23,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(31,'drive-storages',24,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(32,'gaming-laptop',25,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(33,'security-protection',26,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(34,'accessories',27,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(35,'home-kitchen',28,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(36,'health-beauty',29,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(37,'jewelry-watch',30,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(38,'technology-toys',31,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(39,'phones',32,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(40,'babies-moms',33,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(41,'sport-outdoor',34,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(42,'books-office',35,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(43,'cars-motorcycles',36,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(44,'home-improvements',37,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2026-02-28 08:15:12','2026-02-28 08:15:12'),(45,'smart-home-speaker',1,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:24'),(46,'headphone-ultra-bass',2,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:24'),(47,'boxed-bluetooth-headphone',3,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:24'),(48,'camera-samsung-ss-24-digital',4,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:46'),(49,'macbook-pro-2015',5,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:24'),(50,'apple-watch-serial-7',6,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:24'),(51,'macbook-pro-13-inch',7,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:24'),(52,'apple-keyboard-digital',8,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:46'),(53,'macsafe-80w',9,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:24'),(54,'hand-playstation',10,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:24','2026-02-28 08:15:24'),(55,'apple-airpods-serial-3',11,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(56,'cool-smart-watches-digital',12,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:46'),(57,'black-smart-watches',13,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(58,'leather-watch-in-black',14,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(59,'macbook-pro-2015-13-inch',15,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(60,'historic-alarm-clock-digital',16,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:46'),(61,'black-glasses',17,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(62,'phillips-mouse',18,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(63,'gaming-keyboard',19,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(64,'wireless-keyboard-digital',20,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:46'),(65,'black-smart-watches',21,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(66,'smart-home-speaker',22,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(67,'headphone-ultra-bass',23,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(68,'boxed-bluetooth-headphone-digital',24,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:46'),(69,'camera-samsung-ss-24',25,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(70,'leather-watch-in-black',26,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(71,'apple-iphone-13-plus',27,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(72,'macbook-pro-2015-digital',28,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:46'),(73,'apple-watch-serial-7',29,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(74,'macbook-pro-13-inch',30,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(75,'apple-keyboard',31,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(76,'macsafe-80w-digital',32,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:46'),(77,'hand-playstation',33,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(78,'apple-airpods-serial-3',34,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:25','2026-02-28 08:15:25'),(79,'cool-smart-watches',35,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(80,'black-smart-watches-digital',36,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:46'),(81,'leather-watch-in-black',37,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(82,'macbook-pro-2015-13-inch',38,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(83,'sony-wh-1000xm4-wireless-headphones',39,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(84,'samsung-galaxy-s22-ultra-digital',40,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:46'),(85,'dell-xps-15-laptop',41,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(86,'ipad-pro-129-inch',42,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(87,'bose-quietcomfort-earbuds',43,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(88,'lg-oled-c1-series-tv-digital',44,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:46'),(89,'dyson-v11-vacuum-cleaner',45,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(90,'nintendo-switch-oled-model',46,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(91,'canon-eos-r5-camera',47,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(92,'fitbit-sense-smartwatch-digital',48,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:46'),(93,'sonos-beam-soundbar',49,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(94,'logitech-mx-master-3-mouse',50,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(95,'kindle-paperwhite-e-reader',51,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(96,'gopro-hero10-black-digital',52,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:46'),(97,'anker-powercore-power-bank',53,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(98,'samsung-galaxy-buds-pro',54,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:26','2026-02-28 08:15:26'),(99,'electronic',1,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2026-02-28 08:15:34','2026-02-28 08:15:34'),(100,'mobile',2,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2026-02-28 08:15:34','2026-02-28 08:15:34'),(101,'iphone',3,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2026-02-28 08:15:34','2026-02-28 08:15:34'),(102,'printer',4,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2026-02-28 08:15:34','2026-02-28 08:15:34'),(103,'office',5,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2026-02-28 08:15:34','2026-02-28 08:15:34'),(104,'it',6,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2026-02-28 08:15:34','2026-02-28 08:15:34'),(105,'ecommerce',1,'Botble\\Blog\\Models\\Category','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(106,'fashion',2,'Botble\\Blog\\Models\\Category','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(107,'electronic',3,'Botble\\Blog\\Models\\Category','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(108,'commercial',4,'Botble\\Blog\\Models\\Category','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(109,'general',1,'Botble\\Blog\\Models\\Tag','tag','2026-02-28 08:15:36','2026-02-28 08:15:36'),(110,'design',2,'Botble\\Blog\\Models\\Tag','tag','2026-02-28 08:15:36','2026-02-28 08:15:36'),(111,'fashion',3,'Botble\\Blog\\Models\\Tag','tag','2026-02-28 08:15:36','2026-02-28 08:15:36'),(112,'branding',4,'Botble\\Blog\\Models\\Tag','tag','2026-02-28 08:15:36','2026-02-28 08:15:36'),(113,'modern',5,'Botble\\Blog\\Models\\Tag','tag','2026-02-28 08:15:36','2026-02-28 08:15:36'),(114,'4-expert-tips-on-how-to-choose-the-right-mens-wallet',1,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(115,'sexy-clutches-how-to-buy-wear-a-designer-clutch-bag',2,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(116,'the-top-2020-handbag-trends-to-know',3,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(117,'how-to-match-the-color-of-your-handbag-with-an-outfit',4,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(118,'how-to-care-for-leather-bags',5,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(119,'were-crushing-hard-on-summers-10-biggest-bag-trends',6,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(120,'essential-qualities-of-highly-successful-music',7,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(121,'9-things-i-love-about-shaving-my-head',8,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(122,'why-teamwork-really-makes-the-dream-work',9,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(123,'the-world-caters-to-average-people',10,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(124,'the-litigants-on-the-screen-are-not-actors',11,'Botble\\Blog\\Models\\Post','blog','2026-02-28 08:15:36','2026-02-28 08:15:38'),(125,'home',1,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(126,'about-us',2,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(127,'terms-of-use',3,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(128,'terms-conditions',4,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(129,'refund-policy',5,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(130,'blog',6,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(131,'faqs',7,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(132,'contact',8,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(133,'cookie-policy',9,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(134,'affiliate',10,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(135,'career',11,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(136,'coming-soon',12,'Botble\\Page\\Models\\Page','','2026-02-28 08:15:37','2026-02-28 08:15:37'),(137,'gopro',1,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(138,'global-office',2,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(139,'young-shop',3,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(140,'global-store',4,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(141,'roberts-store',5,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(142,'stouffer',6,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(143,'starkist',7,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(144,'old-el-paso',8,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(145,'tyson',9,'Botble\\Marketplace\\Models\\Store','stores','2026-02-28 08:15:43','2026-02-28 08:15:43'),(146,'smart-home-speaker',55,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(147,'headphone-ultra-bass',56,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(148,'headphone-ultra-bass',57,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(149,'headphone-ultra-bass',58,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(150,'headphone-ultra-bass',59,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(151,'boxed-bluetooth-headphone',60,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(152,'boxed-bluetooth-headphone',61,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(153,'boxed-bluetooth-headphone',62,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(154,'apple-airpods-serial-3',63,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(155,'black-smart-watches',64,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(156,'historic-alarm-clock-digital',65,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(157,'historic-alarm-clock-digital',66,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(158,'historic-alarm-clock-digital',67,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(159,'phillips-mouse',68,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(160,'phillips-mouse',69,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(161,'wireless-keyboard-digital',70,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(162,'wireless-keyboard-digital',71,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(163,'wireless-keyboard-digital',72,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(164,'wireless-keyboard-digital',73,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(165,'smart-home-speaker',74,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(166,'smart-home-speaker',75,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(167,'smart-home-speaker',76,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(168,'smart-home-speaker',77,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(169,'headphone-ultra-bass',78,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(170,'boxed-bluetooth-headphone-digital',79,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(171,'boxed-bluetooth-headphone-digital',80,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(172,'camera-samsung-ss-24',81,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(173,'camera-samsung-ss-24',82,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(174,'apple-watch-serial-7',83,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(175,'apple-watch-serial-7',84,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(176,'apple-watch-serial-7',85,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(177,'macbook-pro-13-inch',86,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(178,'hand-playstation',87,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(179,'apple-airpods-serial-3',88,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(180,'apple-airpods-serial-3',89,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(181,'black-smart-watches-digital',90,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(182,'black-smart-watches-digital',91,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(183,'leather-watch-in-black',92,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(184,'leather-watch-in-black',93,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(185,'leather-watch-in-black',94,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(186,'leather-watch-in-black',95,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(187,'leather-watch-in-black',96,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(188,'macbook-pro-2015-13-inch',97,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(189,'macbook-pro-2015-13-inch',98,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(190,'macbook-pro-2015-13-inch',99,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(191,'macbook-pro-2015-13-inch',100,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(192,'sony-wh-1000xm4-wireless-headphones',101,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(193,'ipad-pro-129-inch',102,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(194,'ipad-pro-129-inch',103,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(195,'bose-quietcomfort-earbuds',104,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(196,'bose-quietcomfort-earbuds',105,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(197,'bose-quietcomfort-earbuds',106,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(198,'lg-oled-c1-series-tv-digital',107,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(199,'lg-oled-c1-series-tv-digital',108,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(200,'lg-oled-c1-series-tv-digital',109,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(201,'dyson-v11-vacuum-cleaner',110,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(202,'dyson-v11-vacuum-cleaner',111,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(203,'dyson-v11-vacuum-cleaner',112,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(204,'dyson-v11-vacuum-cleaner',113,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(205,'canon-eos-r5-camera',114,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(206,'fitbit-sense-smartwatch-digital',115,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(207,'fitbit-sense-smartwatch-digital',116,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(208,'fitbit-sense-smartwatch-digital',117,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(209,'fitbit-sense-smartwatch-digital',118,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(210,'fitbit-sense-smartwatch-digital',119,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(211,'logitech-mx-master-3-mouse',120,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(212,'logitech-mx-master-3-mouse',121,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(213,'logitech-mx-master-3-mouse',122,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(214,'kindle-paperwhite-e-reader',123,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(215,'kindle-paperwhite-e-reader',124,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(216,'kindle-paperwhite-e-reader',125,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(217,'gopro-hero10-black-digital',126,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(218,'gopro-hero10-black-digital',127,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(219,'samsung-galaxy-buds-pro',128,'Botble\\Ecommerce\\Models\\Product','products','2026-02-28 08:15:46','2026-02-28 08:15:46'),(220,'new-arrival',1,'Botble\\Ecommerce\\Models\\ProductCollection','collections','2026-02-28 08:15:46','2026-02-28 08:15:46'),(221,'best-sellers',2,'Botble\\Ecommerce\\Models\\ProductCollection','collections','2026-02-28 08:15:46','2026-02-28 08:15:46'),(222,'special-offer',3,'Botble\\Ecommerce\\Models\\ProductCollection','collections','2026-02-28 08:15:46','2026-02-28 08:15:46');
/*!40000 ALTER TABLE `slugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slugs_translations`
--

DROP TABLE IF EXISTS `slugs_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slugs_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slugs_id` bigint unsigned NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prefix` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`lang_code`,`slugs_id`),
  KEY `idx_slugid_key_prefix` (`slugs_id`,`key`,`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slugs_translations`
--

LOCK TABLES `slugs_translations` WRITE;
/*!40000 ALTER TABLE `slugs_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `slugs_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_logins`
--

DROP TABLE IF EXISTS `social_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_logins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci,
  `refresh_token` text COLLATE utf8mb4_unicode_ci,
  `token_expires_at` timestamp NULL DEFAULT NULL,
  `provider_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_logins_provider_provider_id_unique` (`provider`,`provider_id`),
  KEY `social_logins_user_type_user_id_index` (`user_type`,`user_id`),
  KEY `social_logins_user_id_user_type_index` (`user_id`,`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_logins`
--

LOCK TABLES `social_logins` WRITE;
/*!40000 ALTER TABLE `social_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `abbreviation` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `order` tinyint NOT NULL DEFAULT '0',
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint unsigned NOT NULL DEFAULT '0',
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `states_slug_unique` (`slug`),
  KEY `idx_states_name` (`name`),
  KEY `idx_states_status` (`status`),
  KEY `idx_states_country_id` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states_translations`
--

DROP TABLE IF EXISTS `states_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `states_id` bigint unsigned NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `abbreviation` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`states_id`),
  KEY `idx_states_trans_state_lang` (`states_id`,`lang_code`),
  KEY `idx_states_trans_name` (`name`),
  KEY `idx_states_trans_states_id` (`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states_translations`
--

LOCK TABLES `states_translations` WRITE;
/*!40000 ALTER TABLE `states_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `states_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_id` bigint unsigned DEFAULT NULL,
  `author_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'General',1,'Botble\\ACL\\Models\\User',NULL,'published','2026-02-28 08:15:36','2026-02-28 08:15:36'),(2,'Design',1,'Botble\\ACL\\Models\\User',NULL,'published','2026-02-28 08:15:36','2026-02-28 08:15:36'),(3,'Fashion',1,'Botble\\ACL\\Models\\User',NULL,'published','2026-02-28 08:15:36','2026-02-28 08:15:36'),(4,'Branding',1,'Botble\\ACL\\Models\\User',NULL,'published','2026-02-28 08:15:36','2026-02-28 08:15:36'),(5,'Modern',1,'Botble\\ACL\\Models\\User',NULL,'published','2026-02-28 08:15:36','2026-02-28 08:15:36');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_translations`
--

DROP TABLE IF EXISTS `tags_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`tags_id`),
  KEY `idx_tags_trans_tags_id` (`tags_id`),
  KEY `idx_tags_trans_tag_lang` (`tags_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_translations`
--

LOCK TABLES `tags_translations` WRITE;
/*!40000 ALTER TABLE `tags_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonials`
--

DROP TABLE IF EXISTS `testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonials`
--

LOCK TABLES `testimonials` WRITE;
/*!40000 ALTER TABLE `testimonials` DISABLE KEYS */;
/*!40000 ALTER TABLE `testimonials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonials_translations`
--

DROP TABLE IF EXISTS `testimonials_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonials_translations` (
  `lang_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `testimonials_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`testimonials_id`),
  KEY `idx_testimonials_trans_testimonials_id` (`testimonials_id`),
  KEY `idx_testimonials_trans_testimonial_lang` (`testimonials_id`,`lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonials_translations`
--

LOCK TABLES `testimonials_translations` WRITE;
/*!40000 ALTER TABLE `testimonials_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `testimonials_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_meta`
--

DROP TABLE IF EXISTS `user_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_meta` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_meta_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_meta`
--

LOCK TABLES `user_meta` WRITE;
/*!40000 ALTER TABLE `user_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_settings_user_type_user_id_key_unique` (`user_type`,`user_id`,`key`),
  KEY `user_settings_user_type_user_id_index` (`user_type`,`user_id`),
  KEY `user_settings_key_index` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_id` bigint unsigned DEFAULT NULL,
  `super_user` tinyint(1) NOT NULL DEFAULT '0',
  `manage_supers` tinyint(1) NOT NULL DEFAULT '0',
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `last_login` timestamp NULL DEFAULT NULL,
  `sessions_invalidated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@company.com',NULL,NULL,'$2y$12$o3P9vpZQo1czHJ.N1tqUmuAaQsf0jQHxwGbxguzgtscdJiFDybpCu',NULL,'2026-02-28 08:15:35','2026-02-28 08:15:35','System','Admin','admin',NULL,1,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `widgets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `widget_id` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sidebar_id` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` tinyint unsigned NOT NULL DEFAULT '0',
  `data` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `widgets_unique_index` (`theme`,`sidebar_id`,`widget_id`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,'CustomMenuWidget','footer_sidebar','martfury',1,'{\"id\":\"CustomMenuWidget\",\"name\":\"Quick links\",\"menu_id\":\"quick-links\"}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(2,'CustomMenuWidget','footer_sidebar','martfury',2,'{\"id\":\"CustomMenuWidget\",\"name\":\"Company\",\"menu_id\":\"company\"}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(3,'CustomMenuWidget','footer_sidebar','martfury',3,'{\"id\":\"CustomMenuWidget\",\"name\":\"Business\",\"menu_id\":\"business\"}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(4,'BlogSearchWidget','primary_sidebar','martfury',1,'{\"id\":\"BlogSearchWidget\",\"name\":\"Search\"}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(5,'BlogCategoriesWidget','primary_sidebar','martfury',2,'{\"id\":\"BlogCategoriesWidget\",\"name\":\"Categories\"}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(6,'RecentPostsWidget','primary_sidebar','martfury',3,'{\"id\":\"RecentPostsWidget\",\"name\":\"Recent Posts\"}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(7,'TagsWidget','primary_sidebar','martfury',4,'{\"id\":\"TagsWidget\",\"name\":\"Popular Tags\"}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(8,'ProductCategoriesWidget','bottom_footer_sidebar','martfury',1,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Consumer Electric\",\"categories\":[18,2,3,4,5,6,7]}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(9,'ProductCategoriesWidget','bottom_footer_sidebar','martfury',2,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Clothing & Apparel\",\"categories\":[8,9,10,11,12]}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(10,'ProductCategoriesWidget','bottom_footer_sidebar','martfury',3,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Home, Garden & Kitchen\",\"categories\":[13,14,15,16,17]}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(11,'ProductCategoriesWidget','bottom_footer_sidebar','martfury',4,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Health & Beauty\",\"categories\":[20,21,22,23,24]}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(12,'ProductCategoriesWidget','bottom_footer_sidebar','martfury',5,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Computer & Technologies\",\"categories\":[25,26,27,28,29,19]}','2026-02-28 08:15:40','2026-02-28 08:15:40'),(13,'CustomMenuWidget','footer_sidebar','martfury-ar',1,'{\"id\":\"CustomMenuWidget\",\"name\":\"\\u0631\\u0648\\u0627\\u0628\\u0637 \\u0633\\u0631\\u064a\\u0639\\u0629\",\"menu_id\":\"quick-links-ar\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(14,'CustomMenuWidget','footer_sidebar','martfury-ar',2,'{\"id\":\"CustomMenuWidget\",\"name\":\"\\u0627\\u0644\\u0634\\u0631\\u0643\\u0629\",\"menu_id\":\"company-ar\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(15,'CustomMenuWidget','footer_sidebar','martfury-ar',3,'{\"id\":\"CustomMenuWidget\",\"name\":\"\\u0627\\u0644\\u0623\\u0639\\u0645\\u0627\\u0644\",\"menu_id\":\"business-ar\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(16,'BlogSearchWidget','primary_sidebar','martfury-ar',1,'{\"id\":\"BlogSearchWidget\",\"name\":\"\\u0628\\u062d\\u062b\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(17,'BlogCategoriesWidget','primary_sidebar','martfury-ar',2,'{\"id\":\"BlogCategoriesWidget\",\"name\":\"\\u0627\\u0644\\u0641\\u0626\\u0627\\u062a\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(18,'RecentPostsWidget','primary_sidebar','martfury-ar',3,'{\"id\":\"RecentPostsWidget\",\"name\":\"\\u0627\\u0644\\u0645\\u0646\\u0634\\u0648\\u0631\\u0627\\u062a \\u0627\\u0644\\u0623\\u062e\\u064a\\u0631\\u0629\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(19,'TagsWidget','primary_sidebar','martfury-ar',4,'{\"id\":\"TagsWidget\",\"name\":\"\\u0627\\u0644\\u0648\\u0633\\u0648\\u0645 \\u0627\\u0644\\u0634\\u0627\\u0626\\u0639\\u0629\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(20,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-ar',1,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"\\u0627\\u0644\\u0625\\u0644\\u0643\\u062a\\u0631\\u0648\\u0646\\u064a\\u0627\\u062a \\u0627\\u0644\\u0627\\u0633\\u062a\\u0647\\u0644\\u0627\\u0643\\u064a\\u0629\",\"categories\":[18,2,3,4,5,6,7]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(21,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-ar',2,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"\\u0627\\u0644\\u0645\\u0644\\u0627\\u0628\\u0633 \\u0648\\u0627\\u0644\\u0623\\u0632\\u064a\\u0627\\u0621\",\"categories\":[8,9,10,11,12]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(22,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-ar',3,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"\\u0627\\u0644\\u0645\\u0646\\u0632\\u0644 \\u0648\\u0627\\u0644\\u062d\\u062f\\u064a\\u0642\\u0629 \\u0648\\u0627\\u0644\\u0645\\u0637\\u0628\\u062e\",\"categories\":[13,14,15,16,17]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(23,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-ar',4,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"\\u0627\\u0644\\u0635\\u062d\\u0629 \\u0648\\u0627\\u0644\\u062c\\u0645\\u0627\\u0644\",\"categories\":[20,21,22,23,24]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(24,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-ar',5,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"\\u0627\\u0644\\u062d\\u0648\\u0627\\u0633\\u064a\\u0628 \\u0648\\u0627\\u0644\\u062a\\u0642\\u0646\\u064a\\u0627\\u062a\",\"categories\":[25,26,27,28,29,19]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(25,'CustomMenuWidget','footer_sidebar','martfury-vi',1,'{\"id\":\"CustomMenuWidget\",\"name\":\"Li\\u00ean k\\u1ebft nhanh\",\"menu_id\":\"quick-links-vi\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(26,'CustomMenuWidget','footer_sidebar','martfury-vi',2,'{\"id\":\"CustomMenuWidget\",\"name\":\"C\\u00f4ng ty\",\"menu_id\":\"company-vi\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(27,'CustomMenuWidget','footer_sidebar','martfury-vi',3,'{\"id\":\"CustomMenuWidget\",\"name\":\"Kinh doanh\",\"menu_id\":\"business-vi\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(28,'BlogSearchWidget','primary_sidebar','martfury-vi',1,'{\"id\":\"BlogSearchWidget\",\"name\":\"T\\u00ecm ki\\u1ebfm\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(29,'BlogCategoriesWidget','primary_sidebar','martfury-vi',2,'{\"id\":\"BlogCategoriesWidget\",\"name\":\"Danh m\\u1ee5c\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(30,'RecentPostsWidget','primary_sidebar','martfury-vi',3,'{\"id\":\"RecentPostsWidget\",\"name\":\"B\\u00e0i vi\\u1ebft g\\u1ea7n \\u0111\\u00e2y\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(31,'TagsWidget','primary_sidebar','martfury-vi',4,'{\"id\":\"TagsWidget\",\"name\":\"Th\\u1ebb ph\\u1ed5 bi\\u1ebfn\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(32,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-vi',1,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Thi\\u1ebft b\\u1ecb \\u0111i\\u1ec7n t\\u1eed ti\\u00eau d\\u00f9ng\",\"categories\":[18,2,3,4,5,6,7]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(33,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-vi',2,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Qu\\u1ea7n \\u00e1o v\\u00e0 trang ph\\u1ee5c\",\"categories\":[8,9,10,11,12]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(34,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-vi',3,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Nh\\u00e0 c\\u1eeda, v\\u01b0\\u1eddn v\\u00e0 nh\\u00e0 b\\u1ebfp\",\"categories\":[13,14,15,16,17]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(35,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-vi',4,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"S\\u1ee9c kh\\u1ecfe v\\u00e0 l\\u00e0m \\u0111\\u1eb9p\",\"categories\":[20,21,22,23,24]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(36,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-vi',5,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"M\\u00e1y t\\u00ednh v\\u00e0 c\\u00f4ng ngh\\u1ec7\",\"categories\":[25,26,27,28,29,19]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(37,'CustomMenuWidget','footer_sidebar','martfury-fr',1,'{\"id\":\"CustomMenuWidget\",\"name\":\"Liens rapides\",\"menu_id\":\"quick-links-fr\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(38,'CustomMenuWidget','footer_sidebar','martfury-fr',2,'{\"id\":\"CustomMenuWidget\",\"name\":\"Entreprise\",\"menu_id\":\"company-fr\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(39,'CustomMenuWidget','footer_sidebar','martfury-fr',3,'{\"id\":\"CustomMenuWidget\",\"name\":\"Affaires\",\"menu_id\":\"business-fr\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(40,'BlogSearchWidget','primary_sidebar','martfury-fr',1,'{\"id\":\"BlogSearchWidget\",\"name\":\"Rechercher\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(41,'BlogCategoriesWidget','primary_sidebar','martfury-fr',2,'{\"id\":\"BlogCategoriesWidget\",\"name\":\"Cat\\u00e9gories\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(42,'RecentPostsWidget','primary_sidebar','martfury-fr',3,'{\"id\":\"RecentPostsWidget\",\"name\":\"Publications r\\u00e9centes\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(43,'TagsWidget','primary_sidebar','martfury-fr',4,'{\"id\":\"TagsWidget\",\"name\":\"Tags populaires\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(44,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-fr',1,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"\\u00c9lectronique grand public\",\"categories\":[18,2,3,4,5,6,7]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(45,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-fr',2,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"V\\u00eatements et habillement\",\"categories\":[8,9,10,11,12]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(46,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-fr',3,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Maison, jardin et cuisine\",\"categories\":[13,14,15,16,17]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(47,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-fr',4,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Sant\\u00e9 et beaut\\u00e9\",\"categories\":[20,21,22,23,24]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(48,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-fr',5,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Informatique et technologies\",\"categories\":[25,26,27,28,29,19]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(49,'CustomMenuWidget','footer_sidebar','martfury-id',1,'{\"id\":\"CustomMenuWidget\",\"name\":\"Tautan cepat\",\"menu_id\":\"quick-links-id\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(50,'CustomMenuWidget','footer_sidebar','martfury-id',2,'{\"id\":\"CustomMenuWidget\",\"name\":\"Perusahaan\",\"menu_id\":\"company-id\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(51,'CustomMenuWidget','footer_sidebar','martfury-id',3,'{\"id\":\"CustomMenuWidget\",\"name\":\"Bisnis\",\"menu_id\":\"business-id\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(52,'BlogSearchWidget','primary_sidebar','martfury-id',1,'{\"id\":\"BlogSearchWidget\",\"name\":\"Cari\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(53,'BlogCategoriesWidget','primary_sidebar','martfury-id',2,'{\"id\":\"BlogCategoriesWidget\",\"name\":\"Kategori\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(54,'RecentPostsWidget','primary_sidebar','martfury-id',3,'{\"id\":\"RecentPostsWidget\",\"name\":\"Posting terbaru\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(55,'TagsWidget','primary_sidebar','martfury-id',4,'{\"id\":\"TagsWidget\",\"name\":\"Tag populer\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(56,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-id',1,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Elektronik konsumen\",\"categories\":[18,2,3,4,5,6,7]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(57,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-id',2,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Pakaian dan busana\",\"categories\":[8,9,10,11,12]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(58,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-id',3,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Rumah, taman, dan dapur\",\"categories\":[13,14,15,16,17]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(59,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-id',4,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Kesehatan dan kecantikan\",\"categories\":[20,21,22,23,24]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(60,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-id',5,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Komputer dan teknologi\",\"categories\":[25,26,27,28,29,19]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(61,'CustomMenuWidget','footer_sidebar','martfury-tr',1,'{\"id\":\"CustomMenuWidget\",\"name\":\"H\\u0131zl\\u0131 ba\\u011flant\\u0131lar\",\"menu_id\":\"quick-links-tr\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(62,'CustomMenuWidget','footer_sidebar','martfury-tr',2,'{\"id\":\"CustomMenuWidget\",\"name\":\"\\u015eirket\",\"menu_id\":\"company-tr\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(63,'CustomMenuWidget','footer_sidebar','martfury-tr',3,'{\"id\":\"CustomMenuWidget\",\"name\":\"\\u0130\\u015f\",\"menu_id\":\"business-tr\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(64,'BlogSearchWidget','primary_sidebar','martfury-tr',1,'{\"id\":\"BlogSearchWidget\",\"name\":\"Ara\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(65,'BlogCategoriesWidget','primary_sidebar','martfury-tr',2,'{\"id\":\"BlogCategoriesWidget\",\"name\":\"Kategoriler\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(66,'RecentPostsWidget','primary_sidebar','martfury-tr',3,'{\"id\":\"RecentPostsWidget\",\"name\":\"Son g\\u00f6nderiler\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(67,'TagsWidget','primary_sidebar','martfury-tr',4,'{\"id\":\"TagsWidget\",\"name\":\"Pop\\u00fcler etiketler\"}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(68,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-tr',1,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"T\\u00fcketici Elektroni\\u011fi\",\"categories\":[18,2,3,4,5,6,7]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(69,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-tr',2,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Giyim ve Konfeksiyon\",\"categories\":[8,9,10,11,12]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(70,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-tr',3,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Ev, Bah\\u00e7e ve Mutfak\",\"categories\":[13,14,15,16,17]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(71,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-tr',4,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Sa\\u011fl\\u0131k ve G\\u00fczellik\",\"categories\":[20,21,22,23,24]}','2026-02-28 08:15:45','2026-02-28 08:15:45'),(72,'ProductCategoriesWidget','bottom_footer_sidebar','martfury-tr',5,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Bilgisayar ve Teknolojiler\",\"categories\":[25,26,27,28,29,19]}','2026-02-28 08:15:45','2026-02-28 08:15:45');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-28 22:15:47
