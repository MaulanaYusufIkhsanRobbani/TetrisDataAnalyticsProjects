use minimart
select 
	ms_cabang.kode_cabang,
	ms_cabang.nama_cabang,
	#kode_kota,
	ms_kota.nama_kota,
	ms_kota.kode_propinsi
from 
	ms_cabang 
inner join ms_kota on ms_cabang.kode_kota = ms_kota.kode_kota;