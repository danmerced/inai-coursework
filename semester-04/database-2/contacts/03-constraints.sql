USE INAI_Contacts;
GO
-- Keys and restrictions on demo tables only.
CREATE TABLE dbo.ContactCategoryDemo (
 id INT PRIMARY KEY,
 name NVARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE dbo.ContactDemo (
 id INT PRIMARY KEY,
 category_id INT REFERENCES dbo.ContactCategoryDemo(id),
 value NVARCHAR(100) NOT NULL,
 priority INT NOT NULL DEFAULT 1 CHECK(priority BETWEEN 1 AND 5)
);
CREATE UNIQUE INDEX UX_ContactDemo_Value ON dbo.ContactDemo(value);
BEGIN TRANSACTION;
INSERT INTO dbo.ContactCategoryDemo VALUES (1,N'Email');
INSERT INTO dbo.ContactDemo(id,category_id,value) VALUES(1,1,N'demo@example.invalid');
SELECT * FROM dbo.ContactDemo;
ROLLBACK;
DROP TABLE dbo.ContactDemo;
DROP TABLE dbo.ContactCategoryDemo;
