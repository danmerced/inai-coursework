USE INAI_Coffee;
GO
SELECT id_kategoriya,SUM(cena) AS price_sum FROM Tovar GROUP BY ROLLUP(id_kategoriya);
SELECT t.id_kategoriya,z.id_klient,SUM(sz.qty*sz.price) AS total FROM Zakaz z JOIN Sostav_zakaza sz ON z.id=sz.id_zakaz JOIN Tovar t ON t.id=sz.id_tovar
GROUP BY CUBE(t.id_kategoriya,z.id_klient);
SELECT t.id_kategoriya,z.id_klient,SUM(sz.qty*sz.price) AS total FROM Zakaz z JOIN Sostav_zakaza sz ON z.id=sz.id_zakaz JOIN Tovar t ON t.id=sz.id_tovar
GROUP BY GROUPING SETS ((t.id_kategoriya),(z.id_klient),());
SELECT CASE WHEN GROUPING(id_kategoriya)=1 THEN N'ИТОГО' ELSE COALESCE(CAST(id_kategoriya AS NVARCHAR(20)),N'Без категории') END AS category,
 SUM(cena) AS total FROM Tovar GROUP BY ROLLUP(id_kategoriya);
