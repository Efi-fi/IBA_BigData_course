/*
For employees whose salary, increased by 5 percent, is less than or equal to $20,000 and an education level of 18 or 20, list the following:
 
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
List all departments that have no manager assigned. 
List department number, department name, and manager number.
Replace unknown manager numbers with 
the word UNKNOWN and name the column MGRNO.
*/

select deptno, deptname, coalesce(mgrno, 'UNKNOWN') as mgrno
from department
where mgrno is null;

/*
List all employees who were younger than 25 when they joined the company.
List their employee number, last name, and age when they joined the company.
Name the derived column AGE.
 Sort the result by age and then by employee number.
 */
 
 select empno, lastname, year(hiredate-birthdate)
 from employee
 where year(hiredate - birthdate) < 25;
 
 /*
For all departments with at least one designer,
display the number of designers and the department number.
Name the derived column DESIGNER.
*/

select workdept, count(*)
from employee
where job = 'DESIGNER'
group by workdept;

/*
Show the average salary for men and
 the average salary for women for each department. 
 Display the work department, the sex, 
 the average salary and the number of people in each group. 
 Include only those groups that have two or more people.
*/

select workdept, sex, avg(salary), count(*)
from employee
group by workdept, sex
having count(*) > 2;