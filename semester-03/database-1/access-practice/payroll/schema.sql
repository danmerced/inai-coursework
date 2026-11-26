PRAGMA foreign_keys=ON;
CREATE TABLE employees(id INTEGER PRIMARY KEY,last_name TEXT NOT NULL,first_name TEXT NOT NULL,position TEXT NOT NULL,address TEXT,phone TEXT,photo BLOB,notes TEXT);
CREATE TABLE payroll(employee_id INTEGER PRIMARY KEY REFERENCES employees(id),rate NUMERIC NOT NULL CHECK(rate>=0),deduction_rate REAL NOT NULL CHECK(deduction_rate BETWEEN 0 AND 1));
INSERT INTO employees VALUES(1,'Иванов','Иван','Инженер','Улица 1','11-22-33',NULL,''),(2,'Петрова','Анна','Бухгалтер','Улица 2','44-55-66',NULL,''),(3,'Соколов','Олег','Инженер','Улица 3','77-88-99',NULL,'');
INSERT INTO payroll VALUES(1,6500,0.12),(2,5200,0.1),(3,8000,0.12);
CREATE VIEW payroll_summary AS SELECT e.id,e.last_name,e.first_name,e.position,p.rate,p.deduction_rate,ROUND(p.rate*p.deduction_rate,2) AS deductions,ROUND(p.rate*(1-p.deduction_rate),2) AS salary FROM employees e JOIN payroll p ON e.id=p.employee_id;
