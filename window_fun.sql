use TSQLV4;

GO
WITH CTE AS (
SELECT 
    custid, 
    YEAR(orderdate) AS ORDERYEAR,
    SUM(val) AS TOTAL
FROM Sales.OrderValues
WHERE custid IN (3, 4, 5)
GROUP BY custid, YEAR(orderdate)
--ORDER BY custid, ORDERYEAR
)

SELECT 
    custid,
    ORDERYEAR,
    SUM(TOTAL) OVER() AS ALLSALES,
    TOTAL,
    LAG(TOTAL) OVER(PARTITION BY CUSTID ORDER BY ORDERYEAR) AS PREVIOUS,
    LEAD(TOTAL) OVER(PARTITION BY CUSTID ORDER BY ORDERYEAR) AS NEXT,
    (TOTAL - LAG(TOTAL) OVER(PARTITION BY CUSTID ORDER BY ORDERYEAR)) /TOTAL * 100 AS YOY, 
    SUM(TOTAL) OVER(PARTITION BY CUSTID ORDER BY ORDERYEAR ROWS UNBOUNDED PRECEDING) AS RT
    
FROM CTE
ORDER BY CUSTID, ORDERYEAR

SELECT
* FROM Sales.EmpOrders


use test3;

select * from dup
INTERSECT 
select * from dup