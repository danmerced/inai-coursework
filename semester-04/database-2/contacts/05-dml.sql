USE INAI_Contacts;
GO
-- All changes are rolled back so other exercises can reuse the original data.
BEGIN TRANSACTION;
BEGIN TRY
    DELETE FROM tip_klienta WHERE id_tip_klienta=6;
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS foreign_key_error;
END CATCH;
IF XACT_STATE()<>0 ROLLBACK;
GO
BEGIN TRANSACTION;
DELETE FROM kontakty WHERE id_klient>10;
UPDATE klient SET last_name=N'Пробный' WHERE id_klient=10;
UPDATE klient SET id_district=3 WHERE id_klient=1;
UPDATE klient SET first_name=N'Тест',middle_name=N'Тестович',last_name=N'Примеров' WHERE id_klient=1;
SELECT * FROM klient WHERE id_klient IN (1,10);
SELECT COUNT(*) AS contacts_left FROM kontakty;
TRUNCATE TABLE kontakty;
SELECT COUNT(*) AS after_truncate FROM kontakty;
ROLLBACK;
