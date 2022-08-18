-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+

-- CREATE Table highest(
--     id INT,
--     salary int
-- )

-- INSERT into highest VALUES(1, 100), (2, 200), (3, 300)
-- INSERT into highest VALUES(5, 50),(6, 150)
-- with cte as(
-- SELECT
--     id, salary,
--     DENSE_RANK() OVER(ORDER BY salary DESC) as rn
-- FROM highest)
-- SELECT 
--     CASE when datalength(salary) = 0 THEN null 
--     ELSE salary end highests
-- from cte
-- where rn = 4
-- order by salary desc

--use test3


--select * from highest
-- select max(salary)
-- from highest WHERE salary < (
--     select max(salary) from highest where salary < (
--         select max(salary) from highest
--     )
-- )
-- SELECT
--     min(salary)
-- FROM highest
-- where salary in
-- (SELECT distinct salary
-- from highest 
-- ORDER BY salary desc 
-- OFFSET 0 ROWS fetch first 3 rows only)


SELECT min(salary)
FROM (
    SELECT distinct top 10 salary from highest order by salary DESC
) res