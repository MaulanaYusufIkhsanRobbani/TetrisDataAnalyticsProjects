#Try to implement all command in one
select distinct #distinct utk nampilin nilai unik
kode_transaksi as kode,#as ngubah nama kolom 
tgl_transaksi as tanggal,
kode_cabang ,
kode_kasir 
from minimart.tr_penjualan
#Kondisi menyesuaikan isi kolom yg diinginkan
#Bisa =,=>, !=,<,>
#and=2 hal terpenuhi, or=1 aja dah bener
#and or bisa gabung
where kode_cabang = 'CABANG-039' 
#beetween mengganti and, in mengganti or, not in mengganti nor
and (tgl_transaksi between '2008-01-01' and '2008-12-01')
or kode_kasir  in ('039-127','039-156')
or tgl_transaksi is not null
#where like & not like (no=) cari karakter.
# a% = isi field awalan a
# %a = isi field akhirn a
# %a% posisi manapun
# _a% a posisi huruf ke2
# %a__
# a%a depan akhir
limit 150
;