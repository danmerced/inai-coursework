USE INAI_Coffee;
GO
INSERT INTO Kategoriya(nazvanie) VALUES ('Coffee'),('Tea'),('Dessert'),('Other');
INSERT INTO Klient(fio,telefon,email) VALUES ('Demo One','PHONE-1','one@example.invalid'),('Demo Two','PHONE-2','two@example.invalid'),('Demo Three','PHONE-3','three@example.invalid');
INSERT INTO Sotrudnik(fio,id_boss) VALUES ('Manager',NULL);
INSERT INTO Sotrudnik(fio,id_boss) VALUES ('Barista A',1),('Barista B',1);
INSERT INTO Tovar(nazvanie,cena,id_kategoriya) VALUES ('Espresso',150,1),('Latte',250,1),('Cappuccino',250,1),('Americano',180,1),('Green tea',130,2),('Black tea',130,2),('Cheesecake',280,3),('Brownie',220,3);
INSERT INTO Zakaz(id_klient,id_sotrudnik,data,summa) VALUES (1,2,'2024-01-03',400),(2,3,'2024-03-05',280),(1,2,'2025-01-09',380);
INSERT INTO Sostav_zakaza(id_zakaz,id_tovar,qty,price) VALUES (1,1,1,150),(1,2,1,250),(2,7,1,280),(3,3,1,250),(3,5,1,130);
