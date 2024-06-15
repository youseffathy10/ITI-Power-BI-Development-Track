use lab2_part2


--problem 1
select * 
from Employee

--problem 2
select fname,lname, salary, dno
from Employee

--problem 3
select pname
from Project

--problem 4 
select fname+' '+lname as fullname , (0.1*salary)*12 as [annual comm]
from employee


--problem 5
select ssn, fname 
from employee
where salary > 1000

--problem 6
select ssn, fname 
from employee 
where salary*12 > 10000

--problem 7
select fname , salary
from employee 
where sex='F'

--problem 8
SELECT DNUM, DNAME
FROM Departments
WHERE MGRSSN =968574

--PROBLEM 9
SELECT PNUMBER, PNAME, Plocation 
FROM Project
WHERE DNUM =10
