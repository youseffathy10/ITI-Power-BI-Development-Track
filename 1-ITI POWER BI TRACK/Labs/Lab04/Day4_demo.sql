Select S.St_Fname as studname , Cpy.*
from Student S , Student Cpy
where cpy.St_Id = S.St_super --(cpy,parent,pk,leaders) --(S.child,fk,students)

select salary
from Instructor

select sum(salary) as Totalsal
from Instructor

select count(st_id)
from Student

select count(*),count(st_id),Count(st_fname),count(st_age)
from Student

select avg(st_age)
from student

select avg(isnull(st_age,0))
from student

select sum(st_age)/count(*)
from Student

select sum(salary),dept_id
from Instructor
group by Dept_Id

select sum(salary),d.dept_id,dept_name
from Instructor i inner join Department d
	on d.Dept_Id = i.Dept_Id
group by d.dept_id,dept_name

select count(St_id),st_address
from Student
group by St_Address

select count(St_id),dept_id
from Student
group by dept_id

select count(St_id),dept_id,st_address
from Student
group by dept_id,st_address

select sum(salary),dept_id
from Instructor
group by Dept_Id

select sum(salary),dept_id
from Instructor
where salary>1000
group by Dept_Id

select sum(salary),dept_id
from Instructor
group by Dept_Id

select sum(salary),dept_id
from Instructor
group by Dept_Id
having sum(salary)>25000

select sum(salary),dept_id
from Instructor
group by Dept_Id
having count(ins_id)<7

select sum(salary)
from Instructor

select sum(salary),avg(salary)
from Instructor
having count(ins_id)<100

----------------------------------------------
--subqueries
select *
from Student
where st_age>(select avg(St_age) from Student)

select *,(select count(st_id) from Student)
from student

select dept_name
from Department
where Dept_Id  in (select distinct dept_id
                  from student
				  where Dept_Id is not null)

select distinct dept_name
from Student S inner join Department d
	on d.Dept_Id = S.Dept_Id

--Join  DML
--Subquery DML
delete from Stud_Course
where crs_id=100

delete from Stud_Course
where crs_id =(select crs_id from Course where crs_name='OOP')

----------------------------------------------------------------
--union queries   --Set operator
union all   union   intersect   except

--batch  
--set of independent queries

select st_fname
from Student
union all
select ins_name
from Instructor

select st_fname as [names]
from Student
union all
select ins_name
from Instructor

select st_fname,st_id
from Student
union all
select ins_name,ins_id
from Instructor


select convert(varchar(10),st_id)
from Student
union all
select ins_name
from Instructor

select st_fname
from Student
union --distinct  (order+unique)
select ins_name
from Instructor

select st_fname
from Student
intersect
select ins_name
from Instructor

select st_fname,st_id
from Student
intersect
select ins_name,ins_id
from Instructor

select st_fname 
from Student
except
select ins_name
from Instructor


select st_fname 
from Student
except
select ins_name
from Instructor

--------------------
--EERD
--grouping having where
--subqueries
--union
select st_fname,dept_id,st_age
from Student
where st_address='alex'

select st_fname,dept_id,st_age
from Student
order by st_address

select st_fname,dept_id,st_age
from Student
order by 1

select st_fname,dept_id,st_age
from Student
order by St_Address

select st_fname,dept_id,st_age
from Student
order by Dept_Id desc, st_age asc

select st_fname+' '+st_lname as fullname
from Student
order by fullname

select st_fname+' '+st_lname as fullname
from Student
where fullname='ahmed hassan'

select st_fname+' '+st_lname as fullname
from Student
where st_fname+' '+st_lname='ahmed hassan'

select *
from (select st_fname+' '+st_lname as fullname
      from Student) as newtable
where fullname='ahmed hassan'


--execution order
--from
--join
--on
--where <--fun
--group by
--having
--select <--fun
--order
--top

--data types
-------Numeric DT
bit  --boolean   false:true  0:1   flag
tinyint --1 byte    0:255 
smallint --2B   -32768:32767  
int  --4B
bigint --8B
-------Decimal DT
smallmoney  --4B   .0000 $
money       --8B   .0000 $
real               .0000000
float              .0000000000000000000
dec  decimal   dec(5,2)  123.55    1.4     12.443XXXXXX
-------string & char
char(10)   fixed length char   ahmed 10      ali  10       محمد على  ?????
varchar(10)   variable length string    ahmed 5   ali  3
nchar(10)  unicode  Language
nvarchar(10) unicode Language
nvarchar(max)  --up to 2GB
text  --old data type
-------date time DT
date  MM/dd/yyyy
time hh:mm:ss.432
time hh:mm:ss.4328765
smalldatetime MM/dd/yyyy hh:mm:00   range year 100
datetime MM/dd/yyyy hh:mm:ss.677
datetime(7)  MM/dd/yyyy hh:mm:ss.6777723
datetimeoffset  6/6/2024 10.30 +2:00
-------binary DT
binary   1001011  111111000  10001
image 

-------others
xml
uniqueidentifier
geography
sql_variant


