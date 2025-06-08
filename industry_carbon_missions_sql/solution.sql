-- (source: https://www.datacamp.com/projects/1590)
-- The data is stored in a PostgreSQL database containing one table, product_emissions, and contains product carbon footprints (PCFs) for various companies.
-- To-Dos:
-- - find the number of unique companies and their total carbon footprint PCF for each industry group,
-- - filtering for the most recent year in the database. 
-- - return three columns: industry_group, num_companies, and total_industry_footprint, 
-- - round the last column to one decimal place
-- - sort results by total_industry_footprint from highest to lowest values.

-- - Below is a description of the table we are working with:
-- field	data_type
-- id	VARCHAR
-- year	INT
-- product_name	VARCHAR
-- company	VARCHAR
-- country	VARCHAR
-- industry_group	VARCHAR
-- weight_kg	NUMERIC
-- carbon_footprint_pcf	NUMERIC
-- upstream_percent_total_pcf	VARCHAR
-- operations_percent_total_pcf	VARCHAR
-- downstream_percent_total_pcf	VARCHAR

SELECT industry_group,
	COUNT(DISTINCT company) AS num_companies,
	ROUND(SUM(carbon_footprint_pcf), 1) AS total_industry_footprint
FROM product_emissions
WHERE year IN (SELECT MAX(year) FROM product_emissions)
GROUP BY industry_group
ORDER BY total_industry_footprint DESC;

