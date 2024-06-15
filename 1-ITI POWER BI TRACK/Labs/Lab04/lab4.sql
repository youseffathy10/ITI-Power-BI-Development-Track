

--probelm 1
SELECT dep.Dependent_name,dep.sex
FROM Employee e
JOIN Dependent  dep
ON e.SSN = dep.ESSN
WHERE e.sex = 'F' AND dep.Sex = 'F'

UNION 

SELECT dep.Dependent_name,dep.sex
FROM Employee e
JOIN Dependent  dep
ON e.SSN = dep.ESSN
WHERE e.sex = 'M' AND dep.Sex = 'M'


--problem 2 
SELECT p.Pname,SUM(w.Hours)AS [total hours]
FROM Project p
JOIN Works_for w 
ON p.Pnumber = w.Pno
GROUP BY p.pname


--problem 3 

SELECT dep.*
FROM Departments dep
JOIN Employee E
ON E.dno = dep.Dnum AND E.SSN = ( SELECT MIN(ssn) FROM Employee)



--problem 4
SELECT d.Dname,MIN(e.salary) AS Min_salary , MAX(e.salary) AS Max_salary
FROM Departments d
JOIN Employee e
ON d.Dnum = e.Dno
GROUP BY d.Dname


--problem 5
SELECT CONCAT(e.Fname,' ', e.Lname),depen.Dependent_name
FROM Departments d
JOIN Employee e
ON d.MGRSSN = e.SSN
LEFT JOIN Dependent depen
ON e.SSN = depen.ESSN
WHERE depen.Dependent_name is null



--problem 6
SELECT d.Dnum, d.Dname ,COUNT(e.ssn) AS num_of_emp
FROM Departments d
JOIN Employee e
ON e.Dno = d.Dnum
GROUP BY Dnum,Dname
HAVING AVG(e.salary)< all(SELECT AVG(salary) FROM Employee)
	

--problem 7
/*
7.	Retrieve a list of employees names and the projects names they are working on 
ordered by department number and within each department, ordered alphabetically by last name, first name.
*/
SELECT e.Fname,p.Pname
FROM  Employee e
JOIN Works_for w
ON e.SSN = W.ESSn
JOIN Project p 
ON w.Pno = p.Pnumber
ORDER BY e.Dno , e.Lname , e.Fname


--8 Try to get the max 2 salaries using subquery
 
SELECT Max(salary) AS max_sal
FROM Employee
WHERE Salary < (SELECT MAX(salary) FROM Employee)

UNION
SELECT MAX(Salary)
FROM Employee
ORDER BY max_sal desc

--9.Get the full name of employees that is similar to any dependent name

SELECT CONCAT(e.fname,' ',e.Lname)AS fullName
FROM Employee e
JOIN Dependent d
ON e.SSN = d.ESSN
WHERE CONCAT(e.fname,' ',e.Lname) = d.Dependent_name

--10.Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.
SELECT  e.Fname,e.Lname,e.SSN
FROM Employee e
JOIN Dependent d
ON e.SSN = d.ESSN
WHERE EXISTS (SELECT dep.ESSN FROM Dependent dep)

/* 11 In the department table insert new department called "DEPT IT" ,
with id 100, employee with SSN = 112233 as a manager for this department. 
The start date for this manager is '1-11-2006'
*/

INSERT INTO Departments VALUES('DEPT-IT',100,112233,'1-11-2006')


/*
12.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department 
(id = 100), 
and they give you(your SSN =102672) her position (Dept. 20 manager) 

a.	First try to update her record in the department table
b.	Update your record to be department 20 manager.
c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

*/
UPDATE Departments
SET MGRSSN =968574
WHERE Dnum = 100

UPDATE Departments
SET MGRSSN =102672
WHERE Dnum = 20

UPDATE Employee
SET Superssn=102672
WHERE SSN = 102660


--13 
delete Dependent where ESSN=223344
delete Works_for where ESSN=223344
update Departments set MGRSSN=102672 where MGRSSN=223344;
update Employee set Superssn = 102672  where Superssn=223344;
delete Employee where SSN=223344

--14 Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%

update Employee 
set Salary += (0.3*Salary)
from Employee,Works_for,Project
where ssn=ESSn and Pnumber=pno and Pname='Al Rabwah'


