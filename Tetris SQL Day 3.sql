#day 3
-- select 
-- count(*)
-- from minimart.tr_penjualan ;
-- 
-- select 
-- count(1)
-- from minimart.tr_penjualan ;


-- select 
#utk ngitung banyanya yg kembar (klo distinct)
-- count(distinct kode_transaksi)
-- from 
-- minimart.tr_penjualan ;

-- 
-- select 
-- count(distinct kode_cabang)
-- from 
-- minimart.tr_penjualan ;
#Setelah count bisa as

-- select 
-- 	jenis_kelamin,
-- 	kode_cabang, 
-- 	count(*) as total_karyawan
-- from minimart.ms_karyawan
-- group by 1,2;

#group by klo agregat pas milih lebih dr 2 kolom
#having by buat filter

-- select 
-- 	jenis_kelamin,
-- 	kode_cabang, 
-- 	count(*) as total_karyawan
-- from minimart.ms_karyawan
-- group by 1,2
-- having count(*)<5;

#Order by,mengurutkan. Bisa asc & desc

-- select 
-- 	kode_produk, 
-- 	count(*) as total
-- from minimart.tr_penjualan 
-- group by 1
-- -- order by kode_produk ;
-- order by total desc
-- limit 5;

#String function
#upper lower left right replace trim substr
-- select 
-- left ("My name is What", 4) as Keterangan,
-- right ("My name is What", 4) as RightKeterangan,
-- lower ("My name is What", 4) as LowerFunction,
-- upper ("My name is What", 4) as UpperFunction,
-- trim ("		My name is What		", 4) as TrimFunction,
-- replace ("Tetris Program", "Beasiswa") as ReplaceFunction

#Numeric function

#Timestamp function (ekstrak bagian dari waktu)


#Exercise Part 3
-- select 
-- 	kode_cabang,
-- 	kode_produk,
-- 	max(jumlah_pembelian) as jumlah_pembelian 
-- from 
-- 	minimart.tr_penjualan 
-- group by 1,2
-- having 
-- 	max(jumlah_pembelian)>10
-- order by 3;
-- select 
-- 	tgl_transaksi,
-- 	cast(tgl_transaksi as date) tanggal_transaksi,
-- 	cast(tgl_transaksi as time) waktu_transaksi
-- from tr_penjualan 
-- limit 10;

#Case
-- select 
-- case 
-- 	when jumlah_pembelian > 10 then "Lebih dari 10"
-- 	when jumlah_pembelian > 5 then "Lebih dari 5"
-- 	else "Kurang atau sama dengan lima"
-- end as kelompok,
-- count(*) as jumlah
-- from minimart.tr_penjualan 
-- group by 1;

#If null
-- select 
-- ifnull(null, "tetris program") as value;

#Coalesce, mengisi kolom bersifat null data
-- select 
-- 	coalesce (null, "tetris",1,2) as one_value,
-- 	coalesce (null,null, "tetris",1,2) as second_value,
-- 	coalesce (null,null, null, "tetris",1,2) as third_value,
-- 	coalesce (null,null,null, null, "tetris",1,2) as fourth_value
-- ;

#Mengisi nilai kosong di tabel
-- UPDATE tr_penjualan 
-- set kode_kasir = 'NKA'
-- WHERE kode_kasir IS NULL;

#Exercise Part 4
-- select 
-- 	lower(nama_propinsi) as lowercase_provinsi
-- 	
-- from minimart.ms_propinsi ;
-- select 
-- 	count(100) as add_100
-- from minimart.tr_penjualan 

	
#Exercise Part 5




use minimart
SELECT *
FROM ms_harga_harian
WHERE (kode_cabang, harga_berlaku_cabang) IN
    (SELECT kode_cabang, MAX(harga_berlaku_cabang)
     FROM ms_harga_harian
     GROUP BY kode_cabang)
     
     
     
     
-- CTE
WITH total_per_cabang AS (
	SELECT 
		kode_cabang, 
		COUNT(*) AS jumlah_transaksi  
	FROM tr_penjualan
	GROUP BY 1
)
SELECT 
	AVG(jumlah_transaksi) AS avg_jumlah_transaksi
FROM total_per_cabang AS tpc
;


-- Windows Function
SELECT kode_kota,kode_cabang,
       COUNT(kode_cabang) AS Jumlah_cabang
FROM ms_cabang mc
WHERE kode_kota IN ('KOTA-001', 'KOTA-002', 'KOTA-003', 'KOTA-004', 'KOTA-005')
GROUP BY 1,2;

SELECT kode_kota,
kode_cabang,
COUNT(kode_cabang) over (PARTITION BY kode_kota) AS Jumlah_cabang
FROM ms_cabang mc
WHERE kode_kota IN ('KOTA-001', 'KOTA-002', 'KOTA-003', 'KOTA-004', 'KOTA-005')
GROUP BY 1,2;

-- window func 2
WITH total_per_cabang AS (
    SELECT 
        kode_cabang, 
        COUNT(*) AS jumlah_transaksi 
    FROM 
        tr_penjualan
    GROUP BY 
        kode_cabang
)
-- Selanjutnya, Anda dapat menggunakan CTE dalam kueri utama atau kueri lainnya
SELECT * 
FROM 
    total_per_cabang;