USE INAI_Coffee;
GO
-- 1. Number products inside category
SELECT nazvanie,id_kategoriya,cena,ROW_NUMBER() OVER (PARTITION BY id_kategoriya ORDER BY cena DESC,id) AS rn FROM Tovar;
-- 2. Ranking
SELECT nazvanie,cena,RANK() OVER (ORDER BY cena DESC) AS rnk,DENSE_RANK() OVER (ORDER BY cena DESC) AS dense_rnk FROM Tovar;
-- 3. Difference from previous price
SELECT nazvanie,cena,LAG(cena) OVER (ORDER BY cena,id) AS previous,cena-LAG(cena) OVER (ORDER BY cena,id) AS difference FROM Tovar;
-- 4. Running total
SELECT data,summa,SUM(summa) OVER (ORDER BY data,id ROWS UNBOUNDED PRECEDING) AS running_total FROM Zakaz;
-- 5. Top 2 per category
WITH ranked AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY id_kategoriya ORDER BY cena DESC,id) AS rn FROM Tovar)
SELECT id,nazvanie,cena,id_kategoriya,rn FROM ranked WHERE rn<=2;
-- 6. Above average
WITH averages AS (SELECT id_kategoriya,AVG(cena) AS ac FROM Tovar GROUP BY id_kategoriya)
SELECT t.nazvanie,t.cena,a.ac FROM Tovar t JOIN averages a ON t.id_kategoriya=a.id_kategoriya WHERE t.cena>a.ac;
