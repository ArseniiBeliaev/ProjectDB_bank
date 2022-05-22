--Создание таблиц
--Абривиатуры и сокращения
--AtP - appointment to the position - назначение на должность
--TiC - take in company - взять в компанию
--CoC - conclusion of the contract - заключение договора

--Создание таблицы сотрудников
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
('Харченчо','9659054843','Mr','+79575735312');

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
('Стопарик','1996-06-28','2018-07-02',1,'барабанщица-энтузиаст','Mrs',3000,'+79575784395');

INSERT INTO contracts(kind,status,date_of_CoC,id_customer,id_employee_responsible) VALUES
('кредит','действует','2022-05-22',1,3),
('кредит','действует','2022-03-22',2,3),
('кредит','действует','2022-02-22',4,3),
('кредит','разорван','2021-01-07',5,4),
('кредит','разорван','2021-04-22',5,4),
('кредит','разорван','2022-05-12',5,4),
('кредит','разорван','2022-05-22',5,4),
('вклад','действует','2021-06-22',7,10),
('вклад','разорван','2021-05-24',2,9),
('вклад','действует','2021-05-28',4,7),
('вклад','действует','2022-05-29',9,7),
('вклад','действует','2022-05-12',10,8);

INSERT INTO black_list_customer(id_customer,reason,id_employee) VALUES
(5,'Взял 4 кредита и не вернул',2),
(2,'Клал на вклад по рублю каждую минуту и тем самым устрол ДДОС-атаку на сервак',1);

INSERT INTO credits(id_contract,amount,interest_rate,monthly_payment,overdue_monthly,loan_balance,credit_security,
                    amount_credit_security) VALUES
(3,1000,10,420,840,5000,'нет',0),
(4,2000,10,450,840,50000,'нет',0),
(5,3000,200,470,840,5220,'кошка',1000),
(6,4000,100,410,840,50130,'нет',0),
(7,5000,140,340,840,303,'пылесос',200),
(8,6000,50,452,81,523,'нет',0),
(9,7000,700,600,1000,15000,'грибы',150);

INSERT INTO deposits(id_contract,balance,interest_rate,type,date_of_end) VALUES
(11,10000,5,'до востребования',NULL),
(11,12400,5,'до востребования',NULL),
(11,100000,5,'срочный','2023-05-28'),
(11,1310000,5,'срочный','2024-05-29'),
(11,42421300,5,'срочный','2025-05-12');