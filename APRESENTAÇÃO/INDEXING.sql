-- duplicate tables
SELECT *
INTO dbo.alunos_no_index
FROM dbo.alunos;

-- included columns vs multi attribute index --

select * from alunos
where num_aluno = 5

-- included
SELECT *
FROM [SBD_PJ].[dbo].[alunos_incCol]
where num_aluno = 5

-- not included
SELECT *
FROM [SBD_PJ].[dbo].[alunos_no_index]
where num_aluno = 5

-- selecting included column

select cod_curso from alunos
where num_aluno = 5

-- included
SELECT cod_curso
FROM [SBD_PJ].[dbo].[alunos_incCol]
where num_aluno = 5

-- not included
SELECT cod_curso
FROM [SBD_PJ].[dbo].[alunos_no_index]
where num_aluno = 5

-- FULL TEXT --

CREATE UNIQUE INDEX ft_nome_index ON dbo.categorias(nome);
CREATE FULLTEXT CATALOG ft AS DEFAULT;  
CREATE FULLTEXT INDEX ON dbo.categorias(Resume)   
   KEY INDEX nome  
   WITH CHANGE_TRACKING=MANUAL; -- manual change tracking population, 
								-- only full when START FULL POPULATION or START INCREMENTAL POPULATION

   -- WITH CHANGE_TRACKING=OFF, NO POPULATION; -- no tracking, no full population

-- MEM OPTIMIZED --

ALTER DATABASE SBD_PJ ADD FILEGROUP SBD_PJ_mod
    CONTAINS MEMORY_OPTIMIZED_DATA;

ALTER DATABASE SBD_PJ ADD FILE (
    name='SBD_PJ_mod1', filename='D:\FCT\SBD\PRATICA\SBD\APRESENTAÇÃO\mod')
    TO FILEGROUP SBD_PJ_mod;

CREATE TABLE SupportEvent  
(  
    SupportEventId   int               not null   identity(1,1)  
    PRIMARY KEY NONCLUSTERED,  

    StartDateTime        datetime2     not null,  
    CustomerName         nvarchar(16)  not null,  
    SupportEngineerName  nvarchar(16)      null,  
    Priority             int               null,  
    Description          nvarchar(64)      null  
)  
    WITH (  
    MEMORY_OPTIMIZED = ON);  

    --------------------  

--ALTER TABLE SupportEvent  
    --ADD CONSTRAINT constraintUnique_SDT_CN  
    --UNIQUE NONCLUSTERED (StartDateTime DESC, CustomerName);    

--ALTER TABLE SupportEvent  
    --ADD INDEX idx_hash_SupportEngineerName  
    --HASH (SupportEngineerName) WITH (BUCKET_COUNT = 64);  -- Nonunique.  


INSERT INTO SupportEvent  
    (StartDateTime, CustomerName, SupportEngineerName, Priority, Description)  
    VALUES  
    ('2016-02-23 13:40:41:123', 'Abby', 'Zeke', 2, 'Display problem.'     ),  
    ('2016-02-24 13:40:41:323', 'Ben' , null  , 1, 'Cannot find help.'    ),  
    ('2016-02-25 13:40:41:523', 'Carl', 'Liz' , 2, 'Button is gray.'      ),  
    ('2016-02-26 13:40:41:723', 'Dave', 'Zeke', 2, 'Cannot unhide column.'); 
