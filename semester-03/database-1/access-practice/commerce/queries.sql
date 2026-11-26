-- ЛР 6: многотабличные выборки
SELECT * FROM receipt_details ORDER BY received_on;
SELECT * FROM receipt_details WHERE received_on BETWEEN '2025-10-01' AND '2025-10-05';
SELECT * FROM receipt_details WHERE supplier_id=:supplier_id;
SELECT * FROM receipt_details WHERE cost>1000;
SELECT product,SUM(cost) AS total FROM receipt_details GROUP BY product;
SELECT SUM(cost) AS total FROM receipt_details;
-- Модифицирующие запросы выполняются безопасно в транзакции
BEGIN;
INSERT INTO receipts VALUES(5,1,3,'2025-10-09',2);
UPDATE receipts SET quantity=3 WHERE id=5;
DELETE FROM receipts WHERE id=5;
ROLLBACK;
-- ЛР 8: многотабличные отчёты
SELECT supplier,SUM(cost) AS total FROM receipt_details GROUP BY supplier;
SELECT supplier,received_on,SUM(cost) AS total FROM receipt_details GROUP BY supplier,received_on ORDER BY supplier,received_on;
