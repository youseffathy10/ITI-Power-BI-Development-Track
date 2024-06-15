/*
1.	Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 and increases it by 20% if Salary >=3000. Use company DB
*/

USE Company_SD

DECLARE EMP_SALARY CURSOR 
FOR SELECT  Employee.Salary FROM Employee
FOR UPDATE 

DECLARE @sal INT
OPEN EMP_SALARY 
FETCH EMP_SALARY  INTO @sal 

WHILE @@FETCH_STATUS=0
BEGIN
	IF @sal >=3000
		UPDATE Employee
		SET Salary=@sal*1.2
		WHERE CURRENT OF  EMP_SALARY 
	ELSE IF @sal < 3000
		UPDATE Employee
		SET Salary=@sal*1.1
		WHERE CURRENT OF EMP_SALARY
	FETCH EMP_SALARY INTO @sal
END
close EMP_SALARY
deallocate EMP_SALARY


/*
2.	Display Department name with its manager name using cursor. Use ITI DB
*/
USE ITI

DECLARE DeptManager CURSOR 
FOR SELECT D.Dept_Name, I.Ins_Name FROM  Department D JOIN Instructor I  ON D.Dept_Manager = I.Ins_Id
FOR READ ONLY

DECLARE @depName VARCHAR(50), @InsName VARCHAR(50)
OPEN DeptManager 
FETCH  DeptManager INTO @depName, @InsName
WHILE @@FETCH_STATUS=0
BEGIN
SELECT  @depName AS dept_name, @InsName AS Manager_name
FETCH DeptManager INTO  @depName, @InsName
END
CLOSE DeptManager
Deallocate DeptManager



/*
3.	Try to display all students first name in one cell separated by comma. Using Cursor 
*/

DECLARE display CURSOR
FOR SELECT DISTINCT Student.St_Fname FROM  Student
FOR READ ONLY
DECLARE @name VARCHAR(50), @one_cell VARCHAR(100)
OPEN display
FETCH display INTO @name
WHILE @@FETCH_STATUS=0
BEGIN
SET @one_cell = CONCAT(@one_cell, ',',@name)
FETCH display INTO @name
END
SELECT @one_cell
CLOSE display
DEALLOCATE display


/*
4.	Create full, differential Backup for SD DB.
*/

backup database SD
to disk='D:\SD.bak'

backup database SD
to disk='D:\SD.bak'
with differential


/*
5.	Use import export wizard to display student’s data (ITI DB) in excel sheet
*/


/*
6.	Try to generate script from DB ITI that describes all tables and views in this DB
*/



/*
7.	Create a sequence object that allow values from 1 to 10 without cycling in a specific column and test it. (self study)
*/



CREATE TABLE Test (
    ID INT PRIMARY KEY,
    Name VARCHAR(100)
);


CREATE SEQUENCE seq
AS INT 
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 10
NO CYCLE

INSERT INTO Test (ID, Name)
VALUES 
    (NEXT VALUE FOR seq, '1st row'),
    (NEXT VALUE FOR seq, '2nd row'),
    (NEXT VALUE FOR seq, '3rd row');

/*
8.	Display all the data from the Employee table (HumanResources Schema) 
As an XML document “Use XML Raw”. “Use Adventure works DB” 
A)	Elements
B)	Attributes

*/
USE AdventureWorks2012
SELECT * 
FROM HumanResources.Employee
FOR XML RAW('Employee'), ELEMENTS,ROOT

/*
9.	Display Each Department Name with its instructors. “Use ITI DB”
A)	Use XML Auto
B)	Use XML Path

*/

USE ITI

SELECT d.Dept_Name, i.Ins_Name
FROM Department D
JOIN Instructor i
ON i.Dept_Id = d.Dept_Id
FOR XML AUTO


/*

10.	Use the following variable to create a new table “customers” inside the company DB.
 Use OpenXML

*/


 use Company_SD
create table customer (
    FirstName varchar(100),
    Zipcode varchar(10),
    OrderID varchar(100),
    OrderDescription varchar(100)
)

declare @docs xml ='<customers>
              <customer FirstName="Bob" Zipcode="91126">
                     <order ID="12221">Laptop</order>
              </customer>
              <customer FirstName="Judy" Zipcode="23235">
                     <order ID="12221">Workstation</order>
              </customer>
              <customer FirstName="Howard" Zipcode="20009">
                     <order ID="3331122">Laptop</order>
              </customer>
              <customer FirstName="Mary" Zipcode="12345">
                     <order ID="555555">Server</order>
              </customer>
       </customers>'
insert into customer
SELECT
    Cust.value('@FirstName', 'VARCHAR(100)') AS FirstName,
    Cust.value('@Zipcode', 'VARCHAR(10)') AS Zipcode,
    Cust.value('(order/@ID)[1]', 'VARCHAR(100)') AS OrderID,
    Cust.value('(order/text())[1]', 'VARCHAR(100)') AS OrderDescription
FROM
    @docs.nodes('/customers/customer') AS T(Cust)





/*
11.	Create snapshot on SD DB
*/

CREATE DATABASE SNPSHOT
ON (NAME = COMPANY_SD, FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\COMPANY_SD')
AS SNAPSHOT OF COMPANY_SD


/*
12.	Transform all functions in lab6 to stored procedures
*/

ALTER PROC Get_Month(@date date)
	AS 
	BEGIN
		DECLARE @month VARCHAR(20) = FORMAT(@date, 'MMMM')
		SELECT @month
	END

Get_Month '1-1-2024'




CREATE PROC get_ranges (@x1 int,@x2 int)
AS
BEGIN
DECLARE @t table 
	(
	range_of_val int
	) 
	DECLARE @iter int = @x1+1
		WHILE @iter <@x2
			BEGIN
			INSERT INTO @t(range_of_val)
			Values(@iter)
				SET @iter+=1
		
		END
	SELECT * FROM @t
	END

get_ranges  1,10



CREATE PROC get_dep_wit_stud_Fullnames(@stNo int)
AS
BEGIN 
SELECT CONCAT(stud.St_Fname,' ',stud.St_Lname) as fullname,dep.Dept_Name
			FROM Student as stud 
			JOIN Department dep
			ON stud.Dept_Id = dep.Dept_Id
			WHERE stud.St_Id = @stNo
END

get_dep_wit_stud_Fullnames 1


CREATE PROC displayStudentNameS(@stNo int)
AS BEGIN
	DECLARE @firstName VARCHAR(50),
	 @SecondName VARCHAR(50),
	 @message VARCHAR(50)

	SELECT @firstName=St_Fname,@SecondName=St_Lname
	FROM Student 
	WHERE St_id = @stNo
	IF @firstName is null AND @SecondName is null
		SET @message = 'First name & last name are null'
	ELSE IF @firstName Is null AND @SecondName is not null
		SET @message='first name is null'
	ELSE IF @firstName IS NOT NULL AND @SecondName IS null
		SET @message= 'last name is null'
	ELSE
		SET @message =@firstName+' and '+@SecondName+' are not null'
	SELECT @message
END

displayStudentNameS 13




CREATE PROC  display_Dep_and_manager_hiredateS(@MgrId int)
AS
BEGIN
SELECT ins.Ins_Id,dep.Dept_Name,ins.Ins_Name,dep.Manager_hiredate
		FROM Department dep
		JOIN Instructor ins
		ON dep.Dept_Id= ins.Dept_Id
		WHERE ins.Ins_Id = @MgrId

END

display_Dep_and_manager_hiredateS 1



CREATE PROC getstudsS(@format varchar(20))
AS
BEGIN
DECLARE @t table
		(
		 id int,
		 sname varchar(50)
		)

	
		if @format='firstname'
			insert into @t
			select st_id,ISNULL(st_fname,'first name is not found') from Student
		else if @format='lastname'
			insert into @t
			select st_id,ISNULL(st_Lname,'last name is not found') from Student
		else if @format='fullname'
			insert into @t
			select st_id,concat(ISNULL(st_fname,'first name is not found'),' ',ISNULL(st_lname,'second name is not found')) from Student
					
	end


	getstudsS 'firstname'