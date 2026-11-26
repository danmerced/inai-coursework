USE INAI_FlowerShop;
GO
DECLARE @a INT=10, @b INT=15, @c INT=0;
BEGIN TRANSACTION;
IF @c>=0
BEGIN
 SELECT @a+@b AS result;
 COMMIT;
END
ELSE ROLLBACK;
GO
-- Validate an attempted new client.
DECLARE @last_name VARCHAR(100)='';
BEGIN TRY
 BEGIN TRANSACTION;
 IF NULLIF(LTRIM(RTRIM(@last_name)),'') IS NULL
    THROW 50001,'Last name is required',1;
 INSERT INTO client VALUES(4,@last_name,1,1);
 COMMIT;
END TRY
BEGIN CATCH
 IF XACT_STATE()<>0 ROLLBACK;
 SELECT ERROR_MESSAGE() AS message;
END CATCH;
GO
-- Select a client with an unpaid balance. Lock order rows and payment ranges
-- while evaluating the debt and adding a new order.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DECLARE @client INT=2, @debt DECIMAL(12,2);
BEGIN TRY
 BEGIN TRANSACTION;
 SELECT @debt=COALESCE(SUM(COALESCE(i.total,0)-COALESCE(p.total,0)),0)
 FROM sale s WITH (UPDLOCK)
 LEFT JOIN (SELECT sale_id,SUM(qty*price) AS total FROM sale_item GROUP BY sale_id) i ON i.sale_id=s.id
 LEFT JOIN (SELECT sale_id,SUM(amount) AS total FROM sale_payment GROUP BY sale_id) p ON p.sale_id=s.id
 WHERE s.client_id=@client;
 IF @debt>0 THROW 50002,'Previous orders are not paid',1;
 INSERT INTO sale VALUES(4,@client,1,'2026-04-01','Retail','Store');
 COMMIT;
END TRY
BEGIN CATCH
 IF XACT_STATE()<>0 ROLLBACK;
 SELECT ERROR_MESSAGE() AS message;
END CATCH;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
