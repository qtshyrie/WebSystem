-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2026 at 11:55 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `websystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `ID` int(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `birthday` varchar(50) NOT NULL,
  `contacts` int(11) NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT 'default@example.com'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`ID`, `firstname`, `lastname`, `username`, `password`, `birthday`, `contacts`, `email`) VALUES
(14, 'Angelou', 'Alon', 'ram', '$2y$10$G4ZS.jDvsGIuWjaSE6eQNOPPOP12gCqsF5t/F3oQEn2cN6VVtnrPC', '2026-04-13', 2147483647, 'cristuna555@gmail.com'),
(15, 'matthew', 'calunod', 'adsfasfd', '$2y$10$eQMTVjlSp5VgtU8R8GH.GOCXA.MNgouGSMPZaTFzq93jenq1E8LwG', '2026-04-13', 2147483647, 'cristuna555@gmail.com'),
(16, 'Angelou', 'Alon', 'ram', '$2y$10$/Xjn.hdk7nlkNIwkWmPP9OIhPfUOYd5nigZcp0L2BTRRScecQ0Ffe', '2026-04-07', 2147483647, 'cristuna555@gmail.com'),
(17, 'Angelou', 'Alon', 'ram', '$2y$10$x7NDEjZ9VI/QdaLhaosPa.XzmN4TN5ygd792A74k4cy/qktlN8t0a', '2026-04-13', 2147483647, 'cristuna555@gmail.com'),
(18, 'Cristopher', 'asdfasf', 'lonlon', '$2y$10$CLSoy8iBiIymcgaqjfzc7eUMjk/2/OH3xBe.cfqt5oIQkMo1APSZW', '2026-04-13', 2147483647, 'cristuna555@gmail.com'),
(19, 'Cristopher', 'Ramirez', 'admin', '$2y$10$.9PCFxYiy6dG/mvM8cxhPe4kyJqAp2.7CNEKBF4Kvv6Wy49vENwty', '2006-10-14', 2147483647, 'cristopherram55@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` int(11) NOT NULL,
  `icon` varchar(10) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `icon`, `description`, `created_at`) VALUES
(1, '📖', 'Project Hail Mary issued to John Doe', '2026-04-03 13:39:52'),
(2, '✅', 'The Great Gatsby returned', '2026-04-03 13:39:52'),
(3, '⭐', 'Dune rated 5 stars by Sarah Wilson', '2026-04-03 13:39:52');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `status` enum('Available','Issued') DEFAULT 'Available',
  `rating` decimal(2,1) DEFAULT 0.0,
  `category` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `file_path` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `status`, `rating`, `category`, `created_at`, `file_path`) VALUES
(4, 'Computer Programming', 'Sir Ricky', 'Available', 3.0, 'Technology', '2026-04-04 14:46:33', ''),
(5, 'Web System and Tech.', 'Sir Cabral', 'Available', 4.9, 'Technology', '2026-04-04 14:46:33', '\r\n'),
(6, 'Technical Computer Concept', 'Sir Cabral', 'Available', 5.0, 'Technology', '2026-04-04 14:46:33', NULL),
(8, 'The Contemporary World', 'Mrs. Merdegia', 'Available', 4.0, 'English', '2026-04-04 14:46:33', NULL),
(9, 'Philippine Literarure In English', 'Sir Mallilin', 'Available', 4.8, 'Literature', '2026-04-04 14:46:33', NULL),
(101, 'Computer Programming', 'Sir Ricky', 'Available', 3.0, 'Technology', '2026-04-04 14:46:33', NULL),
(102, 'Web System and Tech.', 'Sir Cabral', 'Available', 4.9, 'Technology', '2026-04-04 14:46:33', NULL),
(103, 'Technical Computer Concept', 'Sir Cabral', 'Available', 5.0, 'Technology', '2026-04-04 14:46:33', NULL),
(104, 'College Algebra', 'Sir Uchi', 'Issued', 3.0, 'Math', '2026-04-04 14:46:33', NULL),
(105, 'The Contemporary World', 'Mrs. Merdegia', 'Available', 4.0, 'English', '2026-04-04 14:46:33', NULL),
(106, 'Philippine Literarure In English', 'Sir Mallilin', 'Available', 4.8, 'Literature', '2026-04-04 14:46:33', NULL),
(108, 'Web System and Tech.', 'Sir Cabral', 'Available', 4.9, 'Technology', '2026-04-04 14:47:11', ''),
(109, 'Technical Computer Concept', 'Sir Cabral', 'Available', 5.0, 'Technology', '2026-04-04 14:47:11', NULL),
(110, 'College Algebra', 'Sir Uchi', 'Issued', 3.0, 'Math', '2026-04-04 14:47:11', NULL),
(111, 'The Contemporary World', 'Mrs. Merdegia', 'Available', 4.0, 'English', '2026-04-04 14:47:11', NULL),
(112, 'Philippine Literature In English', 'Sir Mallilin', 'Available', 4.8, 'Literature', '2026-04-04 14:47:11', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
