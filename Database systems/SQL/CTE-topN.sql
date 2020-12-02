--1.
ALTERWITH AVERAGE_SALARY (JOB, AVG_SALARY_FOR_JOB) AS (
    SELECT JOB,
        AVG(SALARY)
    FROM EMPLOYEES
    GROUP BY JOB
)
SELECT SURNAME,
    EMPLOYEES.JOB,
    SALARY,
    AVG_SALARY_FOR_JOB
FROM EMPLOYEES
    INNER JOIN AVERAGE_SALARY ON EMPLOYEES.JOB = AVERAGE_SALARY.JOB
WHERE SALARY > AVG_SALARY_FOR_JOB
--2.
    WITH SUM_SALARIES_DEPARTMENT (DEPT_ID, SUM_OF_SALS) AS (
        SELECT DEPT_ID,
            SUM(SALARY)
        FROM EMPLOYEES
        GROUP BY DEPT_ID
    )
SELECT DEPT_NAME,
    SUM_OF_SALS DEPARTMENT
FROM DEPARTMENTS
    INNER JOIN SUM_SALARIES_DEPARTMENT ON DEPARTMENTS.DEPT_ID = SUM_SALARIES_DEPARTMENT.DEPT_ID
ORDER BY SUM_OF_SALS DESC
FETCH FIRST 1 ROW ONLY
--3
WITH BOSSES_SALARIES (
    BOSS,
    BOSS_NAME,
    BOSS_SALARY
) AS (
    SELECT
        EMP_ID,
        SURNAME,
        SALARY
    FROM
        EMPLOYEES
    WHERE
        EMP_ID IN (
            SELECT
                BOSS_ID
            FROM
                EMPLOYEES
        )
)
SELECT
    SURNAME,
    SALARY,
    BOSS_NAME,
    BOSS_SALARY
FROM
    EMPLOYEES
    INNER JOIN BOSSES_SALARIES ON EMPLOYEES.BOSS_ID = BOSSES_SALARIES.BOSS
WHERE
    SALARY >= 0.6 * BOSS_SALARY
--4
SELECT
    SURNAME,
    HIRE_DATE
FROM
    EMPLOYEES
ORDER BY
    HIRE_DATE
FETCH FIRST 1 ROW ONLY
--5
WITH ELDER (
    SURNAME,
    HIRE_DATE
) AS (
    SELECT
        SURNAME,
        HIRE_DATE
    FROM
        EMPLOYEES
    ORDER BY
        HIRE_DATE
    FETCH FIRST 1 ROW ONLY
)
SELECT
    SURNAME,
    EMPLOYEES.HIRE_DATE - (
        SELECT
            ELDER.HIRE_DATE
        FROM
            ELDER
    ) AS NUM_OF_DAYS
FROM
    EMPLOYEES
ORDER BY
    NUM_OF_DAYS
--6
SELECT
    SURNAME
    || ' earns '
    ||
    CASE
        WHEN SALARY >= 4000   THEN
        'five'
        WHEN SALARY >= 3000   THEN
        'four'
        WHEN SALARY >= 2000   THEN
        'three'
        WHEN SALARY >= 1000   THEN
        'two'
        ELSE
        'one'
    END
    || ' grand' AS SENTENCE
FROM
    EMPLOYEES
ORDER BY
    SURNAME
--7
WITH EMP_HIERARCHY (
    EMP_ID,
    SURNAME,
    EMPLOYEE,
    HIERARCHY
) AS (
    SELECT
        EMP_ID,
        SURNAME,
        NAME || SURNAME,
        NAME || SURNAME
    FROM
        EMPLOYEES
    WHERE
        SURNAME = 'Smith'
    UNION ALL
    SELECT
        E.EMP_ID,
        E.SURNAME,
        E.NAME || E.SURNAME,
        HIERARCHY
        || ' -> '
        || E.NAME
        || E.SURNAME
    FROM
        EMPLOYEES E
        INNER JOIN EMP_HIERARCHY H ON E.BOSS_ID = H.EMP_ID
)
    SEARCH DEPTH FIRST BY SURNAME SET SIBL_ORDER
SELECT
    EMPLOYEE,
    HIERARCHY
FROM
    EMP_HIERARCHY
ORDER BY
    SIBL_ORDER