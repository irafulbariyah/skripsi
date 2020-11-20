-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 20, 2020 at 04:31 PM
-- Server version: 5.7.24
-- PHP Version: 7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siakad_stimata`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_krs`
--

CREATE TABLE `detail_krs` (
  `detail_krs_id` varchar(50) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'baru/ulang',
  `tgl_krs` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tugas_1` float NOT NULL DEFAULT '0',
  `uts` float NOT NULL DEFAULT '0',
  `tugas_2` float NOT NULL DEFAULT '0',
  `uas` float NOT NULL DEFAULT '0',
  `krs_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krs`
--

CREATE TABLE `krs` (
  `krs_id` varchar(50) NOT NULL COMMENT 'tabel krs yang mengelola kaprodi',
  `semester` varchar(50) NOT NULL DEFAULT '',
  `tahun_akademik` varchar(50) NOT NULL DEFAULT '',
  `nip` varchar(100) NOT NULL DEFAULT '',
  `kelas` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'a/b = untuk pembagian setiap kelas berbeda record ',
  `kode_matkul` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_biaya`
--

CREATE TABLE `master_biaya` (
  `biaya_id` int(11) NOT NULL,
  `tahun` varchar(15) DEFAULT NULL,
  `jenis_pembayaran` varchar(100) DEFAULT NULL,
  `jumlah` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_bobot_nilai`
--

CREATE TABLE `master_bobot_nilai` (
  `bobot_nilai_id` int(11) NOT NULL,
  `nilai` varchar(15) DEFAULT NULL,
  `indeks` float DEFAULT NULL,
  `bobot` float NOT NULL DEFAULT '0',
  `predikat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_dosen`
--

CREATE TABLE `master_dosen` (
  `nip` varchar(100) NOT NULL,
  `nidn` varchar(100) NOT NULL DEFAULT '',
  `nama` varchar(100) NOT NULL,
  `alamat_asal` varchar(100) NOT NULL,
  `alamat_domisili` varchar(100) NOT NULL,
  `no_telp` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `keahlian` varchar(100) DEFAULT NULL,
  `home_base` varchar(100) DEFAULT NULL,
  `jabatan_id` int(11) DEFAULT NULL,
  `jafa_id` int(11) DEFAULT NULL,
  `status_dosen_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_jabatan_dosen`
--

CREATE TABLE `master_jabatan_dosen` (
  `jabatan_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_jafa_dosen`
--

CREATE TABLE `master_jafa_dosen` (
  `jafa_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_kalender_akademik`
--

CREATE TABLE `master_kalender_akademik` (
  `kalender_akademik_id` int(11) NOT NULL,
  `kegiatan` varchar(100) DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_akhir` date DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_maba`
--

CREATE TABLE `master_maba` (
  `no_pendaftaran` varchar(50) NOT NULL,
  `nik` int(11) DEFAULT '0',
  `nama` varchar(100) DEFAULT NULL,
  `alamat_asal` varchar(100) DEFAULT NULL,
  `alamat_domisili` varchar(100) DEFAULT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `jenis_kelamin` tinyint(1) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `nama_ayah` varchar(50) DEFAULT NULL,
  `agama` varchar(100) DEFAULT NULL,
  `asal_sekolah` varchar(100) DEFAULT NULL,
  `alamat_asal_sekolah` varchar(100) DEFAULT NULL,
  `jurusan_asal_sekolah` varchar(100) DEFAULT NULL,
  `danem` varchar(15) DEFAULT NULL,
  `status_daftar_mhs_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_mahasiswa`
--

CREATE TABLE `master_mahasiswa` (
  `nim` varchar(15) NOT NULL DEFAULT '',
  `nama` varchar(100) DEFAULT NULL,
  `no_telp` int(100) DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `tgl_keluar` date DEFAULT NULL,
  `no_do` int(11) NOT NULL,
  `lama_studi` int(11) DEFAULT NULL,
  `jenis_kelas` varchar(3) DEFAULT NULL,
  `kode_prodi` varchar(15) DEFAULT NULL,
  `status_daftar_mhs_id` int(11) DEFAULT NULL,
  `status_mhs_id` int(11) DEFAULT NULL,
  `no_pendaftaran` varchar(50) NOT NULL DEFAULT '0',
  `dosen_wali_id` varchar(100) NOT NULL DEFAULT '0' COMMENT 'foreign ke master dosen untuk relasi dosen wali'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_mata_kuliah`
--

CREATE TABLE `master_mata_kuliah` (
  `kode_matkul` varchar(100) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `sks` int(11) DEFAULT NULL,
  `syarat` varchar(100) DEFAULT NULL,
  `semester` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_presensi`
--

CREATE TABLE `master_presensi` (
  `master_presensi_id` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_prodi`
--

CREATE TABLE `master_prodi` (
  `kode_prodi` varchar(15) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `jenjang` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_ruangan`
--

CREATE TABLE `master_ruangan` (
  `ruangan_id` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_status_daftar_mhs`
--

CREATE TABLE `master_status_daftar_mhs` (
  `status_daftar_mhs_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_status_dosen`
--

CREATE TABLE `master_status_dosen` (
  `status_dosen_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_status_mhs`
--

CREATE TABLE `master_status_mhs` (
  `status_mhs_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rekap_presensi_mingguan`
--

CREATE TABLE `rekap_presensi_mingguan` (
  `presensi_id` varchar(50) NOT NULL,
  `krs_id` varchar(50) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `minggu_1` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'cekal = sum dari minggu ke 1-14',
  `minggu_2` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_3` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_4` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_5` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_6` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_7` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_8` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_9` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_10` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_11` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_12` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_13` tinyint(4) NOT NULL DEFAULT '0',
  `minggu_14` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_krs`
--
ALTER TABLE `detail_krs`
  ADD PRIMARY KEY (`detail_krs_id`),
  ADD KEY `FK__mahasiswa` (`nim`),
  ADD KEY `FK_detail_krs_krs` (`krs_id`);

--
-- Indexes for table `krs`
--
ALTER TABLE `krs`
  ADD PRIMARY KEY (`krs_id`),
  ADD KEY `FK__mata_kuliah` (`kode_matkul`),
  ADD KEY `FK_krs_dosen` (`nip`);

--
-- Indexes for table `master_biaya`
--
ALTER TABLE `master_biaya`
  ADD PRIMARY KEY (`biaya_id`);

--
-- Indexes for table `master_bobot_nilai`
--
ALTER TABLE `master_bobot_nilai`
  ADD PRIMARY KEY (`bobot_nilai_id`);

--
-- Indexes for table `master_dosen`
--
ALTER TABLE `master_dosen`
  ADD PRIMARY KEY (`nip`),
  ADD KEY `FK_dosen_1` (`jabatan_id`),
  ADD KEY `FK_dosen_2` (`jafa_id`),
  ADD KEY `FK_dosen_3` (`status_dosen_id`);

--
-- Indexes for table `master_jabatan_dosen`
--
ALTER TABLE `master_jabatan_dosen`
  ADD PRIMARY KEY (`jabatan_id`);

--
-- Indexes for table `master_jafa_dosen`
--
ALTER TABLE `master_jafa_dosen`
  ADD PRIMARY KEY (`jafa_id`);

--
-- Indexes for table `master_kalender_akademik`
--
ALTER TABLE `master_kalender_akademik`
  ADD PRIMARY KEY (`kalender_akademik_id`);

--
-- Indexes for table `master_maba`
--
ALTER TABLE `master_maba`
  ADD PRIMARY KEY (`no_pendaftaran`),
  ADD KEY `FK_maba_1` (`status_daftar_mhs_id`);

--
-- Indexes for table `master_mahasiswa`
--
ALTER TABLE `master_mahasiswa`
  ADD PRIMARY KEY (`nim`),
  ADD KEY `FK_mahasiswa_1` (`kode_prodi`),
  ADD KEY `FK_mahasiswa_2` (`status_daftar_mhs_id`),
  ADD KEY `FK_mahasiswa_3` (`status_mhs_id`),
  ADD KEY `FK_mahasiswa_maba` (`no_pendaftaran`),
  ADD KEY `FK_mahasiswa_dosen` (`dosen_wali_id`);

--
-- Indexes for table `master_mata_kuliah`
--
ALTER TABLE `master_mata_kuliah`
  ADD PRIMARY KEY (`kode_matkul`);

--
-- Indexes for table `master_presensi`
--
ALTER TABLE `master_presensi`
  ADD PRIMARY KEY (`master_presensi_id`);

--
-- Indexes for table `master_prodi`
--
ALTER TABLE `master_prodi`
  ADD PRIMARY KEY (`kode_prodi`);

--
-- Indexes for table `master_ruangan`
--
ALTER TABLE `master_ruangan`
  ADD PRIMARY KEY (`ruangan_id`);

--
-- Indexes for table `master_status_daftar_mhs`
--
ALTER TABLE `master_status_daftar_mhs`
  ADD PRIMARY KEY (`status_daftar_mhs_id`);

--
-- Indexes for table `master_status_dosen`
--
ALTER TABLE `master_status_dosen`
  ADD PRIMARY KEY (`status_dosen_id`);

--
-- Indexes for table `master_status_mhs`
--
ALTER TABLE `master_status_mhs`
  ADD PRIMARY KEY (`status_mhs_id`);

--
-- Indexes for table `rekap_presensi_mingguan`
--
ALTER TABLE `rekap_presensi_mingguan`
  ADD PRIMARY KEY (`presensi_id`),
  ADD KEY `FK_presensi_krs` (`krs_id`),
  ADD KEY `FK_presensi_mahasiswa` (`nim`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_krs`
--
ALTER TABLE `detail_krs`
  ADD CONSTRAINT `FK__mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_detail_krs_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `krs`
--
ALTER TABLE `krs`
  ADD CONSTRAINT `FK__mata_kuliah` FOREIGN KEY (`kode_matkul`) REFERENCES `master_mata_kuliah` (`kode_matkul`),
  ADD CONSTRAINT `FK_krs_dosen` FOREIGN KEY (`nip`) REFERENCES `master_dosen` (`nip`);

--
-- Constraints for table `master_dosen`
--
ALTER TABLE `master_dosen`
  ADD CONSTRAINT `FK_dosen_1` FOREIGN KEY (`jabatan_id`) REFERENCES `master_jabatan_dosen` (`jabatan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dosen_2` FOREIGN KEY (`jafa_id`) REFERENCES `master_jafa_dosen` (`jafa_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dosen_3` FOREIGN KEY (`status_dosen_id`) REFERENCES `master_status_dosen` (`status_dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `master_maba`
--
ALTER TABLE `master_maba`
  ADD CONSTRAINT `FK_maba_1` FOREIGN KEY (`status_daftar_mhs_id`) REFERENCES `master_status_daftar_mhs` (`status_daftar_mhs_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `master_mahasiswa`
--
ALTER TABLE `master_mahasiswa`
  ADD CONSTRAINT `FK_mahasiswa_1` FOREIGN KEY (`kode_prodi`) REFERENCES `master_prodi` (`kode_prodi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mahasiswa_2` FOREIGN KEY (`status_daftar_mhs_id`) REFERENCES `master_status_daftar_mhs` (`status_daftar_mhs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mahasiswa_3` FOREIGN KEY (`status_mhs_id`) REFERENCES `master_status_mhs` (`status_mhs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mahasiswa_dosen` FOREIGN KEY (`dosen_wali_id`) REFERENCES `master_dosen` (`nip`),
  ADD CONSTRAINT `FK_mahasiswa_maba` FOREIGN KEY (`no_pendaftaran`) REFERENCES `master_maba` (`no_pendaftaran`);

--
-- Constraints for table `rekap_presensi_mingguan`
--
ALTER TABLE `rekap_presensi_mingguan`
  ADD CONSTRAINT `FK_presensi_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_presensi_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
