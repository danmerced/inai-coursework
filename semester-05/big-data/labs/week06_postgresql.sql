SET search_path TO inai_bigdata;
-- ELT: raw data is already loaded; transform in the database.
CREATE VIEW curated_city_clicks AS
SELECT city,COUNT(*) AS clicks FROM events_marked WHERE reason IS NULL AND kind='click' GROUP BY city;
SELECT * FROM curated_city_clicks ORDER BY city;
SELECT reason,COUNT(*) FROM events_marked WHERE reason IS NOT NULL GROUP BY reason;
