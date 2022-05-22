--Создание таблиц
--Абривиатуры и сокращения
--AtP - appointment to the position - назначение на должность
--TiC - take in company - взять в компанию
--CoC - conclusion of the contract - заключение договора

--Создание таблицы сотрудников

DROP TABLE employees;
DROP TABLE customers;
DROP TABLE black_list_customer;
DROP TABLE contracts;
DROP TABLE credits;
DROP TABLE deposits;

CREATE TABLE IF NOT EXISTS employees(
    id SERIAL PRIMARY KEY,
    surname VARCHAR(255) NOT NULL,
    date_of_AtP DATE NOT NULL,
    date_of_TiC DATE NOT NULL,
    department_id INTEGER NOT NULL ,
    post VARCHAR(255) NOT NULL,
    appeal VARCHAR(255) CHECK(appeal IN ('Mr','Mrs')),
    hour_rate INTEGER NOT NULL CHECK (hour_rate >= 0),
    phone_number VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers(
    id SERIAL PRIMARY KEY,
    surname VARCHAR(255) NOT NULL,
    passport VARCHAR(255) NOT NULL,
    appeal VARCHAR(255) CHECK(appeal IN ('Mr','Mrs')),
    phone_number VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS contracts(
    id SERIAL PRIMARY KEY,
    kind VARCHAR(255) CHECK (kind IN('кредит','вклад')),
    status VARCHAR(255) CHECK (status IN ('действует','разорван','выполнен')),
    date_of_CoC DATE NOT NULL,
    id_customer SERIAL NOT NULL,
    id_employee_responsible SERIAL NOT NULL,
    FOREIGN KEY (id_customer) REFERENCES customers(id),
    FOREIGN KEY (id_employee_responsible) REFERENCES employees(id)
);

CREATE TABLE IF NOT EXISTS credits(
    id_contract SERIAL NOT NULL,
    amount INTEGER NOT NULL,
    interest_rate INTEGER NOT NULL,
    monthly_payment INTEGER NOT NULL,
    overdue_monthly INTEGER NOT NULL,
    loan_balance INTEGER NOT NULL,
    credit_security VARCHAR(255),
    amount_credit_security INTEGER,
    FOREIGN KEY (id_contract) REFERENCES contracts(id)
);



CREATE TABLE IF NOT EXISTS deposits(
    id_contract SERIAL NOT NULL,
    balance INTEGER NOT NULL,
    interest_rate INTEGER NOT NULL,
    type VARCHAR(255) CHECK (type IN ('срочный','до востребования')),
    date_of_end DATE,
    FOREIGN KEY (id_contract) REFERENCES contracts(id)
);

CREATE TABLE black_list_customer(
    id_customer SERIAL NOT NULL,
    reason VARCHAR(255) NOT NULL,
    id_employee SERIAL NOT NULL,
    FOREIGN KEY (id_customer) REFERENCES customers(id),
    FOREIGN KEY (id_employee) REFERENCES employees(id)
);


INSERT INTO customers(surname, passport, appeal, phone_number) VALUES
('Зелебобс','5716516634','Mrs','+79194907312'),
('Шапановский','5716513457','Mr','+79194907312'),
('Мошалов','5716516969','Mr','+79194903232'),
('Мусскалева','1256137899','Mrs','+79323232322'),
('Погонялский','1234567891','Mr','+79132323532'),
('Шамановатова','9876543211','Mrs','+79112332322'),
('Симойлова','2323232313','Mrs','+79756655512'),
('Вербочков','3282939239','Mr','+79145456412'),
('Бызова','0293828328','Mrs','+79687565612'),
('Солостовсая','3923293999','Mrs','+79575757512'),
('Харченчо','9659054843','Mr','+79575735312'),
('Крымская','5716516545','Mrs','+79774907312'),
('Мартынов','5716513234','Mr','+79684907312'),
('Павлова','5716516754','Mrs','+79124903232'),
('Гаврилов','1256137631','Mr','+79533232322'),
('Воробьев','1234567895','Mr','+79232323532'),
('Серова','9876543976','Mrs','+79322332322'),
('Давыдов','2323232256','Mr','+79746655512'),
('Степанова','3282939874','Mrs','+79985456412'),
('Головин','0293828894','Mr','+7968347565612'),
('Сергеев','3923293075','Mr','+79575743257512'),
('Мальцев','9659054268','Mr','+7957573534212');


INSERT INTO employees(surname, date_of_AtP, date_of_TiC, department_id, post, appeal, hour_rate, phone_number) VALUES
('Романчивко','1992-10-10','2015-06-02',2,'помощник главного помощника','Mrs',5000,'+79575784395'),
('Супачева','1998-11-10','2011-07-02',3,'старший помощник младшего помощника','Mrs',1000,'+79575784395'),
('Газкова','1993-01-10','2014-08-02',2,'директор кредитного отдела','Mrs',15000,'+79575784395'),
('Криворучкова','1982-07-15','2010-09-02',1,'главная уборщица','Mrs',50000,'+79575784395'),
('Кривоногова','2005-12-17','2019-09-02',1,'мойщик посуды','Mrs',50000,'+79575784395'),
('Пирогова','2019-10-12','2020-09-02',1,'электрик','Mrs',7000,'+79575784395'),
('Тортовна','2017-12-12','2022-10-02',6,'исполнительный директор','Mrs',100,'+79575784395'),
('Пивчанская','2006-11-19','2009-11-02',7,'операционист','Mrs',500,'+79575784395'),
('Закусочная','1997-08-12','2010-12-02',2,'брадобрей','Mrs',200,'+79575784395'),
('Стопарик','1996-06-28','2018-07-02',1,'барабанщица-энтузиаст','Mrs',3000,'+79575784395'),
('Ромашкова','1993-10-10','2013-06-02',2,'инженер-танцовщик','Mrs',500,'+79575784395'),
('Смычёва','1923-11-10','2013-07-02',3,'важный министр','Mrs',100,'+79575784395'),
('Подглазкова','1974-01-10','2016-08-02',2,'директор кредитного отдела','Mrs',1500,'+79575784395'),
('Кривопальцева','1917-07-15','2015-09-02',1,'главная уборщица','Mrs',5000,'+79575784395'),
('Криворогова','1956-12-17','2017-09-02',1,'мойщик посуды','Mrs',5000,'+79575784395'),
('Панарин','2000-10-12','2021-09-02',1,'мойщик посуды','Mr',700,'+79575784395'),
('Скотч','2011-12-12','2021-10-02',6,'мойщик посуды','Mr',100,'+79575784395'),
('Глина','2005-11-19','2010-11-02',7,'мойщик посуды','Mr',50,'+79575784395'),
('Месит','1932-08-12','2008-12-02',2,'мойщик посуды','Mr',20,'+79575784395'),
('Поводочка','1952-06-28','2009-07-02',1,'мойщик посуды','Mrs',300,'+79575784395');

INSERT INTO contracts(kind,status,date_of_CoC,id_customer,id_employee_responsible) VALUES
('кредит','действует','2022-05-22',1,3),
('кредит','действует','2022-03-22',2,3),
('кредит','действует','2022-02-22',3,3),
('кредит','действует','2022-05-22',10,3),
('кредит','действует','2022-03-22',11,3),
('кредит','действует','2022-02-22',12,3),
('кредит','разорван','2021-01-07',5,4),
('кредит','разорван','2021-04-22',6,4),
('кредит','разорван','2022-05-12',7,4),
('кредит','разорван','2022-05-22',8,4),
('кредит','разорван','2021-01-07',13,4),
('кредит','разорван','2021-04-22',14,4),
('кредит','разорван','2022-05-12',15,4),
('кредит','разорван','2022-05-22',16,4),
('кредит','разорван','2021-01-07',17,4),
('кредит','разорван','2021-04-22',18,4),
('кредит','разорван','2022-05-12',19,4),
('кредит','разорван','2022-05-22',20,4),
('вклад','действует','2021-06-22',7,10),
('вклад','разорван','2021-05-24',2,9),
('вклад','действует','2021-05-28',4,7),
('вклад','действует','2022-05-29',9,7),
('вклад','действует','2022-05-12',10,8),
('вклад','действует','2021-06-22',7,10),
('вклад','разорван','2021-05-24',2,9),
('вклад','действует','2021-05-28',4,7),
('вклад','действует','2022-05-29',9,7),
('вклад','действует','2022-05-12',10,8);

UPDATE contracts SET id_employee_responsible = 5 WHERE status = 'разорван' AND id_customer = 8;
UPDATE contracts SET id_employee_responsible = 5 WHERE status = 'разорван' AND id_customer = 13;
UPDATE contracts SET id_employee_responsible = 6 WHERE status = 'разорван' AND id_customer = 14;
UPDATE contracts SET id_employee_responsible = 6 WHERE status = 'разорван' AND id_customer = 15;
UPDATE contracts SET id_employee_responsible = 6 WHERE status = 'разорван' AND id_customer = 16;
UPDATE contracts SET date_of_coc = '2020-01-01' WHERE id = 22;
UPDATE contracts SET date_of_coc = '2018-02-02' WHERE id = 23;
UPDATE contracts SET date_of_coc = '2017-11-11' WHERE id = 24;
UPDATE contracts SET date_of_coc = '2022-12-05' WHERE id = 25;
UPDATE contracts SET date_of_coc = '2021-07-09' WHERE id = 26;


INSERT INTO black_list_customer(id_customer,reason,id_employee) VALUES
(5,'невозврат',2),
(2,'нарушение пользования',1),
(5,'невозврат',2),
(6,'невозврат',2),
(6,'невозврат',2),
(7,'невозврат',2),
(8,'невозврат',2),
(13,'невозврат',2),
(14,'невозврат',2),
(15,'невозврат',2),
(16,'невозврат',2),
(17,'невозврат',2),
(18,'невозврат',2),
(19,'невозврат',2),
(20,'невозврат',2);

INSERT INTO credits(id_contract,amount,interest_rate,monthly_payment,overdue_monthly,loan_balance,credit_security,
                    amount_credit_security) VALUES
(1,1000,10,420,840,5000,'нет',0),
(2,2000,10,450,840,50000,'нет',0),
(3,3000,200,470,840,5220,'кошка',1000),
(4,4000,100,410,840,50130,'нет',0),
(5,5000,140,340,840,303,'пылесос',200),
(6,6000,50,452,81,523,'нет',0),
(7,70000,700,600,1000,15000,'грибы',150),
(8,10000,10,420,840,5000,'нет',0),
(9,20000,10,450,840,50000,'нет',0),
(10,30000,200,470,840,5220,'кошка',1000),
(11,400000,100,410,840,50130,'нет',0),
(12,500000,140,340,840,303,'пылесос',200),
(13,600000,50,452,81,523,'нет',0),
(14,700000,700,600,1000,15000,'грибы',150),(3,1000,10,420,840,5000,'нет',0),
(15,200000,10,450,840,50000,'нет',0),
(16,300000,200,470,840,5220,'кошка',1000),
(17,400000,100,410,840,50130,'нет',0),
(18,500000,140,340,840,303,'пылесос',200);


INSERT INTO deposits(id_contract,balance,interest_rate,type,date_of_end) VALUES
(19,10000,5,'до востребования',NULL),
(20,12400,5,'до востребования',NULL),
(21,100000,5,'срочный','2023-05-28'),
(22,1310000,5,'срочный','2024-05-29'),
(23,42421300,5,'срочный','2025-05-12'),
(24,100560,5,'до востребования',NULL),
(25,12400,5,'до востребования',NULL),
(26,1000000,5,'срочный','2023-05-28'),
(27,13108000,5,'срочный','2024-05-29'),
(28,42428600,5,'срочный','2025-05-12');

INSERT INTO contracts(kind,status,date_of_CoC,id_customer,id_employee_responsible) VALUES
('кредит','действует','2022-01-07',5,4),
('кредит','действует','2021-03-12',5,2),
('кредит','действует','2022-05-28',5,10),
('кредит','действует','2019-12-22',7,11),
('кредит','действует','2019-02-09',7,12),
('кредит','действует','2021-01-11',8,13);

INSERT INTO credits(id_contract,amount,interest_rate,monthly_payment,overdue_monthly,loan_balance,credit_security,
                    amount_credit_security) VALUES
(29,1000,10,420,840,5000,'нет',0),
(30,2000,10,450,840,50000,'нет',0),
(31,3000,200,470,840,5220,'кошка',1000),
(32,4000,100,410,840,50130,'нет',0),
(33,5000,140,340,840,303,'пылесос',200);
