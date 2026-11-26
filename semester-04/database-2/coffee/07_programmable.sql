USE INAI_Coffee;
GO
CREATE OR ALTER PROCEDURE AddZakaz @klient INT,@summa DECIMAL(10,2),@newId INT OUTPUT AS
BEGIN
 SET NOCOUNT ON;
 INSERT INTO Zakaz(id_klient,summa) VALUES(@klient,@summa);
 SET @newId=CONVERT(INT,SCOPE_IDENTITY());
END;
GO
CREATE OR ALTER FUNCTION GetBonus(@kl INT) RETURNS DECIMAL(12,2) AS
BEGIN
 RETURN (SELECT COALESCE(SUM(summa),0)/10 FROM Zakaz WHERE id_klient=@kl);
END;
GO
CREATE OR ALTER TRIGGER trg_Tovar_UPD ON Tovar AFTER UPDATE AS
BEGIN
 SET NOCOUNT ON;
 INSERT INTO Tovar_Log(action,old_cena,new_cena)
 SELECT 'UPDATE',d.cena,i.cena FROM inserted i JOIN deleted d ON i.id=d.id WHERE i.cena<>d.cena;
END;
GO
DECLARE @id INT;
EXEC AddZakaz 1,500,@id OUTPUT;
SELECT @id AS new_order,dbo.GetBonus(1) AS bonus;
UPDATE Tovar SET cena=cena+10 WHERE id=1;
SELECT * FROM Tovar_Log;
BEGIN TRANSACTION;
UPDATE Tovar SET cena=cena*1.1 WHERE id_kategoriya=1;
SELECT id,cena FROM Tovar WHERE id_kategoriya=1;
ROLLBACK;
SELECT id,cena FROM Tovar WHERE id_kategoriya=1;
