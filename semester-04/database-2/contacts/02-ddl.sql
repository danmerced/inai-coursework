-- Run on a test instance. INAI_DDL_Practice must not exist.
CREATE DATABASE INAI_DDL_Practice;
GO
USE INAI_DDL_Practice;
GO
CREATE TABLE district (id_district INT NOT NULL, district NVARCHAR(100));
ALTER TABLE district ADD CONSTRAINT PK_district PRIMARY KEY(id_district);
CREATE TABLE klient (id_klient INT NOT NULL PRIMARY KEY, last_name NVARCHAR(50), id_district INT);
ALTER TABLE klient ADD CONSTRAINT FK_klient_district FOREIGN KEY(id_district) REFERENCES district(id_district);
ALTER TABLE klient ALTER COLUMN last_name NVARCHAR(100);
ALTER TABLE klient ADD office NVARCHAR(100);
ALTER TABLE klient DROP COLUMN office;
EXEC sp_rename 'dbo.klient.last_name', 'surname', 'COLUMN';
DROP TABLE klient;
DROP TABLE district;
GO
CREATE TABLE client_type (id INT PRIMARY KEY, name NVARCHAR(100) NOT NULL);
CREATE TABLE client (id INT PRIMARY KEY, type_id INT NOT NULL);
ALTER TABLE client ADD CONSTRAINT FK_client_type FOREIGN KEY(type_id) REFERENCES client_type(id);
DROP TABLE client;
DROP TABLE client_type;
GO
USE master;
GO
-- Optional cleanup: after checking that the database is the one created above.
-- DROP DATABASE INAI_DDL_Practice;
