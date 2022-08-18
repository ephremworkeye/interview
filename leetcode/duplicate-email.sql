USE TEST3
SELECT * from dup
insert into dup VALUES (3, 'addis@gmail.com')

go
with cte as(
SELECT 
    email, 
    ROW_NUMBER() OVER(partition by email ORDER BY email) as rn 
FROM dup) 
delete from cte where rn > 1

delete d2
from dup as d1
inner join dup as d2
on d1.email = d2.email and d1.id < d2.id

select datediff(year, GETDATE(), '2017-01-27')
select datediff(year, GETDATE(), '2020-10-07')

WITH cte as (
SELECT
    id,
    email,
    ROW_NUMBER() OVER(PARTITION BY email ORDER BY id) as rn
FROM dup )
SELECT * from cte WHERE rn > 1
