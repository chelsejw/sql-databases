
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

/*
====================================================================
LIKE AND ILIKE
=====================================================================
*/


/*
* DB: Employees
* Table: employees
* Question: Find the age of all employees who's name starts with M.
* Sample output: https://imgur.com/vXs4093
* Use EXTRACT (YEAR FROM AGE(birth_date)) we will learn about this in later parts of the course
*/
select emp_no, first_name, EXTRACT (YEAR FROM AGE(birth_date)) as "age"
from employees
where first_name
ilike 'g%';
/*
* DB: Employees
* Table: employees
* Question: How many people's name start with A and end with R?
* Expected output: 1846
*/
select count(first_name)
from employees
where first_name
ilike 'a%r';
                                                  
/*
* DB: Store
* Table: customers
* Question: How many people's zipcode have a 2 in it?.
* Expected output: 4211 
*/

select count(cast(zip as text))
from customers
where zip::text like '%2%';
/*
* DB: Store
* Table: customers
* Question: How many people's zipcode start with 2 with the 3rd character being a 1.
* Expected output: 109 
*/

select count(cast(zip as text))
from customers
where zip::text like '2_1%';
/*
* DB: Store
* Table: customers
* Question: Which states have phone numbers starting with 302?
* Replace null values with "No State"                                                  
* Expected output: https://imgur.com/AVe6G4c
*/
select coalesce(state, 'No State'), phone
from customers
where phone like '302%';

/*
====================================================================
DATE TIME
=====================================================================
*/

/*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/

select age(birth_date)
from employees
where age(birth_date::date) > interval '60 years';


/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/
select count(emp_no)
from employees
where extract(month from hire_date)='02'

/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/

select count(emp_no)
from employees
where extract(month from birth_date)='11'
/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee? (Use the analytical function MAX)
*/
select min(birth_date)
from employees; 

select max(age(birth_date)) from employees;

/*
* DB: Store
* Table: orders
* Question: How many orders were made in January 2004?
*/
select count(id)
from orders
where extract(year from orderdate)='2004'AND extract(month from orderdate)='01';
/*
====================================================================
DISTINCT
=====================================================================
*/

/*
* DB: Employees
* Table: titles
* Question: What unique titles do we have?
*/

select distinct title
from titles;

/*
* DB: Employees
* Table: employees
* Question: How many unique birth dates are there?
*/
select count(distinct birth_date)
from employees;
/*
* DB: World
* Table: country
* Question: Can I get a list of distinct life expectancy ages
* Make sure there are no nulls
*/
select distinct lifeexpectancy
from country
where lifeexpectancy is not null;

/*
====================================================================
SORTING
=====================================================================
*/
/*
* DB: Employees
* Table: employees
* Question: Sort employees by first name ascending and last name descending
*/

select first_name, last_name from employees
order by first_name, last_name desc;


/*
* DB: Employees
* Table: employees
* Question: Sort employees by age
*/

select first_name, last_name, age(birth_date) from employees
order by age(birth_date);


/*
* DB: Employees
* Table: employees
* Question: Sort employees who's name starts with a "k" by hire_date
*/
select first_name, last_name, hire_date
from employees
where first_name ilike 'k%'
order by hire_date;


/*
====================================================================
INNER JOINS
=====================================================================
*/

/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/

select a.orderid, a.orderdate, b.customerid, b.state
from orders as a
    inner join customers as b on a.customerid = b.customerid
where b.state IN ('NY', 'OH', 'OR')
order by a.orderid

/*
* DB: Store
* Table: products
* Question: Show me the inventory for each product
*/

select p.*, i.quan_in_stock
from inventory as i
    inner join products as p
    on i.prod_id = p.prod_id
/*
* DB: Employees
* Table: employees
* Question: Show me for each employee which department they work in
*/
select e.*, d.dept_name
from employees as e
    inner join dept_emp as j on e.emp_no = j.emp_no
    inner join departments d on d.dept_no = j.dept_no