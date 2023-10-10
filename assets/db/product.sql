-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 10, 2023 at 05:02 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `id_category`, `slug`, `title`, `description`, `price`, `is_available`, `image`) VALUES
(2, 13, 'kursi-roda-standard', 'Kursi Roda Standard', 'Kursi Roda Black Steel ABM\r\n\r\nKursi Roda ABM :\r\n1. Kursi Roda Standar dengan harga ekonomis\r\n2. Bahan besi dengan powder coating, berat sekitar 7Kg\r\n3. Warna dasar hitam\r\n4. Roda besar ban mati dengan pengayuh bergerigi sehingga tidak licin saat dikayuh o', 1200000, 1, 'ps-3-stick-console-20231007160940.jpg'),
(5, 13, 'tongkat-jalan-lansia-manula-kaki-4-type-code-som-12-hg-gold', 'Tongkat Jalan Lansia Manula (kaki 4) Type Code SOM 1.2 HG - GOLD', 'READY WARNA :\r\nCOKLAT dan SILVER\r\n- TONGKAT KAKI 4\r\n- Bahan anti karat.\r\n- Pegangan Empuk ada busanya.\r\n- Ketinggian dapat diatur antara 72cm-95cm.\r\n- Dimensi Produk : 19cm x 14cm x 8cm\r\n- Karet anti slip pada ujung kaki tongkat dengan metal ring untuk ke', 95000, 1, 'tongkat-jalan-lansia-manula-kaki-4-type-code-som-12-hg-gold-20231007161359.jpg'),
(6, 9, 'atorvastatin-ogb-dexa-medica-20-mg-box-30-tablet', 'ATORVASTATIN OGB DEXA MEDICA 20 MG BOX 30 TABLET', 'PENGGUNAAN OBAT INI HARUS SESUAI PETUNJUK DOKTER. Digunakan untuk menurunkan kadar kolesterol dan juga sebagai terapi tambahan untuk menurunkan kadar kolesterol total, LDL, apolipoprotein B, dan trigliserida yang meningkat pada pasien dengan hiperkolester', 25000, 1, 'atorvastatin-ogb-dexa-medica-20-mg-box-30-tablet-20231007161523.jpg'),
(7, 9, 'amlodipine-besilate-hexpharm-5-mg-box-100-tablet', 'AMLODIPINE BESILATE HEXPHARM 5 MG BOX 100 TABLET', 'Deskripsi:\r\nPENGGUNAAN OBAT INI HARUS SESUAI PETUNJUK DOKTER. Digunakan untuk pengobatan hipertensi (tekanan darah tinggi), angina stabil kronik, pengobatan pasien yang pasti atau diduga menderita angina vasospastik (angina varian)\r\n\r\nKomposisi:\r\nTiap tab', 27000, 1, 'amlodipine-besilate-hexpharm-5-mg-box-100-tablet-20231007161615.jpg'),
(8, 12, 'herslim-herlean-hervibe-bpom-halal-by-herwell-minuman-diet-herslim', 'HERSLIM / HERLEAN / HERVIBE BPOM HALAL BY HERWELL MINUMAN DIET - HERSLIM', 'Berhenti siksa tubuhmu dengan cara yang tidak sehat. Herwell paham kalau kamu butuh asupan nutrisi yang cukup saat diet tanpa merusak plan diet kamu.\r\nHerslim adalah suplemen tinggi nutrisi yang bisa membantu program diet dengan memberikan efek kenyang le', 300000, 1, 'herslim-herlean-hervibe-bpom-halal-by-herwell-minuman-diet-herslim-20231007161744.jpg'),
(9, 7, 'thermometer-digital', 'Thermometer Digital', '1. Dirancang untuk semua umur.\r\n2. Menggunakan Baterai tegangan listrik: dc1.5v\r\n3. Dengan petunjuk suara Dan fungsi memori.\r\n4. kisaran pengukuran: 32,0 ~ 42,0 c; akurasi pengukuran: 0.1 c\r\n5. Ukuran 14cm x 2.5cm', 8250, 1, 'thermometer-digital-20231010214114.jpeg'),
(10, 7, 'tensimeter-digital', 'Tensimeter Digital', 'Measurement Range:\r\n- Pressure: 5.3kPa-37.3kPa (40mmHg-280mmHg)\r\n- Pulse: 40-199 times/min\r\n- Wrist band display range: 0kPa-39.9kPa (0mmHg-299mmHg)\r\nAccuracy:\r\n- Static Pressure +-0/4kPa(+-3mmHg)\r\n- Pulse: within +-5%', 90000, 1, 'tensimeter-digital-20231010214404.jpeg'),
(11, 10, 'waslap', 'Waslap', 'Digunakan sebagai kain penyeka dan cocok digunakan saat memandikan bayi.\r\nPemakaian juga mudah &nyaman dipakai.\r\nDeskripsi produk:\r\n✔️ Lembut\r\n✔️ warna random mix (tidak bisa pilih)', 1500, 1, 'waslap-20231010214848.jpeg'),
(12, 10, 'hand-sanitizer', 'Hand Sanitizer', 'Kelebihan : \r\n1. Aman digunakan untuk segala usia (anak anak hingga dewasa bisa pakai)\r\n2. Aman digunakan sesering mungkin\r\n3. Aroma Menyegarkan\r\n4. Tidak MUdah Kering Di Tangan\r\n5. Membunuh Kuman 99.9%', 18000, 1, 'hand-sanitizer-20231010215124.jpeg'),
(13, 7, 'pulse-oximeter', 'Pulse Oximeter', 'Specifications:\r\nMaterial: Lastics\r\nDisplay Methid: LED 4 colour\r\nBlood Oxygen: 0%-100% ±2%\r\nPulse Rate Display: 0-250bpm ±1bpm\r\nWorking Current: ≤50mA\r\nOperation Mode: Intermittent\r\nCell: 2 x AAA alkaline cells (not included)\r\nItem Size: 57.3 * 33.2 * 32', 8000, 1, 'pulse-oximeter-20231010215519.jpeg'),
(14, 11, 'masker-disposable-3-layer-mask', 'Masker Disposable 3 Layer Mask', '- 1 BOX isi 50 pcs.\r\n- Masker baru masih tersegel.\r\n- Sudah tersertifikasi FDA & CE.\r\n- Perlindungan yang efektif.\r\n- Model ear loop dengan tali yang elastis.\r\n- Dengan bahan yang nyaman saat digunakan.', 5800, 1, 'masker-disposable-3-layer-mask-20231010215750.jpeg'),
(15, 11, 'oxycan-green-500-cc', 'Oxycan Green 500 cc', 'Fungsi\r\nOksigen murni bagi yang memerlukan tambahan oksigen\r\n\r\nKandungan\r\n95% oksigen murni', 38000, 1, 'oxycan-green-500-cc-20231010220009.jpeg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
