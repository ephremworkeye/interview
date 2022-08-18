-- USE test3
-- CREATE TABLE manager(
--     id           int,    
--     name         varchar(50),
--     salary       int,   
--     managerId   int     
-- )
-- USE TEST3

-- INSERT INTO manager VALUES
--     ( 1, 'Joe', 70000, 3 ),
--     (2, 'Henry', 80000, 4),
--     (3, 'Sam', 60000, NULL),
--     (4, 'Max', 90000, NULL)


SELECT 
    e.name
FROM manager as e
INNER JOIN manager as m
on e.managerId = m.id and 
    e.salary > m.salary