# Soal no 1
select distinct mc.nama_cabang, mk.nama_kota
from ms_cabang mc
join ms_kota mk on mc.kode_kota = mk.kode_kota
join tr_penjualan tp on mc.kode_cabang = tp.kode_cabang
where tp.jumlah_pembelian is not null;


#Soal no 2
SELECT mc.nama_cabang, mk.nama_kota
FROM ms_cabang mc
JOIN ms_kota mk ON mc.kode_kota = mk.kode_kota
LEFT JOIN tr_penjualan tp ON mc.kode_cabang = tp.kode_cabang
WHERE tp.kode_cabang IS null and mk.kode_kota is not null;



#Soal no 3
SELECT 
    mk.nama_kota,
    GROUP_CONCAT(DISTINCT CASE WHEN tp.kode_cabang IS NOT NULL THEN mc.nama_cabang END) AS cabang_berjualan ,
    GROUP_CONCAT(DISTINCT CASE WHEN tp.kode_cabang IS NULL THEN mc.nama_cabang END) AS cabang_tidak_berjualan
FROM 
    ms_kota mk
LEFT JOIN 
    ms_cabang mc ON mk.kode_kota = mc.kode_kota
LEFT JOIN 
    tr_penjualan tp ON mc.kode_cabang = tp.kode_cabang
-- where tp.kode_cabang is not null
GROUP BY 
    mk.nama_kota;

   
#Soal no 4
select count(distinct tp.kode_produk) as jumlah_produk_terjual
from tr_penjualan tp 
where tp.kode_kasir = '039-127' and date(tp.tgl_transaksi) = '2008-08-08';

#Soal no 5 Ada berapa cabang di Provinsi Yogyakarta? 
SELECT COUNT(DISTINCT mc.kode_cabang) AS jumlah_cabang
FROM ms_cabang mc
JOIN ms_kota mk ON mc.kode_kota = mk.kode_kota
WHERE mk.kode_propinsi = 'P31';

#Soal no 6 Berapa total keuntungan yang didapat pada tanggal 8 Agustus 2008 pada cabang Makassar 01

SELECT
    mc.nama_cabang,
    SUM(tp.jumlah_pembelian *(mhh.harga_berlaku_cabang - ( mhh.modal_cabang + mhh.biaya_cabang))) AS total_keuntungan
FROM
    tr_penjualan tp
JOIN
    ms_harga_harian mhh ON tp.kode_produk = mhh.kode_produk and mhh.kode_cabang = tp.kode_cabang and date(mhh.tgl_berlaku)=date(tp.tgl_transaksi)
JOIN
    ms_cabang mc  ON tp.kode_cabang = mc.kode_cabang
WHERE
    mc.nama_cabang = 'PHI Mini Market - Makassar 01' AND DATE(tp.tgl_transaksi) = '2008-08-08'
    
GROUP BY
    mc.nama_cabang, tp.tgl_transaksi;

   #Soal no 7
#CTE & Window function
WITH TotalKasir AS (
    SELECT
        kode_kasir,
        kode_cabang,
        SUM(jumlah_pembelian) AS total_transaksi_kasir
    FROM
        tr_penjualan
    GROUP BY
        kode_kasir, kode_cabang
)
SELECT
    kode_kasir,
    total_transaksi_kasir,
    SUM(total_transaksi_kasir) OVER (PARTITION BY kode_cabang) AS total_transaksi_cabang
FROM
    TotalKasir;
 #Subquery & window function
SELECT
    kode_kasir,
    SUM(jumlah_pembelian) AS total_transaksi_kasir,
    SUM(SUM(jumlah_pembelian)) OVER (PARTITION BY kode_cabang) AS total_transaksi_cabang
FROM
    tr_penjualan
GROUP BY
    kode_kasir, kode_cabang;
# CTE & join
WITH TotalKasir AS (
    SELECT
        tp.kode_kasir,
        mc.kode_cabang,
        SUM(tp.jumlah_pembelian) AS total_transaksi_kasir
    FROM
        tr_penjualan tp
    JOIN
        ms_cabang mc ON tp.kode_cabang = mc.kode_cabang
    GROUP BY
        tp.kode_kasir, mc.kode_cabang
)
SELECT
    kode_kasir,
    total_transaksi_kasir,
    SUM(total_transaksi_kasir) OVER (PARTITION BY kode_cabang) AS total_transaksi_cabang
FROM
    TotalKasir;
   
#Soal no 8

ALTER TABLE ms_produk
ADD COLUMN profit_per_produk DECIMAL(10, 2);

UPDATE ms_produk
SET
  profit_per_produk = (
    SELECT
      SUM(
        (
          tr_penjualan.jumlah_pembelian * (
            ms_harga_harian.harga_berlaku_cabang - ms_harga_harian.modal_cabang
          )
        ) - ms_harga_harian.biaya_cabang
      )
    FROM
      tr_penjualan
      INNER JOIN ms_harga_harian ON tr_penjualan.kode_produk = ms_harga_harian.kode_produk
    WHERE
      ms_produk.kode_produk = tr_penjualan.kode_produk
  );

ALTER TABLE ms_produk
ADD COLUMN group_produk VARCHAR(50);


with ranking_produk as(
select
	mhh.kode_cabang, nama_produk,
	sum((mhh.harga_berlaku_cabang-(mhh.modal_cabang+mhh.biaya_cabang))*tp.jumlah_pembelian) as profit_per_produk
from ms_harga_harian mhh
join tr_penjualan tp on mhh.kode_produk = tp.kode_produk
and mhh.tgl_berlaku = tp.tgl_transaksi and mhh.kode_cabang = tp.kode_cabang 
join ms_produk mp on tp.kode_produk =mp.kode_produk
group by 1,2
order by profit_per_produk
)
select *,
	ntile (4) over (order by profit_per_produk desc) as group_produk
from ranking_produk as rp

#Soal no 9

select distinct 
  nama_kota,
  COUNT(nama_cabang) AS total_cabang,
  SUM(jumlah_pembelian) AS jumlah_penjualan_cabang,
  (
    select distinct 
      SUM(jumlah_pembelian)
    FROM
      tr_penjualan
  ) AS jumlah_penjualan_seluruh_cabang,
  SUM(jumlah_pembelian) / (
    SELECT
      SUM(jumlah_pembelian)
    FROM
      tr_penjualan
  ) AS rate
FROM
  ms_kota
  JOIN ms_cabang ON ms_kota.kode_kota = ms_cabang.kode_kota
  JOIN tr_penjualan ON ms_cabang.kode_cabang = tr_penjualan.kode_cabang
GROUP BY
  nama_kota;
  
 
 #Soal no 10
 WITH MonthlyPerformance AS (
    SELECT
        DATE_FORMAT(tgl_transaksi, '%Y-%m') AS month,
        kode_cabang,
        SUM(jumlah_pembelian) AS jumlah_transaksi
    FROM
        tr_penjualan
    WHERE
        YEAR(tgl_transaksi) = 2008
    GROUP BY
        month, kode_cabang
),
PreviousMonthlyPerformance AS (
    SELECT
        DATE_FORMAT(tgl_transaksi, '%Y-%m') AS month,
        kode_cabang,
        SUM(jumlah_pembelian) AS previous_jumlah_transaksi
    FROM
        tr_penjualan
    WHERE
        YEAR(tgl_transaksi) = 2008 AND MONTH(tgl_transaksi) != 1
    GROUP BY
        month, kode_cabang
)
SELECT
    mp.month,
    mp.kode_cabang,
    mp.jumlah_transaksi,
    COALESCE(pmp.previous_jumlah_transaksi, 0) AS previous_jumlah_transaksi,
    CASE
        WHEN COALESCE(pmp.previous_jumlah_transaksi, 0) = 0 THEN NULL
        ELSE mp.jumlah_transaksi / COALESCE(pmp.previous_jumlah_transaksi, 0)
    END AS rate,
    CASE
        WHEN COALESCE(pmp.previous_jumlah_transaksi, 0) = 0 THEN NULL
        WHEN mp.jumlah_transaksi / COALESCE(pmp.previous_jumlah_transaksi, 0) < 0 THEN 'Negatif'
        ELSE 'Positif'
    END AS keterangan
FROM
    MonthlyPerformance mp
LEFT JOIN
    PreviousMonthlyPerformance pmp ON mp.kode_cabang = pmp.kode_cabang AND mp.month = pmp.month
where mp.kode_cabang in ('CABANG-039','CABANG-047');

#Soal no 11
SELECT 
    mk.nama_depan,
    mk.nama_belakang,
    mkj.nama_kota,
    SUM(tp.jumlah_pembelian * (mh.harga_berlaku_cabang - mh.biaya_cabang)) AS profit
FROM
    ms_karyawan mk
JOIN
    tr_penjualan tp ON mk.kode_karyawan = tp.kode_kasir
JOIN
    ms_cabang mc ON tp.kode_cabang = mc.kode_cabang
JOIN
    ms_kota mkj ON mc.kode_kota = mkj.kode_kota
JOIN
    ms_harga_harian mh ON tp.kode_produk = mh.kode_produk
GROUP BY
    mk.kode_karyawan, mk.nama_depan, mk.nama_belakang, mkj.nama_kota;
