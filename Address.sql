-- DATABASE CREATION
CREATE DATABASE IF NOT EXISTS addressbook;
USE addressbook;

-- DROP TABLES IF EXIST (clean slate)
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS employee_data;
DROP TABLE IF EXISTS employee_per;

-- MAIN EMPLOYEE DATA TABLE
CREATE TABLE employee_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    title VARCHAR(100),
    age INT,
    yos INT,
    salary DECIMAL(10,2),
    perks DECIMAL(10,2),
    email VARCHAR(100) UNIQUE
);

-- INSERT EMPLOYEES (employee_data)
INSERT INTO employee_data (f_name, l_name, title, age, yos, salary, perks, email) VALUES
('Rudolf', 'Reindeer', 'Business Analyst', 34, 2, 95000, 17000, 'rudolf@bugnet.com'),
('Manish', 'Patel', 'HR Specialist', 29, 3, 62000, 8000, 'manish.patel@bugnet.com'),
('Alok', 'Peters', 'Sales Associate', 31, 4, 58000, 5000, 'alok.peters@bugnet.com'),
('Sarah', 'Lopez', 'Marketing Manager', 38, 10, 88000, 15000, 'sarah.lopez@bugnet.com'),
('Kelly', 'Ramos', 'Marketing Analyst', 26, 1, 54000, 6000, 'kelly.ramos@bugnet.com'),
('Anika', 'Singh', 'Accountant', 27, 2, 50000, 4000, 'anika.singh@bugnet.com'),
('Mark', 'Brown', 'Support Engineer', 33, 5, 67000, 7000, 'mark.brown@bugnet.com'),
('David', 'Stone', 'Programmer', 30, 4, 72000, 9000, 'david.stone@bugnet.com'),
('Jessica', 'Wu', 'Senior Programmer', 41, 12, 105000, 20000, 'jessica.wu@bugnet.com'),
('Brandon', 'Morris', 'Multimedia Programmer', 28, 3, 81000, 7000, 'brandon.morris@bugnet.com'),
('Helen', 'Cruz', 'Project Coordinator', 32, 7, 69000, 8000, 'helen.cruz@bugnet.com'),
('Carlos', 'Diaz', 'Operations Supervisor', 40, 11, 76000, 9000, 'carlos.diaz@bugnet.com'),
('Maria', 'Gomez', 'Data Analyst', 35, 6, 83000, 7500, 'maria.gomez@bugnet.com'),
('Liam', 'Turner', 'Web Designer', 25, 2, 61000, 5000, 'liam.turner@bugnet.com'),
('Anamika', 'Pandit', 'Web Developer', 24, 1, 55000, 5000, 'anamika.pandit@bugnet.com');

-- EXERCISE 14 UPDATES
UPDATE employee_data
SET l_name = 'Sharma'
WHERE f_name = 'Anamika' AND l_name = 'Pandit';

UPDATE employee_data
SET title = 'Multimedia Specialist'
WHERE title = 'Multimedia Programmer';

UPDATE employee_data
SET salary = salary + 10000
WHERE NOT (f_name = 'Rudolf' AND l_name = 'Reindeer');

-- EMPLOYEE PERSONAL TABLE (birth dates & spouse)
CREATE TABLE employee_per (
    e_id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(50),
    l_name VARCHAR(50),
    birth_date DATE,
    spouse_name VARCHAR(100) DEFAULT NULL
);

-- INSERT EMPLOYEE PERSONAL DATA
INSERT INTO employee_per (f_name, l_name, birth_date, spouse_name) VALUES
('Rudolf', 'Reindeer', '1972-03-16', 'Clarice Reindeer'),
('Manish', 'Patel', '1969-02-05', 'Rani Patel'),
('Alok', 'Peters', '1976-12-31', 'Jenny Peters'),
('Sarah', 'Lopez', '1970-05-08', 'Miguel Lopez'),
('Kelly', 'Ramos', '1971-10-29', 'Adrian Ramos'),
('Anika', 'Singh', '1973-01-09', 'Rahul Singh'),
('Mark', 'Brown', '1964-09-20', 'Diana Brown'),
('David', 'Stone', '1980-11-03', 'Emily Stone'),
('Jessica', 'Wu', '1972-03-30', 'Henry Wu'),
('Brandon', 'Morris', '1962-12-11', 'Lisa Morris');

-- INTEGRATED EMPLOYEE TABLE (for NULL exercises)
CREATE TABLE employee (
    id INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    sex CHAR(1),
    birth DATE,
    email VARCHAR(100),
    spouse VARCHAR(100) DEFAULT NULL,
    children INT DEFAULT NULL
);

-- INSERT DATA (for NULL exercises)
INSERT INTO employee VALUES
(1, 'Daniel', 'Reyes', 'M', '1991-04-21', 'd-reyes@email.com', 'Tina', 2),
(2, 'Lisa', 'Cruz', 'F', '1988-07-15', 'lisa.cruz@email.com', NULL, NULL),
(3, 'Marco', 'Dela Cruz', 'M', '1969-11-02', 'marco.dc@email.com', 'Sarah', 0),
(4, 'Jenny', 'Lopez', 'F', '1969-03-27', 'jen.lopez@email.com', 'Oscar', 3),
(5, 'Patrick', 'Manalo', 'M', '1985-04-09', 'patrick@email.com', 'Joy', 1);

-- PART 2 EXERCISES (DATE)

--  Employees born in April
SELECT id, birth, email
FROM employee
WHERE MONTH(birth) = 4;

-- Employees born in 1969 sorted by spouse
SELECT id, birth, spouse
FROM employee
WHERE YEAR(birth) = 1969
ORDER BY spouse ASC;

--  Employees born in current month
SELECT id
FROM employee
WHERE MONTH(birth) = MONTH(CURDATE());

--  Count unique birth years
SELECT COUNT(DISTINCT YEAR(birth)) AS unique_birth_years
FROM employee;

--  Employees per birth year
SELECT YEAR(birth) AS birth_year, COUNT(*) AS num_employees
FROM employee
GROUP BY YEAR(birth)
ORDER BY birth_year ASC;

--  Employees per month
SELECT MONTHNAME(birth) AS month_name, COUNT(*) AS num_employees
FROM employee
GROUP BY MONTH(birth)
ORDER BY num_employees DESC;

-- PART 3 EXERCISES (NULL COLUMNS)

--  Married employees
SELECT id, spouse
FROM employee
WHERE spouse IS NOT NULL;

--  Married employees sorted by spouse
SELECT id, spouse
FROM employee
WHERE spouse IS NOT NULL
ORDER BY spouse ASC;

--  Count by sex
SELECT sex, COUNT(*) AS count
FROM employee
GROUP BY sex;

--  Married vs unmarried
SELECT CASE WHEN spouse IS NOT NULL THEN 'Married' ELSE 'Unmarried' END AS status,
       COUNT(*) AS count
FROM employee
GROUP BY status;

--  Total children
SELECT SUM(children) AS total_children
FROM employee;

--  Group employees by number of children
SELECT children AS children_count, COUNT(*) AS num_employees
FROM employee
GROUP BY children
ORDER BY children_count DESC;
