--problem 1
SELECT COUNT(St_Age) AS [Number of students]
FROM Student


--problem 2 
SELECT DISTINCT Ins_Name
FROM Instructor


--problem 3 
SELECT stud.St_Id AS [Student ID], CONCAT(stud.St_Fname,' ', stud.St_Lname) AS [Student Full Name], ISNULL(dep.Dept_Name,'NO DEP ') AS [Department name]
FROM Student stud
JOIN Department dep
ON stud.Dept_Id = dep.Dept_Id


--problem 4
SELECT ins.Ins_Name, dep.Dept_Name
FROM Instructor ins
LEFT JOIN Department dep
ON ins.Dept_Id = dep.Dept_Id


--problem 5
SELECT  CONCAT(stud.St_Fname,' ', stud.St_Lname) AS [Student Full Name]
FROM Student stud
JOIN Stud_Course stud_co
ON stud.St_Id = stud_co.St_Id
JOIN Course co
ON stud_co.Crs_Id = co.Crs_Id
WHERE stud_co.Grade IS NOT NULL


--problem 6 Display number of courses for each topic name
SELECT t.Top_Name ,COUNT(co.Crs_Id) AS no_of_courses
FROM COURSE co
JOIN Topic t
ON co.Top_Id = t.Top_Id
GROUP BY t.Top_Name

--7.	Display max and min salary for instructors
SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM Instructor
--8.	Display instructors who have salaries less than the average salary of all instructors.
SELECT Ins_Name
FROM Instructor
WHERE Salary < ( SELECT AVG(salary) FROM Instructor)

--9.	Display the Department name that contains the instructor who receives the minimum salary
SELECT dep.Dept_Name
FROM Instructor ins
JOIN Department dep
ON ins.Dept_Id  = dep.Dept_Id
WHERE ins.salary = (SELECT MIN(Salary) FROM Instructor)

--10.Select max two salaries in instructor table. 
SELECT salary
FROM (	SELECT *,ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
			FROM Instructor) AS tab
WHERE row_num <=2

/*11.Select instructor name and his salary but if there is no salary display instructor bonus keyword. 
“use coalesce Function”
*/

SELECT COALESCE(CAST(salary AS VARCHAR),'bonus')  AS Salary
FROM Instructor

--problem 12 
SELECT AVG(salary)
FROM Instructor

--problem 13 Select Student first name and the data of his supervisor 
SELECT stud.St_Fname, super.*
FROM Student stud
JOIN Student super
ON super.St_Id = stud.St_super


--problem 14 
/*
14.	Write a query to select the highest two salaries in Each Department for instructors who have salaries. 
“using one of Ranking Functions”
*/
SELECT salary
FROM (	SELECT * ,ROW_NUMBER() OVER (PARTITION BY Dept_id ORDER BY salary DESC) AS row_num
		FROM Instructor) AS tab1
WHERE row_num <=2


/*
15-Write a query to select a random student from each department.  “using one of Ranking Functions”

*/
SELECT *
FROM (SELECT *,ROW_NUMBER() OVER(PARTITION BY Dept_Id ORDER BY NEWID() ) AS RN
      FROM Student) AS tb2
WHERE RN =1

	



