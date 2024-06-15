use ITI

declare @x int=(select avg(St_age) from Student)

set @x=100

select @x=7

select @x

declare @y int
	select @y=st_age from Student
	where st_id=8
select @y


declare @y int
	select @y=st_age from Student
	where st_address='alex'
select @y

--Arrays   -- table variable
declare @t table(col1 int) --1D array of integers
	insert into @t
	values(5),(8),(12)
select * from @t

declare @t table(col1 int) --1D array of integers
	insert into @t
	select st_age from Student where st_address='alex'
select * from @t
select count(*) from @t

declare @t table(col1 int,col2 varchar(20)) --2D array 
	insert into @t
	select st_age,st_fname from Student where st_address='alex'
select * from @t
select count(*) from @t

declare @x int,@name varchar(20)
	select @x=st_age , @name=st_fname from Student
	where st_id=3
select @x , @name

declare @sal int
	update Instructor
		set ins_name='ahmed' , @sal=salary
	where ins_id=7
select @sal

--dynamic queries

declare @par int=7

select * from Student
where st_id=@par

declare @par int=5

select top(@par)*
from Student

--metadata 
declare @col varchar(10)='*',@t varchar(20)='instructor'
execute('select '+@col+' from '+@t)

declare @col varchar(10)='*',@t varchar(20)='instructor',@cond varchar(20)='salary>1000'
execute('select '+@col+' from '+@t+' where '+@cond)

declare @col varchar(10)='*',@t varchar(20)='course',@cond varchar(20)='crs_id=100'
execute('select '+@col+' from '+@t+' where '+@cond)

select 'select * from student'

execute( 'select * from student')

--->Global var
select @@SERVERNAME

select @@VERSION

update Student set st_age+=1
select @@ROWCOUNT

select * from Course where Crs_Duration>50
select @@ROWCOUNT

select * from Course where Crs_Duration>50
select @@ROWCOUNT
select @@ROWCOUNT

select * from Course where Crs_Duration>50
go
select @@ERROR

insert into test2 values('ahmedhassan')
select @@IDENTITY

---------------------------------------
--control of statements
--if
declare @x int
update Instructor set Salary+=100
select @x=@@ROWCOUNT
if @x>0 
	begin
		select 'multi rows affected'
		select 'welcome to ITI'
	end
else 
	begin
		select 'zero rows affected'
	end

--begin  end
--if exists  if not exists

if exists(select name from sys.tables where name='student')
	select 'table is existed'
else
	create table student
	(
	id int,
	ename varchar(10)
	)

if exists(select name from sys.tables where name='ITIemployees')
	select 'table is existed'
else
	create table ITIemployees
	(
	id int,
	ename varchar(10)
	)

if not exists(select top_id from course where top_id=10)
	delete from topic where top_id=10
else
	select 'table has relationship'

begin try
	delete from topic where top_id=2
end try
begin catch
	select 'error'
	select ERROR_LINE(),ERROR_MESSAGE(),ERROR_NUMBER()
end catch

--while
declare @x int=10
while @x<=20
	begin
		set @x+=1
		if @x=14
			continue
		if @x=16
			break
		select @x
	end

--continue break
--case iif
select ins_name , salary,
				case
					when salary>=3000 then 'high salary'
					when salary<3000 then 'low'
					else 'no data'
				end as newcol
from Instructor

select ins_name , iif(salary>=3000,'high','low')
from Instructor

update Instructor
	set salary=salary*1.20

update Instructor
	set salary=
			case
				when salary>=3000 then salary*1.20
				else salary*1.10
			end
--------------------------------------
--builtin functions
--->null
select isnull(exp,'')

select isnull(st_lname,'')
from Student

coalesce

nullif

--data conversion

select convert(varchar(50),getdate())
select cast(getdate() as varchar(50))

select convert(varchar(50),getdate(),101)
select convert(varchar(50),getdate(),102)
select convert(varchar(50),getdate(),102)
select convert(varchar(50),getdate(),103)
select convert(varchar(50),getdate(),105)

select format(getdate(),'dd-MM-yyyy')
select format(getdate(),'dddd MMMM yyyy')
select format(getdate(),'ddd MMM yy')
select format(getdate(),'dddd')
select format(getdate(),'MMMM')
select format(getdate(),'hh:mm:ss')
select format(getdate(),'HH')
select format(getdate(),'hh tt')
select format(getdate(),'dd-MM-yyyy hh:mm:ss tt')

select format(getdate(),'yyyy')
select year(getdate())

select eomonth(getdate())

select format(eomonth(getdate()),'dd')

select format(eomonth(getdate()),'dddd')

select eomonth(getdate(),2)

select eomonth(getdate(),-1)

--date
select getdate()

select DATEADD(day,7,getdate())

select DATEADD(year,10,getdate())

select datediff(year,'1/1/2005','1/1/2010')
select datediff(week,'1/1/2005','1/1/2010')

select isdate('dasds')
select isdate('1/1/2000')

select ISNUMERIC('dasdasd')
select ISNUMERIC('123')

--Agg
--ranking
--windowing
--math
sin cos tan log power

select abs(-5)
select sqrt(25)
select power(salary,2)
from Instructor

--string funtcion

select concat('ahmed','ali','eman','omar')
select concat_ws(' - ','ahmed','ali','eman','omar')

select CHARINDEX('h','khalid')
select CHARINDEX('m','khalid')

select REPLACE('ahmed$gmail.com','$','@')

select stuff('ahmedalikhalid',6,3,'omar')

select REVERSE('ahmed')

select REPLICATE('ahmed',3)

select len(st_fname) ,st_fname
from Student

select substring(st_fname,1,3)
from Student

select substring(st_fname,3,3)
from Student

select substring(st_fname,1,len(st_fname)-1)
from Student

select top(1) st_fname
from Student
order by len(st_fname) desc

select UPPER(st_fname),LOWER(st_lname)
from Student

--user defined function
--->scalar
--->prototype function          fun_name   Parameter  return_value  body
create function getsname(@id int)
returns varchar(30)
	begin
		declare @name varchar(30)
			select @name=st_fname from Student
			where st_id=@id
		return @name
	end

--calling
select dbo.getsname(1)

alter schema hr transfer getsname

select hr.getsname(2)

alter schema dbo transfer hr.getsname

drop function getsname

select * from Company_SD.dbo.student

--->inline
create function getinsts(@did int)
returns table
as
	return
		(
		 select ins_name,salary*12 as annualsal
		 from Instructor
		 where Dept_Id=@did
		)

--calling
select * from getinsts(10)
select ins_name from  getinsts(10)
select sum(annualsal) from getinsts(10)

--->Multi
create function getstuds(@format varchar(20))
returns @t table
		(
		 id int,
		 sname varchar(20)
		)
as
	begin
		if @format='firstname'
			insert into @t
			select st_id,st_fname from Student
		else if @format='lastname'
			insert into @t
			select st_id,st_Lname from Student
		else if @format='fullname'
			insert into @t
			select st_id,concat(st_fname,' ',st_lname) from Student
		return 			
	end

--calling
select * from getstuds('firstname')
------------------------------------------------

--SQLserver 2016
select * from string_split('ahmed,ali,khalid,omar',',')

select value from string_split('ahmed,ali,khalid,omar',',')

create table ITIdata
(
 eid int,
 ename varchar(20),
 skills varchar(50)
)

insert into ITIdata
values(1,'ahmed','C#,java,html,SQL')
      ,(2,'eman','C,js,cloud')
	  ,(1,'ali','OOP,JQ,API')

select * from ITIdata

select ename,value
from ITIdata cross apply string_split(skills,',')

































 