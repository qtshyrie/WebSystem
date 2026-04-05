-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2026 at 01:20 AM
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
(22, 'Cristopher', 'Ramirez', 'admin', '$2y$10$H6KWNhDPn59.r5rQ8JtGMeDQoRBhFzPfI4iL2Yqr9alBi0a5PJeiS', '2006-10-14', 2147483647, 'cristopherram55@gmail.com');

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

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `status` enum('Available','Denied') DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT 0.0,
  `category` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `file_path` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `status`, `rating`, `category`, `created_at`, `file_path`) VALUES
(1, 'College Algebra', 'Sir Uchi', 'Denied', 0.0, 'Math', '2026-04-05 10:26:20', NULL),
(4, 'Computer Programming', 'Sir Ricky', 'Available', 3.0, 'Technology', '2026-04-04 14:46:33', ''),
(5, 'Web System and Tech.', 'Sir Cabral', 'Available', 4.9, 'Technology', '2026-04-04 14:46:33', NULL),
(6, 'Technical Computer Concept', 'Sir Cabral', 'Available', 5.0, 'Technology', '2026-04-04 14:46:33', NULL),
(8, 'The Contemporary World', 'Mrs. Merdegia', 'Denied', 4.0, 'English', '2026-04-04 14:46:33', NULL),
(9, 'Philippine Literarure In English', 'Sir Mallilin', 'Available', 4.8, 'Literature', '2026-04-04 14:46:33', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `status` enum('Available','Not Available') DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `path` varchar(260) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `title`, `author`, `status`, `created_at`, `path`) VALUES
(1, 'College Algebra<', 'Prof. Ted Uchi', 'Available', '0000-00-00 00:00:00', 'https://docs.google.com/forms/d/e/1FAIpQLSfB8J0A3UIjod3kCNse70HvFLQ3TTXXkXtls7NCc7K_CrpQMg/viewform?usp=dialog'),
(2, 'Pathfit', 'Prof. Jennider Dela Cruz', 'Not Available', '0000-00-00 00:00:00', 'NULL'),
(3, 'Computer Programming 2', 'Prof. Mark Ricky Raby', 'Available', '0000-00-00 00:00:00', 'https://docs.google.com/forms/d/e/1FAIpQLSfctpjXh4Qrwm6kQebZk3BEi5OEwideyGPHrqHfUM3CRT-QJg/viewform?usp=publish-editor'),
(4, 'NSTP', 'Prof. Leopoldo De Jesus', 'Available', '0000-00-00 00:00:00', 'https://docs.google.com/forms/d/e/1FAIpQLSeK1zgk23g6L6TSFB_4Yv18W1JIfKnGSc1bG3t3Vi-1Srtpug/viewform?usp=header');

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
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
