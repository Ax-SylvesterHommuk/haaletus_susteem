-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 09, 2023 at 01:15 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hommukax_haaletus`
--

-- --------------------------------------------------------

--
-- Table structure for table `haaletus`
--

CREATE TABLE `haaletus` (
  `id` int(11) NOT NULL,
  `eesnimi` varchar(50) NOT NULL,
  `perenimi` varchar(50) NOT NULL,
  `haaletusaeg` datetime NOT NULL DEFAULT current_timestamp(),
  `otsus` enum('poolt','vastu') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `haaletus`
--
DELIMITER $$
CREATE TRIGGER `insert_logi` AFTER INSERT ON `haaletus` FOR EACH ROW BEGIN
  INSERT INTO logi (haaletaja_id, muudetud_veerg, vana_vaartus, uus_vaartus, muutmise_aeg)
  VALUES (NEW.id, 'lisamine', '', '', NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_logi` AFTER UPDATE ON `haaletus` FOR EACH ROW BEGIN
  DECLARE haaletaja_id INT;
  SELECT id INTO haaletaja_id FROM haaletus WHERE id = NEW.id;
  INSERT INTO logi (haaletaja_id, muudetud_veerg, vana_vaartus, uus_vaartus, muutmise_aeg)
  VALUES (haaletaja_id, 'otsus', OLD.otsus, NEW.otsus, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `logi`
--

CREATE TABLE `logi` (
  `id` int(11) NOT NULL,
  `haaletaja_id` int(11) NOT NULL,
  `muudetud_veerg` varchar(50) NOT NULL,
  `vana_vaartus` varchar(255) NOT NULL,
  `uus_vaartus` varchar(255) NOT NULL,
  `muutmise_aeg` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tulemused`
--

CREATE TABLE `tulemused` (
  `id` int(11) NOT NULL,
  `haaltenumber` int(11) NOT NULL,
  `h_alguse_aeg` datetime NOT NULL,
  `poolt_haalte_arv` int(11) NOT NULL,
  `vastu_haalte_arv` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `haaletus`
--
ALTER TABLE `haaletus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logi`
--
ALTER TABLE `logi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tulemused`
--
ALTER TABLE `tulemused`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `haaletus`
--
ALTER TABLE `haaletus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `logi`
--
ALTER TABLE `logi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `tulemused`
--
ALTER TABLE `tulemused`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
