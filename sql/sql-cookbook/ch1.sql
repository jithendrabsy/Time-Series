-- 1.1 all
select *
from emp

-- 1.2 subset of row
select *
from emp
where deptno = 10

-- 1.3 multiple conditions
select *
from emp
where deptno = 10
    or comm is not null
    or sal <= 2000 and deptno = 20

-- 1.4 subset of columns
select ename,deptno,sal
from emp

-- 1.5 meaningful names for columns
select sal as salary, comm as commision
from emp

-- 1.6 referencing aliased column in WHERE clause --- FAILS!
-- because cannot refer to the aliansed column here because - 
-- WHERE executed before SELECT statement
select sal as salary, comm as commision
from emp
where salary < 5000


-- 1.6.1 correction instead
select *
from (
    select sal as salary, comm as commision
    from emp
) X 
where salary < 5000

-- REMEMBER: WHERE is evaluated before SELECT
-- FROM is evaluated before WHERE


-- 1.7 concatenating column values

-- DB2, Oracle, PostgreSQL
select ename|| ' WORK AS A '||job as msg
from emp

-- MySQL
select concat(ename, ' WORK AS A ',job) as msg
from emp

-- SQL Server
select ename + ' WORK AS A ' + job as msg
from emp

-- 1.8 Conditional logic in a SELECT statement
select ename, sal,
        case when sal<=2000 then 'UNDERPAID'
             when sal>=4000 then 'OVERPAID'
             else 'OK'
        end as pay_status
from emp

-- 1.9 limiting #rows returned

-- DB2
select *
from emp fetch first 5 rows only

-- MySQL and PostgreSQL
select *
from emp limit 5

-- SQL Server
select top 5 *
from emp

-- Oracle
select *
from emp
where rownum <= 5

-- Oracle's ROWNUM are assigned after each row is fetched

-- 1.10 returning n random records from table

-- DB2
select ename, job
from emp
order by rand() fetch first 5 rows only

-- MySQL
select ename, job
from emp
order by rand() limit 5

-- PostgreSQL
select ename, job
from emp
order by random() limit 5

-- SQL server
select top 5 ename, job
from emp
order by newid()

-- Oracle
select *
from (
    select ename, job
    from emp
    order by dbms_random.value()
)
where rownum <= 5

-- 1.11 NULL values

select *
from emp
where comm is null


select *
from emp
where emp is not null

-- 1.12 transforming NULL into REAL values

-- COALESCE
select coalesce(comm,0)
from emp

-- CASE
select case when comm is not null then comm
            else 0
        end
from emp

-- 1.13 searching for patterns

select ename, job
from emp
where deptno in (10,20)
and (ename like '%I%' or job like '%ER')