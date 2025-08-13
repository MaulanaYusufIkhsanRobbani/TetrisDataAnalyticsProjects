
#
select mk.kode_cabang, 
	count(distinct kode_karyawan),
	count(distinct kode_produk)
from ms_karyawan mk
join tr_penjualan tp on mk.kode_cabang = tp.kode_cabang 
group by 1;
