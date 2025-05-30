-- (source: https://www.datacamp.com/projects/1906)
-- In this project, we are going to analyze international debt data collected by The World Bank. The dataset contains information about the amount of debt (in USD) owed by developing countries across several categories.
-- The project goal is to find the answers to the following questions:

-- - 1) What is the number of distinct countries present in the database?
-- - 2) What country has the highest amount of debt?
-- - 3) What country has the lowest amount of repayments?

-- - Below is a description of the table we are working with:

-- international_debt table
-- Column	| Definition | Data Type
-- country_name	| Name of the country	| varchar
-- country_code	| Code representing the country	| varchar
-- indicator_name	| Description of the debt indicator	| varchar
-- indicator_code	| Code representing the debt indicator	| varchar
-- debt	| Value of the debt indicator for the given country (in current US dollars)	| float


-- --------------SQL queries--------------
-- 1) What is the number of distinct countries present in the database?
SELECT COUNT(DISTINCT country_name) AS total_distinct_countries
FROM international_debt;
-- Answer: 124
-- index	total_distinct_countries
-- 0	124


-- - 2) What country has the highest amount of debt?
SELECT country_name, SUM(debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY SUM(debt) DESC
LIMIT 1;
-- Answer: China
-- index	country_name	total_debt
-- 0	China	285793494734.2


-- - 3) What country has the lowest amount of repayments?
SELECT country_name, indicator_name, SUM(debt) AS lowest_repayment
FROM international_debt
WHERE indicator_code = 'DT.AMT.DLXF.CD'
GROUP BY country_name, indicator_name
ORDER BY lowest_repayment ASC
LIMIT 1;
-- Answer: Timor-Leste
-- index	country_name	indicator_name	lowest_repayment
-- 0	Timor-Leste	Principal repayments on external debt, long-term (AMT, current US$)	825000


