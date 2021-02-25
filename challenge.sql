-- CHALLENGE CODE

--Part 1
--Number of [titles] Retiring
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

--Part 2
--Only the Most Recent Titles
Select COUNT (rt.emp_no), rt.title
INTO retiring_title_count
FROM retiring_titles as rt
GROUP BY rt.title
ORDER BY rt.title;

--Part 3
--Who's Ready for a Mentor?
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
	AND (t.to_date = '9999-01-01');