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






