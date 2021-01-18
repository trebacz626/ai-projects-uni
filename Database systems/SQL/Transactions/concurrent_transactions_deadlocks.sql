--locks
1.
2.
--Session A
SELECT sys_context('USERENV', 'SID') FROM dual;
--Session B
SELECT sys_context('USERENV', 'SID') FROM dual;
--30
3.
--Session A
update employees
set salary=salary+100
where surname = 'Wood';

select salary from employees where surname='Wood';
--salary = 1367.01

SELECT * FROM table(SBD.LOCKS);
--TM	NONE	ROW EXCLUSIVE (RX)	AI145453.EMPLOYEES	0
--TX	NONE	EXCLUSIVE (X)	row	0

4.
--Session B
select salary from employees where surname='Wood';
--1267.01
--I do not see changes
update employees
set add_salary=50
where surname='Wood'
--above query is pending
5.
--Session A
SELECT * FROM table(SBD.LOCKS);
--the is_blocking field in both rows has changed from 0 to 1
SELECT * FROM table(SBD.LOCKS(30));

--TM	NONE	ROW EXCLUSIVE (RX)	AI145453.EMPLOYEES	0
--TX	EXCLUSIVE (X)	NONE	row	0

--B s waiting for Exclusive_lock (X) on row
6.
Rollback
--Sesion B finishes
--Locks helb by B
--TM	NONE	ROW EXCLUSIVE (RX)	AI145453.EMPLOYEES	0
--TX	NONE	EXCLUSIVE (X)	row	0
7. 
ROLLBACK

--Isolation levels
1.
--session A
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
select salary from employees where surname='Edwards'
--1590
2.
--Session B
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
select salary from employees where surname='Edwards'
--1590
update employees 
set salary = 1890
where surname='Edwards'
commit
3.
--Session A
update employees 
set salary = 1390
where surname='Edwards'
--succedeed
commit
4.
--Anomaly is lost update, salary:1390 salary_if_sequentially: 1690
5.
--session A
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
select salary from employees where surname='Edwards'
--1390
--Session B
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
select salary from employees where surname='Edwards'
--1390
update employees 
set salary = 1690
where surname='Edwards'
commit
--Session A
update employees 
set salary = 1190
where surname='Edwards'
--update employees 
--set salary = 1190
--where surname='Edwards'
--Error report -
--ORA-08177: can't serialize access for this transaction
--The command failed to execute, becuase command B introduced not-serializable changes


--Write skew anomaly in OracleDB
update employees
set salary = 3350
where surname = 'Jones'

update employees
set salary = 3070
where surname = 'Williams'

1.
--A
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
2.
--B
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
3.
--A
UPDATE employees
SET salary = (SELECT salary
 FROM employees
 WHERE surname = 'Jones')
WHERE surname = 'Williams';
4.
--B
UPDATE employees
SET salary = (SELECT salary
 FROM employees
 WHERE surname = 'Williams')
WHERE surname = 'Jones';
5.
--THE SALARY OF JOHNES IS 3070 AND THE SALARY OF WILLIAMS IS 3350 SO THEY WERER EXCHANGED

--REVERT
update employees
set salary = 3350
where surname = 'Jones'

update employees
set salary = 3070
where surname = 'Williams'

--A
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE employees
SET salary = (SELECT salary
 FROM employees
 WHERE surname = 'Jones')
WHERE surname = 'Williams';

COMMIT

--B
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE employees
SET salary = (SELECT salary
 FROM employees
 WHERE surname = 'Williams')
WHERE surname = 'Jones';

COMMIT

--nO BOTH THEIR SALARIES ARE EQUAL TO 3350

--DEADLOCK

--A
UPDATE EMPLOYEES 
SET SALARY = SALARY+10
WHERE emp_id = 210;

--B
UPDATE EMPLOYEES 
SET SALARY = SALARY+10
WHERE emp_id = 220;

--A
UPDATE EMPLOYEES 
SET SALARY = SALARY+20
WHERE emp_id = 220;

--B
UPDATE EMPLOYEES 
SET SALARY = SALARY+20
WHERE emp_id = 210;

--Deadlock detected in session A session B is pending

--A
rollback

--B completed
COMMIT

6.

--C
UPDATE EMPLOYEES 
SET SALARY = SALARY+10
WHERE emp_id = 210;

--B
UPDATE EMPLOYEES 
SET SALARY = SALARY+20
WHERE emp_id = 220;

--A
UPDATE EMPLOYEES 
SET SALARY = SALARY+30
WHERE emp_id = 230;

--C
UPDATE EMPLOYEES 
SET SALARY = SALARY+30
WHERE emp_id = 230;

--B
 UPDATE EMPLOYEES 
SET SALARY = SALARY+10
WHERE emp_id = 210;

--A
UPDATE EMPLOYEES 
SET SALARY = SALARY+20
WHERE emp_id = 220;

--b
rollback
--a
rollback


--Deferred integrity constraints

--A
create table Test(
    id number(5) CONSTRAINT test_pk PRIMARY KEY DEFERRABLE INITIALLY DEFERRED
);


--B
insert into TEST values(1);
insert into TEST values(1);
insert into TEST values(1);
insert into TEST values(1);
insert into TEST values(1);

--all elements have id 1
-- we get constrint violated Test is empty
ROLLBACK
--A
drop table test;
create table Test(
    id number(5) CONSTRAINT test_pk PRIMARY KEY DEFERRABLE INITIALLY IMMEDIATE
);


--B
insert into TEST values(1);
insert into TEST values(1);
--we can see constraint violated immedialtly after executing command
--there is 1 element in test table

--A

drop table test;