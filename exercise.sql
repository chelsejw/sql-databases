-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: Employees
 */
-- 


-- Question 1: What is the average salary for the company?
-- Table: Salaries
SELECT AVG(salary)
FROM salaries; --63810.744836143706

-- Question 2: What year was the youngest person born in the company?
-- Table: employees
SELECT MAX(birth_date)
FROM employees; -- 1965-02-01

-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: France
 */
-- 

-- Question 1: How many towns are there in france?
-- Table: Towns
SELECT COUNT(id)
FROM towns; --36684

-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: World
 */
-- 

-- Question 1: How many official languages are there?
-- Table: countrylanguage
SELECT COUNT(language)
FROM countrylanguage WHERE isofficial = true -- 238
-- Question 2: What is the average life expectancy in the world?
-- Table: country
SELECT AVG(lifeexpectancy)
FROM country; -- 66.48603611164265
-- Question 3: What is the average population for cities in the netherlands?
-- Table: city
select code
from country
WHERE name='Netherlands'; -- NLD


select AVG(population)
from city
WHERE countrycode='NLD'; -- 185001.750000000000


-- How many female customers do we have from the state of Oregon (OR)?
select count(gender)
from customers
where state='OR'; -- 220

-- -Who over the age of 44 has an income of 100 000 or more?

select *
from customers
where age=44 AND income >= 100000; --Count: 44

-- -Who between the ages of 30 and 50 has an income of less than 50 000?
select firstname, lastname, age, income
from customers
WHERE age > 30 AND age < 50 AND income < 50000;

-- What is the average income between the ages of 20 and 50?
select AVG(income)
from customers
WHERE age > 20 AND age < 50; --59409.926240780098