# Результаты переносимого варианта

SQLite: CSV обработан через Python, а не BULK INSERT. Группировка и планы ниже — аналоги, не результаты SSMS.

## Импорт CSV

| rows |
| --- |
| 20 |

## Журнал изменений

| action | total |
| --- | --- |
| INSERT | 12 |
| UPDATE | 5 |

## Оконный запрос 1

| nazvanie | id_kategoriya | cena | rn |
| --- | --- | --- | --- |
| Latte | 1 | 260 | 1 |
| Cappuccino | 1 | 250 | 2 |
| Americano | 1 | 180 | 3 |
| Espresso | 1 | 160 | 4 |
| Green tea | 2 | 135 | 1 |
| Black tea | 2 | 130 | 2 |
| Cheesecake | 3 | 290 | 1 |
| Brownie | 3 | 225 | 2 |
| Matcha | 4 | 310 | 1 |
| Raf | 4 | 300 | 2 |
| Mocha | 4 | 280 | 3 |
| Iced latte | 4 | 270 | 4 |
| Flat white | 4 | 260 | 5 |
| Cold brew | 4 | 250 | 6 |
| Cocoa | 4 | 210 | 7 |
| Lemonade | 4 | 190 | 8 |
| Croissant | 4 | 180 | 9 |
| Muffin | 4 | 150 | 10 |
| Cookie | 4 | 120 | 11 |
| Water | 4 | 70 | 12 |

## Оконный запрос 2

| nazvanie | cena | rnk | dense_rnk |
| --- | --- | --- | --- |
| Matcha | 310 | 1 | 1 |
| Raf | 300 | 2 | 2 |
| Cheesecake | 290 | 3 | 3 |
| Mocha | 280 | 4 | 4 |
| Iced latte | 270 | 5 | 5 |
| Latte | 260 | 6 | 6 |
| Flat white | 260 | 6 | 6 |
| Cappuccino | 250 | 8 | 7 |
| Cold brew | 250 | 8 | 7 |
| Brownie | 225 | 10 | 8 |
| Cocoa | 210 | 11 | 9 |
| Lemonade | 190 | 12 | 10 |
| Americano | 180 | 13 | 11 |
| Croissant | 180 | 13 | 11 |
| Espresso | 160 | 15 | 12 |
| Muffin | 150 | 16 | 13 |
| Green tea | 135 | 17 | 14 |
| Black tea | 130 | 18 | 15 |
| Cookie | 120 | 19 | 16 |
| Water | 70 | 20 | 17 |

## Оконный запрос 3

| nazvanie | cena | previous | difference |
| --- | --- | --- | --- |
| Water | 70 | NULL | NULL |
| Cookie | 120 | 70 | 50 |
| Black tea | 130 | 120 | 10 |
| Green tea | 135 | 130 | 5 |
| Muffin | 150 | 135 | 15 |
| Espresso | 160 | 150 | 10 |
| Americano | 180 | 160 | 20 |
| Croissant | 180 | 180 | 0 |
| Lemonade | 190 | 180 | 10 |
| Cocoa | 210 | 190 | 20 |
| Brownie | 225 | 210 | 15 |
| Cappuccino | 250 | 225 | 25 |
| Cold brew | 250 | 250 | 0 |
| Latte | 260 | 250 | 10 |
| Flat white | 260 | 260 | 0 |
| Iced latte | 270 | 260 | 10 |
| Mocha | 280 | 270 | 10 |
| Cheesecake | 290 | 280 | 10 |
| Raf | 300 | 290 | 10 |
| Matcha | 310 | 300 | 10 |

## Оконный запрос 4

| data | summa | running_total |
| --- | --- | --- |
| 2024-01-03 | 400 | 400 |
| 2024-03-05 | 280 | 680 |
| 2025-01-09 | 380 | 1060 |

## Оконный запрос 5

| id | nazvanie | cena | id_kategoriya | rn |
| --- | --- | --- | --- | --- |
| 2 | Latte | 260 | 1 | 1 |
| 3 | Cappuccino | 250 | 1 | 2 |
| 5 | Green tea | 135 | 2 | 1 |
| 6 | Black tea | 130 | 2 | 2 |
| 7 | Cheesecake | 290 | 3 | 1 |
| 8 | Brownie | 225 | 3 | 2 |
| 11 | Matcha | 310 | 4 | 1 |
| 9 | Raf | 300 | 4 | 2 |

## Оконный запрос 6

| nazvanie | cena | ac |
| --- | --- | --- |
| Latte | 260 | 212.5 |
| Cappuccino | 250 | 212.5 |
| Green tea | 135 | 132.5 |
| Cheesecake | 290 | 257.5 |
| Raf | 300 | 215.83333333333334 |
| Mocha | 280 | 215.83333333333334 |
| Matcha | 310 | 215.83333333333334 |
| Cold brew | 250 | 215.83333333333334 |
| Iced latte | 270 | 215.83333333333334 |
| Flat white | 260 | 215.83333333333334 |

## JOIN 1

| employee | manager |
| --- | --- |
| Manager | NULL |
| Barista A | Manager |
| Barista B | Manager |

## JOIN 2

| category | product |
| --- | --- |
| Coffee | Espresso |
| Coffee | Latte |
| Coffee | Cappuccino |
| Coffee | Americano |
| Tea | Green tea |
| Tea | Black tea |
| Dessert | Cheesecake |
| Dessert | Brownie |
| Other | Raf |
| Other | Mocha |
| Other | Matcha |
| Other | Cold brew |
| Other | Iced latte |
| Other | Flat white |
| Other | Croissant |
| Other | Cookie |
| Other | Muffin |
| Other | Cocoa |
| Other | Lemonade |
| Other | Water |

## JOIN 3

| fio |
| --- |
| Demo One |
| Demo Two |

## Аналог ROLLUP

| category | total |
| --- | --- |
| 1 | 850 |
| 2 | 265 |
| 3 | 515 |
| 4 | 2590 |
| TOTAL | 4220 |

## План до индекса

| id | parent | notused | detail |
| --- | --- | --- | --- |
| 2 | 0 | 216 | SCAN Tovar |

## План после индекса

| id | parent | notused | detail |
| --- | --- | --- | --- |
| 3 | 0 | 61 | SEARCH Tovar USING INDEX idx_tovar_kat (id_kategoriya=?) |

## Функция от даты

| id | parent | notused | detail |
| --- | --- | --- | --- |
| 2 | 0 | 216 | SCAN Zakaz |

## Диапазон дат

| id | parent | notused | detail |
| --- | --- | --- | --- |
| 3 | 0 | 164 | SEARCH Zakaz USING INDEX idx_zakaz_data (data>? AND data<?) |

Откат изменения цены проверен: исходная цена осталась 160.
