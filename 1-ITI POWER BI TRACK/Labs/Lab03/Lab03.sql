

--Problem No1
SELECT D.Dnum, D.Dname, D.MGRSSN, E.Fname
FROM Departments D
JOIN Employee E
ON D.MGRSSN = E.SSN

--Problem No2
SELECT  D.Dname,Pname
FROM Departments D
JOIN Project P
ON D.Dnum = P.Dnum


--Problem 3
SELECT E.Fname, depen.*
FROM Employee E
JOIN Dependent depen
ON E.SSN = depen.ESSN


--Problem 4
SELECT Pnumber,Pnumber,City
FROM Project
WHERE City = 'Alex' OR City='Cairo'



--Problem No.5 
SELECT *
FROM Project
WHERE Pname LIKE 'a%'

--Problem 6
SELECT Fname,Salary
FROM Employee
WHERE DNO=30 AND Salary BETWEEN 1000 AND 2000

--Problem 7
SELECT E.Fname,W.Hours,Pname,E.Dno
FROM Employee E
JOIN Works_for W
ON E.SSN = W.ESSn
JOIN Project P
ON P.Pnumber = W.Pno
WHERE E.Dno =10 AND W.Hours>=10 AND Pname ='AL Rabwah'


--PROBLEM 8
SELECT E.Fname AS EMP_NAME ,M.Fname AS SUPER_NAME
FROM Employee E
JOIN Employee M
ON M.SSN = E.Superssn
WHERE M.Fname ='Kamel'


--Problem 9
SELECT E.Fname,P.Pname
FROM Employee E
JOIN Works_for W
ON E.SSN =W.ESSn
JOIN Project P
ON P.Pnumber = W.Pno
ORDER BY Pname ASC


--problem 10

SELECT p.Pname, p.Pnumber,d.Dname, e.Lname, e.Address,e.Bdate	
FROM Departments d
JOIN Project p
ON d.Dnum = p.Dnum
JOIN Employee e
ON e.SSN =d.MGRSSN
WHERE p.City ='Cairo'

--problem 11
SELECT E.*
FROM Employee E
JOIN Departments d
ON E.SSN = d.MGRSSN

--problem 12 
SELECT *
FROM Employee e
LEFT OUTER JOIN Dependent d
ON E.SSN = d.ESSN


--problem 13 

INSERT INTO Employee(Fname,Lname,Dno,SSN,Superssn,Salary)
VALUES ('ahmed','Mohamed',30,102672,112233,3000)

--problem 14 
INSERT INTO Employee(Fname,Lname,Dno,SSN)
VALUES ('Samy','Mohamed',30,102660)


--problem 15 15.	Upgrade your salary by 20 % of its last value.

UPDATE Employee
SET Salary+= Salary *0.2
WHERE SSN = 102672
