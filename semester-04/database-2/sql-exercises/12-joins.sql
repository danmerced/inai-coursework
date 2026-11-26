CREATE TABLE departments(id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE users_demo(id INT PRIMARY KEY, name VARCHAR(50),department_id INT REFERENCES departments(id));
INSERT INTO departments VALUES(1,'IT'),(2,'Finance'),(3,'Support');
INSERT INTO users_demo VALUES(1,'Demo A',1),(2,'Demo B',2),(3,'Demo C',NULL);
SELECT u.name AS employee,d.name AS department FROM users_demo u INNER JOIN departments d ON u.department_id=d.id;
SELECT u.name AS employee,d.name AS department FROM users_demo u LEFT JOIN departments d ON u.department_id=d.id;
SELECT u.name AS employee,d.name AS department FROM users_demo u RIGHT JOIN departments d ON u.department_id=d.id;
SELECT u.name AS employee,d.name AS department FROM users_demo u FULL OUTER JOIN departments d ON u.department_id=d.id;
