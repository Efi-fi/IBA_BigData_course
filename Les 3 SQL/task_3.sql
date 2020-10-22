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

1) Находим сумму баллов : sum(all score) = sum_score
2) Делим на количество студентов,
и находим таким образам средний балл,
к котторому должен стремится средний балл в подгруппах : avg_score = sum_score/num_sudents
3) Сортируем по среднему баллу
4) Заполняем подгруппы беря студентов с то одного конца, то с другого,
пока не наберём нужное число студентов -1, последнего студента выбираем таким образом,
чтобы средняя оценка стремилась к ideal_avg или суммарный балл стремился к S/количество подгрупп.
*/

drop table students_new;
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

select *
from students
order by score;

@
drop procedure form_groups
@

@
create procedure form_groups(inout in_num_group int, inout in_st_in_group int)
language sql
p1:
begin   
        declare num_group int; --число групп
        declare sum_score int; -- сумма всех оценок
        declare group_sum float; -- необходимая сумма оценок для одной группы
        declare avg_score float; -- необходимая средняя оценка
        declare st_in_group int; -- количество студентов в группе
        
        if in_num_group > 0 then 
                set num_group = in_num_group;
                set in_st_in_group = 0; -- если указано корректное число групп, то количество студентов рассчитается, а указанное значение не учтётся
        else
                set num_group = 
                (select count(*)
                from
                (select groupid
                from students
                group by groupid));
        end if; -- если введено некорректное необходимое число групп, то их количество найдём из исходной таблицы
       
        if in_st_in_group > 0 then
                set st_in_group = in_st_in_group;
        else
                set st_in_group =
                (select cout(*)/num_group
                from students); 
        end if; -- если введено некорректное необходимое число студентов в группе, то их количество найдём из исходной таблицы
        
        set sum_score = 
        (select sum(score)
        from students); -- сумма всех оценок
        
        set group_sum = sum_score / num_group; -- сумма оценок на группу
        
        create table students_new
        like students; -- создаём таблицу аналогичную исходной
        
        insert into students_new(id, score, groupid) 
        select id, score, 0
        from students 
        order by score; -- копируем отсортированную таблицу c 0 вместо groupid
        
        declare gr int;
        declare st_id;
        set gr = 1;
        while (gr <= num_group) do -- итерации по группам
                declare st_num int;
                set st_num = 1;
                while (st_num <= st_in_group) do -- итерации по студентам в группе
                        st_id = (gr-1)*num_group+st_num;
                        
                        
end p1
@

/*
----2----
Найти гонщиков с минимальным разрвом времени финиша
1) Сортируем по времени финиша
2) Добавляем поля номера
3) Создаём переменную, хранящую минимальную разницу, номера строк гонщиков
4) Проходим по списку и находим разницы между соседними строками
5) Если разница меньше чем в переменной перезаписываем переменные
*/
DROP TABLE racers;
CREATE TABLE
    racers
    (
        name VARCHAR(32),
        team VARCHAR(32),
        timetofirst INT
    );
    
insert into racers values
('Hamilton', 'Mersedes', 0),
('Vettel', 'Ferrari', 1),
('Raikonnen', 'Ferrari', 2),
('Bottas', 'Mersedes', 89),
('Ocon', 'Force', 90),
('Sainz', 'Renault', 91),
('Perez', 'Force', 123),
('Massa', 'Williams', 124),
('Kvyat', 'Toro Rosso', 125),
('Stroll', 'Williams', 127),
('Vandoorne', 'McLaren Honda', 131),
('Hartley', 'Toro Rosso', 138),
('Grosjean', 'Haas', 161),
('Ericsson', 'Sauber', 162);
        

/*
Задание 3
Реализовать свой row_number для таблицы employee, без использования каких либо функций 
Доступно select, from, where, group by
*/


/*
Задание 4
Сгенерировать запрос, который будет считать количество строк в каждой таблице схемы
Подсказка: посмотреть syscat.tables
*/
