-- creating and populating table
--Create table Employees
--(
-- EmployeeID int primary key identity,
-- EmployeeName nvarchar(50),
-- ManagerID int foreign key references Employees(EmployeeID)
--)
--GO

--Insert into Employees values ('John', NULL)
--Insert into Employees values ('Mark', NULL)
--Insert into Employees values ('Steve', NULL)
--Insert into Employees values ('Tom', NULL)
--Insert into Employees values ('Lara', NULL)
--Insert into Employees values ('Simon', NULL)
--Insert into Employees values ('David', NULL)
--Insert into Employees values ('Ben', NULL)
--Insert into Employees values ('Stacy', NULL)
--Insert into Employees values ('Sam', NULL)
--GO

--Update Employees Set ManagerID = 8 Where EmployeeName IN ('Mark', 'Steve', 'Lara')
--Update Employees Set ManagerID = 2 Where EmployeeName IN ('Stacy', 'Simon')
--Update Employees Set ManagerID = 3 Where EmployeeName IN ('Tom')
--Update Employees Set ManagerID = 5 Where EmployeeName IN ('John', 'Sam')
--Update Employees Set ManagerID = 4 Where EmployeeName IN ('David')
--GO



declare @id int
set @id = 4;

with cte as (
select EmployeeID, EmployeeName, ManagerID
from Employees
where EmployeeId = @id

union all

select e.EmployeeID, e.EmployeeName, e.ManagerID
from Employees as e
inner join cte as c
on e.EmployeeID = c.ManagerID
)

select e.EmployeeName, ISNULL(m.EmployeeName, 'No boss') as Manager
from cte as e
left join cte as m
on e.ManagerID = m.EmployeeID
