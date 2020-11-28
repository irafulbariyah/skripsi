-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 28, 2020 at 02:24 PM
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
-- Table structure for table `berita_acara`
--

CREATE TABLE `berita_acara` (
  `id_beritaAcara` int(11) NOT NULL,
  `krs_id` varchar(50) NOT NULL DEFAULT '0',
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'pertemuan ke order by tgl ascendding',
  `pokokBahasan` varchar(100) NOT NULL DEFAULT '0',
  `sub_pokokBahasan` varchar(100) NOT NULL DEFAULT '0',
  `sesuai_sap` varchar(15) NOT NULL DEFAULT '0' COMMENT 'ya/tidak'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `detail_krs`
--

CREATE TABLE `detail_krs` (
  `detail_krs_id` varchar(50) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `krs_id` varchar(50) NOT NULL,
  `nip` varchar(50) NOT NULL DEFAULT '0' COMMENT 'untuk ganti nilai oleh kaprodi',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'baru/ulang/ganti nilai',
  `tgl_krs` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `detail_presensi`
--

CREATE TABLE `detail_presensi` (
  `id_detail_presensi` int(11) NOT NULL,
  `master_presensi_id` int(11) NOT NULL DEFAULT '0' COMMENT 'cekal didapat dari perhitungan count di tabel detail presensi',
  `id_master_waktu_presensi` int(11) NOT NULL DEFAULT '0',
  `Datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `latitude` varchar(50) NOT NULL DEFAULT '0',
  `longitude` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_matkul`
--

CREATE TABLE `jadwal_matkul` (
  `jadwal_matkul_id` varchar(15) NOT NULL,
  `krs_id` varchar(50) DEFAULT NULL,
  `ruangan` int(11) DEFAULT NULL,
  `jam_mulai` timestamp NULL DEFAULT NULL,
  `jam_selesai` timestamp NULL DEFAULT NULL,
  `hari` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krs`
--

CREATE TABLE `krs` (
  `krs_id` varchar(50) NOT NULL COMMENT 'tabel krs yang mengelola kaprodi',
  `nip` varchar(100) NOT NULL DEFAULT '' COMMENT 'dosen pengampu',
  `kode_matkul` varchar(100) NOT NULL DEFAULT '',
  `semester` varchar(50) NOT NULL DEFAULT '',
  `tahun_akademik` varchar(50) NOT NULL DEFAULT '',
  `kelas` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'a/b = untuk pembagian setiap kelas berbeda record ',
  `toleransi_keterlambatan` varchar(50) NOT NULL DEFAULT '0',
  `kaprodi` varchar(50) DEFAULT NULL COMMENT 'tanda tangan berita acara-inputnakhir',
  `ketua_kelas` varchar(50) DEFAULT NULL COMMENT 'tanda tangan berita acara'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `login_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `master_hak_akses_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `penginput` varchar(100) NOT NULL DEFAULT '',
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'untuk cekal krs, 1.aktif 2.tercekal'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_biaya`
--

CREATE TABLE `master_biaya` (
  `biaya_id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL COMMENT 'spp/dpp',
  `angkatan` varchar(15) NOT NULL,
  `jumlah` float NOT NULL COMMENT 'jumlah per 1 sks & dpp'
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
-- Table structure for table `master_hak_akses`
--

CREATE TABLE `master_hak_akses` (
  `master_hak_akses_id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL DEFAULT ''
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
-- Table structure for table `master_jenis_pembayaran`
--

CREATE TABLE `master_jenis_pembayaran` (
  `id_master_jenis_pembayaran` int(11) NOT NULL,
  `keterangan` varchar(50) NOT NULL
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
-- Table structure for table `master_penelitian`
--

CREATE TABLE `master_penelitian` (
  `master_penelitian_id` varchar(50) NOT NULL,
  `jenis_penelitian` varchar(50) NOT NULL,
  `kode_matkul` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_presensi`
--

CREATE TABLE `master_presensi` (
  `master_presensi_id` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_presensi`
--

INSERT INTO `master_presensi` (`master_presensi_id`, `nama`) VALUES
(0, 'Alpha'),
(1, 'Hadir'),
(2, 'Sakit'),
(3, 'Izin');

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
-- Table structure for table `master_tipe_nilai`
--

CREATE TABLE `master_tipe_nilai` (
  `idmaster_tipe_nilai` int(10) UNSIGNED NOT NULL,
  `nama` varchar(45) NOT NULL DEFAULT '',
  `wajib` varchar(45) NOT NULL DEFAULT '' COMMENT 'wajib/prasyarat'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_tipe_nilai`
--

INSERT INTO `master_tipe_nilai` (`idmaster_tipe_nilai`, `nama`, `wajib`) VALUES
(1, 'tugas1', ''),
(2, 'uts', ''),
(3, 'tugas2', ''),
(4, 'uas', '');

-- --------------------------------------------------------

--
-- Table structure for table `master_waktu_presensi`
--

CREATE TABLE `master_waktu_presensi` (
  `id_master_waktu_presensi` int(11) NOT NULL,
  `keterangan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_waktu_presensi`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `nilai_kaprodi`
--

CREATE TABLE `nilai_kaprodi` (
  `id_nilai_kaprodi` int(11) NOT NULL,
  `detail_krs_id` varchar(50) NOT NULL DEFAULT '0',
  `nilai` float NOT NULL DEFAULT '0',
  `dateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `keterangan` varchar(50) NOT NULL,
  `nip_kaprodi` varchar(100) NOT NULL,
  `nip_puskordat` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nilai_mhs`
--

CREATE TABLE `nilai_mhs` (
  `idnilai_mhs` int(10) UNSIGNED NOT NULL,
  `detail_krs_id` varchar(50) NOT NULL DEFAULT '',
  `idmaster_tipe_nilai` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `nilai` float NOT NULL DEFAULT '0' COMMENT 'nilai asli'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `idpembayaran` int(11) NOT NULL,
  `nim` varchar(15) NOT NULL DEFAULT '0',
  `biaya_id` int(11) NOT NULL DEFAULT '0' COMMENT 'nama pembayaran',
  `bayar` float NOT NULL DEFAULT '0',
  `tgl_bayar` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nama_rekening_bayar` varchar(50) NOT NULL DEFAULT '0' COMMENT 'jika transfer',
  `id_master_jenis_pembayaran` int(11) NOT NULL DEFAULT '0' COMMENT 'tunai/transfer',
  `bukti` varchar(50) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL COMMENT 'tervefikasi/belom oleh BAU yang login'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `presensi_mhs`
--

CREATE TABLE `presensi_mhs` (
  `id_presensi_mhs` int(11) NOT NULL,
  `krs_id` varchar(50) NOT NULL DEFAULT '0',
  `nim` varchar(15) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rekap_nilai`
--

CREATE TABLE `rekap_nilai` (
  `id_rekapNilai` int(11) NOT NULL,
  `detail_krs_id` varchar(50) NOT NULL DEFAULT '0',
  `nilai` float NOT NULL DEFAULT '0',
  `status` varchar(50) NOT NULL DEFAULT '0' COMMENT 'untuk menandai matkul yang dipakai karena ada matkul yang mengulang (aktif/tidak aktif)'
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

-- --------------------------------------------------------

--
-- Table structure for table `tagihan`
--

CREATE TABLE `tagihan` (
  `tagihan_id` int(11) NOT NULL,
  `nim` varchar(15) NOT NULL DEFAULT '',
  `biaya_id` int(11) NOT NULL DEFAULT '0',
  `jumlah_tagihan` float NOT NULL DEFAULT '0' COMMENT 'diambil dari jumlah bayar di master biaya(jumlah satuan)',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `total_tagihan` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `berita_acara`
--
ALTER TABLE `berita_acara`
  ADD PRIMARY KEY (`id_beritaAcara`);

--
-- Indexes for table `detail_krs`
--
ALTER TABLE `detail_krs`
  ADD PRIMARY KEY (`detail_krs_id`),
  ADD KEY `FK__mahasiswa` (`nim`),
  ADD KEY `FK_detail_krs_krs` (`krs_id`),
  ADD KEY `FK_detail_krs_master_dosen` (`nip`);

--
-- Indexes for table `detail_presensi`
--
ALTER TABLE `detail_presensi`
  ADD PRIMARY KEY (`id_detail_presensi`),
  ADD KEY `FK__master_presensi` (`master_presensi_id`),
  ADD KEY `FK__master_waktu_presensi` (`id_master_waktu_presensi`);

--
-- Indexes for table `jadwal_matkul`
--
ALTER TABLE `jadwal_matkul`
  ADD PRIMARY KEY (`jadwal_matkul_id`),
  ADD KEY `FK_jadwal_matkul_krs` (`krs_id`),
  ADD KEY `FK_jadwal_matkul_master_ruangan` (`ruangan`);

--
-- Indexes for table `krs`
--
ALTER TABLE `krs`
  ADD PRIMARY KEY (`krs_id`),
  ADD KEY `FK__mata_kuliah` (`kode_matkul`),
  ADD KEY `FK_krs_dosen` (`nip`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `FK_login_master_hak_akses` (`master_hak_akses_id`);

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
-- Indexes for table `master_hak_akses`
--
ALTER TABLE `master_hak_akses`
  ADD PRIMARY KEY (`master_hak_akses_id`);

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
-- Indexes for table `master_jenis_pembayaran`
--
ALTER TABLE `master_jenis_pembayaran`
  ADD PRIMARY KEY (`id_master_jenis_pembayaran`);

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
  ADD KEY `FK_mahasiswa_3` (`status_mhs_id`),
  ADD KEY `FK_mahasiswa_dosen` (`dosen_wali_id`),
  ADD KEY `FK_mahasiswa_maba` (`no_pendaftaran`);

--
-- Indexes for table `master_mata_kuliah`
--
ALTER TABLE `master_mata_kuliah`
  ADD PRIMARY KEY (`kode_matkul`);

--
-- Indexes for table `master_penelitian`
--
ALTER TABLE `master_penelitian`
  ADD PRIMARY KEY (`master_penelitian_id`),
  ADD KEY `FK__master_mata_kuliah` (`kode_matkul`);

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
-- Indexes for table `master_tipe_nilai`
--
ALTER TABLE `master_tipe_nilai`
  ADD PRIMARY KEY (`idmaster_tipe_nilai`);

--
-- Indexes for table `master_waktu_presensi`
--
ALTER TABLE `master_waktu_presensi`
  ADD PRIMARY KEY (`id_master_waktu_presensi`);

--
-- Indexes for table `nilai_kaprodi`
--
ALTER TABLE `nilai_kaprodi`
  ADD PRIMARY KEY (`id_nilai_kaprodi`);

--
-- Indexes for table `nilai_mhs`
--
ALTER TABLE `nilai_mhs`
  ADD PRIMARY KEY (`idnilai_mhs`),
  ADD KEY `FK_nilai_mhs_1` (`detail_krs_id`),
  ADD KEY `FK_nilai_mhs_2` (`idmaster_tipe_nilai`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`idpembayaran`),
  ADD KEY `FK_pembayaran_master_mahasiswa` (`nim`),
  ADD KEY `FK_pembayaran_master_biaya` (`biaya_id`);

--
-- Indexes for table `presensi_mhs`
--
ALTER TABLE `presensi_mhs`
  ADD PRIMARY KEY (`id_presensi_mhs`),
  ADD KEY `FK_presensi_mhs_1` (`krs_id`),
  ADD KEY `FK_presensi_mhs_master_mahasiswa` (`nim`);

--
-- Indexes for table `rekap_nilai`
--
ALTER TABLE `rekap_nilai`
  ADD PRIMARY KEY (`id_rekapNilai`);

--
-- Indexes for table `rekap_presensi_mingguan`
--
ALTER TABLE `rekap_presensi_mingguan`
  ADD PRIMARY KEY (`presensi_id`),
  ADD KEY `FK_presensi_krs` (`krs_id`),
  ADD KEY `FK_presensi_mahasiswa` (`nim`);

--
-- Indexes for table `tagihan`
--
ALTER TABLE `tagihan`
  ADD PRIMARY KEY (`tagihan_id`),
  ADD KEY `FK__master_mahasiswa` (`nim`),
  ADD KEY `FK__master_biaya` (`biaya_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `berita_acara`
--
ALTER TABLE `berita_acara`
  MODIFY `id_beritaAcara` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_presensi`
--
ALTER TABLE `detail_presensi`
  MODIFY `id_detail_presensi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_jenis_pembayaran`
--
ALTER TABLE `master_jenis_pembayaran`
  MODIFY `id_master_jenis_pembayaran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_tipe_nilai`
--
ALTER TABLE `master_tipe_nilai`
  MODIFY `idmaster_tipe_nilai` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_waktu_presensi`
--
ALTER TABLE `master_waktu_presensi`
  MODIFY `id_master_waktu_presensi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `nilai_kaprodi`
--
ALTER TABLE `nilai_kaprodi`
  MODIFY `id_nilai_kaprodi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nilai_mhs`
--
ALTER TABLE `nilai_mhs`
  MODIFY `idnilai_mhs` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `idpembayaran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `presensi_mhs`
--
ALTER TABLE `presensi_mhs`
  MODIFY `id_presensi_mhs` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rekap_nilai`
--
ALTER TABLE `rekap_nilai`
  MODIFY `id_rekapNilai` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tagihan`
--
ALTER TABLE `tagihan`
  MODIFY `tagihan_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_krs`
--
ALTER TABLE `detail_krs`
  ADD CONSTRAINT `FK__mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_detail_krs_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_detail_krs_master_dosen` FOREIGN KEY (`nip`) REFERENCES `master_dosen` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_presensi`
--
ALTER TABLE `detail_presensi`
  ADD CONSTRAINT `FK__master_presensi` FOREIGN KEY (`master_presensi_id`) REFERENCES `master_presensi` (`master_presensi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK__master_waktu_presensi` FOREIGN KEY (`id_master_waktu_presensi`) REFERENCES `master_waktu_presensi` (`id_master_waktu_presensi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jadwal_matkul`
--
ALTER TABLE `jadwal_matkul`
  ADD CONSTRAINT `FK_jadwal_matkul_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_jadwal_matkul_master_ruangan` FOREIGN KEY (`ruangan`) REFERENCES `master_ruangan` (`ruangan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `krs`
--
ALTER TABLE `krs`
  ADD CONSTRAINT `FK__mata_kuliah` FOREIGN KEY (`kode_matkul`) REFERENCES `master_mata_kuliah` (`kode_matkul`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_krs_dosen` FOREIGN KEY (`nip`) REFERENCES `master_dosen` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `FK_login_master_hak_akses` FOREIGN KEY (`master_hak_akses_id`) REFERENCES `master_hak_akses` (`master_hak_akses_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `FK_mahasiswa_3` FOREIGN KEY (`status_mhs_id`) REFERENCES `master_status_mhs` (`status_mhs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mahasiswa_dosen` FOREIGN KEY (`dosen_wali_id`) REFERENCES `master_dosen` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mahasiswa_maba` FOREIGN KEY (`no_pendaftaran`) REFERENCES `master_maba` (`no_pendaftaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `master_penelitian`
--
ALTER TABLE `master_penelitian`
  ADD CONSTRAINT `FK__master_mata_kuliah` FOREIGN KEY (`kode_matkul`) REFERENCES `master_mata_kuliah` (`kode_matkul`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nilai_mhs`
--
ALTER TABLE `nilai_mhs`
  ADD CONSTRAINT `FK_nilai_mhs_1` FOREIGN KEY (`detail_krs_id`) REFERENCES `detail_krs` (`detail_krs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_nilai_mhs_2` FOREIGN KEY (`idmaster_tipe_nilai`) REFERENCES `master_tipe_nilai` (`idmaster_tipe_nilai`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `FK_pembayaran_master_biaya` FOREIGN KEY (`biaya_id`) REFERENCES `master_biaya` (`biaya_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_pembayaran_master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `presensi_mhs`
--
ALTER TABLE `presensi_mhs`
  ADD CONSTRAINT `FK_presensi_mhs_1` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`),
  ADD CONSTRAINT `FK_presensi_mhs_master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`);

--
-- Constraints for table `rekap_presensi_mingguan`
--
ALTER TABLE `rekap_presensi_mingguan`
  ADD CONSTRAINT `FK_presensi_krs` FOREIGN KEY (`krs_id`) REFERENCES `krs` (`krs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_presensi_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tagihan`
--
ALTER TABLE `tagihan`
  ADD CONSTRAINT `FK__master_biaya` FOREIGN KEY (`biaya_id`) REFERENCES `master_biaya` (`biaya_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK__master_mahasiswa` FOREIGN KEY (`nim`) REFERENCES `master_mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
