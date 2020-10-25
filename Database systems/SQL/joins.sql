1.
SELECT
    SURNAME,
    JOB
FROM
    EMPLOYEES
WHERE
    SURNAME != 'Johnson'
    AND DEPT_ID = (
        SELECT
            DEPT_ID
        FROM
            EMPLOYEES
        WHERE
            SURNAME = 'Johnson'
    )
