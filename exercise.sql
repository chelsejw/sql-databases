
/*

====================================================================
BASIC SELECTS
=====================================================================

*/

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

/*

====================================================================
OPERATORS / FUNCTIONS
=====================================================================

*/




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


/*

====================================================================
OPERATOR PRECEDENCE
=====================================================================

*/


/*
* DB: Store
* Table: Customers
* Question: 
* Select people either under 30 or over 50 with an income above 50000
* Include people that are 50
* that are from either Japan or Australia
*/


select * from customers where (age < 30 OR age >= 50) AND income > 50000 AND (country='Japan' OR country='Australia');

-- 868 rows


/*
* DB: Store
* Table: Orders
* Question: 
* What was our total sales in June of 2004 for orders over 100 dollars?
*/

select SUM(totalamount)
from orders
WHERE (orderdate >= '2004-06-01' AND orderdate <='2004-06-30') AND totalamount > 100;

-- 205226.06

/*
====================================================================
NULL VALUES
=====================================================================
*/


/*
* DB: https://www.db-fiddle.com/f/PnGNcaPYfGoEDvfexzEUA/0
* Question: 
* Assuming a students minimum age for the class is 15, what is the average age of a student?
*/
SELECT AVG(coalesce(age, 15))
from "Student"; -- 30.4

/*
* DB: https://www.db-fiddle.com/f/PnGNcaPYfGoEDvfexzEUA/0
* Question: 
* Replace all empty first or last names with a default?
*/
SELECT coalesce(name, 'First Name'), coalesce(lastName, 'Last Name')
FROM "Student";


/*
====================================================================
3 VALUED LOGIC  
=====================================================================
*/


/*
* DB: Store
* Table: customers
* Question: adjust the following query to display the null values as "No Address"
*/
SELECT firstname, lastname, address1, coalesce(address2, 'No Address')
FROM customers;


/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/

SELECT *
FROM customers
WHERE address2 IS NOT null;


/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/


SELECT coalesce(lastName, 'Empty'), *
from customers
where (age IS NULL);

/*
====================================================================
BETWEEN AND
=====================================================================
*/


-- Who between the ages of 30 and 50 has an income less than 50 000?
-- (include 30 and 50 in the results)

/*
* Write your query here
*/
select firstname, lastname, age, income
from customers
where age between 30 and 50 AND income < 50000;


-- What is the average income between the ages of 20 and 50? (Including 20 and 50)
/*
* Write your query here
*/

select avg(income)
from customers
where age between 20 and 50; --59361.925908612832