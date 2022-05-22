-- 1) GROUP BY + HAVING
-- Хотим получить фамилии людей,
-- кто выдал больше двух невозвратных кредитов.
-- В результате запроса будут выведены: фамилия, должность, количество невозвратных кредитов, сумма ущерба банка
WITH non_ret_credits AS (
    SELECT DISTINCT id_employee_responsible as id_employee,SUM(loan_balance) as sum,COUNT(*) as cnt
    FROM contracts JOIN credits c on contracts.id = c.id_contract
    WHERE status = 'разорван'
    GROUP BY id_employee_responsible HAVING COUNT(*) > 2 )
SELECT surname,post,sum,cnt FROM non_ret_credits JOIN employees ON id_employee = id;

-- 2) ORDER BY
-- Хотим получить среднюю ставку в час по каждой должности и отсортировать по возрастанию
-- В результате запроса будут выведены: должность, средняя ставка в час в этой должности
SELECT post,AVG(hour_rate) as avgs FROM employees GROUP BY post ORDER BY avgs;

-- 3) func() OVER(): PARTITION BY
-- Хотим получить для каждого человека сумму денег на всех его вкладах, которые действуют
-- В результате запроса будут выведены: id клиента,фамилия, номер вклада, баланс вклада, сумма по всем его вкладам
WITH now_dep AS (
    SELECT id_customer,balance,id_contract
    FROM contracts JOIN deposits d on contracts.id = d.id_contract
    WHERE status = 'действует'
)
SELECT id_customer,surname,id_contract,balance, SUM(balance) OVER (PARTITION BY id_customer)
FROM now_dep JOIN customers ON id_customer = id;

-- 4) func() OVER(): ORDER BY
-- Хотим выдать "ранг" каждому клиенту в зависимости от того, насколько он давно с банком
-- В результате запроса будут выведены: id клиента, фамииля, ранг
WITH ts AS (SELECT id_customer, dense_rank() OVER (order by date_of_coc) as rnk
            FROM contracts)
SELECT id_customer,surname,MIN(rnk) AS min_rnk FROM ts JOIN customers ON id_customer = id GROUP BY id_customer,surname ORDER BY min_rnk;


-- 5) func() OVER(): PARTITION BY + ORDER BY
-- Хотим отсортировать каждого клиента по дате получения всех возможных продуктов: кредита и вклада
-- В результате запроса будут выведены: id клиента, фамилия, тип продукта, дата оформления, порядковый номер
WITH srt_cntrct AS (SELECT id_customer,
                           kind,
                           date_of_coc,
                           row_number() over (partition by id_customer ORDER BY date_of_coc) as num FROM contracts
) SELECT id_customer,surname,kind,date_of_coc,num FROM srt_cntrct JOIN customers ON id_customer = id;

-- 6) func() - все 3 типа функций - агрегирующие, ранжирующие, смещения
-- Хотим отсортировать каждого клиента по дате получения кредита, вывести количество всех его кредитов, и для каждого нового определить
-- дату получения предыдущего
-- В результате запроса будут выведены: id клиента, фамилия, id договора, дата оформления текущего, дата оформления предыдщуего,
-- сумма по всем кредитам, порядковый номер

SELECT id_customer,date_of_coc,kind,row_number() over (partition by id_customer ORDER BY date_of_coc) as num, lag(date_of_coc) OVER
(partition by id_customer ORDER BY date_of_coc) as prev_date_of_coc, count(*) OVER (partition by id_customer) FROM contracts WHERE kind = 'кредит'
