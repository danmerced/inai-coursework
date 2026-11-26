USE INAI_Contacts;
GO
-- SQL Server does not implement BEFORE DML triggers. INSTEAD OF can validate
-- data before the actual write. AFTER can log a successful modification.
CREATE TABLE dbo.TriggerDemo(id INT PRIMARY KEY, amount DECIMAL(10,2) NOT NULL CHECK(amount>=0));
CREATE TABLE dbo.TriggerAudit(id INT, operation VARCHAR(10), old_amount DECIMAL(10,2), new_amount DECIMAL(10,2), logged_at DATETIME2 DEFAULT SYSDATETIME());
GO
CREATE TRIGGER dbo.TriggerDemo_Insert ON dbo.TriggerDemo INSTEAD OF INSERT AS
BEGIN
 SET NOCOUNT ON;
 IF EXISTS(SELECT 1 FROM inserted WHERE amount<0)
    THROW 50001,'Negative amount',1;
 INSERT INTO dbo.TriggerDemo(id,amount) SELECT id,amount FROM inserted;
END;
GO
CREATE TRIGGER dbo.TriggerDemo_Log ON dbo.TriggerDemo AFTER UPDATE,DELETE AS
BEGIN
 SET NOCOUNT ON;
 INSERT INTO dbo.TriggerAudit(id,operation,old_amount,new_amount)
 SELECT d.id,CASE WHEN i.id IS NULL THEN 'DELETE' ELSE 'UPDATE' END,d.amount,i.amount
 FROM deleted d LEFT JOIN inserted i ON i.id=d.id;
END;
GO
INSERT INTO dbo.TriggerDemo VALUES(1,100);
UPDATE dbo.TriggerDemo SET amount=120 WHERE id=1;
DELETE FROM dbo.TriggerDemo WHERE id=1;
BEGIN TRY
 INSERT INTO dbo.TriggerDemo VALUES(2,-100);
END TRY
BEGIN CATCH
 SELECT ERROR_MESSAGE() AS validation_message;
END CATCH;
SELECT * FROM dbo.TriggerAudit;
