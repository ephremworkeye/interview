-- 180. Consecutive Numbers
-- Medium

-- 1206

-- 207

-- Add to List

-- Share
-- SQL Schema
-- Table: Logs

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- id is the primary key for this table.
-- id is an autoincrement column.
 

-- Write an SQL query to find all numbers that appear at least three times consecutively.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Logs table:
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- Output: 
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.


--solution 1 using self join three 2 times

use test3;
SELECT a.num as ConsecutiveNums
FROM Logs as a
INNER JOIN Logs as b
ON a.id = b.id + 1 and a.num = b.num
INNER JOIN Logs as c
ON a.id = c.id+2 and a.num = c.num

--soltuion 2 using window function lead two times
GO
WITH cte AS(
SELECT
    num, 
    LEAD(num, 1) OVER(ORDER BY id) as next1, 
    LEAD(num, 2) OVER(ORDER BY id) as next2
FROM Logs)
SELECT num as ConsecutiveNums from cte 
where num = next1 and next1 = next2
