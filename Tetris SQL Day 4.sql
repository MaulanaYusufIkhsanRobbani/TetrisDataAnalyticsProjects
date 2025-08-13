# Buat view
use minimart
Create view per_kasir as 
select kode_cabang, 
kode_kasir, 
count(*) total_transaksi_kasir 
from tr_penjualan tp 
group by 1,2;
select 
	kode_kasir, total_transaksi_cashier 
from detail_cashier;

#Klo dah kebuat view detail_cashier
CREATE PROCEDURE minimart.per_kasir_cabang(in cabang VARCHAR(16))
begin
	select kode_cabang,
	kode_kasir,
	COUNT(*) as total_transaksi_kasir
	from tr_penjualan tp
	group by 1,2;
end

#Buat lagi procedure, kasir_2_parameter
CREATE PROCEDURE minimart.kasir_2_parameter(in cabang VARCHAR(16), dates DATE)
begin
	select kode_cabang,
	kode_kasir,
	COUNT(*) as total_transaksi_kasir
	from tr_penjualan tp
	where kode_cabang=cabang
	group by 1,2;
	end
	
#2 param lagi
CREATE PROCEDURE minimart.kasir_2_parameter(in cabang VARCHAR(16), dates DATE)
begin
	select kode_cabang,
	kode_kasir,
	COUNT(*) as total_transaksi_kasir
	from tr_penjualan tp
	where kode_cabang=cabang
	and tgl_transaksi=dates
	group by 1,2;
	end