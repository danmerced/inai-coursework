-- psql, from the big-data root. Use a fresh dedicated practice database.
CREATE SCHEMA inai_bigdata;
SET search_path TO inai_bigdata;
CREATE TABLE drivers(driver_id INT PRIMARY KEY, driver_name TEXT NOT NULL);
CREATE TABLE rides(ride_id INT PRIMARY KEY,driver_id INT NOT NULL,city TEXT,ride_date DATE,status TEXT,fare NUMERIC(10,2));
CREATE TABLE payouts(driver_id INT PRIMARY KEY REFERENCES drivers(driver_id),balance NUMERIC(10,2) NOT NULL);
\copy drivers FROM 'data/drivers.csv' CSV HEADER
\copy rides FROM 'data/rides.csv' CSV HEADER
INSERT INTO payouts SELECT driver_id,0 FROM drivers;
SELECT r.city,COUNT(*) AS rides,SUM(r.fare) AS total_fare
FROM rides r JOIN drivers d ON d.driver_id=r.driver_id GROUP BY r.city ORDER BY r.city;
BEGIN;
UPDATE payouts p SET balance=(SELECT COALESCE(SUM(r.fare),0)*0.8 FROM rides r WHERE r.driver_id=p.driver_id AND r.status='completed');
SELECT * FROM payouts;
ROLLBACK;
SELECT * FROM payouts;
BEGIN;
UPDATE payouts p SET balance=(SELECT COALESCE(SUM(r.fare),0)*0.8 FROM rides r WHERE r.driver_id=p.driver_id AND r.status='completed');
COMMIT;
SELECT * FROM payouts ORDER BY driver_id;
