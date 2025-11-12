-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2025 at 07:01 AM
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
-- Database: `db_sekolah_mazkasn`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_guru_azka`
--

CREATE TABLE `tbl_guru_azka` (
  `id_guru` int(11) NOT NULL,
  `nama_guru` varchar(100) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_guru_azka`
--

INSERT INTO `tbl_guru_azka` (`id_guru`, `nama_guru`, `alamat`) VALUES
(1, 'Kiki Julian', 'Gadobangkong\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_kelas_azka`
--

CREATE TABLE `tbl_kelas_azka` (
  `id_kelas` int(11) NOT NULL,
  `nama_kelas` varchar(50) NOT NULL,
  `tingkat` enum('X','XI','XII') NOT NULL,
  `jurusan` varchar(50) NOT NULL,
  `wali_kelas` int(11) NOT NULL,
  `jumlah_siswa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_kelas_azka`
--

INSERT INTO `tbl_kelas_azka` (`id_kelas`, `nama_kelas`, `tingkat`, `jurusan`, `wali_kelas`, `jumlah_siswa`) VALUES
(1, 'XI RPL B', 'XI', 'RPL', 1, 35);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_mapel_azka`
--

CREATE TABLE `tbl_mapel_azka` (
  `id_mapel` int(11) NOT NULL,
  `nama_mapel` varchar(100) NOT NULL,
  `jumlah_jam` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_mapel_azka`
--

INSERT INTO `tbl_mapel_azka` (`id_mapel`, `nama_mapel`, `jumlah_jam`) VALUES
(1, 'Matematika', 3),
(2, 'Bahasa Indonesia', 2),
(3, 'Bahasa Jepang', 2),
(4, 'Bahasa sunda', 2),
(5, 'Bahasa Inggris', 2),
(6, 'Bahasa Indonesia', 2),
(7, 'PPLG', 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_nilai_azka`
--

CREATE TABLE `tbl_nilai_azka` (
  `id_nilai` int(11) NOT NULL,
  `NIS` varchar(50) NOT NULL,
  `id_mapel` int(11) NOT NULL,
  `nilai_harian` float NOT NULL,
  `nilai_uts` float NOT NULL,
  `nilai_uas` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_nilai_azka`
--

INSERT INTO `tbl_nilai_azka` (`id_nilai`, `NIS`, `id_mapel`, `nilai_harian`, `nilai_uts`, `nilai_uas`) VALUES
(1, '10243285 ', 1, 80, 85, 95),
(2, '10243286 ', 2, 80, 90, 75),
(3, '10243287', 2, 85, 90, 90),
(4, '10243285 ', 3, 95, 90, 85),
(5, '10243303', 2, 90, 95, 85),
(8, '10243300', 3, 70, 85, 90),
(9, '10243310', 4, 90, 85, 90),
(10, '10243285 ', 5, 90, 95, 90),
(11, '10243295', 6, 82, 87, 85),
(12, '10243285 ', 7, 90, 91, 89);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_siswa_azka`
--

CREATE TABLE `tbl_siswa_azka` (
  `id_siswa` int(11) NOT NULL,
  `NIS` varchar(50) NOT NULL,
  `id_kelas` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `Jenis_Kelamin` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_siswa_azka`
--

INSERT INTO `tbl_siswa_azka` (`id_siswa`, `NIS`, `id_kelas`, `nama`, `alamat`, `Jenis_Kelamin`) VALUES
(1, '10243285 ', 1, 'Ahkam Ihsanul Mizan', 'Ngamprah', 'Laki-laki'),
(2, '10243286 ', 1, 'Alfin Bathosan', 'Sangkuriang', 'Laki-laki'),
(3, '10243287', 1, 'Anisa Jaya Lestari', 'Kamarung', 'Perempuan'),
(4, '10243288', 1, 'Dean Petra Betti', 'Tegal Kawung', 'Laki-laki'),
(5, '10243289', 1, 'Elva C', 'Kp. Nyalindung', 'Perempuan'),
(6, '10243290', 1, 'Excel Rinda Dwiki Darmawan', 'Kolonel Masturi', 'Laki-laki'),
(7, '10243291', 1, 'Fadlan', 'Citereup', 'Laki-laki'),
(8, '10243292', 1, 'Fahri Hadi ', 'Jl Padasuka', 'Laki-laki'),
(9, '10243293', 1, 'Fauzan Aby ', 'Pojok ', 'Laki-laki'),
(10, '10243294', 1, 'Fauzi Irwana', 'Pasar Kuda', 'Laki-laki'),
(11, '10243295', 1, 'Hail Sukma', 'Haji Gofur\r\n', 'Laki-Laki'),
(12, '10243296', 1, 'Istifa Falasifah', 'Citereup', 'Perempuan'),
(13, '10243297', 1, 'Dirgahayu', 'Citereup', 'Laki-laki'),
(14, '10243298', 1, 'Muhammad Ramdan', 'Citereup\r\n\r\n', 'Laki-Laki'),
(15, '10243299', 1, 'Rizki Ardiansyah', 'Paku Haji', 'Laki-laki'),
(16, '10243300', 1, 'Muhammad Akbar ', 'Jl. Padasuka\r\n\r\n', 'Laki-Laki'),
(17, '10243301', 1, 'Muhammad Alif Firdaus', 'Jl. Kebon Kopi', 'Laki-laki'),
(18, '10243302', 1, 'Muhammad Azzam', 'Jl. Ciawi Tali\r\n', 'Laki-Laki'),
(19, '10243303', 1, 'Muhammad Azka Sa\'adi Nabhan', 'Jl Pangauban,Perumahan Pangauban Silih Asih Blok M58, Kec.Batujajar\r\n', 'Laki-Laki'),
(20, '10243304', 1, 'Muhammad Chandra Pratama', 'Buciper', 'Laki-laki'),
(21, '10243305', 1, 'Muhammad Ezra Taufani', 'Pondok Cibaligo \r\n\r\n', 'Laki-Laki'),
(22, '10243306', 1, '-', '-', 'Laki-laki'),
(23, '10243307', 1, 'Novi Ropiah', 'Cibabat', 'Perempuan'),
(24, '10243308', 1, 'Novri Krisna', 'Sangkuriang', 'Laki-laki'),
(25, '10243309', 1, 'Raditya R', 'Padalarang', 'Laki-laki'),
(26, '10243310 ', 1, 'Rafasya A', 'Padalarang', 'Laki-laki'),
(27, '10243311', 1, 'Rahma Khairul Hawa', 'Cibabat Cigugur ', 'Perempuan'),
(28, '10243312', 1, 'Raihan Fadlansyah', 'Kamarung', 'Laki-laki'),
(29, '10243313', 1, 'Rayhan Rizky ', 'Ciawi Tali', 'Laki-laki'),
(30, '10243314', 1, 'Revita Gadis Amijaya', 'Padaasih', 'Perempuan'),
(31, '10243315', 1, 'Rizki Ahmad M', 'Citereup', 'Laki-laki'),
(32, '10243316', 1, 'Rizqy Ramadhan Indrawan Putra', 'Pancanaka', 'Laki-laki'),
(33, '10243317', 1, 'Salma A', 'Kamarung', 'Perempuan'),
(34, '10243318', 1, 'Sazkiya', '-', 'Perempuan'),
(35, '10243319', 1, 'Yoga Pratama ', 'Citereup', 'Laki-laki'),
(36, '10243320', 1, 'Yunifa Rizky', 'Sangkuriang', 'Perempuan');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_guru_azka`
--
ALTER TABLE `tbl_guru_azka`
  ADD PRIMARY KEY (`id_guru`);

--
-- Indexes for table `tbl_kelas_azka`
--
ALTER TABLE `tbl_kelas_azka`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `fk_guru` (`wali_kelas`);

--
-- Indexes for table `tbl_mapel_azka`
--
ALTER TABLE `tbl_mapel_azka`
  ADD PRIMARY KEY (`id_mapel`);

--
-- Indexes for table `tbl_nilai_azka`
--
ALTER TABLE `tbl_nilai_azka`
  ADD PRIMARY KEY (`id_nilai`),
  ADD KEY `NIS` (`NIS`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tbl_siswa_azka`
--
ALTER TABLE `tbl_siswa_azka`
  ADD PRIMARY KEY (`id_siswa`),
  ADD UNIQUE KEY `NIS` (`NIS`),
  ADD KEY `id_kelas` (`id_kelas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_guru_azka`
--
ALTER TABLE `tbl_guru_azka`
  MODIFY `id_guru` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_kelas_azka`
--
ALTER TABLE `tbl_kelas_azka`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_mapel_azka`
--
ALTER TABLE `tbl_mapel_azka`
  MODIFY `id_mapel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_nilai_azka`
--
ALTER TABLE `tbl_nilai_azka`
  MODIFY `id_nilai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbl_siswa_azka`
--
ALTER TABLE `tbl_siswa_azka`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_kelas_azka`
--
ALTER TABLE `tbl_kelas_azka`
  ADD CONSTRAINT `fk_guru` FOREIGN KEY (`wali_kelas`) REFERENCES `tbl_guru_azka` (`id_guru`);

--
-- Constraints for table `tbl_nilai_azka`
--
ALTER TABLE `tbl_nilai_azka`
  ADD CONSTRAINT `tbl_nilai_azka_ibfk_1` FOREIGN KEY (`NIS`) REFERENCES `tbl_siswa_azka` (`NIS`),
  ADD CONSTRAINT `tbl_nilai_azka_ibfk_2` FOREIGN KEY (`id_mapel`) REFERENCES `tbl_mapel_azka` (`id_mapel`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
