CREATE TABLE tip_klienta (id_tip_klienta INT PRIMARY KEY, tip_klienta TEXT NOT NULL UNIQUE);
CREATE TABLE field_of_industry (id_field INT PRIMARY KEY, field_of_industry TEXT NOT NULL UNIQUE);
CREATE TABLE tip_kontaktov (id_tip_kontaktov INT PRIMARY KEY, tip_kontaktov TEXT NOT NULL UNIQUE);
CREATE TABLE district (id_district INT PRIMARY KEY, district TEXT NOT NULL UNIQUE);
CREATE TABLE klient (
 id_klient INT PRIMARY KEY,
 first_name TEXT NOT NULL, middle_name TEXT, last_name TEXT NOT NULL,
 record_date DATE NOT NULL, office TEXT, position TEXT, comments TEXT,
 id_tip_klienta INT NOT NULL REFERENCES tip_klienta(id_tip_klienta),
 id_field INT NOT NULL REFERENCES field_of_industry(id_field),
 id_district INT NOT NULL REFERENCES district(id_district)
);
CREATE TABLE kontakty (
 id_kontakty INT PRIMARY KEY, kontakty TEXT NOT NULL,
 id_tip_kontaktov INT NOT NULL REFERENCES tip_kontaktov(id_tip_kontaktov),
 id_klient INT NOT NULL REFERENCES klient(id_klient),
 UNIQUE(id_klient,id_tip_kontaktov)
);
INSERT INTO tip_klienta VALUES
  (1, 'Физическое лицо'),
  (2, 'Компания'),
  (3, 'ИП'),
  (4, 'Государство'),
  (5, 'НКО'),
  (6, 'Партнёр');
INSERT INTO field_of_industry VALUES
  (1, 'Образование'),
  (2, 'Бухгалтерский учет'),
  (3, 'Торговля'),
  (4, 'IT'),
  (5, 'Производство'),
  (6, 'Услуги');
INSERT INTO tip_kontaktov VALUES
  (1, 'Телефон'),
  (2, 'e_mail'),
  (3, 'Мессенджер'),
  (4, 'Рабочий телефон'),
  (5, 'Сайт'),
  (6, 'Почта');
INSERT INTO district VALUES
  (1, 'Первомайский'),
  (2, 'Аламединский'),
  (3, 'Октябрьский'),
  (4, 'Ленинский'),
  (5, 'Свердловский'),
  (6, 'Сокулукский');
INSERT INTO klient VALUES
  (1, 'Клиент 1', 'Тестович', 'Асанов', '2019-09-01', 'Офис 1', 'Менеджер', NULL, 1, 2, 1),
  (2, 'Клиент 2', 'Тестович', 'Беков', '2020-02-01', 'Офис 2', 'Менеджер', NULL, 2, 3, 2),
  (3, 'Клиент 3', 'Тестович', 'Алиев', '2019-09-01', 'Офис 3', 'Менеджер', NULL, 3, 4, 3),
  (4, 'Клиент 4', 'Тестович', 'Иванов', '2020-02-01', 'Офис 4', 'Менеджер', NULL, 4, 5, 1),
  (5, 'Клиент 5', 'Тестович', 'Садыков', '2019-09-01', 'Офис 5', 'Менеджер', NULL, 5, 6, 3),
  (6, 'Клиент 6', 'Тестович', 'Петров', '2020-02-01', 'Офис 6', 'Менеджер', NULL, 6, 1, 4),
  (7, 'Клиент 7', 'Тестович', 'Нуров', '2019-09-01', 'Офис 7', 'Менеджер', NULL, 1, 2, 5),
  (8, 'Клиент 8', 'Тестович', 'Орлов', '2020-02-01', 'Офис 8', 'Менеджер', NULL, 2, 3, 6),
  (9, 'Клиент 9', 'Тестович', 'Ким', '2019-09-01', 'Офис 9', 'Менеджер', NULL, 3, 4, 1),
  (10, 'Клиент 10', 'Тестович', 'Усенов', '2020-02-01', 'Офис 10', 'Менеджер', NULL, 4, 5, 2),
  (11, 'Клиент 11', 'Тестович', 'Абдиев', '2019-09-01', 'Офис 11', 'Менеджер', NULL, 5, 6, 3),
  (12, 'Клиент 12', 'Тестович', 'Миронов', '2020-02-01', 'Офис 12', 'Менеджер', NULL, 6, 1, 4);
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
CREATE VIEW client_contacts AS
 SELECT k.id_klient,k.first_name,k.middle_name,k.last_name,k.record_date,k.id_district,k.id_field,k.id_tip_klienta,
 d.district,f.field_of_industry,t.tip_klienta,c.id_kontakty,c.kontakty,ct.tip_kontaktov
 FROM klient k JOIN district d ON d.id_district=k.id_district
 JOIN field_of_industry f ON f.id_field=k.id_field
 JOIN tip_klienta t ON t.id_tip_klienta=k.id_tip_klienta
 JOIN kontakty c ON c.id_klient=k.id_klient
 JOIN tip_kontaktov ct ON ct.id_tip_kontaktov=c.id_tip_kontaktov;
