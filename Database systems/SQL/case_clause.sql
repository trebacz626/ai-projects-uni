1.
SELECT
    SURNAME,
    CASE
    WHEN SALARY < 1500    THEN
    'low paid'
    WHEN SALARY <= 3000   THEN
    'MIDDLE PAID'
    ELSE
    'WELL PAID'
    END AS SALARY
FROM
    EMPLOYEES
2.
SELECT DISTINCT
    BOSS_ID
FROM
    EMPLOYEES
WHERE
    BOSS_ID IS NOT NULL
3.
SELECT DISTINCT
    DEPT_ID,
    JOB
FROM
    EMPLOYEES
WHERE
    DEPT_ID IS NOT NULL
ORDER BY
    DEPT_ID
4.
SELECT DISTINCT
    EXTRACT(YEAR FROM HIRE_DATE) AS YEARS
FROM
    EMPLOYEES
ORDER BY
    YEARS
5.
SELECT
    DEPT_ID
FROM
    DEPARTMENTS 

MINUS

SELECT DISTINCT
    DEPT_ID
FROM
    EMPLOYEES
WHERE
    DEPT_ID IS NOT NULL
6.
SELECT
    SURNAME,
    SALARY,
    'low salary' AS LABEL
FROM
    EMPLOYEES
WHERE
    SALARY < 1500
UNION
SELECT
    SURNAME,
    SALARY,
    'AVERAGE SALARY' AS LABEL
FROM
    EMPLOYEES
WHERE
    SALARY > 1500 AND SALARY <=3000
UNION
SELECT
    SURNAME,
    SALARY,
    'HIGH SALARY' AS LABEL
FROM
    EMPLOYEES
WHERE
    SALARY > 3000
