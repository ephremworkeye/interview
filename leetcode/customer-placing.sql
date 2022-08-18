-- Orders table:
-- +--------------+-----------------+
-- | order_number | customer_number |
-- +--------------+-----------------+
-- | 1            | 1               |
-- | 2            | 2               |
-- | 3            | 3               |
-- | 4            | 3               |
-- +--------------+-----------------+
-- Output: 
-- +-----------------+
-- | customer_number |
-- +-----------------+
-- | 3               |
-- +-----------------+


-- CREATE TABLE cust_order (
--     order_number INT PRIMARY KEY,
--     customer_number INT
-- )

-- INSERT INTO cust_order VALUES (1, 1), (2, 2), (3, 3), (4, 3)

-- SELECT * FROM cust_order
-- WITH cte AS(
-- SELECT 
--     order_number,
--     customer_number,
--     ROW_NUMBER() OVER(PARTITION BY customer_number ORDER BY order_number) as rn

-- FROM cust_order)

-- SELECT top 1 customer_number
-- FROM cte 
-- ORDER BY rn desc

-- SELECT top 1 d.customer_number FROM(
-- SELECT 
--     customer_number, count(customer_number) as ct
-- FROM cust_order
-- group by customer_number
-- ) AS d
-- order by d.ct DESC
