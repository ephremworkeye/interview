use TEST4
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


select e.DeptId, e.name, e.salary from Employee as e
cross apply fn_getEmployeesByDepartment(e.deptid)
