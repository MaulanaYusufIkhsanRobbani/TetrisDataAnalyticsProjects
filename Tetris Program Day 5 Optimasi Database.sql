#optimasi database
-- Optimasi database
-- Copy table ms_kota menjadi ms_kota_2 
CREATE TABLE ms_kota_2 AS SELECT * FROM ms_kota;

-- buat primary key kode_kota 
ALTER TABLE ms_kota_2 ADD PRIMARY KEY (kode_kota);


-- copy table ms_cabang menjadi ms_cabang_2 
CREATE TABLE ms_cabang_2 AS SELECT * FROM ms_cabang;

-- buat primary key kode_cabang 
ALTER TABLE ms_cabang_2 ADD PRIMARY KEY (kode_cabang);

-- buat foreign key kode_kota  ke ms_kota_2.kode_kota 
ALTER TABLE ms_cabang_2 ADD CONSTRAINT fk_kode_kota FOREIGN KEY (kode_kota) REFERENCES ms_kota_2(kode_kota);

--  PK DAN FK TR PENJUALAN

-- copy table tr_penjualan menjadi tr_penjualan_2 
CREATE TABLE tr_penjualan_2 AS SELECT * FROM tr_penjualan;

-- buat foreign key kode_cabang ke ms_cabang_2.kode_cabang 
ALTER TABLE tr_penjualan_2 ADD CONSTRAINT fk_kode_cabang FOREIGN KEY (kode_cabang) REFERENCES ms_cabang_2(kode_cabang);

