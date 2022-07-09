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

select e.EmployeeName, m.EmployeeName
from cte as e
left join cte as m
on e.ManagerID = m.EmployeeID
