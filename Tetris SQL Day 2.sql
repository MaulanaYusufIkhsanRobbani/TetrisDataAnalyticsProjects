-- use minimart;
-- SELECT 
-- 	kode_cabang, 
-- 	kode_produk, 
-- 	max(jumlah_pembelian) jumlah_pembelian 
-- FROM tr_penjualan 
-- GROUP BY 
-- 	kode_cabang,
-- 	kode_produk

##day 2
-- select 
-- kode_cabang  
-- from 
-- tr_penjualan 
-- limit 10;
## saran: sintaks perlu capslock utk bedain formula sm kolom

## Mengambil kode cabang unik dg distinct
-- select distinct 
-- kode_cabang
-- from tr_penjualan;

##menggunakan alias utk rename nama kolom
##tp gk ngerubah database
-- select distinct 
--  	kode_cabang as cabang
-- from ms_cabang ;

#Where
-- select * from tr_penjualan 
-- where tgl_transaksi >= '2008-12-30';

#Where and or
-- select 
-- 	kode_produk,
-- 	tgl_berlaku,
-- 	kode_cabang 
-- from ms_harga_harian mhh  
-- where tgl_berlaku  >= '2008-12-29'
-- and kode_cabang  = 'CABANG-047';

#where and and or
-- select 
-- kode_produk ,
-- tgl_berlaku ,
-- kode_cabang 
-- from ms_harga_harian
-- where kode_produk = 'PROD-0000001' 
-- and tgl_berlaku = '2008-01-01 00:00:00'
-- or kode_cabang ='CABANG-047';

#where beetween
-- select 
-- kode_produk ,
-- tgl_berlaku ,
-- kode_cabang 
-- from ms_harga_harian
-- where  
-- tgl_berlaku = '2008-01-01 00:00:00'
-- ;

#where in, where not in
-- select 
-- kode_produk ,
-- tgl_berlaku ,
-- kode_cabang 
-- from ms_harga_harian
-- where kode_cabang not in ('CABANG-039' , 'CABANG-047');

#where null is null

#where like not like, bandingin kesamaan
# a% = isi field awalan a
# %a = isi field akhirn a
# %a% posisi manapun
# _a% a posisi huruf ke2
# %a__
# a%a depan akhir

-- select *
-- from 
-- ms_propinsi
-- where nama_propinsi like 'Bali%';
