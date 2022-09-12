-- Create Table Countries
-- (
--  Country nvarchar(50),
--  City nvarchar(50)
-- )
-- GO

-- Insert into Countries values ('USA','New York')
-- Insert into Countries values ('USA','Houston')
-- Insert into Countries values ('USA','Dallas')

-- Insert into Countries values ('India','Hyderabad')
-- Insert into Countries values ('India','Bangalore')
-- Insert into Countries values ('India','New Delhi')

-- Insert into Countries values ('UK','London')
-- Insert into Countries values ('UK','Birmingham')
-- Insert into Countries values ('UK','Manchester')

SELECT *
FROM Countries



USE TSQLV4;

SELECT 
    TOP 5 *
FROM sales.OrderValues

GO
WITH c as (
SELECT 
    YEAR(orderdate) as orderyear,
    MONTH(orderdate) as ordermonth,
    --FORMAT(orderdate, 'MMM') as ordermonth,
    val
FROM Sales.OrderValues
)

SELECT 
    *
FROM c
PIVOT(SUM(val) FOR ordermonth 
    IN([7],[8],[9],[10],[11],[12], [1], [2],[3],[4],[5],[6]))as p
ORDER BY orderyear


SELECT DISTINCT productname from Production.Products
SELECT DISTINCT categoryname from Production.Categories
SELECT  DISTINCT empid from Sales.Orders

SELECT top 1 * FROM Sales.OrderValues
SELECT * FROM HR.Employees

GO
WITH cte AS(
SELECT 
    e.firstname + ' ' + e.lastname as fullname,
    ov.productname,
    YEAR(o.orderdate) as orderyear,
    ov.val
FROM HR.Employees as e
INNER JOIN Sales.Orders as o 
ON e.empid = o.empid
INNER JOin Sales.OrderValues as ov
ON o.orderid = ov.orderid
)

SELECT 
    *
FROM cte
PIVOT(SUM(val) FOR orderyear IN([2014], [2015], [2016]))as p
























