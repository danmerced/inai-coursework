# Результаты выполнения SQL

Демонстрационные данные, SQLite.

```text
id | received_on | supplier | product | quantity | price | cost | supplier_id | product_id
1 | 2025-10-01 | Техно | Клавиатура | 5 | 1200 | 6000 | 1 | 1
2 | 2025-10-01 | Техно | Мышь | 8 | 600 | 4800 | 1 | 2
3 | 2025-10-05 | Офис | Кабель | 4 | 250 | 1000 | 2 | 3
4 | 2025-10-08 | Офис | Клавиатура | 3 | 1200 | 3600 | 2 | 1

id | received_on | supplier | product | quantity | price | cost | supplier_id | product_id
1 | 2025-10-01 | Техно | Клавиатура | 5 | 1200 | 6000 | 1 | 1
2 | 2025-10-01 | Техно | Мышь | 8 | 600 | 4800 | 1 | 2
3 | 2025-10-05 | Офис | Кабель | 4 | 250 | 1000 | 2 | 3

id | received_on | supplier | product | quantity | price | cost | supplier_id | product_id
1 | 2025-10-01 | Техно | Клавиатура | 5 | 1200 | 6000 | 1 | 1
2 | 2025-10-01 | Техно | Мышь | 8 | 600 | 4800 | 1 | 2

id | received_on | supplier | product | quantity | price | cost | supplier_id | product_id
1 | 2025-10-01 | Техно | Клавиатура | 5 | 1200 | 6000 | 1 | 1
2 | 2025-10-01 | Техно | Мышь | 8 | 600 | 4800 | 1 | 2
4 | 2025-10-08 | Офис | Клавиатура | 3 | 1200 | 3600 | 2 | 1

product | total
Кабель | 1000
Клавиатура | 9600
Мышь | 4800

total
15400

supplier | total
Офис | 4600
Техно | 10800

supplier | received_on | total
Офис | 2025-10-05 | 1000
Офис | 2025-10-08 | 3600
Техно | 2025-10-01 | 10800

```
