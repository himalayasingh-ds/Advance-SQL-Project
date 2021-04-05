SELECT * FROM hr.`sql folder`; 

    #1---query to display the names (first_name, last_name) using alias ----------
select first_name "first_name", last_name "last_name" from hr.`sql folder`; 




#2----query to get unique department ID from employee table ----------------
select department_id from hr.`sql folder`; 





#3-query to get all employee details from the employee table order by first name, -----------
select * from hr.`sql folder`
ORDER BY first_name desc;






#4---a query to get the names (first_name, last_name), salary, --------------------
SELECT first_name, last_name, salary, salary*.15 PF 
	FROM hr.`sql folder`;
      
      #5-----query to get the employee ID, names (first_name, last_name), ------------------------
    SELECT employee_id, first_name, last_name, salary 
    FROM  hr.`sql folder`
    ORDER BY salary;
     
     #6 -----query to get the total salaries payable to employees -------------------------
    SELECT SUM(salary) 
     FROM hr.`sql folder`;
         
       #7---------query to get the maximum and minimum salary from employees table ----------------
     SELECT MAX(salary), MIN(salary) 
     FROM  hr.`sql folder`;
     
     
     
     
     
     #8----------query to get the average salary and number of employees in the employees table -------------
     SELECT AVG(salary), COUNT(*) 
     FROM hr.`sql folder`;
        
#9------------query to get the number of employees working with the company -------------------------
     SELECT COUNT(*) 
    FROM hr.`sql folder`;


#10----------query to get the number of jobs available in the employees table ------------------------
    SELECT COUNT(DISTINCT job_id) 
    FROM hr.`sql folder`;


    #11------------query get all first name from employees table in upper case ----------------------------
    SELECT UPPER(first_name) 
   FROM hr.`sql folder`;

#12------------query to get the first 3 characters of first name from employees table ---------------------
   SELECT SUBSTRING(first_name,1,3) 
     FROM hr.`sql folder`;
      
      
    
    #13-------query to get first name from employees table after removing white spaces from both side-------------    
     SELECT TRIM(first_name) 
    FROM hr.`sql folder`;
	
    
    
    #14--------query to get the length of the employee names (first_name, last_name) from employees table---
   
   SELECT first_name,last_name, LENGTH(first_name)+LENGTH(last_name)  'Length of  Names' 
    FROM hr.`sql folder`;

 #15---a query to check if the first_name fields of the employees table contains numbers ------
    SELECT * 
   FROM hr.`sql folder`
   WHERE  first_name REGEXP  '[0-9]';


#16--------query to display the name (first_name, last_name) and salary for all employees w-------------
   SELECT first_name, last_name, salary
FROM hr.`sql folder`
WHERE salary NOT BETWEEN 10000 AND 15000;


#17----query to display the name (first_name, last_name) and department ID of all -------
   SELECT first_name, last_name, department_id
FROM hr.`sql folder`
WHERE department_id IN (30, 100)
ORDER BY  department_id  ASC;





#18----------query to display the name (first_name, last_name) and salary for ---------

SELECT first_name, last_name, salary, department_id
FROM hr.`sql folder`
WHERE salary NOT BETWEEN 10000 AND 15000 
AND department_id IN (30, 100);



#19---------query to display the name (first_name, last_name) and hire date-----------
SELECT first_name, last_name, hire_date 
FROM hr.`sql folder`
WHERE YEAR(hire_date)  LIKE '1987%';


#20------------query to display the first_name of all employees who have both ----------
   
   SELECT first_name
FROM hr.`sql folder`
WHERE first_name LIKE '%b%'
AND first_name LIKE '%c%';


-#21-------------a query to display the last name, job, and salary for all employees whose ---------

SELECT last_name, job_id, salary
FROM  hr.`sql folder`
WHERE job_id IN ('IT_PROG', 'SH_CLERK')
AND salary NOT IN (4500,10000, 15000);


#22---a query to display the last name of employees whose names have exactly 6 characters -------------

SELECT last_name FROM hr.`sql folder`  WHERE last_name LIKE '______';


#23----------query to display the last name of employees having 'e' as the third character --------
SELECT last_name FROM  hr.`sql folder` WHERE last_name LIKE '__e%';


-#24--------query to get the job_id and related employee' ----------
SELECT DISTINCT job_id  FROM hr.`sql folder`;
    

#25-----a query to update the portion of the phone_number in the employees -----------
    UPDATE hr.`sql folder`
SET phone_number = REPLACE(phone_number, '124', '999') 
where phone_number LIKE '%124%';
    

#26-----a query to get the details of the employees where the length of the first ---------------
 SELECT * 
FROM hr.`sql folder`
WHERE LENGTH(first_name) >= 8;


#27----------------
UPDATE hr.`sql folder`  SET email = CONCAT(email, '@example.com');

#28-------------
SELECT RIGHT(phone_number, 4) as 'Ph.No.' FROM hr.`sql folder`;


#29--query to get the last word of the street address -------------
SELECT location_id, street_address, 
SUBSTRING_INDEX(REPLACE(REPLACE(REPLACE(street_address,',',' '),')',' '),'(',' '),' ',-1) 
AS 'Last--word-of-street_address' 
FROM locations;


#30--query to get the locations that have minimum street length ------------------
SELECT * FROM locations
WHERE LENGTH(street_address) <= (SELECT  MIN(LENGTH(street_address)) 
FROM locations);


#31---query to display the first word from those job titles which contains more than one words -----------
SELECT job_title, SUBSTR(job_title,1, INSTR(job_title, ' ')-1)
FROM jobs;


#32----a query to display the length of first name for employees where last name contain character 'c' after 2nd position -----
SELECT first_name, last_name FROM employees WHERE INSTR(last_name,'C') > 2;

-#33----------------------
SELECT first_name "Name",
LENGTH(first_name) "Length"
FROM hr.`sql folder`
WHERE first_name LIKE 'J%'
OR first_name LIKE 'M%'
OR first_name LIKE 'A%'
ORDER BY first_name ;


#34----query to display the first name and salary for all employees. Format the salary -------------
SELECT first_name,
LPAD(salary, 10, '$') SALARY
FROM hr.`sql folder`;

-
#35---------query to display the first eight characters of the employees'----------
SELECT left(first_name, 8),
REPEAT('$', FLOOR(salary/1000)) 
'SALARY($)', salary
FROM hr.`sql folder`
ORDER BY salary DESC;

-----#36----query to display the employees with their code, first name, last name and hire date who -----------
SELECT employee_id,first_name,last_name,hire_date 
FROM  hr.`sql folder`
WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m %Y'))>0;
