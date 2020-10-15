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
