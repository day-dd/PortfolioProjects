-- -- (source: https://www.datacamp.com/projects/1574)
-- The goal is to analyze sales data of a company that sells motorcycle parts, to gain a better understanding of wholesale revenue by product line, and how this varies month-to-month and across warehouses.

-- To-Dos:
-- Calculate net revenue for each product line
-- Group results by month and warehouse
-- Filter the results by only "Wholesale" orders

-- - Below is a description of the table "Sales" we are working with:
-- Column	Data_type	Description
-- order_number	VARCHAR	Unique order number.
-- date	DATE	Date of the order, from June to August 2021.
-- warehouse	VARCHAR	The warehouse that the order was made from— North, Central, or West.
-- client_type	VARCHAR	Whether the order was Retail or Wholesale.
-- product_line	VARCHAR	Type of product ordered.
-- quantity	INT	Number of products ordered.
-- unit_price	FLOAT	Price per product (dollars).
-- total	FLOAT	Total price of the order (dollars).
-- payment	VARCHAR	Payment method—Credit card, Transfer, or Cash.
-- payment_fee	FLOAT	Percentage of total charged as a result of the payment method.


-- --------------SQL queries--------------
SELECT product_line,
    CASE WHEN EXTRACT('month' from date) = 6 THEN 'June'
        WHEN EXTRACT('month' from date) = 7 THEN 'July'
        WHEN EXTRACT('month' from date) = 8 THEN 'August'
    END as month,
    warehouse,
	SUM(total) - SUM(payment_fee) AS net_revenue
FROM sales
WHERE client_type = 'Wholesale'
GROUP BY product_line, warehouse, month
ORDER BY product_line, month, net_revenue DESC
  
-- See the results in query_results.csv
