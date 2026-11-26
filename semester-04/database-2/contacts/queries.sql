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
SELECT last_name,kontakty FROM client_contacts WHERE field_of_industry='Бухгалтерский учет';

-- 6.3 Первомайский район
SELECT last_name,kontakty FROM client_contacts WHERE district='Первомайский';

-- 6.4 Телефоны Аламединского района
SELECT last_name,kontakty FROM client_contacts WHERE district='Аламединский' AND tip_kontaktov='Телефон';

-- 6.5 Бухгалтеры Первомайского района
SELECT last_name,kontakty FROM client_contacts WHERE district='Первомайский' AND field_of_industry='Бухгалтерский учет';

-- 6.6 Фамилии на А в Октябрьском районе
SELECT k.last_name FROM klient k JOIN district d ON d.id_district=k.id_district WHERE d.district='Октябрьский' AND k.last_name LIKE 'А%';

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
SELECT last_name,tip_kontaktov,kontakty FROM client_contacts WHERE district='Первомайский' ORDER BY id_klient,id_kontakty;

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
