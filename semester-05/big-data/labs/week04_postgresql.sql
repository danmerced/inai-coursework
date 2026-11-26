SET search_path TO inai_bigdata;
CREATE TABLE payout_baseline AS SELECT * FROM payouts;
BEGIN;
UPDATE payouts SET balance=balance+10;
ROLLBACK;
SELECT * FROM payouts EXCEPT SELECT * FROM payout_baseline;
-- No driver names or exact trip timestamps are exposed to analysts.
CREATE VIEW analyst_city_summary AS
SELECT city,COUNT(*) AS rides_count,SUM(fare)::numeric(12,2) AS total_fare FROM rides GROUP BY city;
REVOKE ALL ON analyst_city_summary FROM PUBLIC;
-- An administrator can create a dedicated NOLOGIN analyst role, grant schema USAGE and
-- SELECT on this view only, and verify via SET ROLE; no raw-table permissions are needed.
SELECT * FROM analyst_city_summary;
