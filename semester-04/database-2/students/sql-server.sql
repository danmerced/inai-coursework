-- Start with a fresh database. Run in SSMS.
CREATE DATABASE INAI_Students;
GO
USE INAI_Students;
GO
CREATE TABLE fakultet (id_fakultet INT PRIMARY KEY,fakultet NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE grajdanstvo (id_grajdanstvo INT PRIMARY KEY,grajdanstvo NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE natsionalnost (id_natsionalnost INT PRIMARY KEY,natsionalnost NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE oblast (id_oblast INT PRIMARY KEY,oblast NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE pol (id_pol INT PRIMARY KEY,pol NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE sostav (id_sostav INT PRIMARY KEY,sostav NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE tip_kont (id_tip_kont INT PRIMARY KEY,tip_kont NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE tip_nas_punkt (id_tip_nas_punkt INT PRIMARY KEY,tip_nas_punkt NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE tip_pov_kval (id_tip_pov_kval INT PRIMARY KEY,tip_pov_kval NVARCHAR(500) NOT NULL UNIQUE);
CREATE TABLE kafedra(id_kafedra INT PRIMARY KEY,kafedra NVARCHAR(500) NOT NULL,id_fakultet INT NOT NULL REFERENCES fakultet(id_fakultet));
CREATE TABLE rayon(id_rayon INT PRIMARY KEY,rayon NVARCHAR(500) NOT NULL,id_oblast INT NOT NULL REFERENCES oblast(id_oblast));
CREATE TABLE zvanie(id_zvanie INT PRIMARY KEY,zvanie NVARCHAR(500) NOT NULL,id_sostav INT NOT NULL REFERENCES sostav(id_sostav));
CREATE TABLE gruppa(id_gruppa INT PRIMARY KEY,gruppa NVARCHAR(500) NOT NULL,gruppa_sokr NVARCHAR(500),id_kafedra INT NOT NULL REFERENCES kafedra(id_kafedra));
CREATE TABLE nas_punkt(id_nas_punkt INT PRIMARY KEY,nas_punkt NVARCHAR(500) NOT NULL,id_tip_nas_punkt INT NOT NULL REFERENCES tip_nas_punkt(id_tip_nas_punkt),id_rayon INT NOT NULL REFERENCES rayon(id_rayon));
CREATE TABLE student(id_student INT PRIMARY KEY,fam NVARCHAR(500) NOT NULL,imya NVARCHAR(500) NOT NULL,otch NVARCHAR(500),passport NVARCHAR(500),password_hash NVARCHAR(500),reg_date DATE,
 id_gruppa INT NOT NULL REFERENCES gruppa(id_gruppa),id_nas_punkt INT NOT NULL REFERENCES nas_punkt(id_nas_punkt),
 id_natsionalnost INT NOT NULL REFERENCES natsionalnost(id_natsionalnost),id_pol INT NOT NULL REFERENCES pol(id_pol),
 id_grajdanstvo INT NOT NULL REFERENCES grajdanstvo(id_grajdanstvo),comments NVARCHAR(500),foto NVARCHAR(500));
CREATE TABLE kontakty(id_kontakty INT PRIMARY KEY,kontakty NVARCHAR(500) NOT NULL,id_student INT NOT NULL REFERENCES student(id_student),id_tip_kont INT NOT NULL REFERENCES tip_kont(id_tip_kont),UNIQUE(id_student,id_tip_kont));
CREATE TABLE pov_kval(id_pov_kval INT PRIMARY KEY,data_pov DATE,nomer_doc NVARCHAR(500),comments NVARCHAR(500),id_tip_pov_kval INT REFERENCES tip_pov_kval(id_tip_pov_kval),id_student INT REFERENCES student(id_student));
CREATE TABLE voinsk_slujba(id_voinsk_slujba INT PRIMARY KEY,data_nachala DATE,data_okonch DATE,nomer_prikaza NVARCHAR(500),comments NVARCHAR(500),id_student INT REFERENCES student(id_student),id_zvanie INT REFERENCES zvanie(id_zvanie));
INSERT INTO fakultet VALUES
  (1, N'Информатика'),
  (2, N'Экономика');
INSERT INTO grajdanstvo VALUES
  (1, N'КР'),
  (2, N'Другое');
INSERT INTO natsionalnost VALUES
  (1, N'Демо A'),
  (2, N'Демо B');
INSERT INTO oblast VALUES
  (1, N'Чуйская'),
  (2, N'Ошская');
INSERT INTO pol VALUES
  (1, N'М'),
  (2, N'Ж');
INSERT INTO sostav VALUES
  (1, N'Рядовой'),
  (2, N'Офицер');
INSERT INTO tip_kont VALUES
  (1, 'Email'),
  (2, N'Телефон'),
  (3, N'Мессенджер');
INSERT INTO tip_nas_punkt VALUES
  (1, N'Город'),
  (2, N'Село');
INSERT INTO tip_pov_kval VALUES
  (1, N'Курс'),
  (2, N'Семинар');
INSERT INTO kafedra VALUES
  (1, N'Программирование', 1),
  (2, N'Менеджмент', 2);
INSERT INTO rayon VALUES
  (1, N'Аламединский', 1),
  (2, N'Кара-Суйский', 2);
INSERT INTO zvanie VALUES
  (1, N'Рядовой', 1),
  (2, N'Лейтенант', 2);
INSERT INTO gruppa VALUES
  (1, N'Группа A', 'A', 1),
  (2, N'Группа B', 'B', 2);
INSERT INTO nas_punkt VALUES
  (1, N'Демо-город', 1, 1),
  (2, N'Демо-село', 2, 2);
INSERT INTO student VALUES
  (1, N'Студент-01', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 1, 2, NULL, NULL),
  (2, N'Студент-02', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 2, 1, NULL, NULL),
  (3, N'Студент-03', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 2, 2, NULL, NULL),
  (4, N'Студент-04', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 1, 1, NULL, NULL),
  (5, N'Студент-05', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 1, 2, NULL, NULL),
  (6, N'Студент-06', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 2, 1, NULL, NULL),
  (7, N'Студент-07', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 2, 2, NULL, NULL),
  (8, N'Студент-08', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 1, 1, NULL, NULL),
  (9, N'Студент-09', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 1, 2, NULL, NULL),
  (10, N'Студент-10', N'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 2, 1, NULL, NULL),
  (11, N'Студент-11', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 2, 2, NULL, NULL),
  (12, N'Студент-12', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 1, 1, NULL, NULL),
  (13, N'Студент-13', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 1, 2, NULL, NULL),
  (14, N'Студент-14', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 2, 1, NULL, NULL),
  (15, N'Студент-15', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 2, 2, NULL, NULL),
  (16, N'Студент-16', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 1, 1, NULL, NULL),
  (17, N'Студент-17', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 1, 2, NULL, NULL),
  (18, N'Студент-18', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 2, 1, NULL, NULL),
  (19, N'Студент-19', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 2, 2, NULL, NULL),
  (20, N'Студент-20', N'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 1, 1, NULL, NULL);
INSERT INTO kontakty VALUES
  (1, 'student1@example.invalid', 1, 1),
  (2, 'PHONE-1', 1, 2),
  (3, 'CHAT-1', 1, 3),
  (4, 'student2@example.invalid', 2, 1),
  (5, 'PHONE-2', 2, 2),
  (6, 'CHAT-2', 2, 3),
  (7, 'student3@example.invalid', 3, 1),
  (8, 'PHONE-3', 3, 2),
  (9, 'CHAT-3', 3, 3),
  (10, 'student4@example.invalid', 4, 1),
  (11, 'PHONE-4', 4, 2),
  (12, 'CHAT-4', 4, 3),
  (13, 'student5@example.invalid', 5, 1),
  (14, 'PHONE-5', 5, 2),
  (15, 'CHAT-5', 5, 3),
  (16, 'student6@example.invalid', 6, 1),
  (17, 'PHONE-6', 6, 2),
  (18, 'CHAT-6', 6, 3),
  (19, 'student7@example.invalid', 7, 1),
  (20, 'PHONE-7', 7, 2),
  (21, 'CHAT-7', 7, 3),
  (22, 'student8@example.invalid', 8, 1),
  (23, 'PHONE-8', 8, 2),
  (24, 'CHAT-8', 8, 3),
  (25, 'student9@example.invalid', 9, 1),
  (26, 'PHONE-9', 9, 2),
  (27, 'CHAT-9', 9, 3),
  (28, 'student10@example.invalid', 10, 1),
  (29, 'PHONE-10', 10, 2),
  (30, 'CHAT-10', 10, 3),
  (31, 'student11@example.invalid', 11, 1),
  (32, 'PHONE-11', 11, 2),
  (33, 'CHAT-11', 11, 3),
  (34, 'student12@example.invalid', 12, 1),
  (35, 'PHONE-12', 12, 2),
  (36, 'CHAT-12', 12, 3),
  (37, 'student13@example.invalid', 13, 1),
  (38, 'PHONE-13', 13, 2),
  (39, 'CHAT-13', 13, 3),
  (40, 'student14@example.invalid', 14, 1),
  (41, 'PHONE-14', 14, 2),
  (42, 'CHAT-14', 14, 3),
  (43, 'student15@example.invalid', 15, 1),
  (44, 'PHONE-15', 15, 2),
  (45, 'CHAT-15', 15, 3),
  (46, 'student16@example.invalid', 16, 1),
  (47, 'PHONE-16', 16, 2),
  (48, 'CHAT-16', 16, 3),
  (49, 'student17@example.invalid', 17, 1),
  (50, 'PHONE-17', 17, 2),
  (51, 'CHAT-17', 17, 3),
  (52, 'student18@example.invalid', 18, 1),
  (53, 'PHONE-18', 18, 2),
  (54, 'CHAT-18', 18, 3),
  (55, 'student19@example.invalid', 19, 1),
  (56, 'PHONE-19', 19, 2),
  (57, 'CHAT-19', 19, 3),
  (58, 'student20@example.invalid', 20, 1),
  (59, 'PHONE-20', 20, 2),
  (60, 'CHAT-20', 20, 3);
GO
CREATE VIEW student_details AS
SELECT s.id_student,s.fam,s.imya,f.fakultet,k.kafedra,g.gruppa,p.pol,n.natsionalnost,c.grajdanstvo,
 o.oblast,r.rayon,np.nas_punkt,tn.tip_nas_punkt
FROM student s JOIN gruppa g ON g.id_gruppa=s.id_gruppa
JOIN kafedra k ON k.id_kafedra=g.id_kafedra JOIN fakultet f ON f.id_fakultet=k.id_fakultet
JOIN pol p ON p.id_pol=s.id_pol JOIN natsionalnost n ON n.id_natsionalnost=s.id_natsionalnost
JOIN grajdanstvo c ON c.id_grajdanstvo=s.id_grajdanstvo
JOIN nas_punkt np ON np.id_nas_punkt=s.id_nas_punkt JOIN rayon r ON r.id_rayon=np.id_rayon
JOIN oblast o ON o.id_oblast=r.id_oblast JOIN tip_nas_punkt tn ON tn.id_tip_nas_punkt=np.id_tip_nas_punkt;

GO
-- Список группы A
SELECT * FROM student_details WHERE gruppa=N'Группа A' ORDER BY id_student;

-- Сводка: fakultet
SELECT fakultet,COUNT(*) AS total FROM student_details GROUP BY fakultet ORDER BY fakultet;

-- Сводка: kafedra
SELECT kafedra,COUNT(*) AS total FROM student_details GROUP BY kafedra ORDER BY kafedra;

-- Сводка: gruppa
SELECT gruppa,COUNT(*) AS total FROM student_details GROUP BY gruppa ORDER BY gruppa;

-- Сводка: pol
SELECT pol,COUNT(*) AS total FROM student_details GROUP BY pol ORDER BY pol;

-- Сводка: natsionalnost
SELECT natsionalnost,COUNT(*) AS total FROM student_details GROUP BY natsionalnost ORDER BY natsionalnost;

-- Сводка: grajdanstvo
SELECT grajdanstvo,COUNT(*) AS total FROM student_details GROUP BY grajdanstvo ORDER BY grajdanstvo;

-- Сводка: oblast
SELECT oblast,COUNT(*) AS total FROM student_details GROUP BY oblast ORDER BY oblast;

-- Сводка: rayon
SELECT rayon,COUNT(*) AS total FROM student_details GROUP BY rayon ORDER BY rayon;

-- Сводка: nas_punkt
SELECT nas_punkt,COUNT(*) AS total FROM student_details GROUP BY nas_punkt ORDER BY nas_punkt;

-- Сводка: tip_nas_punkt
SELECT tip_nas_punkt,COUNT(*) AS total FROM student_details GROUP BY tip_nas_punkt ORDER BY tip_nas_punkt;

-- Сводка: fakultet,kafedra,gruppa
SELECT fakultet,kafedra,gruppa,COUNT(*) AS total FROM student_details GROUP BY fakultet,kafedra,gruppa ORDER BY fakultet,kafedra,gruppa;

-- Сводка: gruppa,pol
SELECT gruppa,pol,COUNT(*) AS total FROM student_details GROUP BY gruppa,pol ORDER BY gruppa,pol;

-- Сводка: oblast,rayon,nas_punkt
SELECT oblast,rayon,nas_punkt,COUNT(*) AS total FROM student_details GROUP BY oblast,rayon,nas_punkt ORDER BY oblast,rayon,nas_punkt;

-- Сводка: natsionalnost,grajdanstvo
SELECT natsionalnost,grajdanstvo,COUNT(*) AS total FROM student_details GROUP BY natsionalnost,grajdanstvo ORDER BY natsionalnost,grajdanstvo;

-- Контакты по студентам
SELECT s.fam,COUNT(c.id_kontakty) AS total FROM student s LEFT JOIN kontakty c ON c.id_student=s.id_student GROUP BY s.fam ORDER BY s.fam;
