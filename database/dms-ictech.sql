-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2021 at 07:23 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dms-ictech`
--

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE `config` (
  `parameter_name` varchar(50) NOT NULL,
  `parameter_value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `config`
--

INSERT INTO `config` (`parameter_name`, `parameter_value`) VALUES
('check_password_complexity', '0'),
('lockout_time', '5'),
('log_platform', '0'),
('max_number_attempts', '10'),
('max_password_age', '90'),
('max_remember_passwords', '0'),
('min_password_length', '6'),
('no_reply_address', 'no.reply@ic-techafrica.com'),
('sender_address', 'support@ic-techafrica.com'),
('session_timeout', '30'),
('smtp_crypto', 'tls'),
('smtp_host', 'mail.ic-techafrica.com'),
('smtp_password', 'Malawi.19'),
('smtp_port', '587'),
('smtp_timeout', '60'),
('smtp_username', 'support@ic-techafrica.com'),
('system_id', 'Document Management System');

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `id` bigint(20) NOT NULL,
  `file_name` varchar(128) NOT NULL COMMENT 'The file name as in the DMS',
  `generated_file_name` varchar(128) NOT NULL COMMENT 'A randomly generated filename by the system',
  `file_size` bigint(20) UNSIGNED NOT NULL,
  `original_file_name` varchar(255) NOT NULL COMMENT 'The file name as it was from the file system',
  `version` smallint(6) UNSIGNED NOT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `mime_type` varchar(45) NOT NULL,
  `owner` int(11) DEFAULT NULL,
  `folder` bigint(20) UNSIGNED NOT NULL,
  `abs_file_path` varchar(2000) NOT NULL,
  `is_archived` int(11) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  `date_uploaded` datetime NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `state` smallint(6) DEFAULT NULL,
  `row_version` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `document`
--

INSERT INTO `document` (`id`, `file_name`, `generated_file_name`, `file_size`, `original_file_name`, `version`, `extension`, `mime_type`, `owner`, `folder`, `abs_file_path`, `is_archived`, `comment`, `date_uploaded`, `uploaded_by`, `state`, `row_version`) VALUES
(9, 'Ecoo Presentation', '1615626766_3eaa1c508bc14893b5dd', 463134, 'eCoO.pptx', 1, 'pptx', 'application/vnd.openxmlformats-officedocument', NULL, 1, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\', 0, 'Presentation On Ecoo To Mra And Min Of Trade', '2021-03-13 11:12:46', 1, -1, 1615800189),
(10, 'Microsoft Sql Server Notes', '1615626824_651acff9450045f204bf', 2770847, 'MicrosoftSQLServerNotesForProfessionals.pdf', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\', 0, '', '2021-03-13 11:13:44', 1, 1, 1615626824),
(11, 'Hosting Services', '1615627279_623204f95995c9ad674f', 13507, 'Hosting Services.docx', 1, 'docx', 'application/vnd.openxmlformats-officedocument', NULL, 3, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\', 0, '', '2021-03-13 11:21:19', 1, 1, 1615627279),
(12, 'Router Spec', '1615634083_bebabf877d919f552891', 776425, 'DWR-921_ds_revc3_Datasheet_en.pdf', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\', 0, '', '2021-03-13 13:14:43', 1, 1, 1615634083),
(13, 'Postgre Manual', '1615634126_cee966c8cfa62a7411b3', 13272744, 'postgresql-13-A4.pdf', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\', 0, '', '2021-03-13 13:15:26', 1, 1, 1615634126),
(14, 'Passport Form', '1615634163_12da1a65e2c1f9859cdf', 30124, '3000010021802.pdf', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\', 0, '', '2021-03-13 13:16:03', 1, 1, 1615634163),
(15, 'Ecoo Presentation', '1615800189_c5e9e7680e7b106092b4', 463134, 'eCoO.pptx', 2, 'pptx', 'application/vnd.openxmlformats-officedocument', NULL, 1, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210315\\', 0, '', '2021-03-15 11:23:09', 1, 1, 1615800189),
(16, 'Tnm Receipt', '1615836693_0eef09b91fb76a0215ab', 65280, 'IMG-20180412-WA0008.jpg', 1, 'jpg', 'image/jpeg', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210315\\', 0, '', '2021-03-15 21:31:33', 1, 1, 1615836693),
(17, 'Development Request Form', '1615837568_34b49d9da44dc4833ff2', 522250, 'DevelopmentRequestForm.pdf', 1, 'pdf', 'application/pdf', NULL, 1, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210315\\', 0, '', '2021-03-15 21:46:08', 1, 1, 1615837568),
(18, 'Backup Codes', '1615908998_79524ebf12ba9c221683', 298, 'Backup-codes.txt', 1, 'txt', 'text/plain', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210316\\', 0, '', '2021-03-16 17:36:38', 1, 1, 1615908998),
(19, 'National Bank Submission', '1615974428_687878579e8e1b0b482f', 5351655, 'NatbankSubmissionIctechAfrica.pdf', 1, 'pdf', 'application/pdf', NULL, 1, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\', 0, NULL, '2021-03-17 11:47:08', 1, 1, 1615974688),
(23, 'CodingStandards', '1615985836_6264c673abd76340705b', 110883, 'CodingStandards', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\', 0, NULL, '2021-03-17 14:57:16', 1, 1, 1615985836),
(24, 'AHL VPN', '1615985837_431c16675a8ecbe904c6', 876317, 'AHL VPN', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\', 0, NULL, '2021-03-17 14:57:17', 1, 1, 1615985837),
(25, 'scan0608', '1615989008_714917a9dfc25f5d392e', 393772, 'scan0608', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\', 0, NULL, '2021-03-17 15:50:08', 1, 1, 1615989008),
(26, 'database19c-wp', '1615989008_abbdeeb5998222cd4812', 1193577, 'database19c-wp', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\', 0, NULL, '2021-03-17 15:50:08', 1, 1, 1615989008),
(27, 'wp_migratingtovirtualservers_sep_uk', '1615993716_87bd65a268be12bfecb4', 164951, 'wp_migratingtovirtualservers_sep_uk', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\', 0, NULL, '2021-03-17 17:08:36', 1, 1, 1615993716),
(28, 'Modern Servers', '1615993716_4a02339af3fa2d6a0e91', 2950471, 'modern-servers-are-key-to-organizing-the-chaos-of-data-and-analytics', 1, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\', 0, NULL, '2021-03-17 17:08:36', 1, -1, 1615993870),
(29, 'Modern Servers', '1615993870_96885c3f4f2db78fb692', 2950471, 'modern-servers-are-key-to-organizing-the-chaos-of-data-and-analytics.pdf', 2, 'pdf', 'application/pdf', NULL, 2, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\', 0, '', '2021-03-17 17:11:10', 1, 1, 1615993870),
(30, 'Hessian', '1616056891_bdf492466ea0d05f54a8', 387911, 'Hessian', 1, 'pptx', 'application/vnd.openxmlformats-officedocument', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 10:41:32', 18, 1, 1616056892),
(31, 'Rehandling', '1616057013_bba867442eb411c81827', 387959, 'Rehandling', 1, 'pptx', 'application/vnd.openxmlformats-officedocument', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 10:43:33', 18, 1, 1616057013),
(32, 'GIZTechnicalWriteup', '1616057150_712891e9aed9de5aad3d', 913505, 'GIZTechnicalWriteup', 1, 'docx', 'application/vnd.openxmlformats-officedocument', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 10:45:50', 18, 1, 1616057150),
(33, 'Mangochi DC EOI', '1616057217_55416f0089cf56a881cc', 1476966, 'Mangochi DC EOI', 1, 'docx', 'application/vnd.openxmlformats-officedocument', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 10:46:57', 18, 1, 1616057217),
(34, 'Fleet Management System', '1616057352_c9c3f37ef79bcb422ee0', 164016, 'Fleet Management System', 1, 'docx', 'application/vnd.openxmlformats-officedocument', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 10:49:12', 18, 1, 1616057352),
(35, 'eMsika', '1616057377_0a292444b6376d376c16', 286208, 'eMsika', 1, 'mpp', 'application/vnd.ms-office', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 10:49:37', 18, 1, 1616057377),
(36, 'Inception Report', '1616057536_ec2c2a2ab51a87b06c99', 777190, 'Inception Report', 1, 'pptx', 'application/vnd.openxmlformats-officedocument', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 10:52:16', 18, 1, 1616057536),
(37, 'github-git-cheat-sheet', '1616059100_79a62ca360356748f1b8', 377767, 'github-git-cheat-sheet', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 11:18:20', 18, 1, 1616059100),
(38, 'SQL_Server_2019_Top_10_Reasons_to_Choose_Infographic_EN_US', '1616059119_c29817483bd18105e46c', 92630, 'SQL_Server_2019_Top_10_Reasons_to_Choose_Infographic_EN_US', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 11:18:39', 18, 1, 1616059119),
(39, 'Brochure', '1616070775_ff6c8e7c38ea0b745a92', 991899, 'eco_brochure.pdf', 1, 'pdf', 'application/pdf', NULL, 1, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, '', '2021-03-18 14:32:55', 1, 1, 1616070775),
(40, 'CodingStandards', '1616070912_c4387ce591730c0f87d5', 110883, 'CodingStandards', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 14:35:12', 18, 1, 1616078897),
(41, 'AHL 252 Product Brief', '1616070913_6704e01c45636eec236b', 97455, 'AHL 252 Product Brief', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 14:35:13', 18, 1, 1616070913),
(42, 'IC-TechHelpdeskManual', '1616070913_b6c4386937458b7c8a01', 385784, 'IC-TechHelpdeskManual', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 14:35:13', 18, 1, 1616070913),
(43, 'DevelopmentRequestForm', '1616070913_a5b1966730210b89617a', 522250, 'DevelopmentRequestForm', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 14:35:13', 18, 1, 1616070913),
(44, 'Growing_SQL_Server_Infographic_EN_US', '1616070913_8fcc09b5c63824dcca85', 289730, 'Growing_SQL_Server_Infographic_EN_US', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 14:35:13', 18, 1, 1616070913),
(45, 'AHL VPN', '1616070914_aa5e0f7d100ce9314edb', 876317, 'AHL VPN', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 1, NULL, '2021-03-18 14:35:14', 18, 1, 1616130381),
(46, 'eco_brochure', '1616070914_90c95e1d62d3a93312d1', 991899, 'eco_brochure', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 14:35:14', 18, 1, 1616070914),
(47, 'database19c-wp', '1616070914_376544adea0e6bdefa20', 1193577, 'database19c-wp', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 14:35:14', 18, 1, 1616070914),
(48, 'DWR-921_ds_revc3_Datasheet_en', '1616070914_6f40749bb7842f509d70', 776425, 'DWR-921_ds_revc3_Datasheet_en', 1, 'pdf', 'application/pdf', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\', 0, NULL, '2021-03-18 14:35:14', 18, 1, 1616070914),
(49, 'WHO COVID-19 global table data December 30th 2020 at 5.01.06 PM', '1616167000_9fff78f071ef9b4e3189', 18548, 'WHO COVID-19 global table data December 30th 2020 at 5.01.06 PM', 1, 'csv', 'text/plain', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210319\\', 0, NULL, '2021-03-19 17:16:40', 18, 1, 1616167000),
(50, 'IC-TechDMS_Schema', '1616167996_96beb01f4d1e4a2b9832', 25485, 'IC-TechDMS_Schema', 1, 'mwb', 'application/zip', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210319\\', 0, NULL, '2021-03-19 17:33:16', 18, 1, 1616167996),
(51, 'encryption-infographic-(3)_505_010819040534', '1616168136_a9e7859d88dbb204ade7', 53077, 'encryption-infographic-(3)_505_010819040534', 1, 'jpg', 'image/jpeg', NULL, 4, 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210319\\', 0, NULL, '2021-03-19 17:35:36', 18, 1, 1616168136);

-- --------------------------------------------------------

--
-- Table structure for table `document_access_level`
--

CREATE TABLE `document_access_level` (
  `row_id` varchar(191) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `privilege` smallint(6) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `document_access_level`
--

INSERT INTO `document_access_level` (`row_id`, `document_id`, `user_id`, `created_date`, `privilege`, `group_id`, `updated_date`) VALUES
('0CBA59BFE1F242189F13CE8181C2E079', 41, 18, '2021-03-18 14:35:13', 1, NULL, NULL),
('0CCF3C183596447CAE2E38A12686F7BE', 23, 1, '2021-03-17 14:57:16', 1, NULL, NULL),
('11B57A2C70ED4E26BD0A9F7EE2FDD33E', 9, 1, '2021-03-13 11:12:46', 1, NULL, NULL),
('1544EAAE9B8746D5A1404250D68A40D8', 50, 18, '2021-03-19 17:33:17', 1, NULL, NULL),
('1925DBA480854498A1DB0DAC414BDBEA', 39, 1, '2021-03-18 14:32:55', 1, NULL, NULL),
('22899D1FBCF141788FF4BCA4385744AB', 12, 1, '2021-03-13 13:14:43', 1, NULL, NULL),
('25DFD84E5B3E4B49AAA2194C7AD7B590', 30, 18, '2021-03-18 10:41:32', 1, NULL, NULL),
('3370EBBC1DB74466B66733B883F2BE06', 49, 18, '2021-03-19 17:16:40', 1, NULL, NULL),
('34A59AEB0D434983ABDBC688EE3355F9', 51, 18, '2021-03-19 17:35:36', 1, NULL, NULL),
('3E5C027F8886408D9D01D7D62459E30F', 24, 1, '2021-03-17 14:57:17', 1, NULL, NULL),
('4227EEAA18D047F08B8C278C488568C7', 48, 18, '2021-03-18 14:35:14', 1, NULL, NULL),
('42CAF3D84A924C659E9039245976744F', 33, 18, '2021-03-18 10:46:57', 1, NULL, NULL),
('57AD4190359C44A7AF09A83B9CDD0CFB', 17, 1, '2021-03-15 21:46:08', 1, NULL, NULL),
('5B58A682778549DEB615FABA462397C8', 37, 18, '2021-03-18 11:18:20', 1, NULL, NULL),
('5CE96FBD53164AA7A7C7220DD2DE80F2', 38, 18, '2021-03-18 11:18:39', 1, NULL, NULL),
('661F8B0E5C1D4927A06BEB157437F78C', 15, 1, '2021-03-15 11:23:10', 1, NULL, NULL),
('66802D8131B745A7BA28A1FC440BE9B5', 40, 18, '2021-03-18 14:35:12', 1, NULL, NULL),
('66D55E45AA1945D9ACBB0B8512E306E2', 27, 1, '2021-03-17 17:08:36', 1, NULL, NULL),
('795809B4CEBF419C823F3E7D30DE1BCF', 43, 18, '2021-03-18 14:35:13', 1, NULL, NULL),
('79A8FF48A67C4DDC951458220972626F', 25, 1, '2021-03-17 15:50:08', 1, NULL, NULL),
('7E8C1846110344388AFC89E4F8145652', 36, 18, '2021-03-18 10:52:16', 1, NULL, NULL),
('926A559EFB544A6290E9BE586B97E6D8', 19, 1, '2021-03-17 11:47:08', 1, NULL, NULL),
('937ADA8C1A6047EBAA6887E9AF4D6961', 46, 18, '2021-03-18 14:35:14', 1, NULL, NULL),
('982F35D332474FCCBC3CDDB525840E8D', 18, 1, '2021-03-16 17:36:38', 1, NULL, NULL),
('9D521A42832A4D4898D987676A415358', 29, 1, '2021-03-17 17:11:10', 1, NULL, NULL),
('A13F634550224E049438BB0EAB1D2AEF', 13, 1, '2021-03-13 13:15:26', 1, NULL, NULL),
('A7967ACC48874284B33A6AF16AA33E2F', 32, 18, '2021-03-18 10:45:50', 1, NULL, NULL),
('B4688F34F2F64A34ABE1242A1CC7DDC7', 10, 1, '2021-03-13 11:13:44', 1, NULL, NULL),
('C3B476CC9BF9420B8BE6FCD6868E9FB3', 42, 18, '2021-03-18 14:35:13', 1, NULL, NULL),
('C50304B7FE4943AB8AC2EFD98D3F4452', 14, 1, '2021-03-13 13:16:03', 1, NULL, NULL),
('CA2490675B6A4C2EBF3A30ADBF2904DC', 44, 18, '2021-03-18 14:35:13', 1, NULL, NULL),
('CDFDB40A8FE44E23996ED50E494835DC', 47, 18, '2021-03-18 14:35:14', 1, NULL, NULL),
('D4114947099E42EBBEC9DF0A0C82D5D1', 28, 1, '2021-03-17 17:08:36', 1, NULL, NULL),
('DC081FEA7D814D4283DD4E95CEA2DA72', 11, 1, '2021-03-13 11:21:20', 1, NULL, NULL),
('E371A51B6D47468986382B5C211E9F43', 35, 18, '2021-03-18 10:49:37', 1, NULL, NULL),
('E90012CD638E44628F523EE17C459679', 34, 18, '2021-03-18 10:49:12', 1, NULL, NULL),
('EF81473DFB254907A7957F0B7A5078D1', 16, 1, '2021-03-15 21:31:33', 1, NULL, NULL),
('F7363195258A406897D05A51923BBBC2', 31, 18, '2021-03-18 10:43:33', 1, NULL, NULL),
('F9E25BDFD74347DDB584C036FA2FE637', 45, 18, '2021-03-18 14:35:14', 1, NULL, NULL),
('FC07080AA0AC41D0B0AA16B95A6C9EEF', 26, 1, '2021-03-17 15:50:08', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `document_keyword`
--

CREATE TABLE `document_keyword` (
  `document_id` bigint(20) NOT NULL,
  `keyword` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `document_keyword`
--

INSERT INTO `document_keyword` (`document_id`, `keyword`) VALUES
(9, 'Ecoo'),
(9, 'Presentation'),
(10, 'Database'),
(10, 'Rdbms'),
(10, 'Sql'),
(11, 'Hosting'),
(11, 'Services'),
(12, 'Spec'),
(13, 'Postgre'),
(13, 'Spec'),
(13, 'Sql'),
(14, 'Documentation'),
(14, 'Malawi'),
(14, 'Passport'),
(15, 'E-government'),
(15, 'Mra'),
(15, 'Sadc'),
(15, 'Trade'),
(16, '252'),
(16, 'Receipt'),
(16, 'Tnm'),
(16, 'Vpn'),
(17, 'Dev'),
(17, 'Request Form'),
(18, 'Codes'),
(29, 'Dell'),
(29, 'Emc'),
(39, 'Brochure'),
(39, 'Pdf');

-- --------------------------------------------------------

--
-- Table structure for table `document_state`
--

CREATE TABLE `document_state` (
  `id` smallint(6) NOT NULL,
  `description` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `document_state`
--

INSERT INTO `document_state` (`id`, `description`) VALUES
(1, 'Current'),
(-1, 'History');

-- --------------------------------------------------------

--
-- Table structure for table `document_status_change`
--

CREATE TABLE `document_status_change` (
  `row_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `previous_state` smallint(6) NOT NULL,
  `new_state` smallint(6) NOT NULL,
  `changed_by` int(10) NOT NULL,
  `changed_date` datetime NOT NULL,
  `row_version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `document_status_change`
--

INSERT INTO `document_status_change` (`row_id`, `document_id`, `previous_state`, `new_state`, `changed_by`, `changed_date`, `row_version`) VALUES
(1, 40, 1, 0, 1, '2021-03-18 16:47:12', 1616078832),
(2, 40, 0, 1, 1, '2021-03-18 16:48:17', 1616078897),
(3, 45, 1, 0, 1, '2021-03-19 07:06:21', 1616130381);

-- --------------------------------------------------------

--
-- Table structure for table `document_transfer`
--

CREATE TABLE `document_transfer` (
  `row_id` bigint(20) NOT NULL,
  `document` bigint(20) NOT NULL,
  `source_folder` bigint(20) UNSIGNED NOT NULL,
  `dest_folder` bigint(20) UNSIGNED NOT NULL,
  `transfer_time` datetime NOT NULL,
  `transfer_user` int(11) NOT NULL,
  `row_version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `email_template`
--

CREATE TABLE `email_template` (
  `parameter_name` varchar(50) NOT NULL,
  `parameter_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `email_template`
--

INSERT INTO `email_template` (`parameter_name`, `parameter_value`) VALUES
('document_grant', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Access Grant</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">You have been granted <b>{privilege}</b> access on the document <b>{document_name}</b> by <b>{grant_user}</b></span></p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p>&nbsp;</p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p>&nbsp;</p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('document_received', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>{document}</b> sent on behalf of <b>{user}</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('document_revoke', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Access Revoke</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your access on the document <b>{document_name}</b> has been revoked by <b>{revoke_user}</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('document_updated', '<!doctype html>\r\n      <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n        <head>\r\n          <title>\r\n            \r\n          </title>\r\n          <!--[if !mso]><!-- -->\r\n          <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n          <!--<![endif]-->\r\n          <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n          <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n          <style type=\"text/css\">\r\n            #outlook a { padding:0; }\r\n            .ReadMsgBody { width:100%; }\r\n            .ExternalClass { width:100%; }\r\n            .ExternalClass * { line-height:100%; }\r\n            body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n            table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n            img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n            p { display:block;margin:13px 0; }\r\n          </style>\r\n          <!--[if !mso]><!-->\r\n          <style type=\"text/css\">\r\n            @media only screen and (max-width:480px) {\r\n              @-ms-viewport { width:320px; }\r\n              @viewport { width:320px; }\r\n            }\r\n          </style>\r\n          <!--<![endif]-->\r\n          <!--[if mso]>\r\n          <xml>\r\n          <o:OfficeDocumentSettings>\r\n            <o:AllowPNG/>\r\n            <o:PixelsPerInch>96</o:PixelsPerInch>\r\n          </o:OfficeDocumentSettings>\r\n          </xml>\r\n          <![endif]-->\r\n          <!--[if lte mso 11]>\r\n          <style type=\"text/css\">\r\n            .outlook-group-fix { width:100% !important; }\r\n          </style>\r\n          <![endif]-->\r\n          \r\n        <!--[if !mso]><!-->\r\n          <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n  <link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n          <style type=\"text/css\">\r\n            @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n  @import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n          </style>\r\n        <!--<![endif]-->\r\n\r\n      \r\n          \r\n      <style type=\"text/css\">\r\n        @media only screen and (min-width:480px) {\r\n          .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n        }\r\n      </style>\r\n      \r\n    \r\n          <style type=\"text/css\">\r\n          \r\n          \r\n\r\n      @media only screen and (max-width:480px) {\r\n        table.full-width-mobile { width: 100% !important; }\r\n        td.full-width-mobile { width: auto !important; }\r\n      }\r\n    \r\n          </style>\r\n          <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n          @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n          .hide_section_on_mobile { display: none !important;} \r\n          @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n          .hide_on_desktop { display: block !important;} \r\n          @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n          .hide_section_on_desktop { display: table !important;} \r\n          @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n          [owa] .mj-column-per-100 {\r\n              width: 100%!important;\r\n            }\r\n            [owa] .mj-column-per-50 {\r\n              width: 50%!important;\r\n            }\r\n            [owa] .mj-column-per-33 {\r\n              width: 33.333333333333336%!important;\r\n            }\r\n            p {\r\n                margin: 0px;\r\n            }\r\n            @media only print and (min-width:480px) {\r\n              .mj-column-per-100 { width:100%!important; }\r\n              .mj-column-per-40 { width:40%!important; }\r\n              .mj-column-per-60 { width:60%!important; }\r\n              .mj-column-per-50 { width: 50%!important; }\r\n              mj-column-per-33 { width: 33.333333333333336%!important; }\r\n              }</style>\r\n          \r\n        </head>\r\n        <body style=\"background-color:#4d4d4d;\">\r\n          \r\n          \r\n        <div style=\"background-color:#4d4d4d;\">\r\n          \r\n        \r\n        <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n        >\r\n          <tr>\r\n            <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n        <![endif]-->\r\n      \r\n        \r\n        <div style=\"Margin:0px auto;max-width:600px;\">\r\n          \r\n          <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n            <tbody>\r\n              <tr>\r\n                <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                  <!--[if mso | IE]>\r\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                  \r\n          <tr>\r\n        \r\n              <td\r\n                 class=\"\" style=\"vertical-align:top;width:600px;\"\r\n              >\r\n            <![endif]-->\r\n              \r\n        <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n          \r\n        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n          \r\n              <tr>\r\n                <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                  \r\n        <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n          <p><strong><span style=\"font-size: 17px;\">Document Updated</span></strong></p>\r\n        </div>\r\n      \r\n                </td>\r\n              </tr>\r\n            \r\n              <tr>\r\n                <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                  \r\n        <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n          <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n  <div>&nbsp;</div>\r\n  <p><span style=\"color: #236fa1; font-size: 12px;\">The document <b>{document}</b> has been updated by <b>{user}</b> to version <b>{version}</b></span></p>\r\n  <div>&nbsp;</div>\r\n  <div>&nbsp;</div>\r\n  <p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n  <div>&nbsp;</div>\r\n  <p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n  <div>&nbsp;</div>\r\n  <p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n  <div>&nbsp;</div>\r\n        </div>\r\n      \r\n                </td>\r\n              </tr>\r\n            \r\n              <tr>\r\n                <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                  \r\n        <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        </div>\r\n      \r\n                </td>\r\n              </tr>\r\n            \r\n              <tr>\r\n                <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                  \r\n        <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n        </p>\r\n        \r\n        <!--[if mso | IE]>\r\n          <table\r\n             align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n          >\r\n            <tr>\r\n              <td style=\"height:0;line-height:0;\">\r\n                &nbsp;\r\n              </td>\r\n            </tr>\r\n          </table>\r\n        <![endif]-->\r\n      \r\n      \r\n                </td>\r\n              </tr>\r\n            \r\n              <tr>\r\n                <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                  \r\n        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"width:600px;\">\r\n                \r\n        <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n      \r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n      \r\n                </td>\r\n              </tr>\r\n            \r\n        </table>\r\n      \r\n        </div>\r\n      \r\n            <!--[if mso | IE]>\r\n              </td>\r\n            \r\n          </tr>\r\n        \r\n                    </table>\r\n                  <![endif]-->\r\n                </td>\r\n              </tr>\r\n            </tbody>\r\n          </table>\r\n          \r\n        </div>\r\n      \r\n        \r\n        <!--[if mso | IE]>\r\n            </td>\r\n          </tr>\r\n        </table>\r\n        <![endif]-->\r\n      \r\n      \r\n        </div>\r\n      \r\n        </body>\r\n      </html>'),
('document_uploaded', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Uploaded</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">The document <b>{document}</b> has been uploaded by <b>{user}</b> to the folder <b>{folder}</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>');
INSERT INTO `email_template` (`parameter_name`, `parameter_value`) VALUES
('folder_grant', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Folder Access Grant</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">You have been granted <b>{privilege}</b> access on the folder <b>{folder_name}</b> by <b>{grant_user}</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('folder_revoke', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Folder Access Revoke</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your access on the folder <b>{folder_name}</b> has been revoked by <b>{revoke_user}</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('group_membership_add', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Group Membership</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">You have been added to the group <b>{group_name}</b> by <b>{user}</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('group_membership_remove', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Group Membership</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">You have been removed from the group <b>{group_name}</b> by <b>{user}</b></span></p>\r\n<br />\r\n<br />\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p>&nbsp;</p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p>&nbsp;</p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html> '),
('new_user_profile', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">New Profile</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your profile has been created successfully. Below are your login credentials:</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Username: <b> {username} </b></span></p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Password: <b> {password} </b></span></p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">URL: <b> {system_url} </b></span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Please login to change your password</span><span style=\"color: #236fa1; font-size: 12px;\"></span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p> </p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>');
INSERT INTO `email_template` (`parameter_name`, `parameter_value`) VALUES
('otp', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">One-Time PIN</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your one time PIN for this session is <b>{otp}</b>.</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">The code is valid for {validity} minute(s).</span><span style=\"color: #236fa1; font-size: 12px;\"></span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('password_change', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Password Changed</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your password has been successfully changed on: <b>{date}</b><br /><br />Timezone: {timezone}.</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">If you did not initiate the change, contact your support team immediately.</span><span style=\"color: #236fa1; font-size: 12px;\"></span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p>&nbsp;</p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('password_reset', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Password Reset</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your password has been reset. Find your new password below:</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">New Password: <b> {new_password} </b></span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Please login to change your password</span><span style=\"color: #236fa1; font-size: 12px;\"></span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p> </p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>'),
('password_self_reset_request', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table align=\"center\" bgcolor=\"#fff\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Password Reset</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello {name},</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">You recently told us that you forgot your password.</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Click the link below to reset your password (or alternatively copy and paste it in your browser):</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">{password_reset_link}</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Note that this link is valid for 1 hour. </span><span style=\"color: #236fa1; font-size: 12px;\">If you did not initiate the reset process, then simply ignore the email.</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p> </p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>');

-- --------------------------------------------------------

--
-- Table structure for table `exception_log`
--

CREATE TABLE `exception_log` (
  `row_id` bigint(20) NOT NULL,
  `message` varchar(8000) NOT NULL,
  `date_logged` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `folder`
--

CREATE TABLE `folder` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `owner` int(11) DEFAULT NULL,
  `state` smallint(6) NOT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `row_version` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `folder`
--

INSERT INTO `folder` (`id`, `name`, `comment`, `created_date`, `created_by`, `owner`, `state`, `updated_date`, `updated_by`, `row_version`) VALUES
(1, 'Shared Folder', '', '2021-02-12 11:30:39', 1, NULL, 1, NULL, NULL, 1613122239),
(2, 'Personal', '', '2021-02-12 12:45:50', 1, NULL, 1, NULL, NULL, 1613126750),
(3, 'Common', '', '2021-02-15 08:26:59', 1, 1, 1, '2021-02-19 11:27:09', 1, 1613726829),
(4, 'Software Development', '', '2021-03-18 10:41:16', 18, 18, 1, NULL, NULL, 1616056876);

-- --------------------------------------------------------

--
-- Table structure for table `folder_access_level`
--

CREATE TABLE `folder_access_level` (
  `row_id` varchar(191) NOT NULL,
  `folder_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `privilege` smallint(6) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `updated_date` int(11) DEFAULT NULL,
  `row_version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `folder_access_level`
--

INSERT INTO `folder_access_level` (`row_id`, `folder_id`, `user_id`, `created_date`, `privilege`, `group_id`, `updated_date`, `row_version`) VALUES
('14404B4084B64055B477DF033A361E98', 1, 1, '2021-02-12 11:30:39', 1, NULL, NULL, 1613122239),
('309E1CEAFD514B14A38DC48A8FCA1533', 4, 18, '2021-03-18 10:41:16', 1, NULL, NULL, 1616056876),
('3123945B4F544AECB647637ED3D4851B', 1, 18, '2021-02-16 14:15:43', 0, NULL, NULL, 1613477743),
('7076BC4A653F489DBBE2AA97F904BD0E', 2, 1, '2021-02-12 12:45:50', 1, NULL, NULL, 1613126750),
('A7FD88DACCF84D149AD30AED08276F21', 2, 18, '2021-02-16 11:26:49', 0, NULL, NULL, 1613467609),
('EFB5601722BA48BAA908F66245A70644', 3, 1, '2021-02-15 08:26:59', 1, NULL, NULL, 1613370419);

-- --------------------------------------------------------

--
-- Table structure for table `folder_hierarchy`
--

CREATE TABLE `folder_hierarchy` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `folder_id` bigint(20) UNSIGNED NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `folder_state`
--

CREATE TABLE `folder_state` (
  `row_id` smallint(6) NOT NULL,
  `description` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `folder_state`
--

INSERT INTO `folder_state` (`row_id`, `description`) VALUES
(1, 'Active'),
(0, 'Inactive');

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE `group` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `comment` varchar(128) DEFAULT '',
  `created_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `state` smallint(6) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`id`, `name`, `comment`, `created_date`, `created_by`, `updated_date`, `updated_by`, `state`) VALUES
(2, 'DEVELOPERS', 'Group For The Developers', '2021-02-12 22:06:48', 1, '2021-02-12 22:07:04', 1, 1),
(1, 'STAFF', '', '2021-02-12 12:11:28', 1, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `group_member`
--

CREATE TABLE `group_member` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `assigned_by` int(11) NOT NULL,
  `assigned_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `group_member`
--

INSERT INTO `group_member` (`user_id`, `group_id`, `assigned_by`, `assigned_date`) VALUES
(1, 2, 1, '2021-02-13 07:58:44'),
(18, 2, 1, '2021-02-16 11:24:47');

-- --------------------------------------------------------

--
-- Table structure for table `group_membership_log`
--

CREATE TABLE `group_membership_log` (
  `row_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `operation` tinyint(4) NOT NULL,
  `changed_by` int(11) NOT NULL,
  `changed_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group_membership_log`
--

INSERT INTO `group_membership_log` (`row_id`, `group_id`, `user_id`, `operation`, `changed_by`, `changed_date`) VALUES
(1, 1, 18, 1, 1, '2021-02-12 12:11:36'),
(2, 1, 18, 0, 1, '2021-02-12 13:03:14'),
(3, 1, 18, 1, 1, '2021-02-12 13:07:52'),
(4, 1, 18, 0, 1, '2021-02-12 18:38:19'),
(5, 1, 18, 1, 1, '2021-02-12 18:40:04'),
(6, 1, 18, 0, 1, '2021-02-12 18:42:26'),
(7, 1, 18, 1, 1, '2021-02-12 18:44:26'),
(8, 1, 18, 0, 1, '2021-02-12 18:58:32'),
(9, 2, 18, 1, 1, '2021-02-12 22:07:19'),
(10, 2, 18, 0, 1, '2021-02-13 07:01:15'),
(11, 1, 18, 1, 1, '2021-02-13 07:07:21'),
(12, 2, 18, 1, 1, '2021-02-13 07:58:37'),
(13, 2, 1, 1, 1, '2021-02-13 07:58:44'),
(14, 2, 18, 0, 1, '2021-02-13 08:36:38'),
(15, 1, 18, 0, 1, '2021-02-15 10:28:40'),
(16, 1, 18, 1, 1, '2021-02-15 10:33:00'),
(17, 1, 18, 0, 1, '2021-02-15 10:33:02'),
(18, 1, 18, 1, 1, '2021-02-15 10:37:27'),
(19, 1, 18, 0, 1, '2021-02-15 10:37:30'),
(20, 1, 18, 1, 1, '2021-02-15 17:13:18'),
(21, 2, 18, 1, 1, '2021-02-15 17:17:04'),
(22, 2, 18, 0, 1, '2021-02-15 17:49:58'),
(23, 2, 18, 1, 1, '2021-02-15 20:53:49'),
(24, 1, 21, 1, 1, '2021-02-16 07:59:37'),
(25, 1, 21, 0, 1, '2021-02-16 08:01:17'),
(26, 2, 18, 0, 1, '2021-02-16 08:39:01'),
(27, 2, 18, 1, 1, '2021-02-16 11:24:47'),
(28, 1, 18, 0, 1, '2021-02-16 17:15:37');

-- --------------------------------------------------------

--
-- Table structure for table `otp`
--

CREATE TABLE `otp` (
  `user_id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_expiry` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `otp`
--

INSERT INTO `otp` (`user_id`, `code`, `date_created`, `date_expiry`) VALUES
(18, 'IDXX31CN', '2021-03-18 14:34:01', '2021-03-18 15:04:01');

-- --------------------------------------------------------

--
-- Table structure for table `outgoing_email`
--

CREATE TABLE `outgoing_email` (
  `row_id` bigint(20) NOT NULL,
  `recipient` varchar(80) NOT NULL,
  `email_message` longtext NOT NULL,
  `subject` varchar(50) NOT NULL,
  `attachment` varchar(2000) DEFAULT NULL,
  `friendly_name` varchar(255) DEFAULT '',
  `submit_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sent_date` datetime DEFAULT NULL,
  `is_sent` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `outgoing_email`
--

INSERT INTO `outgoing_email` (`row_id`, `recipient`, `email_message`, `subject`, `attachment`, `friendly_name`, `submit_date`, `sent_date`, `is_sent`) VALUES
(1, 'mhone.vitu@gmail.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Ecoo Presentation.pptx</b> sent from <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\1615626766_3eaa1c508bc14893b5dd.pptx', 'Ecoo Presentation.pptx', '2021-03-15 10:57:21', '2021-03-15 11:14:11', 1),
(2, 'vmhone@outlook.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Ecoo Presentation.pptx</b> sent from <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\1615626766_3eaa1c508bc14893b5dd.pptx', 'Ecoo Presentation.pptx', '2021-03-15 10:57:21', '2021-03-15 11:14:24', 1),
(4, 'mhone.vitu@gmail.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Hosting Services.docx</b> sent from <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\1615627279_623204f95995c9ad674f.docx', 'Hosting Services.docx', '2021-03-15 11:16:49', '2021-03-15 11:17:08', 1),
(5, 'vmhone@ahlmw.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Hosting Services.docx</b> sent from <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\1615627279_623204f95995c9ad674f.docx', 'Hosting Services.docx', '2021-03-15 11:16:49', '2021-03-15 11:17:17', 1),
(6, 'vmhone@outlook.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Microsoft Sql Server Notes.pdf</b> sent from <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\1615626824_651acff9450045f204bf.pdf', 'Microsoft Sql Server Notes.pdf', '2021-03-15 13:26:15', '2021-03-15 13:27:31', 1);
INSERT INTO `outgoing_email` (`row_id`, `recipient`, `email_message`, `subject`, `attachment`, `friendly_name`, `submit_date`, `sent_date`, `is_sent`) VALUES
(7, 'vmhone@ic-techafrica.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Hosting Services.docx</b> sent from <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210313\\1615627279_623204f95995c9ad674f.docx', 'Hosting Services.docx', '2021-03-15 15:37:29', '2021-03-15 15:38:02', 1),
(8, 'mhone.vitu@gmail.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Ecoo Presentation.pptx</b> sent on behalf of <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210315\\1615800189_c5e9e7680e7b106092b4.pptx', 'Ecoo Presentation.pptx', '2021-03-15 18:20:59', '2021-03-15 18:21:19', 1),
(9, 'mphatsomtukuso@gmail.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Ecoo Presentation.pptx</b> sent on behalf of <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210315\\1615800189_c5e9e7680e7b106092b4.pptx', 'Ecoo Presentation.pptx', '2021-03-15 18:20:59', '2021-03-15 18:21:33', 1),
(10, 'vmhone@ic-techafrica.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Modern Servers.pdf</b> sent on behalf of <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210317\\1615993870_96885c3f4f2db78fb692.pdf', 'Modern Servers.pdf', '2021-03-17 17:11:41', '2021-03-17 17:12:11', 1);
INSERT INTO `outgoing_email` (`row_id`, `recipient`, `email_message`, `subject`, `attachment`, `friendly_name`, `submit_date`, `sent_date`, `is_sent`) VALUES
(11, 'vmhone@ic-techafrica.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table align=\"center\" bgcolor=\"#fff\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Password Reset</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello Vitu Mhone,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">You recently told us that you forgot your password.</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Click the link below to reset your password (or alternatively copy and paste it in your browser):</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">http://localhost:8080/index.php/Common/ValidatePasswordReset/0be851eadc1d4cc28df5a478e44fea85</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Note that this link is valid for 1 hour. </span><span style=\"color: #236fa1; font-size: 12px;\">If you did not initiate the reset process, then simply ignore the email.</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p> </p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Password Reset Request', NULL, '', '2021-03-18 09:35:09', '2021-03-18 09:35:27', 1),
(12, 'vmhone@ic-techafrica.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Password Reset</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello Vitu Mhone,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your password has been reset. Find your new password below:</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">New Password: <b> qS9Bx!k! </b></span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Please login to change your password</span><span style=\"color: #236fa1; font-size: 12px;\"></span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p> </p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Password Reset', NULL, '', '2021-03-18 09:39:18', '2021-03-18 09:39:39', 1),
(13, 'vmhone@ic-techafrica.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Password Changed</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello Vitu Mhone,</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your password has been successfully changed on: <b>Thursday 18th of March 2021 09:40:39 AM</b><br /><br />Timezone: Africa/Harare.</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">If you did not initiate the change, contact your support team immediately.</span><span style=\"color: #236fa1; font-size: 12px;\"></span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p>&nbsp;</p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Password Changed', NULL, '', '2021-03-18 09:40:39', '2021-03-18 14:33:44', 1),
(14, 'vmhone@ic-techafrica.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Uploaded</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello Vitu Mhone,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">The document <b>Brochure</b> has been uploaded by <b>Vitu Mhone (mhone.vitu@gmail.com)</b> to the folder <b>Shared Folder</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Uploaded', NULL, '', '2021-03-18 14:32:56', '2021-03-18 14:33:49', 1);
INSERT INTO `outgoing_email` (`row_id`, `recipient`, `email_message`, `subject`, `attachment`, `friendly_name`, `submit_date`, `sent_date`, `is_sent`) VALUES
(15, 'johnmhone@yahoo.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>Brochure.pdf</b> sent on behalf of <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\1616070775_ff6c8e7c38ea0b745a92.pdf', 'Brochure.pdf', '2021-03-18 14:33:29', '2021-03-18 14:34:00', 1),
(16, 'vmhone@ic-techafrica.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">One-Time PIN</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello Vitu Mhone,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Your one time PIN for this session is <b>136280</b>.</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">The code is valid for 30 minute(s).</span><span style=\"color: #236fa1; font-size: 12px;\"></span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'One-Time Pin (OTP)', NULL, '', '2021-03-18 14:34:01', '2021-03-18 14:34:09', 1),
(17, 'mhone.vitu@gmail.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table align=\"center\" bgcolor=\"#fff\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Password Reset</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello Vitu Mhone,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">You recently told us that you forgot your password.</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Click the link below to reset your password (or alternatively copy and paste it in your browser):</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">http://localhost:8080/index.php/Common/ValidatePasswordReset/c047c528ffd64f41a82b51ad0191d614</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Note that this link is valid for 1 hour. </span><span style=\"color: #236fa1; font-size: 12px;\">If you did not initiate the reset process, then simply ignore the email.</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p> </p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Password Reset Request', NULL, '', '2021-03-19 10:02:36', '2021-03-19 10:03:30', 1),
(18, 'mphatsomtukuso@gmail.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>WHO COVID-19 global table data December 30th 2020 at 5.01.06 PM.csv</b> sent on behalf of <b>Vitu Mhone (vmhone@ic-techafrica.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210319\\1616167000_9fff78f071ef9b4e3189.csv', 'WHO COVID-19 global table data December 30th 2020 at 5.01.06 PM.csv', '2021-03-19 17:19:50', '2021-03-19 17:20:02', 1);
INSERT INTO `outgoing_email` (`row_id`, `recipient`, `email_message`, `subject`, `attachment`, `friendly_name`, `submit_date`, `sent_date`, `is_sent`) VALUES
(19, 'vmhone@outlook.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table bgcolor=\"#fff\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Document Received</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Find attached <b>AHL 252 Product Brief.pdf</b> sent on behalf of <b>Vitu Mhone (mhone.vitu@gmail.com)</b></span></p>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<div>&nbsp;</div>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<div>&nbsp;</div>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<div>&nbsp;</div>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Document Received', 'C:\\xampp\\htdocs\\dms\\writable\\uploads\\20210318\\1616070913_6704e01c45636eec236b.pdf', 'AHL 252 Product Brief.pdf', '2021-05-01 13:59:04', '2021-05-01 13:59:54', 1),
(20, 'mhone.vitu@gmail.com', '<!doctype html>\r\n    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n      <head>\r\n        <title>\r\n          \r\n        </title>\r\n        <!--[if !mso]><!-- -->\r\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n        <!--<![endif]-->\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n        <style type=\"text/css\">\r\n          #outlook a { padding:0; }\r\n          .ReadMsgBody { width:100%; }\r\n          .ExternalClass { width:100%; }\r\n          .ExternalClass * { line-height:100%; }\r\n          body { margin:0;padding:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%; }\r\n          table, td { border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt; }\r\n          img { border:0;height:auto;line-height:100%; outline:none;text-decoration:none;-ms-interpolation-mode:bicubic; }\r\n          p { display:block;margin:13px 0; }\r\n        </style>\r\n        <!--[if !mso]><!-->\r\n        <style type=\"text/css\">\r\n          @media only screen and (max-width:480px) {\r\n            @-ms-viewport { width:320px; }\r\n            @viewport { width:320px; }\r\n          }\r\n        </style>\r\n        <!--<![endif]-->\r\n        <!--[if mso]>\r\n        <xml>\r\n        <o:OfficeDocumentSettings>\r\n          <o:AllowPNG/>\r\n          <o:PixelsPerInch>96</o:PixelsPerInch>\r\n        </o:OfficeDocumentSettings>\r\n        </xml>\r\n        <![endif]-->\r\n        <!--[if lte mso 11]>\r\n        <style type=\"text/css\">\r\n          .outlook-group-fix { width:100% !important; }\r\n        </style>\r\n        <![endif]-->\r\n        \r\n      <!--[if !mso]><!-->\r\n        <link href=\"https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\r\n<link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700\" rel=\"stylesheet\" type=\"text/css\">\r\n        <style type=\"text/css\">\r\n          @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);\r\n@import url(https://fonts.googleapis.com/css?family=Cabin:400,700);\r\n        </style>\r\n      <!--<![endif]-->\r\n\r\n    \r\n        \r\n    <style type=\"text/css\">\r\n      @media only screen and (min-width:480px) {\r\n        .mj-column-per-100 { width:100% !important; max-width: 100%; }\r\n      }\r\n    </style>\r\n    \r\n  \r\n        <style type=\"text/css\">\r\n        \r\n        \r\n\r\n    @media only screen and (max-width:480px) {\r\n      table.full-width-mobile { width: 100% !important; }\r\n      td.full-width-mobile { width: auto !important; }\r\n    }\r\n  \r\n        </style>\r\n        <style type=\"text/css\">.hide_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_mobile { display: block !important;} }\r\n        .hide_section_on_mobile { display: none !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_mobile { display: table !important;} }\r\n        .hide_on_desktop { display: block !important;} \r\n        @media only screen and (min-width: 480px) { .hide_on_desktop { display: none !important;} }\r\n        .hide_section_on_desktop { display: table !important;} \r\n        @media only screen and (min-width: 480px) { .hide_section_on_desktop { display: none !important;} }\r\n        [owa] .mj-column-per-100 {\r\n            width: 100%!important;\r\n          }\r\n          [owa] .mj-column-per-50 {\r\n            width: 50%!important;\r\n          }\r\n          [owa] .mj-column-per-33 {\r\n            width: 33.333333333333336%!important;\r\n          }\r\n          p {\r\n              margin: 0px;\r\n          }\r\n          @media only print and (min-width:480px) {\r\n            .mj-column-per-100 { width:100%!important; }\r\n            .mj-column-per-40 { width:40%!important; }\r\n            .mj-column-per-60 { width:60%!important; }\r\n            .mj-column-per-50 { width: 50%!important; }\r\n            mj-column-per-33 { width: 33.333333333333336%!important; }\r\n            }</style>\r\n        \r\n      </head>\r\n      <body style=\"background-color:#4d4d4d;\">\r\n        \r\n        \r\n      <div style=\"background-color:#4d4d4d;\">\r\n        \r\n      \r\n      <!--[if mso | IE]>\r\n      <table\r\n         align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\" style=\"width:600px;\" width=\"600\"\r\n      >\r\n        <tr>\r\n          <td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n      <![endif]-->\r\n    \r\n      \r\n      <div style=\"Margin:0px auto;max-width:600px;\">\r\n        \r\n        <table align=\"center\" bgcolor=\"#fff\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\r\n          <tbody>\r\n            <tr>\r\n              <td style=\"direction:ltr;font-size:0px;padding:9px 0px 9px 0px;text-align:center;vertical-align:top;\">\r\n                <!--[if mso | IE]>\r\n                  <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                \r\n        <tr>\r\n      \r\n            <td\r\n               class=\"\" style=\"vertical-align:top;width:600px;\"\r\n            >\r\n          <![endif]-->\r\n            \r\n      <div class=\"mj-column-per-100 outlook-group-fix\" style=\"font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;\">\r\n        \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:top;\" width=\"100%\">\r\n        \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><strong><span style=\"font-size: 17px;\">Password Reset</span></strong></p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n        <p><span style=\"color: #236fa1; font-size: 12px;\">Hello Vitu Mhone,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">You recently told us that you forgot your password.</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Click the link below to reset your password (or alternatively copy and paste it in your browser):</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">http://localhost:8080/index.php/Common/ValidatePasswordReset/3a37a7dd6f2c4d778d8397af68dfd932</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Note that this link is valid for 1 hour. </span><span style=\"color: #236fa1; font-size: 12px;\">If you did not initiate the reset process, then simply ignore the email.</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Regards,</span></p>\r\n<p> </p>\r\n<p><span style=\"color: #236fa1; font-size: 12px;\">Document Management System</span></p>\r\n<p> </p>\r\n<p><em>(This email was auto-generated. Please do not reply)</em></p>\r\n<p> </p>\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"left\" style=\"font-size:0px;padding:15px 15px 15px 15px;word-break:break-word;\">\r\n                \r\n      <div style=\"font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:1.2;text-align:left;color:#000000;\">\r\n      </div>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td style=\"font-size:0px;padding:10px 25px;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:25px;word-break:break-word;\">\r\n                \r\n      <p style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:100%;\">\r\n      </p>\r\n      \r\n      <!--[if mso | IE]>\r\n        <table\r\n           align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-top:solid 1px #000000;font-size:1;margin:0px auto;width:565px;\" role=\"presentation\" width=\"565px\"\r\n        >\r\n          <tr>\r\n            <td style=\"height:0;line-height:0;\">\r\n              &nbsp;\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      <![endif]-->\r\n    \r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n            <tr>\r\n              <td align=\"center\" style=\"font-size:0px;padding:0px 0px 0px 0px;word-break:break-word;\">\r\n                \r\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\r\n        <tbody>\r\n          <tr>\r\n            <td style=\"width:600px;\">\r\n              \r\n      <img height=\"auto\" src=\"https://s3-eu-west-1.amazonaws.com/topolio/uploads/6017b7806026c/1612167615.jpg\" style=\"border:0;display:block;outline:none;text-decoration:none;height:auto;width:100%;font-size:13px;\" width=\"600\">\r\n    \r\n            </td>\r\n          </tr>\r\n        </tbody>\r\n      </table>\r\n    \r\n              </td>\r\n            </tr>\r\n          \r\n      </table>\r\n    \r\n      </div>\r\n    \r\n          <!--[if mso | IE]>\r\n            </td>\r\n          \r\n        </tr>\r\n      \r\n                  </table>\r\n                <![endif]-->\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        \r\n      </div>\r\n    \r\n      \r\n      <!--[if mso | IE]>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n      <![endif]-->\r\n    \r\n    \r\n      </div>\r\n    \r\n      </body>\r\n    </html>', 'Password Reset Request', NULL, '', '2021-05-29 19:12:22', '2021-05-29 19:12:30', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_history`
--

CREATE TABLE `password_history` (
  `row_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `date_logged` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `password_history`
--

INSERT INTO `password_history` (`row_id`, `user_id`, `password`, `date_logged`) VALUES
(1, 22, 'pXcMk16UwIPqosWgBGDCNpfdLPC2wUojHbJ0sbPp/8EbEnMhEVlpcX42rXA0sc4fqV46CTImqvqmHq76JqhajA==', '2021-02-16 09:20:35'),
(2, 21, '6i7pgA+6Xib8kXw6Y602ZlVdqou860C3jo0hixNkUrlnQGFcrhTKP5JKogsaZZw/5fmUrEkwx3H/0R7aED43Vw==', '2021-02-19 16:34:43'),
(3, 18, '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', '2021-02-20 17:16:17'),
(4, 18, 'fi/qyV3NfR34AzReGXNpr0sVbk56lfyylVvbuzoRr9i7nTWTG/FVETcLGBQ+OLAbkD9Vxey97Ur5mTRgL83zjA==', '2021-03-18 09:39:18'),
(5, 18, 'OEYMDMeaLikn3/AHHd06roXFqljOznbXbyC3R7bbeW77dJI9A7VdzS2rWion5XNcFlwILNNLOejhNlApZabGow==', '2021-03-18 09:40:39');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset`
--

CREATE TABLE `password_reset` (
  `row_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `request_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiry_time` datetime NOT NULL,
  `token_state` smallint(6) NOT NULL DEFAULT '0',
  `token_usage_time` datetime DEFAULT NULL,
  `generated_token` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `password_reset`
--

INSERT INTO `password_reset` (`row_id`, `user_id`, `request_time`, `expiry_time`, `token_state`, `token_usage_time`, `generated_token`) VALUES
(1, 1, '2021-02-12 11:24:46', '2021-02-12 12:24:46', 0, NULL, '9eb535b9406d49968e1939ea1d40204e'),
(2, 18, '2021-02-12 12:58:04', '2021-02-12 13:58:04', 0, NULL, 'db680c202ddf48b19b1e33641850e714'),
(3, 1, '2021-02-12 16:56:41', '2021-02-12 17:56:41', 0, NULL, '437365f575cd40f7912f6ea71a0ea394'),
(4, 1, '2021-02-12 17:00:00', '2021-02-12 18:00:00', 0, NULL, 'ba61d4a71bad44c7b323d1d6e069d9af'),
(5, 18, '2021-02-12 19:00:57', '2021-02-12 20:00:57', 0, NULL, 'c918b3bcda3c4306bc915ac8ea395ee8'),
(6, 1, '2021-02-13 07:56:45', '2021-02-13 08:56:45', 0, NULL, '8983d950d36a4ed6855bdc1712a66974'),
(7, 18, '2021-02-13 08:20:32', '2021-02-13 09:20:32', 0, NULL, '579f0632ced24b389ae940eb2180fc18'),
(8, 21, '2021-02-15 11:24:59', '2021-02-15 12:24:59', 0, NULL, 'fff4d29fe7b640f89e2b6631c77fb7e0'),
(9, 21, '2021-02-19 16:18:30', '2021-02-19 17:18:30', 1, '2021-02-19 16:34:48', '17447f8a591842219cb79a6c2ec94c5b'),
(10, 18, '2021-02-20 10:55:19', '2021-02-20 11:55:19', 0, NULL, '5b9f7cd2e4704dc4bdb89aeec3e5838e'),
(11, 1, '2021-02-23 09:33:02', '2021-02-23 10:33:02', 0, NULL, 'aff72727135e4402acec0c85d1063a71'),
(12, 1, '2021-03-15 11:07:31', '2021-03-15 12:07:31', 0, NULL, '12323e474e4f48db89dbcb813ab03be0'),
(13, 1, '2021-03-15 11:09:59', '2021-03-15 12:09:59', 0, NULL, 'b21e24ec8e924f9c9ff16cd628928645'),
(14, 18, '2021-03-18 09:35:09', '2021-03-18 10:35:09', 1, '2021-03-18 09:39:39', '0be851eadc1d4cc28df5a478e44fea85'),
(15, 1, '2021-03-19 10:02:35', '2021-03-19 11:02:35', 0, NULL, 'c047c528ffd64f41a82b51ad0191d614'),
(16, 1, '2021-05-29 19:12:22', '2021-05-29 20:12:22', 0, NULL, '3a37a7dd6f2c4d778d8397af68dfd932');

-- --------------------------------------------------------

--
-- Table structure for table `platform`
--

CREATE TABLE `platform` (
  `row_id` bigint(20) NOT NULL,
  `user_agent` varchar(100) DEFAULT '',
  `version` varchar(50) DEFAULT '',
  `is_robot` bit(1) DEFAULT NULL,
  `is_mobile` bit(1) DEFAULT NULL,
  `platform` varchar(50) DEFAULT NULL,
  `date_logged` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table keeps track about the platforms accessing the system';

--
-- Dumping data for table `platform`
--

INSERT INTO `platform` (`row_id`, `user_agent`, `version`, `is_robot`, `is_mobile`, `platform`, `date_logged`) VALUES
(1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:13:00'),
(2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:13:02'),
(3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:13:44'),
(4, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 11:16:42'),
(5, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:18:06'),
(6, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 11:18:53'),
(7, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:20:50'),
(8, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:20:55'),
(9, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:21:37'),
(10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:24:04'),
(11, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:24:13'),
(12, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 11:27:38'),
(13, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 12:57:54'),
(14, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 12:58:45'),
(15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 13:08:09'),
(16, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-12 13:08:12'),
(17, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:03:02'),
(18, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:04:07'),
(19, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:05:55'),
(20, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:06:04'),
(21, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:17:53'),
(22, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:18:58'),
(23, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:56:10'),
(24, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:56:31'),
(25, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 16:59:53'),
(26, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 17:00:25'),
(27, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-12 17:00:53'),
(28, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 18:37:24'),
(29, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 18:37:49'),
(30, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 18:38:00'),
(31, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 18:42:08'),
(32, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 18:44:37'),
(33, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 18:44:37'),
(34, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 18:58:15'),
(35, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 18:58:38'),
(36, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 19:01:04'),
(37, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 22:06:25'),
(38, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-12 22:07:28'),
(39, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-13 07:00:59'),
(40, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-13 07:01:22'),
(41, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-13 07:56:30'),
(42, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-13 07:56:53'),
(43, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-13 07:58:17'),
(44, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-13 07:59:02'),
(45, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-13 08:20:02'),
(46, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-13 08:20:15'),
(47, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-13 08:20:42'),
(48, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', '85.0', b'0', b'0', 'Windows 8', '2021-02-13 08:21:56'),
(49, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-13 08:35:21'),
(50, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-13 08:37:09'),
(51, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 08:26:09'),
(52, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 08:26:09'),
(53, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 09:00:38'),
(54, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 10:26:41'),
(55, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 10:27:07'),
(56, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 11:22:58'),
(57, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 11:23:10'),
(58, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 11:25:54'),
(59, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 11:26:05'),
(60, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 11:33:05'),
(61, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 11:33:21'),
(62, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 11:42:47'),
(63, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 12:00:36'),
(64, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 12:01:06'),
(65, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-15 12:04:46'),
(66, 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150', '88.0.4324.150', b'0', b'0', 'Windows 8.1', '2021-02-15 15:28:46'),
(67, 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150', '88.0.4324.150', b'0', b'0', 'Windows 8.1', '2021-02-15 15:28:52'),
(68, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 17:12:58'),
(69, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 17:13:23'),
(70, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 17:17:10'),
(71, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 17:25:14'),
(72, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 17:25:52'),
(73, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 17:49:18'),
(74, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 17:49:29'),
(75, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 18:08:25'),
(76, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 18:12:17'),
(77, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 18:12:22'),
(78, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-15 20:50:25'),
(79, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-16 07:50:16'),
(80, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 07:53:23'),
(81, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 07:53:24'),
(82, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 07:53:51'),
(83, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 07:55:49'),
(84, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 07:56:00'),
(85, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 07:58:39'),
(86, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 07:59:45'),
(87, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:37:59'),
(88, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:37:59'),
(89, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:38:18'),
(90, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-16 08:38:24'),
(91, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:38:32'),
(92, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:38:32'),
(93, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:38:32'),
(94, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:39:08'),
(95, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:39:35'),
(96, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:39:35'),
(97, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:39:36'),
(98, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:40:36'),
(99, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:40:37'),
(100, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:40:41'),
(101, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:40:55'),
(102, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:41:08'),
(103, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:41:14'),
(104, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:41:24'),
(105, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:42:27'),
(106, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:50:25'),
(107, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:50:26'),
(108, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:50:55'),
(109, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:55:28'),
(110, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:55:32'),
(111, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:55:37'),
(112, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:57:57'),
(113, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:57:57'),
(114, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 08:58:16'),
(115, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 09:00:51'),
(116, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 09:01:41'),
(117, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 09:02:01'),
(118, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 09:14:42'),
(119, 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.2.0.1713 Safar', '69.2.0.1713', b'0', b'0', 'Windows 10', '2021-02-16 09:18:11'),
(120, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 09:19:27'),
(121, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 11:00:44'),
(122, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 13:38:44'),
(123, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 13:44:49'),
(124, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:01:30'),
(125, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:04:46'),
(126, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:04:50'),
(127, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:15:25'),
(128, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:15:26'),
(129, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:33:46'),
(130, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:37:27'),
(131, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:38:11'),
(132, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:46:10'),
(133, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-16 14:47:57'),
(134, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-16 15:34:20'),
(135, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-16 17:07:24'),
(136, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-16 17:14:56'),
(137, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-16 17:15:43'),
(138, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 07:55:12'),
(139, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 07:55:12'),
(140, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 07:55:56'),
(141, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 08:01:56'),
(142, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 08:03:07'),
(143, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 08:11:08'),
(144, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 08:14:34'),
(145, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 08:14:35'),
(146, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 08:27:14'),
(147, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 11:34:30'),
(148, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 11:34:30'),
(149, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 11:34:50'),
(150, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 11:48:50'),
(151, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 11:50:59'),
(152, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-17 11:51:04'),
(153, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-17 17:30:11'),
(154, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-17 17:50:35'),
(155, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-18 08:29:05'),
(156, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-18 08:29:05'),
(157, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-18 08:39:18'),
(158, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-18 08:39:18'),
(159, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:11:27'),
(160, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:11:27'),
(161, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:13:14'),
(162, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:14:12'),
(163, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:14:38'),
(164, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:14:50'),
(165, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:17:00'),
(166, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:17:52'),
(167, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:22:27'),
(168, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:26:11'),
(169, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:28:40'),
(170, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:45:34'),
(171, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:45:58'),
(172, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:53:46'),
(173, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 08:57:08'),
(174, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:04:01'),
(175, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:07:17'),
(176, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:25:06'),
(177, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:25:07'),
(178, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:25:35'),
(179, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:28:01'),
(180, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:30:05'),
(181, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:33:32'),
(182, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 09:33:38'),
(183, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 10:06:59'),
(184, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 10:07:07'),
(185, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 10:07:17'),
(186, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 10:07:34'),
(187, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 10:10:06'),
(188, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 10:24:59'),
(189, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 11:14:59'),
(190, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-19 12:06:34'),
(191, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-19 16:17:33'),
(192, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-19 16:17:39'),
(193, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-19 16:18:16'),
(194, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-19 16:18:53'),
(195, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-20 10:52:30'),
(196, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-20 10:55:03'),
(197, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-20 10:55:27'),
(198, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-20 10:56:11'),
(199, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-20 17:15:14'),
(200, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-20 17:15:23'),
(201, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-20 17:15:26'),
(202, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0', '72.0', b'0', b'0', 'Linux', '2021-02-20 17:16:21'),
(203, 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182', '88.0.4324.182', b'0', b'0', 'Windows 8', '2021-02-20 17:17:00'),
(204, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 08:23:40'),
(205, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 08:23:40'),
(206, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 08:23:48'),
(207, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 08:25:45'),
(208, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 08:30:25'),
(209, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:03:56'),
(210, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:03:57'),
(211, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:06:18'),
(212, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:07:33'),
(213, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:17:40'),
(214, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:18:08'),
(215, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:18:25'),
(216, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:23:22'),
(217, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:24:18'),
(218, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:25:05'),
(219, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:25:55'),
(220, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:29:34'),
(221, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:29:37'),
(222, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:32:32'),
(223, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:43:00'),
(224, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:47:39'),
(225, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 10:49:53'),
(226, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:04:00'),
(227, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:04:02'),
(228, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:04:45'),
(229, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:22:03'),
(230, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:37:14'),
(231, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:52:50'),
(232, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:57:47'),
(233, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:58:07'),
(234, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 11:58:17'),
(235, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 12:00:06'),
(236, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 12:05:00'),
(237, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-22 12:05:09'),
(238, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 08:53:34'),
(239, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 08:53:34'),
(240, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 08:57:20'),
(241, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 09:27:39'),
(242, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 09:32:55'),
(243, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 09:36:15'),
(244, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 09:36:18'),
(245, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 09:36:47'),
(246, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 09:40:28'),
(247, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:01:28'),
(248, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:01:31'),
(249, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:02:13'),
(250, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:07:57'),
(251, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:08:01'),
(252, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:08:03'),
(253, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:08:29'),
(254, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:09:27'),
(255, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:56:21'),
(256, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:57:43'),
(257, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 10:57:53'),
(258, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 11:14:52'),
(259, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 11:20:42'),
(260, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 11:32:50'),
(261, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.15', '88.0.4324.150', b'0', b'0', 'Windows 10', '2021-02-23 11:32:50'),
(262, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:10:12'),
(263, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:14:41'),
(264, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:18:19'),
(265, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:24:10'),
(266, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:30:21'),
(267, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:31:01'),
(268, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:55:27'),
(269, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:57:14'),
(270, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 10:59:16'),
(271, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 11:00:11'),
(272, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 11:07:56'),
(273, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 11:59:56'),
(274, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 15:01:25'),
(275, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 15:01:38'),
(276, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 15:01:58'),
(277, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 15:06:52'),
(278, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-11 17:02:32'),
(279, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 07:05:33'),
(280, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 07:07:43'),
(281, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 07:14:20'),
(282, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 07:22:11'),
(283, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 08:16:48'),
(284, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 08:28:00'),
(285, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 08:28:01'),
(286, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 08:28:57'),
(287, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 08:29:22'),
(288, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 08:29:34'),
(289, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 08:56:30'),
(290, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 10:47:17'),
(291, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 11:08:38'),
(292, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 11:22:03'),
(293, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 16:19:32'),
(294, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-12 17:24:48'),
(295, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:19:33'),
(296, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:20:08'),
(297, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:20:40'),
(298, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:21:09'),
(299, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:21:39'),
(300, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:24:45'),
(301, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:27:18'),
(302, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:27:23'),
(303, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 08:33:08'),
(304, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 09:18:50'),
(305, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 09:33:41'),
(306, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 09:37:37'),
(307, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 09:38:05');
INSERT INTO `platform` (`row_id`, `user_agent`, `version`, `is_robot`, `is_mobile`, `platform`, `date_logged`) VALUES
(308, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 10:32:41'),
(309, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 11:10:39'),
(310, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 15:46:13'),
(311, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 18:24:34'),
(312, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 18:29:47'),
(313, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 18:30:39'),
(314, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 18:38:15'),
(315, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72', '89.0.4389.72', b'0', b'0', 'Windows 10', '2021-03-13 19:14:57'),
(316, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 19:38:27'),
(317, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 19:38:35'),
(318, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-13 20:42:20'),
(319, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 08:27:07'),
(320, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 08:56:48'),
(321, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 09:12:18'),
(322, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 09:12:28'),
(323, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 10:33:46'),
(324, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 10:34:30'),
(325, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 10:34:45'),
(326, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 11:07:26'),
(327, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 11:12:21'),
(328, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 13:08:09'),
(329, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 13:08:11'),
(330, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 13:44:18'),
(331, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 13:45:43'),
(332, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 13:46:09'),
(333, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 13:47:04'),
(334, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72', '89.0.4389.72', b'0', b'0', 'Windows 10', '2021-03-15 13:59:49'),
(335, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72', '89.0.4389.72', b'0', b'0', 'Windows 10', '2021-03-15 14:00:16'),
(336, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72', '89.0.4389.72', b'0', b'0', 'Windows 10', '2021-03-15 14:47:26'),
(337, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 14:54:58'),
(338, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72', '89.0.4389.72', b'0', b'0', 'Windows 10', '2021-03-15 16:08:30'),
(339, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 18:19:57'),
(340, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 18:20:06'),
(341, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-15 21:01:53'),
(342, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-16 09:32:22'),
(343, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-16 09:33:39'),
(344, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-16 09:33:40'),
(345, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-16 10:33:56'),
(346, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-16 16:19:31'),
(347, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-17 08:07:46'),
(348, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-17 09:47:55'),
(349, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-17 12:28:48'),
(350, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-17 16:05:36'),
(351, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-17 16:40:45'),
(352, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-17 20:15:30'),
(353, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-17 20:48:28'),
(354, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-17 21:29:13'),
(355, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 06:20:40'),
(356, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 08:27:52'),
(357, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 09:34:53'),
(358, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 09:35:30'),
(359, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 09:40:09'),
(360, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 09:48:56'),
(361, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 09:49:08'),
(362, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 09:59:36'),
(363, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 10:13:31'),
(364, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 10:35:28'),
(365, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 10:35:41'),
(366, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 10:52:38'),
(367, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 11:10:58'),
(368, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 11:14:43'),
(369, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 11:21:51'),
(370, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 11:42:18'),
(371, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 11:44:27'),
(372, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 11:50:01'),
(373, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 11:53:59'),
(374, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 12:01:11'),
(375, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 12:01:33'),
(376, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 12:10:48'),
(377, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:31:32'),
(378, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:31:47'),
(379, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:33:56'),
(380, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:37:24'),
(381, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:37:43'),
(382, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:37:56'),
(383, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:39:43'),
(384, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:41:01'),
(385, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-18 14:41:47'),
(386, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 05:52:31'),
(387, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 07:02:58'),
(388, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 07:56:16'),
(389, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 07:56:16'),
(390, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 07:56:16'),
(391, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 07:57:09'),
(392, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 08:25:21'),
(393, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 08:38:56'),
(394, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 10:02:28'),
(395, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 10:07:08'),
(396, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 11:01:59'),
(397, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 11:24:24'),
(398, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 11:24:50'),
(399, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 11:24:51'),
(400, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 14:03:27'),
(401, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 15:10:53'),
(402, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0', '86.0', b'0', b'0', 'Windows 10', '2021-03-19 16:28:38');

-- --------------------------------------------------------

--
-- Table structure for table `privilege`
--

CREATE TABLE `privilege` (
  `row_id` int(11) NOT NULL,
  `level` smallint(6) NOT NULL,
  `description` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `privilege`
--

INSERT INTO `privilege` (`row_id`, `level`, `description`) VALUES
(1, 0, 'READ'),
(2, 1, 'WRITE');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` smallint(6) NOT NULL,
  `description` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `description`) VALUES
(1, 'Administrator'),
(4, 'Restricted User'),
(3, 'Standard User'),
(2, 'Super User');

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `row_id` int(11) NOT NULL,
  `role_id` smallint(6) NOT NULL DEFAULT '0',
  `base_path` varchar(50) NOT NULL DEFAULT '',
  `route_path` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`row_id`, `role_id`, `base_path`, `route_path`) VALUES
(1, 1, '', '/Common/Password'),
(2, 1, '', '/Common/Logout'),
(3, 1, '', '/Common/Index'),
(4, 1, '', '/Common/MyProfile'),
(5, 1, '', '/Common/ChangePassword'),
(6, 1, '', '/Dashboard/Index'),
(7, 1, '', '/Dashboard/GetDashboardStatistics'),
(8, 1, '', '/Dashboard/GetLargestFolders'),
(9, 1, '', '/Dashboard/GetLatestFolders'),
(10, 1, '', '/Dashboard/GetLatestFiles'),
(11, 1, '', '/Document/Index'),
(12, 1, '', '/Document/GetAvailableDocuments'),
(13, 1, '', '/Document/GetDocumentVersionHistory'),
(14, 1, '', '/Document/GetDocumentDetails'),
(15, 1, '', '/Document/Manage'),
(16, 1, '', '/Document/ValidateDocumentUpdate'),
(17, 1, '', '/Document/ChangeDocumentState'),
(18, 1, '', '/Document/TransferDocument'),
(19, 1, '', '/Document/Search'),
(20, 1, '', '/Document/SearchDocument'),
(21, 1, '', '/Document/InitiateDocumentUpdate'),
(22, 1, '', '/Document/DownloadDocument'),
(23, 1, '', '/Document/RenameDocument'),
(24, 1, '', '/Document/UpdateDocument'),
(25, 1, '', '/Document/UploadNewDocument'),
(26, 1, '', '/Folder/Index'),
(27, 1, '', '/Folder/GetAvailableOwners'),
(28, 1, '', '/Folder/Manage'),
(29, 1, '', '/Folder/GetAvailableFolders'),
(30, 1, '', '/Folder/GetFolderStates'),
(31, 1, '', '/Folder/GetFolderDetails'),
(32, 1, '', '/Folder/GetDocumentsInFolder'),
(33, 1, '', '/Folder/ModifyFolder'),
(34, 1, '', '/Folder/RenameFolder'),
(35, 1, '', '/Folder/CreateNewFolder'),
(36, 1, '', '/Group/GetAvailableGroups'),
(37, 1, '', '/Group/GetGroupDetails'),
(38, 1, '', '/Group/Manage'),
(39, 1, '', '/Group/Index'),
(40, 1, '', '/Group/ModifyGroup'),
(41, 1, '', '/Group/CreateGroup'),
(42, 1, '', '/GroupMembership/GetGroupMembership'),
(43, 1, '', '/GroupMembership/GetGroupMemberShipById'),
(44, 1, '', '/GroupMembership/GetAvailableUsers'),
(45, 1, '', '/GroupMembership/DoMemberOperation'),
(46, 1, '', '/SystemConfig/Index'),
(47, 1, '', '/SystemConfig/SaveChanges'),
(48, 1, '', '/User/Index'),
(49, 1, '', '/User/Manage'),
(50, 1, '', '/User/GetAvailableRoles'),
(51, 1, '', '/User/GetAvailableUsers'),
(52, 1, '', '/User/GetUserDetails'),
(53, 1, '', '/User/ModifyProfile'),
(54, 1, '', '/User/ResetPassword'),
(55, 1, '', '/User/CreateUser'),
(175, 1, '', '/Privilege/GetGroupAccessOnFolder'),
(176, 1, '', '/Privilege/GetUserAccessOnFolder'),
(177, 1, '', '/Privilege/RevokePrivilegeOnFolder'),
(178, 1, '', '/Privilege/GrantPrivilegeOnFolder'),
(179, 1, '', '/Privilege/GetPrivilegeAssignedToGroupOnFolder'),
(180, 1, '', '/Privilege/ModifyPrivilegeOnFolder'),
(181, 1, '', '/Privilege/GetPrivilegeAssignedToUserOnFolder'),
(182, 1, '', '/Privilege/GetPrivilegeAssignedToGroupOnDocument'),
(183, 1, '', '/Privilege/GetPrivilegeAssignedToUserOnDocument'),
(184, 1, '', '/Privilege/ModifyPrivilegeOnDocument'),
(185, 1, '', '/Privilege/GetUserAccessOnDocument'),
(187, 1, '', '/Privilege/GetGroupAccessOnDocument'),
(188, 2, '', '/Common/ChangePassword'),
(189, 2, '', '/Common/Index'),
(190, 2, '', '/Common/Logout'),
(191, 2, '', '/Common/MyProfile'),
(192, 2, '', '/Common/Password'),
(193, 2, '', '/Dashboard/GetDashboardStatistics'),
(194, 2, '', '/Dashboard/GetLargestFolders'),
(195, 2, '', '/Dashboard/GetLatestFiles'),
(196, 2, '', '/Dashboard/GetLatestFolders'),
(197, 2, '', '/Dashboard/Index'),
(198, 2, '', '/Document/ChangeDocumentState'),
(199, 2, '', '/Document/DownloadDocument'),
(200, 2, '', '/Document/GetAvailableDocuments'),
(201, 2, '', '/Document/GetDocumentDetails'),
(202, 2, '', '/Document/GetDocumentVersionHistory'),
(203, 2, '', '/Document/Index'),
(204, 2, '', '/Document/InitiateDocumentUpdate'),
(205, 2, '', '/Document/Manage'),
(206, 2, '', '/Document/RenameDocument'),
(207, 2, '', '/Document/Search'),
(208, 2, '', '/Document/SearchDocument'),
(209, 2, '', '/Document/TransferDocument'),
(210, 2, '', '/Document/UpdateDocument'),
(211, 2, '', '/Document/UploadNewDocument'),
(212, 2, '', '/Document/ValidateDocumentUpdate'),
(213, 2, '', '/Folder/CreateNewFolder'),
(214, 2, '', '/Folder/GetAvailableFolders'),
(215, 2, '', '/Folder/GetAvailableOwners'),
(216, 2, '', '/Folder/GetDocumentsInFolder'),
(217, 2, '', '/Folder/GetFolderDetails'),
(218, 2, '', '/Folder/GetFolderStates'),
(219, 2, '', '/Folder/Index'),
(220, 2, '', '/Folder/Manage'),
(221, 2, '', '/Folder/ModifyFolder'),
(222, 2, '', '/Folder/RenameFolder'),
(223, 2, '', '/Group/CreateGroup'),
(224, 2, '', '/Group/GetAvailableGroups'),
(225, 2, '', '/Group/GetGroupDetails'),
(226, 2, '', '/Group/Index'),
(227, 2, '', '/Group/Manage'),
(228, 2, '', '/Group/ModifyGroup'),
(229, 2, '', '/GroupMembership/DoMemberOperation'),
(230, 2, '', '/GroupMembership/GetAvailableUsers'),
(231, 2, '', '/GroupMembership/GetGroupMembership'),
(232, 2, '', '/GroupMembership/GetGroupMemberShipById'),
(233, 2, '', '/Privilege/GetGroupAccessOnDocument'),
(234, 2, '', '/Privilege/GetGroupAccessOnFolder'),
(235, 2, '', '/Privilege/GetPrivilegeAssignedToGroupOnDocument'),
(236, 2, '', '/Privilege/GetPrivilegeAssignedToGroupOnFolder'),
(237, 2, '', '/Privilege/GetPrivilegeAssignedToUserOnDocument'),
(238, 2, '', '/Privilege/GetPrivilegeAssignedToUserOnFolder'),
(239, 2, '', '/Privilege/GetUserAccessOnDocument'),
(240, 2, '', '/Privilege/GetUserAccessOnFolder'),
(241, 2, '', '/Privilege/GrantPrivilegeOnFolder'),
(242, 2, '', '/Privilege/ModifyPrivilegeOnDocument'),
(243, 2, '', '/Privilege/ModifyPrivilegeOnFolder'),
(244, 2, '', '/Privilege/RevokePrivilegeOnFolder'),
(315, 3, '', '/Common/ChangePassword'),
(316, 3, '', '/Common/Index'),
(317, 3, '', '/Common/Logout'),
(318, 3, '', '/Common/MyProfile'),
(319, 3, '', '/Common/Password'),
(320, 3, '', '/Dashboard/GetDashboardStatistics'),
(321, 3, '', '/Dashboard/GetLargestFolders'),
(322, 3, '', '/Dashboard/GetLatestFiles'),
(323, 3, '', '/Dashboard/GetLatestFolders'),
(324, 3, '', '/Dashboard/Index'),
(325, 3, '', '/Document/ChangeDocumentState'),
(326, 3, '', '/Document/DownloadDocument'),
(327, 3, '', '/Document/GetAvailableDocuments'),
(328, 3, '', '/Document/GetDocumentDetails'),
(329, 3, '', '/Document/GetDocumentVersionHistory'),
(332, 3, '', '/Document/Manage'),
(333, 3, '', '/Document/RenameDocument'),
(334, 3, '', '/Document/Search'),
(335, 3, '', '/Document/SearchDocument'),
(336, 3, '', '/Document/TransferDocument'),
(337, 3, '', '/Document/UpdateDocument'),
(338, 3, '', '/Document/UploadNewDocument'),
(339, 3, '', '/Document/ValidateDocumentUpdate'),
(341, 3, '', '/Folder/GetAvailableFolders'),
(342, 3, '', '/Folder/GetAvailableOwners'),
(343, 3, '', '/Folder/GetDocumentsInFolder'),
(344, 3, '', '/Folder/GetFolderDetails'),
(345, 3, '', '/Folder/GetFolderStates'),
(357, 3, '', '/GroupMembership/GetAvailableUsers'),
(358, 3, '', '/GroupMembership/GetGroupMembership'),
(359, 3, '', '/GroupMembership/GetGroupMemberShipById'),
(360, 3, '', '/Privilege/GetGroupAccessOnDocument'),
(361, 3, '', '/Privilege/GetGroupAccessOnFolder'),
(362, 3, '', '/Privilege/GetPrivilegeAssignedToGroupOnDocument'),
(363, 3, '', '/Privilege/GetPrivilegeAssignedToGroupOnFolder'),
(364, 3, '', '/Privilege/GetPrivilegeAssignedToUserOnDocument'),
(365, 3, '', '/Privilege/GetPrivilegeAssignedToUserOnFolder'),
(366, 3, '', '/Privilege/GetUserAccessOnDocument'),
(367, 3, '', '/Privilege/GetUserAccessOnFolder'),
(442, 4, '', '/Common/ChangePassword'),
(443, 4, '', '/Common/Index'),
(444, 4, '', '/Common/Logout'),
(445, 4, '', '/Common/MyProfile'),
(446, 4, '', '/Common/Password'),
(447, 4, '', '/Dashboard/GetDashboardStatistics'),
(448, 4, '', '/Dashboard/GetLargestFolders'),
(449, 4, '', '/Dashboard/GetLatestFiles'),
(450, 4, '', '/Dashboard/GetLatestFolders'),
(451, 4, '', '/Dashboard/Index'),
(453, 4, '', '/Document/DownloadDocument'),
(454, 4, '', '/Document/GetAvailableDocuments'),
(455, 4, '', '/Document/GetDocumentDetails'),
(456, 4, '', '/Document/GetDocumentVersionHistory'),
(457, 4, '', '/Document/Index'),
(459, 4, '', '/Document/Manage'),
(461, 4, '', '/Document/Search'),
(462, 4, '', '/Document/SearchDocument'),
(468, 4, '', '/Folder/GetAvailableFolders'),
(469, 4, '', '/Folder/GetAvailableOwners'),
(470, 4, '', '/Folder/GetDocumentsInFolder'),
(471, 4, '', '/Folder/GetFolderDetails'),
(472, 4, '', '/Folder/GetFolderStates'),
(478, 4, '', '/Group/GetAvailableGroups'),
(479, 4, '', '/Group/GetGroupDetails'),
(483, 4, '', '/GroupMembership/DoMemberOperation'),
(484, 4, '', '/GroupMembership/GetAvailableUsers'),
(485, 4, '', '/GroupMembership/GetGroupMembership'),
(486, 4, '', '/GroupMembership/GetGroupMemberShipById'),
(487, 4, '', '/Privilege/GetGroupAccessOnDocument'),
(488, 4, '', '/Privilege/GetGroupAccessOnFolder'),
(489, 4, '', '/Privilege/GetPrivilegeAssignedToGroupOnDocument'),
(490, 4, '', '/Privilege/GetPrivilegeAssignedToGroupOnFolder'),
(491, 4, '', '/Privilege/GetPrivilegeAssignedToUserOnDocument'),
(492, 4, '', '/Privilege/GetPrivilegeAssignedToUserOnFolder'),
(493, 4, '', '/Privilege/GetUserAccessOnDocument'),
(494, 4, '', '/Privilege/GetUserAccessOnFolder'),
(569, 3, '', '/Folder/Manage'),
(570, 3, '', '/Document/Index'),
(574, 3, '', '/Document/InitiateDocumentUpdate'),
(578, 4, '', '/Folder/Manage'),
(583, 3, '', '/Privilege/ModifyPrivilegeOnFolder'),
(587, 3, '', '/Group/GetAvailableGroups'),
(597, 1, '', '/Dashboard/GetDashboardStatistics/1'),
(598, 2, '', '/Dashboard/GetDashboardStatistics/1'),
(599, 3, '', '/Dashboard/GetDashboardStatistics/1'),
(600, 4, '', '/Dashboard/GetDashboardStatistics/1'),
(601, 3, '', '/User/ModifyProfile'),
(602, 2, '', '/User/ModifyProfile'),
(604, 4, '', '/User/ModifyProfile'),
(606, 3, '', '/Privilege/ModifyPrivilegeOnDocument'),
(607, 1, '', '/Document/DownloadDocumentsAsZip'),
(608, 2, '', '/Document/DownloadDocumentsAsZip'),
(609, 3, '', '/Document/DownloadDocumentsAsZip'),
(610, 4, '', '/Document/DownloadDocumentsAsZip'),
(611, 1, '', '/Document/SendDocumentViaEmail'),
(612, 2, '', '/Document/SendDocumentViaEmail'),
(613, 3, '', '/Document/SendDocumentViaEmail'),
(614, 4, '', '/Document/SendDocumentViaEmail'),
(615, 1, '', '/Document/RenderInBrowser'),
(616, 2, '', '/Document/RenderInBrowser'),
(617, 3, '', '/Document/RenderInBrowser'),
(618, 4, '', '/Document/RenderInBrowser'),
(619, 1, '', '/Document/RenderDocument'),
(620, 2, '', '/Document/RenderDocument'),
(621, 3, '', '/Document/RenderDocument'),
(622, 4, '', '/Document/RenderDocument'),
(624, 1, '', '/Document/BulkUpload'),
(625, 2, '', '/Document/BulkUpload'),
(626, 3, '', '/Document/BulkUpload'),
(627, 4, '', '/Document/BulkUpload'),
(628, 4, '', '/Document/UploadMultipleDocuments'),
(629, 3, '', '/Document/UploadMultipleDocuments'),
(630, 2, '', '/Document/UploadMultipleDocuments'),
(631, 1, '', '/Document/UploadMultipleDocuments'),
(632, 1, '', '/Common/GetUserQuotaAllocation'),
(633, 2, '', '/Common/GetUserQuotaAllocation'),
(634, 3, '', '/Common/GetUserQuotaAllocation'),
(635, 4, '', '/Common/GetUserQuotaAllocation');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` varchar(255) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `last_seen` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email_address` varchar(80) NOT NULL,
  `first_name` varchar(35) NOT NULL,
  `last_name` varchar(35) NOT NULL,
  `role` smallint(6) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_login` bit(1) NOT NULL DEFAULT b'0',
  `last_password_change` datetime DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `state` smallint(6) NOT NULL DEFAULT '1',
  `is_locked` bit(1) DEFAULT b'0',
  `unlock_time` datetime DEFAULT '0000-00-00 00:00:00',
  `quota` int(11) NOT NULL DEFAULT '0',
  `use_otp` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email_address`, `first_name`, `last_name`, `role`, `password`, `first_login`, `last_password_change`, `created_date`, `updated_date`, `last_login`, `state`, `is_locked`, `unlock_time`, `quota`, `use_otp`) VALUES
(1, 'mhone.vitu@gmail.com', 'Vitu', 'Mhone', 1, '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', b'0', '2021-05-29 19:09:15', '2020-09-08 14:29:06', '2021-03-18 10:13:11', '2021-05-29 19:09:23', 1, b'0', NULL, 104857600, 0),
(18, 'vmhone@ic-techafrica.com', 'Vitu', 'Mhone', 2, '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', b'0', '2021-03-18 09:40:39', '2020-12-03 11:37:18', '2021-03-19 14:05:34', '2021-03-19 16:54:30', 1, b'0', NULL, 10485760, 0),
(21, 'vmhone@ahlmw.com', 'Vitu', 'Mhone', 4, 'VoLKstbGnEs7TFXmw7uzdje0tuaTjGH56A/8/G563D/TrNYWD+uiUlZtWZbPwaEewBoKI6lpOqoAO7AgwYtBIQ==', b'1', '2021-02-04 16:13:11', '2021-02-04 16:01:29', '2021-03-19 14:04:57', '2021-02-04 17:35:35', 0, b'0', NULL, 0, 0),
(22, 'jkulemeka@ic-techafrica.com', 'Jimmy', 'Kulemeka', 2, 'tCAGwoo68dw1MIDR4JvSNRjSByPkGwBjegh4A3vni4hiqtKXSz+m33i+B5JBRKLTIWuhGw+kdM7I1EmkRjxYaw==', b'0', '2021-02-16 09:20:35', '2021-02-12 16:03:43', '2021-02-19 08:28:37', '2021-02-16 09:20:03', 0, b'0', '0000-00-00 00:00:00', 104857600, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_activity`
--

CREATE TABLE `user_activity` (
  `row_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `date_logged` datetime NOT NULL,
  `is_success` bit(1) NOT NULL DEFAULT b'0',
  `ip_address` varchar(128) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_activity`
--

INSERT INTO `user_activity` (`row_id`, `user_id`, `date_logged`, `is_success`, `ip_address`) VALUES
(1, 1, '2021-02-12 11:13:23', b'1', '172.18.1.208'),
(2, 1, '2021-02-12 11:24:10', b'1', '172.18.1.208'),
(3, 1, '2021-02-12 11:30:03', b'1', '172.18.1.208'),
(4, 1, '2021-02-12 12:58:51', b'1', '172.18.1.208'),
(5, 1, '2021-02-12 16:03:13', b'1', '172.18.1.186'),
(6, 1, '2021-02-12 16:18:06', b'1', '172.18.1.186'),
(7, 1, '2021-02-12 16:56:18', b'1', '172.18.1.186'),
(8, 1, '2021-02-12 17:00:36', b'1', '172.18.1.186'),
(9, 1, '2021-02-12 18:37:32', b'1', '172.18.1.198'),
(10, 1, '2021-02-12 18:38:06', b'1', '172.18.1.198'),
(11, 1, '2021-02-12 18:42:14', b'1', '172.18.1.198'),
(12, 1, '2021-02-12 18:58:21', b'1', '172.18.1.198'),
(13, 1, '2021-02-12 22:06:32', b'1', '172.18.1.198'),
(14, 1, '2021-02-13 07:01:04', b'1', '172.18.1.198'),
(15, 1, '2021-02-13 07:07:08', b'1', '172.18.1.198'),
(16, 1, '2021-02-13 07:58:22', b'1', '172.18.1.186'),
(17, 1, '2021-02-13 08:20:06', b'1', '172.18.1.186'),
(18, 1, '2021-02-13 08:20:46', b'1', '172.18.1.186'),
(19, 1, '2021-02-13 08:35:28', b'1', '172.18.1.198'),
(20, 1, '2021-02-15 08:26:24', b'1', '172.18.1.208'),
(21, 1, '2021-02-15 10:26:52', b'1', '172.18.1.208'),
(22, 1, '2021-02-15 10:28:31', b'1', '172.18.1.208'),
(23, 1, '2021-02-15 12:01:01', b'1', '172.18.1.208'),
(24, 1, '2021-02-15 17:13:04', b'1', '172.18.1.198'),
(25, 1, '2021-02-15 17:16:50', b'1', '172.18.1.198'),
(26, 1, '2021-02-15 17:25:22', b'1', '172.18.1.198'),
(27, 1, '2021-02-15 17:49:38', b'1', '172.18.1.198'),
(28, 1, '2021-02-15 18:08:31', b'1', '172.18.1.198'),
(29, 1, '2021-02-15 20:50:57', b'1', '172.18.1.198'),
(30, 1, '2021-02-16 07:53:31', b'1', '172.18.1.208'),
(31, 1, '2021-02-16 07:58:47', b'1', '172.18.1.208'),
(32, 1, '2021-02-16 08:01:08', b'1', '172.18.1.208'),
(33, 1, '2021-02-16 08:38:07', b'1', '172.18.1.208'),
(34, 1, '2021-02-16 08:38:49', b'1', '172.18.1.208'),
(35, 1, '2021-02-16 08:50:33', b'1', '172.18.1.208'),
(36, 1, '2021-02-16 08:58:03', b'1', '172.18.1.208'),
(37, 22, '2021-02-16 09:20:03', b'1', '172.18.1.208'),
(38, 1, '2021-02-16 11:00:58', b'1', '172.18.1.208'),
(39, 1, '2021-02-16 13:40:26', b'1', '172.18.1.208'),
(40, 1, '2021-02-16 13:51:11', b'1', '172.18.1.208'),
(41, 1, '2021-02-16 14:15:34', b'1', '172.18.1.208'),
(42, 1, '2021-02-16 15:34:26', b'1', '172.18.1.198'),
(43, 1, '2021-02-16 17:07:47', b'1', '172.18.1.198'),
(44, 1, '2021-02-16 17:15:03', b'1', '172.18.1.198'),
(45, 1, '2021-02-17 07:55:25', b'1', '172.18.1.208'),
(46, 1, '2021-02-17 11:34:56', b'1', '172.18.1.208'),
(47, 1, '2021-02-17 17:50:07', b'1', '172.18.1.198'),
(48, 1, '2021-02-19 08:12:39', b'1', '172.18.1.208'),
(49, 18, '2021-02-19 08:13:20', b'1', '172.18.1.208'),
(50, 18, '2021-02-19 08:14:46', b'1', '172.18.1.208'),
(51, 18, '2021-02-19 08:15:46', b'1', '172.18.1.208'),
(52, 18, '2021-02-19 08:20:54', b'1', '172.18.1.208'),
(53, 18, '2021-02-19 08:24:24', b'1', '172.18.1.208'),
(54, 1, '2021-02-19 08:28:17', b'1', '172.18.1.208'),
(55, 1, '2021-02-19 09:25:12', b'1', '172.18.1.208'),
(56, 1, '2021-02-19 09:26:23', b'1', '172.18.1.208'),
(57, 18, '2021-02-19 10:07:13', b'1', '172.18.1.208'),
(58, 1, '2021-02-19 10:07:21', b'1', '172.18.1.208'),
(59, 18, '2021-02-19 10:07:41', b'1', '172.18.1.208'),
(60, 18, '2021-02-19 10:47:17', b'1', '172.18.1.208'),
(61, 1, '2021-02-19 11:15:07', b'1', '172.18.1.208'),
(62, 1, '2021-02-19 16:17:45', b'1', '172.18.1.198'),
(63, 1, '2021-02-20 10:54:34', b'1', '172.18.1.198'),
(64, 18, '2021-02-20 10:55:37', b'1', '172.18.1.198'),
(65, 18, '2021-02-20 17:15:32', b'1', '172.18.1.198'),
(66, 18, '2021-02-22 08:23:54', b'0', '172.18.1.208'),
(67, 18, '2021-02-22 08:23:59', b'0', '172.18.1.208'),
(68, 18, '2021-02-22 08:24:02', b'1', '172.18.1.208'),
(69, 1, '2021-02-22 10:18:15', b'1', '172.18.1.208'),
(70, 1, '2021-02-22 10:25:48', b'1', '172.18.1.208'),
(71, 1, '2021-02-22 11:04:08', b'1', '172.18.1.208'),
(72, 1, '2021-02-22 11:05:19', b'1', '172.18.1.208'),
(73, 1, '2021-02-22 11:22:15', b'1', '172.18.1.208'),
(74, 18, '2021-02-22 11:53:00', b'0', '172.18.1.208'),
(75, 18, '2021-02-22 11:53:04', b'0', '172.18.1.208'),
(76, 18, '2021-02-22 11:53:07', b'1', '172.18.1.208'),
(77, 1, '2021-02-22 11:59:59', b'1', '172.18.1.208'),
(78, 1, '2021-02-22 12:05:05', b'1', '172.18.1.208'),
(79, 1, '2021-02-23 08:54:13', b'1', '172.18.1.208'),
(80, 18, '2021-02-23 10:02:24', b'0', '172.18.1.208'),
(81, 18, '2021-02-23 10:02:26', b'0', '172.18.1.208'),
(82, 18, '2021-02-23 10:02:28', b'1', '172.18.1.208'),
(83, 1, '2021-02-23 10:31:44', b'1', '172.18.1.208'),
(84, 1, '2021-02-23 10:59:29', b'1', '172.18.1.208'),
(85, 1, '2021-02-23 11:15:05', b'1', '[::1]'),
(86, 1, '2021-03-11 10:15:49', b'1', '[::1]'),
(87, 1, '2021-03-11 10:18:56', b'1', '[::1]'),
(88, 1, '2021-03-11 10:25:26', b'1', '[::1]'),
(89, 1, '2021-03-11 10:42:24', b'1', '[::1]'),
(90, 1, '2021-03-11 11:08:17', b'0', '[::1]'),
(91, 1, '2021-03-11 11:08:20', b'1', '[::1]'),
(92, 1, '2021-03-11 13:58:23', b'1', '[::1]'),
(93, 1, '2021-03-12 07:05:49', b'1', '[::1]'),
(94, 1, '2021-03-12 07:08:05', b'0', '[::1]'),
(95, 1, '2021-03-12 07:08:41', b'0', '[::1]'),
(96, 1, '2021-03-12 07:08:49', b'0', '[::1]'),
(97, 1, '2021-03-12 07:08:55', b'0', '[::1]'),
(98, 1, '2021-03-12 07:13:21', b'0', '[::1]'),
(99, 1, '2021-03-12 07:14:02', b'1', '[::1]'),
(100, 1, '2021-03-12 08:16:55', b'1', '[::1]'),
(101, 1, '2021-03-12 08:29:29', b'1', '[::1]'),
(102, 1, '2021-03-12 09:35:17', b'1', '[::1]'),
(103, 1, '2021-03-12 17:24:36', b'1', '[::1]'),
(104, 1, '2021-03-13 08:21:26', b'1', '[::1]'),
(105, 1, '2021-03-13 08:25:01', b'1', '[::1]'),
(106, 1, '2021-03-13 08:30:48', b'1', '[::1]'),
(107, 1, '2021-03-13 08:35:06', b'1', '[::1]'),
(108, 1, '2021-03-13 09:18:56', b'1', '[::1]'),
(109, 1, '2021-03-13 09:40:11', b'1', '[::1]'),
(110, 1, '2021-03-13 10:32:50', b'1', '[::1]'),
(111, 1, '2021-03-13 11:10:43', b'1', '[::1]'),
(112, 1, '2021-03-13 15:46:20', b'1', '[::1]'),
(113, 1, '2021-03-13 18:29:51', b'1', '[::1]'),
(114, 1, '2021-03-13 18:31:57', b'1', '[::1]'),
(115, 1, '2021-03-13 19:15:10', b'1', '[::1]'),
(116, 1, '2021-03-13 19:43:05', b'1', '[::1]'),
(117, 1, '2021-03-15 08:27:17', b'1', '[::1]'),
(118, 1, '2021-03-15 09:12:35', b'0', '[::1]'),
(119, 1, '2021-03-15 09:12:40', b'1', '[::1]'),
(120, 1, '2021-03-15 10:35:40', b'1', '[::1]'),
(121, 1, '2021-03-15 11:12:25', b'1', '[::1]'),
(122, 1, '2021-03-15 13:08:15', b'1', '[::1]'),
(123, 1, '2021-03-15 13:46:18', b'1', '[::1]'),
(124, 1, '2021-03-15 13:47:11', b'1', '[::1]'),
(125, 1, '2021-03-15 14:00:22', b'1', '[::1]'),
(126, 1, '2021-03-15 14:47:32', b'1', '[::1]'),
(127, 1, '2021-03-15 14:55:04', b'1', '[::1]'),
(128, 1, '2021-03-15 16:08:36', b'1', '[::1]'),
(129, 1, '2021-03-15 18:20:28', b'1', '[::1]'),
(130, 1, '2021-03-15 21:02:02', b'1', '[::1]'),
(131, 1, '2021-03-16 09:32:28', b'1', '[::1]'),
(132, 1, '2021-03-16 10:34:02', b'1', '[::1]'),
(133, 1, '2021-03-16 16:19:45', b'1', '[::1]'),
(134, 1, '2021-03-17 08:07:51', b'1', '[::1]'),
(135, 1, '2021-03-17 09:48:19', b'1', '[::1]'),
(136, 1, '2021-03-17 13:22:00', b'1', '[::1]'),
(137, 1, '2021-03-17 13:47:22', b'1', '[::1]'),
(138, 1, '2021-03-17 16:43:17', b'1', '[::1]'),
(139, 1, '2021-03-17 21:59:46', b'1', '[::1]'),
(140, 1, '2021-03-18 08:27:57', b'1', '[::1]'),
(141, 18, '2021-03-18 09:34:58', b'0', '[::1]'),
(142, 18, '2021-03-18 09:35:01', b'0', '[::1]'),
(143, 18, '2021-03-18 09:35:03', b'0', '[::1]'),
(144, 18, '2021-03-18 09:40:34', b'1', '[::1]'),
(145, 1, '2021-03-18 09:49:00', b'1', '[::1]'),
(146, 18, '2021-03-18 09:49:14', b'1', '[::1]'),
(147, 1, '2021-03-18 09:59:40', b'1', '[::1]'),
(148, 18, '2021-03-18 10:13:34', b'1', '[::1]'),
(149, 1, '2021-03-18 10:35:31', b'1', '[::1]'),
(150, 18, '2021-03-18 10:35:44', b'1', '[::1]'),
(151, 1, '2021-03-18 10:52:43', b'1', '[::1]'),
(152, 18, '2021-03-18 11:14:46', b'1', '[::1]'),
(153, 1, '2021-03-18 11:21:54', b'1', '[::1]'),
(154, 18, '2021-03-18 11:42:21', b'1', '[::1]'),
(155, 1, '2021-03-18 11:44:30', b'1', '[::1]'),
(156, 18, '2021-03-18 11:50:05', b'1', '[::1]'),
(157, 18, '2021-03-18 11:54:05', b'1', '[::1]'),
(158, 1, '2021-03-18 12:01:14', b'1', '[::1]'),
(159, 18, '2021-03-18 12:01:37', b'1', '[::1]'),
(160, 1, '2021-03-18 14:09:11', b'1', '[::1]'),
(161, 18, '2021-03-18 14:31:38', b'1', '[::1]'),
(162, 1, '2021-03-18 14:31:51', b'1', '[::1]'),
(163, 18, '2021-03-18 14:34:00', b'1', '[::1]'),
(164, 1, '2021-03-18 14:37:48', b'1', '[::1]'),
(165, 1, '2021-03-18 14:38:21', b'1', '[::1]'),
(166, 1, '2021-03-18 14:41:06', b'1', '[::1]'),
(167, 1, '2021-03-18 16:45:52', b'1', '[::1]'),
(168, 1, '2021-03-19 05:56:45', b'1', '[::1]'),
(169, 1, '2021-03-19 07:06:10', b'1', '[::1]'),
(170, 1, '2021-03-19 07:57:14', b'1', '[::1]'),
(171, 18, '2021-03-19 08:25:24', b'1', '[::1]'),
(172, 1, '2021-03-19 08:39:04', b'1', '[::1]'),
(173, 1, '2021-03-19 10:23:53', b'1', '[::1]'),
(174, 18, '2021-03-19 11:02:02', b'1', '[::1]'),
(175, 1, '2021-03-19 11:24:27', b'1', '[::1]'),
(176, 18, '2021-03-19 11:24:55', b'1', '[::1]'),
(177, 1, '2021-03-19 14:03:33', b'1', '[::1]'),
(178, 1, '2021-03-19 16:28:40', b'1', '[::1]'),
(179, 18, '2021-03-19 16:54:30', b'1', '[::1]'),
(180, 1, '2021-03-20 08:46:23', b'1', '[::1]'),
(181, 1, '2021-03-20 09:11:46', b'1', '[::1]'),
(182, 1, '2021-03-20 12:04:11', b'1', '[::1]'),
(183, 1, '2021-03-20 17:00:09', b'1', '[::1]'),
(184, 1, '2021-03-26 17:53:21', b'1', '[::1]'),
(185, 1, '2021-03-26 19:51:49', b'1', '[::1]'),
(186, 1, '2021-03-27 17:07:36', b'1', '[::1]'),
(187, 1, '2021-04-04 09:13:50', b'1', '[::1]'),
(188, 1, '2021-04-10 09:23:03', b'0', '[::1]'),
(189, 1, '2021-04-10 09:23:06', b'1', '[::1]'),
(190, 1, '2021-04-23 17:36:41', b'1', '[::1]'),
(191, 1, '2021-04-30 17:00:23', b'1', '[::1]'),
(192, 1, '2021-05-01 13:57:49', b'0', '[::1]'),
(193, 1, '2021-05-01 13:57:53', b'1', '[::1]'),
(194, 1, '2021-05-29 19:08:21', b'1', '[::1]'),
(195, 1, '2021-05-29 19:09:23', b'1', '[::1]');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_document_access`
-- (See below for the actual view)
--
CREATE TABLE `vw_document_access` (
`id` bigint(20)
,`file_name` varchar(128)
,`generated_file_name` varchar(128)
,`file_size` bigint(20) unsigned
,`original_file_name` varchar(255)
,`version` smallint(6) unsigned
,`extension` varchar(10)
,`mime_type` varchar(45)
,`owner` int(11)
,`folder` bigint(20) unsigned
,`abs_file_path` varchar(2000)
,`is_archived` int(11)
,`comment` varchar(200)
,`date_uploaded` datetime
,`uploaded_by` int(11)
,`state` smallint(6)
,`row_version` int(11) unsigned
,`privilege_id` smallint(6)
,`privilege_level` smallint(6)
,`folder_id` bigint(20) unsigned
,`folder_name` varchar(128)
,`description` varchar(45)
,`email_address` varchar(80)
,`first_name` varchar(35)
,`last_name` varchar(35)
,`group_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_document_history`
-- (See below for the actual view)
--
CREATE TABLE `vw_document_history` (
`id` bigint(20)
,`file_name` varchar(128)
,`version` smallint(6) unsigned
,`file_size` bigint(20) unsigned
,`extension` varchar(10)
,`mime_type` varchar(45)
,`date_uploaded` datetime
,`uploaded_by` int(11)
,`first_name` varchar(35)
,`last_name` varchar(35)
,`description` varchar(45)
,`folder_name` varchar(128)
,`folder_id` bigint(20) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_document_owner`
-- (See below for the actual view)
--
CREATE TABLE `vw_document_owner` (
`uploaded_by` int(11)
,`owner` int(11)
,`document_id` bigint(20)
,`first_name` varchar(35)
,`last_name` varchar(35)
,`email_address` varchar(80)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_folder`
-- (See below for the actual view)
--
CREATE TABLE `vw_folder` (
`id` bigint(20) unsigned
,`name` varchar(128)
,`comment` varchar(255)
,`created_date` datetime
,`created_by` varchar(71)
,`folder_owner` varchar(71)
,`folder_status` varchar(45)
,`updated_date` datetime
,`folder_state_id` smallint(6)
,`creator_email_address` varchar(80)
,`owner_email_address` varchar(80)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_folder_stat`
-- (See below for the actual view)
--
CREATE TABLE `vw_folder_stat` (
`name` varchar(128)
,`file_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_group_document_privilege`
-- (See below for the actual view)
--
CREATE TABLE `vw_group_document_privilege` (
`group_id` int(11)
,`privilege` smallint(6)
,`document_id` bigint(20)
,`group_name` varchar(45)
,`created_date` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_group_folder_privilege`
-- (See below for the actual view)
--
CREATE TABLE `vw_group_folder_privilege` (
`group_id` int(11)
,`privilege` smallint(6)
,`folder_id` bigint(20) unsigned
,`group_name` varchar(45)
,`created_date` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_notification`
-- (See below for the actual view)
--
CREATE TABLE `vw_notification` (
`user_id` int(11)
,`document_id` bigint(20)
,`uploaded_by` int(11)
,`owner` int(11)
,`first_name` varchar(35)
,`last_name` varchar(35)
,`email_address` varchar(80)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_session`
-- (See below for the actual view)
--
CREATE TABLE `vw_session` (
`id` varchar(255)
,`ip_address` varchar(255)
,`user_agent` varchar(255)
,`date_created` datetime
,`last_seen` datetime
,`time_diff` decimal(18,0)
,`user_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_user_document_privilege`
-- (See below for the actual view)
--
CREATE TABLE `vw_user_document_privilege` (
`document_id` bigint(20)
,`user_id` int(11)
,`created_date` datetime
,`privilege` smallint(6)
,`first_name` varchar(35)
,`last_name` varchar(35)
,`email_address` varchar(80)
,`owner` int(11)
,`uploaded_by` int(11)
,`id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_user_folder_privilege`
-- (See below for the actual view)
--
CREATE TABLE `vw_user_folder_privilege` (
`folder_id` bigint(20) unsigned
,`user_id` int(11)
,`created_date` datetime
,`privilege` smallint(6)
,`first_name` varchar(35)
,`last_name` varchar(35)
,`email_address` varchar(80)
,`owner` int(11)
,`created_by` int(11)
,`id` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_document_access`
--
DROP TABLE IF EXISTS `vw_document_access`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_document_access`  AS  select `document`.`id` AS `id`,`document`.`file_name` AS `file_name`,`document`.`generated_file_name` AS `generated_file_name`,`document`.`file_size` AS `file_size`,`document`.`original_file_name` AS `original_file_name`,`document`.`version` AS `version`,`document`.`extension` AS `extension`,`document`.`mime_type` AS `mime_type`,`document`.`owner` AS `owner`,`document`.`folder` AS `folder`,`document`.`abs_file_path` AS `abs_file_path`,`document`.`is_archived` AS `is_archived`,`document`.`comment` AS `comment`,`document`.`date_uploaded` AS `date_uploaded`,`document`.`uploaded_by` AS `uploaded_by`,`document`.`state` AS `state`,`document`.`row_version` AS `row_version`,`document_access_level`.`privilege` AS `privilege_id`,`p`.`level` AS `privilege_level`,`document`.`folder` AS `folder_id`,`folder`.`name` AS `folder_name`,`document_state`.`description` AS `description`,`user`.`email_address` AS `email_address`,`user`.`first_name` AS `first_name`,`user`.`last_name` AS `last_name`,`group`.`id` AS `group_id` from ((((((`document` join `document_access_level` on((`document`.`id` = `document_access_level`.`document_id`))) join `group` on((`group`.`id` = `document_access_level`.`group_id`))) join `privilege` `p` on((`document_access_level`.`privilege` = `p`.`level`))) join `folder` on((`document`.`folder` = `folder`.`id`))) join `document_state` on((`document_state`.`id` = `document`.`state`))) join `user` on((`user`.`id` = `document`.`uploaded_by`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_document_history`
--
DROP TABLE IF EXISTS `vw_document_history`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_document_history`  AS  select `document`.`id` AS `id`,`document`.`file_name` AS `file_name`,`document`.`version` AS `version`,`document`.`file_size` AS `file_size`,`document`.`extension` AS `extension`,`document`.`mime_type` AS `mime_type`,`document`.`date_uploaded` AS `date_uploaded`,`document`.`uploaded_by` AS `uploaded_by`,`user`.`first_name` AS `first_name`,`user`.`last_name` AS `last_name`,`document_state`.`description` AS `description`,`folder`.`name` AS `folder_name`,`folder`.`id` AS `folder_id` from (((`document` join `folder` on((`document`.`folder` = `folder`.`id`))) join `user` on((`document`.`uploaded_by` = `user`.`id`))) join `document_state` on((`document`.`state` = `document_state`.`id`))) where (`document`.`state` < 0) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_document_owner`
--
DROP TABLE IF EXISTS `vw_document_owner`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_document_owner`  AS  select `d`.`uploaded_by` AS `uploaded_by`,`d`.`owner` AS `owner`,`d`.`id` AS `document_id`,`a`.`first_name` AS `first_name`,`a`.`last_name` AS `last_name`,`a`.`email_address` AS `email_address` from ((`document` `d` left join `user` `a` on((`d`.`uploaded_by` = `a`.`id`))) left join `user` `b` on((`d`.`owner` = `b`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_folder`
--
DROP TABLE IF EXISTS `vw_folder`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_folder`  AS  select `f`.`id` AS `id`,`f`.`name` AS `name`,`f`.`comment` AS `comment`,`f`.`created_date` AS `created_date`,concat(`u`.`first_name`,' ',`u`.`last_name`) AS `created_by`,concat(`v`.`first_name`,' ',`v`.`last_name`) AS `folder_owner`,`s`.`description` AS `folder_status`,`f`.`updated_date` AS `updated_date`,`f`.`state` AS `folder_state_id`,`u`.`email_address` AS `creator_email_address`,`v`.`email_address` AS `owner_email_address` from (((`folder` `f` left join `user` `u` on((`f`.`created_by` = `u`.`id`))) left join `user` `v` on((`f`.`owner` = `v`.`id`))) left join `folder_state` `s` on((`f`.`state` = `s`.`row_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_folder_stat`
--
DROP TABLE IF EXISTS `vw_folder_stat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_folder_stat`  AS  select `a`.`name` AS `name`,(select count(0) AS `file_count` from `document` `b` where (`b`.`folder` = `a`.`id`)) AS `file_count` from `folder` `a` where (`a`.`state` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_group_document_privilege`
--
DROP TABLE IF EXISTS `vw_group_document_privilege`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_group_document_privilege`  AS  select distinct `document_access_level`.`group_id` AS `group_id`,`document_access_level`.`privilege` AS `privilege`,`document_access_level`.`document_id` AS `document_id`,`group`.`name` AS `group_name`,`document_access_level`.`created_date` AS `created_date` from (`document_access_level` join `group` on((`document_access_level`.`group_id` = `group`.`id`))) where (`document_access_level`.`group_id` is not null) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_group_folder_privilege`
--
DROP TABLE IF EXISTS `vw_group_folder_privilege`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_group_folder_privilege`  AS  select distinct `folder_access_level`.`group_id` AS `group_id`,`folder_access_level`.`privilege` AS `privilege`,`folder_access_level`.`folder_id` AS `folder_id`,`group`.`name` AS `group_name`,`folder_access_level`.`created_date` AS `created_date` from (`folder_access_level` left join `group` on((`folder_access_level`.`group_id` = `group`.`id`))) where (`folder_access_level`.`group_id` is not null) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_notification`
--
DROP TABLE IF EXISTS `vw_notification`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_notification`  AS  select distinct `document_access_level`.`user_id` AS `user_id`,`document_access_level`.`document_id` AS `document_id`,`document`.`uploaded_by` AS `uploaded_by`,`document`.`owner` AS `owner`,`user`.`first_name` AS `first_name`,`user`.`last_name` AS `last_name`,`user`.`email_address` AS `email_address` from ((`document_access_level` left join `document` on((`document_access_level`.`document_id` = `document`.`id`))) left join `user` on((`document_access_level`.`user_id` = `user`.`id`))) where ((`document_access_level`.`user_id` <> `document`.`uploaded_by`) and (`user`.`id` is not null)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_session`
--
DROP TABLE IF EXISTS `vw_session`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_session`  AS  select `session`.`id` AS `id`,`session`.`ip_address` AS `ip_address`,`session`.`user_agent` AS `user_agent`,`session`.`date_created` AS `date_created`,from_unixtime(`session`.`last_seen`) AS `last_seen`,round(((unix_timestamp(now()) - `session`.`last_seen`) / 60),0) AS `time_diff`,`session`.`user_id` AS `user_id` from `session` ;

-- --------------------------------------------------------

--
-- Structure for view `vw_user_document_privilege`
--
DROP TABLE IF EXISTS `vw_user_document_privilege`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_user_document_privilege`  AS  select `document_access_level`.`document_id` AS `document_id`,`document_access_level`.`user_id` AS `user_id`,`document_access_level`.`created_date` AS `created_date`,`document_access_level`.`privilege` AS `privilege`,`user`.`first_name` AS `first_name`,`user`.`last_name` AS `last_name`,`user`.`email_address` AS `email_address`,`document`.`owner` AS `owner`,`document`.`uploaded_by` AS `uploaded_by`,`user`.`id` AS `id` from ((`document_access_level` join `user` on((`document_access_level`.`user_id` = `user`.`id`))) join `document` on((`document_access_level`.`document_id` = `document`.`id`))) where isnull(`document_access_level`.`group_id`) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_user_folder_privilege`
--
DROP TABLE IF EXISTS `vw_user_folder_privilege`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_user_folder_privilege`  AS  select `folder_access_level`.`folder_id` AS `folder_id`,`folder_access_level`.`user_id` AS `user_id`,`folder_access_level`.`created_date` AS `created_date`,`folder_access_level`.`privilege` AS `privilege`,`user`.`first_name` AS `first_name`,`user`.`last_name` AS `last_name`,`user`.`email_address` AS `email_address`,`folder`.`owner` AS `owner`,`folder`.`created_by` AS `created_by`,`user`.`id` AS `id` from ((`folder_access_level` join `user` on((`folder_access_level`.`user_id` = `user`.`id`))) join `folder` on((`folder_access_level`.`folder_id` = `folder`.`id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`parameter_name`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `generated_file_name` (`generated_file_name`),
  ADD UNIQUE KEY `idx_file_in_folder` (`file_name`,`version`,`folder`) USING BTREE,
  ADD KEY `fk_state` (`state`),
  ADD KEY `fk_folder` (`folder`),
  ADD KEY `fk_owner` (`owner`),
  ADD KEY `fk_uploaded_by` (`uploaded_by`);

--
-- Indexes for table `document_access_level`
--
ALTER TABLE `document_access_level`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `document_id_user_id_group_id` (`document_id`,`user_id`,`group_id`),
  ADD KEY `fk_user_fk` (`user_id`),
  ADD KEY `fk_group_fk` (`group_id`),
  ADD KEY `fk_priv_fk` (`privilege`);

--
-- Indexes for table `document_keyword`
--
ALTER TABLE `document_keyword`
  ADD PRIMARY KEY (`document_id`,`keyword`),
  ADD KEY `fk_doc_keyword` (`document_id`);

--
-- Indexes for table `document_state`
--
ALTER TABLE `document_state`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `row_id_UNIQUE` (`id`),
  ADD UNIQUE KEY `idx_desc` (`description`);

--
-- Indexes for table `document_status_change`
--
ALTER TABLE `document_status_change`
  ADD PRIMARY KEY (`row_id`),
  ADD KEY `fk_document_id_status` (`document_id`),
  ADD KEY `fk_user_status_change` (`changed_by`);

--
-- Indexes for table `document_transfer`
--
ALTER TABLE `document_transfer`
  ADD PRIMARY KEY (`row_id`),
  ADD KEY `fk_document` (`document`),
  ADD KEY `fk_source_folder` (`source_folder`),
  ADD KEY `fk_dest_folder` (`dest_folder`),
  ADD KEY `fk_user_transfer` (`transfer_user`);

--
-- Indexes for table `email_template`
--
ALTER TABLE `email_template`
  ADD PRIMARY KEY (`parameter_name`) USING BTREE;

--
-- Indexes for table `exception_log`
--
ALTER TABLE `exception_log`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `folder`
--
ALTER TABLE `folder`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_name` (`name`) USING BTREE,
  ADD KEY `fk_folder_state` (`state`),
  ADD KEY `fk_created_by___` (`created_by`),
  ADD KEY `fk_owner____` (`owner`),
  ADD KEY `fk_updated_by_____` (`updated_by`);

--
-- Indexes for table `folder_access_level`
--
ALTER TABLE `folder_access_level`
  ADD PRIMARY KEY (`row_id`) USING BTREE,
  ADD UNIQUE KEY `folder_id_user_id_group_id` (`folder_id`,`user_id`,`group_id`),
  ADD KEY `fk_user_al` (`user_id`),
  ADD KEY `fk_group_al` (`group_id`),
  ADD KEY `fk_privi_al` (`privilege`);

--
-- Indexes for table `folder_hierarchy`
--
ALTER TABLE `folder_hierarchy`
  ADD PRIMARY KEY (`folder_id`),
  ADD UNIQUE KEY `idx_id` (`id`),
  ADD KEY `fk_parent_folder_id` (`parent`);

--
-- Indexes for table `folder_state`
--
ALTER TABLE `folder_state`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `idx_desc` (`description`);

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `group_id_UNIQUE` (`id`),
  ADD KEY `fk_created_by_idx` (`created_by`),
  ADD KEY `fk_updated_by_idx` (`updated_by`);

--
-- Indexes for table `group_member`
--
ALTER TABLE `group_member`
  ADD PRIMARY KEY (`user_id`,`group_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `fk_assigned_by` (`assigned_by`);

--
-- Indexes for table `group_membership_log`
--
ALTER TABLE `group_membership_log`
  ADD PRIMARY KEY (`row_id`),
  ADD KEY `fk_log_group_id` (`group_id`),
  ADD KEY `fk_log_user_id` (`user_id`),
  ADD KEY `fk_log_changed_by` (`changed_by`);

--
-- Indexes for table `otp`
--
ALTER TABLE `otp`
  ADD PRIMARY KEY (`user_id`,`code`);

--
-- Indexes for table `outgoing_email`
--
ALTER TABLE `outgoing_email`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `password_history`
--
ALTER TABLE `password_history`
  ADD PRIMARY KEY (`row_id`),
  ADD KEY `fk_user_idx` (`user_id`);

--
-- Indexes for table `password_reset`
--
ALTER TABLE `password_reset`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `idx_token` (`generated_token`),
  ADD KEY `fk_password_reset` (`user_id`);

--
-- Indexes for table `platform`
--
ALTER TABLE `platform`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `privilege`
--
ALTER TABLE `privilege`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `level_UNIQUE` (`level`),
  ADD UNIQUE KEY `desc_UNIQUE` (`description`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `description` (`description`) USING BTREE;

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`role_id`,`base_path`,`route_path`),
  ADD KEY `row_id` (`row_id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_session_user` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `EmailAddress_UNIQUE` (`email_address`) USING BTREE,
  ADD KEY `fk_user_role_idx` (`role`);

--
-- Indexes for table `user_activity`
--
ALTER TABLE `user_activity`
  ADD PRIMARY KEY (`row_id`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `document_status_change`
--
ALTER TABLE `document_status_change`
  MODIFY `row_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `document_transfer`
--
ALTER TABLE `document_transfer`
  MODIFY `row_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exception_log`
--
ALTER TABLE `exception_log`
  MODIFY `row_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `folder`
--
ALTER TABLE `folder`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `folder_hierarchy`
--
ALTER TABLE `folder_hierarchy`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group`
--
ALTER TABLE `group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `group_membership_log`
--
ALTER TABLE `group_membership_log`
  MODIFY `row_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `outgoing_email`
--
ALTER TABLE `outgoing_email`
  MODIFY `row_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `password_history`
--
ALTER TABLE `password_history`
  MODIFY `row_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `password_reset`
--
ALTER TABLE `password_reset`
  MODIFY `row_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `platform`
--
ALTER TABLE `platform`
  MODIFY `row_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `privilege`
--
ALTER TABLE `privilege`
  MODIFY `row_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `row_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=636;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `user_activity`
--
ALTER TABLE `user_activity`
  MODIFY `row_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=196;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `fk_folder` FOREIGN KEY (`folder`) REFERENCES `folder` (`id`),
  ADD CONSTRAINT `fk_owner` FOREIGN KEY (`owner`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_state` FOREIGN KEY (`state`) REFERENCES `document_state` (`id`),
  ADD CONSTRAINT `fk_uploaded_by` FOREIGN KEY (`uploaded_by`) REFERENCES `user` (`id`);

--
-- Constraints for table `document_access_level`
--
ALTER TABLE `document_access_level`
  ADD CONSTRAINT `fk_doc_fk` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`),
  ADD CONSTRAINT `fk_group_fk` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  ADD CONSTRAINT `fk_priv_fk` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`level`),
  ADD CONSTRAINT `fk_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `document_keyword`
--
ALTER TABLE `document_keyword`
  ADD CONSTRAINT `fk_doc_keyword` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`);

--
-- Constraints for table `document_status_change`
--
ALTER TABLE `document_status_change`
  ADD CONSTRAINT `fk_document_id_status` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`),
  ADD CONSTRAINT `fk_user_status_change` FOREIGN KEY (`changed_by`) REFERENCES `user` (`id`);

--
-- Constraints for table `document_transfer`
--
ALTER TABLE `document_transfer`
  ADD CONSTRAINT `fk_dest_folder` FOREIGN KEY (`dest_folder`) REFERENCES `folder` (`id`),
  ADD CONSTRAINT `fk_document` FOREIGN KEY (`document`) REFERENCES `document` (`id`),
  ADD CONSTRAINT `fk_source_folder` FOREIGN KEY (`source_folder`) REFERENCES `folder` (`id`),
  ADD CONSTRAINT `fk_user_transfer` FOREIGN KEY (`transfer_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `folder`
--
ALTER TABLE `folder`
  ADD CONSTRAINT `fk_created_by___` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_folder_state` FOREIGN KEY (`state`) REFERENCES `folder_state` (`row_id`),
  ADD CONSTRAINT `fk_owner____` FOREIGN KEY (`owner`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_updated_by_____` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`);

--
-- Constraints for table `folder_access_level`
--
ALTER TABLE `folder_access_level`
  ADD CONSTRAINT `fk_folder_al` FOREIGN KEY (`folder_id`) REFERENCES `folder` (`id`),
  ADD CONSTRAINT `fk_group_al` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  ADD CONSTRAINT `fk_privi_al` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`level`),
  ADD CONSTRAINT `fk_user_al` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `folder_hierarchy`
--
ALTER TABLE `folder_hierarchy`
  ADD CONSTRAINT `fk_folder_id` FOREIGN KEY (`folder_id`) REFERENCES `folder` (`id`),
  ADD CONSTRAINT `fk_parent_folder_id` FOREIGN KEY (`parent`) REFERENCES `folder` (`id`);

--
-- Constraints for table `group`
--
ALTER TABLE `group`
  ADD CONSTRAINT `fk_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`);

--
-- Constraints for table `group_member`
--
ALTER TABLE `group_member`
  ADD CONSTRAINT `fk_assigned_by` FOREIGN KEY (`assigned_by`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `group_member_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `group_member_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`);

--
-- Constraints for table `group_membership_log`
--
ALTER TABLE `group_membership_log`
  ADD CONSTRAINT `fk_log_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_log_group_id` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  ADD CONSTRAINT `fk_log_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `otp`
--
ALTER TABLE `otp`
  ADD CONSTRAINT `fk_user_otp` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `password_history`
--
ALTER TABLE `password_history`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `password_reset`
--
ALTER TABLE `password_reset`
  ADD CONSTRAINT `fk_password_reset` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `fk_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

--
-- Constraints for table `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `fk_session_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`role`) REFERENCES `role` (`id`);

--
-- Constraints for table `user_activity`
--
ALTER TABLE `user_activity`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
