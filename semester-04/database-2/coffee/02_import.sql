USE INAI_Coffee;
GO
CREATE TABLE Tovar_Staging(nazvanie NVARCHAR(100) PRIMARY KEY,cena DECIMAL(10,2) NOT NULL CHECK(cena>0));
CREATE TABLE Tovar_Log(id INT IDENTITY PRIMARY KEY,action NVARCHAR(10),old_cena DECIMAL(10,2),new_cena DECIMAL(10,2),dt DATETIME2 DEFAULT SYSDATETIME());
-- Place price.csv on the server in this folder; adjust path if needed.
BULK INSERT Tovar_Staging FROM 'C:\Temp\price.csv'
WITH (FORMAT='CSV',FIRSTROW=2,FIELDTERMINATOR=';',ROWTERMINATOR='0x0a',CODEPAGE='65001');
SELECT * FROM Tovar_Staging;
MERGE Tovar WITH (HOLDLOCK) AS T
USING Tovar_Staging AS S ON T.nazvanie=S.nazvanie
WHEN MATCHED AND T.cena<>S.cena THEN UPDATE SET cena=S.cena
WHEN NOT MATCHED THEN INSERT(nazvanie,cena,id_kategoriya) VALUES(S.nazvanie,S.cena,4)
OUTPUT $action,deleted.cena,inserted.cena INTO Tovar_Log(action,old_cena,new_cena);
SELECT * FROM Tovar_Log ORDER BY id;
