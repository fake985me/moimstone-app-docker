-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 07, 2025 at 12:36 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mdi-app-local`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_url` text COLLATE utf8mb4_unicode_ci,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `logo_url`, `website`, `created_at`, `updated_at`) VALUES
(1, 'dasan', NULL, NULL, NULL, NULL),
(2, 'zaram', NULL, NULL, NULL, NULL),
(3, 'zyxel', NULL, NULL, NULL, NULL),
(4, 'tp-link', NULL, NULL, NULL, NULL),
(5, 'mikrotik', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `carousel_slides`
--

CREATE TABLE `carousel_slides` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `bg_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `center_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_left` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mid_left` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mid_right` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_right` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_component` tinyint(1) NOT NULL DEFAULT '0',
  `component_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carousel_slides`
--

INSERT INTO `carousel_slides` (`id`, `title`, `text`, `bg_image`, `center_img`, `img_left`, `mid_left`, `mid_right`, `img_right`, `use_component`, `component_name`, `order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'MDI Solutions', 'Trusted distributor and Experienced technical support for DASAN equipment in Indonesia', NULL, '/assets/static/carousel/mdi.png', NULL, NULL, NULL, NULL, 1, 'LineAnimationSVG', 1, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(2, 'DASAN Solutions', 'Provide conectivity solutions to your network', '/assets/static/carousel/2.jpg', '/assets/static/carousel/dasan.png', NULL, NULL, NULL, NULL, 0, NULL, 2, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(3, 'Our Products', 'Offers something that is beyond your reach', '/assets/static/carousel/3.jpg', NULL, '/assets/static/carousel/hero_1.png', '/assets/static/carousel/hero_2.png', '/assets/static/carousel/hero_3.png', '/assets/static/carousel/hero_4.png', 0, NULL, 3, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'XGSPON', 'XGS-PON networking products', NULL, NULL),
(2, 'GPON', 'GPON networking products', NULL, NULL),
(3, 'SWITCH', 'Network switches', NULL, NULL),
(4, 'ROUTER', 'Network routers', NULL, NULL),
(5, 'WIRELESS', 'Wireless networking products', NULL, NULL),
(6, 'CPE', 'Customer Premises Equipment', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contact_info`
--

CREATE TABLE `contact_info` (
  `id` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_info`
--

INSERT INTO `contact_info` (`id`, `type`, `label`, `value`, `icon`, `order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'description', '', 'PT Moimstone Dasan Indonesia is a trusted provider of telecommunication infrastructure solutions in Indonesia, specializing in fiber optic network deployment and DASAN equipment distribution.', NULL, 1, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(2, 'address', 'Our Address', 'Gedung Tifa Arum Realty\n3th Floor Suite 301\nJl. K.H Wahid Hasyim No. 103\nKebon Sirih, Jakarta Pusat 10350', 'map-marker', 2, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(3, 'phone', 'Office', '021 2930-6714', 'phone', 3, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(4, 'email', 'Mail', 'info@mdi-solutions.com', 'envelope', 4, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(5, 'sales', 'Sales & Marketing', 'Hadi : +62 887-0978-7005', 'user', 5, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(6, 'sales', 'Sales & Marketing', 'Bambang : +62 813-1004-0018', 'user', 6, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `current_stocks`
--

CREATE TABLE `current_stocks` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` bigint UNSIGNED NOT NULL,
  `po_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('preparing','shipped','in_transit','delivered','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'preparing',
  `tracking_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `courier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `delivered_date` date DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_items`
--

CREATE TABLE `delivery_items` (
  `id` bigint UNSIGNED NOT NULL,
  `delivery_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lendings`
--

CREATE TABLE `lendings` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `borrower_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `borrower_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `borrower_organization` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `lend_date` date NOT NULL,
  `expected_return_date` date NOT NULL,
  `actual_return_date` date DEFAULT NULL,
  `status` enum('pending','returned','overdue','lost') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `user_id` bigint UNSIGNED NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lending_returns`
--

CREATE TABLE `lending_returns` (
  `id` bigint UNSIGNED NOT NULL,
  `lending_id` bigint UNSIGNED NOT NULL,
  `return_date` date NOT NULL,
  `quantity_returned` int NOT NULL,
  `condition` enum('good','damaged','lost') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_01_01_000001_create_categories_table', 1),
(6, '2024_01_01_000002_create_products_table', 1),
(7, '2024_01_01_000003_create_product_images_table', 1),
(8, '2024_01_01_000004_create_current_stocks_table', 1),
(9, '2024_01_01_000005_create_stock_transactions_table', 1),
(10, '2024_01_01_000006_create_sales_people_table', 1),
(11, '2024_01_01_000007_create_purchases_table', 1),
(12, '2024_01_01_000008_create_purchase_items_table', 1),
(13, '2024_01_01_000009_create_sales_table', 1),
(14, '2024_01_01_000010_create_sale_items_table', 1),
(15, '2024_01_01_000011_create_warranties_table', 1),
(16, '2024_01_01_000012_create_lendings_table', 1),
(17, '2024_01_01_000013_create_lending_returns_table', 1),
(18, '2024_01_01_000014_create_deliveries_table', 1),
(19, '2024_01_01_000015_create_delivery_items_table', 1),
(20, '2025_11_30_073356_create_solutions_table', 1),
(21, '2025_11_30_073438_create_projects_table', 1),
(22, '2025_11_30_073442_create_site_settings_table', 1),
(23, '2025_11_30_073454_create_contact_info_table', 1),
(24, '2025_11_30_114334_create_pages_table', 1),
(25, '2025_11_30_114340_create_page_sections_table', 1),
(26, '2025_11_30_114345_create_page_templates_table', 1),
(27, '2025_12_01_000001_create_sub_categories_table', 1),
(28, '2025_12_01_000002_create_brands_table', 1),
(29, '2025_12_04_180704_make_label_nullable_in_contact_info_table', 1),
(30, '2025_12_05_000001_create_carousel_slides_table', 1),
(31, '2025_12_05_170633_create_public_products_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint UNSIGNED NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `published_at` timestamp NULL DEFAULT NULL,
  `template_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_sections`
--

CREATE TABLE `page_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `page_id` bigint UNSIGNED NOT NULL,
  `section_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL DEFAULT '0',
  `content` json NOT NULL,
  `settings` json DEFAULT NULL,
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_templates`
--

CREATE TABLE `page_templates` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_sections` json NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth-token', '65e02d84a1bd85f70279b51c611123cf69a934eb33134688f3b93caad89074f1', '[\"*\"]', '2025-12-06 10:52:10', NULL, '2025-12-06 10:50:12', '2025-12-06 10:52:10'),
(2, 'App\\Models\\User', 1, 'auth-token', '5f88d1cdb88ad088d387d2323463947a89635e2265219d50bedd9c75ba08703f', '[\"*\"]', '2025-12-07 05:18:43', NULL, '2025-12-07 04:57:57', '2025-12-07 05:18:43');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descriptions` text COLLATE utf8mb4_unicode_ci,
  `stock` int NOT NULL DEFAULT '0',
  `minimum_stock` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `image`, `category`, `sub_category`, `brand`, `title`, `descriptions`, `stock`, `minimum_stock`, `created_at`, `updated_at`) VALUES
(1, NULL, 'https://ik.imagekit.io/iamfake/products/olt-V8208.png?updatedAt=1750091720038', 'XGSPON', 'OLT', 'dasan', 'V8208 edit', 'The V8208 is a 6RU height chassis PON Optical Line Termination (OLT) supporting XGS-PON, GPON as well as 10GE Active Ethernet service. It terminates the traffic coming from the subscriber lines and consolidates it on one or more Gigabit Ethernet interfaces towards the metropolitan area. It is a high-density chassis system that supports up to 8,192 residential and business subscribers with 64 GPON ports (1:128 split ratio). It also provides simultaneous services of GPON and Gigabit Ethernet. V8208 features flexible and high capacity PON access and 10GE uplinks, scalability and line rate performance with a 3.2Tbps (Full -duplex) non-blocked switch fabric.', 0, 0, '2025-12-05 09:58:29', '2025-12-06 08:12:01'),
(2, '', 'https://ik.imagekit.io/iamfake/products/olt-V5832xg.png?updatedAt=1750091714791', 'XGSPON', 'OLT', 'dasan', 'V5832XG', 'The V5832XG is a cost-effective chassis based PON Optical Line Termination (OLT). Based on the latest IEEE standard, the V5832XG has been specifically designed to fulfill a function within mobile backhaul networks. The V5832XG can be used for a variety of new, revenue-generating applications, for example as L2/L3 Ethernet LAN switches in high rise buildings or as datacenter application and aggregation switches. Additionally, the V5832XG system helps to enhance network efficiency through offering dedicated L3 functionality. The V5832XG introduces a point-to-multipoint concept with the PON technology, which enables a cost-effective FTTx service. The reason why PON is considered as a cost-effective solution is its usage of a passive splitter rather than an active switching system.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(3, '', 'https://ik.imagekit.io/iamfake/products/olt-v6016xc.png?updatedAt=1750091717062', 'XGSPON', 'OLT', 'dasan', 'V6016XC', 'The XGS-PON technology adds new features and function­ality targeted at improving performance and interoper­ability, and adds support for new applications, services, and deployment scenarios. Among these changes are improvements in data rate and reach performance, dia­gnostics, and stand-by mode, to name a few. The V6016XC introduces a point-to-multipoint concept with the XGS-PON technology, which enables a cost-effective FTTx service. The reason why XGS-PON is considered as a cost effective solution is its usage of a passive splitter rather than an active switching system. The V6016XC is comprised of 16-port XGS-PON/GPON combo interface for service interface and fixed 4-port 25GE interface and 2-port 100GE for uplink on the front panel. It offers usable interface to make up diversity network services. Therefore, depending on customer requirements, it can be configured with several Ethernet configurations.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(4, '', 'https://ik.imagekit.io/iamfake/products/olt-v6008xc.png?updatedAt=1750154125972', 'XGSPON', 'OLT', 'dasan', 'V6008XC', 'The XGS-PON technology adds new features and function­ality targeted at improving performance and interoper­ability, and adds support for new applications, services, and deployment scenarios. Among these changes are improvements in data rate and reach performance, dia­gnostics, and stand-by mode, to name a few. The V6008XC introduces a point-to-multipoint concept with the XGS-PON technology, which enables a cost-effective FTTx service. The reason why XGS-PON is considered as a cost effective solution is its usage of a passive splitter rather than an active switching system. The V6008XC is comprised of 8-port XGS-PON/GPON combo interface for service interface and fixed 4-port 25GE interface and 2-port 100GE for uplink on the front panel. It offers usable interface to make up diversity network services. Therefore, depending on customer requirements, it can be configured with several Ethernet configurations.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(5, '', 'https://ik.imagekit.io/iamfake/products/ont-h840c.png?updatedAt=1750092487469', 'XGSPON', 'ONT', 'dasan', 'H840C', 'The H840C optical network terminal (ONT) is targeted for all subscribers requiring multiple POTS and high-speed data interfaces in a cost-effective indoor housing. H840C support a standalone device and with fan-less design. Fully compliant with ITU-T G.9807 standards, H840C supports data rates of 10Gbps upstream and downstream. The ONU is provided with Class N1/N2 type PMD. With DNS leading-edge XGS-PON technology, users can enjoy bandwidth-intensive multimedia services such as real-time audio, and gaming much easier and faster than ever before. The H840C supports Dynamic Bandwidth Allocation (DBA) mechanism in compliance with ITU-T G.9807 with the OLT to optimize upstream bandwidth allocation among ONUs based on the service contracts and supports status reporting DBA in compliance with ITU-T Rec. G.9807.1.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(6, '', 'https://ik.imagekit.io/iamfake/products/ont-h842.png?updatedAt=1750393481115', 'XGSPON', 'ONT', 'dasan', 'H842', 'The H842 is a high-performance, XGS-PON compliant Optical Network Terminal (ONT) able to support service provider requirements for high-speed data and voice in a cost-effective design. The ONT is fully compliant with ITU-T G.9807.1 XGS-PON standard with integrated, on-board optics supporting 1270nm and 1577nm wavelengths with Class N1 type PMD optical receiver. With leading-edge XGS-PON technology, users can enjoy bandwidth intensive multimedia services such as real-time audio, and gaming much easier and faster than ever before. The H842 provides one XGS-PON interface, one 1/2.5/5/10GBase-T port and one 10/100/1000Base-T port. The ONT contains an integrated L2 switch supporting wire-speed L2 bridging.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(7, '', 'https://ik.imagekit.io/iamfake/products/ont%20zaram.png?updatedAt=1753866204414', 'XGSPON', 'ONU PoE', 'zaram', 'ZX-ONT-PoE', 'XGSPON On-board BOSA Compliant with ITU-T G.9807.1 XGS-PON (N1/N2) Support 10Gbps bi-directional traffic capability 1270nm Burst-Mode Transmitter with DFB Laser 1577nm Continuous-Mode Receiver with APD-TIA', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(8, '', 'https://ik.imagekit.io/iamfake/products/Zaram%20Technology%20Introduction.png?updatedAt=1753863193830', 'XGSPON', 'ONU', 'zaram', 'XGS-PON 8-port', 'XGSPON ONU Transceiver Compliant with ITU-T G.9807.1 XGS-PON (N1/N2) Support 10Gbps bi-directional traffic capability 1270nm Burst-Mode Transmitter with DFB Laser 1577nm Continuous-Mode Receiver with APD-TIA', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(9, '', 'https://ik.imagekit.io/iamfake/products/zaram-xgspon-gponstick.png?updatedAt=1750406138420', 'XGSPON', 'XGSPON STICK', 'zaram', 'ZXOS11EPI', 'XGSPON chip and optical component integrated SFP+ ONU product', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(10, '', 'https://ik.imagekit.io/iamfake/products/olt-V8106.png?updatedAt=1750091714706', 'GPON', 'OLT', 'dasan', 'V8106', 'The V8106 is a 6RU height chassis PON Optical Line Termination (OLT) supporting 96 GPON ports as well as a Layer 3 switch of supporting 8 1/10GbE ports Active Ethernet service. It terminates the traffic coming from the subscriber lines and consolidates it on one or more Gigabit Ethernet interfaces towards the metropolitan area. ', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(11, '', 'https://ik.imagekit.io/iamfake/products/olt-V8102.png?updatedAt=1750160493023', 'GPON', 'OLT', 'dasan', 'V8102', 'DASAN Networks V8106 is a chassis system. DASAN Networks V8102 is a 2RU GPON OLT chassis system consisting of 4 slots for 2 modular service slots, 2 fabric switching slots and 2 uplink slots to provide complete features and high performance for FTTx applications. The V8102 OLT is a high-density chassis system that supports up to 4096 residential and business customers with 32 GPON ports (1:128 split ratio). The V8102 GPON OLT supports redundant GPON systems. The V8102 features high-capacity GPON access capacity and 10GbE uplink and line rate performance with non-blocked 320Gbps switch fabric. In addition, V8102 is ready for XG-PON service, it fully supports XG-PON technology with the same chassis. V8102 ensures equipment-level reliability with full redundancy design concept for SFU/Power/GPON units. PON technology adds new features and functionalities targeted to improve performance and interoperability, and adds support for new applications, services, and deployment scenarios.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(12, '', 'https://ik.imagekit.io/iamfake/products/olt-V5816.png?updatedAt=1750160494148', 'GPON', 'OLT', 'dasan', 'V5816', 'As the number of services using internet communications such as broadband internet, internet telephony, and IPTV increases, the need for high-performance network equipment is increasing. This is no exception in areas where population density is low and where there are few customers. You can plan more effectively in terms of network deployment costs. The V5816 is a compact GPON OLT system with 16 GPON ports, 4 1G/10GBase-R ports for uplink, and 4 1000Base-T ports, making it suitable for low-density and low-cost FTTx services. V5816 supports Gigabit ports and is applicable to various network environments. In addition, the redundant power supply is realized so that the network system is not interrupted, ensuring stable service.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(13, '', 'https://ik.imagekit.io/iamfake/products/olt-V5808.png?updatedAt=1750160493762', 'GPON', 'OLT', 'dasan', 'V5808', 'As the number of services using internet communications such as broadband internet, internet telephony, and IPTV increases, the need for high-performance network equipment is increasing. This is no exception in areas where population density is low and where there are few customers. You can plan more effectively in terms of network deployment costs. The V5808 is a compact GPON OLT system with 8 GPON ports, 4 1G/10GBase-R ports for uplink, and 4 1000Base-T ports, making it suitable for low-density and low-cost FTTx services. V5808 supports Gigabit ports and is applicable to various network environments. In addition, the power supply that supports redundant has been realized so that the network system is not disturbed, ensuring stable service.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(14, '', 'https://ik.imagekit.io/iamfake/products/onu-d2224gp.png?updatedAt=1757310940085', 'GPON', 'ONU PoE', 'dasan', 'D2224GP', 'D2224GP is a high performance the second managed gigabit switch. Provides twenty-four 10/100/1000Mbps self-adaption RJ45 ports, plus four  gigabit  SFP ports, it can be used to link bandwidth higher upstream equipment. Support VLAN ACL based on port, easily implement network monitoring, traffic regulation, priority tag and traffic control. Support traditional STP/RSTP/MSTP 2 link protection technology; greatly improve the ability of fault tolerance, redundancy backup to ensure the stable operation of the network. D2224GP provides perfect QOS strategy and plenty of VLAN function. Support 802. 1x authentication based on the port and MAC, easily set user access. Support ACL control based on the time, easy control the access time accurately. D2224GP\\', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(15, '', 'https://ik.imagekit.io/iamfake/products/l2-d2008gpe.png?updatedAt=1750233558797', 'GPON', 'ONU PoE', 'dasan', 'D2008GPE', 'D2008GPE is a new generation designed for high security and high-performance network the layer 2 switch. Provides eight 10/100/1000Mbps self-adaption RJ45 port, and two 100/1000Mbps SFP ports, all ports support wire-speed forwarding, can provide you with larger network flexibility. All ports support Auto MDI/MDIX function.The Switch with a low-cost, easy-to-use, high performance upgrade your old network to a 1000Mbps Gigabit network. ', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(16, '', 'https://ik.imagekit.io/iamfake/products/D2224g.png?updatedAt=1757315109362', 'GPON', 'ONU', 'dasan', 'D2224G', 'D2224G Supports VLAN ACL based on port, easily implement network monitoring, traffic regulation, priority tag and traffic control. Support traditional STP/RSTP/MSTP2 link protection technology; greatly improve the ability of fault tolerance, redundancy backup to ensure the stable operation of the network. Support ACL control based on the time, easy control the access time accurately. Support 802.1x authentication based on the port and MAC, easily set user access. ', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(17, '', 'https://ik.imagekit.io/iamfake/products/onu-v2224g(gp).png?updatedAt=1750481534918', 'GPON', 'ONU', 'dasan', 'V2224G', 'Dasan Networks is a global leader in the delivery of carrier-grade network and customer access solutions that enable high-speed data, voice, video, and wireless services over existing and emerging FTTP (Fiber-tothe-Premise) networks and legacy copper networks.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(18, '', 'https://ik.imagekit.io/iamfake/products/l2-v2724gt.png?updatedAt=1750247607040', 'GPON', 'ONU', 'dasan', 'V2724GT', 'The V2724GT is a cost effective single-board Gigabit Ethernet switch. It has been designed as ultra-compact customer premise equipment with the reliable Layer 2 functionalities. The V2724GT is comprised of 24-port 10/100/1000Base-T(RJ45) and 4-port 10GBase-R(SFP /SFP+). The MGMT and console interface is also located on the front panel with embedded LED for LNK/ACT and TX/RX indication respectively. They are for use of equipment management via remote access or CLI. The V2724GT provides a single AC/DC power connector input and its switch on the front panel. This system supports PSU (AC/DC) and fixed FANs for stable service delivery.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(19, '', 'https://ik.imagekit.io/iamfake/products/ont-h660-gm.png?updatedAt=1750092485700', 'GPON', 'ONT', 'dasan', 'H660GM', 'The H660GM provides one GPON uplink port, four Gigabit Ethernet (10/100/1000Base-T) ports, Wireless LAN interface and two FXS voice ports that enhance the ability to deliver demanding data/Wi-Fi/VoIP services. The H660GM uses Session Initiation Protocol (SIP) to terminate VoIP calls so that in-home wiring does not change and standard telephone setsmay be used. The H660GM supports the full triple play of services including voice and highspeed Internet access services.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(20, '', 'https://ik.imagekit.io/iamfake/products/ont-h660-gma.png?updatedAt=1750262804701', 'GPON', 'ONT', 'dasan', 'H660GMA', 'H660GM-A optical network terminal (ONT) is targeted for all subscribers requiring high-speed data interfaces in a cost-effective indoor housing. Fully compliant with ITU-T G.984 standards, the H660GM-A supports data rates of 1.25Gbps upstream and 2.5Gbps downstream. The H660GM-A provides 1 GPON uplink port, 4 Gigabit Ethernet (10/100/1000Base-T) ports, Wireless LAN interface, and 1 FXS voice port that enhance the ability to deliver demanding data/Wi-Fi/VoIP services. The H660GM-A contains both built-in wire-speed L2 switch and L3 routing gateway with port forwarding, NAT and NAPT address translation, PPPoE client support for high speed Internet service.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(21, '', 'https://ik.imagekit.io/iamfake/products/ont-h660nb.png?updatedAt=1750092487672', 'GPON', 'ONT', 'dasan', 'H660NB', 'The H660NB is GPON Optical Network Terminal (ONT) compliant with ITU-T G.984 standard. The H660NB is developed for all clients based on GPON technology. GPON technology supports upstream 1.25Gbps and downstream 2.5Gbps data transmission rate. With DNS leading-edge GPON technology, users can enjoy band­width consuming multimedia services such as real-time video, audio and gaming much easier and faster than ever before. The H660NB is comprised of 1 GPON uplink port and 4 Gigabit Ethernet downlink port supporting 10/100/ 500/1000Base-T (RJ45). The H660NB supports high speed internet access service. The H660NB contains both built-in wire-speed L2 switch and L3 routing gateway with port forwarding, NAT and NAPT address translation, multiple PPPoE clients support for high speed internet service.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(22, '', 'https://ik.imagekit.io/iamfake/products/ont-h665pdc.png?updatedAt=1750602181268', 'GPON', 'ONT', 'dasan', 'H665PDC', 'The H665PDC is the GPON optical network terminal (ONT) incorporates interoperability, key customers’ specific requirements and cost-efficiency. Fully com­pliant with ITU-T G.984.x standard, the H665PDC supports data rates of 1.25Gbps upstream and 2.5 Gbps downstream. With DNS leading-edge GPON technology, users can enjoy bandwidth-intensive multimedia services. The H665PDC provides 1 GPON uplink port, 1 GE (100M/1G/2.5GBase-T) port. GPON uplink port has SFF connector type and a high-speed optical access method that has been defined in ITU-T G.9807. The H665PDC is designed to provide a simple and cost-effective GPON network connection and combines the benefits of high-speed GPON technology and enables many interactive multi-media applications such as collaborative computing using fiber network.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(23, '', 'https://ik.imagekit.io/iamfake/products/H650SFP.png?updatedAt=1750092485793', 'GPON', 'GPON STICK', 'dasan', 'H650', 'H650SFP is a Gigabit Passive Optical Network (GPON) stick type SFP, which is an ultra-small GPON ONT like SFP module. GPON Stick is an installable and removable product such as FTTx or wireless backhaul applications with small size and low power consumption.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(24, '', 'https://ik.imagekit.io/iamfake/products/switch-v-8610.png?updatedAt=1750511649041', 'SWITCH', 'BACKBONE', 'dasan', 'V8610', 'The V8610 switch is designed to meet the needs of cloud data center applications, providing virtualization, high availability, high performance, various functions and flexible configuration to build a powerful core network with easy and simple configuration, and has all the elements necessary to evolve to the next-generation cloud architecture.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(25, '', 'https://ik.imagekit.io/iamfake/products/switch-v-8607.png?updatedAt=1750560970997', 'SWITCH', 'BACKBONE', 'dasan', 'V8607', 'The V8607 switch is designed to meet the needs of cloud data center applications, providing virtualization, high availability, high performance, various functions and flexible configuration to build a powerful core network with easy and simple configuration, and has all the elements needed to evolve to the next-generation cloud architecture. The V8607 switch supports up to 12Tbps of capacity and consists of a total of 5 line card slots. Depending on the selection of line cards, it provides up to 240 Gigabit Ethernet ports, up to 240 10G Ethernet ports or up to 120 40G Ethernet ports, providing a solution suitable for building a medium-sized core network or aggregating sub-networks, providing sufficient capacity to support end users to build data center-class networks in the enterprise, public, building and defense sectors. The V8607 switch ensures perfect stability and availability through data center network protocols, various virtualization technologies, Software Defined Network technologies including OpenFlow, and multiple configurations of management modules and power supplies.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(26, '', 'https://ik.imagekit.io/iamfake/products/switch-v-8605.png?updatedAt=1750562806237', 'SWITCH', 'BACKBONE', 'dasan', 'V8605', 'The V8605 switch is designed to meet the needs of cloud data center applications, providing  virtualization, high availability, high performance, various features and flexible configurations to build a powerful core network with easy and simple configuration , and has all the elements needed to evolve to the next-generation cloud architecture. The V8605 switch supports up to 7.2TBPS capacity and consists of a total of 3 line card slots.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(27, '', 'https://ik.imagekit.io/iamfake/products/l3-m4000.png?updatedAt=1750566382772', 'SWITCH', 'L3 SWITCH', 'dasan', 'M4000', 'The M4000 Mobile Backhaul access/aggregation CSR (Cell Site Router) 1U height chassis provides a variety of solutions to configure the unit according to the net­work environment. The M4000 is comprised of 32 optical 10/25GE ports and 2 100GE ports.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(28, '', 'https://ik.imagekit.io/iamfake/products/l3-m3500.png?updatedAt=1750569726288', 'SWITCH', 'L3 SWITCH', 'dasan', 'M3500', 'The M3500 is a 1-rack-unit (1RU) carrier Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. The M3500 is comprised of fixed 48 optical 1GE(SFP) or 10GE(SFP+) or 25GE(SFP28) ports and 6 40GE(QSFP28) or 100GE(QSFP28) ports of the optional uplink modules on the front panel. It offers flexible interface to make up diversity network services and benefit of network extension.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(29, '', 'https://ik.imagekit.io/iamfake/products/m3000.png?updatedAt=1750577572759', 'SWITCH', 'L3 SWITCH', 'dasan', 'M3000', 'The M3000 is a cost-effective carrier Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. It has been designed for mobile backhaul networks with demanding subscriber bandwidth requirements and rigid quality-of­service and security needs. The M3000 can be used for a variety of new, revenue-generating applications, for example as L2/L3 Ethernet LAN switches in high rise buildings or as datacenter appli­cation and aggregation switches. Additionally, M3000 switch helps to enhance network efficiency through offering dedicated L3 functionality. The M3000 offers timing services, allowing for mobile clock­ing synchronization from the core of the network. M3000 can be used for various application scenarios as a mobile backhaul switch for the mobile, business, and residential markets.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(30, '', 'https://ik.imagekit.io/iamfake/products/l3-switch-v6848xg.png?updatedAt=1750584948856', 'SWITCH', 'L3 SWITCH', 'dasan', 'V6848XG', 'Dasan Networks\\', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(31, '', 'https://ik.imagekit.io/iamfake/products/l3-switch-d5128g.png?updatedAt=1750592107711', 'SWITCH', 'L3 SWITCH', 'dasan', 'D5128G', 'The D5128G switch is a next-generation multiservice switch that delivers superior performance and enhanced security features. The D5128G provides flexible Gigabit and 10 Gigabit interfaces. It is a highly versatile combo-type product that can provide 4 SFP ports out of 28 GTX ports as service ports. The D5128G supports VSU (Virtual Switch Unit) technology, allowing up to 9 switches to be managed as a single switch. The D5128G provides a PSU (power supply unit) slot that can be equipped with an AC power module and implements power module redundancy to ensure reliability.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(32, '', 'https://ik.imagekit.io/iamfake/products/l3-switch-v5648g.png?updatedAt=1750592025655', 'SWITCH', 'L3 SWITCH', 'dasan', 'V5648G', 'The V5648G is a 1U high-performance stand-alone enterprise L3 switch designed for data center, campus, and branch office environments. The V5648G provides 48 ports of Gigabit Ethernet interfaces (RJ-45) and provides high-bandwidth switching, filtering, and traffic management capabilities without compromising performance. The V5648G not only provides LLDP (Link Layer Discovery Protocol) to discover network problems and strengthen network management in environments where multiple heterogeneous devices are operated in combination, but also supports additional functions such as LLDP-MED and DHCP Snooping to strengthen network security in the future. The V5648G provides a PSU (power supply unit) slot that can be equipped with an AC power module and implements power module redundancy to ensure reliability.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(33, '', 'https://ik.imagekit.io/iamfake/products/l3-switch-v5624g.png?updatedAt=1750593563242', 'SWITCH', 'L3 SWITCH', 'dasan', 'V5624G', 'The V5624G is a highly versatile combo-type product that can be provided with a choice of 24 ports of GTx and SFP (RJ-45/SFP provided). The V5624G provides high-bandwidth switching, filtering, and traffic management functions without delaying data. Additionally, the V5624G supports LLDP (Link Layer Discovery Protocol) as well as LLDP-MED and DHCP snooping, which is beneficial for expanding/enforcing network security and enables troubleshooting and improved network management. The V5624G provides a PSU (power supply unit) slot that can be equipped with an AC power module and implements power module redundancy to ensure reliability.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(34, '', 'https://ik.imagekit.io/iamfake/products/l2-c2100.png?updatedAt=1750596948083', 'SWITCH', 'L2 SWITCH', 'dasan', 'C2100', 'The C2100 is a cost-effective compact Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. It has been designed for mobile fronthaul networks with demanding subscriber bandwidth requirements and rigid quality-of­service and security needs. The C2100 can be used for a variety of new, revenue-generating applications, for example as L2 Ethernet LAN switches in high rise buildings or as datacenter application and aggregation switches. The C2100 offers clock synchronization services, allowing for mobile clocking synchronization from the core of the network. The C2100 can be used for various application scenarios as a mobile fronthaul switch for the mobile, busi­ness, and residential markets.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(35, '', 'https://ik.imagekit.io/iamfake/products/l2-c2200.png?updatedAt=1750657386523', 'SWITCH', 'L2 SWITCH', 'dasan', 'C2200', 'The C2200 is a cost-effective carrier Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. It has been designed for mobile fronthaul networks with demanding subscriber bandwidth requirements and rigid quality-of­service and security needs. The C2200 can be used for a variety of new, revenue-generating applications, for example as L2 Ethernet LAN switches in high rise buildings or as datacenter application and aggregation switches. The C2200 offers clock synchronization services, allowing for mobile clocking synchronization from the core of the network. The C2200 can be used for various application scenarios as a mobile fronthaul switch for the mobile, busi­ness, and residential markets.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(36, '', 'https://ik.imagekit.io/iamfake/products/l2-c2300.png?updatedAt=1750657960946', 'SWITCH', 'L2 SWITCH', 'dasan', 'C2300', 'The C2300 is a cost-effective carrier Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. It has been designed for mobile fronthaul networks with demanding subscriber bandwidth requirements and rigid quality-of­service and security needs. The C2300 can be used for a variety of new, revenue-generating applications, for example as L2 Ethernet LAN switches in high rise buildings or as datacenter application and aggregation switches. The C2300 offers clock synchronization services, allowing for mobile clocking synchronization from the core of the network. The C2300 can be used for various application scenarios as a mobile fronthaul switch for the mobile, busi­ness, and residential markets.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(37, '', 'https://ik.imagekit.io/iamfake/products/D2224g.png?updatedAt=1750092485713', 'SWITCH', 'L2 SWITCH', 'dasan', 'D2224G', 'D2224G Supports VLAN ACL based on port, easily implement network monitoring, traffic regulation, priority tag and traffic control. Support traditional STP/RSTP/MSTP2 link protection technology; greatly improve the ability of fault tolerance, redundancy backup to ensure the stable operation of the network. Support ACL control based on the time, easy control the access time accurately. Support 802.1x authentication based on the port and MAC, easily set user access. ', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(38, '', 'https://ik.imagekit.io/iamfake/products/l2-v2724gt.png?updatedAt=1750247607040', 'SWITCH', 'L2 SWITCH', 'dasan', 'V2724GT', 'The V2724GT is a cost effective single-board Gigabit Ethernet switch. It has been designed as ultra-compact customer premise equipment with the reliable Layer 2 functionalities. The V2724GT is comprised of 24-port 10/100/1000Base-T(RJ45) and 4-port 10GBase-R(SFP /SFP+). The MGMT and console interface is also located on the front panel with embedded LED for LNK/ACT and TX/RX indication respectively. They are for use of equipment management via remote access or CLI. The V2724GT provides a single AC/DC power connector input and its switch on the front panel. This system supports PSU (AC/DC) and fixed FANs for stable service delivery.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(39, '', 'https://ik.imagekit.io/iamfake/products/l3-switch-d2648gp.png?updatedAt=1750664449839', 'SWITCH', 'PoE SWITCH', 'dasan', 'D2448GP', 'The D2648GP from Dasan Networks is a gigabit Ethernet L3 switch that supports Power over Ethernet (PoE/PoE+) on 24 service ports. It also supports IPv4/IPv6 routing, allowing it to function as both a centralized switch and a PoE switch at the same time, and provides a 10G uplink to ensure expandability for future traffic increases. The D2648GP supports PoE, allowing it to supply data and power to connected terminals simultaneously via Ethernet cables, eliminating the need for separate power connections for each device, which can reduce costs. The D2648GP provides dynamic IP routing, ACL, QoS, and Multicast functions to ensure stable network communication and build a flexible and stable network. It also offers a wide range of performance, reliability, and enhanced network management functions to enable efficient network construction and differentiated service provision.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(40, '', 'https://ik.imagekit.io/iamfake/products/l3-switch-d2624g.png?updatedAt=1750665369541', 'SWITCH', 'PoE SWITCH', 'dasan', 'D2624GP', 'The D2624GP from Dasan Networks is a gigabit Ethernet switch that supports Power over Ethernet (PoE) for 24 subscriber ports. The D2624GP supports the PoE function, allowing it to simultaneously supply data and power to connected sub-terminals via Ethernet cables. This has a great cost-saving advantage because there is no need to install a power outlet for each individual device. The D2624GP provides 24 fixed 10/100/1000BASE-T (RJ-45) gigabit Ethernet service ports. It also provides four 1000BASE-X (SFP) / 10GBASE-R (SFP+) uplink ports, making it an efficient switch that can be utilized in various network environments. D2624GP provides intelligent services such as QoS, security ACL (Access Control List), and multicast management to ensure stable network communication and build a high-performance network. In addition, it has a wide range of performance, reliability, and enhanced network management functions to enable efficient network construction and differentiated service provision.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(41, '', 'https://ik.imagekit.io/iamfake/products/onu-d2224gp.png?updatedAt=1750092496705', 'SWITCH', 'PoE SWITCH', 'dasan', 'D2224GP', 'D2224GP is a high performance the second managed gigabit switch. Provides twenty-four 10/100/1000Mbps self-adaption RJ45 ports, plus four  gigabit  SFP ports, it can be used to link bandwidth higher upstream equipment. Support VLAN ACL based on port, easily implement network monitoring, traffic regulation, priority tag and traffic control. Support traditional STP/RSTP/MSTP 2 link protection technology; greatly improve the ability of fault tolerance, redundancy backup to ensure the stable operation of the network. D2224GP provides perfect QOS strategy and plenty of VLAN function. Support 802. 1x authentication based on the port and MAC, easily set user access. Support ACL control based on the time, easy control the access time accurately. D2224GP\\', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(42, '', 'https://ik.imagekit.io/iamfake/products/l2-d2008gpe.png?updatedAt=1750233558797', 'SWITCH', 'PoE SWITCH', 'dasan', 'D2008GPE', 'D2008GPE is a new generation designed for high security and high-performance network the layer 2 switch. Provides eight 10/100/1000Mbps self-adaption RJ45 port, and two 100/1000Mbps SFP ports, all ports support wire-speed forwarding, can provide you with larger network flexibility. All ports support Auto MDI/MDIX function.The Switch with a low-cost, easy-to-use, high performance upgrade your old network to a 1000Mbps Gigabit network. ', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(43, '', 'https://ik.imagekit.io/iamfake/products/ap-w340.png?updatedAt=1750738971254', 'WIRELESS', 'Access Point', 'dasan', 'W340', 'Supporting the latest Wi-Fi standard, 802.11ax, the W340 supports Triple Radio, Dual Band Wi-Fi services to maximize service performance. The three radios provide access speeds of up to 1.15Gbps + 4.8Gbps + 867Mbps. It supports WPA3, the latest wireless security standard, to protect the security of user terminals, and supports wireless RF control, mobile access, QoS (Quality of Service), and perfect L2/L3 roaming. W340 can be selected as a standalone/controller-linked/cloud service type by setting without changing the OS. Controller linkage can easily provide integrated management, wireless traffic transfer, security, and access control through linkage with Dasan Networks W7210/W7110 wireless controller. In addition, for wired connection, it ensures high performance and high availability through the AP\\', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(44, '', 'https://ik.imagekit.io/iamfake/products/ap-w640.png?updatedAt=1750743488648', 'WIRELESS', 'Access Point', 'dasan', 'W640', 'With the growing popularity of personal digital devices such as tablet, smart phone, laptop, and other mobile computing tools, the needs is being increased for con­figuring the consolidated wireless network, and estab­lishing the smart environment. W640 is a Wi-Fi 6 indoor Access Point based on 802.11 a/b/g/n/ac/ax, which supports Triple-Radio and Triple -Band. It supports WPA3 to protect the security of user devices, and supports wireless RF control, mobile access, QoS (Quality of Service), and complete L2/L3 roaming. In this regard, the W640 is the perfect fit for the enter­prise and home customers that want to deploy the opti­mized secure wireless networks in the office, workplace, entire campus or apartment houses.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(45, '', 'https://ik.imagekit.io/iamfake/products/ap-w345.png?updatedAt=1750744297787', 'WIRELESS', 'Access Point', 'dasan', 'W345', 'The W345 is a next-generation Outdoor Access Point product that adopts the Wi-Fi 6 802.11ax protocol and supports wireless speeds of up to 2,400 Mbps + 1,150 Mbps + 867 Mbps through Triple-Radio technology. It supports security of user devices, and supports wireless RF control, mobile access, QoS (Quality of Service), and complete L2 roaming. The W345 is designed to be fully in outdoor environments through a hardware design that satisfies the waterproof/dustproof rating of IP67/IP68. W345 allow you to meet flexible wireless Wi-Fi coverage range in different environmental requirements. The W345 is an outdoor AP suitable for various enterprise scenarios such as public Wi-Fi, education, hotels and office environ­ments.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(46, '', 'https://ik.imagekit.io/iamfake/products/controller-w7110.png?updatedAt=1750745905696', 'WIRELESS', 'CONTROLLER', 'dasan', 'W7110', 'Dasan Networks W7110 high-performance wireless controller is designed to support next-generation high-speed wireless networks. W7110 enables network communication between AP (Access Point) and controller to flexibly accommodate Wi-Fi services without changing the existing network. It can manage 32 wireless APs by default, and can manage up to 224 wireless APs by adding licenses.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(47, '', 'https://ik.imagekit.io/iamfake/products/controller-w7210.png?updatedAt=1750752417835', 'WIRELESS', 'CONTROLLER', 'dasan', 'W7210', 'Dasan Networks W7210 high-performance wireless controller is designed to support next-generation high-speed wireless networks. W7210 enables network communication between AP (Access Point) and controller to flexibly accommodate Wi-Fi services without changing the existing network. It can manage 128 wireless APs by default, and can manage up to 2,560 (distributed) wireless APs by adding licenses.', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29'),
(48, '', NULL, 'Test Category', NULL, 'Test Brand', 'Test Product', 'This is a test product', 0, 0, '2025-12-05 09:58:29', '2025-12-05 09:58:29');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `title`, `description`, `image_url`, `url`, `category`, `order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Telkom Indonesia FTTH Deployment', 'Successfully deployed fiber optic network infrastructure for residential areas covering 5000+ homes in Jakarta and surrounding areas.', '/assets/static/projects/telkom.jpg', NULL, 'FTTH', 1, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(2, 'XL Axiata Network Upgrade', 'Upgraded existing network infrastructure with latest DASAN OLT equipment, improving network capacity and reliability for 10,000+ subscribers.', '/assets/static/projects/xl.jpg', NULL, 'Network Upgrade', 2, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(3, 'Smart City Network - Surabaya', 'Implemented high-speed fiber network infrastructure to support smart city initiatives including traffic management, CCTV, and IoT devices.', '/assets/static/projects/smartcity.jpg', NULL, 'Smart City', 3, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(4, 'Industrial Park Connectivity', 'Provided complete network solution for industrial park in Karawang, connecting 50+ factories with high-speed fiber optic network.', '/assets/static/projects/industrial.jpg', NULL, 'Enterprise', 4, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(5, 'University Campus Network', 'Deployed campus-wide fiber network covering dormitories, lecture halls, and administrative buildings serving 15,000+ students.', '/assets/static/projects/campus.jpg', NULL, 'Education', 5, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `public_products`
--

CREATE TABLE `public_products` (
  `id` bigint UNSIGNED NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `spec1` text COLLATE utf8mb4_unicode_ci,
  `spec2` text COLLATE utf8mb4_unicode_ci,
  `spec3` text COLLATE utf8mb4_unicode_ci,
  `spec4` text COLLATE utf8mb4_unicode_ci,
  `spec5` text COLLATE utf8mb4_unicode_ci,
  `spec6` text COLLATE utf8mb4_unicode_ci,
  `spec7` text COLLATE utf8mb4_unicode_ci,
  `descriptions` text COLLATE utf8mb4_unicode_ci,
  `fitur1` text COLLATE utf8mb4_unicode_ci,
  `fitur2` text COLLATE utf8mb4_unicode_ci,
  `fitur3` text COLLATE utf8mb4_unicode_ci,
  `fitur4` text COLLATE utf8mb4_unicode_ci,
  `fitur5` text COLLATE utf8mb4_unicode_ci,
  `fitur6` text COLLATE utf8mb4_unicode_ci,
  `fitur7` text COLLATE utf8mb4_unicode_ci,
  `fitur8` text COLLATE utf8mb4_unicode_ci,
  `fitur9` text COLLATE utf8mb4_unicode_ci,
  `fitur10` text COLLATE utf8mb4_unicode_ci,
  `fitur11` text COLLATE utf8mb4_unicode_ci,
  `fitur12` text COLLATE utf8mb4_unicode_ci,
  `fitur13` text COLLATE utf8mb4_unicode_ci,
  `fitur14` text COLLATE utf8mb4_unicode_ci,
  `fitur15` text COLLATE utf8mb4_unicode_ci,
  `wireless_standard` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wireless_stream` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wireless_stream1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wireless_stream2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wireless_stream3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wireless_stream4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wireless_stream5` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manageable_aps` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ap_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number_of_clients` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_rating` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `switching` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `throughput` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flash_memory` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sdram_memory` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interface_main` text COLLATE utf8mb4_unicode_ci,
  `interface1` text COLLATE utf8mb4_unicode_ci,
  `interface2` text COLLATE utf8mb4_unicode_ci,
  `interface3` text COLLATE utf8mb4_unicode_ci,
  `interface4` text COLLATE utf8mb4_unicode_ci,
  `interface5` text COLLATE utf8mb4_unicode_ci,
  `antena` text COLLATE utf8mb4_unicode_ci,
  `cu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cu1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cu2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cu3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cu4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_interface1` text COLLATE utf8mb4_unicode_ci,
  `additional_interface2` text COLLATE utf8mb4_unicode_ci,
  `additional_interface3` text COLLATE utf8mb4_unicode_ci,
  `additional_interface4` text COLLATE utf8mb4_unicode_ci,
  `mac_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `routing_table` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dustproof_waterproof` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `noise` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mtbf` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operating_temperature` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_temperature` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operating_humidity` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `power1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `power2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `power3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `power_consumptions` text COLLATE utf8mb4_unicode_ci,
  `dimensions` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diagram` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `network_diagram` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `public_products`
--

INSERT INTO `public_products` (`id`, `sku`, `module`, `slug`, `image`, `category`, `sub_category`, `brand`, `title`, `subtitle`, `spec1`, `spec2`, `spec3`, `spec4`, `spec5`, `spec6`, `spec7`, `descriptions`, `fitur1`, `fitur2`, `fitur3`, `fitur4`, `fitur5`, `fitur6`, `fitur7`, `fitur8`, `fitur9`, `fitur10`, `fitur11`, `fitur12`, `fitur13`, `fitur14`, `fitur15`, `wireless_standard`, `wireless_stream`, `wireless_stream1`, `wireless_stream2`, `wireless_stream3`, `wireless_stream4`, `wireless_stream5`, `manageable_aps`, `ap_number`, `number_of_clients`, `capacity`, `ip_rating`, `switching`, `throughput`, `flash_memory`, `sdram_memory`, `interface_main`, `interface1`, `interface2`, `interface3`, `interface4`, `interface5`, `antena`, `cu`, `cu1`, `cu2`, `cu3`, `cu4`, `additional_interface1`, `additional_interface2`, `additional_interface3`, `additional_interface4`, `mac_address`, `routing_table`, `dustproof_waterproof`, `noise`, `mtbf`, `operating_temperature`, `storage_temperature`, `operating_humidity`, `power1`, `power2`, `power3`, `power_consumptions`, `dimensions`, `diagram`, `network_diagram`, `is_active`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, '', 'A', 'v8208', 'https://ik.imagekit.io/iamfake/products/olt-V8208.png?updatedAt=1750091720038', 'XGSPON', 'OLT', 'dasan', 'V8208', 'XGSPON OLT', '8 port GPON/XGSPON Combo', '16p GPON/XGSPON Combo', '8p 10GE', 'DC', 'up to 96PON', '', '', 'The V8208 is a 6RU height chassis PON Optical Line Termination (OLT) supporting XGS-PON, GPON as well as 10GE Active Ethernet service. It terminates the traffic coming from the subscriber lines and consolidates it on one or more Gigabit Ethernet interfaces towards the metropolitan area. It is a high-density chassis system that supports up to 8,192 residential and business subscribers with 64 GPON ports (1:128 split ratio). It also provides simultaneous services of GPON and Gigabit Ethernet. V8208 features flexible and high capacity PON access and 10GE uplinks, scalability and line rate performance with a 3.2Tbps (Full -duplex) non-blocked switch fabric.', '8-port GPON interfaces per slot', '8-port XGS-PON interfaces per slot', '8-port 10GE interface per slot', 'Multi-service chassis for FTTx deployments Full redundancy', 'Support and delivery of various service types', 'VoIP, IP-TV, high-speed internet, mobile, etc', 'Non-stop forwarding, Non-stop routing features based on distributed architecture', 'Selective service/uplink modular units for flexible network', 'High capacity XGS-PON access and 10GE uplink and line rate performance', 'Realtime network traffic monitoring and analyzing', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8MB(Boot) + 512MB(NOS)', '4GB (DDR4)', '', 'IU_GPON8 for GPON(SFP)', 'IU_XGSPON8 for GPON/XGS-PON Combo(SFP+)', 'IU_10GE8 for 10GE(SFP+)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0 ~ 50°C', '-20 ~ 70°C', '20 ~ 80% (non-condensing)', '-48VDC', '', '', '875W (SFU x 2 + FAN x 2 + PSU_DC x 2 + IU_XGSPON8 x 6 + IU_10GE8 x 2)', '443.8 x 265.9 x 280 mm (Wing Bracket excluded)', 'xgspon_olt', 'xgsponLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(2, '', 'A', 'v5832xg', 'https://ik.imagekit.io/iamfake/products/olt-V5832xg.png?updatedAt=1750091714791', 'XGSPON', 'OLT', 'dasan', 'V5832XG', 'XGSPON OLT', '8 port GPON/XGSPON Combo', '16p GPON/XGSPON Combo', '8/16p GPON', '4p 10GE', 'AC/DC', 'up to 32PON', '', 'The V5832XG is a cost-effective chassis based PON Optical Line Termination (OLT). Based on the latest IEEE standard, the V5832XG has been specifically designed to fulfill a function within mobile backhaul networks. The V5832XG can be used for a variety of new, revenue-generating applications, for example as L2/L3 Ethernet LAN switches in high rise buildings or as datacenter application and aggregation switches. Additionally, the V5832XG system helps to enhance network efficiency through offering dedicated L3 functionality. The V5832XG introduces a point-to-multipoint concept with the PON technology, which enables a cost-effective FTTx service. The reason why PON is considered as a cost-effective solution is its usage of a passive splitter rather than an active switching system.', '16-port GPON interfaces per slot', '8-port XGS-PON interfaces per slot', '8-port 10GE interfaces per slot', '800Gbps switching capacity', '595Mpps throughput', 'Hot swappable for all plug-in units', 'XGS-PON ODN class N1 compliant with ITU-T G.9807.1', 'GPON SFP B+ compliant with ITU-T G.984.2', 'GPON SFP C+ compliant with ITU-T G.984.2', 'Supports DDM (Digital Diagnostics Monitoring)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8MB(Boot) + 512MB(NOS)', '4GB (DDR4 with ECC)', '', 'IU_GPON16 for GPON(SFP)', 'IU_XGSPON8 for XGS-PON (SFP)', 'IU_10GE4_UP for 10GE(SFP+)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '10 ~ 50°C', '-40 ~ 70°C', '5 ~ 95% (non-condensing)', 'DC -48VDC', 'AC: 220VAC', '', '265W (PSU DC) 310W (PSU AC)', '482.6 x 133 x 280 mm (3RU, Wing Bracket included)', 'xgspon_olt', 'xgsponLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(3, '', 'A', 'v6016xc', 'https://ik.imagekit.io/iamfake/products/olt-v6016xc.png?updatedAt=1750091717062', 'XGSPON', 'OLT', 'dasan', 'V6016XC', 'XGSPON OLT', '16 port GPON/XGSPON Combo', '4p 1/10/25GE', '2p 100GE', 'AC/DC', '', '', '', 'The XGS-PON technology adds new features and function­ality targeted at improving performance and interoper­ability, and adds support for new applications, services, and deployment scenarios. Among these changes are improvements in data rate and reach performance, dia­gnostics, and stand-by mode, to name a few. The V6016XC introduces a point-to-multipoint concept with the XGS-PON technology, which enables a cost-effective FTTx service. The reason why XGS-PON is considered as a cost effective solution is its usage of a passive splitter rather than an active switching system. The V6016XC is comprised of 16-port XGS-PON/GPON combo interface for service interface and fixed 4-port 25GE interface and 2-port 100GE for uplink on the front panel. It offers usable interface to make up diversity network services. Therefore, depending on customer requirements, it can be configured with several Ethernet configurations.', '900 Gbps switching capacity', 'Redundant dual power supply unit (PSU)', '16-port XGS-PON/GPON combo interfaces', 'Fixed 4-port 25GE and 2-port 100GE interfaces', 'Hot Swappable for all plug-in units (PSU and FAN)', 'XGS-PON ODN class N1 compliant with ITU-T G.9807.1', 'ITU-T G.984.4 ONT Management & Control Interface (OMCI)', 'GPON SFP B+, C+ compliant with ITU-T G.984.2', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8MB(Boot) + 512MB(NOS) + 8GB(USB, Optional)', '4GB', '', '16 x XGS-PON/GPON combo (SFP+/SFP)', '4 x 10/25GBase-R (SFP28)', '2 x 40/100Base-R (QSFP28)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40 ~ 65°C', '-40 ~ 70°C', '5 ~ 95% (non-condensing)', 'DC -48VDC', 'AC: 100-240 VAC', '', 'Max. 230W (PSU DC) Max. 245W (PSU AC)', '420 x 44 x 280 mm (1RU)', 'xgspon_olt', 'xgsponLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(4, '', 'A', 'v6008xc', 'https://ik.imagekit.io/iamfake/products/olt-v6008xc.png?updatedAt=1750154125972', 'XGSPON', 'OLT', 'dasan', 'V6008XC', 'XGSPON OLT', '8 port GPON/XGSPON Combo', '4p 1/10/25GE', '2p 100GE', 'AC/DC', '', '', '', 'The XGS-PON technology adds new features and function­ality targeted at improving performance and interoper­ability, and adds support for new applications, services, and deployment scenarios. Among these changes are improvements in data rate and reach performance, dia­gnostics, and stand-by mode, to name a few. The V6008XC introduces a point-to-multipoint concept with the XGS-PON technology, which enables a cost-effective FTTx service. The reason why XGS-PON is considered as a cost effective solution is its usage of a passive splitter rather than an active switching system. The V6008XC is comprised of 8-port XGS-PON/GPON combo interface for service interface and fixed 4-port 25GE interface and 2-port 100GE for uplink on the front panel. It offers usable interface to make up diversity network services. Therefore, depending on customer requirements, it can be configured with several Ethernet configurations.', 'Redundant dual power supply unit (PSU)', '8-port XGS-PON/GPON combo interfaces', 'Fixed 4-port 25GE and 2-port 100GE interfaces', 'Hot Swappable for all plug-in units (PSU and FAN)', 'XGS-PON ODN class N1 compliant with ITU-T G.9807.1', 'ITU-T G.984.4 ONT Management & Control Interface (OMCI)', 'GPON SFP B+, C+ compliant with ITU-T G.984.2', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8MB (Boot) + 512MB (NOS) + 8GB (USB, Optional)', '4GB', '', '8 x XGS-PON/GPON combo (SFP+/SFP)', '4 x 10/25GBase-R (SFP28)', '2 x 40/100Base-R (QSFP28)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40 ~ 65°C', '-40 ~ 70°C', '5 ~ 95% (non-condensing)', 'DC -48VDC', 'AC: 100-240 VAC', '', 'Max. 155W (PSU DC) Max. 170W (PSU AC)', '440 x 44 x 280 mm (1RU)', 'xgspon_olt', 'xgsponLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(5, '', 'A', 'h840c', 'https://ik.imagekit.io/iamfake/products/ont-h840c.png?updatedAt=1750092487469', 'XGSPON', 'ONT', 'dasan', 'H840C', 'XGSPON ONT', '4 ports 10/100/1000Base-T (RJ45)', '1 port 101GBase-T (RJ45)', '', '', '', '', '', 'The H840C optical network terminal (ONT) is targeted for all subscribers requiring multiple POTS and high-speed data interfaces in a cost-effective indoor housing. H840C support a standalone device and with fan-less design. Fully compliant with ITU-T G.9807 standards, H840C supports data rates of 10Gbps upstream and downstream. The ONU is provided with Class N1/N2 type PMD. With DNS leading-edge XGS-PON technology, users can enjoy bandwidth-intensive multimedia services such as real-time audio, and gaming much easier and faster than ever before. The H840C supports Dynamic Bandwidth Allocation (DBA) mechanism in compliance with ITU-T G.9807 with the OLT to optimize upstream bandwidth allocation among ONUs based on the service contracts and supports status reporting DBA in compliance with ITU-T Rec. G.9807.1.', '1-port XGS-PON interface for uplink', '1-port N-Base-T(1/2.5/5/10GBase-T) interface', '4-port 10/100/1000GBase-T interfaces', 'ITU-T G.9807 compliant XGS-PON ONT', 'XGS-PON data rate of 10Gbps/10Gbps(US/DS)', 'Advanced QoS & Network Management', 'IEEE802.1D and IEEE802.1Q bridging', 'Priority queues and scheduling on Upstream', 'Activation with automatic discovered Serial Number and password', 'Dying Gasp support', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '128MB', '512MB (DDR)', '', '1 x N Base-T(1/2.5/5/10Base-T) (RJ45)', '4 x 10/100/1000Base-T (RJ45)', '1 x XGS-PON (SC/APC)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0 ~ 45°C', '', '20 ~ 90% (non-condensing)', '12VDC 1.5A', '', '', '', '160 x 39.5 x 150 mm', 'xgspon_ont', 'xgsponLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(6, '', 'A', 'h842', 'https://ik.imagekit.io/iamfake/products/ont-h842.png?updatedAt=1750393481115', 'XGSPON', 'ONT', 'dasan', 'H842', 'XGSPON ONT', '1 port 10/100/1000Base-T (RJ45)', '1 port 101GBase-T (RJ45)', '', '', '', '', '', 'The H842 is a high-performance, XGS-PON compliant Optical Network Terminal (ONT) able to support service provider requirements for high-speed data and voice in a cost-effective design. The ONT is fully compliant with ITU-T G.9807.1 XGS-PON standard with integrated, on-board optics supporting 1270nm and 1577nm wavelengths with Class N1 type PMD optical receiver. With leading-edge XGS-PON technology, users can enjoy bandwidth intensive multimedia services such as real-time audio, and gaming much easier and faster than ever before. The H842 provides one XGS-PON interface, one 1/2.5/5/10GBase-T port and one 10/100/1000Base-T port. The ONT contains an integrated L2 switch supporting wire-speed L2 bridging.', 'IPTV multicast, IGMPv2 and IGMPv3 services', 'MTU jumbo frame 9216-byte support', 'Any-port, Any-service data model', 'Traffic management including Q-in-Q tagging, 802.1Q VLANs, multiple subscriber VLANs', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '128MB', '256MB', '', ' 1 port 10/100/1000Base-T (RJ-45)', '1 port 10GBase-T (RJ45)', ' 1 port XGS-PON', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0 to 40 °C', '', '5 to 90 % (non-condensing)', '12VDC 1.5A', '', '', '', '160 × 40 x 140 mm', 'xgspon_ont', 'xgsponLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(7, '', 'A', 'zx-ont-poe', 'https://ik.imagekit.io/iamfake/products/ont%20zaram.png?updatedAt=1753866204414', 'XGSPON', 'ONU PoE', 'zaram', 'ZX-ONT-PoE', 'XGSPON ONU', '1 port 10G/2.5G Ethernet Support PoE', 'ZX-ONT-2.5G: Up to 2.5GbE', 'ZX-ONT-10G: Up to 10GbE', '', '', '', '', 'XGSPON On-board BOSA Compliant with ITU-T G.9807.1 XGS-PON (N1/N2) Support 10Gbps bi-directional traffic capability 1270nm Burst-Mode Transmitter with DFB Laser 1577nm Continuous-Mode Receiver with APD-TIA', 'ZX-ONT-2.5G : 100M/1G/2.5GbE UTP Support', 'ZX-ONT-10G : 100M/1G/2.5G/5G/10G UTP Support', 'POE Powered or Optional 12V Power Adaptor', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '16MB', '64MB LPDDR', '', ' 1 port 2.5GBase-T (RJ-45)', '1 port 10GBase-T (RJ45)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'PoE Powered/DC Terminal', '', '', '', '', 'xgspon_onu', 'xgsponLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(8, '', 'A', 'xgs-pon-8-port', 'https://ik.imagekit.io/iamfake/products/Zaram%20Technology%20Introduction.png?updatedAt=1753863193830', 'XGSPON', 'ONU', 'zaram', 'XGS-PON 8-port', 'XGSPON ONU', '8 port 1GE(1,2 at, 3-8 : af) RJ45', '1 port 10GE/5GE/2.5GE/1G (RJ45)', '10G SFP+ 2port /  1G PoE (PSE 30W) 8-port or 4', '', '', '', '', 'XGSPON ONU Transceiver Compliant with ITU-T G.9807.1 XGS-PON (N1/N2) Support 10Gbps bi-directional traffic capability 1270nm Burst-Mode Transmitter with DFB Laser 1577nm Continuous-Mode Receiver with APD-TIA', 'RJ45 : 8 x 1GE(1,2 at, 3-8 : af)', 'RJ45 : 1 x 10GE/5GE/2.5GE/1G', 'SFP+ : 1', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '16MB', '64MB LPDDR', '', '8 port 1GE(1,2 at, 3-8 : af) RJ45', '1 port 10GE/5GE/2.5GE/1G (RJ45)', '1 port SFP+', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'DC 48VDC', '', '', '', '20 x 210 x 44 mm', 'xgspon_onu', 'xgsponLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(9, '', 'C', 'zxos11epi', 'https://ik.imagekit.io/iamfake/products/zaram-xgspon-gponstick.png?updatedAt=1750406138420', 'XGSPON', 'XGSPON STICK', 'zaram', 'ZXOS11EPI', 'XGSPON STICK', '10 GPON port (SC/UPC, SFP compliant interface)', 'SFP+ XFI interface', '', '', '', '', '', 'XGSPON chip and optical component integrated SFP+ ONU product', 'Low Power Consumption SFP+ Formfactor with Embedded ZX300 SoC', 'Compliant with standard SFP+ form factor SFF-8431, SFF-8472, GR-468', 'XGS-PON uplink, G.9807 series and G.988 GPON OMCI compliant', 'Very low power consumption, typically less than 2W', 'SFF-8472 DDM', 'Class N1/N2', 'APD Receiver : -28.5dBm', '1270nm DFB Burst Laser', 'Commercial/Industrial Temperature', 'IEEE 1588, ToD, SyncE Support(Only EPI supports SyncE)', '10G XFI Interface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Embedded 256Mbit (Serial Flash*1)', '', 'Embedded 512Mbit, LPDDR\"', '', '10 GPON Port (SC/UPC, SFP compliant interface)', 'SFP+ XFI interface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40°C to +85°C', '', '', '≤2.10 W with 3.3V', '', '', '', '', 'xgspon_sfp', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(10, '', 'A', 'v8106', 'https://ik.imagekit.io/iamfake/products/olt-V8106.png?updatedAt=1750091714706', 'GPON', 'OLT', 'dasan', 'V8106', 'GPON OLT', '96 GPON port / 48 XG-PON', '6U chassis', '', '', '', '', '', 'The V8106 is a 6RU height chassis PON Optical Line Termination (OLT) supporting 96 GPON ports as well as a Layer 3 switch of supporting 8 1/10GbE ports Active Ethernet service. It terminates the traffic coming from the subscriber lines and consolidates it on one or more Gigabit Ethernet interfaces towards the metropolitan area. ', 'Shelf with 6/2 slots for SIUs/NIUs for a maximum of interfaces per shelf', '640Gbps switching capacity per unit', 'Dual switch fabric units (SFU)', 'Redundant and load-balanced dual power supply unit (PSU)', 'Hot Swappable for all plug-in units (SFU, SIU, NIU, PSU, FAN)', 'LED alarm indicator', 'Visible alarm indicator', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '36MB (Dual OS)', '2GB DDR3', '', '16 port GPON interface Unit x6', '4 port 10GBase-R interface Unit x2', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-25 to 55°C (-13 to 131°F)', '−40 to 80 °C (-40 to 176°F) ', '0 to 90 % (non-condensing', '−48/60VDC ', '', '', '', '482.6mm x 265.9mm x 280mm', 'gpon_olt', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(11, '', 'A', 'v8102', 'https://ik.imagekit.io/iamfake/products/olt-V8102.png?updatedAt=1750160493023', 'GPON', 'OLT', 'dasan', 'V8102', 'GPON OLT', '32-Port GPON', '2RU height chassis', '', '', '', '', '', 'DASAN Networks V8106 is a chassis system. DASAN Networks V8102 is a 2RU GPON OLT chassis system consisting of 4 slots for 2 modular service slots, 2 fabric switching slots and 2 uplink slots to provide complete features and high performance for FTTx applications. The V8102 OLT is a high-density chassis system that supports up to 4096 residential and business customers with 32 GPON ports (1:128 split ratio). The V8102 GPON OLT supports redundant GPON systems. The V8102 features high-capacity GPON access capacity and 10GbE uplink and line rate performance with non-blocked 320Gbps switch fabric. In addition, V8102 is ready for XG-PON service, it fully supports XG-PON technology with the same chassis. V8102 ensures equipment-level reliability with full redundancy design concept for SFU/Power/GPON units. PON technology adds new features and functionalities targeted to improve performance and interoperability, and adds support for new applications, services, and deployment scenarios.', '320Gbps switching capacity', '2-Slot for switching fabric unit + uplink interface units', '2-Slot for subscriber interface units (SIUs)', 'Redundant and load-balanced dual power supply unit (PSU)', 'Hot swappable FAN unit', 'LED alarm indicator', 'Visible alarm indicator', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8MB Boot, 64MB NOS (dual) ', '2GB (DDR3)', '', '2x 16-port of GPON interfaces (SIU_GPON16)', '4 port of 1G/10GBase-R optical interfaces (SFP/SFP+)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '5~131°F (-15~55°C) ', '-40~158°F (-40~70°C)', '0 to 90 % (non-condensing)', 'DC type: −48/60V ', '', '', 'Approximately 206 W', '297 mm x 20.5 mm x 252.5 mm', 'gpon_olt', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(12, '', 'A', 'v5816', 'https://ik.imagekit.io/iamfake/products/olt-V5816.png?updatedAt=1750160494148', 'GPON', 'OLT', 'dasan', 'V5816', 'GPON OLT', '16p GPON', '4p 1/10GE', 'AC/DC', '', '', '', '', 'As the number of services using internet communications such as broadband internet, internet telephony, and IPTV increases, the need for high-performance network equipment is increasing. This is no exception in areas where population density is low and where there are few customers. You can plan more effectively in terms of network deployment costs. The V5816 is a compact GPON OLT system with 16 GPON ports, 4 1G/10GBase-R ports for uplink, and 4 1000Base-T ports, making it suitable for low-density and low-cost FTTx services. V5816 supports Gigabit ports and is applicable to various network environments. In addition, the redundant power supply is realized so that the network system is not interrupted, ensuring stable service.', '168 Gbps switching capacity', '16 GPON ports, 4 10GE ports and 4 GE (Electric)  ports', 'Reliable FTTx service with power redundancy system', 'Enhanced QoS services', 'IGMP support for IPTV', 'Fully Managed via Dasan’s INAS Element Manager', 'Increased reliability through power redundancy', 'Comfortable network management with SNMPv2 / v3 and RMON', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '125MB', '1GB (DDR3)', '', '16-Port GPON (SFP)', '4 Port 100/1000Base-T (RJ45)', '4 Port 1G/10GBase-R (SFP/SFP+)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-20~60°C', '', '0~90% (non-condensing)', 'DC type : -48/60VDC', '', '', '', '440 x 44 x 300mm', 'gpon_olt', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(13, '', 'A', 'v5808', 'https://ik.imagekit.io/iamfake/products/olt-V5808.png?updatedAt=1750160493762', 'GPON', 'OLT', 'dasan', 'V5808', 'GPON OLT', '8p GPON', '4p 1/10GE', 'AC/DC', '', '', '', '', 'As the number of services using internet communications such as broadband internet, internet telephony, and IPTV increases, the need for high-performance network equipment is increasing. This is no exception in areas where population density is low and where there are few customers. You can plan more effectively in terms of network deployment costs. The V5808 is a compact GPON OLT system with 8 GPON ports, 4 1G/10GBase-R ports for uplink, and 4 1000Base-T ports, making it suitable for low-density and low-cost FTTx services. V5808 supports Gigabit ports and is applicable to various network environments. In addition, the power supply that supports redundant has been realized so that the network system is not disturbed, ensuring stable service.', '8 GPON ports, 10GE 4 ports and GE (Electric) 4 ports', '118 Gbps switching capacity', 'High Capacity Uplink / Service Interface 2.5Gbps (down) / 1.25Gbps (up)', 'Reliable FTTx service with power redundancy system', 'Enhanced QoS services', 'Fully Managed via Dasan’s INAS Element Manager', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '125MB', '1GB (DDR3)', '', '8 GPON(SFP, SC/PC type)', '4 Port 100/1000Base-T (RJ45)', '4 Port 1G/10GBase-R (SFP/SFP+)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-20~60°C', '', '0~90% (non-condensing)', 'DC type : -48/60VDC', '', '', '', '440 x 44 x 300mm', 'gpon_olt', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(14, '', 'B', 'd2224gp', 'https://ik.imagekit.io/iamfake/products/onu-d2224gp.png?updatedAt=1757310940085', 'GPON', 'ONU PoE', 'dasan', 'D2224GP', 'ONU PoE', '24 ports', 'Supports PoE power up to 30W for each PoE port', '24 10/100/1000Mbps Auto MDI/MDI-X Ethernet port', '', '', '', '', 'D2224GP is a high performance the second managed gigabit switch. Provides twenty-four 10/100/1000Mbps self-adaption RJ45 ports, plus four  gigabit  SFP ports, it can be used to link bandwidth higher upstream equipment. Support VLAN ACL based on port, easily implement network monitoring, traffic regulation, priority tag and traffic control. Support traditional STP/RSTP/MSTP 2 link protection technology; greatly improve the ability of fault tolerance, redundancy backup to ensure the stable operation of the network. D2224GP provides perfect QOS strategy and plenty of VLAN function. Support 802. 1x authentication based on the port and MAC, easily set user access. Support ACL control based on the time, easy control the access time accurately. D2224GP\\', '24 10/100/1000Mbps Auto MDI/MDI-X Ethernet port (4 SFP combo ports)', 'Switching Capacity up to 56Gbps', 'Store and forward mode operates', 'Support Web-based Management ', 'Supports PoE power up to30W for each PoE port, total power up to 370W for all PoE ports', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '24 port 10/100/1000Mbps PoE/PoE+', '4 ports 2 x100/1000Mbps SFP port', 'H650SFP : uplink GPON ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0 to 60°C', '', '10 to 90% (non-condensing)', '', '', '', '< 22W (without POE), < 400W (with POE)', '440mm x 44mm x 208mm', 'gpon_onu', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(15, '', 'B', 'd2008gpe', 'https://ik.imagekit.io/iamfake/products/l2-d2008gpe.png?updatedAt=1750233558797', 'GPON', 'ONU PoE', 'dasan', 'D2008GPE', 'ONU PoE', '8 ports', 'Supports PoE power up to 30W for each PoE port', 'Total power up to 150W for all PoE ports', '', '', '', '', 'D2008GPE is a new generation designed for high security and high-performance network the layer 2 switch. Provides eight 10/100/1000Mbps self-adaption RJ45 port, and two 100/1000Mbps SFP ports, all ports support wire-speed forwarding, can provide you with larger network flexibility. All ports support Auto MDI/MDIX function.The Switch with a low-cost, easy-to-use, high performance upgrade your old network to a 1000Mbps Gigabit network. ', 'Switching Capacityup to 20Gbps', 'Supports PoE power up to 30W for each PoE port', 'Total power up to 150W for all PoE ports', 'Support web management', 'High performance, durable stability', 'Intelligent identification', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8 x 10/100/1000Mbps Auto-Negotiation ports', '2 ports 2 x100/1000Mbps SFP port', 'H650SFP : uplink GPON ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0 to 50°C', '', '10 to 90% (non-condensing)', '', '', '', 'Less than 140W (at PoE full-load)', '280 x 44 x 180mm', 'gpon_onu', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(16, '', 'B', 'd2224g', 'https://ik.imagekit.io/iamfake/products/D2224g.png?updatedAt=1757315109362', 'GPON', 'ONU', 'dasan', 'D2224G', 'ONU', '24 port 10/100/1000Mbps Auto MDI/MDI-X Ethernet port', '4 x 100/1000Mbps SFP port', '4 x 100/1000Mbps SFP port', 'Store and forward mode operation', 'Support Web-based Management ', '', '', 'D2224G Supports VLAN ACL based on port, easily implement network monitoring, traffic regulation, priority tag and traffic control. Support traditional STP/RSTP/MSTP2 link protection technology; greatly improve the ability of fault tolerance, redundancy backup to ensure the stable operation of the network. Support ACL control based on the time, easy control the access time accurately. Support 802.1x authentication based on the port and MAC, easily set user access. ', 'Switching Capacity up to 56Gbps', 'Store and forward mode operation', 'Support Web-based Management ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '24 port 10/100/1000Base-T (RJ45)', '4 ports 100/1000Base-SFP', 'H650SFP : uplink GPON ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0℃ - 45℃', '', '10 to 90% (non-condensing)', '', '', '', 'Maximum:20W(220V/50Hz)', '440 x 44 x 208mm', 'gpon_onu', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(17, '', 'A', 'v2224g', 'https://ik.imagekit.io/iamfake/products/onu-v2224g(gp).png?updatedAt=1750481534918', 'GPON', 'ONU', 'dasan', 'V2224G', 'ONU', '24 port 10/100/1000Base-T subscriber ports', 'FTTx deployments for various applications with PON uplink interface', '', '', '', '', '', 'Dasan Networks is a global leader in the delivery of carrier-grade network and customer access solutions that enable high-speed data, voice, video, and wireless services over existing and emerging FTTP (Fiber-tothe-Premise) networks and legacy copper networks.', '24 10/100/1000Base-T subscriber ports', 'FTTx deployments for various applications with PON uplink interface', 'Broadcast/Multicast/Unknown unicast storm control', 'L2/L3/L4 traffic classification/priority management', 'User password protected system management', 'IEEE 802.1x port-based, MAC-based security', 'RADIUS authentication', 'Network management via SNMP v1/v2/v3 and RMON', 'Advanced QoS features (SP/WRR/DRR)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '32MB', '256MB', '', '24 10/100/1000Base-T ports (RJ45)', '2 1000Base-X ports (SFP)', '1 GPON port (SC/APC)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-4~148°F (-20~65°C)', '-40~158°F (-40~70°C)', '0~90% (non-condensing)', '100-240VAC, 50/60Hz', 'ON/OFF (on front panel)', '', 'Max. 40W', '17.32 x 1.73 x 10.47 in (440 x 44 x 266 mm)', 'gpon_onu', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(18, '', 'A', 'v2724gt', 'https://ik.imagekit.io/iamfake/products/l2-v2724gt.png?updatedAt=1750247607040', 'GPON', 'ONU', 'dasan', 'V2724GT', 'ONU', '24 port 1-Gigabit Ethernet interfaces', '4 port 10-Gigabit Ethernet interfaces', '1RU switch installation', '', '', '', '', 'The V2724GT is a cost effective single-board Gigabit Ethernet switch. It has been designed as ultra-compact customer premise equipment with the reliable Layer 2 functionalities. The V2724GT is comprised of 24-port 10/100/1000Base-T(RJ45) and 4-port 10GBase-R(SFP /SFP+). The MGMT and console interface is also located on the front panel with embedded LED for LNK/ACT and TX/RX indication respectively. They are for use of equipment management via remote access or CLI. The V2724GT provides a single AC/DC power connector input and its switch on the front panel. This system supports PSU (AC/DC) and fixed FANs for stable service delivery.', '128Gbps switching capacity', '95Mpps Throughput', '24-port 1 Gibabit Ethernet', '4-port 10 Gigabit Ethernet', 'Extensive Layer2 access switch functions with non-blocking', 'Compact 1 RU chassis suitable for indoor and outdoor deployments, with AC & DC variants', 'Management via CLI or SNMPv2/v3, plus NETCONF/YANG enabled for SDN network', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '512MB', '512MB', '', '24 x 10/100/1000Base-T (RJ45)', '4 x 10GBase-R (SFP/SFP+)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-20 ~ 60°C', '-40 ~ 70°C', '0 ~ 90% (non-condensing)', 'DC 48VDC', 'AC: 100~230VAC', '', '27W', '440 x 44 x 240 mm', 'gpon_onu', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(19, '', 'D', 'h660gm', 'https://ik.imagekit.io/iamfake/products/ont-h660-gm.png?updatedAt=1750092485700', 'GPON', 'ONT', 'dasan', 'H660GM', 'ONT', '4 port 10/100/1000Base-T (RJ-45)', '2 port FXS (RJ-11)', '4 antennas (2T2R), Wi-Fi 802.11b/g/n/ac', '', '', '', '', 'The H660GM provides one GPON uplink port, four Gigabit Ethernet (10/100/1000Base-T) ports, Wireless LAN interface and two FXS voice ports that enhance the ability to deliver demanding data/Wi-Fi/VoIP services. The H660GM uses Session Initiation Protocol (SIP) to terminate VoIP calls so that in-home wiring does not change and standard telephone setsmay be used. The H660GM supports the full triple play of services including voice and highspeed Internet access services.', '', '4-port 10/100/1000Base-T interface', ' 2-port FXS interface for phone service', 'ITU-T G.984.x compliant GPON ONT', 'GPON data rate of 1.2Gbps/2.5Gbps(US/DS)', 'SIP (RFC3261/3262/3264)', 'Advanced QoS & Network Management', 'Multi-Layer Filtering', 'Remote Fault monitoring', 'IEEE 802.1D and IEEE 802.1Q bridging', 'Dying Gasp support', 'IEEE802.11b/g/n/ac compliant', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '128MB', '128MB', '', '4-port 10/100/1000Base-T (RJ-45)', '1 x GPON (SC/APC)', ' 2-port FXS (RJ-11)', '', '', 'Wi-Fi 802.11b/g/n/ac, 4 antennas (2T2R)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-5 to 50 °C', '', '20 to 90 % (non-condensing)', '12VDC 1.5A', '', '', '', '212 × 40 x 140 mm', 'gpon_ont', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(20, '', 'D', 'h660gma', 'https://ik.imagekit.io/iamfake/products/ont-h660-gma.png?updatedAt=1750262804701', 'GPON', 'ONT', 'dasan', 'H660GMA', 'ONT', '4 port 10/100/1000Base-T (RJ-45)', '1 port FXS (RJ-11)', '2 antennas (2T2R), Wi-Fi 802.11b/g/n/ac', '', '', '', '', 'H660GM-A optical network terminal (ONT) is targeted for all subscribers requiring high-speed data interfaces in a cost-effective indoor housing. Fully compliant with ITU-T G.984 standards, the H660GM-A supports data rates of 1.25Gbps upstream and 2.5Gbps downstream. The H660GM-A provides 1 GPON uplink port, 4 Gigabit Ethernet (10/100/1000Base-T) ports, Wireless LAN interface, and 1 FXS voice port that enhance the ability to deliver demanding data/Wi-Fi/VoIP services. The H660GM-A contains both built-in wire-speed L2 switch and L3 routing gateway with port forwarding, NAT and NAPT address translation, PPPoE client support for high speed Internet service.', '1-port GPON interface for uplink', '4-port 10/100/1000Base-T interface', ' 1-port FXS interface for phone service', 'ITU-T G.984.x compliant GPON ONT', 'GPON data rate of 1.2Gbps/2.5Gbps(US/DS)', 'SIP (RFC3261/3262/3264)', 'Advanced QoS & Network Management', 'Multi-Layer Filtering', 'Remote Fault monitoring', 'IEEE 802.1D and IEEE 802.1Q bridging', 'Dying Gasp support', 'IEEE802.11b/g/n/ac compliant', 'Wi-Fi Max Throughput', '300Mbps in 802.11n', '866Mbps in 802.11ac', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '128MB', '256MB (DDR)', '', '4 x 10/100/1000Base-T (RJ45)', '1 x GPON (SC/APC)', '1 x FXS interface (RJ11)', '1 x USB 2.0 (Type A)', '', '2Tx2R, MIMO', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-5 ~ 45°C', '', '20 ~ 90% (non-condensing)', '12VDC 1.0A', '', '', '', '160 x 40 x 140 mm (Antenna excluded) 212.6 x 186.5 x 140 mm (Antenna included)', 'gpon_ont', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(21, '', 'D', 'h660nb', 'https://ik.imagekit.io/iamfake/products/ont-h660nb.png?updatedAt=1750092487672', 'GPON', 'ONT', 'dasan', 'H660NB', 'ONT', '4 port 10/100/500/1000Base-T interface', 'GPON data rate of 1.2Gbps/2.5Gbps(US/DS)', '', '', '', '', '', 'The H660NB is GPON Optical Network Terminal (ONT) compliant with ITU-T G.984 standard. The H660NB is developed for all clients based on GPON technology. GPON technology supports upstream 1.25Gbps and downstream 2.5Gbps data transmission rate. With DNS leading-edge GPON technology, users can enjoy band­width consuming multimedia services such as real-time video, audio and gaming much easier and faster than ever before. The H660NB is comprised of 1 GPON uplink port and 4 Gigabit Ethernet downlink port supporting 10/100/ 500/1000Base-T (RJ45). The H660NB supports high speed internet access service. The H660NB contains both built-in wire-speed L2 switch and L3 routing gateway with port forwarding, NAT and NAPT address translation, multiple PPPoE clients support for high speed internet service.', '1-port GPON interface for uplink', '4-port 10/100/500/1000Base-T interface', 'ITU-T G.984.x compliant GPON ONT', 'GPON data rate of 1.2Gbps/2.5Gbps(US/DS)', 'Advanced QoS & Network Management', 'Protection of delay-sensitive traffic based on SLA', 'Multi-Layer Filtering', 'Remote Fault monitoring', 'IEEE 802.1D and IEEE 802.1Q bridging', 'Dying Gasp support', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '128MB', '128MB (DDR)', '', '4 x 10/100/500/1000Base-T (RJ45)', '1 x GPON (SC/APC)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-5 ~ 50°C', '', '0 ~ 95% (non-condensing)', '5VDC 2A', '', '', '', '180 x 131 x 28 mm (Foot exluded)', 'gpon_ont', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(22, '', 'D', 'h665pdc', 'https://ik.imagekit.io/iamfake/products/ont-h665pdc.png?updatedAt=1750602181268', 'GPON', 'ONT', 'dasan', 'H665PDC', 'ONT', '1 port 100M/1G/2.5GBase-T (RJ45)', '1 x GPON (SC/PC)', 'LAN port: PoE PD 802.3af', '', '', '', '', 'The H665PDC is the GPON optical network terminal (ONT) incorporates interoperability, key customers’ specific requirements and cost-efficiency. Fully com­pliant with ITU-T G.984.x standard, the H665PDC supports data rates of 1.25Gbps upstream and 2.5 Gbps downstream. With DNS leading-edge GPON technology, users can enjoy bandwidth-intensive multimedia services. The H665PDC provides 1 GPON uplink port, 1 GE (100M/1G/2.5GBase-T) port. GPON uplink port has SFF connector type and a high-speed optical access method that has been defined in ITU-T G.9807. The H665PDC is designed to provide a simple and cost-effective GPON network connection and combines the benefits of high-speed GPON technology and enables many interactive multi-media applications such as collaborative computing using fiber network.', '1 port GPON interface for uplink', '1 port 100M/1G/2.5GBase-T interface', 'ITU-T G.984.x compliant GPON ONT', 'GPON data rate of 1.2Gbps/2.5Gbps(US/DS)', 'Advanced QoS & Network Management', 'Protection of delay-sensitive traffic based on SLA', 'Multi-Layer Filtering', 'Remote Fault monitoring', 'IEEE 802.1D and IEEE 802.1Q bridging', 'Dying Gasp support', 'Supports PoE PD 802.3af', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '256MB', '256MB (DDR)', '', '1 x 100M/1G/2.5GBase-T (RJ45)', '1 x GPON (SC/PC)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-20 ~ 60°C', '', '5 ~ 95% (non-condensing)', 'LAN port: PoE PD 802.3af', '', '', '', '28 x 66 x 108 mm', 'gpon_ont', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(23, '', 'C', 'h650', 'https://ik.imagekit.io/iamfake/products/H650SFP.png?updatedAt=1750092485793', 'GPON', 'GPON STICK', 'dasan', 'H650', 'GPON STICK', '1 Port 1000Base-X (SFP)', 'Up 1.25Gbps / Down 2.5Gbps', '', '', '', '', '', 'H650SFP is a Gigabit Passive Optical Network (GPON) stick type SFP, which is an ultra-small GPON ONT like SFP module. GPON Stick is an installable and removable product such as FTTx or wireless backhaul applications with small size and low power consumption.', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '32MB', '1GB DDR3', '', '1 Port 1000Base-X (SFP)', '1 Port GPON (SC/APC)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40 to 85°C', '', '', 'Input : 3.14 to 3.46VAC', '', '', '', '', 'optic_onu', 'gponline', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(24, '', 'E', 'v8610', 'https://ik.imagekit.io/iamfake/products/switch-v-8610.png?updatedAt=1750511649041', 'SWITCH', 'BACKBONE', 'dasan', 'V8610', 'BACKBONE SWITCH', '96 port 40G/100G', '384 port 1G/10G', 'SIZE 18U', '', '', '', '', 'The V8610 switch is designed to meet the needs of cloud data center applications, providing virtualization, high availability, high performance, various functions and flexible configuration to build a powerful core network with easy and simple configuration, and has all the elements necessary to evolve to the next-generation cloud architecture.', 'Up to 8 Ethernet interface line cards', 'Standard Ethernet Bridging', 'All IPv4/IPv6 tunnelling', 'Multiprotocol Label Switiching', 'SP, WRR, DRR, WFQ, RED/WRED, Rate Limit', 'Dustproof and waterproof: IP31', 'IGMPv1/v2/v3, PIM-DM/SM/SSM, MSDP IGMP snooping, PIM-DM/SMv6, MLD', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '19.2Tbps', '14,285Mpps', '', '', 'Up to 8 Ethernet interface line cards :', 'Supports 100/1000BASE-X', 'Supports 10/100/1000BASE-T (RJ-45)', 'Supports 10/100/1000BASE-T (RJ-45) POE', 'Supports 1G/10G/40G/100G', '', '', 'Common Specifications :', '1-port console (RJ-45)', '1-port 10/100/1000BASE-T MGMT', '1-port SD card', '1-port USB', '1 Port Console(RJ45)', '1 Port Reset Key (Restore Factory Key)', '1 Port USB Host v2.0', '', '512K(Max)', '512K(Max)', 'IP31', '67.4dB @35°C, 77.4dB @50°C', '>200K hours', '0~50℃', '-40~70℃', '10~90% (non-condensing)', '90~180/180~264VAC (50/60Hz)', '1600W @ 180~264V per module', '', '', '442 x 530 x 797.3 mm (18U height, weight Up to 146Kg)', 'core', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(25, '', 'E', 'v8607', 'https://ik.imagekit.io/iamfake/products/switch-v-8607.png?updatedAt=1750560970997', 'SWITCH', 'BACKBONE', 'dasan', 'V8607', 'BACKBONE SWITCH', '60 port 40G/100G', '240 port 1G/10G', 'SIZE 8U', '', '', '', '', 'The V8607 switch is designed to meet the needs of cloud data center applications, providing virtualization, high availability, high performance, various functions and flexible configuration to build a powerful core network with easy and simple configuration, and has all the elements needed to evolve to the next-generation cloud architecture. The V8607 switch supports up to 12Tbps of capacity and consists of a total of 5 line card slots. Depending on the selection of line cards, it provides up to 240 Gigabit Ethernet ports, up to 240 10G Ethernet ports or up to 120 40G Ethernet ports, providing a solution suitable for building a medium-sized core network or aggregating sub-networks, providing sufficient capacity to support end users to build data center-class networks in the enterprise, public, building and defense sectors. The V8607 switch ensures perfect stability and availability through data center network protocols, various virtualization technologies, Software Defined Network technologies including OpenFlow, and multiple configurations of management modules and power supplies.', 'Up to 5 Ethernet interface line cards', 'Standard Ethernet Bridging', 'All IPv4/IPv6 tunnelling', 'Multiprotocol Label Switiching', 'SP, WRR, DRR, WFQ, RED/WRED, Rate Limit', 'Dustproof and waterproof: IP31', 'IGMPv1/v2/v3, PIM-DM/SM/SSM, MSDP IGMP snooping, PIM-DM/SMv6, MLD', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '12Tbps', '8,928Mpps', '', '', 'Up to 5 Ethernet interface line cards', 'Supports 100/1000BASE-X', 'Supports 10/100/1000BASE-T (RJ-45)', 'Supports 10/100/1000BASE-T (RJ-45) POE', 'Supports 1G/10G/40G/100G', '', '', 'Common Specifications', '1-port console (RJ-45)', '1-port 10/100/1000BASE-T MGMT', '1-port SD card', '1-port USB', '1 Port Console(RJ45)', '1 Port Reset Key (Restore Factory Key)', '1 Port USB Host v2.0', '', '512K(Max)', '512K(Max)', 'IP31', '59.3dB @35°C, 68.4dB @50°C', '>200K hours', '0~50℃', '-40~70℃', '10~90% (non-condensing)', '90~180/180~264VAC (50/60Hz)', '1600W @ 180~264V per module', '', '', '442 x 530 x 352.8 mm (8U height, weight Up to 66Kg', 'core', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(26, '', 'E', 'v8605', 'https://ik.imagekit.io/iamfake/products/switch-v-8605.png?updatedAt=1750562806237', 'SWITCH', 'BACKBONE', 'dasan', 'V8605', 'BACKBONE SWITCH', '36x40G Port', '144x1G/10G Port', 'SIZE 5U', '', '', '', '', 'The V8605 switch is designed to meet the needs of cloud data center applications, providing  virtualization, high availability, high performance, various features and flexible configurations to build a powerful core network with easy and simple configuration , and has all the elements needed to evolve to the next-generation cloud architecture. The V8605 switch supports up to 7.2TBPS capacity and consists of a total of 3 line card slots.', 'Up to 3 Ethernet interface line cards', 'Standard Ethernet Bridging', 'All IPv4/IPv6 tunnelling', 'Multiprotocol Label Switiching', 'SP, WRR, DRR, WFQ, RED/WRED, Rate Limit', 'Dustproof and waterproof: IP31', 'IGMPv1/v2/v3, PIM-DM/SM/SSM, MSDP IGMP snooping, PIM-DM/SMv6, MLD', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '7.2Tbps', '5,357Mpps', '', '', 'Up to 3 Ethernet interface line cards', 'Supports 100/1000BASE-X', 'Supports 10/100/1000BASE-T (RJ-45)', 'Supports 10/100/1000BASE-T (RJ-45) POE', 'Supports 1G/10G/40G/100G', '', '', 'Common Specifications', '1-port console (RJ-45)', '1-port 10/100/1000BASE-T MGMT', '1-port SD card', '1-port USB', '1 Port Console(RJ45)', '1 Port Reset Key (Restore Factory Key)', '1 Port USB Host v2.0', '', '512K(Max)', '512K(Max)', 'IP31', '56.6dB @35°C, 66dB @50°C', '>200K hours', '0~50℃', '-40~70℃', '10~90% (non-condensing)', '90~180/180~264VAC (50/60Hz)', '1600W @ 180~264V per module', '', '', '442 x 530 x 219.5 mm (5U height, weight Up to 42Kg)', 'core', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(27, '', 'A', 'm4000', 'https://ik.imagekit.io/iamfake/products/l3-m4000.png?updatedAt=1750566382772', 'SWITCH', 'L3 SWITCH', 'dasan', 'M4000', 'L3 SWITCH', '32 port x 10/25GBase-R (SFP28)', '2 slot power for PSU_DC/PSU_AC', 'Redundant dual power supply unit (PSU)', 'Hot Swappable for all plug-in units (PSU and FAN)', '1RU type front access device', '', '', 'The M4000 Mobile Backhaul access/aggregation CSR (Cell Site Router) 1U height chassis provides a variety of solutions to configure the unit according to the net­work environment. The M4000 is comprised of 32 optical 10/25GE ports and 2 100GE ports.', 'Max. 360 Gbps switching capacity base on I/O full duplex', 'Main switching block in Base board with fixed I/O Interface', '1-port alarm interface', 'Support dual power supplies for redundancy', 'Clock Synchronization IEEE 1588v2 (TC/BC)', 'Synchronous Ethernet', 'Management via CLI or SNMPv1/v2/v3 and RMON', 'User password protected system management', 'Data secured through SSH', 'Enhanced security through RADIUS and TACACS+', 'Remote network management', 'L2/L3/L4 based ACL (Access Control List)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8MB (Boot), 512MB (NOS)', '4GB (DDR4)', '', '32 port- 1GBase-R (SFP) or 10GBase-R (SFP+) or 25GBase-R (SFP28)', '2 port- 100GBase-R (SFP+)', '1 port (RJ45 to RS232)', '1 Port 100/1000Base-T (RJ45)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40 to 149°F (-40 to 65°C)', '-40 to 158°F (-40 to 70°C)', '5 to 95% non-condensing', 'AC: 110~220VAC (50/60Hz) ', 'DC : -48VDC', '', 'Max. 200W (AC), 190W ( DC )', '444 mm x 44 mm x 250 mm (19\"\" x 1U)', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(28, '', 'B', 'm3500', 'https://ik.imagekit.io/iamfake/products/l3-m3500.png?updatedAt=1750569726288', 'SWITCH', 'L3 SWITCH', 'dasan', 'M3500', 'L3 SWITCH', '48 port - 1GBase-R (SFP) or 10GBase-R (SFP+) or 25GBase-R (SFP28)', 'Hardware-based IPv4/IPv6 Routing Protocol support', 'OS redundancy (supports booting of standby OS in case of primary OS failure)', '', '', '', '', 'The M3500 is a 1-rack-unit (1RU) carrier Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. The M3500 is comprised of fixed 48 optical 1GE(SFP) or 10GE(SFP+) or 25GE(SFP28) ports and 6 40GE(QSFP28) or 100GE(QSFP28) ports of the optional uplink modules on the front panel. It offers flexible interface to make up diversity network services and benefit of network extension.', 'Max. 3.6T switching capacity base on I/O full duplex', '48 subscriber interface ports', '6 optional expansion uplink interface ports', 'Support dual power supplies for redundancy', 'Ultra low latency', 'High density 48-port 10GE switch', 'Management via CLI or SNMPv1/v2/v3 and RMON', 'User password protected system management', 'Data secured through SSH', 'Enhanced security through RADIUS and TACACS+', 'Remote network management', 'L2/L3/L4 based ACL (Access Control List)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '48 port- 1GBase-R (SFP) or 10GBase-R (SFP+) or 25GBase-R (SFP28)', '6 port- 40G/100GBase-R (QSFP28)', 'RS232(RJ-45) 1 port', '10/100/1000Base-T 1 port', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0 ~ 50°C', '', '10 ~ 80% (non-condensing)', '24/48VDC', '110-220VAC, 50/60Hz ', '', '66W (25G LR x 48 + 100G LR x 6) 324W (25G ER-Lite X 48 + 100G ER-Lite x 6)', '440 x 44 x 415.8 mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17');
INSERT INTO `public_products` (`id`, `sku`, `module`, `slug`, `image`, `category`, `sub_category`, `brand`, `title`, `subtitle`, `spec1`, `spec2`, `spec3`, `spec4`, `spec5`, `spec6`, `spec7`, `descriptions`, `fitur1`, `fitur2`, `fitur3`, `fitur4`, `fitur5`, `fitur6`, `fitur7`, `fitur8`, `fitur9`, `fitur10`, `fitur11`, `fitur12`, `fitur13`, `fitur14`, `fitur15`, `wireless_standard`, `wireless_stream`, `wireless_stream1`, `wireless_stream2`, `wireless_stream3`, `wireless_stream4`, `wireless_stream5`, `manageable_aps`, `ap_number`, `number_of_clients`, `capacity`, `ip_rating`, `switching`, `throughput`, `flash_memory`, `sdram_memory`, `interface_main`, `interface1`, `interface2`, `interface3`, `interface4`, `interface5`, `antena`, `cu`, `cu1`, `cu2`, `cu3`, `cu4`, `additional_interface1`, `additional_interface2`, `additional_interface3`, `additional_interface4`, `mac_address`, `routing_table`, `dustproof_waterproof`, `noise`, `mtbf`, `operating_temperature`, `storage_temperature`, `operating_humidity`, `power1`, `power2`, `power3`, `power_consumptions`, `dimensions`, `diagram`, `network_diagram`, `is_active`, `sort_order`, `created_at`, `updated_at`) VALUES
(29, '', 'B', 'm3000', 'https://ik.imagekit.io/iamfake/products/m3000.png?updatedAt=1750577572759', 'SWITCH', 'L3 SWITCH', 'dasan', 'M3000', 'L3 SWITCH', '24 port - 1GBase-R (SFP) or 10GBase-R (SFP+) or 25GBase-R (SFP28)', '4 port - 40GBase-R (QSFP+) or 100GBase-R (QSFP28)', '', '', '', '', '', 'The M3000 is a cost-effective carrier Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. It has been designed for mobile backhaul networks with demanding subscriber bandwidth requirements and rigid quality-of­service and security needs. The M3000 can be used for a variety of new, revenue-generating applications, for example as L2/L3 Ethernet LAN switches in high rise buildings or as datacenter appli­cation and aggregation switches. Additionally, M3000 switch helps to enhance network efficiency through offering dedicated L3 functionality. The M3000 offers timing services, allowing for mobile clock­ing synchronization from the core of the network. M3000 can be used for various application scenarios as a mobile backhaul switch for the mobile, business, and residential markets.', 'Max. 1000Gbps switching capacity base on I/O full duplex', 'Support 10/25/40/100G Ethernet interfaces', '1-port ALARM interface', 'IEEE 1588v2 (TC/BC)', 'Synchronization Ethernet (SyncE)', 'Management via CLI or SNMPv2/v3', 'User password protected system management', 'Data secured through SSH', 'Remote network management', 'L2 Switching and Ethernet bridging', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '24 port- 1GBase-R (SFP) or 10GBase-R (SFP+) or 25GBase-R (SFP28)', '4 port- 40GBase-R (QSFP+) or 100GBase-R (QSFP28)', '1 x Alarm (RJ45) - 3-ports input/1-port output', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-20 ~ 60°C', '', '10 ~ 80% (non-condensing)', 'DC 24/48 VDC', 'AC: 100-240 VAC', '', 'Max. 270W', '440 x 44 x 415.8 mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(30, '', 'A', 'v6848xg', 'https://ik.imagekit.io/iamfake/products/l3-switch-v6848xg.png?updatedAt=1750584948856', 'SWITCH', 'L3 SWITCH', 'dasan', 'V6848XG', 'L3 SWITCH', '48 port 10GbE (SFP+) or 1G (SFP)', 'End-to-end 10GbE data center solution', 'Support for stable service through power redundancy', '', '', '', '', 'Dasan Networks\\', '48 10GbE (SFP+) or 1G (SFP) ports', 'End-to-end 10GbE data center solution', '960Gbps switching capacity', '714Mpps packet processing speed', 'Enhanced QoS features, VLAN, multimedia switching support', 'Stable service and flexible network configuration management', 'Support for stable service through power redundancy', 'Convenient network management through SNMPv1/v2/v3 and RMON', 'Enhanced security features with SSH/IEEE 802.1x network login method', 'Strengthening system and network security through RADIUS and TACACS+', 'User-friendly CLI using console and telnet, etc.', 'Provides L2/L3/L4 H/W-based ACL', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8MB+64MB', '2GB DDR3', '', '48 Port 10GbE (SFP+) or 1G(SFP)', '1 Port (RJ45 to RS232)', '1 port 10/100/1000Base-T', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '32~122°F (0~50°C)', '-40~158°F (-40~70°C)', '0~80% (non-condensing)', 'AC: 100~240VAC (50/60Hz)', 'DC: -20~-60VDC', '', 'Max. 160W', '440 x 44 x 418 mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(31, '', 'B', 'd5128g', 'https://ik.imagekit.io/iamfake/products/l3-switch-d5128g.png?updatedAt=1750592107711', 'SWITCH', 'L3 SWITCH', 'dasan', 'D5128G', 'L3 SWITCH', '28 1GbE (28 ports RJ45, 4 combo SFP)', '4 port 1G/10GBASE-X (SFP/SFP+)', 'Improved stability through power redundancy', '', '', '', '', 'The D5128G switch is a next-generation multiservice switch that delivers superior performance and enhanced security features. The D5128G provides flexible Gigabit and 10 Gigabit interfaces. It is a highly versatile combo-type product that can provide 4 SFP ports out of 28 GTX ports as service ports. The D5128G supports VSU (Virtual Switch Unit) technology, allowing up to 9 switches to be managed as a single switch. The D5128G provides a PSU (power supply unit) slot that can be equipped with an AC power module and implements power module redundancy to ensure reliability.', '296Gbps switching capacity', '28 1GbE (28 ports RJ45, 4 combo SFP)', 'Provides 4 1G/10GbE (SFP/SFP+) ports', 'Improved stability through power redundancy', 'Stable service and flexible network configuration management', 'VSU(Virtual Switch Unit): Up to 9 members', 'Convenient network management through SNMPv1/v2/v3 and RMON', 'Enhanced security features with SSH/IEEE 802.1x network login method', 'Strengthening system and network security through RADIUS and TACACS+', 'User-friendly CLI using console and telnet, etc.', 'Provides L2/L3/L4 H/W-based ACL', 'Supports Ethernet Ring Protocol (ERPS)', 'IPv4/v6 support', 'OpenFlow 1.0 & 1.3 support', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '28 Port 10/100/1000Base-T (4Port 100/1000Base-X Combo)', '4 port 1G/10GBASE-X (SFP/SFP+)', '1 port RJ45, 1 Port Mini USB Console', '1 Port RJ45, 1 Port USB 2.0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0°C ~ 50°C', '-40°C ~ 70°C', '5% to 90% (non-condensing)', 'AC: 100V to 240VAC (50/60Hz)', 'HVDC: 120V to 340VDC', 'DC: -36V to -72V', 'Max.45W', '440 × 44 × 280 mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(32, '', 'A', 'v5648g', 'https://ik.imagekit.io/iamfake/products/l3-switch-v5648g.png?updatedAt=1750592025655', 'SWITCH', 'L3 SWITCH', 'dasan', 'V5648G', 'L3 SWITCH', '48 1GbE (RJ45) +4 10GbE (SFP+)', '4 port 100/1000M Base-X, 10GBase-R compatible (SFP/SFP+)', 'Provides redundant power supply units (PSU)', '', '', '', '', 'The V5648G is a 1U high-performance stand-alone enterprise L3 switch designed for data center, campus, and branch office environments. The V5648G provides 48 ports of Gigabit Ethernet interfaces (RJ-45) and provides high-bandwidth switching, filtering, and traffic management capabilities without compromising performance. The V5648G not only provides LLDP (Link Layer Discovery Protocol) to discover network problems and strengthen network management in environments where multiple heterogeneous devices are operated in combination, but also supports additional functions such as LLDP-MED and DHCP Snooping to strengthen network security in the future. The V5648G provides a PSU (power supply unit) slot that can be equipped with an AC power module and implements power module redundancy to ensure reliability.', '48 1GbE (RJ45) +4 10GbE (SFP+)', '216Gbps switching capacity', 'Provides redundant power supply units (PSU)', 'Support for standards-based management protocols (SNMP v1/v2/v3&RMON)', 'Secure system access via SSH', 'Strengthening network security through RADIUS&TACTAS+', 'Provides remote network management functions', 'User-centric CLI', 'Hardware-based L2/L3/L4 ACL', 'Application of security compliance verification', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '128MB(256MB)', '512MB (SDRAM)', '', '48 Port 10/100/1000 Base-T(RJ-45)', '4 Port 100/1000M Base-X, 10GBase-R compatible (SFP/SFP+)', '1 port 10/100/1000Base-T(RJ-45)', '1 Console (RJ45)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-20°C ~ +60°C', '', '0%~90%(Non-Condensing), 50/60Hz', 'AC Input type: 100~240VAC, 50/60Hz', '', '', '', '440 x 44 x 280mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(33, '', 'A', 'v5624g', 'https://ik.imagekit.io/iamfake/products/l3-switch-v5624g.png?updatedAt=1750593563242', 'SWITCH', 'L3 SWITCH', 'dasan', 'V5624G', 'L3 SWITCH', '24 port 1GbE combo (RJ45, SFP)', '6 port 1G/10GBase-R (SFP/SFP+)', 'Improved stability through power redundancy', 'Smart Buffer', '', '', '', 'The V5624G is a highly versatile combo-type product that can be provided with a choice of 24 ports of GTx and SFP (RJ-45/SFP provided). The V5624G provides high-bandwidth switching, filtering, and traffic management functions without delaying data. Additionally, the V5624G supports LLDP (Link Layer Discovery Protocol) as well as LLDP-MED and DHCP snooping, which is beneficial for expanding/enforcing network security and enables troubleshooting and improved network management. The V5624G provides a PSU (power supply unit) slot that can be equipped with an AC power module and implements power module redundancy to ensure reliability.', 'Supports 24 1GbE (combo) + 6 1G/10GbE (SFP/SFP+) ports', '168Gbps switching capacity', 'Improved stability through power redundancy', 'Stable service and flexible network configuration management', 'Smart Buffer', 'Convenient network management through SNMPv1/v2/v3 and RMON', 'Enhanced security features with SSH/IEEE 802.1x network login method', 'Strengthening system and network security through RADIUS and TACACS+', 'User-friendly CLI using console and telnet, etc.', 'Provides L2/L3/L4 H/W-based ACL', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '128MB', '512MB(SDRAM)', '', '24 port 1GbE combo (RJ45, SFP)', '6 port 1G/10GBase-R (SFP/SFP+)', '1 port (RJ45 to RS232)', '1 port(RJ45)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-20 ~ 60°C', '-40 ~ 80°C', '0~90% (non-condensing)', 'AC: 100~240VAC (50/60Hz)', 'DC: -20~-60VDC', '', 'Max. 61W', '440 x 44 x 325mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(34, '', 'A', 'c2100', 'https://ik.imagekit.io/iamfake/products/l2-c2100.png?updatedAt=1750596948083', 'SWITCH', 'L2 SWITCH', 'dasan', 'C2100', 'L2 SWITCH', '8 x 10/25GBase-R (SFP+/SFP28)', '2 x 1/10GBase-R (SFP/SFP+)', '2 x 100GBase-R (QSFP28)', '1 x 100GBase-R (QSFP-DD)', '', '', '', 'The C2100 is a cost-effective compact Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. It has been designed for mobile fronthaul networks with demanding subscriber bandwidth requirements and rigid quality-of­service and security needs. The C2100 can be used for a variety of new, revenue-generating applications, for example as L2 Ethernet LAN switches in high rise buildings or as datacenter application and aggregation switches. The C2100 offers clock synchronization services, allowing for mobile clocking synchronization from the core of the network. The C2100 can be used for various application scenarios as a mobile fronthaul switch for the mobile, busi­ness, and residential markets.', 'Support 1/10/25/100G Ethernet interfaces', 'Cell Site Fronthaul Switch', 'IEEE 1588v2 Clock Synchronization', 'Synchronization Ethernet (SyncE)', 'Management via CLI or SNMPv2/v3', 'User password protected system management', 'Data secured through SSH', 'Remote network management', 'L2 Switching and Ethernet bridging', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '512MB NAND (NOS)', '4GB DDR4 with ECC', '', '2 port 1/10GBase-R (SFP/SFP+)', '8 port 1/10/25GBase-R (SFP+/SFP28)', '2 port 100GBase-R (QSFP28)', '1 port GNSS (SMA)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40 ~ 65°C', '-20℃ ~ 70℃', '5% ~ 95% (non-condensing)', 'AC : 100/220 VAC', 'DC : 48 VDC', '', 'Approximately 105W', '330 x 44 x 200mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(35, '', 'A', 'c2200', 'https://ik.imagekit.io/iamfake/products/l2-c2200.png?updatedAt=1750657386523', 'SWITCH', 'L2 SWITCH', 'dasan', 'C2200', 'L2 SWITCH', '24 x 10/25GBase-R (SFP+/SFP28)', '4 x 1/10GBase-R (SFP/SFP+)', '4 x 100GBase-R (QSFP28/QSFP-DD)', '', '', '', '', 'The C2200 is a cost-effective carrier Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. It has been designed for mobile fronthaul networks with demanding subscriber bandwidth requirements and rigid quality-of­service and security needs. The C2200 can be used for a variety of new, revenue-generating applications, for example as L2 Ethernet LAN switches in high rise buildings or as datacenter application and aggregation switches. The C2200 offers clock synchronization services, allowing for mobile clocking synchronization from the core of the network. The C2200 can be used for various application scenarios as a mobile fronthaul switch for the mobile, busi­ness, and residential markets.', 'Support 10/25/100G Ethernet interfaces', 'eCPRI fronthaul gateway', 'IEEE 1588v2 Clock Synchronization', 'Synchronization Ethernet (SyncE)', 'Management via CLI or SNMPv2/v3', 'User password protected system management', 'Data secured through SSH', 'Remote network management', 'L2 Switching and Ethernet bridging', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '512MB NAND (NOS)', '4GB DDR4 with ECC', '', '4 port 1/10GBase-R (SFP/SFP+)', '24 port 10/25GBase-R (SFP+/SFP28)', '4 port 100GBase-R (QSFP28/QSFP-DD)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40 ~ 65°C', '-40℃ ~ 70℃', '5 ~ 95% (non-condensing)', 'AC: 100-240 VAC', 'DC: 48 VDC', '', '160.7W (PSU DC) 182.2W (PSU AC)', '444 x 44 x 250 mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(36, '', 'A', 'c2300', 'https://ik.imagekit.io/iamfake/products/l2-c2300.png?updatedAt=1750657960946', 'SWITCH', 'L2 SWITCH', 'dasan', 'C2300', 'L2 SWITCH', '16 x 10/25GBase-R (SFP+/SFP28)', '4 x 1/10GBase-R (SFP/SFP+)', '6 x 100GBase-R (QSFP28/QSFP-DD)', '', '', '', '', 'The C2300 is a cost-effective carrier Ethernet switch to support the packet-based transport technology that is based upon circuit-based transport networking. It has been designed for mobile fronthaul networks with demanding subscriber bandwidth requirements and rigid quality-of­service and security needs. The C2300 can be used for a variety of new, revenue-generating applications, for example as L2 Ethernet LAN switches in high rise buildings or as datacenter application and aggregation switches. The C2300 offers clock synchronization services, allowing for mobile clocking synchronization from the core of the network. The C2300 can be used for various application scenarios as a mobile fronthaul switch for the mobile, busi­ness, and residential markets.', 'Support 10/25/100G Ethernet interfaces', 'eCPRI fronthaul gateway', 'IEEE 1588v2 Clock Synchronization', 'Synchronization Ethernet (SyncE)', 'Management via CLI or SNMPv2/v3', 'User password protected system management', 'Data secured through SSH', 'Remote network management', 'L2 Switching and Ethernet bridging', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Flash 1GB (NOS)', '4GB DDR4 with ECC', '', '4 port 1/10GBase-R (SFP/SFP+)', '16 port 10/25GBase-R (SFP+/SFP28)', '6 port 100GBase-R (QSFP28/QSFP-DD)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40 ~ 65°C', '-40℃ ~ 70℃', '5 ~ 95% (non-condensing)', 'AC: 100-240 VAC', 'DC: 48 VDC', '', '170W (PSU DC) 180W (PSU AC)', '444 x 44 x 250 mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(37, '', 'B', 'd2224g-1', 'https://ik.imagekit.io/iamfake/products/D2224g.png?updatedAt=1750092485713', 'SWITCH', 'L2 SWITCH', 'dasan', 'D2224G', 'L2 SWITCH', '24 x 10/100/1000Mbps Auto MDI/MDI-X Ethernet port', '4 x 100/1000Mbps SFP port', '4 x 100/1000Mbps SFP port', 'Store and forward mode operation', 'Support Web-based Management ', '', '', 'D2224G Supports VLAN ACL based on port, easily implement network monitoring, traffic regulation, priority tag and traffic control. Support traditional STP/RSTP/MSTP2 link protection technology; greatly improve the ability of fault tolerance, redundancy backup to ensure the stable operation of the network. Support ACL control based on the time, easy control the access time accurately. Support 802.1x authentication based on the port and MAC, easily set user access. ', 'Switching Capacity up to 56Gbps', 'Store and forward mode operation', 'Support Web-based Management ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '24 port 10/100/1000Base-T (RJ45)', '4 ports 100/1000Base-SFP', 'H650SFP : uplink GPON ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0℃ - 45℃', '', '10 to 90% (non-condensing)', '', '', '', 'Maximum:20W(220V/50Hz)', '440 x 44 x 208mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(38, '', 'A', 'v2724gt-1', 'https://ik.imagekit.io/iamfake/products/l2-v2724gt.png?updatedAt=1750247607040', 'SWITCH', 'L2 SWITCH', 'dasan', 'V2724GT', 'L2 SWITCH', '24 port 1-Gigabit Ethernet interfaces', '4 port 10-Gigabit Ethernet interfaces', '1RU switch installation', '', '', '', '', 'The V2724GT is a cost effective single-board Gigabit Ethernet switch. It has been designed as ultra-compact customer premise equipment with the reliable Layer 2 functionalities. The V2724GT is comprised of 24-port 10/100/1000Base-T(RJ45) and 4-port 10GBase-R(SFP /SFP+). The MGMT and console interface is also located on the front panel with embedded LED for LNK/ACT and TX/RX indication respectively. They are for use of equipment management via remote access or CLI. The V2724GT provides a single AC/DC power connector input and its switch on the front panel. This system supports PSU (AC/DC) and fixed FANs for stable service delivery.', '128Gbps switching capacity', '95Mpps Throughput', '24-port 1 Gibabit Ethernet', '4-port 10 Gigabit Ethernet', 'Extensive Layer2 access switch functions with non-blocking', 'Compact 1 RU chassis suitable for indoor and outdoor deployments, with AC & DC variants', 'Management via CLI or SNMPv2/v3, plus NETCONF/YANG enabled for SDN network', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '512MB', '512MB', '', '24 x 10/100/1000Base-T (RJ45)', '4 x 10GBase-R (SFP/SFP+)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-20 ~ 60°C', '-40 ~ 70°C', '0 ~ 90% (non-condensing)', 'DC 48VDC', 'AC: 100~230VAC', '', '27W', '440 x 44 x 240 mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(39, '', 'F', 'd2448gp', 'https://ik.imagekit.io/iamfake/products/l3-switch-d2648gp.png?updatedAt=1750664449839', 'SWITCH', 'PoE SWITCH', 'dasan', 'D2448GP', 'PoE SWITCH', '48 port 10/100/1000/BASE-T PoE/PoE+', '2 port 100/1000EASE-X Combo', '2 port 1G/10G BASE-X', '', '', '', '', 'The D2648GP from Dasan Networks is a gigabit Ethernet L3 switch that supports Power over Ethernet (PoE/PoE+) on 24 service ports. It also supports IPv4/IPv6 routing, allowing it to function as both a centralized switch and a PoE switch at the same time, and provides a 10G uplink to ensure expandability for future traffic increases. The D2648GP supports PoE, allowing it to supply data and power to connected terminals simultaneously via Ethernet cables, eliminating the need for separate power connections for each device, which can reduce costs. The D2648GP provides dynamic IP routing, ACL, QoS, and Multicast functions to ensure stable network communication and build a flexible and stable network. It also offers a wide range of performance, reliability, and enhanced network management functions to enable efficient network construction and differentiated service provision.', '48 ports of 1G PoE and up to 4 ports of 10G uplink', 'Stacking: Up to 9 Members', 'Provides L2/L3/L4 H/W-based ACL', 'Accommodates diverse requirements utilizing 1G or 10G uplink', 'L2/L3/L4 Traffic Classification and QoS', 'System protection and management through differential management of permissions by user level', 'IEEE 802.1x authentication support', 'RADIUS/TACACS+ authentication', 'Network management via SNMP v1/v2/v3 and RMON', 'Power supply redundancy and hot-swap support', 'PoE(15.4W) / PoE+(30W)', 'Supports Ethernet Ring Protocol (ERPS)', 'IPv6 support', 'SDN Ready', '', '', '', '', '', '', '', '', '', '', '', '', '', '176Gbps', '131Mpps', '', '', '', '48 port 10/100/1000/BASE-T PoE/PoE+', '2 port 100/1000EASE-X Combo', '2 port 1G/10G BASE-X', '1 port RJ45', '', '', '', '', '', '', '', '', 'Expansion module (rear): max 2 port 1G/10G BASE-X', '', '', '', '', '', '', '', '0℃ ~ 50℃', '-40℃ ~ 70℃', '10% to 90% (non-condensing)', '100V to 240VAC (50/60Hz), power supply dualization (removable) support', 'Supports 500W (PoE 370W) redundancy or 1150W (PoE 740W) redundancy', 'Supports up to 1480W (when 1150W power supply is dualized), supports mixed PoE/PoE+ within a single device', '', '440x44x260mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(40, '', 'F', 'd2624gp', 'https://ik.imagekit.io/iamfake/products/l3-switch-d2624g.png?updatedAt=1750665369541', 'SWITCH', 'PoE SWITCH', 'dasan', 'D2624GP', 'PoE SWITCH', '24 port 10/100/1000/BASE-T(RJ45) PoE/PoE+', '4 port 1000BASE-X(SFP) / 10GBASE-R (SFP+)', 'Less than 460W (including PoE) Less than 40W (excluding PoE)', 'Total 370W PoE budget', '', '', '', 'The D2624GP from Dasan Networks is a gigabit Ethernet switch that supports Power over Ethernet (PoE) for 24 subscriber ports. The D2624GP supports the PoE function, allowing it to simultaneously supply data and power to connected sub-terminals via Ethernet cables. This has a great cost-saving advantage because there is no need to install a power outlet for each individual device. The D2624GP provides 24 fixed 10/100/1000BASE-T (RJ-45) gigabit Ethernet service ports. It also provides four 1000BASE-X (SFP) / 10GBASE-R (SFP+) uplink ports, making it an efficient switch that can be utilized in various network environments. D2624GP provides intelligent services such as QoS, security ACL (Access Control List), and multicast management to ensure stable network communication and build a high-performance network. In addition, it has a wide range of performance, reliability, and enhanced network management functions to enable efficient network construction and differentiated service provision.', '24 10/100/1000BASE-T ports and Provides 4 1000BASE-X (SFP)/10GBASE-R (SFP+) ports', 'Stacking support: Up to 9 Stack Members', 'Provides L2/L3/L4 H/W-based ACL', 'Build various networks through gigabit uplink interface', 'L2/L3/L4 traffic classification and priority management', 'System protection and management through user password', 'IEEE 802.1x port-based, MAC-based security', 'RADIUS/TACACS+ authentication', 'Network management via SNMP v1/v2/v3 and RMON', 'Excellent QoS features', 'PoE(15.4W) / PoE+(30W)', 'Up to 24 ports 15.4W power supply at the same time', 'Power supply control per 10/100/1000Base-T port', 'Supports Ethernet Ring Protocol (ERPS)', 'SDN Ready', '', '', '', '', '', '', '', '', '', '', '', '', '128Gbps', '95Mpps', '', '', '', '24 port 10/100/1000/BASE-T(RJ45) PoE/PoE+', '4 port 1000BASE-X(SFP) / 10GBASE-R (SFP+)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0°C ~ 50°C', '-40°C ~ 70°C', '10% to 90% (non-condensing)', '100V to 240VAC (50/60Hz)', '', '', 'Less than 460W (including PoE) Less than 40W (excluding PoE)', '440 × 44 × 260 mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(41, '', 'B', 'd2224gp-1', 'https://ik.imagekit.io/iamfake/products/onu-d2224gp.png?updatedAt=1750092496705', 'SWITCH', 'PoE SWITCH', 'dasan', 'D2224GP', 'PoE SWITCH', 'Supports PoE power up to 30W for each PoE port', '24 10/100/1000Mbps Auto MDI/MDI-X Ethernet port', '', '', '', '', '', 'D2224GP is a high performance the second managed gigabit switch. Provides twenty-four 10/100/1000Mbps self-adaption RJ45 ports, plus four  gigabit  SFP ports, it can be used to link bandwidth higher upstream equipment. Support VLAN ACL based on port, easily implement network monitoring, traffic regulation, priority tag and traffic control. Support traditional STP/RSTP/MSTP 2 link protection technology; greatly improve the ability of fault tolerance, redundancy backup to ensure the stable operation of the network. D2224GP provides perfect QOS strategy and plenty of VLAN function. Support 802. 1x authentication based on the port and MAC, easily set user access. Support ACL control based on the time, easy control the access time accurately. D2224GP\\', '24 10/100/1000Mbps Auto MDI/MDI-X Ethernet port (4 SFP combo ports)', 'Switching Capacity up to 56Gbps', 'Store and forward mode operates', 'Support Web-based Management ', 'Supports PoE power up to30W for each PoE port, total power up to 370W for all PoE ports', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '24 port 10/100/1000Mbps PoE/PoE+', '4 ports 2 x100/1000Mbps SFP port', 'H650SFP : uplink GPON ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0 to 60°C', '', '10 to 90% (non-condensing)', '', '', '', '< 22W (without POE), < 400W (with POE)', '440mm x 44mm x 208mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(42, '', 'B', 'd2008gpe-1', 'https://ik.imagekit.io/iamfake/products/l2-d2008gpe.png?updatedAt=1750233558797', 'SWITCH', 'PoE SWITCH', 'dasan', 'D2008GPE', 'PoE SWITCH', 'Supports PoE power up to 30W for each PoE port', 'Total power up to 150W for all PoE ports', '', '', '', '', '', 'D2008GPE is a new generation designed for high security and high-performance network the layer 2 switch. Provides eight 10/100/1000Mbps self-adaption RJ45 port, and two 100/1000Mbps SFP ports, all ports support wire-speed forwarding, can provide you with larger network flexibility. All ports support Auto MDI/MDIX function.The Switch with a low-cost, easy-to-use, high performance upgrade your old network to a 1000Mbps Gigabit network. ', 'Switching Capacityup to 20Gbps', 'Supports PoE power up to 30W for each PoE port', 'Total power up to 150W for all PoE ports', 'Support web management', 'High performance, durable stability', 'Intelligent identification', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '8 x 10/100/1000Mbps Auto-Negotiation ports', '2 ports 2 x100/1000Mbps SFP port', 'H650SFP : uplink GPON ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0 to 50°C', '', '10 to 90% (non-condensing)', '', '', '', 'Less than 140W (at PoE full-load)', '280 x 44 x 180mm', 'access', 'switchLine', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(43, '', 'G', 'w340', 'https://ik.imagekit.io/iamfake/products/ap-w340.png?updatedAt=1750738971254', 'WIRELESS', 'Access Point', 'dasan', 'W340', 'Access Point Indoor', '802.11 a/b/g/n/ac/ax (Wi-Fi 6)', '2.4GHz: 1,150Mbps', '5GHz(1): 4.8Gbps', '5GHz(2): 867Mbps', 'Standalone AP / Controller-Based AP / Cloud mode selectable', '', '', 'Supporting the latest Wi-Fi standard, 802.11ax, the W340 supports Triple Radio, Dual Band Wi-Fi services to maximize service performance. The three radios provide access speeds of up to 1.15Gbps + 4.8Gbps + 867Mbps. It supports WPA3, the latest wireless security standard, to protect the security of user terminals, and supports wireless RF control, mobile access, QoS (Quality of Service), and perfect L2/L3 roaming. W340 can be selected as a standalone/controller-linked/cloud service type by setting without changing the OS. Controller linkage can easily provide integrated management, wireless traffic transfer, security, and access control through linkage with Dasan Networks W7210/W7110 wireless controller. In addition, for wired connection, it ensures high performance and high availability through the AP\\', '2.4G & 5G (Triple-radio, Dual-band)', '802.11a/b/g/n/ac/ax (Wi-Fi 6)', 'Supports OFDMA, MU-MIMO, BSS Coloring', 'Wi-Fi performance up to 6.8 Gbps', 'Supports interference avoidance and frequency optimization connection functions', '3 Port 1G Ethernet Ports (2 Port PoE)', '1 Port Console', 'Easy setup via console/web/controller', 'Built-in smart antenna', 'WPA1/2/3', '1,280 simultaneous terminal connections (100 recommended)', 'Provides Web UI management functions', 'PoE redundancy support', 'Up to 48 SSIDs', 'TWT(Target Wakeup Time)', '802.11 a/b/g/n/ac/ax (Wi-Fi 6)', 'Triple-radio, dual-band', 'R1: 2.4GHz 4×4:4(ax)', 'R2: 5GHz 4×4:4(ax)', 'R3: 5GHz 2×2:2(ac)', '', '', '', '', '', 'Up to 1,280 clients per AP', 'IP41', '', '', '', '', '', '3 Port 1G Ethernet Ports (2 Port PoE)', '1 Port Console', '', '', '', 'omni-directional antenna (MU-MIMO)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-10℃ to 55℃', '', '5% to 95% (non-condensing)', '', '', '', '< 25.4W', '220mm × 220mm × 48.9mm, weight: 1.3Kg', 'wifi', 'wireless', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(44, '', 'G', 'w640', 'https://ik.imagekit.io/iamfake/products/ap-w640.png?updatedAt=1750743488648', 'WIRELESS', 'Access Point', 'dasan', 'W640', 'Access Point Indoor', '802.11a/b/g/n/ac/ax (Wi-Fi 6E)', '2.4GHz: 1,150Mbps ', '5GHz: 2.4Gbps ', '6GHz: 4.8Gbps', 'Standalone AP/Controller-Based AP/Easy Mesh AP', '', '', 'With the growing popularity of personal digital devices such as tablet, smart phone, laptop, and other mobile computing tools, the needs is being increased for con­figuring the consolidated wireless network, and estab­lishing the smart environment. W640 is a Wi-Fi 6 indoor Access Point based on 802.11 a/b/g/n/ac/ax, which supports Triple-Radio and Triple -Band. It supports WPA3 to protect the security of user devices, and supports wireless RF control, mobile access, QoS (Quality of Service), and complete L2/L3 roaming. In this regard, the W640 is the perfect fit for the enter­prise and home customers that want to deploy the opti­mized secure wireless networks in the office, workplace, entire campus or apartment houses.', '2.4GHz & 5GHz & 6GHz (3 Radio / 3 Band)', '802.11a/b/g/n/ac/ax (Wi-Fi 6E)', 'Supports OFDMA, MU-MIMO, BSS Coloring', 'Wireless performance up to 7.95 Gbps', 'Supports interference avoidance and frequency optimization connection functions', '1 Port 1G/2.5G/5G Ethernet Ports', '1 Port 1G Ethernet Ports', 'Provides Web UI management functions', 'Built-in antenna', 'WPA1/2/3, OWE', 'Up to 24 SSIDs', '', '', '', '', '802.11a/b/g/n/ac/ax (Wi-Fi 6E)', 'Triple-radio, Tri-band', 'R1: 2.4GHz 4×4:4(ax)', 'R2: 5GHz 4×4:4(ax)', 'R3: 6GHz 2×2:2(ac)', '', '', '', '', '', 'Up to 1,024 clients per AP', '', '', '', '', '', '', '1 Port 1G/2.5G/5G Base-T ', '1 Port 10/100/1000M Base-T', '', '', '', 'omni-directional antenna (MU-MIMO)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0℃ to 55℃', '', '5% to 95% (non-condensing)', '', '', '', '< 38W', '230mm × 230mm × 50mm, weight: 950g', 'wifi', 'wireless', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(45, '', 'G', 'w345', 'https://ik.imagekit.io/iamfake/products/ap-w345.png?updatedAt=1750744297787', 'WIRELESS', 'Access Point', 'dasan', 'W345', 'Access Point Outdoor', '802.11a/b/g/n/ac/ax compliant (Wi-Fi 6)', '2.4GHz: 1,150Mbps', '5GHz: 2,400Mbps', '2.4GHz/5GHz: 867Mbps', 'Standalone AP / Controller-Based AP / Cloud integration mode selectable', '', '', 'The W345 is a next-generation Outdoor Access Point product that adopts the Wi-Fi 6 802.11ax protocol and supports wireless speeds of up to 2,400 Mbps + 1,150 Mbps + 867 Mbps through Triple-Radio technology. It supports security of user devices, and supports wireless RF control, mobile access, QoS (Quality of Service), and complete L2 roaming. The W345 is designed to be fully in outdoor environments through a hardware design that satisfies the waterproof/dustproof rating of IP67/IP68. W345 allow you to meet flexible wireless Wi-Fi coverage range in different environmental requirements. The W345 is an outdoor AP suitable for various enterprise scenarios such as public Wi-Fi, education, hotels and office environ­ments.', 'High-performance 802.11ax outdoor AP', '2.4Ghz & 5G (Triple-Radio Dual Band)', '802.11 a/b/g/n/ac/ax(Wi-Fi6)', 'Supports OFDMA, MU-MIMO, BSS Coloring', 'WiFi performance up to 4.42Gbps', 'Supports interference avoidance and frequency optimization connection functions', '1 Port 1G/2.5G/5G/10G RJ45', '1 Port 10G SFP+', '1 Port Console', 'Easy setup via Console / Web / Controller', 'Built-in smart antenna', '1,024 simultaneous terminal connections', '32 SSID', 'WPA1/2/3', 'Energy saving of IoT terminals through TWT', '802.11a/b/g/n/ac/ax (Wi-Fi6)', 'Triple-radio, dual-band', 'R1: 2.4G 4x4:4SS MU-MIMO', 'R2: 5G 2×2:2SS MU-MIMO,', 'R3: 5G 4×4:4SS MU-MIMO', '', '', '', '', '', 'Up to 1,024 clients per AP', 'IP67/IP68', '', '', '', '', '', '1Port 100/1000/2.5G/5G/10G Base-T', '1Port 10G BASE-X', '', '', '', 'Built-in omni-directional antenna, Two External Antenna ports(WDS)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '-40℃ to 65℃', '', '0% to 100% (non-condensing)', '', '', '', '', '31cm × 12cm (diameter x depth), wieght: 4kg', 'wifi', 'wireless', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(46, '', 'H', 'w7110', 'https://ik.imagekit.io/iamfake/products/controller-w7110.png?updatedAt=1750745905696', 'WIRELESS', 'CONTROLLER', 'dasan', 'W7110', 'AP Controller', '6 ports 1000BASE-T', '2 ports  1000BASE-T/1000BASE-X (Combo)', '1 Port Console', 'Manage up to 224 APs per controller', 'Provides settings and dashboard via Web GUI', '', '', 'Dasan Networks W7110 high-performance wireless controller is designed to support next-generation high-speed wireless networks. W7110 enables network communication between AP (Access Point) and controller to flexibly accommodate Wi-Fi services without changing the existing network. It can manage 32 wireless APs by default, and can manage up to 224 wireless APs by adding licenses.', '802.11a/b/g/n/ac AP Management', 'L2/L3 roaming support', 'Manage up to 224 APs per controller', 'Centralized or distributed traffic selection for AP service traffic', 'Customized licensing policy based on customer size', 'Convenient management via console interface', 'Provides settings and dashboard via Web GUI', 'Automatic upgrade feature by equipment/group', 'Smart device automatic recognition and registration function', 'Security features: CPP/NFPP', 'Internet service guarantee function even in case of controller failure ', '', '', '', '', '', '', '', '', '', '', '', 'Default 32 / Maximum 224 (when purchasing additional licenses)', '2,048', '6,400', '', '', '', '', '', '', '', '6 ports 1000BASE-T', '2 ports  1000BASE-T/1000BASE-X (Combo)', '1 Port Console', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0℃ to 45℃', '-40°C ~ 70°C', '10% to 90%RH (non-condensing)', '100VAC to 240VAC, 50Hz to 60Hz', '', '', '<40W', '440 × 200 x 43.61 (1RU, 19-inch rack mountable)', 'controller', 'wireless', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(47, '', 'H', 'w7210', 'https://ik.imagekit.io/iamfake/products/controller-w7210.png?updatedAt=1750752417835', 'WIRELESS', 'CONTROLLER', 'dasan', 'W7210', 'AP Controller', '8 ports 10/100/1000BASE-T or 100/1000BASE-X (Combo)', '4 ports 10G/1G BASE-X SFP+(Combo)', 'Supports Wi-Fi 6 AP management', 'Supports the latest WPA3 wireless security technology', '', '', '', 'Dasan Networks W7210 high-performance wireless controller is designed to support next-generation high-speed wireless networks. W7210 enables network communication between AP (Access Point) and controller to flexibly accommodate Wi-Fi services without changing the existing network. It can manage 128 wireless APs by default, and can manage up to 2,560 (distributed) wireless APs by adding licenses.', 'Supports Wi-Fi 6 AP management', 'Supports the latest WPA3 wireless security technology', '802.11a/b/g/n/ac/ax AP Management', 'L2/L3 roaming support', 'Manage up to 2,560 APs per controller', 'Manage up to 10,240 APs through controller virtualization', 'Centralized or distributed processing traffic selection for AP service traffic', 'Customized licensing policy based on customer size', 'Dynamic RF', 'Enhanced security through RADIUS and SSL', 'Convenient management through console interface', 'Provides settings and dashboard via Web GUI', 'Automatic upgrade function by equipment/group', 'Automatic smart device recognition and registration function', '', '', '', '', '', '', '', '', 'Base 128 / Max 1,024 (with additional license purchase)', '4,096', '32K (up to 128K when virtualized)', '', '', '', '', '', '', '', '8 ports 10/100/1000BASE-T or 100/1000BASE-X (Combo)', '4 ports 10G/1G BASE-X SFP+(Combo)', '1 Port Console, 1port 10/100M MGMT', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0ºC to 45ºC', '-40ºC to 70ºC\"\"', '10% to 90%RH (non-condensing)', '100VAC to 240VAC, 50Hz to 60Hz (power supply dualization and hot-swap support)', '', '', '<100W', '440 × 560 x 86.1 (2RU, 19-inch rack mount)', 'controller', 'wireless', 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(48, '', 'A', 'test-product', NULL, 'Test Category', NULL, 'Test Brand', 'Test Product', 'Test Subtitle', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'This is a test product', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-12-06 10:49:17', '2025-12-06 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint UNSIGNED NOT NULL,
  `po_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_address` text COLLATE utf8mb4_unicode_ci,
  `supplier_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` enum('pending','received','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `user_id` bigint UNSIGNED NOT NULL,
  `order_date` date NOT NULL,
  `received_date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` bigint UNSIGNED NOT NULL,
  `purchase_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_address` text COLLATE utf8mb4_unicode_ci,
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` enum('pending','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `sales_person_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `sale_date` date NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_people`
--

CREATE TABLE `sales_people` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commission_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales_people`
--

INSERT INTO `sales_people` (`id`, `user_id`, `name`, `phone`, `email`, `commission_rate`, `active`, `created_at`, `updated_at`) VALUES
(1, 3, 'Sales User', '08123456789', 'sales@example.com', 5.00, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` bigint UNSIGNED NOT NULL,
  `sale_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `solutions`
--

CREATE TABLE `solutions` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `solutions`
--

INSERT INTO `solutions` (`id`, `title`, `description`, `image_url`, `order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Network Infrastructure', 'We provide comprehensive network infrastructure solutions including fiber optic deployment, structured cabling, and network design services to ensure reliable and high-performance connectivity for your business.', '/assets/static/solutions/network.jpg', 1, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(2, 'Fiber Optic Solutions', 'Specialized in FTTH (Fiber to the Home) and FTTB (Fiber to the Building) deployments using GPON and XG-PON technologies. We offer end-to-end solutions from planning to implementation.', '/assets/static/solutions/fiber.jpg', 2, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(3, 'Telecommunication Equipment', 'As an authorized distributor of DASAN equipment, we provide high-quality OLT, ONU, and related telecommunication devices with full technical support and warranty.', '/assets/static/solutions/telecom.jpg', 3, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(4, 'Technical Support & Maintenance', 'Our experienced technical team provides 24/7 support, regular maintenance, troubleshooting, and training services to ensure your network operates at peak performance.', '/assets/static/solutions/support.jpg', 4, 1, '2025-12-06 10:49:17', '2025-12-06 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `stock_transactions`
--

CREATE TABLE `stock_transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `transaction_type` enum('in','out') COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `reference_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `category_id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'OLT', 'Optical Line Terminal', NULL, NULL),
(2, 1, 'ONT', 'Optical Network Terminal', NULL, NULL),
(3, 1, 'ONU PoE', 'Optical Network Unit with PoE', NULL, NULL),
(4, 2, 'OLT', 'Optical Line Terminal', NULL, NULL),
(5, 2, 'ONT', 'Optical Network Terminal', NULL, NULL),
(6, 3, 'L2 SWITCH', 'Layer 2 Switch', NULL, NULL),
(7, 3, 'L3 SWITCH', 'Layer 3 Switch', NULL, NULL),
(8, 4, 'ENTERPRISE ROUTER', 'Enterprise Router', NULL, NULL),
(9, 5, 'INDOOR AP', 'Indoor Access Point', NULL, NULL),
(10, 5, 'OUTDOOR AP', 'Outdoor Access Point', NULL, NULL),
(11, 5, 'CONTROLLER', 'Wireless Controller', NULL, NULL),
(12, 6, 'VOIP', 'Voice over IP devices', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('superadmin','admin','sales','guest') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'guest',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@warehouse.com', NULL, '$2y$10$fG1X8X42VVfekME/.ZoUMur9R.gnVGmrcGWjIQHToQ3QUesRAqaVa', 'superadmin', NULL, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(2, 'Admin User', 'admin@example.com', NULL, '$2y$10$xRTwMp60mub1qHuDgLjm.uN9kOs2A3eA1u9ryW0jpTxY/TeJA8HVC', 'admin', NULL, '2025-12-06 10:49:17', '2025-12-06 10:49:17'),
(3, 'Sales User', 'sales@example.com', NULL, '$2y$10$.smADKAiH1cEJkJMHlxloegf7eU7VRyZwe26SXDQDJIk5IrPbBelG', 'sales', NULL, '2025-12-06 10:49:17', '2025-12-06 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `warranties`
--

CREATE TABLE `warranties` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `sale_id` bigint UNSIGNED DEFAULT NULL,
  `warranty_period_months` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','expired','claimed','void') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brands_name_unique` (`name`);

--
-- Indexes for table `carousel_slides`
--
ALTER TABLE `carousel_slides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `contact_info`
--
ALTER TABLE `contact_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `current_stocks`
--
ALTER TABLE `current_stocks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `current_stocks_product_id_unique` (`product_id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deliveries_user_id_foreign` (`user_id`);

--
-- Indexes for table `delivery_items`
--
ALTER TABLE `delivery_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_items_delivery_id_foreign` (`delivery_id`),
  ADD KEY `delivery_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `lendings`
--
ALTER TABLE `lendings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lendings_product_id_foreign` (`product_id`),
  ADD KEY `lendings_user_id_foreign` (`user_id`);

--
-- Indexes for table `lending_returns`
--
ALTER TABLE `lending_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lending_returns_lending_id_foreign` (`lending_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`),
  ADD KEY `pages_slug_index` (`slug`),
  ADD KEY `pages_is_published_index` (`is_published`);

--
-- Indexes for table `page_sections`
--
ALTER TABLE `page_sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_sections_page_id_order_index` (`page_id`,`order`);

--
-- Indexes for table `page_templates`
--
ALTER TABLE `page_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_sku_index` (`sku`),
  ADD KEY `products_category_index` (`category`),
  ADD KEY `products_sub_category_index` (`sub_category`),
  ADD KEY `products_brand_index` (`brand`),
  ADD KEY `products_stock_index` (`stock`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_product_id_foreign` (`product_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `public_products`
--
ALTER TABLE `public_products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `public_products_slug_unique` (`slug`),
  ADD KEY `public_products_category_index` (`category`),
  ADD KEY `public_products_sub_category_index` (`sub_category`),
  ADD KEY `public_products_brand_index` (`brand`),
  ADD KEY `public_products_module_index` (`module`),
  ADD KEY `public_products_is_active_index` (`is_active`),
  ADD KEY `public_products_sort_order_index` (`sort_order`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchases_po_number_unique` (`po_number`),
  ADD KEY `purchases_user_id_foreign` (`user_id`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_items_purchase_id_foreign` (`purchase_id`),
  ADD KEY `purchase_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_invoice_number_unique` (`invoice_number`),
  ADD KEY `sales_sales_person_id_foreign` (`sales_person_id`),
  ADD KEY `sales_user_id_foreign` (`user_id`);

--
-- Indexes for table `sales_people`
--
ALTER TABLE `sales_people`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_people_user_id_foreign` (`user_id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_items_sale_id_foreign` (`sale_id`),
  ADD KEY `sale_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `site_settings_key_unique` (`key`);

--
-- Indexes for table `solutions`
--
ALTER TABLE `solutions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_transactions`
--
ALTER TABLE `stock_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_transactions_product_id_foreign` (`product_id`),
  ADD KEY `stock_transactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sub_categories_category_id_name_unique` (`category_id`,`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `warranties`
--
ALTER TABLE `warranties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warranties_product_id_foreign` (`product_id`),
  ADD KEY `warranties_sale_id_foreign` (`sale_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `carousel_slides`
--
ALTER TABLE `carousel_slides`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `contact_info`
--
ALTER TABLE `contact_info`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `current_stocks`
--
ALTER TABLE `current_stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_items`
--
ALTER TABLE `delivery_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lendings`
--
ALTER TABLE `lendings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lending_returns`
--
ALTER TABLE `lending_returns`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `page_sections`
--
ALTER TABLE `page_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `page_templates`
--
ALTER TABLE `page_templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `public_products`
--
ALTER TABLE `public_products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_people`
--
ALTER TABLE `sales_people`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `solutions`
--
ALTER TABLE `solutions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `stock_transactions`
--
ALTER TABLE `stock_transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `warranties`
--
ALTER TABLE `warranties`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `current_stocks`
--
ALTER TABLE `current_stocks`
  ADD CONSTRAINT `current_stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `delivery_items`
--
ALTER TABLE `delivery_items`
  ADD CONSTRAINT `delivery_items_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `delivery_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lendings`
--
ALTER TABLE `lendings`
  ADD CONSTRAINT `lendings_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lendings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lending_returns`
--
ALTER TABLE `lending_returns`
  ADD CONSTRAINT `lending_returns_lending_id_foreign` FOREIGN KEY (`lending_id`) REFERENCES `lendings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `page_sections`
--
ALTER TABLE `page_sections`
  ADD CONSTRAINT `page_sections_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `purchase_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_items_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_sales_person_id_foreign` FOREIGN KEY (`sales_person_id`) REFERENCES `sales_people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sales_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales_people`
--
ALTER TABLE `sales_people`
  ADD CONSTRAINT `sales_people_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `sale_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_items_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stock_transactions`
--
ALTER TABLE `stock_transactions`
  ADD CONSTRAINT `stock_transactions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `warranties`
--
ALTER TABLE `warranties`
  ADD CONSTRAINT `warranties_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `warranties_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
