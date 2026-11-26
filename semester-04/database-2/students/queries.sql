-- Список группы A
SELECT * FROM student_details WHERE gruppa='Группа A' ORDER BY id_student;

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
