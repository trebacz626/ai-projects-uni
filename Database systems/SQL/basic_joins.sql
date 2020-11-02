1.
SELECT
    NAME,
    SURNAME,
    DEPT_NAME,
    ADDRESS
FROM
    EMPLOYEES
    INNER JOIN DEPARTMENTS USING ( DEPT_ID )
2.
SELECT
    'Employee '
    || NAME
    || ' '
    || SURNAME
    || ' works in '
    || DEPT_NAME
    || ' located at'
    || ADDRESS AS SENTANCE
FROM
    EMPLOYEES
    INNER JOIN DEPARTMENTS USING ( DEPT_ID )
3.
SELECT
    SURNAME,
    salary
FROM
    EMPLOYEES
    INNER JOIN DEPARTMENTS USING ( DEPT_ID )
where address = '47TH STR'
4.
SELECT
    COUNT(*),
    AVG(SALARY)
FROM
    EMPLOYEES
    INNER JOIN DEPARTMENTS USING ( DEPT_ID )
WHERE
    ADDRESS = '47TH STR'
5.
SELECT
    SURNAME, JOB, SALARY, MIN_SALARY, MAX_SALARY
FROM
    EMPLOYEES
    INNER JOIN JOBS ON EMPLOYEES.JOB = JOBS.NAME
6.
SELECT
    SURNAME,
    JOB,
    SALARY,
    MIN_SALARY,
    MAX_SALARY
FROM
    EMPLOYEES
    INNER JOIN JOBS ON EMPLOYEES.JOB = JOBS.NAME
WHERE
    SALARY NOT BETWEEN MIN_SALARY AND MAX_SALARY
7.
SELECT
    SURNAME,
    JOB,
    SALARY,
    MIN_SALARY,
    MAX_SALARY
FROM
    EMPLOYEES
    INNER JOIN JOBS ON EMPLOYEES.SALARY BETWEEN MIN_SALARY AND MAX_SALARY
WHERE
    JOBS.NAME = 'ASSISTANT'
8.
SELECT
    DEPT_NAME         AS DEPARTMENT,
    COUNT(EMP_ID)     AS EMPLOYEES_AT_DEPT,
    SUM(SALARY)       AS SALARIES_AT_DEPT
FROM
    EMPLOYEES
    INNER JOIN DEPARTMENTs USING ( DEPT_ID )
GROUP BY
    DEPT_NAME
9.
SELECT
    DEPT_NAME         AS DEPARTMENT,
    COUNT(EMP_ID)     AS EMPLOYEES_AT_DEPT,
    SUM(SALARY)       AS SALARIES_AT_DEPT
FROM
    DEPARTMENTS
    INNER JOIN EMPLOYEES USING ( DEPT_ID )
GROUP BY
    DEPT_NAME
HAVING
	COUNT(EMP_ID) >= 2
10.
SELECT
    DEPT_NAME  AS DEPARTMENT,
    CASE
    WHEN COUNT(EMP_ID) <= 2      THEN
    'small'
    WHEN COUNT(EMP_ID) <= 6      THEN
    'medium'
    ELSE
    'big'
    END AS "SIZE"
FROM
    DEPARTMENTS
    INNER JOIN EMPLOYEES USING ( DEPT_ID )
GROUP BY
    DEPT_NAME
11.
