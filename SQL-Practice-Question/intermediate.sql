USE Northwind;
-- 21. In the Customers table, show the total number of customers per Country and City.

SELECT
    Country,
    City,
    COUNT(*) as TotalCustomers
FROM Customers
GROUP BY   Country, City
ORDER by TotalCustomers DESC

--22. Products that need reordering

SELECT 
    ProductID,
    ProductName,
    UnitsInStock,
    ReorderLevel 
FROM Products
WHERE UnitsInStock < ReorderLevel


-- 23. Products that need reordering, continued

SELECT 
    ProductID,
    ProductName,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel, 
    Discontinued
FROM Products
WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel AND Discontinued = 0


-- 24. Customer list by region

with cte as(
SELECT  
    CustomerID, 
    CompanyName, 
    Region,
    CASE when Region is NULL THEN 1 ELSE 0 End as flg
FROM Customers

)

SELECT 
    CustomerID, CompanyName, Region, flg
from cte
ORDER BY flg, Region, CustomerID

--another method

SELECT  
    CustomerID, 
    CompanyName, 
    Region
FROM Customers
ORDER BY 
    CASE when Region is NULL then 1 ELSE 0 end, 
    Region,
    CustomerID

--order by productName first when productName starts with letter 'F'
SELECT 
    ProductId,
    ProductName
from Products
ORDER BY CASE when ProductName like 'F%' then 0 else 1 end


-- 25. High freight charges

SELECT
    top 3 ShipCountry,
    AVG(Freight) as totalFreight
from orders
GROUP BY ShipCountry
order by totalFreight DESC

--26. High freight charges - 2015


SELECT
    top 3 ShipCountry,
    AVG(Freight) as totalFreight
from orders
where YEAR(OrderDate) = 2015
GROUP BY ShipCountry
order by totalFreight DESC


Select 
    Top 3 ShipCountry,
    AverageFreight = avg(freight) 
From Orders 
--Where OrderDate between '1/1/2015' and '12/31/2015' 
Where OrderDate >= '1/1/2015' and OrderDate <= '12/31/2015' 
Group By ShipCountry 
Order By AverageFreight desc

SELECT 
    OrderID, OrderDate, ShipCountry, Freight
FROM orders ORDER BY OrderDate




--41. Late orders Some customers are complaining about their orders arriving late. Which orders are late?


SELECT
    OrderId,
    CONVERT(date, OrderDate) AS OrderDate,  
    CONVERT(date, RequiredDate) AS RequiredDate,
    CONVERT(date, ShippedDate) AS ShippedDate
FROM Orders
WHERE RequiredDate <= ShippedDate


-- 42. Late orders - which employees? Some salespeople have more orders arriving late than others.
-- Maybe they're not following up on the order process, and need more training. Which salespeople 
--have the most orders arriving late?

 SELECT 
    e.EmployeeID,
    e.LastName,
    COUNT(o.OrderID) AS TotalLateOrders
 FROM Employees AS e
 INNER JOIN Orders AS o 
 ON e.EmployeeID = o.EmployeeID
 WHERE o.RequiredDate <= o.ShippedDate 
 GROUP BY e.EmployeeID, e.LastName
 ORDER BY TotalLateOrders DESC


--  43. Late orders vs. total orders Andrew, the VP of sales, has been doing some more thinking 
--  some more about the problem of late orders. He realizes that just looking at the number of 
--  orders arriving late for each salesperson isn't a good idea. It needs to be compared against 
--  the total number of orders per salesperson. Return results like the following:


SELECT
    e.EmployeeID,
    e.LastName, 
    COUNT(o.OrderID) AS TotalOrders,
    COUNT(CASE WHEN o.RequiredDate <= o.ShippedDate THEN 1 ELSE NULL END) AS TotalLateOrders
FROM Employees AS e INNER JOIN Orders AS o 
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.LastName
--HAVING COUNT(CASE WHEN o.RequiredDate <= o.ShippedDate THEN 1 ELSE NULL END) > 0
ORDER BY e.EmployeeID

--with second method using two cte's

GO;

WITH totalOrders AS (
    SELECT
        o.EmployeeID, 
        COUNT(*) AS TotalOrders
    FROM Orders AS o
    GROUP BY o.EmployeeID
), lateOrders AS (
    SELECT
        o.EmployeeID, 
        COUNT(*) AS LateOrders
    FROM Orders AS o
    WHERE o.RequiredDate <= o.ShippedDate
    GROUP BY o.EmployeeID
 )

SELECT
    e.EmployeeID, 
    e.LastName, 
    t.TotalOrders, 
    l.LateOrders
FROM Employees AS e
INNER JOIN totalOrders as t 
    ON e.EmployeeID = t.EmployeeID
INNER JOIN lateOrders as l 
    ON t.EmployeeID = l.EmployeeID


-- 44. Late orders vs. total orders - missing employee There's an employee missing in the answer 
-- from the problem above. Fix the SQL to show all employees who have taken orders.

GO;
WITH totalOrders AS (
    SELECT
        o.EmployeeID, 
        COUNT(*) AS TotalOrders
    FROM Orders AS o
    GROUP BY o.EmployeeID
), lateOrders AS (
    SELECT
        o.EmployeeID, 
        COUNT(*) AS LateOrders
    FROM Orders AS o
    WHERE o.RequiredDate <= o.ShippedDate
    GROUP BY o.EmployeeID
 )

SELECT
    e.EmployeeID, 
    e.LastName, 
    t.TotalOrders, 
    l.LateOrders
FROM Employees AS e
INNER JOIN totalOrders as t 
    ON t.EmployeeID = e.EmployeeID
LEFT JOIN lateOrders as l 
    ON e.EmployeeID = l.EmployeeID


-- 45. Late orders vs. total orders - fix null Continuing on the answer for above query, 
-- let's fix the results for row 5 - Buchanan. He should have a 0 instead of a Null in LateOrders.

GO;
WITH totalOrders AS (
    SELECT
        o.EmployeeID, 
        COUNT(*) AS TotalOrders
    FROM Orders AS o
    GROUP BY o.EmployeeID
), lateOrders AS (
    SELECT
        o.EmployeeID, 
        COUNT(*) AS LateOrders
    FROM Orders AS o
    WHERE o.RequiredDate <= o.ShippedDate
    GROUP BY o.EmployeeID
 )

SELECT
    e.EmployeeID, 
    e.LastName, 
    t.TotalOrders, 
    CASE WHEN l.LateOrders IS NULL THEN 0 ELSE l.LateOrders END AS LateOrders
FROM Employees AS e
INNER JOIN totalOrders as t 
    ON t.EmployeeID = e.EmployeeID
LEFT JOIN lateOrders as l 
    ON e.EmployeeID = l.EmployeeID


-- 46. Late orders vs. total orders - percentage Now we want to get the percentage of late orders 
-- over total orders.

GO;
WITH cte AS(
    SELECT
        e.EmployeeID, 
        e.LastName,
        COUNT(*) AS TotalOrders,
        COUNT(CASE WHEN o.RequiredDate <= o.ShippedDate THEN 1 ELSE NULL END) AS LateOrders 
    FROM Employees AS e 
    INNER JOIN Orders AS o 
    ON e.EmployeeID = o.EmployeeID
    GROUP BY    e.EmployeeID, e.LastName
)
SELECT 
    EmployeeID, 
    LastName, 
    TotalOrders, 
    LateOrders,
    CONVERT(DECIMAL(10, 2), LateOrders  * 1.00/ TotalOrders) AS percentagVal
FROM cte



-- 48. Customer grouping Andrew Fuller, the VP of sales at Northwind, would like to do a 
-- sales campaign for existing customers. He'd like to categorize customers into groups, 
-- based on how much they ordered in 2016. Then, depending on which group the customer is in, 
-- he will target the customer with different sales materials. The customer grouping categories
--  are 0 to 1,000, 1,000 to 5,000, 5,000 to 10,000, and over 10,000. A good starting point for 
--  this query is the answer from the problem “High-value customers - total orders. We don’t want 
--  to show customers who don’t have any orders in 2016. Order the results by CustomerID.

GO;
WITH cte AS (

SELECT
    c.CustomerID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) as TotalSales
FROM Customers AS c 
INNER JOIN Orders AS o 
ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails as od 
on o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 2016
GROUP BY  c.CustomerID, c.CompanyName
)
SELECT 
    CustomerID,
    CompanyName,
    TotalSales,
    CASE WHEN TotalSales >= 10000 THEN 'Very High' 
        WHEN TotalSales >= 5000 AND TotalSales < 10000 THEN 'High'
        WHEN TotalSales >= 1000 AND TotalSales < 5000 THEN 'Medium'
        WHEN TotalSales >= 0 AND TotalSales < 1000 THEN 'Low'
        END AS customerGroup
FROM cte
ORDER BY CustomerID


-- WE CAN SOLVE THIS PROBLEM WIHT OUT USING CTE

SELECT
    C.CustomerID,
    C.CompanyName,
    SUM(OD.UnitPrice * OD.Quantity) AS TotalSales,
    CASE 
        WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 0 AND 1000 THEN 'Low'
        WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 1000 AND 5000 THEN 'Medium'
        WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 5000 AND 10000 THEN 'High'
        WHEN SUM(OD.UnitPrice * OD.Quantity) > 10000 THEN 'Very High'
        END AS customerGroup
FROM Customers AS C
INNER JOIN Orders AS O 
ON C.CustomerID = O.CustomerID
INNER JOIN OrderDetails AS OD 
ON O.OrderID = OD.OrderID 
WHERE o.OrderDate > '20160101' AND o.OrderDate < '20170101'
GROUP BY c.CustomerID, c.CompanyName


-- 50. Customer grouping with percentage Based on the above query, show all the defined 
-- CustomerGroups, and the percentage in each. Sort by the total in each group, 
-- in descending order.
GO

;WITH cte as(
    SELECT
        C.CustomerID,
        C.CompanyName,
        SUM(OD.UnitPrice * OD.Quantity) AS TotalSales,
        CASE 
            WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 0 AND 1000 THEN 'Low'
            WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 1000 AND 5000 THEN 'Medium'
            WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 5000 AND 10000 THEN 'High'
            WHEN SUM(OD.UnitPrice * OD.Quantity) > 10000 THEN 'Very High'
            END AS customerGroup
    FROM Customers AS C
    INNER JOIN Orders AS O 
    ON C.CustomerID = O.CustomerID
    INNER JOIN OrderDetails AS OD 
    ON O.OrderID = OD.OrderID 
    WHERE o.OrderDate > '20160101' AND o.OrderDate < '20170101'
    GROUP BY c.CustomerID, c.CompanyName
)
,cte2 as(
SELECT 
    customerGroup,
    COUNT(*) AS TotalInGroup
FROM cte
GROUP BY customerGroup
)
SELECT
    customerGroup,
    TotalInGroup, 
    TotalInGroup * 1.00 / SUM(TotalInGroup) OVER()  AS percentangInGroup
FROM cte2
ORDER BY TotalInGroup DESC


-- anther solution without multiplle cte
GO

;WITH cte as(
    SELECT
        C.CustomerID,
        C.CompanyName,
        SUM(OD.UnitPrice * OD.Quantity) AS TotalSales,
        CASE 
            WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 0 AND 1000 THEN 'Low'
            WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 1000 AND 5000 THEN 'Medium'
            WHEN SUM(OD.UnitPrice * OD.Quantity) BETWEEN 5000 AND 10000 THEN 'High'
            WHEN SUM(OD.UnitPrice * OD.Quantity) > 10000 THEN 'Very High'
            END AS customerGroup
    FROM Customers AS C
    INNER JOIN Orders AS O 
    ON C.CustomerID = O.CustomerID
    INNER JOIN OrderDetails AS OD 
    ON O.OrderID = OD.OrderID 
    WHERE o.OrderDate > '20160101' AND o.OrderDate < '20170101'
    GROUP BY c.CustomerID, c.CompanyName
)

SELECT
    customerGroup,
    COUNT(*) AS totalInGroup, 
    COUNT(*) * 1.00 / (SELECT count(*) from cte) AS percentageInGroup
FROM cte
GROUP BY customerGroup
ORDER BY TotalInGroup DESC

-- 52. Countries with suppliers or customers Some Northwind employees are planning a business trip, 
-- and would like to visit as many suppliers and customers as possible. For their planning, they’d
--  like to see a list of all countries where suppliers and/or customers are based.


SELECT Country
FROM Suppliers
UNION
SELECT Country
FROM Customers
ORDER BY Country


-- 53. Countries with suppliers or customers, version 2 The employees going on the business trip 
-- don’t want just a raw list of countries, they want more details. We’d like to see output like
--  the below, in the Expected Results.
go
;WITH customerCte as(
SELECT distinct Country
FROM Customers AS C
)
,supplierCte as(
    SELECT distinct Country
    FROM Suppliers
)
select * FROM customerCte as c FULL OUTER JOIN supplierCte as s ON c.Country = s.Country


SELECT distinct c.Country, s.Country
FROM Customers as c full join Suppliers as s  on c.Country = s.Country
group by c.Country, s.Country
































