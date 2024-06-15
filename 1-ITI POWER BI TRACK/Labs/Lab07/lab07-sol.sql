--Problem 1 
CREATE FUNCTION Get_MonthDay(@date date)
	RETURNS varchar(20)
	AS 
	BEGIN
		DECLARE @month VARCHAR(20) = FORMAT(@date, 'MMMM')
		RETURN @month
	END

SELECT dbo.Get_MonthDay('1-10-2024') AS Month_of_the_date



--problem2
/*
Create a multi-statements table-valued function that takes 2 
integers and returns the values between them.
*/

CREATE FUNCTION diff_between_values(@x1 int , @x2 int)
	RETURNS @t TABLE 
	(
	num1 int,
	num2 int,
	diff int
	)
	AS 
BEGIN
DECLARE @difference int
		IF @x1 > @x2 
			SET @difference = @x1-@x2
		ELSE IF @x1 <@x2
			SET @difference = @x2-@x1
		INSERT INTO @t(num1,num2,diff)
		VALUES(@x1,@x2,@difference)
	RETURN
END

SELECT * FROM diff_between_values(122 ,10)


--Problem 2: range between 2 values
CREATE FUNCTION get_range(@x1 int,@x2 int)
RETURNS @t table 
	(
	range_of_val int
	)
AS 
	BEGIN 
	DECLARE @iter int = @x1+1
		WHILE @iter <@x2
			BEGIN
			INSERT INTO @t(range_of_val)
			Values(@iter)
				SET @iter+=1
			END
	RETURN
	END

SELECT * FROM get_range(10,20)


--problem 3
/*
Create inline function that takes Student No and 
returns Department Name with Student full name.

*/

CREATE FUNCTION get_dep_wit_stud_Fullname(@stNo int)
RETURNS TABLE
AS 
	RETURN
		(
			SELECT CONCAT(stud.St_Fname,' ',stud.St_Lname) as fullname,dep.Dept_Name
			FROM Student as stud 
			JOIN Department dep
			ON stud.Dept_Id = dep.Dept_Id
			WHERE stud.St_Id = @stNo
		)

SELECT * FROM get_dep_wit_stud_Fullname(1)


--problem 4
/*
4.	Create a scalar function that takes Student ID and returns a message to user 
a.	If first name and Last name are null then display 'First name & last name are null'
b.	If First name is null then display 'first name is null'
c.	If Last name is null then display 'last name is null'
d.	Else display 'First name & last name are not null'

*/

CREATE FUNCTION displayStudentName(@stNo int)
RETURNS VARCHAR(50)
	BEGIN
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
	
	RETURN @message
	END

SELECT dbo.displayStudentName(13)


--Problem 5
/*
5.	Create inline function that takes integer which represents manager ID and displays department name,
Manager Name and hiring date 

*/

CREATE FUNCTION display_Dep_and_manager_hiredate(@MgrId int)
RETURNS TABLE
	RETURN
	(
		SELECT ins.Ins_Id,dep.Dept_Name,ins.Ins_Name,dep.Manager_hiredate
		FROM Department dep
		JOIN Instructor ins
		ON dep.Dept_Id= ins.Dept_Id
		WHERE ins.Ins_Id = @MgrId
	)

SELECT * FROM display_Dep_and_manager_hiredate(1)


--problem 6
/*
6.	Create multi-statements table-valued function that takes a string
If string='first name' returns student first name
If string='last name' returns student last name 
If string='full name' returns Full Name from student table 
Note: Use “ISNULL” function


*/
create function getstuds(@format varchar(20))
returns @t table
		(
		 id int,
		 sname varchar(50)
		)
as
	begin
		if @format='firstname'
			insert into @t
			select st_id,ISNULL(st_fname,'first name is not found') from Student
		else if @format='lastname'
			insert into @t
			select st_id,ISNULL(st_Lname,'last name is not found') from Student
		else if @format='fullname'
			insert into @t
			select st_id,concat(ISNULL(st_fname,'first name is not found'),' ',ISNULL(st_lname,'second name is not found')) from Student
		return 			
	end

select * from dbo.getstuds('firstname')


--problem 7
/*
7.	Write a query that returns the Student No and Student first name without the last char

*/
select substring(st_fname,1,len(st_fname)-1) AS firstName
from Student

--problem 8
/*
Write query to delete all grades for the students Located in SD Department 
*/

DELETE st_co
FROM Stud_Course st_co
JOIN student stud
ON st_co.St_Id = stud.St_Id
JOIN Department dep
ON stud.Dept_Id=dep.Dept_Id
WHERE dep.Dept_Name = 'SD'





--Bonus NO.1
CREATE TABLE emp
(
    id int identity(1,1) primary key,
    mgr_id hierarchyid not null,
    emp_name varchar(50)
);
/*
	Mohamed
	Abdullah 
 Tamer    Ahmed
Tarek
*/
INSERT INTO emp (mgr_id, emp_name)
VALUES 
    (('/'), 'Mohamed'),
    (('/1/'), 'Abdullah'),
    (('/1/1/'), 'Ahmed'),
    (('/1/1/2/'), 'Tarek'),
    (('/1/2/'), 'Tamer');

SELECT emp_name, mgr_id.GetLevel() as lvl
FROM emp;

SELECT emp_name, mgr_id.GetAncestor(2) as ancestor
FROM emp;

--Bonus NO.2
/*
2.	Create a batch that inserts 3000 rows in the student table(ITI database). 
The values of the st_id column should be unique and between 3000 and 6000.
All values of the columns st_fname, st_lname, should be set to 'Jane', ' Smith' respectively.
*/

DECLARE @iterator int = 3000  
WHILE @iterator <6000
	BEGIN
	INSERT INTO Student(St_Id,St_Fname,St_Lname)
	 VALUES(@iterator,'Jane','Smith')
	 SET @iterator+=1
	END
