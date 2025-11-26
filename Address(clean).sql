
-- DATABASE CREATION
CREATE DATABASE IF NOT EXISTS addressbook;
USE addressbook;

-- DROP TABLE IF EXIST
DROP TABLE IF EXISTS employee_full;


-- UNIFIED EMPLOYEE TABLE
CREATE TABLE employee_full (
    id INT PRIMARY KEY AUTO_INCREMENT,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    sex CHAR(1) DEFAULT NULL,
    birth_date DATE DEFAULT NULL,
    email VARCHAR(100) UNIQUE,
    spouse VARCHAR(100) DEFAULT NULL,
    children INT DEFAULT NULL,
    title VARCHAR(100) DEFAULT NULL,
    age INT DEFAULT NULL,
    yos INT DEFAULT NULL,
    salary DECIMAL(10,2) DEFAULT NULL,
    perks DECIMAL(10,2) DEFAULT NULL
);


-- INSERT UNIFIED DATA
INSERT INTO employee_full 
(f_name, l_name, sex, birth_date, email, spouse, children, title, age, yos, salary, perks)
VALUES
-- Employee 1
('Rudolf', 'Reindeer', 'M', '1972-03-16', 'rudolf@bugnet.com', 'Clarice Reindeer', 1, 'Business Analyst', 34, 2, 95000, 17000),
-- Employee 2
('Manish', 'Patel', 'M', '1969-02-05', 'manish.patel@bugnet.com', 'Rani Patel', 0, 'HR Specialist', 29, 3, 62000, 8000),
-- Employee 3
('Alok', 'Peters', 'M', '1976-12-31', 'alok.peters@bugnet.com', 'Jenny Peters', 2, 'Sales Associate', 31, 4, 58000, 5000),
-- Employee 4
('Sarah', 'Lopez', 'F', '1970-05-08', 'sarah.lopez@bugnet.com', 'Miguel Lopez', 2, 'Marketing Manager', 38, 10, 88000, 15000),
-- Employee 5
('Kelly', 'Ramos', 'F', '1971-10-29', 'kelly.ramos@bugnet.com', 'Adrian Ramos', 0, 'Marketing Analyst', 26, 1, 54000, 6000),
-- Employee 6
('Anika', 'Singh', 'F', '1973-01-09', 'anika.singh@bugnet.com', 'Rahul Singh', 1, 'Accountant', 27, 2, 50000, 4000),
-- Employee 7
('Mark', 'Brown', 'M', '1964-09-20', 'mark.brown@bugnet.com', 'Diana Brown', 3, 'Support Engineer', 33, 5, 67000, 7000),
-- Employee 8
('David', 'Stone', 'M', '1980-11-03', 'david.stone@bugnet.com', 'Emily Stone', 0, 'Programmer', 30, 4, 72000, 9000),
-- Employee 9
('Jessica', 'Wu', 'F', '1972-03-30', 'jessica.wu@bugnet.com', 'Henry Wu', 2, 'Senior Programmer', 41, 12, 105000, 20000),
-- Employee 10
('Brandon', 'Morris', 'M', '1962-12-11', 'brandon.morris@bugnet.com', 'Lisa Morris', 1, 'Multimedia Specialist', 28, 3, 81000, 7000),
-- Employee 11
('Helen', 'Cruz', 'F', NULL, 'helen.cruz@bugnet.com', NULL, NULL, 'Project Coordinator', 32, 7, 69000, 8000),
-- Employee 12
('Carlos', 'Diaz', 'M', NULL, 'carlos.diaz@bugnet.com', NULL, NULL, 'Operations Supervisor', 40, 11, 76000, 9000),
-- Employee 13
('Maria', 'Gomez', 'F', NULL, 'maria.gomez@bugnet.com', NULL, NULL, 'Data Analyst', 35, 6, 83000, 7500),
-- Employee 14
('Liam', 'Turner', 'M', NULL, 'liam.turner@bugnet.com', NULL, NULL, 'Web Designer', 25, 2, 61000, 5000),
-- Employee 15
('Anamika', 'Sharma', 'F', NULL, 'anamika.pandit@bugnet.com', NULL, NULL, 'Web Developer', 24, 1, 55000, 5000);

-- EXERCISE 14 UPDATES (SALARY & TITLE)
UPDATE employee_full
SET salary = salary + 10000
WHERE f_name != 'Rudolf' AND l_name != 'Reindeer';


-- PART 2 EXERCISES (DATE)

-- 1. Employees born in April
SELECT id, f_name, l_name, birth_date, email
FROM employee_full
WHERE MONTH(birth_date) = 4;

-- 2. Employees born in 1969 sorted by spouse
SELECT id, f_name, l_name, birth_date, spouse
FROM employee_full
WHERE YEAR(birth_date) = 1969
ORDER BY spouse ASC;

-- 3. Employees born in current month
SELECT id, f_name, l_name
FROM employee_full
WHERE MONTH(birth_date) = MONTH(CURDATE());

-- 4. Count unique birth years
SELECT COUNT(DISTINCT YEAR(birth_date)) AS unique_birth_years
FROM employee_full;

-- 5. Employees per birth year
SELECT YEAR(birth_date) AS birth_year, COUNT(*) AS num_employees
FROM employee_full
GROUP BY YEAR(birth_date)
ORDER BY birth_year ASC;

-- 6. Employees per month
SELECT MONTHNAME(birth_date) AS month_name, COUNT(*) AS num_employees
FROM employee_full
GROUP BY MONTH(birth_date)
ORDER BY num_employees DESC;

-- PART 3 EXERCISES (NULL COLUMNS)

-- 1. Married employees
SELECT id, f_name, l_name, spouse
FROM employee_full
WHERE spouse IS NOT NULL;

-- 2. Married employees sorted by spouse
SELECT id, f_name, l_name, spouse
FROM employee_full
WHERE spouse IS NOT NULL
ORDER BY spouse ASC;

-- 3. Count by sex
SELECT sex, COUNT(*) AS count
FROM employee_full
GROUP BY sex;

-- 4. Married vs unmarried
SELECT CASE WHEN spouse IS NOT NULL THEN 'Married' ELSE 'Unmarried' END AS status,
       COUNT(*) AS count
FROM employee_full
GROUP BY status;

-- 5. Total children
SELECT SUM(children) AS total_children
FROM employee_full;

-- 6. Group employees by number of children
SELECT children AS children_count, COUNT(*) AS num_employees
FROM employee_full
GROUP BY children
ORDER BY children_count DESC;
