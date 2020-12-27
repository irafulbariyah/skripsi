-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for siakad_stimata
CREATE DATABASE IF NOT EXISTS `siakad_stimata` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `siakad_stimata`;

-- Dumping structure for table siakad_stimata.berita_acara
CREATE TABLE IF NOT EXISTS `berita_acara` (
  `id_beritaAcara` int(11) NOT NULL AUTO_INCREMENT,
  `krs_id` varchar(50) NOT NULL DEFAULT '0',
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'pertemuan ke order by tgl ascendding',
  `pokokBahasan` varchar(100) NOT NULL DEFAULT '0',
  `sub_pokokBahasan` varchar(100) NOT NULL DEFAULT '0',
  `sesuai_sap` varchar(15) NOT NULL DEFAULT '0' COMMENT 'ya/tidak',
  PRIMARY KEY (`id_beritaAcara`),
  KEY `FK_berita_acara_krs` (`krs_id`),
  CONSTRAINT `FK_berita_acara_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.berita_acara: ~0 rows (approximately)
DELETE FROM `berita_acara`;
/*!40000 ALTER TABLE `berita_acara` DISABLE KEYS */;
/*!40000 ALTER TABLE `berita_acara` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.detail_krs
CREATE TABLE IF NOT EXISTS `detail_krs` (
  `detail_krs_id` varchar(50) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `krs_id` varchar(50) NOT NULL,
  `nip` varchar(50) NOT NULL DEFAULT '0' COMMENT 'untuk ganti nilai oleh kaprodi',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'baru/ulang/ganti nilai',
  `tgl_krs` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`detail_krs_id`),
  KEY `FK__mahasiswa` (`nim`),
  KEY `FK_detail_krs_krs` (`krs_id`),
  KEY `FK_detail_krs_master_dosen` (`nip`),
  CONSTRAINT `FK__mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_detail_krs_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_detail_krs_master_dosen` FOREIGN KEY (`nip`) REFERENCES `master_karyawan` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.detail_krs: ~0 rows (approximately)
DELETE FROM `detail_krs`;
/*!40000 ALTER TABLE `detail_krs` DISABLE KEYS */;
/*!40000 ALTER TABLE `detail_krs` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.detail_presensi
CREATE TABLE IF NOT EXISTS `detail_presensi` (
  `id_detail_presensi` int(11) NOT NULL AUTO_INCREMENT,
  `master_presensi_id` int(11) DEFAULT NULL COMMENT 'cekal didapat dari perhitungan count di tabel detail presensi',
  `id_master_waktu_presensi` int(11) DEFAULT '0',
  `id_presensi_mhs` int(11) DEFAULT NULL,
  `Datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `latitude` varchar(50) DEFAULT '0',
  `longitude` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id_detail_presensi`),
  KEY `FK_detail_presensi_master_presensi` (`master_presensi_id`),
  KEY `FK_detail_presensi_master_waktu_presensi` (`id_master_waktu_presensi`),
  KEY `FK_detail_presensi_presensi_mhs` (`id_presensi_mhs`),
  CONSTRAINT `FK_detail_presensi_master_presensi` FOREIGN KEY (`master_presensi_id`) REFERENCES `master_tipe_presensi` (`id_master_presensi`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_detail_presensi_master_waktu_presensi` FOREIGN KEY (`id_master_waktu_presensi`) REFERENCES `master_waktu_presensi` (`id_master_waktu_presensi`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_detail_presensi_presensi_mhs` FOREIGN KEY (`id_presensi_mhs`) REFERENCES `presensi_mhs` (`id_presensi_mhs`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.detail_presensi: ~0 rows (approximately)
DELETE FROM `detail_presensi`;
/*!40000 ALTER TABLE `detail_presensi` DISABLE KEYS */;
/*!40000 ALTER TABLE `detail_presensi` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.detail_tugasakhir
CREATE TABLE IF NOT EXISTS `detail_tugasakhir` (
  `id_detail_tugasAkhir` int(11) NOT NULL AUTO_INCREMENT,
  `detail_krs_id` varchar(50) NOT NULL DEFAULT '0',
  `tanggalMaju` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `judul` varchar(100) NOT NULL DEFAULT '0',
  `pembimbing1` varchar(100) NOT NULL COMMENT 'nip',
  `pembimbing2` varchar(100) NOT NULL COMMENT 'nip',
  `penguji1` varchar(100) NOT NULL COMMENT 'nip',
  `penguji2` varchar(100) NOT NULL COMMENT 'nip',
  `penguji3` varchar(100) NOT NULL COMMENT 'nip',
  PRIMARY KEY (`id_detail_tugasAkhir`),
  KEY `FK_detail_tugasakhir_detail_krs` (`detail_krs_id`),
  KEY `FK_detail_tugasakhir_master_dosen_3` (`penguji1`),
  KEY `FK_detail_tugasakhir_master_dosen_4` (`penguji2`),
  KEY `FK_detail_tugasakhir_master_dosen_5` (`penguji3`),
  KEY `FK_detail_tugasakhir_master_dosen` (`pembimbing1`),
  KEY `FK_detail_tugasakhir_master_dosen_2` (`pembimbing2`),
  CONSTRAINT `FK_detail_tugasakhir_master_dosen` FOREIGN KEY (`pembimbing1`) REFERENCES `master_karyawan` (`nip`),
  CONSTRAINT `FK_detail_tugasakhir_master_dosen_2` FOREIGN KEY (`pembimbing2`) REFERENCES `master_karyawan` (`nip`),
  CONSTRAINT `FK_detail_tugasakhir_master_dosen_3` FOREIGN KEY (`penguji1`) REFERENCES `master_karyawan` (`nip`),
  CONSTRAINT `FK_detail_tugasakhir_master_dosen_4` FOREIGN KEY (`penguji2`) REFERENCES `master_karyawan` (`nip`),
  CONSTRAINT `FK_detail_tugasakhir_master_dosen_5` FOREIGN KEY (`penguji3`) REFERENCES `master_karyawan` (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.detail_tugasakhir: ~0 rows (approximately)
DELETE FROM `detail_tugasakhir`;
/*!40000 ALTER TABLE `detail_tugasakhir` DISABLE KEYS */;
/*!40000 ALTER TABLE `detail_tugasakhir` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.jadwal_matkul
CREATE TABLE IF NOT EXISTS `jadwal_matkul` (
  `jadwal_matkul_id` varchar(15) NOT NULL,
  `krs_id` varchar(50) DEFAULT NULL,
  `ruangan` int(11) DEFAULT NULL,
  `jam_mulai` timestamp NULL,
  `jam_selesai` timestamp NULL,
  `hari` date DEFAULT NULL,
  PRIMARY KEY (`jadwal_matkul_id`),
  KEY `FK_jadwal_matkul_krs` (`krs_id`),
  KEY `FK_jadwal_matkul_master_ruangan` (`ruangan`),
  CONSTRAINT `FK_jadwal_matkul_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_matkul_master_ruangan` FOREIGN KEY (`ruangan`) REFERENCES `master_ruangan` (`ruangan_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.jadwal_matkul: ~0 rows (approximately)
DELETE FROM `jadwal_matkul`;
/*!40000 ALTER TABLE `jadwal_matkul` DISABLE KEYS */;
/*!40000 ALTER TABLE `jadwal_matkul` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.konversi_baru
CREATE TABLE IF NOT EXISTS `konversi_baru` (
  `id_konversiBaru` int(11) NOT NULL AUTO_INCREMENT,
  `nim` varchar(15) DEFAULT NULL,
  `id_rekapNilai` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_konversiBaru`),
  KEY `FK_konversi_baru_1` (`nim`),
  KEY `FK_konversi_baru_2` (`id_rekapNilai`),
  CONSTRAINT `FK_konversi_baru_1` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_konversi_baru_2` FOREIGN KEY (`id_rekapNilai`) REFERENCES `rekap_nilai` (`id_rekapNilai`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.konversi_baru: ~0 rows (approximately)
DELETE FROM `konversi_baru`;
/*!40000 ALTER TABLE `konversi_baru` DISABLE KEYS */;
/*!40000 ALTER TABLE `konversi_baru` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.konversi_lama
CREATE TABLE IF NOT EXISTS `konversi_lama` (
  `id_konversiLama` int(11) NOT NULL AUTO_INCREMENT,
  `nrk` varchar(50) DEFAULT '',
  `nama` varchar(45) DEFAULT '',
  `nim_lama` varchar(45) DEFAULT '',
  `pt_asal` varchar(45) DEFAULT '',
  `jenjang` varchar(45) DEFAULT '',
  `jurusan_asal` varchar(45) DEFAULT '',
  `status` varchar(45) DEFAULT '' COMMENT 'lulus/belum lulus',
  `kode_matkul_lama` varchar(45) DEFAULT '',
  `nama_matkul` varchar(45) DEFAULT '',
  `sks` int(10) DEFAULT '0',
  `nilai` varchar(45) DEFAULT '',
  PRIMARY KEY (`id_konversiLama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.konversi_lama: ~0 rows (approximately)
DELETE FROM `konversi_lama`;
/*!40000 ALTER TABLE `konversi_lama` DISABLE KEYS */;
/*!40000 ALTER TABLE `konversi_lama` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.krs
CREATE TABLE IF NOT EXISTS `krs` (
  `krs_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'tabel krs yang mengelola kaprodi',
  `nip` varchar(100) NOT NULL DEFAULT '' COMMENT 'dosen pengampu',
  `kode_matkul` varchar(100) NOT NULL DEFAULT '',
  `semester` varchar(50) NOT NULL DEFAULT '',
  `tahun_akademik` varchar(50) NOT NULL DEFAULT '',
  `id_master_jenjang` int(10) NOT NULL AUTO_INCREMENT,
  `kode_prodi` varchar(50) DEFAULT NULL,
  `id_master_kelas` int(10) unsigned DEFAULT NULL COMMENT 'a/b = untuk pembagian setiap kelas berbeda record ',
  `toleransi_keterlambatan` varchar(50) NOT NULL DEFAULT '0',
  `kaprodi` varchar(50) DEFAULT NULL COMMENT 'tanda tangan berita acara-inputnakhir',
  `ketua_kelas` varchar(50) DEFAULT NULL COMMENT 'tanda tangan berita acara',
  PRIMARY KEY (`krs_id`),
  KEY `FK_krs_master_jenjang` (`id_master_jenjang`),
  KEY `FK_krs_master_prodi` (`kode_prodi`),
  KEY `FK_krs_master_dosen` (`kaprodi`),
  KEY `FK_krs_master_mata_kuliah` (`kode_matkul`),
  KEY `FK_krs_master_dosen_2` (`nip`),
  KEY `FK_krs_master_kelas` (`id_master_kelas`),
  CONSTRAINT `FK_krs_master_dosen` FOREIGN KEY (`kaprodi`) REFERENCES `master_karyawan` (`nip`),
  CONSTRAINT `FK_krs_master_dosen_2` FOREIGN KEY (`nip`) REFERENCES `master_karyawan` (`nip`),
  CONSTRAINT `FK_krs_master_jenjang` FOREIGN KEY (`id_master_jenjang`) REFERENCES `master_jenjang` (`id_master_jenjang`),
  CONSTRAINT `FK_krs_master_kelas` FOREIGN KEY (`id_master_kelas`) REFERENCES `master_kelas` (`id_master_kelas`),
  CONSTRAINT `FK_krs_master_mata_kuliah` FOREIGN KEY (`kode_matkul`) REFERENCES `master_mata_kuliah` (`kode_matkul`),
  CONSTRAINT `FK_krs_master_prodi` FOREIGN KEY (`kode_prodi`) REFERENCES `master_prodi` (`kode_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.krs: ~0 rows (approximately)
DELETE FROM `krs`;
/*!40000 ALTER TABLE `krs` DISABLE KEYS */;
/*!40000 ALTER TABLE `krs` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.login
CREATE TABLE IF NOT EXISTS `login` (
  `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT '',
  `password` varchar(100) DEFAULT '',
  `penginput` varchar(100) DEFAULT '',
  `master_hak_akses_id` int(10) DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) DEFAULT '0' COMMENT 'untuk cekal krs, 1.aktif 2.tercekal',
  PRIMARY KEY (`login_id`),
  KEY `FK_login_master_hak_akses` (`master_hak_akses_id`),
  CONSTRAINT `FK_login_master_hak_akses` FOREIGN KEY (`master_hak_akses_id`) REFERENCES `master_hak_akses` (`master_hak_akses_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.login: ~186 rows (approximately)
DELETE FROM `login`;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` (`login_id`, `username`, `password`, `penginput`, `master_hak_akses_id`, `last_login`, `status`) VALUES
	(3, '17.31.0001', '4603', 'Admin', 7, '2020-12-02 19:33:15', 0),
	(4, '17.31.0002', '1961', '', NULL, '2020-12-02 19:33:15', 0),
	(5, '17.31.0003', '3685', '', NULL, '2020-12-02 19:33:15', 0),
	(6, '17.31.0004', '1274', '', NULL, '2020-12-02 19:33:15', 0),
	(7, '17.31.0005', '5998', '', NULL, '2020-12-02 19:33:15', 0),
	(8, '17.31.0006', '4108', '', NULL, '2020-12-02 19:33:15', 0),
	(9, '17.31.0007', '8560', '', NULL, '2020-12-02 19:33:15', 0),
	(10, '17.51.0001', '2544', '', NULL, '2020-12-02 19:33:15', 0),
	(11, '17.51.0002', '3960', '', NULL, '2020-12-02 19:33:15', 0),
	(12, '17.51.0003', '4350', '', NULL, '2020-12-02 19:33:15', 0),
	(13, '17.51.0004', '5620', '', NULL, '2020-12-02 19:33:15', 0),
	(14, '17.51.0005', '9759', '', NULL, '2020-12-02 19:33:15', 0),
	(15, '17.51.0006', '7111', '', NULL, '2020-12-02 19:33:15', 0),
	(16, '17.51.0007', '6277', '', NULL, '2020-12-02 19:33:15', 0),
	(17, '17.51.0008', '5400', '', NULL, '2020-12-02 19:33:15', 0),
	(18, '17.51.0009', '1441', '', NULL, '2020-12-02 19:33:15', 0),
	(19, '17.51.0010', '7041', '', NULL, '2020-12-02 19:33:15', 0),
	(20, '17.51.0011', '8840', '', NULL, '2020-12-02 19:33:15', 0),
	(21, '17.51.0012', '3295', '', NULL, '2020-12-02 19:33:15', 0),
	(22, '17.51.0013', '3826', '', NULL, '2020-12-02 19:33:15', 0),
	(23, '17.51.0014', '9244', '', NULL, '2020-12-02 19:33:15', 0),
	(24, '17.51.0015', '4743', '', NULL, '2020-12-02 19:33:15', 0),
	(25, '17.51.0016', '5983', '', NULL, '2020-12-02 19:33:15', 0),
	(26, '17.51.0017', '5688', '', NULL, '2020-12-02 19:33:15', 0),
	(27, '17.51.0018', '4920', '', NULL, '2020-12-02 19:33:15', 0),
	(28, '17.51.0019', '5397', '', NULL, '2020-12-02 19:33:16', 0),
	(29, '17.51.0020', '5510', '', NULL, '2020-12-02 19:33:16', 0),
	(30, '17.51.0021', '1358', '', NULL, '2020-12-02 19:33:16', 0),
	(31, '17.51.0022', '2590', '', NULL, '2020-12-02 19:33:16', 0),
	(32, '17.51.0023', '7222', '', NULL, '2020-12-02 19:33:16', 0),
	(33, '17.51.0024', '5336', '', NULL, '2020-12-02 19:33:16', 0),
	(34, '17.51.0025', '5013', '', NULL, '2020-12-02 19:33:16', 0),
	(35, '17.51.0026', '9058', '', NULL, '2020-12-02 19:33:16', 0),
	(36, '17.51.0027', '2510', '', NULL, '2020-12-02 19:33:16', 0),
	(37, '17.51.0069', '8377', '', NULL, '2020-12-02 19:33:16', 0),
	(38, '17.52.0001', '4082', '', NULL, '2020-12-02 19:33:16', 0),
	(39, '17.52.0002', '9659', '', NULL, '2020-12-02 19:33:16', 0),
	(40, '17.52.0003', '6048', '', NULL, '2020-12-02 19:33:16', 0),
	(41, '17.52.0004', '1264', '', NULL, '2020-12-02 19:33:16', 0),
	(42, '17.52.0005', '8177', '', NULL, '2020-12-02 19:33:16', 0),
	(43, '17.52.0006', '7094', '', NULL, '2020-12-02 19:33:16', 0),
	(44, '17.52.0007', '9410', '', NULL, '2020-12-02 19:33:16', 0),
	(45, '17.52.0008', '3421', '', NULL, '2020-12-02 19:33:16', 0),
	(46, '17.52.0009', '4285', '', NULL, '2020-12-02 19:33:16', 0),
	(47, '17.52.0010', '1161', '', NULL, '2020-12-02 19:33:16', 0),
	(48, '17.52.0011', '2952', '', NULL, '2020-12-02 19:33:16', 0),
	(49, '17.52.0012', '1279', '', NULL, '2020-12-02 19:33:16', 0),
	(50, '17.52.0013', '7536', '', NULL, '2020-12-02 19:33:16', 0),
	(51, '17.52.0014', '3846', '', NULL, '2020-12-02 19:33:16', 0),
	(52, '17.52.0015', '6621', '', NULL, '2020-12-02 19:33:16', 0),
	(53, '17.52.0016', '1568', '', NULL, '2020-12-02 19:33:16', 0),
	(54, '17.52.0017', '7979', '', NULL, '2020-12-02 19:33:16', 0),
	(55, '17.52.0018', '5189', '', NULL, '2020-12-02 19:33:16', 0),
	(56, '17.52.0019', '2011', '', NULL, '2020-12-02 19:33:16', 0),
	(57, '17.52.0020', '4488', '', NULL, '2020-12-02 19:33:16', 0),
	(58, '17.52.0021', '6406', '', NULL, '2020-12-02 19:33:16', 0),
	(59, '17.52.0022', '8569', '', NULL, '2020-12-02 19:33:16', 0),
	(60, '17.52.0023', '3627', '', NULL, '2020-12-02 19:33:16', 0),
	(61, '17.52.0024', '2428', '', NULL, '2020-12-02 19:33:16', 0),
	(62, '17.52.0025', '1261', '', NULL, '2020-12-02 19:33:16', 0),
	(63, '17.52.0026', '1234', '', NULL, '2020-12-02 19:33:16', 0),
	(64, '18.31.0001', '3131', '', NULL, '2020-12-02 19:40:30', 0),
	(65, '18.31.0002', '1397', '', NULL, '2020-12-02 19:40:30', 0),
	(66, '18.31.0003', '3752', '', NULL, '2020-12-02 19:40:30', 0),
	(67, '18.31.0006', '5831', '', NULL, '2020-12-02 19:40:30', 0),
	(68, '18.31.0007', '1962', '', NULL, '2020-12-02 19:40:31', 0),
	(69, '18.31.0008', '6904', '', NULL, '2020-12-02 19:40:31', 0),
	(70, '18.31.0009', '4754', '', NULL, '2020-12-02 19:40:31', 0),
	(71, '18.31.0010', '2873', '', NULL, '2020-12-02 19:40:31', 0),
	(72, '18.31.0011', '5691', '', NULL, '2020-12-02 19:40:31', 0),
	(73, '18.31.0012', '5730', '', NULL, '2020-12-02 19:40:31', 0),
	(74, '18.31.0014', '9504', '', NULL, '2020-12-02 19:40:31', 0),
	(75, '18.31.0016', '2312', '', NULL, '2020-12-02 19:40:31', 0),
	(76, '18.51.0001', '3094', '', NULL, '2020-12-02 19:40:31', 0),
	(77, '18.51.0002', '6951', '', NULL, '2020-12-02 19:40:31', 0),
	(78, '18.51.0003', '5917', '', NULL, '2020-12-02 19:40:31', 0),
	(79, '18.51.0004', '7823', '', NULL, '2020-12-02 19:40:31', 0),
	(80, '18.51.0005', '1849', '', NULL, '2020-12-02 19:40:31', 0),
	(81, '18.51.0006', '6841', '', NULL, '2020-12-02 19:40:31', 0),
	(82, '18.51.0007', '2619', '', NULL, '2020-12-02 19:40:31', 0),
	(83, '18.51.0008', '5724', '', NULL, '2020-12-02 19:40:31', 0),
	(84, '18.51.0009', '9524', '', NULL, '2020-12-02 19:40:31', 0),
	(85, '18.51.0010', '5743', '', NULL, '2020-12-02 19:40:31', 0),
	(86, '18.51.0011', '8596', '', NULL, '2020-12-02 19:40:31', 0),
	(87, '18.51.0012', '7452', '', NULL, '2020-12-02 19:40:31', 0),
	(88, '18.51.0013', '1694', '', NULL, '2020-12-02 19:40:31', 0),
	(89, '18.51.0014', '5428', '', NULL, '2020-12-02 19:40:31', 0),
	(90, '18.51.0015', '1905', '', NULL, '2020-12-02 19:40:31', 0),
	(91, '18.51.0016', '5386', '', NULL, '2020-12-02 19:40:31', 0),
	(92, '18.51.0017', '3905', '', NULL, '2020-12-02 19:40:31', 0),
	(93, '18.51.0018', '2469', '', NULL, '2020-12-02 19:40:31', 0),
	(94, '18.51.0020', '5386', '', NULL, '2020-12-02 19:40:31', 0),
	(95, '18.51.0021', '3701', '', NULL, '2020-12-02 19:40:31', 0),
	(96, '18.51.0022', '5296', '', NULL, '2020-12-02 19:40:31', 0),
	(97, '18.51.0023', '9896', '', NULL, '2020-12-02 19:40:31', 0),
	(98, '18.51.0024', '1803', '', NULL, '2020-12-02 19:40:31', 0),
	(99, '18.51.0025', '2968', '', NULL, '2020-12-02 19:40:31', 0),
	(100, '18.51.0026', '3681', '', NULL, '2020-12-02 19:40:31', 0),
	(101, '18.51.0027', '4729', '', NULL, '2020-12-02 19:40:31', 0),
	(102, '18.51.0028', '3847', '', NULL, '2020-12-02 19:40:31', 0),
	(103, '18.51.0029', '4792', '', NULL, '2020-12-02 19:40:31', 0),
	(104, '18.51.0030', '984', '', NULL, '2020-12-02 19:40:31', 0),
	(105, '18.51.0031', '5689', '', NULL, '2020-12-02 19:40:31', 0),
	(106, '18.51.0032', '3629', '', NULL, '2020-12-02 19:40:31', 0),
	(107, '18.51.0033', '2579', '', NULL, '2020-12-02 19:40:31', 0),
	(108, '18.51.0078', '8359', '', NULL, '2020-12-02 19:40:31', 0),
	(109, '18.51.0079', '4428', '', NULL, '2020-12-02 19:40:32', 0),
	(110, '18.51.0080', '3397', '', NULL, '2020-12-02 19:40:32', 0),
	(111, '18.51.0081', '2449', '', NULL, '2020-12-02 19:40:32', 0),
	(112, '18.51.0082', '2211', '', NULL, '2020-12-02 19:40:32', 0),
	(113, '18.51.0083', '2795', '', NULL, '2020-12-02 19:40:32', 0),
	(114, '18.52.0001', '4268', '', NULL, '2020-12-02 19:40:32', 0),
	(115, '18.52.0002', '2479', '', NULL, '2020-12-02 19:40:32', 0),
	(116, '18.52.0003', '2322', '', NULL, '2020-12-02 19:40:32', 0),
	(117, '18.52.0004', '3590', '', NULL, '2020-12-02 19:40:32', 0),
	(118, '18.52.0005', '2468', '', NULL, '2020-12-02 19:40:32', 0),
	(119, '18.52.0006', '4956', '', NULL, '2020-12-02 19:40:32', 0),
	(120, '18.52.0007', '5670', '', NULL, '2020-12-02 19:40:32', 0),
	(121, '18.52.0008', '3579', '', NULL, '2020-12-02 19:40:32', 0),
	(122, '18.52.0009', '5791', '', NULL, '2020-12-02 19:40:32', 0),
	(123, '18.52.0010', '5693', '', NULL, '2020-12-02 19:40:32', 0),
	(124, '18.52.0011', '6793', '', NULL, '2020-12-02 19:40:32', 0),
	(125, '18.52.0012', '5748', '', NULL, '2020-12-02 19:40:32', 0),
	(126, '18.52.0013', '2123', '', NULL, '2020-12-02 19:40:32', 0),
	(127, '18.52.0014', '5671', '', NULL, '2020-12-02 19:40:32', 0),
	(128, '18.52.0015', '4629', '', NULL, '2020-12-02 19:40:32', 0),
	(129, '18.52.0017', '9304', '', NULL, '2020-12-02 19:40:32', 0),
	(130, '18.52.0019', '3487', '', NULL, '2020-12-02 19:40:32', 0),
	(131, '18.52.0020', '5487', '', NULL, '2020-12-02 19:40:32', 0),
	(132, '18.52.0021', '3495', '', NULL, '2020-12-02 19:40:32', 0),
	(133, '18.52.0022', '4631', '', NULL, '2020-12-02 19:40:32', 0),
	(134, '18.52.0023', '5704', '', NULL, '2020-12-02 19:40:32', 0),
	(135, '18.52.0024', '5763', '', NULL, '2020-12-02 19:40:32', 0),
	(136, '18.52.0026', '4639', '', NULL, '2020-12-02 19:40:32', 0),
	(137, '18.52.0027', '4532', '', NULL, '2020-12-02 19:40:32', 0),
	(138, '18.52.0028', '7413', '', NULL, '2020-12-02 19:40:32', 0),
	(139, '18.52.0029', '8963', '', NULL, '2020-12-02 19:40:32', 0),
	(140, '19.31.0001', '2384', '', NULL, '2020-12-02 19:41:29', 0),
	(141, '19.31.0002', '2465', '', NULL, '2020-12-02 19:41:29', 0),
	(142, '19.31.0003', '1472', '', NULL, '2020-12-02 19:41:29', 0),
	(143, '19.31.0004', '1135', '', NULL, '2020-12-02 19:41:29', 0),
	(144, '19.31.0005', '3495', '', NULL, '2020-12-02 19:41:29', 0),
	(145, '19.31.0006', '5434', '', NULL, '2020-12-02 19:41:29', 0),
	(146, '19.31.0007', '2257', '', NULL, '2020-12-02 19:41:29', 0),
	(147, '19.31.0008', '1453', '', NULL, '2020-12-02 19:41:29', 0),
	(148, '19.31.0009', '2277', '', NULL, '2020-12-02 19:41:29', 0),
	(149, '19.31.0010', '7422', '', NULL, '2020-12-02 19:41:29', 0),
	(150, '19.31.0011', '1116', '', NULL, '2020-12-02 19:41:29', 0),
	(151, '19.31.0012', '1705', '', NULL, '2020-12-02 19:41:29', 0),
	(152, '19.51.0001', '9984', '', NULL, '2020-12-02 19:41:29', 0),
	(153, '19.51.0002', '1437', '', NULL, '2020-12-02 19:41:29', 0),
	(154, '19.51.0003', '3364', '', NULL, '2020-12-02 19:41:29', 0),
	(155, '19.51.0004', '9755', '', NULL, '2020-12-02 19:41:29', 0),
	(156, '19.51.0005', '5541', '', NULL, '2020-12-02 19:41:29', 0),
	(157, '19.51.0006', '1004', '', NULL, '2020-12-02 19:41:29', 0),
	(158, '19.51.0007', '4630', '', NULL, '2020-12-02 19:41:29', 0),
	(159, '19.51.0008', '4221', '', NULL, '2020-12-02 19:41:29', 0),
	(160, '19.51.0009', '5432', '', NULL, '2020-12-02 19:41:29', 0),
	(161, '19.51.0010', '1574', '', NULL, '2020-12-02 19:41:29', 0),
	(162, '19.51.0011', '1432', '', NULL, '2020-12-02 19:41:29', 0),
	(163, '19.51.0012', '4557', '', NULL, '2020-12-02 19:41:29', 0),
	(164, '19.51.0013', '3601', '', NULL, '2020-12-02 19:41:29', 0),
	(165, '19.51.0014', '1650', '', NULL, '2020-12-02 19:41:29', 0),
	(166, '19.51.0015', '4596', '', NULL, '2020-12-02 19:41:30', 0),
	(167, '19.51.0016', '9964', '', NULL, '2020-12-02 19:41:30', 0),
	(168, '19.51.0017', '2534', '', NULL, '2020-12-02 19:41:30', 0),
	(169, '19.51.0018', '4567', '', NULL, '2020-12-02 19:41:30', 0),
	(170, '19.51.0019', '4467', '', NULL, '2020-12-02 19:41:30', 0),
	(171, '19.51.0020', '3892', '', NULL, '2020-12-02 19:41:30', 0),
	(172, '19.51.0021', '3346', '', NULL, '2020-12-02 19:41:30', 0),
	(173, '19.51.0022', '3452', '', NULL, '2020-12-02 19:41:30', 0),
	(174, '19.51.0023', '1273', '', NULL, '2020-12-02 19:41:30', 0),
	(175, '19.51.0024', '1304', '', NULL, '2020-12-02 19:41:30', 0),
	(176, '19.51.0025', '1450', '', NULL, '2020-12-02 19:41:30', 0),
	(177, '19.51.0026', '3941', '', NULL, '2020-12-02 19:41:30', 0),
	(178, '19.51.0027', '4540', '', NULL, '2020-12-02 19:41:30', 0),
	(179, '19.51.0028', '7584', '', NULL, '2020-12-02 19:41:30', 0),
	(180, '19.51.0029', '5129', '', NULL, '2020-12-02 19:41:30', 0),
	(181, '19.52.0001', '4727', '', NULL, '2020-12-02 19:41:30', 0),
	(182, '19.52.0002', '6579', '', NULL, '2020-12-02 19:41:30', 0),
	(183, '19.52.0003', '3574', '', NULL, '2020-12-02 19:41:30', 0),
	(184, '19.52.0004', '9514', '', NULL, '2020-12-02 19:41:30', 0),
	(185, '19.52.0005', '7896', '', NULL, '2020-12-02 19:41:30', 0),
	(186, '19.52.0006', '3247', '', NULL, '2020-12-02 19:41:30', 0),
	(187, '19.52.0007', '1103', '', NULL, '2020-12-02 19:41:30', 0),
	(188, '19.52.0008', '9910', '', NULL, '2020-12-02 19:41:30', 0);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_biaya
CREATE TABLE IF NOT EXISTS `master_biaya` (
  `biaya_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL COMMENT 'spp/dpp',
  `angkatan` varchar(15) NOT NULL,
  `kelas` varchar(50) DEFAULT NULL,
  `jenjang` varchar(50) DEFAULT NULL,
  `jumlah` float NOT NULL COMMENT 'jumlah per 1 sks & dpp',
  PRIMARY KEY (`biaya_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_biaya: ~51 rows (approximately)
DELETE FROM `master_biaya`;
/*!40000 ALTER TABLE `master_biaya` DISABLE KEYS */;
INSERT INTO `master_biaya` (`biaya_id`, `nama`, `angkatan`, `kelas`, `jenjang`, `jumlah`) VALUES
	(1, 'spp', '2017', 'pagi', 'D3', 850000),
	(2, 'sks', '2017', 'pagi', 'D3', 85000),
	(3, 'spp', '2018', 'pagi', 'D3', 3000000),
	(4, 'spp', '2019', 'pagi', 'D3', 3000000),
	(5, 'spp', '2020', 'pagi', 'D3', 3000000),
	(6, 'spp', '2017', 'pagi', 'S1', 1000000),
	(7, 'spp', '2018', 'pagi', 'S1', 4500000),
	(8, 'spp', '2019', 'pagi', 'S1', 4800000),
	(9, 'spp', '2020', 'pagi', 'S1', 4800000),
	(10, 'sks', '2017', 'pagi', 'S1', 125000),
	(11, 'spp', '2017', 'malam', 'S1', 1150000),
	(12, 'spp', '2018', 'malam', 'S1', 4750000),
	(13, 'spp', '2019', 'malam', 'S1', 5100000),
	(14, 'spp', '2020', 'malam', 'S1', 5100000),
	(15, 'sks', '2017', 'malam', 'S1', 135000),
	(16, 'Dpp Gelombang 1', '2017', 'pagi', 'D3', 2500000),
	(17, 'Dpp Gelombang 1', '2017', 'pagi ', 'S1', 6500000),
	(18, 'Dpp Gelombang 1 ', '2017', 'malam', 'S1', 6500000),
	(19, 'Dpp Gelombang 2', '2017', 'Pagi', 'D3', 3000000),
	(20, 'Dpp Gelombang 2', '2017', 'pagi', 'S1', 7000000),
	(21, 'Dpp Gelombang 2', '2017', 'malam', 'S1', 7000000),
	(22, 'Dpp Gelombang 3', '2017', 'Pagi', 'D3', 3500000),
	(23, 'Dpp Gelombang 3', '2017', 'pagi', 'S1', 7500000),
	(24, 'Dpp Gelombang 3', '2017', 'malam', 'S1', 7500000),
	(25, 'Dpp Gelombang 1', '2018', 'Pagi', 'D3', 2500000),
	(26, 'Dpp Gelombang 1', '2018', 'Pagi', 'S1', 2500000),
	(27, 'Dpp Gelombang 1', '2018', 'Malam', 'S1', 2500000),
	(28, 'Dpp Gelombang 2', '2018', 'Pagi', 'D3', 3000000),
	(29, 'Dpp Gelombang 2', '2018', 'Pagi', 'S1', 3000000),
	(30, 'Dpp Gelombang 2', '2018', 'Malam', 'S1', 3000000),
	(31, 'Dpp Gelombang 3', '2018', 'Pagi', 'D3', 3500000),
	(32, 'Dpp Gelombang 3', '2018', 'Pagi', 'S1', 3500000),
	(33, 'Dpp Gelombang 3', '2018', 'Malam', 'S1', 3500000),
	(34, 'Dpp Gelombang 1', '2019', 'Pagi', 'D3', 5000000),
	(35, 'Dpp Gelombang 1', '2019', 'Pagi', 'S1', 5000000),
	(36, 'Dpp Gelombang 1', '2019', 'Malam', 'S1', 5000000),
	(37, 'Dpp Gelombang 2', '2019', 'Pagi', 'D3', 5500000),
	(38, 'Dpp Gelombang 2', '2019', 'Pagi', 'S1', 5500000),
	(39, 'Dpp Gelombang 2', '2019', 'Malam', 'S1', 5500000),
	(40, 'Dpp Gelombang 3', '2019', 'Pagi', 'D3', 6000000),
	(41, 'Dpp Gelombang 3', '2019', 'Pagi', 'S1', 6000000),
	(42, 'Dpp Gelombang 3', '2019', 'Malam', 'S1', 6000000),
	(43, 'Dpp Gelombang 1', '2020', 'Pagi', 'D3', 5000000),
	(44, 'Dpp Gelombang 1', '2020', 'Pagi', 'S1', 5000000),
	(45, 'Dpp Gelombang 1', '2020', 'Malam', 'S1', 5000000),
	(46, 'Dpp Gelombang 2', '2020', 'Pagi', 'D3', 5500000),
	(47, 'Dpp Gelombang 2', '2020', 'Pagi', 'S1', 5500000),
	(48, 'Dpp Gelombang 2', '2020', 'Malam', 'S1', 5500000),
	(49, 'Dpp Gelombang 3', '2020', 'Pagi', 'D3', 6000000),
	(50, 'Dpp Gelombang 3', '2020', 'Pagi', 'S1', 6000000),
	(51, 'Dpp Gelombang 3', '2020', 'Malam', 'S1', 6000000);
/*!40000 ALTER TABLE `master_biaya` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_bobot_nilai
CREATE TABLE IF NOT EXISTS `master_bobot_nilai` (
  `bobot_nilai_id` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` varchar(15) DEFAULT NULL,
  `indeks` float DEFAULT NULL,
  `predikat` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bobot_nilai_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_bobot_nilai: ~10 rows (approximately)
DELETE FROM `master_bobot_nilai`;
/*!40000 ALTER TABLE `master_bobot_nilai` DISABLE KEYS */;
INSERT INTO `master_bobot_nilai` (`bobot_nilai_id`, `nilai`, `indeks`, `predikat`) VALUES
	(1, 'A', 4, 'Sangat Memuaskan'),
	(2, 'A-', 3.75, 'Memuaskan'),
	(3, 'B', 3, 'Baik'),
	(4, 'B+', 3.5, 'Baik'),
	(5, 'B-', 2.75, 'Baik'),
	(6, 'C', 2, 'Cukup'),
	(7, 'C+', 2.5, 'Cukup'),
	(8, 'C-', 1.75, 'Cukup'),
	(9, 'D', 1, 'Kurang'),
	(10, 'E', 0, 'Sangat Kurang');
/*!40000 ALTER TABLE `master_bobot_nilai` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_hak_akses
CREATE TABLE IF NOT EXISTS `master_hak_akses` (
  `master_hak_akses_id` int(10) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`master_hak_akses_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_hak_akses: ~8 rows (approximately)
DELETE FROM `master_hak_akses`;
/*!40000 ALTER TABLE `master_hak_akses` DISABLE KEYS */;
INSERT INTO `master_hak_akses` (`master_hak_akses_id`, `nama`) VALUES
	(1, 'Puskordat'),
	(2, 'Kaprodi TI'),
	(3, 'Kaprodi SI'),
	(4, 'Sekretaris Kaprodi TI'),
	(5, 'Sekretaris Kaprodi SI'),
	(6, 'Bauk'),
	(7, 'Mahasiswa'),
	(8, 'Dosen'),
	(9, 'pmb'),
	(10, 'baak');
/*!40000 ALTER TABLE `master_hak_akses` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_jabatan_karyawan
CREATE TABLE IF NOT EXISTS `master_jabatan_karyawan` (
  `jabatan_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`jabatan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_jabatan_karyawan: ~13 rows (approximately)
DELETE FROM `master_jabatan_karyawan`;
/*!40000 ALTER TABLE `master_jabatan_karyawan` DISABLE KEYS */;
INSERT INTO `master_jabatan_karyawan` (`jabatan_id`, `nama`) VALUES
	(1, 'Ketua'),
	(2, 'Waka STMIK'),
	(3, 'BAJAMU'),
	(4, 'Ketua Prodi Teknologi Informasi'),
	(5, 'Sekretaris Prodi Teknologi Informasi'),
	(6, 'Ketua Prodi Sistem Informasi'),
	(7, 'Sekretaris Prodi Sistem Informasi'),
	(8, 'Kepala BAUK'),
	(9, 'Kabag Kepegawaian'),
	(10, 'Kabag Rumah Umum dan Rumah Tangga'),
	(11, 'Kepala BAAK'),
	(12, 'Kabag Akademik dan Data'),
	(13, 'Kabag Kemahasiswaan dan Alumni'),
	(14, 'OB');
/*!40000 ALTER TABLE `master_jabatan_karyawan` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_jenis_pembayaran
CREATE TABLE IF NOT EXISTS `master_jenis_pembayaran` (
  `id_master_jenis_pembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`id_master_jenis_pembayaran`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_jenis_pembayaran: ~2 rows (approximately)
DELETE FROM `master_jenis_pembayaran`;
/*!40000 ALTER TABLE `master_jenis_pembayaran` DISABLE KEYS */;
INSERT INTO `master_jenis_pembayaran` (`id_master_jenis_pembayaran`, `nama`) VALUES
	(1, 'Tunai'),
	(2, 'Transfer');
/*!40000 ALTER TABLE `master_jenis_pembayaran` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_jenjang
CREATE TABLE IF NOT EXISTS `master_jenjang` (
  `id_master_jenjang` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_master_jenjang`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_jenjang: ~2 rows (approximately)
DELETE FROM `master_jenjang`;
/*!40000 ALTER TABLE `master_jenjang` DISABLE KEYS */;
INSERT INTO `master_jenjang` (`id_master_jenjang`, `nama`) VALUES
	(1, 'S1'),
	(2, 'D3');
/*!40000 ALTER TABLE `master_jenjang` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_kalender_akademik
CREATE TABLE IF NOT EXISTS `master_kalender_akademik` (
  `kalender_akademik_id` int(11) NOT NULL AUTO_INCREMENT,
  `kegiatan` varchar(100) DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_akhir` date DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kalender_akademik_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_kalender_akademik: ~0 rows (approximately)
DELETE FROM `master_kalender_akademik`;
/*!40000 ALTER TABLE `master_kalender_akademik` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_kalender_akademik` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_karyawan
CREATE TABLE IF NOT EXISTS `master_karyawan` (
  `nip` varchar(100) NOT NULL,
  `nidn` varchar(100) DEFAULT '',
  `nama` varchar(100) DEFAULT NULL,
  `alamat_asal` varchar(100) DEFAULT NULL,
  `alamat_domisili` varchar(100) DEFAULT NULL,
  `no_telp` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `keahlian` varchar(100) DEFAULT NULL,
  `home_base` varchar(100) DEFAULT NULL,
  `jafa_id` int(11) DEFAULT NULL,
  `jabatan_id` int(11) DEFAULT NULL,
  `status_dosen_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nip`),
  KEY `FK_dosen_3` (`status_dosen_id`),
  KEY `FK_master_dosen_master_jafa_dosen` (`jafa_id`),
  KEY `FK_master_dosen_master_jabatan_karyawan` (`jabatan_id`),
  CONSTRAINT `FK_dosen_3` FOREIGN KEY (`status_dosen_id`) REFERENCES `master_status_dosen` (`status_dosen_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_master_dosen_master_jabatan_karyawan` FOREIGN KEY (`jabatan_id`) REFERENCES `master_jabatan_karyawan` (`jabatan_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_master_dosen_master_jafa_dosen` FOREIGN KEY (`jafa_id`) REFERENCES `master_pangkat_dosen` (`jafa_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_karyawan: ~62 rows (approximately)
DELETE FROM `master_karyawan`;
/*!40000 ALTER TABLE `master_karyawan` DISABLE KEYS */;
INSERT INTO `master_karyawan` (`nip`, `nidn`, `nama`, `alamat_asal`, `alamat_domisili`, `no_telp`, `email`, `tempat_lahir`, `tgl_lahir`, `keahlian`, `home_base`, `jafa_id`, `jabatan_id`, `status_dosen_id`) VALUES
	('00.12.01.001', '0702046705', 'Sapta Aji Sri Margiutomo, S.Kom., M.M.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.002', '0707087301', 'Dr. Tubagus Mohammad Akhriza, S.Si., MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.004', '0714067301', 'Eni Farida, S.Ag., M.M.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.006', '0726086802', 'Rahayu Widayanti, S.E., M.M.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.008', '0717106702', 'Jauharul Maknunah, S.E., M.M.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.009', '0004077304', 'Dr. Khoerul Anwar, S.T., M.T.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.010', '0726037401', 'Sujito, S.Kom., M.Pd.MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.011', '0716087501', 'Mahmud Yunus, S.Kom., M.Pd. MT.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.015', '', 'Ali Qody, S.S.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.016', '0721107902', 'Dwi Safiroh Utsalina, S.Kom.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.019', '0712027801', 'Fitri Marisa, S.Kom., M.Pd.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.023', '0728047403', 'Syahminan, S.Kom., M.Kom.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.025', '0718067401', 'Sigit Setyowibowo, S.T.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.106', '0729096803', 'Teguh Santoso, M.Pd.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('00.12.01.107', '0718047402', 'Dita Savitri, S.Pd.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('01.09.10.036', '0728056102', 'Mochamad Husni, S.Pd.I., M.M.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('01.10.01.037', '0715017701', 'Dr. Indah Dwi Mumpuni, S.Kom., M.M.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('02.04.01.127', '0024085407', 'Drs. Widjianto, M.Kom.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('02.08.01.043', '0702027805', 'Heri Purnomo, S.Kom.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('02.10.01.130', '0706047102', 'Sri Esti Trisno Sami., S.T.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('03.12.01.013', '0716046802', 'Retno Sundari, S.Pd., M.M.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('04.10.20.002', '', 'Erfandi Hermawanto, S.Pd.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('05.03.02.004', '0728117001', 'Mohamad As\'ad, S.Si., M.Si.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('06.02.25.036', '0730118201', 'Luqman Affandi, S.Kom., MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('06.09.18.006', '0717017304', 'Antonius Duty Susilo, S.Pd., M.T.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('07.01.02.001', '0708097603', 'Evy Sophia, S.Pd.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('07.05.21.011', '', 'Amelia Rumbiak', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('07.09.18.013', '0705048105', 'Meme Susilowati, S.Kom., MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('07.09.18.014', '0027026903', 'Daeng Achmad Suaidi, S.Si., M.Kom', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('08.03.10.003', '0711048202', 'Andri Prasetyo, S.E.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('09.03.16.106', '0712047201', 'Zuraidah, M.Si.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('09.03.25.001', '0702108502', 'Dian Wahyuningsih, S.Kom.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('09.09.07.109', '0022126206', 'Drs. Slamet, M.Si.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('09.09.07.112', '0710108001', 'Roesdy Adham Trilaksono, S.Kom.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('10.03.15.103', '0009088107', 'Banni Satria Andoko, S.Kom., MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('11.03.21.002', '0713027803', 'Eko Teguh Triwisuda, M.T.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('11.03.21.004', '', 'Ratna Suita, S.Pd.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('11.03.21.005', '0014047705', 'Rekyan Regasari, M.T.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('11.05.25.001', '0706077901', 'Dinny Wahyu Widarti, S.Kom.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('11.05.25.003', '0717038602', 'Linda Suvi Rahmawati, S.Kom.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('11.09.19.001', '0721037701', 'Gede Arka Puniatmaja, M.Kom.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('11.10.25.004', '0705058007', 'Samsul Arifin, S.Kom.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('12.03.25.101', '', 'Yansina Yudit Unimera, M.A., M.Th.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('13.03.25.001', '', 'Syahroni, S.Kom', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('13.09.25.003', '', 'Saatul Ihsan, S.Kom.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('13.09.25.004', '', 'Moh. Ahsan, S.Kom.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('13.09.25.005', '', 'Vita Kusumasari, M.Pd.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.02.25.001', '0710119101', 'Ali Syaifulloh, S.Kom.,MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.02.25.002', '0710028901', 'Nasrul Firdaus, S.Kom.,MMSI', 'Jalan Pondok RT 03/RW05 Paciran Lamongan', 'Perumahan Mondoroko Raya Blok GH 6 No 101 Singosari Malang', '+6285649602435', 'nasrul@stimata.ac.id', 'Lamongan', '1989-02-10', NULL, NULL, NULL, NULL, NULL),
	('14.02.25.003', '0725118406', 'Dr. Weda Adistianaya Dewa, S.Kom., MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.02.25.004', '0709028901', 'Liduina Asih Primandari, S.Si., M.Si', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.03.25.101', '', 'Hanavi, M.Th', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.04.25.101', '', 'Arif Saivul Afandi, S.Kom.,MM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.05.25.102', '', 'Dr. Aviananta Tarigan, ST', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.10.25.101', '', 'Tatik, M.Pd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.10.25.102', '', 'Fatkhur Rohman, S.ST., MT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('14.10.25.103', '', 'Sofyan Arifianto, S.Si.,M.Kom', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('15.03.25.101', '', 'Erwin Tjipta Wijaya, S.T., M.Kom', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('15.09.25.102', '', 'Doddy Maulana, SE.,M.T.,MSc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('16.09.19.001', '0710069002', 'Eka Yuniar, S.Kom., MMSI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('18.07.30.001', '', 'Muhammad Ali Agung Baroto, S.Pd., M.Pd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('19.09.01.003', '', 'Rendhi Fatrisna Yuniar, M.Pd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `master_karyawan` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_kelas
CREATE TABLE IF NOT EXISTS `master_kelas` (
  `id_master_kelas` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_master_kelas`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_kelas: ~2 rows (approximately)
DELETE FROM `master_kelas`;
/*!40000 ALTER TABLE `master_kelas` DISABLE KEYS */;
INSERT INTO `master_kelas` (`id_master_kelas`, `nama`) VALUES
	(1, 'A'),
	(2, 'B'),
	(3, 'C');
/*!40000 ALTER TABLE `master_kelas` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_maba
CREATE TABLE IF NOT EXISTS `master_maba` (
  `no_pendaftaran` varchar(50) NOT NULL,
  `nik` int(11) DEFAULT '0',
  `nama` varchar(100) DEFAULT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `alamat_domisili` varchar(100) DEFAULT NULL,
  `alamat_asal` varchar(100) DEFAULT NULL,
  `tahun_masuk` int(11) DEFAULT NULL,
  `jenis_kelamin` tinyint(1) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `nama_ayah` varchar(50) DEFAULT NULL,
  `agama` varchar(100) DEFAULT NULL,
  `asal_sekolah` varchar(100) DEFAULT NULL,
  `alamat_asal_sekolah` varchar(100) DEFAULT NULL,
  `jurusan_asal_sekolah` varchar(100) DEFAULT NULL,
  `danem` varchar(15) DEFAULT NULL,
  `status_daftar_mhs_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`no_pendaftaran`),
  KEY `FK_master_maba_master_status_daftar_mhs` (`status_daftar_mhs_id`),
  CONSTRAINT `FK_master_maba_master_status_daftar_mhs` FOREIGN KEY (`status_daftar_mhs_id`) REFERENCES `master_status_daftar_mhs` (`status_daftar_mhs_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_maba: ~8 rows (approximately)
DELETE FROM `master_maba`;
/*!40000 ALTER TABLE `master_maba` DISABLE KEYS */;
INSERT INTO `master_maba` (`no_pendaftaran`, `nik`, `nama`, `tempat_lahir`, `tgl_lahir`, `alamat_domisili`, `alamat_asal`, `tahun_masuk`, `jenis_kelamin`, `nama_ibu`, `nama_ayah`, `agama`, `asal_sekolah`, `alamat_asal_sekolah`, `jurusan_asal_sekolah`, `danem`, `status_daftar_mhs_id`) VALUES
	('', 0, 'SIGIT WAHYU ALVIANTO', 'SURABAYA', '2020-12-12', 'PERUM RANDUAGUNG INDAH BLOK S-4 SINGOSARI MALANG', 'JL. INTAN 12E/V-10 RT 004 RW 13 KOTA BARU DRIYOREJO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('20180509PMBMB00', 0, 'RENDI WIJAYA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('20180625PMBMB00', 0, 'IQBAL ALAN SOFYAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('20180629PMBMB00', 0, 'EKA YULIA ORBANINGTYAS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('20180718PMBMB00', 0, 'RICO DWI SETIAWAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('20180723PMBMB00', 0, 'RIZKY PUJANGGA WIDYA PUTRA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('20180801PMBMB00', 0, 'SISKA WARDANI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('20180807PMBMB00', 0, 'FITRI PRASTIWI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `master_maba` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_mahasiswa
CREATE TABLE IF NOT EXISTS `master_mahasiswa` (
  `nim` varchar(15) NOT NULL DEFAULT '',
  `no_pendaftaran` varchar(50) NOT NULL DEFAULT '0',
  `nama` varchar(100) DEFAULT NULL,
  `no_telp` int(100) DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `tgl_keluar` date DEFAULT NULL,
  `no_do` int(11) DEFAULT NULL,
  `lama_studi` int(11) DEFAULT NULL,
  `id_master_jenjang` int(11) DEFAULT NULL,
  `kode_prodi` varchar(15) DEFAULT NULL,
  `id_master_kelas` int(10) unsigned DEFAULT NULL,
  `status_mhs_id` int(11) DEFAULT NULL,
  `nip` varchar(100) NOT NULL DEFAULT '0' COMMENT 'dosen wali foreign ke master dosen untuk relasi dosen wali',
  PRIMARY KEY (`nim`),
  KEY `FK_master_mahasiswa_1` (`id_master_kelas`),
  KEY `FK_master_mahasiswa_2` (`id_master_jenjang`),
  KEY `FK_mahasiswa_dosen` (`nip`) USING BTREE,
  KEY `FK_mahasiswa_maba` (`no_pendaftaran`) USING BTREE,
  KEY `FK_mahasiswa_1` (`kode_prodi`) USING BTREE,
  KEY `FK_master_mahasiswa_master_status_mhs` (`status_mhs_id`),
  CONSTRAINT `FK_master_mahasiswa_1` FOREIGN KEY (`id_master_kelas`) REFERENCES `master_kelas` (`id_master_kelas`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_master_mahasiswa_2` FOREIGN KEY (`id_master_jenjang`) REFERENCES `master_jenjang` (`id_master_jenjang`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_master_mahasiswa_3` FOREIGN KEY (`no_pendaftaran`) REFERENCES `master_maba` (`no_pendaftaran`),
  CONSTRAINT `FK_master_mahasiswa_4` FOREIGN KEY (`kode_prodi`) REFERENCES `master_prodi` (`kode_prodi`),
  CONSTRAINT `FK_master_mahasiswa_5` FOREIGN KEY (`nip`) REFERENCES `master_karyawan` (`nip`),
  CONSTRAINT `FK_master_mahasiswa_master_status_mhs` FOREIGN KEY (`status_mhs_id`) REFERENCES `master_status_mhs` (`status_mhs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_mahasiswa: ~0 rows (approximately)
DELETE FROM `master_mahasiswa`;
/*!40000 ALTER TABLE `master_mahasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_mahasiswa` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_mata_kuliah
CREATE TABLE IF NOT EXISTS `master_mata_kuliah` (
  `kode_matkul` varchar(100) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `sks` int(11) DEFAULT NULL,
  `syarat` varchar(100) DEFAULT NULL,
  `semester` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode_matkul`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_mata_kuliah: ~601 rows (approximately)
DELETE FROM `master_mata_kuliah`;
/*!40000 ALTER TABLE `master_mata_kuliah` DISABLE KEYS */;
INSERT INTO `master_mata_kuliah` (`kode_matkul`, `nama`, `sks`, `syarat`, `semester`, `status`, `keterangan`) VALUES
	('MBB0-3101', 'Perilaku Dalam Berorganisasi', 2, '', '6', 'Wajib', NULL),
	('MBB0-3102', 'Kewirausahaan', 3, NULL, '2', 'Wajib', NULL),
	('MBB0-3103', 'Bisnis Teknologi Informasi', 3, 'MBB0-3102', '5', 'Wajib', NULL),
	('MBB0-3104', 'Kewirausahaan', 2, NULL, '-', 'Wajib', NULL),
	('MBB0-5101', 'Perilaku Dalam Berorganisasi', 2, '', '8', 'Wajib', NULL),
	('MBB0-5102', 'Komputer Dan Masyarakat', 2, '', '-', '-', NULL),
	('MBB0-5103', 'Kewirausahaan', 2, '', '-', 'Wajib', NULL),
	('MBB0-5104', 'Kewirausahaan', 3, NULL, '4', 'Wajib', NULL),
	('MBB0-5105', 'Bisnis Teknologi Informasi', 3, 'MBB0-5104', '5', 'Wajib', NULL),
	('MBB0-5201', 'Perilaku Dalam Berorganisasi', 2, '', '6', 'Wajib', NULL),
	('MBB0-5202', 'Komputer Dan Masyarakat', 2, '', '-', '-', NULL),
	('MBB0-5203', 'Kewirausahaan', 2, '', '-', 'Wajib', NULL),
	('MBB0-5204', 'Ilmu Sosial Dan Budaya Dasar', 3, '', '-', '-', NULL),
	('MBB0-5205', 'Bisnis Teknologi Informasi', 3, NULL, '5', 'Wajib', NULL),
	('MBB0-5206', 'Kewirausahaan', 3, '', '4', 'Wajib', NULL),
	('MBB0-5301', 'Perilaku Dalam Berorganisasi', 2, '', '-', '-', NULL),
	('MBB0-5302', 'Kewirausahaan', 2, '', '-', '-', NULL),
	('MKB0-3101', 'Pengantar Teknologi Informasi', 3, '', '1', 'Wajib', NULL),
	('MKB0-3102', 'Paketerangan Program Aplikasi', 3, '', '1', 'Wajib', NULL),
	('MKB0-3103', 'Praktikum Paketerangan Program Aplikasi', 1, 'MKB0-3126', '-', '-', ''),
	('MKB0-3104', 'Bahasa Pemrograman 1', 3, '', '-', 'Wajib', NULL),
	('MKB0-3105', 'Praktikum Bahasa Pemrograman 1', 1, 'MKB0-3104', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3106', 'Algoritma Pemrograman', 3, '', '-', 'Wajib', NULL),
	('MKB0-3107', 'Bahasa Pemrograman 2', 3, 'MKB0-3106', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3108', 'Praktikum Bahasa Pemrograman 2', 1, 'MKB0-3107', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3109', 'Struktur Data', 3, 'MKB0-3154', '3', 'Wajib', 'MENEMPUH'),
	('MKB0-3110', 'Sistem Berkas', 3, '', '-', '-', NULL),
	('MKB0-3111', 'Sistem Basis Data', 3, 'MKB0-3109', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3112', 'Praktikum Sistem Basis Data', 1, 'MKB0-3111', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3113', 'Pemrograman Berbasis Unix', 2, '', '-', '-', NULL),
	('MKB0-3114', 'Praktikum Pemrograman  Berbasis Unix', 1, '', '-', '-', NULL),
	('MKB0-3115', 'Pemrograman Internet 1', 3, 'MKB0-3106', '-', '-', 'MENEMPUH'),
	('MKB0-3116', 'Praktikum Pemrograman Internet 1', 1, 'MKB0-3115', '-', '-', 'BERSAMA'),
	('MKB0-3117', 'Aplikasi Sistem Operasi', 3, '', '6', 'Wajib', NULL),
	('MKB0-3118', 'Praktikum Aplikasi Sistem Operasi', 1, 'MKB0-3117', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3119', 'Jaringan Komputer', 3, '', '-', 'Wajib', NULL),
	('MKB0-3120', 'Praktikum Jaringan Komputer', 1, 'MKB0-3161', '3', 'Wajib', 'BERSAMA'),
	('MKB0-3121', 'Keamanan Komputer', 3, '', '-', '-', NULL),
	('MKB0-3122', 'Manajemen LAN', 2, 'MKB0-3119', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3123', 'Praktikum Manajemen LAN', 1, 'MKB0-3122', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3124', 'Pemrograman Internet 2', 2, '', '-', '-', NULL),
	('MKB0-3125', 'Praktikum Pemrograman Internet 2', 1, 'MKB0-3139', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3126', 'Paketerangan Program Aplikasi', 2, '', '-', 'Wajib', NULL),
	('MKB0-3127', 'Interaksi Manusia Dan Komputer', 3, 'MKB0-3101', '4', 'Wajib', NULL),
	('MKB0-3128', 'Sistem Berkas', 2, '', '2', 'Wajib', NULL),
	('MKB0-3129', 'Pemrograman Java', 3, '', '-', '-', ''),
	('MKB0-3130', 'Praktikum Pemrograman Java', 1, '', '-', '-', ''),
	('MKB0-3131', 'Pemrograman Piranti Bergerak', 3, '', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3132', 'Praktikum Pemrograman Piranti Bergerak', 1, 'MKB0-3131', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3134', 'Pemrograman Berbasis .Net', 2, '', '-', '-', NULL),
	('MKB0-3135', 'Praktikum Pemrograman Berbasis .Net', 1, '', '-', '-', NULL),
	('MKB0-3136', 'Pemrograman Client-Server', 3, '', '-', '-', ''),
	('MKB0-3137', 'Keamanan Informasi', 3, '', '-', '-', NULL),
	('MKB0-3138', 'Komputer Dan Masyarakat', 3, '', '-', '-', NULL),
	('MKB0-3139', 'Pemrograman Internet 2', 3, 'MKB0-3115', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3140', 'Praktikum Algoritma dan Pemrograman', 1, 'MKB0-3106', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3141', 'Pemrograman Berbasis Web', 3, '', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3142', 'Praktikum Pemrograman Berbasis Web', 1, 'mkb0-3141', '-', 'Wajib', 'BERSAMA'),
	('MKB0-3143', 'Pemrograman Berorientasi Objek', 3, '', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3144', 'Praktikum Pemrograman Berorientasi Objek', 1, 'MKB0-3156', '2', 'Wajib', 'BERSAMA'),
	('MKB0-3145', 'Manajemen Jaringan Komputer', 2, '', '-', 'Wajib', NULL),
	('MKB0-3146', 'Praktikum Manajemen Jaringan Komputer', 1, '', '-', 'Wajib', NULL),
	('MKB0-3147', 'Pemasaran Berbasis Web', 3, 'MKB0-3141', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3148', 'Praktikum Pemasaran Berbasis Web', 1, 'MKB0-3141', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-3149', 'Manajemen Jaringan Komputer', 3, NULL, '-', 'Wajib', NULL),
	('MKB0-3150', 'Pemrograman Web 1', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-3151', 'Praktikum Pemrograman Web 1', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-3152', 'Sistem Basis Data 1', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-3153', 'Praktikum Sistem Basis Data 1', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-3154', 'Algoritma dan Kompleksitas', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-3155', 'Praktikum Algoritma dan Kompleksitas', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-3156', 'Pemrograman Berorientasi Objek', 2, '', '2', 'Wajib', ''),
	('MKB0-3157', 'Pemrograman Piranti Bergerak 1', 2, NULL, '3', 'Wajib', NULL),
	('MKB0-3158', 'Praktikum Pemrograman Piranti Bergerak 1', 1, NULL, '3', 'Wajib', NULL),
	('MKB0-3159', 'Pemrograman Piranti Bergerak 2', 2, 'MKB0-3157', '4', 'Wajib', NULL),
	('MKB0-3160', 'Praktikum Pemrograman Piranti Bergerak 2', 1, 'MKB0-3158', '4', 'Wajib', NULL),
	('MKB0-3161', 'Jaringan Komputer', 2, '', '3', 'Wajib', NULL),
	('MKB0-3162', 'Sistem Basis Data 2', 2, 'MKB0-3152', '2', 'Wajib', NULL),
	('MKB0-3163', 'Praktikum Sistem Basis Data 2', 1, 'MKB0-3153', '2', 'Wajib', NULL),
	('MKB0-3164', 'Pemrograman Web 2', 2, 'MKB0-3150', '2', 'Wajib', NULL),
	('MKB0-3165', 'Praktikum Pemrograman Web 2', 1, 'MKB0-3151', '2', 'Wajib', NULL),
	('MKB0-3166', 'Gamifikasi', 2, 'MKB0-3127', '5', 'Wajib', NULL),
	('MKB0-3301', 'Pengantar Teknologi Informasi', 3, '', '-', '-', NULL),
	('MKB0-3302', 'Organisasi Komputer', 2, '', '-', '-', NULL),
	('MKB0-3303', 'Komunikasi Data', 4, '', '-', '-', NULL),
	('MKB0-3304', 'Sistem Operasi', 3, '', '-', '-', NULL),
	('MKB0-3305', 'Arsitektur Komputer', 2, '', '-', '-', NULL),
	('MKB0-3306', 'Keamanan Jaringan Komunikasi', 3, '', '-', '-', NULL),
	('MKB0-3307', 'Metode Pemeliharaan', 2, '', '-', '-', NULL),
	('MKB0-3308', 'Metodologi Perancangan Program', 4, '', '-', '-', NULL),
	('MKB0-3309', 'Mikroprosesor', 3, '', '-', '-', NULL),
	('MKB0-3310', 'Praktikum Perakitan Komputer', 1, '', '-', '-', NULL),
	('MKB0-3311', 'Praktikum Rangkaian Digital', 1, '', '-', '-', NULL),
	('MKB0-3312', 'Rancang Bangun LAN', 2, '', '-', '-', NULL),
	('MKB0-3313', 'Troubleshoting', 4, '', '-', '-', NULL),
	('MKB0-3314', 'Bahasa Rakitan', 2, '', '-', '-', NULL),
	('MKB0-3315', 'Jaringan Komputer', 3, '', '-', '-', NULL),
	('MKB0-3316', 'Kecerdasan Buatan', 3, '', '-', '-', NULL),
	('MKB0-3317', 'Manajemen LAN', 2, '', '-', '-', NULL),
	('MKB0-3318', 'Mikrokontroller', 3, '', '-', '-', NULL),
	('MKB0-3319', 'Praktikum Assembler', 1, '', '-', '-', NULL),
	('MKB0-3320', 'Praktikum Instalasi Jaringan', 1, '', '-', '-', NULL),
	('MKB0-3321', 'Praktikum Mikrokontroller', 1, '', '-', '-', NULL),
	('MKB0-3322', 'Robotika', 3, '', '-', '-', NULL),
	('MKB0-3323', 'Interfacing', 3, '', '-', '-', NULL),
	('MKB0-3324', 'Praktikum Interfacing', 1, '', '-', '-', NULL),
	('MKB0-5101', 'Pengantar Teknologi Informasi', 3, '', '1', 'Wajib', NULL),
	('MKB0-5102', 'Paketerangan Program Aplikasi', 3, '', '1', 'Wajib', NULL),
	('MKB0-5103', 'Praktikum Paketerangan Program Aplikasi', 1, 'MKB0-5126', '-', '-', 'BERSAMA'),
	('MKB0-5104', 'Bahasa Pemrograman 1', 3, '', '-', 'Wajib', NULL),
	('MKB0-5105', 'Praktikum Bahasa Pemrograman 1', 1, 'MKB0-5104', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5106', 'Algoritma Pemrograman', 3, '', '-', 'Wajib', NULL),
	('MKB0-5107', 'Bahasa Pemrograman 2', 3, 'MKB0-5106', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5108', 'Praktikum Bahasa Pemrograman 2', 1, 'MKB0-5107', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5109', 'Struktur Data', 3, '', '3', 'Wajib', 'MENEMPUH'),
	('MKB0-5110', 'Sistem Berkas', 3, '', '-', '-', NULL),
	('MKB0-5111', 'Pemrograman Internet 1', 3, 'MKB0-5106', '-', '-', 'MENEMPUH'),
	('MKB0-5112', 'Praktikum Pemrograman Internet 1', 1, 'MKB0-5111', '-', '-', 'BERSAMA'),
	('MKB0-5113', 'Aplikasi Sistem Operasi', 3, '', '-', '-', NULL),
	('MKB0-5114', 'Praktikum Aplikasi Sistem Operasi', 1, '', '-', '-', NULL),
	('MKB0-5115', 'Sistem Basis Data', 3, 'MKB0-5109', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5116', 'Praktikum Sistem Basis Data', 1, 'MKB0-5115', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5117', 'Keamanan Informasi', 3, '', '6', 'Wajib', NULL),
	('MKB0-5118', 'Jaringan Komputer', 3, 'MKK0-5129', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5119', 'Praktikum Jaringan Komputer', 1, 'MKB0-5164', '5', 'Wajib', 'BERSAMA'),
	('MKB0-5120', 'Komunikasi Data', 3, '', '-', 'Wajib', ''),
	('MKB0-5121', 'Pemrograman Internet 2', 2, '', '-', '-', NULL),
	('MKB0-5122', 'Praktikum Pemrograman Internet 2', 1, 'MKB0-5140', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5123', 'Rekayasa Perangkat Lunak', 3, 'MKK0-5111', '6', 'Wajib', 'MENEMPUH'),
	('MKB0-5124', 'Pemrograman Client-Server', 3, '', '-', '-', NULL),
	('MKB0-5125', 'Praktikum Pemrograman Client-Server', 1, '', '-', '-', NULL),
	('MKB0-5126', 'Paketerangan Program Aplikasi', 2, '', '-', 'Wajib', NULL),
	('MKB0-5127', 'Komunikasi Data', 2, '', '4', '-', NULL),
	('MKB0-5128', 'Sistem Berkas', 2, '', '2', 'Wajib', NULL),
	('MKB0-5129', 'Komputer Dan Masyarakat', 3, '', '-', '-', NULL),
	('MKB0-5130', 'Pemrograman Berbasis Unix', 2, '', '-', '-', NULL),
	('MKB0-5131', 'Praktikum Pemrograman Berbasis Unix', 1, '', '-', '-', NULL),
	('MKB0-5132', 'Komputer Dan Masyarakat', 3, '', '-', '-', NULL),
	('MKB0-5133', 'Sistem Basis Data 1', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-5134', 'Praktikum Sistem Basis Data 1', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-5135', 'Pemrograman Berorientasi Objek', 3, NULL, NULL, NULL, NULL),
	('MKB0-5136', 'Praktikum Algoritma dan Pemrograman', 1, 'MKB0-5106', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5137', 'Pemrograman Web 1', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-5138', 'Praktikum Pemrograman Web 1', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-5139', 'Business Intellegent', 3, '', '-', '-', NULL),
	('MKB0-5140', 'Pemrograman Internet 2', 3, 'MKB0-5111', '-', 'Wajib', 'LULUS'),
	('MKB0-5141', 'Praktikum Rekayasa Perangkat Lunak', 1, 'MKB0-5123', '-', NULL, NULL),
	('MKB0-5142', 'Praktikum Rekayasa Perangkat Lunak', 1, 'MKB0-5160', '4', 'Wajib', 'BERSAMA'),
	('MKB0-5143', 'Pemrograman Berbasis Web', 3, '', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5144', 'Praktikum Pemrograman Berbasis Web', 1, 'MKB0-5143', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5145', 'Sistem Penunjang Keputusan', 3, '', '-', 'Wajib', NULL),
	('MKB0-5146', 'Pemrograman Piranti Bergerak', 3, '', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5147', 'Praktikum Pemrograman Piranti Bergerak', 1, 'MKB0-5146', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5148', 'Pemrograman Berorientasi Objek', 2, NULL, '2', 'Wajib', NULL),
	('MKB0-5149', 'Praktikum Pemrograman Berorientasi Objek', 1, NULL, '2', 'Wajib', NULL),
	('MKB0-5150', 'Pemasaran Berbasis Web', 3, NULL, '-', 'Wajib', NULL),
	('MKB0-5151', 'Praktikum Pemasaran Berbasis Web', 1, NULL, '-', 'Wajib', NULL),
	('MKB0-5152', 'Manajemen Proyek Teknologi Informasi', 3, 'MKB0-5123', '-', 'Wajib', NULL),
	('MKB0-5153', 'Algoritma dan Kompleksitas', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-5154', 'Praktikum Algoritma dan Kompleksitas', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-5155', 'Pemrograman Web 2', 2, 'MKB0-5137', '-', 'Wajib', NULL),
	('MKB0-5156', 'Praktikum Pemrograman Web 2', 1, '', '-', 'Wajib', NULL),
	('MKB0-5157', 'Pemrograman Web 3', 2, 'MKB0-5168', '-', 'Wajib', 'LULUS'),
	('MKB0-5158', 'Pemrograman Piranti Bergerak 1', 2, '', '3', 'Wajib', NULL),
	('MKB0-5159', 'Praktikum Pemrograman Piranti Bergerak 1', 1, NULL, '3', 'Wajib', NULL),
	('MKB0-5160', 'Rekayasa Perangkat Lunak', 2, NULL, '4', 'Wajib', NULL),
	('MKB0-5161', 'Pemrograman Piranti Bergerak 2', 2, NULL, '4', 'Wajib', NULL),
	('MKB0-5162', 'Praktikum Pemrograman Piranti Bergerak 2', 1, NULL, '4', 'Wajib', NULL),
	('MKB0-5163', 'Pemrograman Piranti Bergerak 3', 2, 'mkb0-5161', '5', 'Wajib', NULL),
	('MKB0-5164', 'Jaringan Komputer', 2, NULL, '5', 'Wajib', NULL),
	('MKB0-5165', 'E-Business', 3, NULL, '-', 'Wajib', NULL),
	('MKB0-5166', 'Sistem Basis Data 2', 2, 'mkb0-5133', '2', 'Wajib', NULL),
	('MKB0-5167', 'Praktikum Sistem Basis Data 2', 1, NULL, '2', 'Wajib', NULL),
	('MKB0-5168', 'Pemrograman Web 2', 2, 'MKB0-5137', '2', 'Wajib', NULL),
	('MKB0-5169', 'Praktikum Pemrograman Web 2', 1, '', '2', 'Wajib', NULL),
	('MKB0-5170', 'Pemrograman Web 3', 3, 'MKB0-5168', '-', 'Wajib', NULL),
	('MKB0-5171', 'Arsitektur Enterprise', 3, NULL, '-', NULL, NULL),
	('MKB0-5201', 'Pengantar Teknologi Informasi', 3, '', '1', 'Wajib', NULL),
	('MKB0-5202', 'Paketerangan Program Aplikasi', 3, '', '1', 'Wajib', NULL),
	('MKB0-5203', 'Praktikum Paketerangan Program Aplikasi', 1, 'MKB0-5207', '-', '-', 'BERSAMA'),
	('MKB0-5204', 'Arsitektur Komputer', 2, '', '-', '-', NULL),
	('MKB0-5205', 'Komunikasi Data', 3, 'MKB0-5210', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5206', 'Kecerdasan Buatan', 3, '', '5', 'Wajib', NULL),
	('MKB0-5207', 'Paketerangan Program Aplikasi', 2, '', '-', 'Wajib', NULL),
	('MKB0-5208', 'Algoritma dan Kompleksitas', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-5209', 'Praktikum Algoritma dan Kompleksitas', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-5210', 'Jaringan Komputer', 3, 'MKB0-5216', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5211', 'Praktikum Jaringan Komputer', 1, 'MKB0-5244', '5', 'Wajib', 'BERSAMA'),
	('MKB0-5212', 'Sistem Pakar', 3, '', '-', 'Wajib', NULL),
	('MKB0-5213', 'Organisasi Komputer', 2, '', '-', '-', NULL),
	('MKB0-5214', 'Komunikasi Data', 2, '', '4', '-', NULL),
	('MKB0-5215', 'Komputer Dan Masyarakat', 3, '', '-', '-', NULL),
	('MKB0-5216', 'Arsitektur Dan Organisasi Komputer', 3, '', '3', 'Wajib', NULL),
	('MKB0-5217', 'Pemrograman Berbasis Web', 3, '', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5218', 'Praktikum Pemrograman Berbasis Web', 1, 'MKB0-5217', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5219', 'Pemrograman Piranti Bergerak', 3, '', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5220', 'Praktikum Pemrograman Piranti Bergerak', 1, 'MKB0-5219', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5221', 'Pengolahan Citra Digital', 3, '', '-', 'Wajib', NULL),
	('MKB0-5222', 'Manajemen Proyek Teknologi Informasi', 0, 'MKB0-5258', '', 'Wajib', NULL),
	('MKB0-5223', 'Sistem Basis Data 1', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-5224', 'Praktikum Sistem Basis Data 1', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-5225', 'Sistem Basis Data 2', 2, 'MKB0-5223', '2', 'Wajib', 'MENEMPUH'),
	('MKB0-5226', 'Praktikum Sistem Basis Data 2', 1, 'MKB0-5225', '2', 'Wajib', 'BERSAMA'),
	('MKB0-5227', 'Pemrograman Web 1', 2, NULL, '1', 'Wajib', NULL),
	('MKB0-5228', 'Praktikum Pemrograman Web 1', 1, NULL, '1', 'Wajib', NULL),
	('MKB0-5229', 'Pemrograman Web 2', 2, 'MKB0-5227', '2', 'Wajib', 'MENEMPUH'),
	('MKB0-5230', 'Praktikum Pemrograman Web 2', 1, 'MKB0-5228', '2', 'Wajib', 'BERSAMA'),
	('MKB0-5231', 'Pemrograman Web Framework', 2, 'MKB0-5229', '4', 'Wajib', 'LULUS'),
	('MKB0-5232', 'Pemrograman Piranti Bergerak 1', 2, NULL, '3', 'Wajib', NULL),
	('MKB0-5233', 'Praktikum Pemrograman Piranti Bergerak 1', 1, '', '3', 'Wajib', ''),
	('MKB0-5234', 'Pemrograman Berorientasi Objek', 2, NULL, '2', 'Wajib', NULL),
	('MKB0-5235', 'Praktikum Pemrograman Berorientasi Objek', 1, NULL, '2', 'Wajib', NULL),
	('MKB0-5236', 'Analisis dan Perancangan Sistem Informasi', 2, NULL, '3', 'Wajib', NULL),
	('MKB0-5237', 'Pemrograman Piranti Bergerak 2', 2, 'MKB0-5232', '4', 'Wajib', 'LULUS'),
	('MKB0-5238', 'Praktikum Pemrograman Piranti Bergerak 2', 1, NULL, '4', 'Wajib', NULL),
	('MKB0-5239', 'Pemrograman Piranti Bergerak 3', 2, 'MKB0-5237', '5', 'Wajib', 'LULUS'),
	('MKB0-5240', 'Keamanan Informasi', 3, '', '6', 'Wajib', NULL),
	('MKB0-5241', 'Keamanan Jaringan Komunikasi', 3, '', '-', '-', NULL),
	('MKB0-5242', 'Keamanan Internet', 3, '', '-', 'Wajib', NULL),
	('MKB0-5243', 'Rekayasa Perangkat Lunak', 2, 'MKB0-5256', '4', 'Wajib', 'MENEMPUH'),
	('MKB0-5244', 'Jaringan Komputer', 2, NULL, '5', 'Wajib', NULL),
	('MKB0-5245', 'Arsitektur Enterprise', 2, '', '5', 'Wajib', NULL),
	('MKB0-5246', 'Konsep dan Aplikasi Automata', 2, NULL, '5', 'Wajib', NULL),
	('MKB0-5247', 'Pemrograman Web 3', 3, NULL, NULL, NULL, NULL),
	('MKB0-5250', 'Algoritma Dan Pemrograman 1', 3, '', '-', '-', ''),
	('MKB0-5251', 'Praktikum Algoritma Dan Pemrograman 1', 1, '', '-', '-', ''),
	('MKB0-5252', 'Pemrograman Java', 3, '', '-', '-', NULL),
	('MKB0-5253', 'Praktikum Pemrograman Java', 1, '', '-', '-', NULL),
	('MKB0-5254', 'Pemrograman Internet', 3, 'MKB0-5267', '-', '-', 'MENEMPUH'),
	('MKB0-5255', 'Praktikum Pemrograman Internet', 1, 'MKB0-5254', '-', '-', 'BERSAMA'),
	('MKB0-5256', 'Analisis Dan Perancangan Sistem Informasi', 3, 'MKB0-5263', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5257', 'Praktikum Analisis & Perancangan Sistem Informasi', 1, '', '3', 'Wajib', ''),
	('MKB0-5258', 'Rekayasa Perangkat Lunak', 3, 'MKB0-5256', '6', 'Wajib', 'MENEMPUH'),
	('MKB0-5259', 'Testing Dan Implementasi Sistem', 3, '', '5', '-', NULL),
	('MKB0-5260', 'Interaksi Manusia Dan Komputer', 2, '', '-', '-', NULL),
	('MKB0-5261', 'Manajemen Proyek Teknologi Informasi', 3, 'MKB0-5256', '7', 'Wajib', 'MENEMPUH'),
	('MKB0-5262', 'Rekayasa Perangkat Lunak Lanjut', 3, '', '-', '-', NULL),
	('MKB0-5263', 'Sistem Basis Data', 3, 'MKK0-5209', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5264', 'Praktikum Sistem Basis Data', 1, 'MKB0-5263', '-', 'Wajib', 'BERSAMA'),
	('MKB0-5265', 'Bahasa Rakitan', 3, 'MKB0-5286', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5266', 'Interaksi Manusia Dan Komputer', 3, '', '4', 'Wajib', NULL),
	('MKB0-5267', 'Algoritma Dan Pemrograman 2', 3, 'MKK0-5213', '-', '-', 'MENEMPUH'),
	('MKB0-5268', 'Praktikum Algoritma Dan Pemrograman 2', 1, 'MKB0-5267', '-', '-', 'BERSAMA'),
	('MKB0-5269', 'Testing dan Implementasi Sistem', 2, NULL, '-', 'Wajib', 'Menempuh'),
	('MKB0-5281', 'Sistem Operasi', 3, 'MKB0-5216', '4', 'Wajib', 'MENEMPUH'),
	('MKB0-5282', 'Mikroprosesor', 3, '', '-', '-', NULL),
	('MKB0-5284', 'Teknik Kompilasi', 3, '', '-', '-', NULL),
	('MKB0-5285', 'Rekayasa Sistem Operasi', 3, 'MKB0-5258', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5286', 'Mikroprosesor', 2, 'MKB0-5216', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5287', 'Teknik Kompilasi', 2, 'MKK0-5283', '-', 'Wajib', 'MENEMPUH'),
	('MKB0-5288', 'Praktikum Rekayasa Perangkat Lunak', 1, 'MKB0-5243', '4', 'Wajib', 'BERSAMA'),
	('MKB0-5289', 'Pemrograman Internet 2', 3, '', '-', '-', NULL),
	('MKB0-5290', 'Praktikum Pemrograman Internet 2', 1, '', '-', '-', NULL),
	('MKB0-5291', 'Manajemen LAN', 3, '', '-', '-', NULL),
	('MKB0-5292', 'Praktikum Manajemen LAN', 1, '', '-', '-', NULL),
	('MKB0-5293', 'Praktikum Rekayasa Sistem Operasi', 1, '', '-', '-', NULL),
	('MKB0-5294', 'Mikroprosesor dan Asembler', 1, 'MKB0-5250', '', 'Wajib', ''),
	('MKB0-5295', 'Sistem Operasi', 2, NULL, '4', 'Wajib', NULL),
	('MKB0-5301', 'Pengantar Teknologi Informasi', 3, '', '-', '-', NULL),
	('MKB0-5302', 'Organisasi Komputer', 2, '', '-', '-', NULL),
	('MKB0-5303', 'Pengantar Telekomunikasi', 2, '', '-', '-', NULL),
	('MKB0-5304', 'Arsitektur Komputer', 2, '', '-', '-', NULL),
	('MKB0-5305', 'Sistem Operasi', 3, '', '-', '-', NULL),
	('MKB0-5306', 'Komunikasi Data', 3, '', '-', '-', NULL),
	('MKB0-5307', 'Mikroprosesor', 3, '', '-', '-', NULL),
	('MKB0-5308', 'Jaringan Komputer', 3, '', '-', '-', NULL),
	('MKB0-5309', 'Praktikum Instalasi Jaringan', 1, '', '-', '-', NULL),
	('MKB0-5310', 'Bahasa Rakitan', 3, '', '-', '-', NULL),
	('MKB0-5311', 'Mikrokontroller', 3, '', '-', '-', NULL),
	('MKB0-5312', 'Kecerdasan Buatan', 3, '', '-', '-', NULL),
	('MKB0-5313', 'Manajemen LAN', 2, '', '-', '-', NULL),
	('MKB0-5314', 'Praktikum Manajemen LAN', 1, '', '-', '-', NULL),
	('MKB0-5315', 'Instrumentasi Pengaturan', 3, '', '-', '-', NULL),
	('MKB0-5316', 'Analisis Kinerja Sistem', 3, '', '-', '-', NULL),
	('MKB0-5317', 'Sistem Pakar', 3, '', '-', '-', NULL),
	('MKB0-5318', 'Interfacing', 3, '', '-', '-', NULL),
	('MKB0-5319', 'Praktikum Interfacing', 1, '', '-', '-', NULL),
	('MKB0-5320', 'Keamanan Jaringan Komunikasi', 3, '', '-', '-', NULL),
	('MKB0-5321', 'Metode Pemeliharaan', 2, '', '-', '-', NULL),
	('MKB0-5322', 'Robotika', 3, '', '-', '-', NULL),
	('MKB0-5323', 'Analisis Jaringan', 2, '', '-', '-', NULL),
	('MKB0-5324', 'Sistem Waktu Nyata', 3, '', '-', '-', NULL),
	('MKB0-5325', 'Interaksi Manusia Dan Komputer', 2, '', '-', '-', NULL),
	('MKB0-5326', 'Mikroprosesor', 2, '', '-', '-', NULL),
	('MKB0-5327', 'Interfacing', 2, '', '-', '-', NULL),
	('MKB0-5328', 'Sistem Pakar', 2, '', '-', '-', NULL),
	('MKB1-3101', 'Pemrograman Berbasis .Net', 2, 'MKB0-3147', '-', 'Pilihan', 'LULUS'),
	('MKB1-3102', 'Praktikum Pemrograman Berbasis .Net', 1, 'MKB1-3101', '-', 'Pilihan', 'BERSAMA'),
	('MKB1-3103', 'Pemrograman Berbasis Web Lanjut', 2, NULL, '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-3104', 'Praktikum Pemrograman Berbasis Web Lanjut', 1, 'MKB1-3103', '-', 'Pilihan', 'BERSAMA'),
	('MKB1-3105', 'Prinsip dan Dasar Animasi', 2, NULL, '-', 'Pilihan', NULL),
	('MKB1-3106', 'Praktikum Prinsip dan Dasar Animasi', 1, NULL, '-', 'Pilihan', NULL),
	('MKB1-3107', 'Story Board', 2, NULL, '-', 'Pilihan', NULL),
	('MKB1-3108', 'Animasi 2 Dimensi', 2, 'MKB1-3105', '-', 'Pilihan', 'LULUS'),
	('MKB1-3109', 'Praktikum Animasi 2 Dimensi', 1, 'MKB1-3106', '-', 'Pilihan', 'LULUS'),
	('MKB1-3110', 'Video dan Sound Efek', 2, 'MKB1-3108', '-', 'Pilihan', 'BERSAMA'),
	('MKB1-3111', 'Praktikum Video dan Sound Efek', 1, 'MKB1-3109', '-', 'Pilihan', 'BERSAMA'),
	('MKB1-3112', 'Animasi 3 Dimensi', 2, 'MKB1-3108', '-', 'Pilihan', 'LULUS'),
	('MKB1-3113', 'Praktikum Animasi 3 Dimensi', 1, 'MKB1-3109', '-', 'Pilihan', 'LULUS'),
	('MKB1-3114', 'Game 3 Dimensi Artificial Intelligence', 2, 'MKB1-3112', '-', 'Pilihan', NULL),
	('MKB1-3115', 'Praktikum Game 3 Dimensi Artificial Intelligence', 1, 'MKB1-3113', '-', 'Pilihan', NULL),
	('MKB1-3126', 'Web Administrator', 3, '', '-', '-', NULL),
	('MKB1-3127', 'Praktikum Web Administrator', 1, '', '-', '-', NULL),
	('MKB1-3128', 'Pemrograman Internet 3', 2, 'MKB0-3139', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-3129', 'Praktikum Pemrograman Internet 3', 1, 'MKB1-3128', '-', 'Pilihan', 'BERSAMA'),
	('MKB1-3130', 'Pemrograman Animasi', 3, '', '-', '-', NULL),
	('MKB1-3131', 'Praktikum Pemrograman Animasi', 1, '', '-', '-', NULL),
	('MKB1-3132', 'Content Management System', 3, 'MKB0-3139', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-3133', 'Praktikum Content Management System', 1, 'MKB1-3132', '-', 'Pilihan', 'BERSAMA'),
	('MKB1-3134', 'Multimedia Interaktif', 0, NULL, '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-3135', 'Praktikum Multimedia Interaktif', 0, NULL, '', 'Pilihan', 'MENEMPUH'),
	('MKB1-3136', 'Desain Grafis dan Animasi', 3, 'MKB1-3134', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-3137', 'Video dan Sound Editing', 1, NULL, '', 'Pilihan', 'MENEMPUH'),
	('MKB1-5126', 'Pemrograman Internet 3', 2, '', '-', '-', NULL),
	('MKB1-5127', 'Praktikum Pemrograman Internet 3', 1, '', '-', '-', NULL),
	('MKB1-5128', 'Pengolahan Citra', 2, '', '-', '-', NULL),
	('MKB1-5129', 'Praktikum Pengolahan Citra', 1, '', '-', '-', NULL),
	('MKB1-5132', 'Pemrograman Visual Basic.Net', 2, '', '-', '-', NULL),
	('MKB1-5133', 'Praktikum Pemrograman Visual Basic.Net', 1, '', '-', '-', NULL),
	('MKB1-5134', 'Pemrograman Java', 3, '', '-', '-', NULL),
	('MKB1-5135', 'Praktikum Pemrograman Java', 1, '', '-', '-', NULL),
	('MKB1-5136', 'Grafika Komputer', 3, 'MKK0-5106', '6', 'Pilihan', 'LULUS'),
	('MKB1-5137', 'Manajemen LAN', 2, '', '-', 'Pilihan', NULL),
	('MKB1-5138', 'Praktikum Manajemen LAN', 1, '', '-', 'Pilihan', NULL),
	('MKB1-5139', 'Pengolahan Citra', 3, 'MKB1-5136', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-5141', 'Desain Grafis dan Animasi', 3, 'MKB1-5143', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-5142', 'Video dan Sound Editing', 3, '', '-', 'Pilihan', NULL),
	('MKB1-5143', 'Multimedia Interaktif', 2, '', '-', 'Pilihan', NULL),
	('MKB1-5144', 'Praktikum Multimedia Interaktif', 1, 'MKB1-5143', '-', 'Pilihan', 'BERSAMA'),
	('MKB1-5145', 'Pemrograman Web FrameWork 1', 2, NULL, '6', 'Pilihan', NULL),
	('MKB1-5146', 'Praktikum Pemrograman Web FrameWork 1', 1, NULL, '6', 'Pilihan', NULL),
	('MKB1-5147', 'Evaluasi Pengalaman dan Antarmuka Pengguna', 3, 'MKK0-5131', '7', 'Pilihan', 'MENEMPUH'),
	('MKB1-5148', 'Optimasi Mesin Pencari', 3, NULL, '-', 'Pilihan', ''),
	('MKB1-5149', 'Pengelolaan Situs Web Bisnis', 3, NULL, '8', 'Pilihan', NULL),
	('MKB1-5201', 'Sistem Komputasi Awan', 2, NULL, '-', 'Pilihan', NULL),
	('MKB1-5202', 'Praktikum Sistem Komputasi Awan', 1, NULL, '-', 'Pilihan', NULL),
	('MKB1-5203', 'Aplikasi Komputasi Awan', 2, NULL, '-', 'Pilihan', NULL),
	('MKB1-5204', 'Praktikum Aplikasi Komputasi Awan', 1, NULL, '-', 'Pilihan', NULL),
	('MKB1-5250', 'Pemrograman JavaScript', 2, '', '-', '-', NULL),
	('MKB1-5251', 'Praktikum Pemrograman JavaScript', 1, '', '-', '-', NULL),
	('MKB1-5252', 'Pemrograman Piranti Bergerak', 2, '', '-', '-', NULL),
	('MKB1-5253', 'Praktikum Pemrograman Piranti Bergerak', 1, '', '-', '-', NULL),
	('MKB1-5254', 'Pemrograman Internet 2', 2, '', '-', '-', NULL),
	('MKB1-5255', 'Praktikum Pemrograman Internet 2', 1, '', '-', '-', NULL),
	('MKB1-5256', 'Pemrograman Internet 3', 2, '', '-', '-', NULL),
	('MKB1-5257', 'Praktikum Pemrograman Internet 3', 1, '', '-', '-', NULL),
	('MKB1-5258', 'Bahasa Pemrograman 1', 3, '', '-', '-', NULL),
	('MKB1-5259', 'Praktikum Bahasa Pemrograman 1', 1, '', '-', '-', NULL),
	('MKB1-5260', 'Pemrograman Visual Basic .Net', 2, '', '-', '-', NULL),
	('MKB1-5261', 'Praktikum Pemrograman Visual Basic .Net', 1, '', '-', '-', NULL),
	('MKB1-5262', 'Pemrograman Client-Server', 3, '', '-', '-', NULL),
	('MKB1-5263', 'Praktikum Pemrograman Client-Server', 1, '', '-', '-', NULL),
	('MKB1-5264', 'Bahasa Pemrograman 2', 3, '', '-', '-', NULL),
	('MKB1-5265', 'Praktikum Bahasa Pemrograman 2', 1, '', '-', '-', NULL),
	('MKB1-5266', 'Manajemen LAN', 2, '', '-', 'Pilihan', NULL),
	('MKB1-5267', 'Praktikum Manajemen LAN', 1, '', '-', 'Pilihan', NULL),
	('MKB1-5268', 'Pemrograman Internet 2', 3, '', '-', '-', NULL),
	('MKB1-5269', 'Jaringan Nirkabel Dan Komputasi Bergerak', 3, 'MKB0-5216', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-5270', 'Kompresi Data', 3, 'MKK0-5209', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-5271', 'Teori Graph', 3, 'MKK0-5208', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-5272', 'Keamanan Internet', 0, NULL, '-', 'Pilihan', 'AKRE-TI'),
	('MKB1-5273', 'Jaringan dan Virtualisasi', 3, NULL, '-', 'Pilihan', NULL),
	('MKB1-5274', 'Praktikum Jaringan dan Virtualisasi', 1, NULL, '-', 'Pilihan', NULL),
	('MKB1-5280', 'Interfacing', 3, '', '-', '-', NULL),
	('MKB1-5281', 'Praktikum Interfacing', 1, '', '-', '-', NULL),
	('MKB1-5282', 'Pengolahan Citra', 2, '', '-', '-', NULL),
	('MKB1-5283', 'Praktikum Pengolahan Citra', 1, '', '-', '-', NULL),
	('MKB1-5284', 'Jaringan Komputer Lanjut', 3, 'MKB0-5210', '6', 'Pilihan', 'MENEMPUH'),
	('MKB1-5285', 'Keamanan Jaringan Komunikasi', 3, 'MKB1-5269', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-5286', 'Keamanan Internet', 3, 'MKB1-5269', '-', 'Pilihan', 'MENEMPUH'),
	('MKB1-5287', 'Jaringan Nirkabel Dan Komputasi Bergerak', 0, NULL, '', 'Pilihan', 'Akre-TI'),
	('MKB1-5288', 'Jaringan Komputer Lanjut', 0, NULL, '-', 'Pilihan', 'AKRE-TI'),
	('MKB1-5289', 'Kompresi Data', 0, NULL, '', 'Pilihan', 'AKRE-TI'),
	('MKB1-5290', 'Pemrograman Keamanan Jaringan', 0, '', '', 'Pilihan', 'AKRE-TI'),
	('MKB1-5291', 'Sistem Deteksi Penyusupan', 0, '', '', 'Pilihan', 'AKRE-TI'),
	('MKB1-5292', 'Rekayasa Perangkat Lunak Skalabilitas', 0, NULL, '', NULL, 'AKRE-TI'),
	('MKB1-5293', 'Pengantar Komputasi Awan', 3, NULL, '-', 'Pilihan', NULL),
	('MKB1-5294', 'Komputasi Grid dan Pararel', 3, NULL, '-', 'Pilihan', NULL),
	('MKB1-5295', 'Infrastruktur Komputasi Awan', 2, NULL, '-', 'Pilihan', NULL),
	('MKB1-5296', 'Keamanan Komputasi Awan', 2, NULL, '-', 'Pilihan', NULL),
	('MKB1-5297', 'Komputasi Grid', 3, NULL, '-', 'Pilihan', NULL),
	('MKB1-5298', 'Praktikum Komputasi Grid', 1, NULL, '-', 'Pilihan', NULL),
	('MKB1-5326', 'Grafika Komputer', 3, '', '-', '-', NULL),
	('MKB1-5327', 'Pengolahan Citra', 2, '', '-', '-', NULL),
	('MKB1-5328', 'Troubleshoting', 2, '', '-', '-', NULL),
	('MKB1-5329', 'Pemrograman Internet 1', 3, '', '-', '-', NULL),
	('MKB2-3101', 'Pemrograman Berbasis .Net', 2, '', '-', '-', ''),
	('MKB2-3102', 'Praktikum Pemrograman Berbasis .Net', 1, '', '-', '-', ''),
	('MKB2-3103', 'Pemrograman Berbasis Desktop', 3, NULL, '-', 'Pilihan', NULL),
	('MKB2-3104', 'Praktikum Pemrograman Berbasis Desktop', 1, '', '-', 'Pilihan', NULL),
	('MKB2-3105', 'Pemrograman Berbasis Desktop Lanjut', 1, '', '', 'Pilihan', NULL),
	('MKB2-3106', 'Pemrograman Berbasis Desktop', 0, NULL, '', 'Pilihan', 'MENEMPUH'),
	('MKB2-3107', 'Praktikum Pemrograman Berbasis Desktop', 0, NULL, '', 'Pilihan', 'MENEMPUH'),
	('MKB2-3108', 'Pemrograman Web Content Management System', 2, 'MKB2-3117', '-', 'Pilihan', NULL),
	('MKB2-3109', 'Praktikum Pemrograman Web Content Management System', 1, 'MKB2-3118', '-', 'Pilihan', NULL),
	('MKB2-3110', 'Manajemen Server Web', 2, NULL, '4', 'Pilihan', NULL),
	('MKB2-3111', 'Pemrograman Web Framework 1', 2, '', '4', 'Pilihan', ''),
	('MKB2-3112', 'Praktikum Pemrograman Web Framework 1', 1, '', '4', 'Pilihan', ''),
	('MKB2-3113', 'Optimasi Performa Web Server', 2, 'MKB2-3115', '-', 'Pilihan', 'LULUS'),
	('MKB2-3114', 'Praktikum Optimasi Performa Web Server', 1, 'MKB2-3116', '-', 'Pilihan', 'LULUS'),
	('MKB2-3115', 'User Interface Design', 2, 'MKB0-3127', '5', 'Pilihan', NULL),
	('MKB2-3116', 'Praktikum User Interface Design', 1, 'MKB0-3127', '5', 'Pilihan', NULL),
	('MKB2-3117', 'Pemrograman Web Framework 2', 2, 'MKB2-3111', '5', 'Pilihan', 'LULUS'),
	('MKB2-3118', 'Praktikum Pemrograman Web Framework 2', 1, 'MKB2-3112', '5', 'Pilihan', 'LULUS'),
	('MKB2-3129', 'Pemrograman Java', 3, 'MKB0-3106', '-', 'Pilihan', 'MENEMPUH'),
	('MKB2-3130', 'Praktikum Pemrograman Java', 1, 'MKB2-3129', '-', 'Pilihan', 'BERSAMA'),
	('MKB2-3131', 'Pemrograman Piranti Bergerak', 3, 'MKB2-3129', '-', 'Pilihan', 'MENEMPUH'),
	('MKB2-3136', 'Pemrograman Client-Server', 3, 'MKB0-3111', '6', 'Pilihan', 'MENEMPUH'),
	('MKB2-3137', 'Pemrograman Client-Server', 2, 'MKB0-3111', '-', 'Pilihan', 'MENEMPUH'),
	('MKB2-3138', 'Praktikum Pemrograman Client-Server', 1, 'MKB0-3111', '6', 'Pilihan', 'MENEMPUH'),
	('MKB2-5130', 'Kecerdasan Bisnis', 2, NULL, '-', 'Pilihan', NULL),
	('MKB2-5131', 'Pemrograman Berbasis .Net', 3, 'MKB0-5150', '-', 'Pilihan', 'LULUS'),
	('MKB2-5132', 'Pemrograman Berbasis .Net', 2, 'MKB0-5150', '-', 'Pilihan', 'LULUS'),
	('MKB2-5133', 'Praktikum Pemrograman Berbasis .Net', 1, 'MKB2-5132', '-', 'Pilihan', 'BERSAMA'),
	('MKB2-5138', 'Konsep Dan Aplikasi Data Mining', 3, 'MKB0-5115', '6', 'Pilihan', 'LULUS'),
	('MKB2-5139', 'Kecerdasan Bisnis', 3, '', '7', 'Pilihan', ''),
	('MKB2-5140', 'E-Business', 2, NULL, '6', 'Pilihan', NULL),
	('MKB2-5141', 'Sistem Penunjang Keputusan', 3, '', '-', '-', NULL),
	('MKB2-5142', 'Arsitektur Enterprise', 3, NULL, '5', 'Pilihan', NULL),
	('MKB2-5143', 'Pembelajaran Mesin', 3, NULL, '8', 'Pilihan', NULL),
	('MKB2-5144', 'Komputasi Kognitif', 3, NULL, '-', NULL, NULL),
	('MKB2-5201', 'Mikrokontroler', 3, NULL, '5', 'Pilihan', NULL),
	('MKB2-5203', 'Jaringan Saraf Tiruan', 3, 'MKK0-5284', '-', 'Pilihan', 'MENEMPUH'),
	('MKB2-5204', 'Pengolahan Citra', 3, 'MKB2-5205', '-', 'Pilihan', 'MENEMPUH'),
	('MKB2-5205', 'Sistem Logika Fuzzy', 3, 'MKB2-5203', '6', 'Pilihan', 'MENEMPUH'),
	('MKB2-5206', 'Algoritma Genetik', 3, 'MKB2-5203', '-', 'Pilihan', 'MENEMPUH'),
	('MKB2-5207', 'Sistem Pakar', 3, 'MKB2-5203', '-', '-', 'MENEMPUH'),
	('MKB2-5208', 'Pemrograman Berorientasi Objek', 3, NULL, '-', 'Pilihan', NULL),
	('MKB2-5209', 'Praktikum Pemrograman Berorientasi Objek', 1, 'MKB2-5208', '-', 'Pilihan', NULL),
	('MKB2-5210', 'Jaringan Saraf Tiruan', 0, NULL, '', 'Pilihan', 'AKRE-TI'),
	('MKB2-5211', 'Sistem Logika Fuzzy', 0, NULL, '-', 'Pilihan', 'AKRE-TI'),
	('MKB2-5212', 'Algoritma Genetik', 0, '', '-', 'Pilihan', 'AKRE-TI'),
	('MKB2-5213', 'Pengolahan Citra Digital', 0, '', '', 'Pilihan', 'AKRE-TI'),
	('MKB2-5214', 'Pengantar Teknologi Game', 0, '', '', 'Pilihan', 'AKRE-TI'),
	('MKB2-5215', 'Pengolahan Big Data', 0, '', '', 'Pilihan', 'AKRE-TI'),
	('MKB2-5216', 'Konsep dan Aplikasi Data Mining', 3, NULL, '6', 'Wajib', NULL),
	('MKB2-5217', 'Pengantar Internet of Things', 3, NULL, '-', 'Pilihan', NULL),
	('MKB2-5218', 'Komunikasi Nirkabel', 2, NULL, '-', 'Pilihan', NULL),
	('MKB2-5219', 'Keamanan Jaringan Nirkabel', 2, NULL, '-', 'Pilihan', NULL),
	('MKB2-5220', 'Mikrokontroller 2', 3, NULL, '-', 'Pilihan', NULL),
	('MKB2-5221', 'Praktikum Mikrokontroller 2', 1, NULL, '-', 'Pilihan', NULL),
	('MKB2-5222', 'Praktikum Mikrokontroler', 1, NULL, '5', 'Pilihan', NULL),
	('MKB2-5223', 'Embedded Apllication Development', 2, NULL, '-', 'Pilihan', NULL),
	('MKB2-5224', 'Praktikum Embedded Apllication Development', 1, NULL, '-', 'Pilihan', NULL),
	('MKB2-5225', 'Sistem Cerdas', 2, NULL, '7', 'Pilihan', NULL),
	('MKB2-5226', 'Praktikum Sistem Cerdas', 1, NULL, '7', 'Pilihan', NULL),
	('MKB2-5227', 'Pemrosesan Citra Berbasis IOT', 3, NULL, '-', 'Pilihan', NULL),
	('MKB2-5234', 'Pembelajaran Mesin', 3, NULL, '-', 'Pilihan', NULL),
	('MKB205222', 'Embedded Application Development', 2, NULL, '', 'Pilihan', NULL),
	('MKB205223', 'Praktikum Embedded Application Development', 1, NULL, '', 'Pilihan', NULL),
	('MKB205224', 'Sistem Cerdas/Machine Learning', 2, NULL, '', 'Pilihan', NULL),
	('MKB205225', 'Praktikum Sistem Cerdas/Machine Learning', 1, NULL, '', 'Pilihan', NULL),
	('MKK0-3101', 'Logika Informatika', 3, '', '1', 'Wajib', NULL),
	('MKK0-3102', 'Kalkulus', 2, '', '-', '-', NULL),
	('MKK0-3103', 'Manajemen Umum', 2, '', '-', 'Wajib', NULL),
	('MKK0-3104', 'Sistem Informasi Manajemen', 3, 'MKB0-3101', '4', 'Wajib', 'LULUS'),
	('MKK0-3105', 'Pengantar Akuntansi', 3, '', '-', 'Wajib', NULL),
	('MKK0-3106', 'Praktikum Pengantar Akuntansi', 1, '', '-', '-', NULL),
	('MKK0-3107', 'Matriks Dan Transformasi Linier', 3, '', '2', 'Wajib', NULL),
	('MKK0-3108', 'Pengantar Ekonomi', 2, '', '-', 'Wajib', NULL),
	('MKK0-3109', 'Matematika Diskrit', 3, '', '3', 'Wajib', NULL),
	('MKK0-3110', 'Arsitektur Dan Organisasi Komputer', 3, '', '-', '-', NULL),
	('MKK0-3111', 'Analisis Dan Perancangan Sistem Informasi', 3, 'MKB0-3111', '-', 'Wajib', 'MENEMPUH'),
	('MKK0-3112', 'Praktikum Analisis & Perancangan Sistem Informasi', 1, 'MKK0-3111', '3', 'Wajib', 'BERSAMA'),
	('MKK0-3113', 'Statistik', 3, '', '4', 'Wajib', NULL),
	('MKK0-3114', 'Teknik Riset Operasional', 3, '', '3', 'Wajib', ''),
	('MKK0-3115', 'Sistem Informasi Manajemen', 2, '', '-', 'Wajib', NULL),
	('MKK0-3116', 'Manajemen Keuangan', 2, '', '-', 'Wajib', NULL),
	('MKK0-3117', 'Analisis Dan Perancangan Sistem Informasi', 2, NULL, '3', 'Wajib', NULL),
	('MKK0-3301', 'Algoritma & Pemrograman 1', 3, '', '-', '-', NULL),
	('MKK0-3302', 'Praktikum Algoritma & Pemrograman 1', 1, '', '-', '-', NULL),
	('MKK0-3303', 'Fisika 1', 2, '', '-', '-', NULL),
	('MKK0-3304', 'Kalkulus 1', 2, '', '-', '-', NULL),
	('MKK0-3305', 'Rangkaian Listrik', 2, '', '-', '-', NULL),
	('MKK0-3306', 'Algoritma & Pemrograman 2', 2, '', '-', '-', NULL),
	('MKK0-3307', 'Praktikum Algoritma & Pemrograman 2', 1, '', '-', '-', NULL),
	('MKK0-3308', 'Elektronika', 2, '', '-', '-', NULL),
	('MKK0-3309', 'Praktikum Elektronika', 1, '', '-', '-', NULL),
	('MKK0-3310', 'Kalkulus 2', 2, '', '-', '-', NULL),
	('MKK0-3311', 'Matriks & Transformasi Linier', 3, '', '-', '-', NULL),
	('MKK0-3312', 'Fisika 2', 2, '', '-', '-', NULL),
	('MKK0-3313', 'Algoritma & Pemrograman 3', 2, '', '-', '-', NULL),
	('MKK0-3314', 'Praktikum Algoritma & Pemrograman 3', 1, '', '-', '-', NULL),
	('MKK0-3315', 'Pengantar Telekomunikasi', 2, '', '-', '-', NULL),
	('MKK0-3316', 'Peralatan Elektronika', 2, '', '-', '-', NULL),
	('MKK0-3317', 'Sistem Digital', 3, '', '-', '-', NULL),
	('MKK0-3318', 'Statistik Dasar', 3, '', '-', '-', NULL),
	('MKK0-5101', 'Logika Informatika', 3, '', '1', 'Wajib', NULL),
	('MKK0-5102', 'Manajemen Umum', 2, '', '-', 'Wajib', NULL),
	('MKK0-5103', 'Kalkulus', 2, '', '-', '-', NULL),
	('MKK0-5104', 'Pengantar Sistem Informasi', 2, '', '-', '-', NULL),
	('MKK0-5105', 'Pengantar Akuntansi', 3, '', '-', 'Wajib', NULL),
	('MKK0-5106', 'Matriks Dan Transformasi Linier', 3, '', '2', 'Wajib', NULL),
	('MKK0-5107', 'Statistik', 3, '', '2', 'Wajib', NULL),
	('MKK0-5108', 'Matematika Diskrit', 3, '', '3', 'Wajib', NULL),
	('MKK0-5109', 'Organisasi Komputer', 2, '', '-', '-', NULL),
	('MKK0-5110', 'Sistem Informasi Akuntansi', 3, 'MKK0-5116', '6', 'Wajib', 'MENEMPUH'),
	('MKK0-5111', 'Analisis Dan Perancangan Sistem Informasi', 3, 'MKB0-5115', '-', 'Wajib', 'MENEMPUH'),
	('MKK0-5112', 'Prak. Analisis & Perancangan Sistem Informasi', 1, '', '3', 'Wajib', ''),
	('MKK0-5113', 'Teknik Riset Operasional', 3, 'MKK0-5106', '3', 'Wajib', 'MENEMPUH'),
	('MKK0-5114', 'Statistik Terapan', 3, '', '-', '-', NULL),
	('MKK0-5115', 'Arsitektur Komputer', 2, '', '-', '-', NULL),
	('MKK0-5116', 'Sistem Informasi Manufaktur', 3, '', '-', 'Wajib', ''),
	('MKK0-5117', 'Sistem Penunjang Keputusan', 3, '', '5', 'Wajib', NULL),
	('MKK0-5118', 'Testing Dan Implementasi Sistem', 2, '', '5', 'Wajib', NULL),
	('MKK0-5119', 'Kecerdasan Buatan', 3, '', '5', 'Wajib', NULL),
	('MKK0-5120', 'Kecerdasan Buatan', 3, '', '-', 'Wajib', NULL),
	('MKK0-5121', 'Manajemen Proyek Teknologi Informasi', 3, 'MKB0-5123', '-', '-', NULL),
	('MKK0-5122', 'Sistem Informasi Manufaktur 2', 3, '', '-', '-', NULL),
	('MKK0-5123', 'Analisis Proses Bisnis', 2, 'MBB0-5103', '7', 'Wajib', 'MENEMPUH'),
	('MKK0-5124', 'Sistem Informasi Peramalan', 2, '', '-', 'Wajib', NULL),
	('MKK0-5125', 'Sistem Informasi Optimasi Laba', 2, '', '-', '-', NULL),
	('MKK0-5126', 'Analisis Keuangan', 3, '', '-', '-', NULL),
	('MKK0-5127', 'Analisis Keuangan', 2, '', '-', '-', NULL),
	('MKK0-5128', 'Interaksi Manusia Dan Komputer', 3, '', '4', 'Wajib', NULL),
	('MKK0-5129', 'Arsitektur Dan Organisasi Komputer', 3, '', '3', 'Wajib', ''),
	('MKK0-5130', 'Sistem Operasi', 3, 'MKK0-5129', '4', 'Wajib', 'MENEMPUH'),
	('MKK0-5131', 'Interaksi Manusia Dan Komputer', 3, '', '-', 'Wajib', NULL),
	('MKK0-5132', 'Testing Dan Implementasi Sistem', 2, 'MKB0-5123', '-', 'Wajib', 'MENEMPUH'),
	('MKK0-5133', 'Manajemen Proyek Teknologi Informasi', 3, 'MKB0-5123', '7', 'Wajib', 'MENEMPUH'),
	('MKK0-5134', 'Sistem Informasi Manajemen', 2, '', '-', 'Wajib', NULL),
	('MKK0-5135', 'Analisis dan Perancangan Sistem Informasi', 2, 'MKB0-5166', '3', 'Wajib', 'MENEMPUH'),
	('MKK0-5150', 'Interaksi Manusia Dan Komputer', 2, '', '-', '-', NULL),
	('MKK0-5201', 'Logika Informatika', 3, '', '1', 'Wajib', NULL),
	('MKK0-5202', 'Manajemen Umum', 2, '', '-', 'Wajib', NULL),
	('MKK0-5203', 'Kalkulus 1', 2, '', '-', 'Wajib', NULL),
	('MKK0-5204', 'Kalkulus 2', 2, 'MKK0-5203', '-', 'Wajib', 'MENEMPUH'),
	('MKK0-5205', 'Pengantar Sistem Informasi', 2, '', '-', '-', NULL),
	('MKK0-5206', 'Matriks Dan Transformasi Linier', 3, '', '2', 'Wajib', NULL),
	('MKK0-5207', 'Statistik', 3, '', '2', 'Wajib', NULL),
	('MKK0-5208', 'Matematika Diskrit', 3, '', '3', 'Wajib', ''),
	('MKK0-5209', 'Struktur Data', 3, '', '3', 'Wajib', ''),
	('MKK0-5210', 'Sistem Berkas', 3, '', '-', '-', NULL),
	('MKK0-5211', 'Teknik Riset Operasional', 3, '', '3', 'Wajib', ''),
	('MKK0-5212', 'Sistem Berkas', 2, '', '2', 'Wajib', NULL),
	('MKK0-5213', 'Algoritma Dan Pemrograman 1', 3, '', '-', '-', NULL),
	('MKK0-5214', 'Praktikum Algoritma Dan Pemrograman 1', 1, 'MKK0-5213', '-', '-', 'BERSAMA'),
	('MKK0-5215', 'Algoritma Dan Pemrograman 2', 3, '', '-', '-', NULL),
	('MKK0-5216', 'Praktikum Algoritma Dan Pemrograman 2', 1, '', '-', '-', NULL),
	('MKK0-5217', 'Algoritma Dan Pemrograman', 3, '', '-', 'Wajib', 'MENEMPUH'),
	('MKK0-5218', 'Praktikum Algoritma Dan Pemrograman', 1, 'MKK0-5217', '-', 'Wajib', 'BERSAMA'),
	('MKK0-5219', 'Sistem Informasi Manajemen', 2, '', '-', 'Wajib', NULL),
	('MKK0-5280', 'Grafika Komputer', 3, 'MKK0-5206', '-', 'Wajib', 'MENEMPUH'),
	('MKK0-5283', 'Teori Bahasa Otomata', 3, 'MKK0-5208', '-', 'Wajib', 'MENEMPUH'),
	('MKK0-5284', 'Metode Numerik', 2, 'MKK0-5204', '-', 'Wajib', 'MENEMPUH'),
	('MKK0-5285', 'Sistem Penunjang Keputusan', 3, '', '-', 'Wajib', NULL),
	('MKK0-5286', 'Bahasa Indonesia Ilmiah', 3, '', '-', '-', NULL),
	('MKK0-5287', 'Konsep dan Aplikasi Data Mining', 0, NULL, '-', NULL, 'AKRE-TI'),
	('MKK0-5288', 'Cloud Computing', 0, NULL, '-', NULL, 'AKRE-TI'),
	('MKK0-5301', 'Logika Informatika', 3, '', '-', '-', NULL),
	('MKK0-5302', 'Kalkulus 1', 2, '', '-', '-', NULL),
	('MKK0-5303', 'Algoritma Pemrograman 1', 3, '', '-', '-', NULL),
	('MKK0-5304', 'Praktikum Algoritma Pemrograman 1', 1, '', '-', '-', NULL),
	('MKK0-5305', 'Fisika 1', 2, '', '-', '-', NULL),
	('MKK0-5306', 'Fisika 2', 2, '', '-', '-', NULL),
	('MKK0-5307', 'Algoritma Pemrograman 2', 3, '', '-', '-', NULL),
	('MKK0-5308', 'Praktikum Algoritma Pemrograman 2', 1, '', '-', '-', NULL),
	('MKK0-5309', 'Rangkaian Listrik', 2, '', '-', '-', NULL),
	('MKK0-5310', 'Kalkulus 2', 2, '', '-', '-', NULL),
	('MKK0-5311', 'Elektronika', 3, '', '-', '-', NULL),
	('MKK0-5312', 'Matriks & Transformasi Linier', 2, '', '-', '-', NULL),
	('MKK0-5313', 'Struktur Data', 3, '', '-', '-', NULL),
	('MKK0-5314', 'Matematika Diskrit', 3, '', '-', '-', NULL),
	('MKK0-5315', 'Statistik Dasar', 3, '', '-', '-', NULL),
	('MKK0-5316', 'Peralatan Elektronika', 2, '', '-', '-', NULL),
	('MKK0-5317', 'Algoritma Pemrograman 3', 2, '', '-', '-', NULL),
	('MKK0-5318', 'Praktikum Algoritma Pemrograman 3', 1, '', '-', '-', NULL),
	('MKK0-5319', 'Sistem Digital', 3, '', '-', '-', NULL),
	('MKK0-5320', 'Teknik Riset Operasional', 3, '', '-', '-', NULL),
	('MKK0-5321', 'Metode Numerik', 3, '', '-', '-', NULL),
	('MKK0-5322', 'Sistem Pengaturan Digital', 3, '', '-', '-', NULL),
	('MKK0-5323', 'Sistem Pengaturan', 3, '', '-', '-', NULL),
	('MKK0-5324', 'Perancangan Sistem', 2, '', '-', '-', NULL),
	('MKK1-5110', 'Sistem Informasi Akuntansi', 3, 'MKK0-5116', '-', '-', 'MENEMPUH'),
	('MKK1-5121', 'Standar ISO Pada Manufaktur', 2, '', '-', '-', NULL),
	('MKK1-5122', 'Sistem Informasi Perbankan', 3, '', '-', '-', NULL),
	('MKK1-5123', 'E-Bisnis', 2, '', '-', '-', NULL),
	('MKK1-5124', 'E-Bisnis', 2, '', '-', '-', NULL),
	('MKK1-5125', 'E-Business', 3, '', '6', 'Pilihan', NULL),
	('MKK1-5126', 'Sistem Penunjang Keputusan', 3, '', '-', '-', NULL),
	('MKK1-5325', 'Simulasi Permodelan', 3, '', '-', '-', NULL),
	('MKK1-5326', 'Otomasi Sistem', 2, '', '-', '-', NULL),
	('MKK1-5327', 'Simulasi Permodelan', 2, '', '-', '-', NULL),
	('MPB0-3101', 'Tugas Pemrograman', 1, '', '-', '-', NULL),
	('MPB0-3102', 'Praktek Kerja Lapangan', 1, '', '-', '-', NULL),
	('MPB0-3103', 'Etika Profesi', 2, '', '4', 'Wajib', NULL),
	('MPB0-3104', 'Tugas Akhir', 4, '100 sks', 'X', 'Wajib', 'lulus 100 sks'),
	('MPB0-3105', 'Tugas Pemrograman', 2, 'MKK0-5111', '-', 'Wajib', 'BERSAMA'),
	('MPB0-3107', 'Praktik Kerja Teknologi Informasi', 4, '80 sks', '5', 'Wajib', 'LULUS'),
	('MPB0-3108', 'Seminar Pra Tugas Akhir', 1, NULL, '5', 'Wajib', NULL),
	('MPB0-3301', 'Kewarganegaraan', 3, '', '-', '-', NULL),
	('MPB0-3302', 'Etika Profesi', 2, '', '-', '-', NULL),
	('MPB0-3303', 'Tugas Akhir', 4, '90 sks', '-', '-', NULL),
	('MPB0-5101', 'Rekayasa Miniatur Proyek', 3, '', '-', '-', NULL),
	('MPB0-5102', 'Tugas Pemrograman Khusus', 2, '110 sks', 'x', 'Wajib', 'lulus 110 sks'),
	('MPB0-5103', 'Etika Profesi', 2, '', '4', 'Wajib', NULL),
	('MPB0-5104', 'Skripsi', 4, '130 sks', 'X', 'Wajib', 'lulus 130 sks'),
	('MPB0-5105', 'Praktik Kerja Teknologi Informasi', 4, '110 sks', '7', 'Wajib', 'lulus 110 sks'),
	('MPB0-5106', 'Rekayasa Miniatur Proyek', 2, '', '-', '-', NULL),
	('MPB0-5108', 'Seminar Pra Skripsi', 1, NULL, '7', 'Wajib', NULL),
	('MPB0-5201', 'Etika Profesi', 2, '', '4', 'Wajib', NULL),
	('MPB0-5202', 'Tugas Pemrograman Khusus', 2, '110 sks', 'x', 'Wajib', 'lulus 110 sks'),
	('MPB0-5203', 'Skripsi', 4, '130 sks', 'X', 'Wajib', NULL),
	('MPB0-5204', 'Praktik Kerja Teknologi Informasi', 4, '110 sks', 'X', 'Wajib', 'lulus 110 sks'),
	('MPB0-5208', 'Seminar Pra Skripsi', 1, NULL, '7', 'Wajib', NULL),
	('MPB0-5301', 'Tugas Pemrograman Khusus', 2, '110 sks', '-', '-', NULL),
	('MPB0-5302', 'Etika Profesi', 2, '', '-', '-', NULL),
	('MPB0-5303', 'Skripsi', 4, '130 sks', '-', '-', NULL),
	('MPK0-3101', 'Bahasa Inggris Profesi', 2, '', '-', 'Wajib', NULL),
	('MPK0-3102', 'Pancasila', 2, '', '-', '-', NULL),
	('MPK0-3103', 'Agama', 3, '', '-', '-', NULL),
	('MPK0-3104', 'Bahasa Inggris Informatika', 2, '', '1', 'Wajib', NULL),
	('MPK0-3105', 'Metode Penelitian', 2, '', '4', 'Wajib', NULL),
	('MPK0-3106', 'Kewarganegaraan', 3, 'MPK0-3109', '4', 'Wajib', NULL),
	('MPK0-3107', 'Bahasa Indonesia', 3, '', '3', 'Wajib', NULL),
	('MPK0-3108', 'Pancasila dan Kewarganegaraan', 3, '', '-', '-', NULL),
	('MPK0-3109', 'Pancasila', 3, '', '3', 'Wajib', NULL),
	('MPK0-3140', 'Agama Islam', 3, '', '2', 'Wajib', NULL),
	('MPK0-3141', 'Agama Kristen', 3, '', '2', 'Wajib', NULL),
	('MPK0-3142', 'Agama Budha', 3, '', '2', 'Wajib', NULL),
	('MPK0-3143', 'Agama Hindu', 3, '', '2', 'Wajib', NULL),
	('MPK0-3301', 'Bahasa Inggris Profesi', 2, '', '-', '-', NULL),
	('MPK0-3302', 'Pancasila', 2, '', '-', '-', NULL),
	('MPK0-3303', 'Agama', 3, '', '-', '-', NULL),
	('MPK0-3304', 'Bahasa Inggris Informatika', 2, '', '-', '-', NULL),
	('MPK0-3305', 'Metode Penelitian', 2, '', '-', '-', NULL),
	('MPK0-5101', 'Bahasa Inggris Profesi', 2, '', '-', 'Wajib', NULL),
	('MPK0-5102', 'Pancasila', 2, '', '-', '-', NULL),
	('MPK0-5103', 'Agama', 3, '', '-', '-', NULL),
	('MPK0-5104', 'Bahasa Inggris Informatika', 2, '', '1', 'Wajib', NULL),
	('MPK0-5105', 'Kewarganegaraan', 3, '', '4', 'Wajib', NULL),
	('MPK0-5106', 'Metode Penelitian Informatika', 2, 'MPK0-5108', '-', NULL, NULL),
	('MPK0-5107', 'Ilmu Sosial Dan Budaya Dasar', 3, '', '-', 'Wajib', NULL),
	('MPK0-5108', 'Bahasa Indonesia', 3, '', '3', 'Wajib', NULL),
	('MPK0-5109', 'Pancasila Dan Kewarganegaraan', 3, '', '-', '-', NULL),
	('MPK0-5110', 'Pancasila', 3, '', '3', 'Wajib', NULL),
	('MPK0-5116', 'Metode Penelitian', 2, 'MPK0-5108', '6', 'Wajib', 'MENEMPUH'),
	('MPK0-5118', 'Metode Penelitian', 3, NULL, '-', 'Wajib', NULL),
	('MPK0-5140', 'Agama Islam', 3, '', '2', 'Wajib', NULL),
	('MPK0-5141', 'Agama Kristen', 3, '', '2', 'Wajib', NULL),
	('MPK0-5142', 'Agama Budha', 3, '', '2', 'Wajib', NULL),
	('MPK0-5143', 'Agama Hindu', 3, '', '2', 'Wajib', NULL),
	('MPK0-5201', 'Bahasa Inggris Profesi', 2, '', '-', 'Wajib', NULL),
	('MPK0-5202', 'Pancasila', 2, '', '-', '-', NULL),
	('MPK0-5203', 'Bahasa Inggris Informatika', 2, '', '1', 'Wajib', ''),
	('MPK0-5204', 'Agama', 3, '', '-', '-', NULL),
	('MPK0-5205', 'Kewarganegaraan', 3, '', '4', 'Wajib', NULL),
	('MPK0-5206', 'Metode Penelitian', 2, 'MPK0-5208', '6', 'Wajib', 'MENEMPUH'),
	('MPK0-5207', 'Pancasila Dan Kewarganegaraan', 3, '', '-', '-', NULL),
	('MPK0-5208', 'Bahasa Indonesia', 3, '', '3', 'Wajib', NULL),
	('MPK0-5209', 'Pancasila', 3, '', '3', 'Wajib', NULL),
	('MPK0-5211', 'Metode Penelitian', 3, NULL, '', 'Wajib', NULL),
	('MPK0-5240', 'Agama Islam', 3, '', '2', 'Wajib', NULL),
	('MPK0-5241', 'Agama Kristen', 3, '', '2', 'Wajib', NULL),
	('MPK0-5242', 'Agama budha', 3, '', '2', 'Wajib', NULL),
	('MPK0-5243', 'Agama Hindu', 3, '', '2', 'Wajib', NULL),
	('MPK0-5301', 'Bahasa Inggris Profesi', 2, '', '-', '-', NULL),
	('MPK0-5302', 'Pancasila', 2, '', '-', '-', NULL),
	('MPK0-5303', 'Bahasa Inggris Informatika', 2, '', '-', '-', NULL),
	('MPK0-5304', 'Agama', 3, '', '-', '-', NULL),
	('MPK0-5305', 'Metode Penelitian', 2, '', '-', '-', NULL),
	('MPK0-5306', 'Kewarganegaraan', 3, '', '-', '-', NULL);
/*!40000 ALTER TABLE `master_mata_kuliah` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_pangkat_dosen
CREATE TABLE IF NOT EXISTS `master_pangkat_dosen` (
  `jafa_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`jafa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_pangkat_dosen: ~4 rows (approximately)
DELETE FROM `master_pangkat_dosen`;
/*!40000 ALTER TABLE `master_pangkat_dosen` DISABLE KEYS */;
INSERT INTO `master_pangkat_dosen` (`jafa_id`, `nama`) VALUES
	(1, 'Lektor'),
	(2, 'Lektor Kepala'),
	(3, 'Asisten Ahli'),
	(4, 'Tenaga Pengajar');
/*!40000 ALTER TABLE `master_pangkat_dosen` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_prodi
CREATE TABLE IF NOT EXISTS `master_prodi` (
  `kode_prodi` varchar(15) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_prodi: ~2 rows (approximately)
DELETE FROM `master_prodi`;
/*!40000 ALTER TABLE `master_prodi` DISABLE KEYS */;
INSERT INTO `master_prodi` (`kode_prodi`, `nama`) VALUES
	('K51', 'Sistem informasi'),
	('K52', 'Teknologi Informasi');
/*!40000 ALTER TABLE `master_prodi` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_ruangan
CREATE TABLE IF NOT EXISTS `master_ruangan` (
  `ruangan_id` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`ruangan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_ruangan: ~17 rows (approximately)
DELETE FROM `master_ruangan`;
/*!40000 ALTER TABLE `master_ruangan` DISABLE KEYS */;
INSERT INTO `master_ruangan` (`ruangan_id`, `nama`) VALUES
	(1, 'Laboratorium Aplikasi'),
	(2, 'Laboratorium Jaringan Komputer'),
	(3, 'Laboratorium Sistem Operasi dan Multimedia'),
	(4, 'Perpustakaan'),
	(5, 'Ruang Kesehatan'),
	(6, 'Ruang Dosen'),
	(7, 'Ruang Recent'),
	(8, 'Musholla'),
	(9, 'Auditorium'),
	(10, 'Ruang BAAK'),
	(11, 'Ruang BAUK'),
	(12, 'Ruang Sekretariat Ketua'),
	(13, 'Ruang Sekretaris Program Studi'),
	(14, 'Ruang Informasi dan Pendaftaran'),
	(15, 'Ruang Kelas A.35'),
	(16, 'Ruang Kelas A.34'),
	(17, 'Ruang Kelas A.33'),
	(18, 'Ruang Kelas A.32'),
	(19, 'Ruang Kelas A.31');
/*!40000 ALTER TABLE `master_ruangan` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_status_daftar_mhs
CREATE TABLE IF NOT EXISTS `master_status_daftar_mhs` (
  `status_daftar_mhs_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`status_daftar_mhs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_status_daftar_mhs: ~3 rows (approximately)
DELETE FROM `master_status_daftar_mhs`;
/*!40000 ALTER TABLE `master_status_daftar_mhs` DISABLE KEYS */;
INSERT INTO `master_status_daftar_mhs` (`status_daftar_mhs_id`, `nama`) VALUES
	(1, 'Baru'),
	(2, 'Alih Jenjang'),
	(3, 'Pindahan');
/*!40000 ALTER TABLE `master_status_daftar_mhs` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_status_dosen
CREATE TABLE IF NOT EXISTS `master_status_dosen` (
  `status_dosen_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`status_dosen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_status_dosen: ~2 rows (approximately)
DELETE FROM `master_status_dosen`;
/*!40000 ALTER TABLE `master_status_dosen` DISABLE KEYS */;
INSERT INTO `master_status_dosen` (`status_dosen_id`, `nama`) VALUES
	(1, 'Dosen Luar Biasa'),
	(2, 'Dosen PNS DPK'),
	(3, 'Dosen Tetap');
/*!40000 ALTER TABLE `master_status_dosen` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_status_mhs
CREATE TABLE IF NOT EXISTS `master_status_mhs` (
  `status_mhs_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`status_mhs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_status_mhs: ~8 rows (approximately)
DELETE FROM `master_status_mhs`;
/*!40000 ALTER TABLE `master_status_mhs` DISABLE KEYS */;
INSERT INTO `master_status_mhs` (`status_mhs_id`, `nama`) VALUES
	(1, 'Lulus'),
	(2, 'Aktif'),
	(3, 'Non Aktif'),
	(4, 'Cuti'),
	(5, 'Kadaluarsa'),
	(6, 'Keluar'),
	(7, 'Tidak Dilaporkan'),
	(8, 'Mengundurkan Diri');
/*!40000 ALTER TABLE `master_status_mhs` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_tipe_nilai
CREATE TABLE IF NOT EXISTS `master_tipe_nilai` (
  `idmaster_tipe_nilai` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(45) NOT NULL DEFAULT '',
  `wajib` varchar(45) NOT NULL DEFAULT '' COMMENT 'wajib/prasyarat',
  PRIMARY KEY (`idmaster_tipe_nilai`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_tipe_nilai: ~4 rows (approximately)
DELETE FROM `master_tipe_nilai`;
/*!40000 ALTER TABLE `master_tipe_nilai` DISABLE KEYS */;
INSERT INTO `master_tipe_nilai` (`idmaster_tipe_nilai`, `nama`, `wajib`) VALUES
	(1, 'tugas1', ''),
	(2, 'uts', ''),
	(3, 'tugas2', ''),
	(4, 'uas', '');
/*!40000 ALTER TABLE `master_tipe_nilai` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_tipe_presensi
CREATE TABLE IF NOT EXISTS `master_tipe_presensi` (
  `id_master_presensi` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_master_presensi`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_tipe_presensi: ~4 rows (approximately)
DELETE FROM `master_tipe_presensi`;
/*!40000 ALTER TABLE `master_tipe_presensi` DISABLE KEYS */;
INSERT INTO `master_tipe_presensi` (`id_master_presensi`, `nama`) VALUES
	(1, 'Alpha'),
	(2, 'Hadir'),
	(3, 'Sakit'),
	(4, 'Izin');
/*!40000 ALTER TABLE `master_tipe_presensi` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_tugasakhir
CREATE TABLE IF NOT EXISTS `master_tugasakhir` (
  `master_tugasAkhir_id` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_tugas_akhir` varchar(50) NOT NULL,
  `jenjang` int(11) DEFAULT NULL,
  `kode_matkul` varchar(100) NOT NULL,
  PRIMARY KEY (`master_tugasAkhir_id`),
  KEY `FK__master_mata_kuliah` (`kode_matkul`),
  KEY `FK_master_tugasakhir_master_jenjang` (`jenjang`),
  CONSTRAINT `FK__master_mata_kuliah` FOREIGN KEY (`kode_matkul`) REFERENCES `master_mata_kuliah` (`kode_matkul`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_master_tugasakhir_master_jenjang` FOREIGN KEY (`jenjang`) REFERENCES `master_jenjang` (`id_master_jenjang`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_tugasakhir: ~2 rows (approximately)
DELETE FROM `master_tugasakhir`;
/*!40000 ALTER TABLE `master_tugasakhir` DISABLE KEYS */;
INSERT INTO `master_tugasakhir` (`master_tugasAkhir_id`, `jenis_tugas_akhir`, `jenjang`, `kode_matkul`) VALUES
	(1, 'Skripsi', 1, 'MPB0-5303'),
	(2, 'Pkti', 1, 'MPB0-5105'),
	(3, 'ta', 2, 'MPB0-3104');
/*!40000 ALTER TABLE `master_tugasakhir` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.master_waktu_presensi
CREATE TABLE IF NOT EXISTS `master_waktu_presensi` (
  `id_master_waktu_presensi` int(11) NOT NULL AUTO_INCREMENT,
  `keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_master_waktu_presensi`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.master_waktu_presensi: ~16 rows (approximately)
DELETE FROM `master_waktu_presensi`;
/*!40000 ALTER TABLE `master_waktu_presensi` DISABLE KEYS */;
INSERT INTO `master_waktu_presensi` (`id_master_waktu_presensi`, `keterangan`) VALUES
	(1, 'minggu1'),
	(2, 'minggu2'),
	(3, 'minggu3'),
	(4, 'minggu4'),
	(5, 'minggu5'),
	(6, 'minggu6'),
	(7, 'minggu7'),
	(8, 'minggu8'),
	(9, 'minggu9'),
	(10, 'minggu10'),
	(11, 'minggu11'),
	(12, 'minggu12'),
	(13, 'minggu13'),
	(14, 'minggu14'),
	(15, 'uts'),
	(16, 'uas');
/*!40000 ALTER TABLE `master_waktu_presensi` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.nilai_kaprodi
CREATE TABLE IF NOT EXISTS `nilai_kaprodi` (
  `id_nilai_kaprodi` int(11) NOT NULL AUTO_INCREMENT,
  `detail_krs_id` varchar(50) NOT NULL DEFAULT '0',
  `nilai` float NOT NULL DEFAULT '0',
  `dateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `keterangan` varchar(50) NOT NULL,
  `nip_kaprodi` varchar(100) NOT NULL,
  `nip_puskordat` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id_nilai_kaprodi`),
  KEY `FK_nilai_kaprodi_detail_krs` (`detail_krs_id`),
  KEY `FK_nilai_kaprodi_master_dosen` (`nip_kaprodi`),
  KEY `FK_nilai_kaprodi_master_dosen_2` (`nip_puskordat`),
  CONSTRAINT `FK_nilai_kaprodi_detail_krs` FOREIGN KEY (`detail_krs_id`) REFERENCES `detail_krs` (`detail_krs_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_nilai_kaprodi_master_dosen` FOREIGN KEY (`nip_kaprodi`) REFERENCES `master_karyawan` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_nilai_kaprodi_master_dosen_2` FOREIGN KEY (`nip_puskordat`) REFERENCES `master_karyawan` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.nilai_kaprodi: ~0 rows (approximately)
DELETE FROM `nilai_kaprodi`;
/*!40000 ALTER TABLE `nilai_kaprodi` DISABLE KEYS */;
/*!40000 ALTER TABLE `nilai_kaprodi` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.nilai_mhs
CREATE TABLE IF NOT EXISTS `nilai_mhs` (
  `idnilai_mhs` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detail_krs_id` varchar(50) NOT NULL DEFAULT '',
  `idmaster_tipe_nilai` int(10) unsigned NOT NULL DEFAULT '0',
  `nilai` float NOT NULL DEFAULT '0' COMMENT 'nilai asli',
  PRIMARY KEY (`idnilai_mhs`),
  KEY `FK_nilai_mhs_1` (`detail_krs_id`),
  KEY `FK_nilai_mhs_2` (`idmaster_tipe_nilai`),
  CONSTRAINT `FK_nilai_mhs_1` FOREIGN KEY (`detail_krs_id`) REFERENCES `detail_krs` (`detail_krs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_nilai_mhs_2` FOREIGN KEY (`idmaster_tipe_nilai`) REFERENCES `master_tipe_nilai` (`idmaster_tipe_nilai`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.nilai_mhs: ~0 rows (approximately)
DELETE FROM `nilai_mhs`;
/*!40000 ALTER TABLE `nilai_mhs` DISABLE KEYS */;
/*!40000 ALTER TABLE `nilai_mhs` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.nilai_tugasakhir
CREATE TABLE IF NOT EXISTS `nilai_tugasakhir` (
  `id_nilai_tugasAkhir` int(11) NOT NULL AUTO_INCREMENT,
  `detail_krs_id` varchar(50) NOT NULL DEFAULT '0',
  `nip` varchar(50) NOT NULL DEFAULT '0' COMMENT 'isi nilai untuk beberapa dosen pembimbing dan penguji',
  `master_tugasAkhir_id` int(11) DEFAULT NULL,
  `idmaster_tipe_nilai` int(10) unsigned DEFAULT NULL,
  `nilai` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_nilai_tugasAkhir`),
  KEY `FK_nilai_tugasakhir_master_tugasakhir` (`master_tugasAkhir_id`),
  KEY `FK_nilai_tugasakhir_master_tipe_nilai` (`idmaster_tipe_nilai`),
  KEY `FK_nilai_tugasakhir_3` (`nip`),
  KEY `FK_nilai_tugasakhir_detail_krs` (`detail_krs_id`),
  CONSTRAINT `FK_nilai_tugasakhir_3` FOREIGN KEY (`nip`) REFERENCES `master_karyawan` (`nip`),
  CONSTRAINT `FK_nilai_tugasakhir_detail_krs` FOREIGN KEY (`detail_krs_id`) REFERENCES `detail_krs` (`detail_krs_id`),
  CONSTRAINT `FK_nilai_tugasakhir_master_tipe_nilai` FOREIGN KEY (`idmaster_tipe_nilai`) REFERENCES `master_tipe_nilai` (`idmaster_tipe_nilai`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_nilai_tugasakhir_master_tugasakhir` FOREIGN KEY (`master_tugasAkhir_id`) REFERENCES `master_tugasakhir` (`master_tugasAkhir_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.nilai_tugasakhir: ~0 rows (approximately)
DELETE FROM `nilai_tugasakhir`;
/*!40000 ALTER TABLE `nilai_tugasakhir` DISABLE KEYS */;
/*!40000 ALTER TABLE `nilai_tugasakhir` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.pembayaran
CREATE TABLE IF NOT EXISTS `pembayaran` (
  `idpembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `nim` varchar(15) NOT NULL DEFAULT '0',
  `biaya_id` int(11) NOT NULL DEFAULT '0' COMMENT 'nama pembayaran',
  `tagihan_id` int(11) DEFAULT NULL,
  `bayar` float NOT NULL DEFAULT '0',
  `tgl_bayar` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nama_rekening_bayar` varchar(50) NOT NULL DEFAULT '0' COMMENT 'jika transfer',
  `id_master_jenis_pembayaran` int(11) NOT NULL DEFAULT '0' COMMENT 'tunai/transfer',
  `bukti` varchar(50) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL COMMENT 'tervefikasi/belom oleh BAU yang login',
  PRIMARY KEY (`idpembayaran`),
  KEY `FK_pembayaran_master_jenis_pembayaran` (`id_master_jenis_pembayaran`),
  KEY `FK_pembayaran_master_mahasiswa` (`nim`),
  KEY `FK_pembayaran_tagihan` (`tagihan_id`),
  KEY `FK_pembayaran_master_biaya` (`biaya_id`),
  CONSTRAINT `FK_pembayaran_master_biaya` FOREIGN KEY (`biaya_id`) REFERENCES `master_biaya` (`biaya_id`),
  CONSTRAINT `FK_pembayaran_master_jenis_pembayaran` FOREIGN KEY (`id_master_jenis_pembayaran`) REFERENCES `master_jenis_pembayaran` (`id_master_jenis_pembayaran`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaran_master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaran_tagihan` FOREIGN KEY (`tagihan_id`) REFERENCES `tagihan` (`tagihan_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.pembayaran: ~0 rows (approximately)
DELETE FROM `pembayaran`;
/*!40000 ALTER TABLE `pembayaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `pembayaran` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.presensi_mhs
CREATE TABLE IF NOT EXISTS `presensi_mhs` (
  `id_presensi_mhs` int(11) NOT NULL AUTO_INCREMENT,
  `krs_id` varchar(50) NOT NULL DEFAULT '0',
  `nim` varchar(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_presensi_mhs`),
  KEY `FK_presensi_mhs_1` (`krs_id`),
  KEY `FK_presensi_mhs_master_mahasiswa` (`nim`),
  CONSTRAINT `FK_presensi_mhs_1` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`),
  CONSTRAINT `FK_presensi_mhs_master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.presensi_mhs: ~0 rows (approximately)
DELETE FROM `presensi_mhs`;
/*!40000 ALTER TABLE `presensi_mhs` DISABLE KEYS */;
/*!40000 ALTER TABLE `presensi_mhs` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.rekap_konvesi
CREATE TABLE IF NOT EXISTS `rekap_konvesi` (
  `no_form` varchar(50) NOT NULL,
  `tahun_akademik` varchar(50) NOT NULL,
  `no_spphkn` varchar(50) NOT NULL,
  `id_konversiLama` int(11) NOT NULL DEFAULT '0',
  `id_konversiBaru` int(11) NOT NULL DEFAULT '0',
  `tgl_susunKonversi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nip_kaprodi` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`no_form`),
  KEY `FK_rekap_konvesi_konversi_lama` (`id_konversiLama`),
  KEY `FK_rekap_konvesi_konversi_baru` (`id_konversiBaru`),
  KEY `FK_rekap_konvesi_master_dosen` (`nip_kaprodi`),
  CONSTRAINT `FK_rekap_konvesi_konversi_baru` FOREIGN KEY (`id_konversiBaru`) REFERENCES `konversi_baru` (`id_konversiBaru`),
  CONSTRAINT `FK_rekap_konvesi_konversi_lama` FOREIGN KEY (`id_konversiLama`) REFERENCES `konversi_lama` (`id_konversiLama`),
  CONSTRAINT `FK_rekap_konvesi_master_dosen` FOREIGN KEY (`nip_kaprodi`) REFERENCES `master_karyawan` (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.rekap_konvesi: ~0 rows (approximately)
DELETE FROM `rekap_konvesi`;
/*!40000 ALTER TABLE `rekap_konvesi` DISABLE KEYS */;
/*!40000 ALTER TABLE `rekap_konvesi` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.rekap_nilai
CREATE TABLE IF NOT EXISTS `rekap_nilai` (
  `id_rekapNilai` int(11) NOT NULL AUTO_INCREMENT,
  `detail_krs_id` varchar(50) DEFAULT '0',
  `id_nilai_mhs` int(11) unsigned NOT NULL,
  `nilai` float DEFAULT '0',
  `status` varchar(50) DEFAULT '0' COMMENT 'untuk menandai matkul yang dipakai karena ada matkul yang mengulang (aktif/tidak aktif)',
  PRIMARY KEY (`id_rekapNilai`),
  KEY `FK_rekap_nilai_detail_krs` (`detail_krs_id`),
  KEY `FK_rekap_nilai_nilai_mhs` (`id_nilai_mhs`),
  CONSTRAINT `FK_rekap_nilai_detail_krs` FOREIGN KEY (`detail_krs_id`) REFERENCES `detail_krs` (`detail_krs_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_rekap_nilai_nilai_mhs` FOREIGN KEY (`id_nilai_mhs`) REFERENCES `nilai_mhs` (`idnilai_mhs`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.rekap_nilai: ~0 rows (approximately)
DELETE FROM `rekap_nilai`;
/*!40000 ALTER TABLE `rekap_nilai` DISABLE KEYS */;
/*!40000 ALTER TABLE `rekap_nilai` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.tagihan
CREATE TABLE IF NOT EXISTS `tagihan` (
  `tagihan_id` int(11) NOT NULL AUTO_INCREMENT,
  `nim` varchar(15) NOT NULL DEFAULT '',
  `biaya_id` int(11) NOT NULL DEFAULT '0',
  `jumlah_tagihan` float NOT NULL DEFAULT '0' COMMENT 'diambil dari jumlah bayar di master biaya(jumlah satuan)',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `total_tagihan` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`tagihan_id`),
  KEY `FK__master_mahasiswa` (`nim`),
  KEY `FK_tagihan_master_biaya` (`biaya_id`),
  CONSTRAINT `FK__master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tagihan_master_biaya` FOREIGN KEY (`biaya_id`) REFERENCES `master_biaya` (`biaya_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.tagihan: ~0 rows (approximately)
DELETE FROM `tagihan`;
/*!40000 ALTER TABLE `tagihan` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagihan` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.token_presensi
CREATE TABLE IF NOT EXISTS `token_presensi` (
  `id_token` int(11) NOT NULL AUTO_INCREMENT,
  `krs_id` varchar(50) DEFAULT NULL,
  `id_presensi_mhs` int(11) DEFAULT NULL,
  `datetimer` time DEFAULT '00:00:00',
  PRIMARY KEY (`id_token`),
  KEY `FK_token_presensi_krs` (`krs_id`),
  KEY `FK_token_presensi_master_presensi` (`id_presensi_mhs`) USING BTREE,
  CONSTRAINT `FK_token_presensi_2` FOREIGN KEY (`id_presensi_mhs`) REFERENCES `presensi_mhs` (`id_presensi_mhs`),
  CONSTRAINT `FK_token_presensi_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.token_presensi: ~0 rows (approximately)
DELETE FROM `token_presensi`;
/*!40000 ALTER TABLE `token_presensi` DISABLE KEYS */;
/*!40000 ALTER TABLE `token_presensi` ENABLE KEYS */;

-- Dumping structure for table siakad_stimata.yudisium
CREATE TABLE IF NOT EXISTS `yudisium` (
  `id_yudisium` int(11) NOT NULL AUTO_INCREMENT,
  `nim` varchar(50) NOT NULL DEFAULT '0',
  `jumlah_sks` float NOT NULL DEFAULT '0',
  `ipk` float NOT NULL DEFAULT '0',
  `predikat` varchar(50) NOT NULL DEFAULT '0',
  `tglYudisium` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tglCetak` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `noTrans` varchar(50) NOT NULL,
  `noIjazah` varchar(50) NOT NULL,
  `skLulus` varchar(50) NOT NULL,
  `nil` varchar(50) NOT NULL,
  `nsi` varchar(50) NOT NULL,
  `tahunLulus` varchar(50) NOT NULL,
  PRIMARY KEY (`id_yudisium`),
  KEY `FK_yudisium_master_mahasiswa` (`nim`),
  CONSTRAINT `FK_yudisium_master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table siakad_stimata.yudisium: ~0 rows (approximately)
DELETE FROM `yudisium`;
/*!40000 ALTER TABLE `yudisium` DISABLE KEYS */;
/*!40000 ALTER TABLE `yudisium` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
