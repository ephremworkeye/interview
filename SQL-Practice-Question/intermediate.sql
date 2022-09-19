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



