-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 07, 2023 at 11:18 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ci_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `id_user`, `id_product`, `qty`, `subtotal`) VALUES
(1, 4, 2, 1, 500000);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `slug`, `title`) VALUES
(7, 'alat-kesehatan-pribadi', 'Alat Kesehatan Pribadi'),
(9, 'obat-obatan', 'Obat-obatan'),
(10, 'perlengkapan-kebersihan', 'Perlengkapan Kebersihan'),
(11, 'perlengkapan-medis', 'Perlengkapan Medis'),
(12, 'suplemen-diet', 'Suplemen Diet'),
(13, 'alat-penunjang-gerak', 'Alat Penunjang Gerak');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `date` date NOT NULL,
  `invoice` varchar(100) NOT NULL,
  `total` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `method` enum('prepaid','postpaid') CHARACTER SET utf32 COLLATE utf32_general_ci NOT NULL,
  `status` enum('waiting','paid','delivered','cancel') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `id_user`, `date`, `invoice`, `total`, `name`, `address`, `phone`, `method`, `status`) VALUES
(1, 5, '2020-03-18', '520200318210456', 36000000, 'Hakim', 'Kampung Malang Kulon 1/38-A', '087855777360', 'prepaid', 'paid'),
(2, 5, '2020-03-19', '520200319181238', 500000, 'Jotaro Kujo', 'Western', '218838383', 'prepaid', 'delivered'),
(3, 5, '2020-03-24', '520200324223408', 3000000, 'Amir Muhammad Hakim', 'Kampung Malang Kulon 1/38-A', '087855777360', 'prepaid', 'waiting');

-- --------------------------------------------------------

--
-- Table structure for table `orders_confirm`
--

CREATE TABLE `orders_confirm` (
  `id` int(11) NOT NULL,
  `id_orders` int(11) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `nominal` int(11) NOT NULL,
  `note` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `orders_confirm`
--

INSERT INTO `orders_confirm` (`id`, `id_orders`, `account_name`, `account_number`, `nominal`, `note`, `image`) VALUES
(1, 1, 'Amir', '42424123333', 36000000, '-', '520200318210456-20200319173859.jpg'),
(2, 2, 'Dio Brando', '344312321', 500000, 'Mantap kang', '520200319181238-20200319181447.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL,
  `id_orders` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `qty` int(4) NOT NULL,
  `subtotal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`id`, `id_orders`, `id_product`, `qty`, `subtotal`) VALUES
(1, 1, 4, 6, 30000000),
(2, 1, 3, 2, 6000000),
(3, 2, 2, 1, 500000),
(4, 3, 3, 1, 3000000);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `id_category`, `slug`, `title`, `description`, `price`, `is_available`, `image`) VALUES
(2, 13, 'kursi-roda-standard', 'Kursi Roda Standard', 'Kursi Roda Black Steel ABM\r\n\r\nKursi Roda ABM :\r\n1. Kursi Roda Standar dengan harga ekonomis\r\n2. Bahan besi dengan powder coating, berat sekitar 7Kg\r\n3. Warna dasar hitam\r\n4. Roda besar ban mati dengan pengayuh bergerigi sehingga tidak licin saat dikayuh o', 1200000, 1, 'ps-3-stick-console-20231007160940.jpg'),
(5, 13, 'tongkat-jalan-lansia-manula-kaki-4-type-code-som-12-hg-gold', 'Tongkat Jalan Lansia Manula (kaki 4) Type Code SOM 1.2 HG - GOLD', 'READY WARNA :\r\nCOKLAT dan SILVER\r\n- TONGKAT KAKI 4\r\n- Bahan anti karat.\r\n- Pegangan Empuk ada busanya.\r\n- Ketinggian dapat diatur antara 72cm-95cm.\r\n- Dimensi Produk : 19cm x 14cm x 8cm\r\n- Karet anti slip pada ujung kaki tongkat dengan metal ring untuk ke', 95000, 1, 'tongkat-jalan-lansia-manula-kaki-4-type-code-som-12-hg-gold-20231007161359.jpg'),
(6, 9, 'atorvastatin-ogb-dexa-medica-20-mg-box-30-tablet', 'ATORVASTATIN OGB DEXA MEDICA 20 MG BOX 30 TABLET', 'PENGGUNAAN OBAT INI HARUS SESUAI PETUNJUK DOKTER. Digunakan untuk menurunkan kadar kolesterol dan juga sebagai terapi tambahan untuk menurunkan kadar kolesterol total, LDL, apolipoprotein B, dan trigliserida yang meningkat pada pasien dengan hiperkolester', 25000, 1, 'atorvastatin-ogb-dexa-medica-20-mg-box-30-tablet-20231007161523.jpg'),
(7, 9, 'amlodipine-besilate-hexpharm-5-mg-box-100-tablet', 'AMLODIPINE BESILATE HEXPHARM 5 MG BOX 100 TABLET', 'Deskripsi:\r\nPENGGUNAAN OBAT INI HARUS SESUAI PETUNJUK DOKTER. Digunakan untuk pengobatan hipertensi (tekanan darah tinggi), angina stabil kronik, pengobatan pasien yang pasti atau diduga menderita angina vasospastik (angina varian)\r\n\r\nKomposisi:\r\nTiap tab', 27000, 1, 'amlodipine-besilate-hexpharm-5-mg-box-100-tablet-20231007161615.jpg'),
(8, 12, 'herslim-herlean-hervibe-bpom-halal-by-herwell-minuman-diet-herslim', 'HERSLIM / HERLEAN / HERVIBE BPOM HALAL BY HERWELL MINUMAN DIET - HERSLIM', 'Berhenti siksa tubuhmu dengan cara yang tidak sehat. Herwell paham kalau kamu butuh asupan nutrisi yang cukup saat diet tanpa merusak plan diet kamu.\r\nHerslim adalah suplemen tinggi nutrisi yang bisa membantu program diet dengan memberikan efek kenyang le', 300000, 1, 'herslim-herlean-hervibe-bpom-halal-by-herwell-minuman-diet-herslim-20231007161744.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','member') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `image` varchar(255) DEFAULT NULL,
  `dob` date NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `address` varchar(64) NOT NULL,
  `city` varchar(25) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `paypal` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `password`, `role`, `is_active`, `image`, `dob`, `gender`, `address`, `city`, `phone`, `paypal`) VALUES
(8, 'Rifki Riza Alfiansyah', '19081010105@student.upnjatim.ac.id', '$2y$10$dY5H5YuMm8DEOZbWHI04OOLcYx1ZUE/Taozo8kx5L1bgLxa.GjcmW', 'member', 1, NULL, '2023-10-07', 'male', 'Surabaya', 'KOTA PASURUAN', '123123', '1321321312'),
(9, 'admin', 'admin@admin.com', '$2y$10$Tyq8/sO7EgWLWKC24fSldOeE4.YTQCuu1NFzrncfaLLvdGwLZaHCa', 'admin', 1, NULL, '2023-10-07', 'male', 'admin123', 'admin123', '123', 'admin123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders_confirm`
--
ALTER TABLE `orders_confirm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders_confirm`
--
ALTER TABLE `orders_confirm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
