-- Start with a fresh database. Run in SSMS.
CREATE DATABASE INAI_Contacts;
GO
USE INAI_Contacts;
GO
CREATE TABLE tip_klienta (id_tip_klienta INT PRIMARY KEY, tip_klienta NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE field_of_industry (id_field INT PRIMARY KEY, field_of_industry NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE tip_kontaktov (id_tip_kontaktov INT PRIMARY KEY, tip_kontaktov NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE district (id_district INT PRIMARY KEY, district NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE klient (
 id_klient INT PRIMARY KEY,
 first_name NVARCHAR(500) NOT NULL, middle_name NVARCHAR(500), last_name NVARCHAR(500) NOT NULL,
 record_date DATE NOT NULL, office NVARCHAR(500), position NVARCHAR(500), comments NVARCHAR(500),
 id_tip_klienta INT NOT NULL REFERENCES tip_klienta(id_tip_klienta),
 id_field INT NOT NULL REFERENCES field_of_industry(id_field),
 id_district INT NOT NULL REFERENCES district(id_district)
);
CREATE TABLE kontakty (
 id_kontakty INT PRIMARY KEY, kontakty NVARCHAR(500) NOT NULL,
 id_tip_kontaktov INT NOT NULL REFERENCES tip_kontaktov(id_tip_kontaktov),
 id_klient INT NOT NULL REFERENCES klient(id_klient),
 UNIQUE(id_klient,id_tip_kontaktov)
);
INSERT INTO tip_klienta VALUES
  (1, N'Физическое лицо'),
  (2, N'Компания'),
  (3, N'ИП'),
  (4, N'Государство'),
  (5, N'НКО'),
  (6, N'Партнёр');
INSERT INTO field_of_industry VALUES
  (1, N'Образование'),
  (2, N'Бухгалтерский учет'),
  (3, N'Торговля'),
  (4, 'IT'),
  (5, N'Производство'),
  (6, N'Услуги');
INSERT INTO tip_kontaktov VALUES
  (1, N'Телефон'),
  (2, 'e_mail'),
  (3, N'Мессенджер'),
  (4, N'Рабочий телефон'),
  (5, N'Сайт'),
  (6, N'Почта');
INSERT INTO district VALUES
  (1, N'Первомайский'),
  (2, N'Аламединский'),
  (3, N'Октябрьский'),
  (4, N'Ленинский'),
  (5, N'Свердловский'),
  (6, N'Сокулукский');
INSERT INTO klient VALUES
  (1, N'Клиент 1', N'Тестович', N'Асанов', '2019-09-01', N'Офис 1', N'Менеджер', NULL, 1, 2, 1),
  (2, N'Клиент 2', N'Тестович', N'Беков', '2020-02-01', N'Офис 2', N'Менеджер', NULL, 2, 3, 2),
  (3, N'Клиент 3', N'Тестович', N'Алиев', '2019-09-01', N'Офис 3', N'Менеджер', NULL, 3, 4, 3),
  (4, N'Клиент 4', N'Тестович', N'Иванов', '2020-02-01', N'Офис 4', N'Менеджер', NULL, 4, 5, 1),
  (5, N'Клиент 5', N'Тестович', N'Садыков', '2019-09-01', N'Офис 5', N'Менеджер', NULL, 5, 6, 3),
  (6, N'Клиент 6', N'Тестович', N'Петров', '2020-02-01', N'Офис 6', N'Менеджер', NULL, 6, 1, 4),
  (7, N'Клиент 7', N'Тестович', N'Нуров', '2019-09-01', N'Офис 7', N'Менеджер', NULL, 1, 2, 5),
  (8, N'Клиент 8', N'Тестович', N'Орлов', '2020-02-01', N'Офис 8', N'Менеджер', NULL, 2, 3, 6),
  (9, N'Клиент 9', N'Тестович', N'Ким', '2019-09-01', N'Офис 9', N'Менеджер', NULL, 3, 4, 1),
  (10, N'Клиент 10', N'Тестович', N'Усенов', '2020-02-01', N'Офис 10', N'Менеджер', NULL, 4, 5, 2),
  (11, N'Клиент 11', N'Тестович', N'Абдиев', '2019-09-01', N'Офис 11', N'Менеджер', NULL, 5, 6, 3),
  (12, N'Клиент 12', N'Тестович', N'Миронов', '2020-02-01', N'Офис 12', N'Менеджер', NULL, 6, 1, 4);
INSERT INTO kontakty VALUES
  (1, 'PHONE-01', 1, 1),
  (2, 'client1@example.invalid', 2, 1),
  (3, 'CHAT-01', 3, 1),
  (4, 'WORK-01', 4, 1),
  (5, 'https://example.invalid/1', 5, 1),
  (6, '0555345678', 6, 1),
  (7, 'PHONE-02', 1, 2),
  (8, 'client2@example.invalid', 2, 2),
  (9, 'CHAT-02', 3, 2),
  (10, 'WORK-02', 4, 2),
  (11, 'https://example.invalid/2', 5, 2),
  (12, 'ADDRESS-02', 6, 2),
  (13, 'PHONE-03', 1, 3),
  (14, 'client3@example.invalid', 2, 3),
  (15, 'CHAT-03', 3, 3),
  (16, 'WORK-03', 4, 3),
  (17, 'https://example.invalid/3', 5, 3),
  (18, 'ADDRESS-03', 6, 3),
  (19, 'PHONE-04', 1, 4),
  (20, 'client4@example.invalid', 2, 4),
  (21, 'CHAT-04', 3, 4),
  (22, 'WORK-04', 4, 4),
  (23, 'https://example.invalid/4', 5, 4),
  (24, 'ADDRESS-04', 6, 4),
  (25, 'PHONE-05', 1, 5),
  (26, 'client5@example.invalid', 2, 5),
  (27, 'CHAT-05', 3, 5),
  (28, 'WORK-05', 4, 5),
  (29, 'https://example.invalid/5', 5, 5),
  (30, 'ADDRESS-05', 6, 5),
  (31, 'PHONE-06', 1, 6),
  (32, 'client6@example.invalid', 2, 6),
  (33, 'CHAT-06', 3, 6),
  (34, 'WORK-06', 4, 6),
  (35, 'https://example.invalid/6', 5, 6),
  (36, 'ADDRESS-06', 6, 6),
  (37, 'PHONE-07', 1, 7),
  (38, 'client7@example.invalid', 2, 7),
  (39, 'CHAT-07', 3, 7),
  (40, 'WORK-07', 4, 7),
  (41, 'https://example.invalid/7', 5, 7),
  (42, 'ADDRESS-07', 6, 7),
  (43, 'PHONE-08', 1, 8),
  (44, 'client8@example.invalid', 2, 8),
  (45, 'CHAT-08', 3, 8),
  (46, 'WORK-08', 4, 8),
  (47, 'https://example.invalid/8', 5, 8),
  (48, 'ADDRESS-08', 6, 8),
  (49, 'PHONE-09', 1, 9),
  (50, 'client9@example.invalid', 2, 9),
  (51, 'CHAT-09', 3, 9),
  (52, 'WORK-09', 4, 9),
  (53, 'https://example.invalid/9', 5, 9),
  (54, 'ADDRESS-09', 6, 9),
  (55, 'PHONE-10', 1, 10),
  (56, 'client10@example.invalid', 2, 10),
  (57, 'CHAT-10', 3, 10),
  (58, 'WORK-10', 4, 10),
  (59, 'https://example.invalid/10', 5, 10),
  (60, 'ADDRESS-10', 6, 10),
  (61, 'PHONE-11', 1, 11),
  (62, 'client11@example.invalid', 2, 11),
  (63, 'CHAT-11', 3, 11),
  (64, 'WORK-11', 4, 11),
  (65, 'https://example.invalid/11', 5, 11),
  (66, 'ADDRESS-11', 6, 11),
  (67, 'PHONE-12', 1, 12),
  (68, 'client12@example.invalid', 2, 12),
  (69, 'CHAT-12', 3, 12),
  (70, 'WORK-12', 4, 12),
  (71, 'https://example.invalid/12', 5, 12),
  (72, 'ADDRESS-12', 6, 12);
GO
CREATE VIEW client_contacts AS
 SELECT k.id_klient,k.first_name,k.middle_name,k.last_name,k.record_date,k.id_district,k.id_field,k.id_tip_klienta,
 d.district,f.field_of_industry,t.tip_klienta,c.id_kontakty,c.kontakty,ct.tip_kontaktov
 FROM klient k JOIN district d ON d.id_district=k.id_district
 JOIN field_of_industry f ON f.id_field=k.id_field
 JOIN tip_klienta t ON t.id_tip_klienta=k.id_tip_klienta
 JOIN kontakty c ON c.id_klient=k.id_klient
 JOIN tip_kontaktov ct ON ct.id_tip_kontaktov=c.id_tip_kontaktov;

GO
-- 4.3 Клиент по номеру контакта
SELECT id_klient,first_name,last_name FROM client_contacts WHERE id_kontakty=6;

-- 4.4 Контакты клиента
SELECT kontakty,tip_kontaktov FROM client_contacts WHERE id_klient=1;

-- 4.5 Клиенты по району
SELECT id_klient,last_name FROM klient WHERE id_district=2;

-- 4.6 Район 1, направление 2
SELECT id_klient,last_name FROM klient WHERE id_district=1 AND id_field=2;

-- 4.7 Электронная почта района 3
SELECT last_name,kontakty FROM client_contacts WHERE id_district=3 AND tip_kontaktov='e_mail';

-- 4.8 ФИО по контакту 3
SELECT last_name,first_name,middle_name FROM client_contacts WHERE id_kontakty=3;

-- 4.9 Все контакты района 2
SELECT last_name,kontakty FROM client_contacts WHERE id_district=2;

-- 4.10 Район и отрасль по контакту 6
SELECT district,field_of_industry FROM client_contacts WHERE id_kontakty=6;

-- 6.1 Контакты клиента 3
SELECT kontakty,tip_kontaktov FROM client_contacts WHERE id_klient=3;

-- 6.2 Контакты бухгалтеров
SELECT last_name,kontakty FROM client_contacts WHERE field_of_industry=N'Бухгалтерский учет';

-- 6.3 Первомайский район
SELECT last_name,kontakty FROM client_contacts WHERE district=N'Первомайский';

-- 6.4 Телефоны Аламединского района
SELECT last_name,kontakty FROM client_contacts WHERE district=N'Аламединский' AND tip_kontaktov=N'Телефон';

-- 6.5 Бухгалтеры Первомайского района
SELECT last_name,kontakty FROM client_contacts WHERE district=N'Первомайский' AND field_of_industry=N'Бухгалтерский учет';

-- 6.6 Фамилии на А в Октябрьском районе
SELECT k.last_name FROM klient k JOIN district d ON d.id_district=k.id_district WHERE d.district=N'Октябрьский' AND k.last_name LIKE N'А%';

-- 6.7 Количество по районам
SELECT d.district,COUNT(k.id_klient) AS total FROM district d LEFT JOIN klient k ON k.id_district=d.id_district GROUP BY d.district;

-- 6.8 Количество по сферам
SELECT f.field_of_industry,COUNT(k.id_klient) AS total FROM field_of_industry f LEFT JOIN klient k ON k.id_field=f.id_field GROUP BY f.field_of_industry;

-- 6.9 Фамилия по контакту 5
SELECT last_name FROM client_contacts WHERE id_kontakty=5;

-- 6.10 Район и тип клиента по контакту 6
SELECT district,tip_klienta FROM client_contacts WHERE id_kontakty=6;

-- 6.11 Район и тип по значению контакта
SELECT district,tip_klienta FROM client_contacts WHERE kontakty='0555345678';

-- 6.12 Район, тип, сфера, фамилия
SELECT district,tip_klienta,field_of_industry,last_name FROM client_contacts WHERE id_kontakty=6;

-- 6.13 Контакты первых пяти клиентов
WITH numbered AS (SELECT id_klient,ROW_NUMBER() OVER(ORDER BY id_klient) AS rn FROM klient) SELECT c.last_name,c.kontakty FROM client_contacts c JOIN numbered n ON n.id_klient=c.id_klient WHERE n.rn<=5 ORDER BY c.id_klient,c.id_kontakty;

-- 6.14 Все контакты Первомайского района
SELECT last_name,tip_kontaktov,kontakty FROM client_contacts WHERE district=N'Первомайский' ORDER BY id_klient,id_kontakty;

-- 7.1 Число строк tip_klienta
SELECT COUNT(*) AS total FROM tip_klienta;

-- 7.1 Число строк field_of_industry
SELECT COUNT(*) AS total FROM field_of_industry;

-- 7.1 Число строк tip_kontaktov
SELECT COUNT(*) AS total FROM tip_kontaktov;

-- 7.1 Число строк district
SELECT COUNT(*) AS total FROM district;

-- 7.1 Число строк klient
SELECT COUNT(*) AS total FROM klient;

-- 7.1 Число строк kontakty
SELECT COUNT(*) AS total FROM kontakty;

-- 7.2 Клиенты выбранного района
SELECT COUNT(*) AS total FROM klient WHERE id_district=1;

-- 7.3 Клиенты по районам
SELECT d.district,COUNT(k.id_klient) AS total FROM district d LEFT JOIN klient k ON k.id_district=d.id_district GROUP BY d.district;

-- 7.4 Типы клиентов до даты
SELECT t.tip_klienta,COUNT(*) AS total FROM klient k JOIN tip_klienta t ON t.id_tip_klienta=k.id_tip_klienta WHERE record_date <= '2019-10-10' GROUP BY t.tip_klienta;

-- 7.5 Число контактов каждого клиента
SELECT k.id_klient,k.last_name,COUNT(c.id_kontakty) AS total FROM klient k LEFT JOIN kontakty c ON c.id_klient=k.id_klient GROUP BY k.id_klient,k.last_name;

-- 7.6 Число контактов с типом клиента
SELECT k.id_klient,k.last_name,t.tip_klienta,COUNT(c.id_kontakty) AS total FROM klient k JOIN tip_klienta t ON t.id_tip_klienta=k.id_tip_klienta LEFT JOIN kontakty c ON c.id_klient=k.id_klient GROUP BY k.id_klient,k.last_name,t.tip_klienta;

-- 7.7 Клиенты без контактов
SELECT k.id_klient,k.last_name FROM klient k LEFT JOIN kontakty c ON c.id_klient=k.id_klient WHERE c.id_kontakty IS NULL;

-- 7.8 Число контактов клиентов до даты
SELECT k.id_klient,k.last_name,COUNT(c.id_kontakty) AS total FROM klient k LEFT JOIN kontakty c ON c.id_klient=k.id_klient WHERE k.record_date <= '2019-10-10' GROUP BY k.id_klient,k.last_name;
