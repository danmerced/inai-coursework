PRAGMA foreign_keys=ON;
CREATE TABLE suppliers(id INTEGER PRIMARY KEY,name TEXT NOT NULL,director TEXT,address TEXT,phone TEXT);
CREATE TABLE products(id INTEGER PRIMARY KEY,name TEXT NOT NULL,price NUMERIC NOT NULL CHECK(price>=0));
CREATE TABLE receipts(id INTEGER PRIMARY KEY,supplier_id INTEGER NOT NULL REFERENCES suppliers(id),product_id INTEGER NOT NULL REFERENCES products(id),received_on TEXT NOT NULL,quantity INTEGER NOT NULL CHECK(quantity>0));
INSERT INTO suppliers VALUES(1,'Техно','Иван Иванов','Улица 1','000-111'),(2,'Офис','Анна Петрова','Улица 2','000-222');
INSERT INTO products VALUES(1,'Клавиатура',1200),(2,'Мышь',600),(3,'Кабель',250);
INSERT INTO receipts VALUES(1,1,1,'2025-10-01',5),(2,1,2,'2025-10-01',8),(3,2,3,'2025-10-05',4),(4,2,1,'2025-10-08',3);
CREATE VIEW receipt_details AS SELECT r.id,r.received_on,s.name AS supplier,p.name AS product,r.quantity,p.price,r.quantity*p.price AS cost,r.supplier_id,r.product_id FROM receipts r JOIN suppliers s ON s.id=r.supplier_id JOIN products p ON p.id=r.product_id;
