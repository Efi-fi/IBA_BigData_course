/* База данных для Telegrm-бота
Таблица пользователей:

Поля взятые из Telegram bot API:
id	        Integer	Unique identifier for this user or bot
first_name	String	User's or bot's first name
last_name	String	Optional. User's or bot's last name
username	String	Optional. User's or bot's username
language_code	String	Optional. IETF language tag of the user's language

Остальные поля
...
*/

/*
----1----
Разделить студентов по подгруппам так,
чтобы средние быллы по группам были максимально одинаковые.

1) Находим сумму баллов : sum(all score) = S
2) Делим на количество студентов,
и находим таким образам средний балл,
к котторому должен стремится средний балл в подгруппах : S/ALL = ideal_avg
3) Сортируем по среднему баллу
4) Заполняем подгруппы беря студентов с то одного конца, то с другого,
пока не наберём нужное число студентов -1, последнего студента выбираем таким образом,
чтобы средняя оценка стремилась к ideal_avg или суммарный балл стремился к S/количество подгрупп.
*/

drop table students;
create table students (id int, score int, groupid int);

insert into students values
(1, 7, 1),
(2, 9, 1),
(3, 8, 1),
(4, 5, 2),
(5, 3, 2),
(6, 4, 2),
(7, 9, 3),
(8, 4, 3),
(9, 6, 3);

select groupid, avg(score)
from students
group by groupid;
