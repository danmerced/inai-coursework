USE INAI_FlowerShop;
GO
CREATE OR ALTER PROCEDURE dbo.SupplyProducts @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id,s.day,t.name,i.qty,i.price FROM supply_item i JOIN supply s ON s.id=i.supply_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to ORDER BY s.day,s.id,t.id;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SupplierProducts @supplier INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id,s.day,t.name,i.qty,i.price FROM supply_item i JOIN supply s ON s.id=i.supply_id JOIN product t ON t.id=i.product_id WHERE s.supplier_id=@supplier ORDER BY s.day;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SupplyByType @type INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.name,SUM(i.qty) AS qty FROM supply_item i JOIN supply s ON s.id=i.supply_id JOIN product t ON t.id=i.product_id WHERE t.type_id=@type GROUP BY t.name;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SupplyTotals @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.name,SUM(i.qty) AS qty,SUM(i.qty*i.price) AS total FROM supply_item i JOIN supply s ON s.id=i.supply_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to GROUP BY t.name;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SupplyByClient @from DATE, @to DATE, @client INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.name,SUM(i.qty) AS qty,SUM(i.qty*i.price) AS total FROM supply_item i JOIN supply s ON s.id=i.supply_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to AND s.client_id=@client GROUP BY t.name;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SupplyPriceHistory @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.name,s.day,i.price,LAG(i.price) OVER(PARTITION BY t.id ORDER BY s.day,i.id) AS previous_price FROM supply_item i JOIN supply s ON s.id=i.supply_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SupplyPayments @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.*,s.supplier_id FROM supply_payment p JOIN supply s ON s.id=p.supply_id WHERE p.day >= @from AND p.day < @to ORDER BY p.day;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SupplyPaymentsByClient @from DATE, @to DATE, @client INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.day,p.amount,s.client_id FROM supply_payment p JOIN supply s ON s.id=p.supply_id WHERE p.day >= @from AND p.day < @to AND s.client_id=@client;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SaleProducts @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id,s.day,t.name,i.qty,i.price FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to ORDER BY s.day,s.id,t.id;
END;
GO

CREATE OR ALTER PROCEDURE dbo.ClientOrders @from DATE, @to DATE, @client INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id,s.day,SUM(i.qty*i.price) AS total FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to AND s.client_id=@client GROUP BY s.id,s.day ORDER BY s.day;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SoldProducts @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.name,SUM(i.qty) AS qty,SUM(i.qty*i.price) AS total FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to GROUP BY t.name;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SalesByClient @from DATE, @to DATE, @client INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id,s.day,t.name,i.qty,i.price FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to AND s.client_id=@client ORDER BY s.day;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SalePriceHistory @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.name,s.day,i.price,LAG(i.price) OVER(PARTITION BY t.id ORDER BY s.day,i.id) AS previous_price FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to;
END;
GO

CREATE OR ALTER PROCEDURE dbo.CurrentPrice
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id,name,price FROM product ORDER BY name;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SalePayments @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.id,p.day,p.method,p.amount,s.client_id FROM sale_payment p JOIN sale s ON s.id=p.sale_id WHERE p.day >= @from AND p.day < @to ORDER BY p.day;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SalePaymentMethods @from DATE, @to DATE, @method VARCHAR(40)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.method,SUM(p.amount) AS total FROM sale_payment p WHERE p.day >= @from AND p.day < @to AND p.method=@method GROUP BY p.method;
END;
GO

CREATE OR ALTER PROCEDURE dbo.EmployeeSales @from DATE, @to DATE, @employee INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id,s.day,t.name,i.qty,i.price FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to AND s.employee_id=@employee ORDER BY s.day;
END;
GO

CREATE OR ALTER PROCEDURE dbo.EmployeeStatistics @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.name,COUNT(DISTINCT s.id) AS orders,SUM(i.qty*i.price) AS total FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id JOIN employee e ON e.id=s.employee_id WHERE s.day >= @from AND s.day < @to GROUP BY e.name;
END;
GO

CREATE OR ALTER PROCEDURE dbo.DistrictSales @from DATE, @to DATE, @district INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT d.name,SUM(i.qty*i.price) AS total FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id JOIN client c ON c.id=s.client_id JOIN district d ON d.id=c.district_id WHERE s.day >= @from AND s.day < @to AND d.id=@district GROUP BY d.name;
END;
GO

CREATE OR ALTER PROCEDURE dbo.ClientTypeStatistics @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ct.name,SUM(i.qty*i.price) AS total FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id JOIN client c ON c.id=s.client_id JOIN client_type ct ON ct.id=c.type_id WHERE s.day >= @from AND s.day < @to GROUP BY ct.name;
END;
GO

CREATE OR ALTER PROCEDURE dbo.ClientContacts @client INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT kind,value FROM client_contact WHERE client_id=@client;
END;
GO

CREATE OR ALTER PROCEDURE dbo.OrdersBySaleType @from DATE, @to DATE, @kind VARCHAR(40)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id,s.day,s.sale_type,SUM(i.qty*i.price) AS total FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to AND s.sale_type=@kind GROUP BY s.id,s.day,s.sale_type;
END;
GO

CREATE OR ALTER PROCEDURE dbo.OrdersByOrderType @from DATE, @to DATE, @kind VARCHAR(40)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id,s.day,s.order_type,SUM(i.qty*i.price) AS total FROM sale_item i JOIN sale s ON s.id=i.sale_id JOIN product t ON t.id=i.product_id WHERE s.day >= @from AND s.day < @to AND s.order_type=@kind GROUP BY s.id,s.day,s.order_type;
END;
GO

CREATE OR ALTER PROCEDURE dbo.ProductBalance @from DATE, @to DATE
AS
BEGIN
    SET NOCOUNT ON;
    ;WITH incoming AS (
     SELECT i.product_id,SUM(CASE WHEN s.day<@from THEN i.qty ELSE 0 END) AS before_qty,SUM(CASE WHEN s.day>=@from THEN i.qty ELSE 0 END) AS period_qty
     FROM supply_item i JOIN supply s ON s.id=i.supply_id WHERE s.day<@to GROUP BY i.product_id
    ), outgoing AS (
     SELECT i.product_id,SUM(CASE WHEN s.day<@from THEN i.qty ELSE 0 END) AS before_qty,SUM(CASE WHEN s.day>=@from THEN i.qty ELSE 0 END) AS period_qty
     FROM sale_item i JOIN sale s ON s.id=i.sale_id WHERE s.day<@to GROUP BY i.product_id
    )
    SELECT t.name,COALESCE(a.before_qty,0)-COALESCE(b.before_qty,0) AS opening,
     COALESCE(a.period_qty,0) AS supplied,COALESCE(b.period_qty,0) AS sold,
     COALESCE(a.before_qty,0)+COALESCE(a.period_qty,0)-COALESCE(b.before_qty,0)-COALESCE(b.period_qty,0) AS closing
    FROM product t LEFT JOIN incoming a ON a.product_id=t.id LEFT JOIN outgoing b ON b.product_id=t.id;
END;
GO
