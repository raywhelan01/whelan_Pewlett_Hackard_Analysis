# whelan_Pewlett_Hackard_Analysis
## Module 7 Challenge Write-up

For this project, Pewlett-Hackard asked us to perform some analyses on their human resources database to identify how many employees were nearing retirement and how many employees could be be groomed through a mentorship program to replace them. To do this, I performed several queries on the database, filtering by employee age to identify employees nearing retirement and being careful to exclude former employees and duplicate entries in the database. Next, I identified the counts of how many employees were nearing retirement by their title. Lastly, I filtered our employee database for a slightly younger cohort who of employees could could be mentored by the retiring employees to take over.

First, I started by creating an entity relationship diagram for Pewlett-Hackard's HR database, shown below.

![EmployeeDB](https://github.com/raywhelan01/whelan_Pewlett_Hackard_Analysis/blob/master/EmployeeDB.png?raw=true)

### Query 1: Number of [titles] Retiring

For this query, I accessed the "current_emp" table created during the module, the "title" table, and the "salary" table to create a new table called "retiring_titles". This table holds the Employee Number, first and last name, title, from_date, and salary of all employees nearing retirement. The 'WHERE' condition in the query filters out all duplicate entries from the 'title' table, ensuring our table only shows current employee titles.

This query return 33,118 employees.

#### Code and output screenshot
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	t.title,
	t.from_date,
	s.salary
INTO retiring_titles
FROM current_emp as ce
INNER JOIN titles as t
ON (ce.emp_no = t.emp_no)
INNER JOIN salaries as s
ON (ce.emp_no = s.emp_no)
WHERE (t.to_date = '9999-01-01')
-- By using this 'WHERE' filter, we can ensure that all old titles for current employees will be excluded
ORDER BY ce.emp_no;

![Query1](https://github.com/raywhelan01/whelan_Pewlett_Hackard_Analysis/blob/master/Query%20Screenshots/Query%201.png)

### Query 2: Only the Most Recent Titles


#### Code and output screenshot
Select COUNT (rt.emp_no), rt.title
INTO retiring_title_count
FROM retiring_titles as rt
GROUP BY rt.title
ORDER BY rt.title;

![Query 2](https://github.com/raywhelan01/whelan_Pewlett_Hackard_Analysis/blob/master/Query%20Screenshots/Query%202.png)

### Query 3: Who's Ready for a Mentor?

For this query, I accessed the original "employees" database and the "titles" database. Similarly to how we identified the employees near retirement, I filtered for a slightly younger group of employees who could be eligible mentees in a mentorship program. Again, I also filtered to ensure no duplicate entries would return and employees would only be shown with their current title.

This query returned 1,549 employees.

#### Code and output screenshot
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO potential_mentees
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no;

![Query 3](https://github.com/raywhelan01/whelan_Pewlett_Hackard_Analysis/blob/master/Query%20Screenshots/Query%203.png)
