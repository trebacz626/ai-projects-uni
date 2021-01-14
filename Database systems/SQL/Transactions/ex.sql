--DML TRANSACTIONS
1.
SELECT * FROM EMPLOYEES

2.
UPDATE EMPLOYEES
 SET JOB = 'PROFESSOR'
 WHERE SURNAME = 'Green'

3.
DELETE FROM EMPLOYEES
WHERE JOB = 'ASSISTANT'

4.
ROLLBACK

--DDL TRANSACTIONS
1.Update employees
    set salary = salary*1.1
    where 
    job = 'LECTURER'

2. ALTER TABLE EMPLOYEES
MODIFY ADD_SALARY number(7,2)

3. i COULD NOT :(

--sAVEPOINTS
1.
UPDATE EMPLOYEES
    SET SALARY = SALARY + 200
    WHERE
    SURNAME='Smith'

2.
SAVEPOINT s1

3.
update employees
    set add_salary = 100
    where
    SURNAME= 'Wilson'
4.
savepoint s2

5.
delete from employees where surname = 'Young'

6.
ROLLBACK TO SAVEPOINT s1

7.
select * from employees

8.
ROLLBACK TO SAVEPOINT s2

9.
rollback