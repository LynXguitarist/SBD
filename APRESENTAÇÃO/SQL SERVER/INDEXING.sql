-- 1 -> comparar todos os indices iguais no Oracle vs SQL Server
	-- Clustered, NonClustered

-- 2 -> ver tambem indices diferentes
	-- SQL Server -> 2filtered (parecido ao bitmap), full text
	-- Oracle -> 2bitmap

-- 3 -> Ver hash, comparar Oracle vs SQL Server e dps passar para Sim�es testar
	-- se mais r�pido index + hash join ou s� um deles

-- 4 -> mostrar included columns vs multi attribute index

select * from alunos;