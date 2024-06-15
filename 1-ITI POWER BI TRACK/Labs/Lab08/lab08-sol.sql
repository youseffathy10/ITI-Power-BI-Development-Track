--1.Create a view that displays student full name, course name if the student has a grade more than 50. [Use ITI DB]
USE ITI 
GO

CREATE VIEW courseView WITH ENCRYPTION
AS 
SELECT CONCAT(St_Fname,' ' ,St_Lname) AS FullName,c.Crs_Name
FROM Student stud
JOIN Stud_Course st_co
ON stud.St_Id = st_co.St_Id
JOIN Course c
ON st_co.Crs_Id = c.Crs_Id
WHERE st_co.Grade >50


SELECT * FROM courseView

--problem 2  Create an Encrypted view that displays manager names and the topics they teach. [Use ITI DB]

ALTER VIEW InstructorInfo WITH ENCRYPTION
AS 
SELECT ins.Ins_Name, topic.Top_Name
FROM Department dep
JOIN Instructor ins
ON dep.Dept_Manager = ins.Ins_Id
JOIN Ins_Course ins_co
ON ins.Ins_Id = ins_co.Ins_Id
JOIN Course c
ON c.Crs_Id = ins_co.Crs_Id
JOIN Topic 
ON Topic.Top_Id =c.Top_Id


SELECT * FROM InstructorInfo


--problem 3 Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department . [Use ITI DB]
CREATE VIEW instructorDepInfo 
AS 
SELECT ins.Ins_Name , dep.Dept_Name
FROM Instructor ins
JOIN Department dep
ON ins.Dept_Id = dep.Dept_Id
WHERE dep.Dept_Name = 'SD' OR dep.Dept_Name='Java'

SELECT * FROM instructorDepInfo


--problem 4	
/*Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
Note: Prevent the users to run the following query 
Update V1 set st_address=’tanta’
Where st_address=’alex’;
*/

CREATE VIEW V1 
AS 
SELECT *
FROM Student st
WHERE ST.St_Address IN ('Alex','Cairo')
WITH CHECK OPTION 

SELECT * FROM V1

Update V1 set st_address='tanta'
Where st_address='alex'

/*
5.	Create a view that will display the project name and the number of employees work on it. “Use Company DB”
*/


CREATE VIEW emp_project
AS 
SELECT p.Pname,COUNT(w.essn) AS emp_Num
FROM Company_SD.dbo.Project  p
JOIN Company_SD.dbo.Works_for w
ON p.Pnumber = w.Pno
GROUP BY p.Pname

SELECT * 
FROM emp_project


/*
6.	Create a stored procedure without parameters to show the number of students per department name.[use ITI DB] 
*/
CREATE PROC NoStud
AS 
	SELECT dep.Dept_Name , COUNT(stud.St_Id) AS NumOfStudents
	FROM Student stud
	JOIN Department dep
	ON stud.Dept_Id = dep.Dept_Id
	GROUP BY dep.Dept_Name

NoStud


/*
7.	Create a stored procedure that will check for the # of employees 
in the project p1 
if they are more than 3 print message to the user “'The number of employees in the project p1 is 3 or more'”
if they are less display a message to the user “'The following employees work for the project p1'” 
in addition to the first name and last name of each one. [Company DB] 
*/


ALTER PROC num_Of_Emp_In_Project_P1
AS 
	DECLARE @counter int 
	SET @counter =  (
	SELECT COUNT(*) 
	FROM Company_SD.dbo.project p 
	JOIN Company_SD.dbo.works_for w 
	ON p.Pnumber = w.pno 
	JOIN Company_SD.dbo.employee e 
	ON e.ssn = w.essn 
	WHERE p.Pname = 'AL Solimaniah'
	)

	IF @counter >=3
		SELECT 'The number of employees in the project AL Solimaniah is 3 or more' AS message
	ELSE 
	BEGIN
		SELECT 'The following employees work for the project AL Solimaniah' AS message
		SELECT e.Fname,e.Lname 
		FROM Company_SD.dbo.project p 
		JOIN Company_SD.dbo.works_for w 
		ON p.Pnumber = w.pno 
		JOIN Company_SD.dbo.employee e 
		ON e.ssn = w.essn 
		WHERE p.Pname = 'AL Solimaniah'
	END
 num_Of_Emp_In_Project_P1


 /*
 8.	Create a stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him. 
 The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number) and it will be used to update works_on table. [Company DB]
 */

 Alter PROC	UpdateEmployee @Old_empNo int, @new_EmpNo int , @projNo int
 AS 
 BEGIN TRY
	UPDATE Company_SD.dbo.Works_for
	SET @Old_empNo = @new_EmpNo
	WHERE Pno = @projNo AND ESSn = @Old_empNo
END TRY
	BEGIN CATCH
		SELECT 'THERE IS NO EMPLOYEE WITH THAT NUMBER IN THE DB ' 
	END CATCH

UpdateEmployee 669955, 12345  , 10


/*
9.	add column budget in project table and insert any draft values in it then 
then Create an Audit table with the following structure 
This table will be used to audit the update trials on the Budget column (Project table, Company DB)
Example:
If a user updated the budget column then the project number, user name that made that update, the date of the modification and the value of the old and the new budget will be inserted into the Audit table
Note: This process will take place only if the user updated the budget column

*/
USE Company_SD

CREATE TABLE history
(
    projectNo varchar(10),
    UserName varchar(50),
    Modified_date date,
    old_budget int,
    budget_new int
);

DROP TABLE history
ALTER TABLE Company_SD.dbo.Project ADD Budget int;


CREATE TRIGGER tr_1
ON Company_SD.dbo.Project
AFTER UPDATE
AS

    IF UPDATE(Budget)
    BEGIN
        DECLARE @projectNo varchar(10);
        DECLARE @budget_old int;
        DECLARE @budget_new int;
        SELECT @projectNo = i.Pnumber,
               @budget_old = d.Budget,
               @budget_new = i.Budget
        FROM inserted i
        JOIN deleted d ON i.Pnumber = d.Pnumber;
        INSERT INTO history (projectNo, UserName, Modified_date, old_budget, budget_new)
        VALUES (@projectNo, suser_name(), GETDATE(), @budget_old, @budget_new);
    END



UPDATE Company_SD.dbo.Project
SET Budget = 300
WHERE Pnumber = 200;




/*
10.	Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
“Print a message for user to tell him that he can’t insert a new record in that table”

*/

ALTER TRIGGER TRIG
ON Company_SD.dbo.Departments
INSTEAD OF INSERT 
AS 
	SELECT 'SORRY BUT YOU CANNOT INSERT IN THIS TABLE'


INSERT INTO Company_SD.dbo.Departments VALUES ('D1',10,102300,NULL)


/*
11.	 Create a trigger that prevents the insertion Process for Employee table in March [Company DB].
*/

CREATE TRIGGER preventInsertion
on Company_SD.dbo.Employee
instead of insert
as
	if(format(getdate(),'MMMM')='March')
		select 'not allowed'
	else
		insert into student
		select * from inserted

/*
12.	Create a trigger on student table after insert to add Row in Student Audit table (Server User Name , Date, Note)
where note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”. [Use ITI DB]
*/

CREATE TABLE student_Audit
(
Server_User_name varchar(50),
_date DATE,
NOTE varchar(100)
)
ALTER TRIGGER trg
ON Student
AFTER INSERT 
	AS	
		DECLARE  @id int 
		SELECT @id=inserted.St_Id FROM inserted
		DECLARE @note varchar(50) 
		SET @note = suser_name() +' Insert New Row with Key= '+CAST(@id AS VARCHAR) +' in '+' Student table' 
		INSERT INTO student_Audit VALUES(suser_name(),getdate(),@note)

INSERT INTO Student(St_Id,St_Fname) VALUES(223,'mohamed')

SELECT * FROM student_Audit


/*
13.	 Create a trigger on student table instead of delete to add Row in Student Audit table (Server User Name, Date, Note) 
where note will be“ try to delete Row with Key=[Key Value]” . [Use ITI DB]
*/
CREATE TRIGGER DeletTracker
ON Student
AFTER DELETE
	AS	
		DECLARE  @id int 
		SELECT @id=deleted.St_Id FROM deleted
		DECLARE @note varchar(50) 
		SET @note = suser_name() +' try to delete Row with Key= '+CAST(@id AS VARCHAR)  
		INSERT INTO student_Audit VALUES(suser_name(),getdate(),@note)

DELETE 
FROM Student
WHERE St_Id BETWEEN 3001 AND 6000

SELECT * FROM student_Audit
