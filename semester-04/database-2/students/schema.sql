CREATE TABLE fakultet (id_fakultet INT PRIMARY KEY,fakultet TEXT NOT NULL UNIQUE);
CREATE TABLE grajdanstvo (id_grajdanstvo INT PRIMARY KEY,grajdanstvo TEXT NOT NULL UNIQUE);
CREATE TABLE natsionalnost (id_natsionalnost INT PRIMARY KEY,natsionalnost TEXT NOT NULL UNIQUE);
CREATE TABLE oblast (id_oblast INT PRIMARY KEY,oblast TEXT NOT NULL UNIQUE);
CREATE TABLE pol (id_pol INT PRIMARY KEY,pol TEXT NOT NULL UNIQUE);
CREATE TABLE sostav (id_sostav INT PRIMARY KEY,sostav TEXT NOT NULL UNIQUE);
CREATE TABLE tip_kont (id_tip_kont INT PRIMARY KEY,tip_kont TEXT NOT NULL UNIQUE);
CREATE TABLE tip_nas_punkt (id_tip_nas_punkt INT PRIMARY KEY,tip_nas_punkt TEXT NOT NULL UNIQUE);
CREATE TABLE tip_pov_kval (id_tip_pov_kval INT PRIMARY KEY,tip_pov_kval TEXT NOT NULL UNIQUE);
CREATE TABLE kafedra(id_kafedra INT PRIMARY KEY,kafedra TEXT NOT NULL,id_fakultet INT NOT NULL REFERENCES fakultet(id_fakultet));
CREATE TABLE rayon(id_rayon INT PRIMARY KEY,rayon TEXT NOT NULL,id_oblast INT NOT NULL REFERENCES oblast(id_oblast));
CREATE TABLE zvanie(id_zvanie INT PRIMARY KEY,zvanie TEXT NOT NULL,id_sostav INT NOT NULL REFERENCES sostav(id_sostav));
CREATE TABLE gruppa(id_gruppa INT PRIMARY KEY,gruppa TEXT NOT NULL,gruppa_sokr TEXT,id_kafedra INT NOT NULL REFERENCES kafedra(id_kafedra));
CREATE TABLE nas_punkt(id_nas_punkt INT PRIMARY KEY,nas_punkt TEXT NOT NULL,id_tip_nas_punkt INT NOT NULL REFERENCES tip_nas_punkt(id_tip_nas_punkt),id_rayon INT NOT NULL REFERENCES rayon(id_rayon));
CREATE TABLE student(id_student INT PRIMARY KEY,fam TEXT NOT NULL,imya TEXT NOT NULL,otch TEXT,passport TEXT,password_hash TEXT,reg_date DATE,
 id_gruppa INT NOT NULL REFERENCES gruppa(id_gruppa),id_nas_punkt INT NOT NULL REFERENCES nas_punkt(id_nas_punkt),
 id_natsionalnost INT NOT NULL REFERENCES natsionalnost(id_natsionalnost),id_pol INT NOT NULL REFERENCES pol(id_pol),
 id_grajdanstvo INT NOT NULL REFERENCES grajdanstvo(id_grajdanstvo),comments TEXT,foto TEXT);
CREATE TABLE kontakty(id_kontakty INT PRIMARY KEY,kontakty TEXT NOT NULL,id_student INT NOT NULL REFERENCES student(id_student),id_tip_kont INT NOT NULL REFERENCES tip_kont(id_tip_kont),UNIQUE(id_student,id_tip_kont));
CREATE TABLE pov_kval(id_pov_kval INT PRIMARY KEY,data_pov DATE,nomer_doc TEXT,comments TEXT,id_tip_pov_kval INT REFERENCES tip_pov_kval(id_tip_pov_kval),id_student INT REFERENCES student(id_student));
CREATE TABLE voinsk_slujba(id_voinsk_slujba INT PRIMARY KEY,data_nachala DATE,data_okonch DATE,nomer_prikaza TEXT,comments TEXT,id_student INT REFERENCES student(id_student),id_zvanie INT REFERENCES zvanie(id_zvanie));
INSERT INTO fakultet VALUES
  (1, 'Информатика'),
  (2, 'Экономика');
INSERT INTO grajdanstvo VALUES
  (1, 'КР'),
  (2, 'Другое');
INSERT INTO natsionalnost VALUES
  (1, 'Демо A'),
  (2, 'Демо B');
INSERT INTO oblast VALUES
  (1, 'Чуйская'),
  (2, 'Ошская');
INSERT INTO pol VALUES
  (1, 'М'),
  (2, 'Ж');
INSERT INTO sostav VALUES
  (1, 'Рядовой'),
  (2, 'Офицер');
INSERT INTO tip_kont VALUES
  (1, 'Email'),
  (2, 'Телефон'),
  (3, 'Мессенджер');
INSERT INTO tip_nas_punkt VALUES
  (1, 'Город'),
  (2, 'Село');
INSERT INTO tip_pov_kval VALUES
  (1, 'Курс'),
  (2, 'Семинар');
INSERT INTO kafedra VALUES
  (1, 'Программирование', 1),
  (2, 'Менеджмент', 2);
INSERT INTO rayon VALUES
  (1, 'Аламединский', 1),
  (2, 'Кара-Суйский', 2);
INSERT INTO zvanie VALUES
  (1, 'Рядовой', 1),
  (2, 'Лейтенант', 2);
INSERT INTO gruppa VALUES
  (1, 'Группа A', 'A', 1),
  (2, 'Группа B', 'B', 2);
INSERT INTO nas_punkt VALUES
  (1, 'Демо-город', 1, 1),
  (2, 'Демо-село', 2, 2);
INSERT INTO student VALUES
  (1, 'Студент-01', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 1, 2, NULL, NULL),
  (2, 'Студент-02', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 2, 1, NULL, NULL),
  (3, 'Студент-03', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 2, 2, NULL, NULL),
  (4, 'Студент-04', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 1, 1, NULL, NULL),
  (5, 'Студент-05', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 1, 2, NULL, NULL),
  (6, 'Студент-06', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 2, 1, NULL, NULL),
  (7, 'Студент-07', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 2, 2, NULL, NULL),
  (8, 'Студент-08', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 1, 1, NULL, NULL),
  (9, 'Студент-09', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 2, 2, 1, 2, NULL, NULL),
  (10, 'Студент-10', 'Учебный', NULL, NULL, NULL, '2025-09-01', 1, 1, 1, 2, 1, NULL, NULL),
  (11, 'Студент-11', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 2, 2, NULL, NULL),
  (12, 'Студент-12', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 1, 1, NULL, NULL),
  (13, 'Студент-13', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 1, 2, NULL, NULL),
  (14, 'Студент-14', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 2, 1, NULL, NULL),
  (15, 'Студент-15', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 2, 2, NULL, NULL),
  (16, 'Студент-16', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 1, 1, NULL, NULL),
  (17, 'Студент-17', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 1, 2, NULL, NULL),
  (18, 'Студент-18', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 2, 1, NULL, NULL),
  (19, 'Студент-19', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 2, 2, 2, 2, NULL, NULL),
  (20, 'Студент-20', 'Учебный', NULL, NULL, NULL, '2025-09-01', 2, 1, 1, 1, 1, NULL, NULL);
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
CREATE VIEW student_details AS
SELECT s.id_student,s.fam,s.imya,f.fakultet,k.kafedra,g.gruppa,p.pol,n.natsionalnost,c.grajdanstvo,
 o.oblast,r.rayon,np.nas_punkt,tn.tip_nas_punkt
FROM student s JOIN gruppa g ON g.id_gruppa=s.id_gruppa
JOIN kafedra k ON k.id_kafedra=g.id_kafedra JOIN fakultet f ON f.id_fakultet=k.id_fakultet
JOIN pol p ON p.id_pol=s.id_pol JOIN natsionalnost n ON n.id_natsionalnost=s.id_natsionalnost
JOIN grajdanstvo c ON c.id_grajdanstvo=s.id_grajdanstvo
JOIN nas_punkt np ON np.id_nas_punkt=s.id_nas_punkt JOIN rayon r ON r.id_rayon=np.id_rayon
JOIN oblast o ON o.id_oblast=r.id_oblast JOIN tip_nas_punkt tn ON tn.id_tip_nas_punkt=np.id_tip_nas_punkt;
