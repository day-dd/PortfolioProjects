-- The goal of the project is to use joining and data manipulation to better understand the world's oldest businesses.
-- We will work with 4 tables: buisness, new_businesses, countries, categories

-- Questions to answer:
-- 1) What's the oldest business on each continent?
-- 2) How many countries per continent lack data on the oldest businesses?
-- 3) Does including the `new_businesses` data change this?
-- 4) Which business categories are best suited to last over the course of centuries?

-- 1) What's the oldest business on each continent?
SELECT bc.continent, bc.business, bc.year_founded, bc.country
FROM (
    SELECT business, year_founded, country, continent
    FROM businesses
    JOIN countries USING (country_code)
) bc
JOIN (SELECT continent, MIN(year_founded) AS year_founded
    FROM businesses
    JOIN countries 
    USING (country_code)
    GROUP BY continent
) c 
ON bc.continent = c.continent AND bc.year_founded = c.year_founded

-- Answer 1:
-- continent	business	year_founded	country
-- Oceania	Australia Post	1809	Australia
-- Europe	St. Peter Stifts Kulinarium	803	Austria
-- Asia	Kongō Gumi	578	Japan
-- North America	La Casa de Moneda de México	1534	Mexico
-- Africa	Mauritius Post	1772	Mauritius
-- South America	Casa Nacional de Moneda	1565	Peru

-- 2) How many countries per continent lack data on the oldest businesses? 
-- 3) Does including the `new_businesses` data change this?
SELECT c.continent, COUNT(c.country_code) AS countries_without_businesses
FROM countries c
LEFT JOIN (
    SELECT * FROM businesses
  -- 3) Does including the `new_businesses` data change this? 
    UNION ALL
    SELECT * FROM new_businesses
) b
ON c.country_code = b.country_code
WHERE b.business IS NULL
GROUP BY c.continent;

-- Answer 2: 
-- continent	countries_without_businesses
-- Africa 3
-- Asia	7
-- Europe	2
-- North America	6
-- Oceania	11
-- South America	3

-- Answer 3:
-- yes, it reduces the number of countries without businesses for North America and Oceania

-- Which business categories are best suited to last over the course of centuries on each continent?
SELECT cat.category, c.continent, MIN(b.year_founded) AS year_founded
FROM businesses b
INNER JOIN categories cat ON b.category_code = cat.category_code
INNER JOIN countries c ON b.country_code = c.country_code
GROUP BY cat.category, c.continent
ORDER BY cat.category, year_founded, c.continent
LIMIT 10;

-- Answer 4:
-- (the answer here contains the top 10 rows out of 56)
-- category	continent	year_founded
-- Agriculture	Europe	1218
-- Agriculture	North America	1638
-- Agriculture	Asia	1930
-- Agriculture	Africa	1947
-- Aviation & Transport	Africa	1854
-- Aviation & Transport	Asia	1858
-- Aviation & Transport	North America	1870
-- Banking & Finance	South America	1565
-- Banking & Finance	Europe	1606
-- Banking & Finance	Asia	1830



