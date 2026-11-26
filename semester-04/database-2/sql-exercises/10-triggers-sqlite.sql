CREATE TABLE products(id INTEGER PRIMARY KEY, price NUMERIC NOT NULL);
CREATE TABLE audit(product_id INT,old_price NUMERIC,new_price NUMERIC);
CREATE TRIGGER validate_price BEFORE INSERT ON products
WHEN NEW.price<=0 BEGIN SELECT RAISE(ABORT,'Price must be positive'); END;
CREATE TRIGGER validate_update BEFORE UPDATE ON products
WHEN NEW.price<=0 BEGIN SELECT RAISE(ABORT,'Price must be positive'); END;
CREATE TRIGGER log_price AFTER UPDATE ON products
BEGIN INSERT INTO audit VALUES(OLD.id,OLD.price,NEW.price); END;
CREATE VIEW expensive AS SELECT id,price FROM products WHERE price>200;
CREATE TRIGGER expensive_insert INSTEAD OF INSERT ON expensive
BEGIN
 SELECT CASE WHEN NEW.price<=200 THEN RAISE(ABORT,'Price is below the view limit') END;
 INSERT INTO products VALUES(NEW.id,NEW.price);
END;
INSERT INTO products VALUES(1,150);
UPDATE products SET price=250 WHERE id=1;
INSERT INTO expensive VALUES(2,300);
SELECT * FROM products;
SELECT * FROM audit;
