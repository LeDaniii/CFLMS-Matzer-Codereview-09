-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 08, 2020 at 11:37 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cr09_daniel_matzer_delivery`
--
CREATE DATABASE IF NOT EXISTS `cr09_daniel_matzer_delivery` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cr09_daniel_matzer_delivery`;

-- --------------------------------------------------------

--
-- Table structure for table `companies_adresses`
--

CREATE TABLE `companies_adresses` (
  `adress_company_id` int(11) NOT NULL,
  `company` varchar(35) NOT NULL,
  `street` varchar(40) NOT NULL,
  `street_number` int(11) NOT NULL,
  `city` varchar(35) NOT NULL,
  `zip_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `companies_adresses`
--

INSERT INTO `companies_adresses` (`adress_company_id`, `company`, `street`, `street_number`, `city`, `zip_code`) VALUES
(1, 'Fed Ex Austria', 'Bahnhofstraße', 156, 'Kalsdorf', 8401),
(2, 'UPS Austria', 'Cargo Nord', 1, 'Schwechat', 1300),
(3, 'Hermes', 'Concorde Business ', 1, 'Schwechat', 2320),
(4, 'DHL Austria', 'Pestalozzistraße', 62, 'Graz', 8010),
(5, 'Austria Post Ag', 'Bahnhofsgürtel', 48, 'Graz', 8020);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `fk_processing_customer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `fk_processing_customer`) VALUES
(6, 2),
(5, 6),
(7, 6),
(8, 6),
(9, 7),
(2, 8),
(3, 9),
(10, 9),
(4, 10),
(1, 11);

-- --------------------------------------------------------

--
-- Table structure for table `distribution_center`
--

CREATE TABLE `distribution_center` (
  `distribution_center_id` int(11) NOT NULL,
  `accepted` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT NULL,
  `fk_adress_companies` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `distribution_center`
--

INSERT INTO `distribution_center` (`distribution_center_id`, `accepted`, `is_active`, `fk_adress_companies`) VALUES
(1, '2020-11-11 14:11:22', 1, 2),
(2, '2020-10-12 13:11:22', 1, 3),
(3, '2020-09-14 13:12:00', 0, 4),
(4, '2020-10-19 13:12:00', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `fk_staff_id` int(11) DEFAULT NULL,
  `fk_postshop_id` int(11) DEFAULT NULL,
  `employee_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`fk_staff_id`, `fk_postshop_id`, `employee_id`) VALUES
(1, 6, 1),
(2, 4, 2),
(4, 5, 3),
(3, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `mail_carries`
--

CREATE TABLE `mail_carries` (
  `mail_carries_id` int(11) NOT NULL,
  `accepted` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT NULL,
  `fk_adress_companies` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mail_carries`
--

INSERT INTO `mail_carries` (`mail_carries_id`, `accepted`, `is_active`, `fk_adress_companies`) VALUES
(1, '2020-10-12 13:27:15', 0, 5),
(2, '2020-11-08 14:27:15', 1, 2),
(3, '2020-11-05 14:27:47', 1, 4),
(4, '2020-10-15 13:28:09', 0, 5),
(5, '2020-09-23 13:28:29', 0, 5),
(6, '2020-10-21 13:28:42', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mail_category`
--

CREATE TABLE `mail_category` (
  `mail_category_id` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `receipt_nr` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `delivery` enum('standard','express') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mail_category`
--

INSERT INTO `mail_category` (`mail_category_id`, `weight`, `receipt_nr`, `price`, `delivery`) VALUES
(1, 15, 1564156, 10, 'standard'),
(2, 20, 16541564, 80, 'express'),
(3, 0, 159684685, 1, 'standard'),
(4, 0, 165416, 1, 'standard'),
(5, 65, 1564654, 45, 'standard');

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE `package` (
  `package_id` int(11) NOT NULL,
  `fk_cust_id` int(11) NOT NULL,
  `fk_rec_id` int(11) NOT NULL,
  `fk_mail_category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`package_id`, `fk_cust_id`, `fk_rec_id`, `fk_mail_category`) VALUES
(1, 3, 4, 3),
(2, 1, 2, 4),
(3, 8, 5, 2),
(4, 6, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `postshops`
--

CREATE TABLE `postshops` (
  `postshop_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `street` varchar(30) NOT NULL,
  `street_number` int(11) NOT NULL,
  `zip_code` int(11) NOT NULL,
  `city` varchar(30) DEFAULT NULL,
  `fk_services` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `postshops`
--

INSERT INTO `postshops` (`postshop_id`, `name`, `street`, `street_number`, `zip_code`, `city`, `fk_services`) VALUES
(1, 'Post Partner', 'Ungargasse', 64, 1030, 'Vienna', 1),
(3, 'Briefkasten', 'Jakob_Fuchs_Gasse', 6, 2345, 'Brunn am Gebierge', 5),
(4, 'Adeg Kurzmann', 'Marktplatz', 1, 8081, 'Heiligenkreuz', 3),
(5, 'Postfilioale', 'Ostbahnstraße', 3, 8041, 'Graz', 2),
(6, 'Postfiliale', 'Triester Str.', 364, 8055, 'Graz', 3),
(7, 'Postfiliale', 'Burenstraße', 85, 8052, 'Graz', 4);

-- --------------------------------------------------------

--
-- Table structure for table `processing`
--

CREATE TABLE `processing` (
  `start_time` datetime DEFAULT NULL,
  `end_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `process` enum('PICKUP_AT_STORE','PICKUP_AT_SENDER_LOCATION','HANDOUT_AT_STORE','DEPOSIT_AT_RECIPIENT_LOCATION','DELIVERY_START','DELIVERY_END') DEFAULT NULL,
  `fk_pack_id` int(11) DEFAULT NULL,
  `fk_empl_id` int(11) DEFAULT NULL,
  `fk_postshop_id` int(11) DEFAULT NULL,
  `fk_mail_carries` int(11) DEFAULT NULL,
  `fk_distribution_center` int(11) DEFAULT NULL,
  `processing_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `processing`
--

INSERT INTO `processing` (`start_time`, `end_time`, `process`, `fk_pack_id`, `fk_empl_id`, `fk_postshop_id`, `fk_mail_carries`, `fk_distribution_center`, `processing_id`) VALUES
(NULL, '2020-10-30 14:32:42', 'PICKUP_AT_STORE', 1, 1, 6, 3, NULL, 1),
(NULL, '2020-11-06 14:35:13', 'DELIVERY_START', 2, 2, 4, 2, NULL, 2),
(NULL, '2020-11-06 14:39:02', 'DELIVERY_START', 3, 2, 4, 3, NULL, 3),
('2020-11-09 15:41:23', '2020-11-07 14:42:24', 'DELIVERY_START', 4, 2, 4, NULL, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `processing_adresses`
--

CREATE TABLE `processing_adresses` (
  `processing_adress_id` int(11) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `zip_code` int(11) NOT NULL,
  `street_number` int(11) NOT NULL,
  `street` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `processing_adresses`
--

INSERT INTO `processing_adresses` (`processing_adress_id`, `first_name`, `last_name`, `zip_code`, `street_number`, `street`, `city`) VALUES
(1, 'Nene', 'Sakura', 8010, 165, 'KennIvieleicht', 'Graz'),
(2, 'Shizuku', 'Hazuki', 8010, 4896, 'KennIvieleicht', 'Graz'),
(3, 'Ko', 'Yagami', 8081, 86, 'Oberdorof', 'Priching'),
(4, 'Rin', 'Toyama', 8081, 86, 'Oberdorof', 'Priching'),
(5, 'Christina', 'Wako', 8010, 658, 'KeineAhnung', 'Graz'),
(6, 'Kaori', 'Miyazono', 8010, 196, 'Jakomini', 'Graz'),
(7, 'Ryoota', 'Watari', 8010, 451, 'Jakomini', 'Graz'),
(8, 'Tsubaka', 'Sawabe', 1010, 154, 'Innere Stadt', 'Vienna'),
(9, 'Saki', 'Arima', 1010, 685, 'Innere Stadt', 'Vienna'),
(10, 'Hiroko', 'Seto', 1050, 456, 'Magareten', 'Vienna'),
(11, 'Koosei', 'Arima', 1010, 685, 'Innere Stadt', 'Vienna');

-- --------------------------------------------------------

--
-- Table structure for table `recipient`
--

CREATE TABLE `recipient` (
  `recipient_id` int(11) NOT NULL,
  `fk_processing_recipient` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `recipient`
--

INSERT INTO `recipient` (`recipient_id`, `fk_processing_recipient`) VALUES
(1, 1),
(2, 2),
(4, 3),
(5, 4),
(3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `service_id` int(11) NOT NULL,
  `service_name` varchar(30) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`service_id`, `service_name`, `description`, `is_active`) VALUES
(1, 'Service1', 'Irgendetwas nützliches1', 0),
(2, 'Service2', 'Irgendetwas nützliches2', 0),
(3, 'Service3', 'Irgendetwas nützliches3', 0),
(4, 'Service3', 'Irgendetwas nützliches3', 0),
(5, 'Service4', 'Irgendetwas nützliches4', 0);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `zip_code` int(11) NOT NULL,
  `street_number` int(11) NOT NULL,
  `street` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `first_name`, `last_name`, `zip_code`, `street_number`, `street`, `city`) VALUES
(1, 'Aoba', 'Suzukaze', 8010, 78, 'Wasinet', 'Graz'),
(2, 'Hifumi', 'Takimoto', 8081, 54, 'Oberdorf', 'Pirching'),
(3, 'Yun', 'Iijima', 8010, 789, 'KeineAhnung', 'Graz'),
(4, 'Umiko', 'Ahagon', 8010, 396, 'Kenninet', 'Graz');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `companies_adresses`
--
ALTER TABLE `companies_adresses`
  ADD PRIMARY KEY (`adress_company_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `fk_processing_customer` (`fk_processing_customer`);

--
-- Indexes for table `distribution_center`
--
ALTER TABLE `distribution_center`
  ADD PRIMARY KEY (`distribution_center_id`),
  ADD KEY `fk_adress_companies` (`fk_adress_companies`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `fk_staff_id` (`fk_staff_id`),
  ADD KEY `fk_postshop_id` (`fk_postshop_id`);

--
-- Indexes for table `mail_carries`
--
ALTER TABLE `mail_carries`
  ADD PRIMARY KEY (`mail_carries_id`),
  ADD KEY `fk_adress_companies` (`fk_adress_companies`);

--
-- Indexes for table `mail_category`
--
ALTER TABLE `mail_category`
  ADD PRIMARY KEY (`mail_category_id`);

--
-- Indexes for table `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`package_id`),
  ADD KEY `fk_cust_id` (`fk_cust_id`),
  ADD KEY `fk_rec_id` (`fk_rec_id`),
  ADD KEY `fk_mail_category` (`fk_mail_category`);

--
-- Indexes for table `postshops`
--
ALTER TABLE `postshops`
  ADD PRIMARY KEY (`postshop_id`),
  ADD KEY `fk_services` (`fk_services`);

--
-- Indexes for table `processing`
--
ALTER TABLE `processing`
  ADD PRIMARY KEY (`processing_id`),
  ADD KEY `fk_pack_id` (`fk_pack_id`),
  ADD KEY `fk_empl_id` (`fk_empl_id`),
  ADD KEY `fk_postshop_id` (`fk_postshop_id`),
  ADD KEY `fk_mail_carries` (`fk_mail_carries`),
  ADD KEY `fk_distribution_center` (`fk_distribution_center`);

--
-- Indexes for table `processing_adresses`
--
ALTER TABLE `processing_adresses`
  ADD PRIMARY KEY (`processing_adress_id`);

--
-- Indexes for table `recipient`
--
ALTER TABLE `recipient`
  ADD PRIMARY KEY (`recipient_id`),
  ADD KEY `fk_processing_recipient` (`fk_processing_recipient`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `companies_adresses`
--
ALTER TABLE `companies_adresses`
  MODIFY `adress_company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `distribution_center`
--
ALTER TABLE `distribution_center`
  MODIFY `distribution_center_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mail_carries`
--
ALTER TABLE `mail_carries`
  MODIFY `mail_carries_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mail_category`
--
ALTER TABLE `mail_category`
  MODIFY `mail_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `package_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `postshops`
--
ALTER TABLE `postshops`
  MODIFY `postshop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `processing`
--
ALTER TABLE `processing`
  MODIFY `processing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `processing_adresses`
--
ALTER TABLE `processing_adresses`
  MODIFY `processing_adress_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `recipient`
--
ALTER TABLE `recipient`
  MODIFY `recipient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`fk_processing_customer`) REFERENCES `processing_adresses` (`processing_adress_id`);

--
-- Constraints for table `distribution_center`
--
ALTER TABLE `distribution_center`
  ADD CONSTRAINT `distribution_center_ibfk_1` FOREIGN KEY (`fk_adress_companies`) REFERENCES `companies_adresses` (`adress_company_id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`fk_staff_id`) REFERENCES `staff` (`staff_id`),
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`fk_postshop_id`) REFERENCES `postshops` (`postshop_id`);

--
-- Constraints for table `mail_carries`
--
ALTER TABLE `mail_carries`
  ADD CONSTRAINT `mail_carries_ibfk_1` FOREIGN KEY (`fk_adress_companies`) REFERENCES `companies_adresses` (`adress_company_id`);

--
-- Constraints for table `package`
--
ALTER TABLE `package`
  ADD CONSTRAINT `package_ibfk_1` FOREIGN KEY (`fk_cust_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `package_ibfk_2` FOREIGN KEY (`fk_rec_id`) REFERENCES `recipient` (`recipient_id`),
  ADD CONSTRAINT `package_ibfk_3` FOREIGN KEY (`fk_mail_category`) REFERENCES `mail_category` (`mail_category_id`);

--
-- Constraints for table `postshops`
--
ALTER TABLE `postshops`
  ADD CONSTRAINT `postshops_ibfk_1` FOREIGN KEY (`fk_services`) REFERENCES `service` (`service_id`);

--
-- Constraints for table `processing`
--
ALTER TABLE `processing`
  ADD CONSTRAINT `processing_ibfk_1` FOREIGN KEY (`fk_pack_id`) REFERENCES `package` (`package_id`),
  ADD CONSTRAINT `processing_ibfk_2` FOREIGN KEY (`fk_empl_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `processing_ibfk_3` FOREIGN KEY (`fk_postshop_id`) REFERENCES `postshops` (`postshop_id`),
  ADD CONSTRAINT `processing_ibfk_4` FOREIGN KEY (`fk_mail_carries`) REFERENCES `mail_carries` (`mail_carries_id`),
  ADD CONSTRAINT `processing_ibfk_5` FOREIGN KEY (`fk_distribution_center`) REFERENCES `distribution_center` (`distribution_center_id`);

--
-- Constraints for table `recipient`
--
ALTER TABLE `recipient`
  ADD CONSTRAINT `recipient_ibfk_1` FOREIGN KEY (`fk_processing_recipient`) REFERENCES `processing_adresses` (`processing_adress_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
