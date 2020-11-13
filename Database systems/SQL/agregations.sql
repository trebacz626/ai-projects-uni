1.
SELECT
    MIN(SALARY)                      AS MIN_SALARY,
    MAX(SALARY)                      AS MAX_SALARY,
    MAX(SALARY) - MIN(SALARY)          AS DIFFERENCE
FROM
    EMPLOYEES
2.
SELECT
    COUNT(EMP_ID)
FROM
    EMPLOYEES
WHERE
    DEPT_ID IS NULL
3.
SELECT
    COUNT(EMP_ID)
FROM
    EMPLOYEES
WHERE
    JOB LIKE 'PROFESSOR'
4.
SELECT
    JOB,
    AVG(SALARY) AS AVG_SALARY
FROM
    EMPLOYEES
GROUP BY
    JOB
ORDER BY
    AVG_SALARY DESC
5.
SELECT
    JOB,
    AVG(SALARY + NVL(
        ADD_SALARY, 0
    )) AS AVG_SALARY,
    COUNT(EMP_ID)
FROM
    EMPLOYEES
GROUP BY
    JOB
ORDER BY
    AVG_SALARY DESC
6.
SELECT
    JOB,
    AVG(SALARY + NVL(
        ADD_SALARY, 0
    )) AS AVG_SALARY,
    COUNT(EMP_ID)
FROM
    EMPLOYEES
GROUP BY
    JOB
HAVING
    COUNT(EMP_ID) > 1
ORDER BY
    AVG_SALARY DESC
7.
SELECT
    DEPT_ID,
    COUNT(EMP_ID)
FROM
    EMPLOYEES
WHERE
    ADD_SALARY IS NOT NULL
    AND DEPT_ID IS NOT NULL
GROUP BY
    DEPT_ID
ORDER BY
    DEPT_ID
8.
SELECT
    DEPT_ID,
    COUNT(EMP_ID),
    AVG(ADD_SALARY),
    SUM(ADD_SALARY)
FROM
    EMPLOYEES
WHERE
    ADD_SALARY IS NOT NULL
    AND DEPT_ID IS NOT NULL
GROUP BY
    DEPT_ID
ORDER BY
    DEPT_ID
9.
SELECT
    BOSS_ID,
    COUNT(EMP_ID)
FROM
    EMPLOYEES
WHERE
    BOSS_ID IS NOT NULL
GROUP BY
    BOSS_ID
ORDER BY
    BOSS_ID
10.
SELECT
    EXTRACT(YEAR FROM HIRE_DATE) AS HIRE_YEAR,
    COUNT(EMP_ID)
FROM
    EMPLOYEES
GROUP BY
    EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY
    EXTRACT(YEAR FROM HIRE_DATE)
11.
SELECT
    LENGTH(SURNAME),
    COUNT(SURNAME)
FROM
    EMPLOYEES
GROUP BY
    LENGTH(SURNAME)
ORDER BY
    LENGTH(SURNAME)
12.
SELECT
    COUNT(SURNAME)
FROM
    EMPLOYEES
WHERE
    SURNAME LIKE '%A%'
    OR SURNAME LIKE '%a%'
UNION
SELECT
    COUNT(SURNAME)
FROM
    EMPLOYEES
WHERE
    SURNAME LIKE '%E%'
    OR SURNAME LIKE '%e%'
13.
SELECT
    COUNT(
        CASE
        WHEN SURNAME LIKE '%A%'
             OR SURNAME LIKE '%a%' THEN
        1
        ELSE
        NULL
        END
    )  AS COUNT_A,
    COUNT(
        CASE
        WHEN SURNAME LIKE '%E%'
             OR SURNAME LIKE '%e%' THEN
        1
        ELSE
        NULL
        END
    )  AS COUNT_E
FROM
    EMPLOYEES