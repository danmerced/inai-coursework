USE INAI_Contacts;
GO
-- Local demo: count each client's contacts and collect results.
DECLARE @id INT,@total INT;
DECLARE @result TABLE(client_id INT PRIMARY KEY, contact_count INT);
DECLARE client_cursor CURSOR LOCAL FAST_FORWARD FOR SELECT id_klient FROM klient ORDER BY id_klient;
OPEN client_cursor;
FETCH NEXT FROM client_cursor INTO @id;
WHILE @@FETCH_STATUS=0
BEGIN
 SELECT @total=COUNT(*) FROM kontakty WHERE id_klient=@id;
 INSERT INTO @result VALUES(@id,@total);
 FETCH NEXT FROM client_cursor INTO @id;
END;
CLOSE client_cursor;
DEALLOCATE client_cursor;
SELECT * FROM @result;
-- Set-based equivalent:
SELECT k.id_klient,COUNT(c.id_kontakty) AS contact_count FROM klient k LEFT JOIN kontakty c ON k.id_klient=c.id_klient GROUP BY k.id_klient;
