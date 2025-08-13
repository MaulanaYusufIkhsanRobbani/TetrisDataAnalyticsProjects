select *
	from tr_so
#soal 1	

SELECT 
    p.nama_pegawai,
    COUNT(s.kode_sales) AS jumlah_so,
    p.target,
    CASE 
        WHEN COUNT(s.kode_sales) < p.target THEN 'ya'
        ELSE 'tidak'
    END AS kurang_dari_target
FROM  tr_so s
JOIN ms_pegawai p ON s.kode_sales = p.kode_pegawai
GROUP BY p.nama_pegawai, p.target
ORDER BY p.nama_pegawai;

#soal2

SELECT 
    d.no_do,
    s.kode_customer,
    d.tgl_do,
    CASE
        WHEN s.satuan = 'dus' THEN s.qty * 30
        WHEN s.satuan = 'krat' THEN s.qty * 24
        ELSE s.qty
    END AS qty,
    CASE
    	WHEN s.satuan = 'dus' THEN ROUND(s.qty * p.harga_satuan*1.1*30 + ongkos_kirim)
    	WHEN s.satuan = 'krat' THEN ROUND(s.qty * p.harga_satuan*1.1*24 + ongkos_kirim)
    	ELSE ROUND(s.qty * p.harga_satuan*1.1 + ongkos_kirim)
    END AS amount
FROM tr_do d
JOIN tr_so s ON d.no_entry_so = s.no_entry_so
JOIN ms_product p ON s.kode_barang = p.kode_produk
JOIN ms_customer mc ON s.kode_customer = mc.kode_customer

#soal3

SELECT 
    ts.no_do,
    c.nama_customer,
    ts.tgl_do,
    DATE '2018-02-01' AS date_measurement,
    DATE '2018-02-01' - ts.tgl_do AS aging
FROM tr_so ts2 
JOIN ms_customer c ON ts2.kode_customer = c.kode_customer
JOIN  tr_do ts  ON ts2.no_entry_so = ts.no_entry_so 
ORDER BY aging ASC

#soal4

SELECT 
    p.nama_product,
    SUM(
        CASE
            WHEN s.satuan = 'dus' THEN s.qty * 30
            WHEN s.satuan = 'krat' THEN s.qty * 24
            ELSE s.qty
        END
    ) AS qty
FROM ms_product p
JOIN  tr_so s ON p.kode_produk = s.kode_barang
GROUP BY p.nama_product
ORDER BY qty DESC
LIMIT 3

#soal 5
SELECT 
    v.vendor,
    SUM(
        CASE
            WHEN s.satuan = 'dus' THEN s.qty * 1.1 * 30 * p.harga_satuan
            WHEN s.satuan = 'krat' THEN s.qty * 1.1 * 24 * p.harga_satuan
            ELSE s.qty * 1.1 * p.harga_satuan
        END
    ) AS amount
FROM  ms_product p
JOIN tr_so s ON p.kode_produk = s.kode_barang
JOIN ms_vendor v ON p.kode_vendor = v.kode_vendor
GROUP BY v.vendor
ORDER BY amount DESC
LIMIT 3

#soal 6

		