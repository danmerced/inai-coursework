# Результаты SQLite

Товары после триггеров: [(1, 250), (2, 300)]
Журнал: [(1, 150, 250)]
Отклонено: INSERT INTO products VALUES(3,-10) — Price must be positive
Отклонено: UPDATE products SET price=-10 WHERE id=1 — Price must be positive
Отклонено: INSERT INTO expensive VALUES(3,100) — Price is below the view limit

`SELECT u.name AS employee,d.name AS department FROM users_demo u INNER JOIN departments d ON u.department_id=d.id`
[('Demo A', 'IT'), ('Demo B', 'Finance')]

`SELECT u.name AS employee,d.name AS department FROM users_demo u LEFT JOIN departments d ON u.department_id=d.id`
[('Demo A', 'IT'), ('Demo B', 'Finance'), ('Demo C', None)]

`SELECT u.name AS employee,d.name AS department FROM users_demo u RIGHT JOIN departments d ON u.department_id=d.id`
[('Demo A', 'IT'), ('Demo B', 'Finance'), (None, 'Support')]

`SELECT u.name AS employee,d.name AS department FROM users_demo u FULL OUTER JOIN departments d ON u.department_id=d.id`
[('Demo A', 'IT'), ('Demo B', 'Finance'), ('Demo C', None), (None, 'Support')]
