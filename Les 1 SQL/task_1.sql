-- 1. List last name, salary, and bonus of all male employees.

select lastname, salary, bonus
from employee
where sex = 'M';

/*
2. List last name, salary, and commission for all employees with a salary greater than $20,000 and hired after 1979.
*/
 
select lastname, salary, comm, hiredate
from employee
where salary > 20000 and hiredate >= '1980-01-01';

/*
3. List last name, salary, bonus, and commission for all employees with a salary greater
than $22,000, a bonus of $400 or $500, and a commission less than $1,900. The list
should be ordered by last name.
*/

select lastname, salary, bonus, comm
from employee
where salary > 22000 and bonus in (400, 500) and comm < 1900
order by lastname;

/*
4. Using the EMP_ACT table, for all projects that have a project number beginning with
AD and have activities 10, 80, and 180 associated with them, list the following:
● Project number
● Activity number
● Starting date for activity
● Ending date for activity
Order the list by activity number within project number.
*/

select projno, actno, emstdate, emendate
from emp_act
where projno like 'AD%' and actno in (10, 80, 180)
order by actno;

/*
5. Produce a report that lists employees' last names, first names, and department
names. Sequence the report on first name within last name, within department
name.
*/

select employee.lastname, employee.firstnme, dept.deptname
from employee
left join dept on employee.workdept = dept.deptno
order by employee.firstnme;

/*
6. Modify the previous query to include job. Also, list data for only departments between
A02 and D22, and exclude managers from the list. Sequence the report on first name
within last name, within job, within department name.
*/

select employee.lastname, employee.firstnme, dept.deptname, employee.job
from employee
left join dept on employee.workdept = dept.deptno
where employee.workdept between 'A02' and 'D22' and employee.job <> 'MNAGER'
order by employee.firstnme;

/*
7. For all projects that have a project number beginning with AD, list project number,
project name, and activity number. List identical rows once. Order the list by project
number and then by activity number.
*/

select distinct project.projno, project.projname, emp_act.actno
from project
right join emp_act using(projno)
where projno like 'AD%'
order by projno, emp_act.actno;

/*
8. Which employees in department A00 were hired before their manager?
List department number, the manager's last name, the employee's last name, and
the hiring dates of both the manager and the employee.
Order the list by the employee's last name.
*/

select manager.deptno, 
       manager.lastname manager, employee.lastname employee,
       manager.hiredate m_haridate, employee.hiredate e_hiredate
from employee
left join 
        (
        select *
        from department
        left join employee on department.mgrno = employee.empno
        ) as manager -- Managers table
on manager.deptno = employee.workdept
where manager.deptno = 'A00' AND employee.hiredate > manager.hiredate;
