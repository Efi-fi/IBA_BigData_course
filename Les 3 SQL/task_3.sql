/* База данных для Telegrm-бота
Таблица пользователей:

Поля взятые из Telegram bot API:
id	Integer	Unique identifier for this user or bot
first_name	String	User's or bot's first name
last_name	String	Optional. User's or bot's last name
username	String	Optional. User's or bot's username
language_code	String	Optional. IETF language tag of the user's language

Остальные поля:
gender       | character varying(6)           |           |          |
floor        | smallint                       |           |          |
room         | character varying(5)           |           |          |
course       | smallint                       |           |          |
faculty      | character varying(6)           |           |          |
birth_date   | smallint                       |           |          |
created      | timestamp(0) without time zone |           |          |
updated      | timestamp(0) without time zone |           |          |
count_mess   | integer                        |           |          | 1
role         | character varying(6)           |           |          | 'user3'::character varying
crimes       | integer                        |           |          | 0
sub          | boolean                        |           |          | true
*/
create table Users(
        id int primary key unique not null,
        first_name varchar(32),
        last_name varchar(32),
        username varchar(32),
        language_code varchar(8),
        gender varchar(8), --M, Male, F, Female
        floor smallint,
        room varchar(8),
        course smallint,
        faculty varchar(8),
        birth_date date,
        created timestamp,
        updated timestamp,
        count_mess int,
        role varchar(8),
        crimes int,
        sub smallint); -- 0-no sub, 1- sub

alter table Users
rename column telegram_id to id; -- not working, because it's primary key

drop table Users;
/*


Таблица сообщений:
id	                Integer	Unique message identifier inside this chat
from	                User	Optional. Sender, empty for messages sent to channels
datetime                Integer	Date the message was sent in Unix time
text	                String	Optional. For text messages, the actual UTF-8 text of the message, 0-4096 characters
*/
create table Messages(
        id int primary key unique not null,
        user_id int,
        created timestamp,
        text varchar(1024),
        foreign key (from_id)
        references Users(id)
        on update no action
        on delete no action);

/*
Объявления: 
Ads
*/
create table Ads(
        id int primary key unique not null,
        theme varchar(32),
        title varchar(32),
        text varchar(256),
        user_id int,
        created timestamp,
        foreign key (user_id)
        references Users(id)
        on update no action
        on delete cascade);
        
        

/*
Mailings
*/
create table Mails(
        id int primary key unique not null,
         

        
        

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
5) Если разница меньше чем в переменной перезаписываем переменные, так как много одинаковых разниц, то буду записывать их в таблицу diff 
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





        
@
create procedure min_dif_1()
language sql
p2:
begin
        create global temporary table racers_new
        (
        name VARCHAR(32),
        team VARCHAR(32),
        timetofirst INT,
        num int
        );
        
        insert into racers_new(num, name, team, timetofirst) 
        select row_number() over( order by timetofirst) num, name, team, timetofirst
        from racers
        order by timetofirst;
        
        create global temporary table diff
        (
        racer_1 int,
        racer_2 int,
        diff int
        );
        
        insert into diff(racer_1, racer_2, diff)
        select num, num+1, lead(timetofirst) over(order by timetofirst) - timetofirst as min_diff
        from racers_new;
        
        declare mindiff int;
        set mindiff =
        (select min(diff)
        from diff);
        
        select r1.name Racer1, r1.team Team1, r2.name Racer2, r2.team Team2, r1.timetofirst Time1, r2.timetofirst Time2, d.diff
        from diff d
        left join racers_new r1 on d.racer_1 = r1.num
        left join racers_new r2 on d.racer_2 = r2.num
        where d.diff = mindiff;
        
end p2
@

drop table racers_new;
drop procedure min_dif;


/*
Найти 5 гонщиков с минимальным разрвом времени финиша
*/
select *
from 
(select *, row_number() over(order by timetofirst) n_row
from racers)
where n_row 

select n_row
from
(select *, row_number() over(order by timetofirst) n_row, lead(timetofirst, 5) over(order by timetofirst) diff5
from racers)
where diff5 in
        (select min(diff5)
        from
        (select lead(timetofirst, 5) over(order by timetofirst) diff5
        from racers)
        );


@
create or replace procedure min_diff_n(in n int)
DYNAMIC RESULT SETS 1
language sql
reads sql data
begin
        declare min_diff int;
        declare n_row int;
        
        set min_diff = 
        (select min(diff_n)
        from
        (select lead(timetofirst, 5) over(order by timetofirst) diff_n
        from racers)
        );
        
        set n_row =
        (select n_row
        from
        (select *, row_number() over(order by timetofirst) n_row, lead(timetofirst, 5) over(order by timetofirst) diff_n
        from racers)
        where diff_n = min_diff
        );
        
        DECLARE c1 CURSOR WITH HOLD WITH RETURN FOR
                (select *
                from
                (select name, team, timetofirst, row_number() over(order by timetofirst) row_n
                from racers)
                where row_n between n_row and n_row+4);
        open c1;
end p2
@


@
drop procedure min_diff_n
@

/*
Задание 3
Реализовать свой row_number для таблицы employee, без использования каких либо функций 
Доступно select, from, where, group by

*/

select *, case 
when empno < 200000 then empno/10
else
from
(select *
from employee)


/*
Задание 4
Сгенерировать запрос, который будет считать количество строк в каждой таблице схемы
Подсказка: посмотреть syscat.tables
*/

select *
from syscat.tables;

select tabschema, tabname, avgrowsize, card -- (select count(*) from tabschema.tabname) as num_row
from syscat.tables
where tabschema = 'VKM83249';