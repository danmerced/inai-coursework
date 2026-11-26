USE INAI_Coffee;
GO
SELECT e.fio AS employee,m.fio AS manager FROM Sotrudnik e LEFT JOIN Sotrudnik m ON e.id_boss=m.id;
SELECT k.nazvanie AS category,t.nazvanie AS product FROM Kategoriya k FULL OUTER JOIN Tovar t ON k.id=t.id_kategoriya;
SELECT fio FROM Klient k WHERE EXISTS(SELECT 1 FROM Zakaz z WHERE z.id_klient=k.id);

GO
CREATE VIEW V_Dorogie AS SELECT id,nazvanie,cena,id_kategoriya FROM Tovar WHERE cena>200 WITH CHECK OPTION;
GO
BEGIN TRY
 BEGIN TRANSACTION;
 INSERT INTO V_Dorogie(nazvanie,cena,id_kategoriya) VALUES('Low price demo',50,1);
 ROLLBACK;
END TRY
BEGIN CATCH
 IF XACT_STATE()<>0 ROLLBACK;
 SELECT ERROR_MESSAGE() AS check_option_error;
END CATCH;
-- MySQL alternative for full outer join:
-- SELECT k.nazvanie,t.nazvanie FROM Kategoriya k LEFT JOIN Tovar t ON k.id=t.id_kategoriya
-- UNION ALL
-- SELECT k.nazvanie,t.nazvanie FROM Kategoriya k RIGHT JOIN Tovar t ON k.id=t.id_kategoriya WHERE k.id IS NULL;
