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

-- Data exporting was unselected.

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
  CONSTRAINT `FK_detail_krs_master_dosen` FOREIGN KEY (`nip`) REFERENCES `master_dosen` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.detail_presensi
CREATE TABLE IF NOT EXISTS `detail_presensi` (
  `id_detail_presensi` int(11) NOT NULL AUTO_INCREMENT,
  `master_presensi_id` int(11) DEFAULT NULL COMMENT 'cekal didapat dari perhitungan count di tabel detail presensi',
  `id_master_waktu_presensi` int(11) DEFAULT '0',
  `Datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `latitude` varchar(50) DEFAULT '0',
  `longitude` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id_detail_presensi`),
  KEY `FK_detail_presensi_master_presensi` (`master_presensi_id`),
  KEY `FK_detail_presensi_master_waktu_presensi` (`id_master_waktu_presensi`),
  CONSTRAINT `FK_detail_presensi_master_presensi` FOREIGN KEY (`master_presensi_id`) REFERENCES `master_tipe_presensi` (`id_master_presensi`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_detail_presensi_master_waktu_presensi` FOREIGN KEY (`id_master_waktu_presensi`) REFERENCES `master_waktu_presensi` (`id_master_waktu_presensi`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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
  KEY `FK_detail_tugasakhir_master_dosen` (`pembimbing1`),
  KEY `FK_detail_tugasakhir_master_dosen_2` (`pembimbing2`),
  KEY `FK_detail_tugasakhir_master_dosen_3` (`penguji1`),
  KEY `FK_detail_tugasakhir_master_dosen_4` (`penguji2`),
  KEY `FK_detail_tugasakhir_master_dosen_5` (`penguji3`),
  CONSTRAINT `FK_detail_tugasakhir_master_dosen_3` FOREIGN KEY (`penguji1`) REFERENCES `master_dosen` (`nip`),
  CONSTRAINT `FK_detail_tugasakhir_master_dosen_4` FOREIGN KEY (`penguji2`) REFERENCES `master_dosen` (`nip`),
  CONSTRAINT `FK_detail_tugasakhir_master_dosen_5` FOREIGN KEY (`penguji3`) REFERENCES `master_dosen` (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.krs
CREATE TABLE IF NOT EXISTS `krs` (
  `krs_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'tabel krs yang mengelola kaprodi',
  `nip` varchar(100) NOT NULL DEFAULT '' COMMENT 'dosen pengampu',
  `kode_matkul` varchar(100) NOT NULL DEFAULT '',
  `semester` varchar(50) NOT NULL DEFAULT '',
  `tahun_akademik` varchar(50) NOT NULL DEFAULT '',
  `id_master_jenjang` int(10) unsigned DEFAULT NULL,
  `kode_prodi` int(10) unsigned DEFAULT NULL,
  `id_master_kelas` int(10) unsigned DEFAULT NULL COMMENT 'a/b = untuk pembagian setiap kelas berbeda record ',
  `toleransi_keterlambatan` varchar(50) NOT NULL DEFAULT '0',
  `kaprodi` varchar(50) DEFAULT NULL COMMENT 'tanda tangan berita acara-inputnakhir',
  `ketua_kelas` varchar(50) DEFAULT NULL COMMENT 'tanda tangan berita acara',
  PRIMARY KEY (`krs_id`),
  KEY `FK__mata_kuliah` (`kode_matkul`),
  KEY `FK_krs_dosen` (`nip`),
  KEY `FK_krs_1` (`id_master_kelas`),
  CONSTRAINT `FK_krs_1` FOREIGN KEY (`id_master_kelas`) REFERENCES `master_kelas` (`id_master_kelas`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_biaya
CREATE TABLE IF NOT EXISTS `master_biaya` (
  `biaya_id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL COMMENT 'spp/dpp',
  `angkatan` varchar(15) NOT NULL,
  `kelas` varchar(50) DEFAULT NULL,
  `jenjang` varchar(50) DEFAULT NULL,
  `jumlah` float NOT NULL COMMENT 'jumlah per 1 sks & dpp',
  PRIMARY KEY (`biaya_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_bobot_nilai
CREATE TABLE IF NOT EXISTS `master_bobot_nilai` (
  `bobot_nilai_id` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` varchar(15) DEFAULT NULL,
  `indeks` float DEFAULT NULL,
  `predikat` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bobot_nilai_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_dosen
CREATE TABLE IF NOT EXISTS `master_dosen` (
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
  KEY `FK_master_dosen_master_jabatan_dosen` (`jabatan_id`),
  KEY `FK_master_dosen_master_jafa_dosen` (`jafa_id`),
  CONSTRAINT `FK_dosen_3` FOREIGN KEY (`status_dosen_id`) REFERENCES `master_status_dosen` (`status_dosen_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_master_dosen_master_jabatan_dosen` FOREIGN KEY (`jabatan_id`) REFERENCES `master_jabatan_dosen` (`jabatan_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_master_dosen_master_jafa_dosen` FOREIGN KEY (`jafa_id`) REFERENCES `master_pangkat_dosen` (`jafa_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_hak_akses
CREATE TABLE IF NOT EXISTS `master_hak_akses` (
  `master_hak_akses_id` int(10) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`master_hak_akses_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_jabatan_dosen
CREATE TABLE IF NOT EXISTS `master_jabatan_dosen` (
  `jabatan_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`jabatan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_jenis_pembayaran
CREATE TABLE IF NOT EXISTS `master_jenis_pembayaran` (
  `id_master_jenis_pembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`id_master_jenis_pembayaran`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_jenjang
CREATE TABLE IF NOT EXISTS `master_jenjang` (
  `id_master_jenjang` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_master_jenjang`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_kalender_akademik
CREATE TABLE IF NOT EXISTS `master_kalender_akademik` (
  `kalender_akademik_id` int(11) NOT NULL AUTO_INCREMENT,
  `kegiatan` varchar(100) DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_akhir` date DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kalender_akademik_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_kelas
CREATE TABLE IF NOT EXISTS `master_kelas` (
  `id_master_kelas` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_master_kelas`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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
  `dosen_wali_id` varchar(100) NOT NULL DEFAULT '0' COMMENT 'foreign ke master dosen untuk relasi dosen wali',
  PRIMARY KEY (`nim`),
  KEY `FK_mahasiswa_1` (`kode_prodi`),
  KEY `FK_mahasiswa_3` (`status_mhs_id`),
  KEY `FK_mahasiswa_dosen` (`dosen_wali_id`),
  KEY `FK_mahasiswa_maba` (`no_pendaftaran`),
  KEY `FK_master_mahasiswa_1` (`id_master_kelas`),
  KEY `FK_master_mahasiswa_2` (`id_master_jenjang`),
  CONSTRAINT `FK_master_mahasiswa_1` FOREIGN KEY (`id_master_kelas`) REFERENCES `master_kelas` (`id_master_kelas`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_master_mahasiswa_2` FOREIGN KEY (`id_master_jenjang`) REFERENCES `master_jenjang` (`id_master_jenjang`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_pangkat_dosen
CREATE TABLE IF NOT EXISTS `master_pangkat_dosen` (
  `jafa_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`jafa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_prodi
CREATE TABLE IF NOT EXISTS `master_prodi` (
  `kode_prodi` varchar(15) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_ruangan
CREATE TABLE IF NOT EXISTS `master_ruangan` (
  `ruangan_id` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`ruangan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_status_daftar_mhs
CREATE TABLE IF NOT EXISTS `master_status_daftar_mhs` (
  `status_daftar_mhs_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`status_daftar_mhs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_status_dosen
CREATE TABLE IF NOT EXISTS `master_status_dosen` (
  `status_dosen_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`status_dosen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_status_mhs
CREATE TABLE IF NOT EXISTS `master_status_mhs` (
  `status_mhs_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`status_mhs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_tipe_nilai
CREATE TABLE IF NOT EXISTS `master_tipe_nilai` (
  `idmaster_tipe_nilai` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(45) NOT NULL DEFAULT '',
  `wajib` varchar(45) NOT NULL DEFAULT '' COMMENT 'wajib/prasyarat',
  PRIMARY KEY (`idmaster_tipe_nilai`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_tipe_presensi
CREATE TABLE IF NOT EXISTS `master_tipe_presensi` (
  `id_master_presensi` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_master_presensi`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.master_waktu_presensi
CREATE TABLE IF NOT EXISTS `master_waktu_presensi` (
  `id_master_waktu_presensi` int(11) NOT NULL AUTO_INCREMENT,
  `keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_master_waktu_presensi`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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
  CONSTRAINT `FK_nilai_kaprodi_master_dosen` FOREIGN KEY (`nip_kaprodi`) REFERENCES `master_dosen` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_nilai_kaprodi_master_dosen_2` FOREIGN KEY (`nip_puskordat`) REFERENCES `master_dosen` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.nilai_tugasakhir
CREATE TABLE IF NOT EXISTS `nilai_tugasakhir` (
  `id_nilai_tugasAkhir` int(11) NOT NULL AUTO_INCREMENT,
  `detail_krs_id` varchar(50) NOT NULL DEFAULT '0',
  `nip` varchar(50) NOT NULL DEFAULT '0' COMMENT 'isi nilai untuk beberapa dosen pembimbing dan penguji',
  `master_tugasAkhir_id` int(11) DEFAULT NULL,
  `idmaster_tipe_nilai` int(10) unsigned DEFAULT NULL,
  `nilai` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_nilai_tugasAkhir`),
  KEY `FK_nilai_tugasakhir_detail_krs` (`detail_krs_id`),
  KEY `FK_nilai_tugasakhir_master_dosen` (`nip`),
  KEY `FK_nilai_tugasakhir_master_tugasakhir` (`master_tugasAkhir_id`),
  KEY `FK_nilai_tugasakhir_master_tipe_nilai` (`idmaster_tipe_nilai`),
  CONSTRAINT `FK_nilai_tugasakhir_master_tipe_nilai` FOREIGN KEY (`idmaster_tipe_nilai`) REFERENCES `master_tipe_nilai` (`idmaster_tipe_nilai`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_nilai_tugasakhir_master_tugasakhir` FOREIGN KEY (`master_tugasAkhir_id`) REFERENCES `master_tugasakhir` (`master_tugasAkhir_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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
  KEY `FK_pembayaran_master_biaya` (`biaya_id`),
  KEY `FK_pembayaran_master_mahasiswa` (`nim`),
  KEY `FK_pembayaran_tagihan` (`tagihan_id`),
  CONSTRAINT `FK_pembayaran_master_biaya` FOREIGN KEY (`biaya_id`) REFERENCES `master_biaya` (`biaya_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaran_master_jenis_pembayaran` FOREIGN KEY (`id_master_jenis_pembayaran`) REFERENCES `master_jenis_pembayaran` (`id_master_jenis_pembayaran`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaran_master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaran_tagihan` FOREIGN KEY (`tagihan_id`) REFERENCES `tagihan` (`tagihan_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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
  CONSTRAINT `FK_rekap_konvesi_master_dosen` FOREIGN KEY (`nip_kaprodi`) REFERENCES `master_dosen` (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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
  KEY `FK__master_biaya` (`biaya_id`),
  CONSTRAINT `FK__master_biaya` FOREIGN KEY (`biaya_id`) REFERENCES `master_biaya` (`biaya_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK__master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table siakad_stimata.token_presensi
CREATE TABLE IF NOT EXISTS `token_presensi` (
  `id_token` int(11) NOT NULL AUTO_INCREMENT,
  `krs_id` varchar(50) DEFAULT NULL,
  `id_master_presensi` int(11) DEFAULT '0',
  `datetimer` time DEFAULT '00:00:00',
  PRIMARY KEY (`id_token`),
  KEY `FK_token_presensi_krs` (`krs_id`),
  KEY `FK_token_presensi_master_presensi` (`id_master_presensi`),
  CONSTRAINT `FK_token_presensi_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_token_presensi_master_presensi` FOREIGN KEY (`id_master_presensi`) REFERENCES `master_tipe_presensi` (`id_master_presensi`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
