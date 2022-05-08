-- executation plan for the query
explain plan set statement_id='q1' into plan_table for
select * from uscensus where id=9000;

select operation, options, object_name, position, cost from plan_table; -- COST = 2, 2, 1

-- Force Update Info in plan_table
-- analyze table <Table_Name> compute statistics;
-- analyze index <Index_Name> compute statistics;
        
        
-- For checking the execution time of a query (in milliseconds) you may execute
-- 8018 ms without PK, 5448 with PK, 3393 with index, 7921 without index
select sql_text, elapsed_time
from V$SQLAREA
where sql_text like 'select  /*+ NO_INDEX (uscensus pk_uscensus)*/ * from uscensus where id=9000';

-- 2

-- adds constraint to PK
alter table uscensus
add constraint pk_uscensus primary key(id);

-- drops the primary key
ALTER TABLE USCENSUS
DROP PRIMARY KEY;


select  /*+ NO_INDEX (uscensus pk_uscensus)*/ * from uscensus where id=9000;

-- 4 B+ Tree

select AVG(age) from uscensus where education = 'Preschool';

-- create index over education
create index education_index on uscensus (education);

-- 70287 ms without index, 4023 with index
select sql_text, elapsed_time
from V$SQLAREA
where sql_text like 'select AVG(age) from uscensus where education = ''Preschool''';

-- drops index
drop index education_index;

-- 5 bitmap index

select AVG(age) from uscensus where education = 'Preschool';

create bitmap index education_index on uscensus (education);

-- 4026 with bitmap index
select sql_text, elapsed_time
from V$SQLAREA
where sql_text like 'select AVG(age) from uscensus where education = ''Preschool''';


-- 6

select COUNT(*) from uscensus where education = 'Preschool';

-- 10958 ms without index, 3518 with B+Tree, 3670 with bitmap
select sql_text, elapsed_time
from V$SQLAREA
where sql_text like 'select COUNT(*) from uscensus where education = ''Preschool''';

-- 7

select * from uscensus where sex = 'Female' and country = 'Scotland' and income = '>50K';

-- 11118 ms without index, 
select sql_text, elapsed_time
from V$SQLAREA
where sql_text like 'select * from uscensus where sex = ''Female'' and country = ''Scotland'' and income = ''>50K''';

--Indices for sex, country, income, (sex, country), (country, sex), (sex, income), (income, sex), (country, income), (income, sex)
-- (sex, country, income), (sex, income, country), (country, sex, income), (country, income, sex), (income, sex, country) and (income, country, sex)




--8

explain plan set statement_id='q1' into plan_table for
-- selects to test

select operation, options, object_name, position, cost from plan_table; -- COST = 2, 2, 1
