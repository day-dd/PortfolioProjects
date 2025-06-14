-- (source: https://www.datacamp.com/projects/1593)
-- The goal of the project is to examine whether international students have a higher risk of mental health difficulties than the general population, and whether social connectedness (belonging to a social group) and acculturative stress (stress associated with joining a new culture) are predictive of depression.
-- We will explore the students data using PostgreSQL to see if the length of stay is a contributing factor.
	
-- - Below is a description of the table we are working with:
-- Field Name	Description
-- inter_dom	Types of students (international or domestic)
-- japanese_cate	Japanese language proficiency
-- english_cate	English language proficiency
-- academic	Current academic level (undergraduate or graduate)
-- age	Current age of student
-- stay	Current length of stay in years
-- todep	Total score of depression (PHQ-9 test)
-- tosc	Total score of social connectedness (SCS test)
-- toas	Total score of acculturative stress (ASISS test)

-- --------------SQL queries--------------
SELECT stay, COUNT(*) AS count_int, ROUND(AVG(todep), 2) AS average_phq, ROUND(AVG(tosc), 2) AS average_scs, ROUND(AVG(toas), 2) AS average_as
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay DESC;
