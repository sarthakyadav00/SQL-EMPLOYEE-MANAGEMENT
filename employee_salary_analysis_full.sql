CREATE TABLE jobs(
  id INT PRIMARY KEY
  ,work_year INT
  ,experience_level VARCHAR(50)
  ,employment_type VARCHAR(50)
  ,job_title VARCHAR(50)
  ,salary INT
  ,salary_currency VARCHAR(50)
  ,salary_in_usd INT
  ,employee_residence VARCHAR(50)
  ,remote_ratio INT
  ,company_location VARCHAR(50)
  ,company_size VARCHAR(50)
);

CREATE TABLE companies(
 id INT PRIMARY KEY,
 company_name VARCHAR(20));
 
 select * from companies
 select * from jobs



-- Q1. What is the average salary for all the jobs in the dataset?

select AVG(salary) as Average_Salary from jobs

-- Q2. What is the highest salary in the dataset and which job role does it correspond to?

select job_title, salary from jobs
order by salary desc limit 1;

-- Q3. What is the average salary for data scientists in US?

select AVG(salary) as Average_Data_Scientist_Salary from jobs
where job_title = 'Data Scientist' AND company_location = 'US'

-- Q4. What is the number of jobs available for each job title? (Most to least order)

select COUNT(job_title) as Number_of_jobs, job_title
from jobs
group by job_title
order by number_of_jobs desc

--Q5. What is the total salary paid for all data analyst jobs in DE?

select SUM(salary) as total_salary_paid from jobs 
where job_title = 'Data Analyst' and company_location = 'DE'

--Q6. What are the top 5 highest paying job titles and their corresponding average salaries?

select job_title, AVG(salary) as average_salary
from jobs 
group by job_title
order by average_salary desc limit 5

--Q7. What are the number of jobs available in each location?

select company_location, COUNT(company_location) as location_jobs
from jobs
group by company_location
order by location_jobs desc

-- Q8. What are the top 3 job titles that have the most jobs available in the dataset?

select job_title, COUNT(*) as number_jobs 
from jobs 
group by job_title 
order by number_jobs desc limit 3; 

--Q9. What is the average salary for data engineers in IN?

select AVG(salary) as average_salary 
from jobs
where job_title = 'Data Engineer' and company_location = 'IN'

-- Q10. What are the top five countries with the highest average salary?

select company_location, AVG(salary) as average_salary 
from jobs
group by company_location
order by average_salary desc limit 5

-- Q11. What is the average salary for each job title, and what is the total number of jobs available for each job title?

SELECT job_title, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title;

-- Q12. What are the top 5 job titles with the highest total salaries, and what is the total number of jobs available for each job title?

SELECT job_title, SUM(salary) AS total_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title 
ORDER BY total_salary DESC 
LIMIT 5;

-- Q13. What are the top 5 locations with the highest total salaries, and what is the total number of jobs available for each location?

SELECT company_location, SUM(salary) AS total_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY company_location 
ORDER BY total_salary DESC 
LIMIT 5;

-- Q14. What is the average salary for each job title in each location, and what is the total number of jobs available for each job title in each location?

SELECT job_title, company_location, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title, company_location;

-- Q15. What is the average salary for each job title in each location, and what is the percentage of jobs for each job title in each location?

SELECT job_title, company_location, AVG(salary) AS average_salary, 
(COUNT(*) * 100 / (SELECT COUNT(*) FROM jobs WHERE company_location = j.company_location)) AS job_percentage 
FROM jobs j 
GROUP BY job_title, company_location;

-- Q16. What are the top 5 job titles with the highest average salaries, and what is the total number of jobs available for each job title?

SELECT job_title, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title 
ORDER BY average_salary DESC 
LIMIT 5;

-- Q17. What is the average salary for each job title, and what is the percentage of jobs for each job title in the dataset?

SELECT job_title, AVG(salary) AS average_salary, 
(COUNT(*) * 100 / (SELECT COUNT(*) FROM jobs)) AS job_percentage 
FROM jobs 
GROUP BY job_title;


-- Q18. What is the total number of jobs available for each year of experience, and what is the average salary for each year of experience?

SELECT experience_level, COUNT(*) AS num_jobs, AVG(salary) AS average_salary 
FROM jobs 
GROUP BY experience_level;
/*
EN, which refers to Entry-level / Junior.

MI, which refers to Mid-level / Intermediate.

SE, which refers to Senior-level / Expert.

EX, which refers to Executive-level / Director.
*/

-- Q19. What are the top 5 job titles with the highest average salaries in each location?

SELECT job_title, company_location, AVG(salary) AS average_salary 
FROM jobs 
WHERE job_title IN (SELECT job_title FROM jobs GROUP BY job_title ORDER BY AVG(salary) DESC) 
GROUP BY job_title, company_location;

-- Q20. What is the average salary for each degree level, and what is the total number of jobs available for each degree level?

SELECT degree_level, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY degree_level;


-- Q21. What are the top 5 job titles with the highest salaries, and what is the name of the company that offers the highest salary for each job title?

SELECT job_title, MAX(salary) AS highest_salary, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY job_title, company_name
ORDER BY highest_salary DESC 
LIMIT 5;

-- Q22. What is the total number of jobs available for each job title, and what is the name of the company that offers the highest salary for each job title?


SELECT job_title, COUNT(*) AS num_jobs, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
WHERE salary = (SELECT MIN(salary) FROM jobs WHERE job_title = jobs.job_title) 
GROUP BY job_title, company_name;



-- Q23. What are the top 5 cities with the highest average salaries, and what is the name of the company that offers the highest salary for each city?

SELECT company_location, AVG(salary) AS average_salary, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY company_location 
ORDER BY average_salary DESC 
LIMIT 5;

-- Q24. What is the average salary for each job title in each company, and what is the rank of each job title within each company based on the average salary?

SELECT job_title, company_name, AVG(salary) AS average_salary, 
RANK() OVER (PARTITION BY company_name ORDER BY AVG(salary) DESC) AS salary_rank 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY job_title, company_name;






-- Q25. What are the top 5 companies with the highest average salaries for data scientist positions, and what is the rank of each company based on the average salary?

SELECT company_name, AVG(salary) AS average_salary, 
RANK() OVER (ORDER BY AVG(salary) DESC) AS salary_rank 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
WHERE job_title = 'Data Scientist' 
GROUP BY company_name 
ORDER BY average_salary DESC 
LIMIT 5;



