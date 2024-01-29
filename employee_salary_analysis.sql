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


