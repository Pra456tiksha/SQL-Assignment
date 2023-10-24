
--Create ETL Job
create table Emp_SRC(ID int, Name varchar(255), Address varchar(255), Salary money);

insert into Emp_SRC values(1,'Ram','Pune',10000);
insert into Emp_SRC values(2,'Sham','Ahmednagar',15000);
insert into Emp_SRC values(3,'Rina','Hyderabad',35000);
insert into Emp_SRC values(4,'Payal','Delhi',25000);
insert into Emp_SRC values(5,'Krishna','Kolhapur',40000);

select * from EMP_SRC

create table Emp_DESC(ID int, Name varchar(255), Address varchar(255), Salary money);

select * from EMP_DESC