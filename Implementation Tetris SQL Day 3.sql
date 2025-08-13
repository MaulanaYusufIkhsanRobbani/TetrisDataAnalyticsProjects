select 
	kode_transaksi,
	Count(kode_cabang),
	jumlah_pembelian
from
	minimart.tr_penjualan 
where
	(kode_transaksi between 1 and 2000)
group by 	#Pengelompokan berdasarkan yg g diinput
	kode_transaksi, 
	jumlah_pembelian
#having kyk where tp bisa nerapin aggregate function
	#aggregate function = count(),avg(), sum()dsb
having count(jumlah_pembelian)<10
#klo asc gk perlu ditulis
order by 
	jumlah_pembelian desc
	;