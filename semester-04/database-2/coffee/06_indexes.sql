USE INAI_Coffee;
GO
-- In SSMS enable actual execution plan (Ctrl+M) before running.
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT * FROM Tovar WHERE id_kategoriya=1;
CREATE INDEX idx_tovar_kat ON Tovar(id_kategoriya);
SELECT * FROM Tovar WHERE id_kategoriya=1;
CREATE INDEX idx_zakaz_data ON Zakaz(data);
SELECT * FROM Zakaz WHERE YEAR(data)=2024;
SELECT * FROM Zakaz WHERE data>='2024-01-01' AND data<'2025-01-01';
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
-- A small demo table may still be scanned; compare actual plans.
