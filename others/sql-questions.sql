Use TEST3;

select * from sys.tables

-- 1 higest salary
SELECT top 1 salary
FROM (
select top 1 salary
from highest
order by salary DESC) as dr
order by salary


GO
with cte as(
SELECT 
    salary,
    DENSE_RANK() OVER(order by salary desc) as rn
FROM highest
)
SELECT 
    top 1 salary
from cte
where rn = 2


-- organizational hierarchies

SELECT * FROM Employee_Manager


GO
-- get the employee
-- join the employee with his managers in recursive way
-- and merge  both result set using union ALL
-- to find the requested result set use self join to get employee name with its manager name


DECLARE @empid as INT 
set @empid = 4

;WITH empcte as(
SELECT
    EmployeeID,
    EmployeeName,
    ManagerID
FROM Employee_Manager 
WHERE EmployeeID = @empid
UNION ALL
SELECT
    m.EmployeeID,
    m.EmployeeName,
    m.ManagerID
FROM Employee_Manager as m
INNER JOIN empcte as e
ON e.ManagerID = m.EmployeeID
)

SELECT e1.EmployeeName, e2.EmployeeName 
from empcte as e1
Left JOIN empcte as e2
on e1.ManagerID = e2.EmployeeID

-- 3 delete duplicate
select * from dup

SELECT *
from dup as d1
INNER join dup as d2
on d1.email = d2.email

DELETE d2
from dup as d1
INNER join dup as d2
on d1.email = d2.email AND d2.id > d1.id

-- other way

GO
with dupcte as (
SELECT 
    id, email,
    row_number() OVER(PARTITION by email order by id) as rn 
FROM dup)
delete from dupcte
where rn > 1


-- create table dup2(
--     id int,
--     name varchar(20),
--     email varchar(20)

-- )

-- insert into dup2 values(1, 'james', 'james@gmail.com'),
--     (2, 'james', 'james@gmail.com'), (3, 'tom', 'tom@gmail.com'),
--     (4, 'biden', 'biden@gmail.com'), (5, 'biden', 'biden@gmail.com')
--     ,(6, 'trump', 'trump@gmail.com')

SELECT * from dup2

DELETE d2
FROM dup2 as d1
inner JOIN dup2 as d2
on d1.name = d2.name AND d1.email = d2.email and d2.id > d1.id  


--transform row to column
