CREATE TABLE Department
( DeptNo varchar(2) primary key,
DeptName varchar(50),
location loc 
)

sp_addType loc, 'nchar(2)'

CREATE RULE loc1 AS @x IN ('NY','DS','KW')

CREATE DEFAULT def AS 'NY'

sp_bindrule loc1 , loc

sp_bindefault def, loc

---------------------------------
INSERT INTO Department VALUES('d1','Research','NY'),
					('d2','Accounting','DS'),
					('d3','Marketing','KW')
---------------------------------

CREATE TABLE Employee
(
EmpNo int,
Emp_Fname varchar(50),
Emp_Lname varchar(50),
DeptNo varchar(2),
Salary int,

CONSTRAINT c1  PRIMARY KEY(EmpNo),
CONSTRAINT c2 FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo),
CONSTRAINT c3 UNIQUE (Salary),
CONSTRAINT c4 CHECK (Emp_Fname IS NOT NULL AND Emp_Lname IS NOT NULL)

)

CREATE RULE R_SALARY AS @salary < 6000

sp_bindrule R_SALARY,'Employee.Salary'


----------------------QUESTION NO 1
INSERT INTO Works_on VALUES(11111,'p1','Analyst','2006.10.1')

-----------------------------QUESTION NO 2

UPDATE Works_on
SET EmpNo = 11111
WHERE EmpNo =10102
--Cannot insert duplicate keys ERROR 

-------------------------------	QUESTION NO 3
UPDATE Works_on
SET EmpNo = 222222
WHERE EmpNo = 10102

--TWo ROWS AFFECTED 

----------------- QUESTION NO 4

DELETE FROM Works_on
WHERE Works_on.EmpNo = 10102

----------- 0 rows affected 


ALTER TABLE SD.dbo.Employee
ADD TelephoneNumber INT;

----------------------
ALTER TABLE SD.dbo.Employee 
DROP TelephoneNumber

-------------------------------CREATING Company Schema 

CREATE SCHEMA Company

CREATE SCHEMA HumanResource

ALTER SCHEMA Company TRANSFER Department
ALTER SCHEMA HumanResource TRANSFER Employee
-------------------------
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Employee'

-----------------------------------------

CREATE synonym Emp
FOR HumanResource.Employee

-----------------------------
Select * from Employee 
/*
Doesn't work as I didn't mention the name of the schema so the engine assumed  that the schema of the employee table was dbo by default
*/
-----------------------------
Select * from Emp
/*
It works because I gave the humanresource.employee a synonym called Emp
*/
----------------------------

Select * from HumanResource.Employee
/*
It works
*/

---------------------------------
Select * from HumanResource.Emp
/*
It doesn't work because the EMP is a synonym and it contains the humanresource schema inside it 
*/
--------------------------------------------

UPDATE Company.Project 
SET Budget += Budget*0.1
FROM Company.Project JOIN  dbo.Works_on
ON Company.Project.ProjectNo = dbo.Works_on.ProjectNo
WHERE dbo.Works_on.EmpNo = 10102 and job=''


---------------------------------------------------
/*
6.	Change the name of the department for which the employee named James works. 
The new department name is Sales.
*/
UPDATE Company.Department
SET DeptName = 'Sales'
FROM  Company.Department JOIN Emp
ON  Company.Department.DeptNo = Emp.DeptNo
WHERE Emp.Emp_Fname = 'James'

----------------------------------------------------------
/*
7.	Change the enter date for 
the projects for those employees who work in project p1 and belong to department ‘Sales’.
The new date is 12.12.2007.
*/
update  dbo.Works_on
set Enter_date ='2007/12/12'
from Company.project p , dbo.Works_on w ,Company.Department d , HumanResource.Employee e
where p.ProjectNo = W.ProjectNo 
and W.EmpNo = E.EmpNo
and d.DeptNo = E.DeptNo 
and d.DeptName= 'sales' and p.ProjectName = 'p1'


-----------------------------------------------------------------------------------
delete  from works_on 
where EmpNo in (select EmpNo from Company.Department d join HumanResource.Employee e on d.DeptNo =e.DeptNo 
where location = 'KW')

-------------------------------------
CREATE INDEX indx
ON ITI.dbo.Department(Manager_hiredate)

------------------------------------------
create clustered index i1
on ITI.dbo.Department(Manager_hiredate)
-------------------------------------------------
create unique index i2
on ITI.dbo.student(st_age)