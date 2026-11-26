# База контактов студентов — урок 8

Две группы по 10 человек и три контакта на каждого. Персональные поля оставлены пустыми; все записи демонстрационные.

| Уровень | Таблицы |
|---|---|
| 1 | fakultet, grajdanstvo, natsionalnost, oblast, pol, sostav, tip_kont, tip_nas_punkt, tip_pov_kval |
| 2 | kafedra, rayon, zvanie |
| 3 | gruppa, nas_punkt |
| 4 | student |
| 5 | kontakty, pov_kval, voinsk_slujba |

В `sql-server.sql` — создание структуры, заполнение, общий список группы, агрегирование по факультету, кафедре, группе и демографическим признакам и сочетаниям. [Результаты переносимых запросов](results.md). SQL Server требует запуска отдельно.
