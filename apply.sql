
create function fn_getEmployeesByDepartment(@deptid int)
returns table
as 
return
(
	select * from Employee where DeptId = @deptid
)	

select * from fn_getEmployeesByDepartment(1)

select e.DeptId, e.name, e.Salary
from Dept as d
inner join Employee as e
on d.id = e.DeptId



cross apply fn_getEmployeesByDepartment(e.deptid)
select e.DeptId, e.Name, e.Salary
from Employee as e