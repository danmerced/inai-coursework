USE INAI_Coffee;
GO
-- Contained exercise: no server credentials and no privilege changes outside this database.
CREATE USER barista_user WITHOUT LOGIN;
CREATE USER admin_user WITHOUT LOGIN;
CREATE ROLE barista_role;
CREATE ROLE admin_role;
ALTER ROLE barista_role ADD MEMBER barista_user;
ALTER ROLE admin_role ADD MEMBER admin_user;
GRANT SELECT ON dbo.Tovar TO barista_role;
GRANT SELECT,INSERT ON dbo.Zakaz TO barista_role;
GRANT SELECT ON dbo.Klient TO barista_role;
GRANT EXECUTE ON dbo.AddZakaz TO barista_role;
GRANT SELECT,INSERT,UPDATE,DELETE ON dbo.Tovar TO admin_role;
GRANT SELECT,INSERT,UPDATE,DELETE ON dbo.Zakaz TO admin_role;
DENY UPDATE,DELETE ON dbo.Tovar TO barista_role;
EXECUTE AS USER='barista_user';
BEGIN TRY
 SELECT * FROM dbo.Tovar;
END TRY
BEGIN CATCH
 SELECT ERROR_MESSAGE() AS unexpected_error;
END CATCH;
BEGIN TRY
 UPDATE dbo.Tovar SET cena=999 WHERE id=1;
END TRY
BEGIN CATCH
 SELECT ERROR_MESSAGE() AS expected_update_denial;
END CATCH;
BEGIN TRY
 DELETE FROM dbo.Tovar WHERE id=1;
END TRY
BEGIN CATCH
 SELECT ERROR_MESSAGE() AS expected_delete_denial;
END CATCH;
REVERT;
REVOKE SELECT ON dbo.Klient FROM barista_role;
-- For server-level authentication, create local logins interactively on a test instance and map users to them.
