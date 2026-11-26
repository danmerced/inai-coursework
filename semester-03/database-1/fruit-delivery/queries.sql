-- 3.1: продукты на А, стоимость 90–160
SELECT name, price FROM products WHERE name LIKE 'А%' AND price BETWEEN 90 AND 160 ORDER BY name;
-- 3.2: денежная величина скидки
SELECT id, order_id, quantity*price AS gross, ROUND(quantity*price*discount,2) AS discount_amount FROM order_details;
-- 3.3: параметр имени клиента (пример: Fresh Market)
SELECT o.order_number,o.placed_at,p.name,d.quantity,d.price,d.discount
FROM orders o JOIN clients c ON o.client_id=c.id
JOIN order_details d ON o.id=d.order_id JOIN products p ON d.product_id=p.id
WHERE c.company=:client ORDER BY o.placed_at,p.name;
-- 3.4: клиенты с заказом дороже 3000 после скидок
SELECT DISTINCT c.company FROM clients c JOIN orders o ON o.client_id=c.id
WHERE o.id IN (SELECT order_id FROM order_details GROUP BY order_id HAVING SUM(quantity*price*(1-discount))>3000);
-- Многотабличный отчёт: сумма по заказу и оплата (без размножения строк JOIN)
SELECT o.order_number,c.company,ROUND(SUM(d.quantity*d.price*(1-d.discount)),2) AS total,
COALESCE((SELECT SUM(p.amount) FROM payments p WHERE p.order_id=o.id),0) AS paid
FROM orders o JOIN clients c ON c.id=o.client_id JOIN order_details d ON d.order_id=o.id
GROUP BY o.id,o.order_number,c.company ORDER BY o.order_number;
