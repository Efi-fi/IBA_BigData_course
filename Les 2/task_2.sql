/*
1 For employees whose salary, increased by 5 percent, 
is less than or equal to $20,000 and
 an education level of 18 or 20, list the following:
 
Last name
Current Salary
Salary increased by 5 percent
Monthly salary increased by 5 percent
*/


select lastname, salary as current_salary, 
salary*1.05, salary*1.05/12
from employee
where salary*1.05 <= 20000 and edlevel in (18, 20);


/*
1.2 List all departments that have no manager assigned. 
List department number, department name, and manager number.
Replace unknown manager numbers with 
the word UNKNOWN and name the column MGRNO.
*/

select deptno, deptname, coalesce(mgrno, 'UNKNOWN') as mgrno
from department
where mgrno is null;

/*
2 List all employees who were younger than 25 when they joined the company.
List their employee number, last name, and age when they joined the company.
Name the derived column AGE.
 Sort the result by age and then by employee number.
 */
 
 select empno, lastname, year(hiredate-birthdate)
 from employee
 where year(hiredate - birthdate) < 25;
 
 /*
3 For all departments with at least one designer,
display the number of designers and the department number.
Name the derived column DESIGNER.
*/

select workdept, count(*)
from employee
where job = 'DESIGNER'
group by workdept;

/*
4 Show the average salary for men and
 the average salary for women for each department. 
 Display the work department, the sex, 
 the average salary and the number of people in each group. 
 Include only those groups that have two or more people.
*/

select workdept, sex, decimal(avg(salary), 9, 2) , count(*)
from employee
group by workdept, sex
having count(*) > 2;

/*
5. Display the average bonus and average commission for all departments with
an average bonus greater than $500 and an average commission greater
than $2,000. Display all averages with two digits to the right of the decimal
point.
*/

select workdept, decimal(avg(bonus), 11, 2) avg_bonus, decimal(avg(comm), 11, 2) avg_comm
from employee
group by workdept
having avg(bonus) > 500 and avg(comm) > 2000;

/*
6. List the department number, employee number, and salaries of all
employees in department A00.
For the last line of the report, display the sum of all the salaries.
*/

select workdept, cast(empno as varchar(7)), salary
from employee
where workdept = 'A00'
union all
select 'A00', 'Salary sum = ', sum(salary)
from employee
where workdept = 'A00';


/*
7. List department number, department name, last name, and first name of all
those employees in departments that have only male employees.
*/

select d.deptno, d.deptname, e.lastname, e.firstnme
from employee e
inner join department d on e.workdept = d.deptno
where d.deptno not in
        (
        select distinct workdept
        from employee
        where sex = 'F'
        );

/*
8. We want to do a salary analysis for people that have the same job and
education level as the employee Stern. Show the last name, job, edlevel, the
number of years they've worked as of January 1, 2000, and their salary.
Name the derived column YEARS.
Sort the listing by highest salary first.
*/

select lastname, job, edlevel, year(hiredate - current_date) "YEARS", salary
from employee
where 
job in (select job from employee where lastname = 'STERN') --Logic problem if will exist 2 or more STERNS !!!
and
edlevel in  (select edlevel from employee where lastname = 'STERN');

/*
Создать таблицу с полями user_id, phone_type, phone_number. Вставить данный (необязательно как в примере) :)

Source:
user_id	|| phone_type	|| phone_number
---------------------------------------
1		|| home			|| 1111111
1		|| work			|| 2222222
2		|| home			|| 3333333
3		|| home			|| 4444444
3		|| work			|| 5555555
4		|| work			|| 6666666

Получить следующий результат (вместо колонок phone_type, phone_number появились поля home_number, work_number):
user_id	|| home_number	|| work_number
---------------------------------------
1		|| 1111111		|| 2222222
2		|| 3333333		|| NULL
3		|| 4444444		|| 5555555
4		|| NULL			|| 6666666
*/

create table User
        (
        user_id int primary key not null,
        phone_type varchar(16),
        phone_number varchar(9)
        );

drop table User;


create table User
        (
        user_id int not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
        phone_type varchar(16),
        phone_number varchar(9),
        primary key (user_id)
        );

insert into User (phone_type, phone_number)
values
        (1111111, 2222222),
        (3333333, NULL),
        (4444444, 5555555),
        (NULL, 6666666);

-- Не то вставил
delete from User;

-- Понял, что primary key не подходит для колонки user_id
drop table User;
 
create table User
        (
        user_id int,
        phone_type varchar(16),
        phone_number varchar(9)
        );

insert into User (user_id, phone_type, phone_number)
values
        (1, 'home', 1111111),
        (1, 'work', 2222222),
        (2, 'home', 3333333),
        (3, 'home', 4444444),
        (3, 'work', 5555555),
        (4, 'work', 6666666);

select u1.user_id, u1.phone_type, u1.phone_number, u2.phone_type, u2.phone_number
from user u1
left join user u2 on u1.user_id = u2.user_id and u1.phone_type != u2.phone_type;

select coalesce(u_home.user_id, u_work.user_id) user_id, u_home.phone_number, u_work.phone_number
from
        (select user_id, phone_number
        from user
        where phone_type = 'home') as u_home
full join
        (select user_id, phone_number
        from user
        where phone_type = 'work') as u_work
on u_home.user_id = u_work.user_id
order by user_id;

/*
Создать таблицу flagsб заполнить данными. Найти в какой строчке выставлен всего один флаг и вывести его название:

Source:
id || fl1 || fl2 || fl3 || fl4 || fl5 || fl6 || fl7 || fl8 || fl9
---------------------------------------
1  || true || true || true || true || true || true || true || true || true
2  || true || false || false || true || true || true || true || true || true
3  || true || false || true || false || false || true || true || true || false
4  || false || false || true || false || false || false || false || false || false
5  || false || false || false || false || false || false || false || false || false

Result:
id	|| flag
---------------------------------------
4		|| fl3
*/
