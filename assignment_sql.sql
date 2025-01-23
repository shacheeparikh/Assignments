CREATE DATABASE MarketCo;

Use MarketCo;
-- 1) Statement to create the Contact table  
Create table Contact
(
ContactID int primary key,
CompanyID int,
FirstName varchar(45),
LastName Varchar(45),
Street Varchar(45),
City Varchar(45),
State Varchar(2),
Zip Varchar(10),
IsMain Boolean,
Email Varchar(45),
Phone Varchar(12)
);


 
-- 2) Statement to create the Employee table 
Create Table Employee
(
EmployeeID int primary key,
FirstName varchar(45),
LastName Varchar(45),
Salary Decimal(10,2),
HireDate date,
Jobtitle Varchar(45),
Email Varchar(45),
Phone Varchar(12)
);


Insert into employee VALUES(1,'shachee','parikh', 30000 , '2021-12-12','Quality Analyst','parikhshachee28@gmail.com','7990087844');

Insert into employee VALUES(2,'Lesley','band', 30000 , '2019-09-06',' Analyst','parikhshachee28@gmail.com','215-888-2345');

select * from employee;

-- 3) Statement to create the ContactEmployee table  
-- HINT: Use DATE as the datatype for ContactDate. It allows you to store the 
-- date in this format: YYYY-MM-DD (i.e., ‘2014-03-12’ for March 12, 2014).
Create Table ContactEmployee
(
ContactEmployeeID int primary key,
contactID int,
EmployeeID int,
ContactDate Date,
Descriptionn Varchar(100)
);

insert into Contact VALUES(1,1,'shachee','parikh', '1st street','New York', 'NY' , '92122',0,'shacheeparikh@gmail.com','79990087844');

-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800 
Update Employee 
set Phone='215-888-8800'
WHERE FirstName='Lesley';


Create Table Company 
(
CompanyID int primary key,
CompanyName varchar(45),
Street varchar(45),
city varchar(45),
state varchar(2),
zip varchar(10)
);

Insert into company values(1,'abcd.inc',' park ave','new york', 'NY', '92122');
Insert into company values(3,'urban outfitters, Inc',' park ave','new york', 'NY', '92122');

INSERT INTO Company (CompanyID, CompanyName, Street, City, State, Zip)
VALUES
(11, 'Tech Innovations', '123 Silicon Valley', 'San Jose', 'CA', '95131'),
(13, 'Green Solutions', '456 Maple Avenue', 'Austin', 'TX', '73301'),
(12, 'BlueWave Technologies', '789 Ocean Drive', 'Miami', 'FL', '33101'),
(4, 'Smart Homes Inc.', '321 Elm Street', 'Seattle', 'WA', '98101'),
(5, 'Foodie Express', '654 Pine Lane', 'Chicago', 'IL', '60610'),
(6, 'Bright Future Corp.', '987 Birch Boulevard', 'Denver', 'CO', '80203'),
(7, 'HealthCare Partners', '111 Oak Road', 'New York', 'NY', '10001'),
(8, 'Auto World', '333 Auto Drive', 'Detroit', 'MI', '48201'),
(9, 'Cyber Security Solutions', '444 Tech Park', 'Boston', 'MA', '02110'),
(10, 'Global Consulting', '555 Corporate Plaza', 'Los Angeles', 'CA', '90001');

-- 5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” . 

Update Company set CompanyName='Urban Outfitters' where CompanyName='Urban_outfitters';

-- 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement).
-- HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove.
delete from contactemployee where ContactEmployeeID = 1;

select * from contactemployee;
insert into contactemployee values(2,1,2,'2023-09-06', 'shachee parikh & lesley band');
select * from contact;
select * from employee;
update contactemployee set Descriptionn='shachee and lesley' where ContactEmployeeID=2;


-- 7) Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). 
-- Run the SQL SELECT query in MySQL Workbench. Copy the results below as well. 
select * from company;
update company set companyName='Toll brothers' where companyID=8;
select e.FirstName , e.LastName from company c Join contact ct on c.companyid=ct.companyid join contactemployee ce on 
ct.contactid=ce.contactid   join employee e on ce.employeeid=e.employeeid  where c.companyname='Toll brothers';

select * from contact;
select * from employee;
select * from company;
select * from contactemployee;



/*8) What is the significance of “%” and “_” operators in the LIKE statement?
The % wildcard represents zero or more characters. It matches any sequence of characters, including an empty string.
For example:
SELECT * FROM employees WHERE name LIKE 'J%';
This will match any name that starts with the letter "J" (e.g., "John", "James", "Jill").
SELECT * FROM products WHERE code LIKE '%123';

9) Explain normalization in the context of databases.
Normalization in the context of databases refers to the process of organizing data within a database to reduce redundancy and improve data
 integrity. The goal is to ensure that the database is structured efficiently, minimizing the chances of anomalies like data duplication, 
 update anomalies, and deletion anomalies.
Normalization involves dividing large tables into smaller, more manageable ones and defining relationships between them. This is done through
 a series of stages, called normal forms, each with specific rules designed to eliminate different types of redundancy and dependency issues.

10) What does a join in MySQL mean?
n MySQL, a JOIN is a SQL operation used to combine rows from two or more tables based on a related column between them. This operation allows
 you to query data from multiple tables in a single query, facilitating more complex data retrieval.
 
11) What do you understand about DDL, DCL, and DML in MySQL?
In MySQL (and relational databases in general), SQL (Structured Query Language) commands are categorized into different types based on 
their function. The most common categories are DDL (Data Definition Language), DCL (Data Control Language), 
and DML (Data Manipulation Language). Each of these categories serves a distinct purpose in managing and interacting with the database.
1. DDL (Data Definition Language)
DDL commands are used to define and manage the structure of the database, tables, schemas, and other database objects. These commands do 
not manipulate data directly, but they modify the database schema itself.
CREATE: Used to create a new database object (e.g., CREATE TABLE, CREATE DATABASE).
ALTER: Used to modify an existing database object (e.g., ALTER TABLE to add or remove columns).
DROP: Used to delete a database object (e.g., DROP TABLE, DROP DATABASE).
TRUNCATE: Deletes all rows from a table but retains the structure (faster than DELETE).

DCL (Data Control Language) is used to control access to the database by granting or revoking permissions.

Common DCL Commands:

GRANT: Provides specific permissions to users (e.g., GRANT SELECT ON database.table TO 'user'@'localhost';).
REVOKE: Removes permissions from users (e.g., REVOKE SELECT ON database.table FROM 'user'@'localhost';).

DML (Data Manipulation Language)
DML is used to interact with and manipulate the data within database tables.

Common DML Commands:

SELECT: Retrieves data from tables.
INSERT: Adds new records to a table.
UPDATE: Modifies existing records in a table.
DELETE: Removes records from a table.


12) What is the role of the MySQL JOIN clause in a query, and what are some
common types of joins? 
In MySQL, the JOIN clause is essential for combining rows from two or more tables based on a related column between them. This operation allows for the retrieval of comprehensive datasets 
by linking tables through their relationships, facilitating more complex and informative queries.

Common Types of Joins:

INNER JOIN: Retrieves records with matching values in both tables. If there's no match, the rows are excluded. 
This is the most frequently used join. 

Example:
SELECT employees.name, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

LEFT JOIN (LEFT OUTER JOIN): Returns all records from the left table and the matched records from the right table. If there's no match, 
the result is NULL on the side of the right table.
Example:
SELECT employees.name, departments.department_name
FROM employees
left JOIN departments ON employees.department_id = departments.department_id;

RIGHT JOIN (RIGHT OUTER JOIN): Returns all records from the right table and the matched records from the left table. If there's no match, 
the result is NULL on the side of the left table.
SELECT employees.name, departments.department_name
FROM employees
RIGHT JOIN departments ON employees.department_id = departments.department_id;

CROSS JOIN: Returns the Cartesian product of the two tables, meaning it combines all rows from the first table with all rows from the second table. 
This type of join does not require any condition. 
SELECT employees.name, departments.department_name
FROM employees
CROSS JOIN departments;

A self-join is a regular join but the table is joined with itself. 
It's useful for hierarchical data or comparing rows within the same table. 
SELECT e1.name AS Employee, e2.name AS Manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;
*/