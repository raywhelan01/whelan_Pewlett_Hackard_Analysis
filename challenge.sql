-- CHALLENGE CODE

--Identifying duplicates
SELECT
--	emp_no,
  first_name,
  last_name,
  count(*)
FROM current_emp
GROUP BY
--	emp_no,
  first_name,
  last_name
HAVING count(*) > 1
ORDER BY first_name;

--Number of [titles] Retiring
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	t.title,
	t.from_date,
	s.salary
--INTO retiring_titles
FROM current_emp as ce
INNER JOIN titles as t
ON (ce.emp_no = t.emp_no)
INNER JOIN salaries as s
ON (ce.emp_no = s.emp_no)
--WHERE (t.to_date = '9999-01-01')

--Only the Most Recent Titles
Select COUNT (ce.emp_no), t.title
--INTO title_count
FROM current_emp as ce
LEFT JOIN titles as t
ON ce.emp_no = t.emp_no
GROUP BY t.title
ORDER BY t.title;

--Who's Ready for a Mentor?
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
--INTO potential_mentees
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (t.to_date = '9999-01-01');