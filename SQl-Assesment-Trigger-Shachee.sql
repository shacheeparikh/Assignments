-- Create Database 
CREATE DATABASE try; 
USE try; 
 
CREATE TABLE employees ( 
Employee_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR (100), 
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE 
); 
 
CREATE TABLE employee_audit ( 
audit_id INT AUTO_INCREMENT PRIMARY KEY, 
employee_id INT, 
name VARCHAR 
(100), 
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE, 
action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 
 
INSERT INTO employees (name, position, salary, hire_date) VALUES ('John Doe', 
'Software Engineer', 80000.00, '2022-01-15'), 
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'), 
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

/*create a Trigger that will insert a record into the employee_audit table every time 
a new employee is added to the employee’s table: 
We have an employee’s table, and we want to create a stored procedure to add a 
new employee and automatically log this action in an 
employee_audit table.*/

DELIMITER //
CREATE PROCEDURE add_employee (in e_name varchar(100), in e_position varchar(100), in e_salary varchar(100), in e_hire_date date)
BEGIN
  INsert into employees  (name, position, salary, hire_date) values (e_name,e_position, e_salary, e_hire_date);
END //
DELIMITER ;

delimiter //
create trigger after_emp_insert after insert on employees for each row
begin
   insert into employee_audit(employee_id, name,position, action_date) values (new.employee_id,new.name,new.position,now());
   end //
   delimiter ;
   

call try.add_employee('shachee', 'QA engineer', '30000', '2023-02-02');
