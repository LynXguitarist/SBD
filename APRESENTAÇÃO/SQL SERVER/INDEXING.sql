-- 1 -> comparar todos os indices iguais no Oracle vs SQL Server
	-- Clustered, NonClustered

-- 2 -> ver tambem indices diferentes
	-- SQL Server -> 2filtered (parecido ao bitmap), full text
	-- Oracle -> 2bitmap

-- 3 -> Ver hash, comparar Oracle vs SQL Server e dps passar para Simões testar
	-- se mais rápido index + hash join ou só um deles

-- 4 -> mostrar included columns vs multi attribute index

select * from alunos;