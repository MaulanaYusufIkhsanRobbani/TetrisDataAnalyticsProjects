#soal 6
SELECT node, 
       CASE WHEN parent IS NOT NULL AND EXISTS (SELECT 1 FROM nodes WHERE parent = n.node) THEN 'Batang'
            WHEN parent IS NOT NULL AND NOT EXISTS (SELECT 1 FROM nodes WHERE parent = n.node) THEN 'Daun'
            WHEN parent IS NULL THEN 'Akar'
       END AS position
FROM nodes n
ORDER BY node ASC;

#soal7
SELECT x, y
FROM (
  SELECT a.x, a.y, ROW_NUMBER() OVER (ORDER BY a.x) AS rn
  FROM xy a
  JOIN xy b
  ON a.x = b.y AND a.y = b.x
) t
WHERE rn % 2 = 1

#soal8
SELECT 
    SUBSTRING(strdata, 1, 10) AS tanggal,
    CASE 
        WHEN POSITION('lusin' IN strdata) > 0 THEN CAST(SUBSTRING(strdata FROM POSITION('terjual' IN strdata)+8 FOR POSITION('lusin' IN strdata)-POSITION('terjual' IN strdata)-8) AS INTEGER) * 12
        WHEN POSITION('buah' IN strdata) > 0 THEN CAST(SUBSTRING(strdata FROM POSITION('terjual' IN strdata)+8 FOR POSITION('buah' IN strdata)-POSITION('terjual' IN strdata)-8) AS INTEGER)
    END AS qty,
    CAST(SUBSTRING(strdata FROM POSITION('Rp ' IN strdata)+3 FOR LENGTH(strdata)) AS INTEGER) AS total,
    CAST(SUBSTRING(strdata FROM POSITION('Rp ' IN strdata)+3 FOR LENGTH(strdata)) AS INTEGER)/
        CASE 
            WHEN POSITION('lusin' IN strdata) > 0 THEN CAST(SUBSTRING(strdata FROM POSITION('terjual' IN strdata)+8 FOR POSITION('lusin' IN strdata)-POSITION('terjual' IN strdata)-8) AS INTEGER)*12
            WHEN POSITION('buah' IN strdata) > 0 THEN CAST(SUBSTRING(strdata FROM POSITION('terjual' IN strdata)+8 FOR POSITION('buah' IN strdata)-POSITION('terjual' IN strdata)-8) AS INTEGER)
        END AS harga_satuan
FROM strdata s ;

#soal 9
WITH odd_rows AS (
  SELECT nama1, tanggal_lahir AS tanggal_lahir1, tanggal_registrASi AS tanggal_registrASi1, ROW_NUMBER() OVER (ORDER BY nama) AS rn
  FROM people
  WHERE rn % 2 = 1
),
even_rows AS (
  SELECT nama2, tanggal_lahir AS tanggal_lahir2, tanggal_registrASi AS tanggal_registrASi2, ROW_NUMBER() OVER (ORDER BY nama) AS rn
  FROM people
  WHERE rn % 2 = 0
)
SELECT 
  odd_rows.nama1,
  even_rows.nama2,
  DATEDIFF(year, odd_rows.tanggal_lahir1, odd_rows.tanggal_registrASi1) - DATEDIFF(year, even_rows.tanggal_lahir2, even_rows.tanggal_registrASi2) AS selisih
FROM odd_rows
JOIN even_rows ON odd_rows.rn = even_rows.rn



WITH numbered_rows AS (
  SELECT nama, tanggal_lahir, tanggal_registrASi, ROW_NUMBER() OVER (ORDER BY nama) AS rn
  FROM people
),
nama1 AS (
  SELECT nama AS nama1, tanggal_lahir AS tanggal_lahir1, tanggal_registrASi AS tanggal_registrASi1, rn
  FROM numbered_rows
  WHERE rn % 2 = 1
),
nama2 AS (
  SELECT nama AS nama2, tanggal_lahir AS tanggal_lahir2, tanggal_registrASi AS tanggal_registrASi2, rn
  FROM numbered_rows
  WHERE rn % 2 = 0
)
SELECT 
  nama1.nama1,
  nama2.nama2,
  (DATEDIFF(nama1.tanggal_registrASi1, nama1.tanggal_lahir1) / 365) - (DATEDIFF(nama2.tanggal_registrASi2, nama2.tanggal_lahir2) / 365) AS selisih
FROM nama1
JOIN nama2 ON nama1.rn = nama2.rn

SELECT 
  nama1,
  nama2,
  (DATEDIFF(tanggal_registrASi1, tanggal_lahir1) / 365) - (DATEDIFF(tanggal_registrASi2, tanggal_lahir2) / 365) AS selisih
FROM (
  SELECT nama AS nama1, tanggal_lahir AS tanggal_lahir1, tanggal_registrASi AS tanggal_registrASi1, rn
  FROM (
    SELECT nama, tanggal_lahir, tanggal_registrASi, ROW_NUMBER() OVER (ORDER BY nama) AS rn
    FROM people
  ) t1
  WHERE rn % 2 = 1
) t1
JOIN (
  SELECT nama AS nama2, tanggal_lahir AS tanggal_lahir2, tanggal_registrASi AS tanggal_registrASi2, rn
  FROM (
    SELECT nama, tanggal_lahir, tanggal_registrASi, ROW_NUMBER() OVER (ORDER BY nama) AS rn
    FROM people
  ) t2
  WHERE rn % 2 = 0
) t2 ON t1.rn = t2.rn

#soal 10
SELECT 'Norwegia,Jepang,Norwegia' AS jawaban
