--SQLServer Schema
--dbo  database owner
--default schema
--SchemaName.Objectname
--Logical group of objects

create schema HR

create schema sales

alter schema HR transfer student

alter schema HR transfer instructor

alter schema sales transfer department

select * from student

select * from hr.student

select * from sales.department

create table student
(
 sid int,
 sname varchar(10)
)

select * from Student

create table sales.student
(
 sid int,
 sname varchar(10)
)

--permissions
--user ===>group of tables  "schema" HR
select * from student

select * from dbo.student

alter schema HR transfer course

select * into HR.course
from course

drop schema HR

use AdventureWorks2012

select * from HumanResources.Jobcandidate

use ITI

select * from AdventureWorks2012.HumanResources.Jobcandidate

--shortcut ===>object 
--sysnonym
create synonym JobC
for AdventureWorks2012.HumanResources.Jobcandidate

select * from JobC

alter schema dbo transfer hr.instructor


alter schema dbo transfer sales.department

-------------------------------------------
backup database db1
to disk='g:\db1.bak'


create table depts
(
 did int Primary key,
 dname varchar(10)
)

create table employee
(
 eid int identity(1,1),
 ename varchar(20),
 eadd varchar(10) default 'cairo',
 hiredate date default getdate(),
 bd date ,
 age as year(getdate())-year(bd),
 sal int ,
 overtime int,
 netsal as sal+overtime persisted, --computed +saved
 gender varchar(1),
 hour_rate int not null,
 dnum int,
 constraint c1 primary key(eid,ename),
 constraint c2 unique(sal),
 constraint c4 unique(overtime),
 constraint c3 check(sal>1000),
 constraint c5 check(overtime between 100 and 500),
 constraint c6 check(Eadd in('alex','mansoura','cairo')),
 constraint c7 check(gender='f' or gender='m'),
 constraint c8 foreign key(dnum) references depts(did)
	on delete set null on update cascade
 )

 alter table employee drop constraint c3

 alter table employee add constraint c9 check(hour_rate>1000)

 --constraint  ----> new data XXXXXX
 --constraint  ---->shared between tables XXXXX
 --constraint  ---->new data type XXXX

 alter table instructor add constraint c10 check(salary>1000)

 --Rule  [Global check constraint]
 create rule r1 as @x>1000

 sp_bindrule r1,'instructor.salary'
 sp_bindrule r1,'employee.sal'

 sp_unbindrule 'instructor.salary'
 sp_unbindrule 'employee.sal'

 drop rule r1


  ----default------
  create default de1 as 5000
  
  sp_bindefault de1,'instructor.salary'

  sp_unbindefault 'instructor.salary'

  drop default de1

  ------------------------------------------------------
  --create new table     int      value>1000     default 5000
  sp_addtype complexdt,'int'

  create rule r1 as @x>1000

  create default def1 as 5000

  sp_bindrule r1,complexdt

  sp_bindefault def1,complexdt
  
  create table mystaff
  (
   id int primary key,
   ename varchar(10),
   salary complexdt
  )

   sp_helpconstraint 'employee'


 dbcc chek_ident('employee',reseed,1)

 set identity_insert employee on

 select IDENT_CURRENT('employee')

 insert into employee(ename,sal,overtime,hour_rate)
 values('ali',4444,300,10)

 select SCOPE_IDENTITY()

 --------------------------------------
 --create DB  filegroup + Properties +schema
 --system dbs
 --DB intergirty constraints_rules

 drop table student   --data_metdata  DDL

 delete from student   --data  DML  slower  log   rollback  --can't reset indetity
                       --where

 truncate table student --data faster  --sometime log --can't rollback ddl
                        --reset identity

--indexes
create clustered index i2
on student(st_fname)

create nonclustered index i3
on student(st_fname)

create nonclustered index i2
on student(st_address)

select *
from student
where st_id=1

select *
from tab5
where st_id=1

--->primary key constraint ----->clustered index
--->unique constraint ---------->nonclustered index

create table mytest
(
 id int identity,
 ssn int primary key,  --clsutered
 sal int unique, --non
 overtime int unique, --non
 ename varchar(20),
 constraint c100 check(sal>1000)
)

create unique index i4  ----->unique constraint +non clustered index
on student(st_age)

create index i4  ----->non clustered index
on student(st_age)

--------------------------------------------------

select * from Instructor
where salary=8000

select * from Course
where Crs_Duration=10
-----------------------------------
--builtin functions
--string functions
select concat('ahmed','ali','omar','khalid')

select concat_ws(' _ ','ahmed','ali','omar','khalid')

select str(123)

select upper(st_fname),lower(st_lname)
from student

select len(st_fname) , st_fname
from student

select substring(st_fname,1,3)
from student

select substring(st_fname,3,3)
from student

select substring(st_fname,1,len(st_fname)-1)
from student

select *
from student
where len(st_fname)>4

select trim('   ahmed     ')
select Ltrim('   ahmed     ')

select REVERSE('ahmed')

select replicate('ahmed',3)

select replicate(st_fname,3)
from student

select top(1)st_fname
from student
order by len(st_fname) desc

select st_fname+space(10)+st_lname
from student

select CHARINDEX('a','omar')
select CHARINDEX('k','omar')

select REPLACE('ahmed$gmail.com','$','@')

select stuff('ahmedmohamedali',5,7,'omar')

select QUOTENAME('USA','[')

select QUOTENAME('USA','"')




