--Воспользуемся инлексами для быстрого поиска по фамилии, т.к. они расположены не в алфавитном порядке
create index on employees(upper(surname));
create index on customers(upper(surname));