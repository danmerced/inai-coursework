SET search_path TO inai_bigdata;
CREATE TABLE events_raw(event_id INT PRIMARY KEY,city TEXT,kind TEXT,event_time TIMESTAMP);
\copy events_raw FROM 'data/events_quality.csv' CSV HEADER
CREATE VIEW events_marked AS
WITH cleaned AS (
 SELECT event_id,city AS original_city,kind AS original_kind,INITCAP(LOWER(TRIM(city))) AS city,
 LOWER(TRIM(kind)) AS kind,event_time FROM events_raw
) SELECT *,CASE WHEN city IS NULL OR city='' THEN 'missing_city'
 WHEN kind IS NULL OR kind NOT IN ('click','view') THEN 'unknown_kind' END AS reason,
 (city IS DISTINCT FROM original_city OR kind IS DISTINCT FROM original_kind) AS normalized
 FROM cleaned;
CREATE TABLE events_accepted AS SELECT * FROM events_marked WHERE reason IS NULL;
CREATE TABLE events_quarantine AS SELECT * FROM events_marked WHERE reason IS NOT NULL;
SELECT (SELECT COUNT(*) FROM events_raw) AS raw_count,
(SELECT COUNT(*) FROM events_accepted) AS accepted_count,
(SELECT COUNT(*) FROM events_quarantine) AS quarantine_count;
SELECT reason,COUNT(*) FROM events_quarantine GROUP BY reason;
SELECT COUNT(*) AS normalized_accepted FROM events_accepted WHERE normalized;
