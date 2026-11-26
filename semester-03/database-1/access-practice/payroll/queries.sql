-- ЛР 1: сортировка и отбор
SELECT * FROM employees ORDER BY last_name;
SELECT * FROM employees WHERE position='Инженер';
-- ЛР 2: начисления и удержания
SELECT * FROM payroll_summary ORDER BY salary DESC;
-- ЛР 3: выборки
SELECT * FROM payroll_summary WHERE substr(last_name,1,1) BETWEEN 'А' AND 'И';
SELECT * FROM payroll_summary WHERE position <> 'Инженер';
SELECT * FROM payroll_summary WHERE rate>5500;
SELECT * FROM payroll_summary WHERE rate<=6500;
SELECT * FROM payroll_summary WHERE last_name=:surname;
SELECT * FROM payroll_summary WHERE id=:employee_id;
-- ЛР 4: итоги отчёта
SELECT position,COUNT(*) AS employees,ROUND(AVG(rate),2) AS avg_rate,ROUND(AVG(deductions),2) AS avg_deductions,ROUND(AVG(salary),2) AS avg_salary,ROUND(SUM(salary),2) AS total_salary FROM payroll_summary GROUP BY position;
