-- drop TABLE duplicate
-- Create table duplicate
-- (
--  ID int,
--  FirstName nvarchar(50),
--  LastName nvarchar(50),
--  Gender nvarchar(50),
--  Salary int
-- )
-- GO

-- Insert into duplicate values (1, 'Mark', 'Hastings', 'Male', 60000)
-- Insert into duplicate values (1, 'Mark', 'Hastings', 'Male', 60000)
-- Insert into duplicate values (1, 'Mark', 'Hastings', 'Male', 60000)
-- Insert into duplicate values (2, 'Mary', 'Lambeth', 'Female', 30000)
-- Insert into duplicate values (2, 'Mary', 'Lambeth', 'Female', 30000)
-- Insert into duplicate values (3, 'Ben', 'Hoskins', 'Male', 70000)
-- Insert into duplicate values (3, 'Ben', 'Hoskins', 'Male', 70000)
-- Insert into duplicate values (3, 'Ben', 'Hoskins', 'Male', 70000)

-- select * from duplicate;

WITH cte AS(
SELECT
    ID,
    FirstName,
    LastName,
    Gender,
    ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) as rn
FROM duplicate)

Delete  
from cte
where rn > 1
