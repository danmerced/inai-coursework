# Результаты запросов (SQLite)

Демонстрационные данные; запуск на встроенной SQLite.

## 4.3 Клиент по номеру контакта

| id_klient | first_name | last_name |
| --- | --- | --- |
| 1 | Клиент 1 | Асанов |


## 4.4 Контакты клиента

| kontakty | tip_kontaktov |
| --- | --- |
| PHONE-01 | Телефон |
| client1@example.invalid | e_mail |
| CHAT-01 | Мессенджер |
| WORK-01 | Рабочий телефон |
| https://example.invalid/1 | Сайт |
| 0555345678 | Почта |


## 4.5 Клиенты по району

| id_klient | last_name |
| --- | --- |
| 2 | Беков |
| 10 | Усенов |


## 4.6 Район 1, направление 2

| id_klient | last_name |
| --- | --- |
| 1 | Асанов |


## 4.7 Электронная почта района 3

| last_name | kontakty |
| --- | --- |
| Алиев | client3@example.invalid |
| Садыков | client5@example.invalid |
| Абдиев | client11@example.invalid |


## 4.8 ФИО по контакту 3

| last_name | first_name | middle_name |
| --- | --- | --- |
| Асанов | Клиент 1 | Тестович |


## 4.9 Все контакты района 2

| last_name | kontakty |
| --- | --- |
| Беков | PHONE-02 |
| Беков | client2@example.invalid |
| Беков | CHAT-02 |
| Беков | WORK-02 |
| Беков | https://example.invalid/2 |
| Беков | ADDRESS-02 |
| Усенов | PHONE-10 |
| Усенов | client10@example.invalid |
| Усенов | CHAT-10 |
| Усенов | WORK-10 |
| Усенов | https://example.invalid/10 |
| Усенов | ADDRESS-10 |


## 4.10 Район и отрасль по контакту 6

| district | field_of_industry |
| --- | --- |
| Первомайский | Бухгалтерский учет |


## 6.1 Контакты клиента 3

| kontakty | tip_kontaktov |
| --- | --- |
| PHONE-03 | Телефон |
| client3@example.invalid | e_mail |
| CHAT-03 | Мессенджер |
| WORK-03 | Рабочий телефон |
| https://example.invalid/3 | Сайт |
| ADDRESS-03 | Почта |


## 6.2 Контакты бухгалтеров

| last_name | kontakty |
| --- | --- |
| Асанов | PHONE-01 |
| Асанов | client1@example.invalid |
| Асанов | CHAT-01 |
| Асанов | WORK-01 |
| Асанов | https://example.invalid/1 |
| Асанов | 0555345678 |
| Нуров | PHONE-07 |
| Нуров | client7@example.invalid |
| Нуров | CHAT-07 |
| Нуров | WORK-07 |
| Нуров | https://example.invalid/7 |
| Нуров | ADDRESS-07 |


## 6.3 Первомайский район

| last_name | kontakty |
| --- | --- |
| Асанов | PHONE-01 |
| Асанов | client1@example.invalid |
| Асанов | CHAT-01 |
| Асанов | WORK-01 |
| Асанов | https://example.invalid/1 |
| Асанов | 0555345678 |
| Иванов | PHONE-04 |
| Иванов | client4@example.invalid |
| Иванов | CHAT-04 |
| Иванов | WORK-04 |
| Иванов | https://example.invalid/4 |
| Иванов | ADDRESS-04 |
| Ким | PHONE-09 |
| Ким | client9@example.invalid |
| Ким | CHAT-09 |
| Ким | WORK-09 |
| Ким | https://example.invalid/9 |
| Ким | ADDRESS-09 |


## 6.4 Телефоны Аламединского района

| last_name | kontakty |
| --- | --- |
| Беков | PHONE-02 |
| Усенов | PHONE-10 |


## 6.5 Бухгалтеры Первомайского района

| last_name | kontakty |
| --- | --- |
| Асанов | PHONE-01 |
| Асанов | client1@example.invalid |
| Асанов | CHAT-01 |
| Асанов | WORK-01 |
| Асанов | https://example.invalid/1 |
| Асанов | 0555345678 |


## 6.6 Фамилии на А в Октябрьском районе

| last_name |
| --- |
| Алиев |
| Абдиев |


## 6.7 Количество по районам

| district | total |
| --- | --- |
| Аламединский | 2 |
| Ленинский | 2 |
| Октябрьский | 3 |
| Первомайский | 3 |
| Свердловский | 1 |
| Сокулукский | 1 |


## 6.8 Количество по сферам

| field_of_industry | total |
| --- | --- |
| IT | 2 |
| Бухгалтерский учет | 2 |
| Образование | 2 |
| Производство | 2 |
| Торговля | 2 |
| Услуги | 2 |


## 6.9 Фамилия по контакту 5

| last_name |
| --- |
| Асанов |


## 6.10 Район и тип клиента по контакту 6

| district | tip_klienta |
| --- | --- |
| Первомайский | Физическое лицо |


## 6.11 Район и тип по значению контакта

| district | tip_klienta |
| --- | --- |
| Первомайский | Физическое лицо |


## 6.12 Район, тип, сфера, фамилия

| district | tip_klienta | field_of_industry | last_name |
| --- | --- | --- | --- |
| Первомайский | Физическое лицо | Бухгалтерский учет | Асанов |


## 6.13 Контакты первых пяти клиентов

| last_name | kontakty |
| --- | --- |
| Асанов | PHONE-01 |
| Асанов | client1@example.invalid |
| Асанов | CHAT-01 |
| Асанов | WORK-01 |
| Асанов | https://example.invalid/1 |
| Асанов | 0555345678 |
| Беков | PHONE-02 |
| Беков | client2@example.invalid |
| Беков | CHAT-02 |
| Беков | WORK-02 |
| Беков | https://example.invalid/2 |
| Беков | ADDRESS-02 |
| Алиев | PHONE-03 |
| Алиев | client3@example.invalid |
| Алиев | CHAT-03 |
| Алиев | WORK-03 |
| Алиев | https://example.invalid/3 |
| Алиев | ADDRESS-03 |
| Иванов | PHONE-04 |
| Иванов | client4@example.invalid |
| Иванов | CHAT-04 |
| Иванов | WORK-04 |
| Иванов | https://example.invalid/4 |
| Иванов | ADDRESS-04 |
| Садыков | PHONE-05 |
| Садыков | client5@example.invalid |
| Садыков | CHAT-05 |
| Садыков | WORK-05 |
| Садыков | https://example.invalid/5 |
| Садыков | ADDRESS-05 |


## 6.14 Все контакты Первомайского района

| last_name | tip_kontaktov | kontakty |
| --- | --- | --- |
| Асанов | Телефон | PHONE-01 |
| Асанов | e_mail | client1@example.invalid |
| Асанов | Мессенджер | CHAT-01 |
| Асанов | Рабочий телефон | WORK-01 |
| Асанов | Сайт | https://example.invalid/1 |
| Асанов | Почта | 0555345678 |
| Иванов | Телефон | PHONE-04 |
| Иванов | e_mail | client4@example.invalid |
| Иванов | Мессенджер | CHAT-04 |
| Иванов | Рабочий телефон | WORK-04 |
| Иванов | Сайт | https://example.invalid/4 |
| Иванов | Почта | ADDRESS-04 |
| Ким | Телефон | PHONE-09 |
| Ким | e_mail | client9@example.invalid |
| Ким | Мессенджер | CHAT-09 |
| Ким | Рабочий телефон | WORK-09 |
| Ким | Сайт | https://example.invalid/9 |
| Ким | Почта | ADDRESS-09 |


## 7.1 Число строк tip_klienta

| total |
| --- |
| 6 |


## 7.1 Число строк field_of_industry

| total |
| --- |
| 6 |


## 7.1 Число строк tip_kontaktov

| total |
| --- |
| 6 |


## 7.1 Число строк district

| total |
| --- |
| 6 |


## 7.1 Число строк klient

| total |
| --- |
| 12 |


## 7.1 Число строк kontakty

| total |
| --- |
| 72 |


## 7.2 Клиенты выбранного района

| total |
| --- |
| 3 |


## 7.3 Клиенты по районам

| district | total |
| --- | --- |
| Аламединский | 2 |
| Ленинский | 2 |
| Октябрьский | 3 |
| Первомайский | 3 |
| Свердловский | 1 |
| Сокулукский | 1 |


## 7.4 Типы клиентов до даты

| tip_klienta | total |
| --- | --- |
| ИП | 2 |
| НКО | 2 |
| Физическое лицо | 2 |


## 7.5 Число контактов каждого клиента

| id_klient | last_name | total |
| --- | --- | --- |
| 1 | Асанов | 6 |
| 2 | Беков | 6 |
| 3 | Алиев | 6 |
| 4 | Иванов | 6 |
| 5 | Садыков | 6 |
| 6 | Петров | 6 |
| 7 | Нуров | 6 |
| 8 | Орлов | 6 |
| 9 | Ким | 6 |
| 10 | Усенов | 6 |
| 11 | Абдиев | 6 |
| 12 | Миронов | 6 |


## 7.6 Число контактов с типом клиента

| id_klient | last_name | tip_klienta | total |
| --- | --- | --- | --- |
| 1 | Асанов | Физическое лицо | 6 |
| 2 | Беков | Компания | 6 |
| 3 | Алиев | ИП | 6 |
| 4 | Иванов | Государство | 6 |
| 5 | Садыков | НКО | 6 |
| 6 | Петров | Партнёр | 6 |
| 7 | Нуров | Физическое лицо | 6 |
| 8 | Орлов | Компания | 6 |
| 9 | Ким | ИП | 6 |
| 10 | Усенов | Государство | 6 |
| 11 | Абдиев | НКО | 6 |
| 12 | Миронов | Партнёр | 6 |


## 7.7 Клиенты без контактов

| id_klient | last_name |
| --- | --- |

Нет строк.


## 7.8 Число контактов клиентов до даты

| id_klient | last_name | total |
| --- | --- | --- |
| 1 | Асанов | 6 |
| 3 | Алиев | 6 |
| 5 | Садыков | 6 |
| 7 | Нуров | 6 |
| 9 | Ким | 6 |
| 11 | Абдиев | 6 |
