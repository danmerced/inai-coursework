# Результаты выполнения SQL

Демонстрационные данные, SQLite.

```text
name | price
Абрикос | 150
Апельсин | 120

id | order_id | gross | discount_amount
1 | 1 | 2400 | 240.0
2 | 1 | 1800 | 0.0
3 | 2 | 850 | 42.5
4 | 3 | 1200 | 0.0
5 | 4 | 4200 | 420.0

order_number | placed_at | name | quantity | price | discount
D001 | 2025-10-01 | Абрикос | 12 | 150 | 0.0
D001 | 2025-10-01 | Апельсин | 20 | 120 | 0.1
D003 | 2025-10-03 | Ананас | 5 | 240 | 0.0

company
Fresh Market
Fruit Cafe

order_number | company | total | paid
D001 | Fresh Market | 3960.0 | 3960
D002 | Green Shop | 807.5 | 807.5
D003 | Fresh Market | 1200.0 | 0
D004 | Fruit Cafe | 3780.0 | 2000

```
