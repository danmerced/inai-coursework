-- Выполнять в отдельном учебном экземпляре SQL Server из SSMS.
USE master;
GO
IF DB_ID(N'SecurityDB') IS NULL
    CREATE DATABASE SecurityDB;
GO
IF DB_ID(N'MySampleDB') IS NULL
    CREATE DATABASE MySampleDB;
GO
SELECT name, recovery_model_desc FROM sys.databases WHERE name IN ('SecurityDB','MySampleDB');
GO
USE MySampleDB;
GO
SELECT name,type_desc,physical_name,size*8/1024.0 AS size_mb FROM sys.database_files;
SELECT name,type_desc FROM sys.filegroups;
GO
