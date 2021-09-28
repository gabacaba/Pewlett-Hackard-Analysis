--Employee_Database_challenge.sql
drop table retirement_titles;
SELECT employees.emp_no, 
employees.first_name, 
employees.last_name,
employees.birth_date,
titles.title,
titles.from_date,
titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name, 
last_name,
title
INTO unique_titles
from retirement_titles
Order by emp_no, emp_no DESC;

--Employee count by Title type
select count (unique_titles.emp_no), unique_titles.title
into retiring_titles
from unique_titles
group by unique_titles.title
order by count (unique_titles.emp_no) DESC;

--DELIVERABLE 2
--SELECT CURRENT EMPLOYEES who were born between January 1, 1965 and December 31, 1965


SELECT employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, dept_emp.from_date, dept_emp.to_date
into deliverable_2_info
FROM employees
left join dept_emp 
on employees.emp_no = dept_emp.emp_no
WHERE employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
and dept_emp.to_date = '9999-01-01';

Select DISTINCT ON (deliverable_2_info.emp_no) deliverable_2_info.emp_no, 
deliverable_2_info.first_name, deliverable_2_info.last_name, 
deliverable_2_info.birth_date, deliverable_2_info.from_date, deliverable_2_info.to_date,
titles.title
INTO mentorship_eligibilty
FROM deliverable_2_info
INNER JOIN titles
ON deliverable_2_info.emp_no = titles.emp_no
Order by deliverable_2_info.emp_no, deliverable_2_info.emp_no DESC;