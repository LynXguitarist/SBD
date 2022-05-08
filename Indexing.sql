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

-- force index/no index(not working)
select  /*+ NO_INDEX (uscensus pk_uscensus)*/ * from uscensus where id=9000;

-- 3


