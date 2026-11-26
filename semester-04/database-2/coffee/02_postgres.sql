-- Execute using psql in the directory containing price.csv, after 01_postgres.sql.
CREATE TABLE Tovar_Staging(nazvanie VARCHAR(100) PRIMARY KEY,cena DECIMAL(10,2) NOT NULL CHECK(cena>0));
\copy Tovar_Staging FROM 'price.csv' WITH (FORMAT csv,HEADER true,DELIMITER ';',ENCODING 'UTF8')
INSERT INTO Kategoriya(nazvanie) VALUES ('Other') ON CONFLICT(nazvanie) DO NOTHING;
INSERT INTO Tovar(nazvanie,cena,id_kategoriya)
SELECT nazvanie,cena,(SELECT id FROM Kategoriya WHERE nazvanie='Other') FROM Tovar_Staging
ON CONFLICT(nazvanie) DO UPDATE SET cena=EXCLUDED.cena WHERE Tovar.cena<>EXCLUDED.cena;
SELECT * FROM Tovar_Staging;
SELECT * FROM Tovar ORDER BY id;
