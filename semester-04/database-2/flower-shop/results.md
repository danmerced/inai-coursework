# Результаты запросов

Тела 24 процедур выполнены как параметризованные SELECT в SQLite. Обёртки CREATE PROCEDURE не запускались.

## SupplyProducts

| id | day | name | qty | price |
| --- | --- | --- | --- | --- |
| 1 | 2026-02-01 | Rose | 40 | 60 |
| 1 | 2026-02-01 | Tulip | 30 | 40 |
| 2 | 2026-02-10 | Vase | 10 | 150 |
| 3 | 2026-03-01 | Rose | 20 | 65 |

## SupplierProducts

| id | day | name | qty | price |
| --- | --- | --- | --- | --- |
| 1 | 2026-02-01 | Rose | 40 | 60 |
| 1 | 2026-02-01 | Tulip | 30 | 40 |
| 3 | 2026-03-01 | Rose | 20 | 65 |

## SupplyByType

| name | qty |
| --- | --- |
| Rose | 60 |
| Tulip | 30 |

## SupplyTotals

| name | qty | total |
| --- | --- | --- |
| Rose | 60 | 3700 |
| Tulip | 30 | 1200 |
| Vase | 10 | 1500 |

## SupplyByClient

| name | qty | total |
| --- | --- | --- |
| Rose | 60 | 3700 |
| Tulip | 30 | 1200 |

## SupplyPriceHistory

| name | day | price | previous_price |
| --- | --- | --- | --- |
| Rose | 2026-02-01 | 60 | None |
| Rose | 2026-03-01 | 65 | 60 |
| Tulip | 2026-02-01 | 40 | None |
| Vase | 2026-02-10 | 150 | None |

## SupplyPayments

| id | supply_id | day | amount | supplier_id |
| --- | --- | --- | --- | --- |
| 1 | 1 | 2026-02-03 | 2400 | 1 |
| 2 | 2 | 2026-02-11 | 1500 | 2 |

## SupplyPaymentsByClient

| day | amount | client_id |
| --- | --- | --- |
| 2026-02-03 | 2400 | 1 |

## SaleProducts

| id | day | name | qty | price |
| --- | --- | --- | --- | --- |
| 1 | 2026-02-05 | Rose | 5 | 120 |
| 1 | 2026-02-05 | Tulip | 2 | 80 |
| 2 | 2026-02-12 | Vase | 2 | 300 |
| 3 | 2026-03-02 | Rose | 3 | 130 |

## ClientOrders

| id | day | total |
| --- | --- | --- |
| 1 | 2026-02-05 | 760 |
| 3 | 2026-03-02 | 390 |

## SoldProducts

| name | qty | total |
| --- | --- | --- |
| Rose | 8 | 990 |
| Tulip | 2 | 160 |
| Vase | 2 | 600 |

## SalesByClient

| id | day | name | qty | price |
| --- | --- | --- | --- | --- |
| 1 | 2026-02-05 | Rose | 5 | 120 |
| 1 | 2026-02-05 | Tulip | 2 | 80 |
| 3 | 2026-03-02 | Rose | 3 | 130 |

## SalePriceHistory

| name | day | price | previous_price |
| --- | --- | --- | --- |
| Rose | 2026-02-05 | 120 | None |
| Rose | 2026-03-02 | 130 | 120 |
| Tulip | 2026-02-05 | 80 | None |
| Vase | 2026-02-12 | 300 | None |

## CurrentPrice

| id | name | price |
| --- | --- | --- |
| 1 | Rose | 120 |
| 2 | Tulip | 80 |
| 3 | Vase | 300 |

## SalePayments

| id | day | method | amount | client_id |
| --- | --- | --- | --- | --- |
| 1 | 2026-02-05 | Card | 760 | 1 |
| 2 | 2026-02-12 | Cash | 500 | 2 |
| 3 | 2026-03-02 | Card | 390 | 1 |

## SalePaymentMethods

| method | total |
| --- | --- |
| Card | 1150 |

## EmployeeSales

| id | day | name | qty | price |
| --- | --- | --- | --- | --- |
| 1 | 2026-02-05 | Rose | 5 | 120 |
| 1 | 2026-02-05 | Tulip | 2 | 80 |

## EmployeeStatistics

| name | orders | total |
| --- | --- | --- |
| Worker A | 1 | 760 |
| Worker B | 2 | 990 |

## DistrictSales

| name | total |
| --- | --- |
| North | 1150 |

## ClientTypeStatistics

| name | total |
| --- | --- |
| Business | 600 |
| Individual | 1150 |

## ClientContacts

| kind | value |
| --- | --- |
| email | a@example.invalid |

## OrdersBySaleType

| id | day | sale_type | total |
| --- | --- | --- | --- |
| 1 | 2026-02-05 | Retail | 760 |
| 3 | 2026-03-02 | Retail | 390 |

## OrdersByOrderType

| id | day | order_type | total |
| --- | --- | --- | --- |
| 2 | 2026-02-12 | Store | 600 |
| 3 | 2026-03-02 | Store | 390 |

## ProductBalance

| name | opening | supplied | sold | closing |
| --- | --- | --- | --- | --- |
| Rose | 0 | 60 | 8 | 52 |
| Tulip | 0 | 30 | 2 | 28 |
| Vase | 0 | 10 | 2 | 8 |
