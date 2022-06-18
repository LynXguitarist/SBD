--drop table cursos;
create table cursos(cod_curso TINYINT not null, 
		nome VARCHAR(35) not null,
		primary key (cod_curso));


--drop table departamentos;
create table departamentos (cod_departamento TINYINT not null,
		nome VARCHAR(40) not null,
		primary key (cod_departamento));

--drop table alunos;
create table alunos (num_aluno INT not null,
		nome NVARCHAR(30) not null,
		local NVARCHAR(25),
		data_nsc date,
		sexo char(1) not null CHECK ( sexo IN ( 'F' , 'M' )  ), 
		cod_curso TINYINT not null,
		primary key (num_aluno),
		unique (num_aluno, cod_curso),
		foreign key (cod_curso) references cursos);

--drop table cadeiras;
create table cadeiras(cod_cadeira SMALLINT not null,
		nome VARCHAR(40) not null,
		creditos TINYINT not null,
		cod_departamento TINYINT not null,
		primary key (cod_cadeira),
		foreign key (cod_departamento) references departamentos);

--drop table curso_cadeira;
create table curso_cadeira( cod_curso TINYINT not null, 
		cod_cadeira SMALLINT not null,
		semestre TINYINT not null,
		primary key (cod_curso, cod_cadeira),
		foreign key (cod_curso) references cursos,
		foreign key (cod_cadeira) references cadeiras);

--drop table inscricoes;
create table inscricoes(num_aluno INT not null,
		cod_curso TINYINT not null,
		cod_cadeira SMALLINT not null, 
		data_inscricao date not null,
		data_avaliacao date,
		nota TINYINT,
		primary key (num_aluno, cod_curso, cod_cadeira, data_inscricao),
		foreign key (num_aluno, cod_curso) references alunos(num_aluno, cod_curso),
		foreign key (cod_curso, cod_cadeira) references curso_cadeira);

--drop table categorias;
create table categorias(cod_categoria TINYINT not null,
		nome NVARCHAR(30) not null,
		vencimento INT not null,
		primary key (cod_categoria));

--drop table docentes;
create table docentes(cod_docente SMALLINT not null,
		nome VARCHAR(30) not null,
		cod_departamento TINYINT not null,
		cod_categoria TINYINT not null,
		primary key (cod_docente),
		foreign key (cod_departamento) references departamentos,
		foreign key (cod_categoria) references categorias);

--drop table precedencias;
create table precedencias(cod_curso TINYINT not null,
		cod_cadeira SMALLINT not null,
		cod_cadeira_p SMALLINT not null,
		primary key (cod_curso, cod_cadeira, cod_cadeira_p),
		foreign key (cod_curso, cod_cadeira) references 
				curso_cadeira(cod_curso,cod_cadeira),
		foreign key (cod_curso, cod_cadeira_p) references 
				curso_cadeira(cod_curso,cod_cadeira));

--drop table historico_categorias;
create table historico_categorias(cod_docente SMALLINT not null,
		cod_categoria TINYINT not null,
		data date not null,
		primary key (cod_docente, cod_categoria),
		foreign key (cod_docente) references docentes(cod_docente),
		foreign key (cod_categoria) references categorias(cod_categoria));



--drop sequence seq_aluno;
create sequence seq_aluno increment by 1 start with 1;

--drop sequence seq_docente;
create sequence seq_docente increment by 1 start with 1;

--drop sequence seq_curso;
create sequence seq_curso increment by 1 start with 1;

--drop sequence seq_cadeira;
create sequence seq_cadeira increment by 1 start with 1;

--drop sequence seq_departamento;
create sequence seq_departamento increment by 1 start with 1;

--drop sequence seq_categoria;
create sequence seq_categoria increment by 1 start with 1;



/* Tabela cursos */
/* cod_curso, nome */

insert into cursos values(NEXT VALUE FOR seq_curso,'Engenharia Informatica');
insert into cursos values(NEXT VALUE FOR seq_curso,'Engenharia Electrotecnica');
insert into cursos values(NEXT VALUE FOR seq_curso,'Engenharia do Ambiente');
insert into cursos values(NEXT VALUE FOR seq_curso,'Matematica');
insert into cursos values(NEXT VALUE FOR seq_curso,'Arquitectura');

/* Tabela alunos */
/* num_aluno, nome, local, data_nsc, sexo, cod_curso */

insert into alunos values(NEXT VALUE FOR seq_aluno,'Joaquim Pires Lopes','Lisboa',CONVERT(DATE, '1992.01.01'),'M',2);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Ana Maria Fonseca','Setubal',CONVERT(DATE, '1992.03.01'),'F',1);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Paula Antunes','Lisboa',CONVERT(DATE, '1991.07.13'),'F',2);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Joana Ramalho Silva','Costa da Caparica',CONVERT(DATE, '1991.09.23'),'F',3);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Rui Manuel Silva','Cascais',CONVERT(DATE, '1991.08.15'),'M',1);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Joao Paulo Santos','Lisboa',CONVERT(DATE, '1992.11.16'),'M',1);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Cristina Fernandes Lopes','Lisboa',CONVERT(DATE, '1992.01.07'),'F',1);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Miguel Pinto Leite','Cascais',CONVERT(DATE, '1992.01.07'),'M',3);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Francisco Costa Rosa',NULL,CONVERT(DATE, '1990.02.16'),'M',4);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Elsa Fialho Pinto',NULL,CONVERT(DATE, '1989.10.29'),'F',1);
insert into alunos values(NEXT VALUE FOR seq_aluno,'Maria Pinto Ribeiro',NULL,CONVERT(DATE, '1993.10.20'),'F',1);

/* Tabela departamentos */
/* cod_departamento, nome */

insert into departamentos values(NEXT VALUE FOR seq_departamento, 'Departamento de Informatica');
insert into departamentos values(NEXT VALUE FOR seq_departamento, 'Departamento de Electrotecnia');
insert into departamentos values(NEXT VALUE FOR seq_departamento, 'Departamento de Matematica');
insert into departamentos values(NEXT VALUE FOR seq_departamento, 'Departamento de Ambiente');

/* Tabela cadeiras */
/* cod_cadeira, nome_cadeira, creditos, cod_departamento*/

insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Introducao a Programacao',4,1);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Inteligencia Artificial',4,1);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Redes de Computadores',4,1);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Bases de Dados',4,1);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Sistemas de Bases de Dados',3,1);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Metodologias Desenvolvimento de Software',4,1);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Sistemas Distribuidos',4,1);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Sistemas Logicos',4,2);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Microprocessadores',4,2);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Electronica Geral',3,2);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Analise Matematica 1',4,3);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Calculo Numerico',3,3);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Analise Matematica 2',5,3);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Climatologia',4,4);
insert into cadeiras values(NEXT VALUE FOR seq_cadeira,'Poluicao do Ar',2,4);

/* Tabela categorias */
/* cod_categoria, nome, vencimento */

insert into categorias values(NEXT VALUE FOR seq_categoria,'Assistente',2071);
insert into categorias values(NEXT VALUE FOR seq_categoria,'Professor Auxiliar',2885);
insert into categorias values(NEXT VALUE FOR seq_categoria,'Professor Associado',3255);
insert into categorias values(NEXT VALUE FOR seq_categoria,'Professor Catedratico',4217);

/* Tabela docentes */
/* cod_docente, nome, cod_departamento, cod_categoria */

insert into docentes values(NEXT VALUE FOR seq_docente,'Joana Ramalho Silva',1,1);
insert into docentes values(NEXT VALUE FOR seq_docente,'Filipe Costa Rocha',2,1);
insert into docentes values(NEXT VALUE FOR seq_docente,'Joao Mario Cunha',1,3);
insert into docentes values(NEXT VALUE FOR seq_docente,'Carla Maria Vargas',3,2);
insert into docentes values(NEXT VALUE FOR seq_docente,'Antonio Miguel Horta',3,3);
insert into docentes values(NEXT VALUE FOR seq_docente,'Eduardo Jose Durao',2,1);
insert into docentes values(NEXT VALUE FOR seq_docente,'Manuela Bravo Neves',1,2);
insert into docentes values(NEXT VALUE FOR seq_docente,'Sofia Alves Prazeres',1,3);
insert into docentes values(NEXT VALUE FOR seq_docente,'Joana Alves Pereira',4,2);


/* Tabela curso_cadeira */
/* cod_curso, cod_cadeira, semestre*/

insert into curso_cadeira values(1,1,1);
insert into curso_cadeira values(1,2,8);
insert into curso_cadeira values(1,3,5);
insert into curso_cadeira values(1,4,7);
insert into curso_cadeira values(1,5,8);
insert into curso_cadeira values(1,6,6);
insert into curso_cadeira values(1,7,8);
insert into curso_cadeira values(1,8,2);
insert into curso_cadeira values(1,11,1);
insert into curso_cadeira values(1,12,5);
insert into curso_cadeira values(1,13,2);
insert into curso_cadeira values(2,1,3);
insert into curso_cadeira values(2,4,9);
insert into curso_cadeira values(2,8,2);
insert into curso_cadeira values(2,9,4);
insert into curso_cadeira values(2,10,3);
insert into curso_cadeira values(2,11,1);
insert into curso_cadeira values(3,1,3);
insert into curso_cadeira values(3,8,4);
insert into curso_cadeira values(3,11,1);
insert into curso_cadeira values(3,14,4);
insert into curso_cadeira values(3,15,5);
insert into curso_cadeira values(4,1,3);
insert into curso_cadeira values(4,8,4);
insert into curso_cadeira values(4,11,1);
insert into curso_cadeira values(4,12,3);
insert into curso_cadeira values(4,13,2);

/* Tabela inscricoes */
/* num_aluno, cod_curso, cod_cadeira, data_inscricao, data_avaliacao, nota */

insert into inscricoes values( 1,2, 1,CONVERT(date, '2011-09-03'), CONVERT(date, '2012-02-11'),10);
insert into inscricoes values( 1,2, 8,CONVERT(DATE, '2011.09.05'),null,null);
insert into inscricoes values( 1,2, 9,CONVERT(DATE, '2012.10.06'),null,null);
insert into inscricoes values( 2,1, 1,CONVERT(DATE, '2009.10.23'),CONVERT(DATE, '2010.02.11'),11);
insert into inscricoes values( 2,1,11,CONVERT(DATE, '2009.09.23'),CONVERT(DATE, '2010.03.12'),13);
insert into inscricoes values( 2,1, 4,CONVERT(DATE, '2012.09.05'),null,null);
insert into inscricoes values( 2,1, 6,CONVERT(DATE, '2012.03.05'),CONVERT(DATE, '2012.07.05'),15);
insert into inscricoes values( 3,2, 1,CONVERT(DATE, '2004.10.05'),CONVERT(DATE, '2005.02.11'),12);
insert into inscricoes values( 3,2, 9,CONVERT(DATE, '2005.09.06'),null,null);
insert into inscricoes values( 4,3,14,CONVERT(DATE, '2004.10.05'),CONVERT(DATE, '2005.03.11'),10);
insert into inscricoes values( 5,1,1 ,CONVERT(DATE, '2012.09.07'),null,null);
insert into inscricoes values( 6,1,1 ,CONVERT(DATE, '2012.09.23'),null,null);
insert into inscricoes values( 6,1,11,CONVERT(DATE, '2012.09.23'),null,null);
insert into inscricoes values( 7,1, 1,CONVERT(DATE, '2010.09.08'),CONVERT(DATE, '2011.02.10'),13);
insert into inscricoes values( 7,1,11,CONVERT(DATE, '2010.09.06'),CONVERT(DATE, '2011.03.07'),17);
insert into inscricoes values( 7,1, 4,CONVERT(DATE, '2011.11.05'),CONVERT(DATE, '2012.07.12'),15);
insert into inscricoes values( 7,1, 2,CONVERT(DATE, '2011.11.05'),CONVERT(DATE, '2012.03.11'),13);
insert into inscricoes values( 8,3,14,CONVERT(DATE, '2005.10.11'),CONVERT(DATE, '2006.03.12'),14);
insert into inscricoes values( 9,4, 1,CONVERT(DATE, '2012.10.07'),null,null);
insert into inscricoes values( 9,4,11,CONVERT(DATE, '2012.10.07'),CONVERT(DATE, '2013.02.07'),12);
insert into inscricoes values( 9,4,13,CONVERT(DATE, '2012.10.07'),null,null);
insert into inscricoes values(10,1,11,CONVERT(DATE, '2006.09.11'),CONVERT(DATE, '2007.02.12'),15);
insert into inscricoes values(10,1,1 ,CONVERT(DATE, '2007.09.12'),CONVERT(DATE, '2008.02.11'),12);

/* Tabela historico_categorias */
/* cod_docente, cod_categoria, data_categoria */

insert into historico_categorias values(1,1,CONVERT(DATE, '2012.11.27'));
insert into historico_categorias values(2,1,CONVERT(DATE, '2011.12.13'));
insert into historico_categorias values(3,1,CONVERT(DATE, '2009.08.15'));
insert into historico_categorias values(3,2,CONVERT(DATE, '2011.01.08'));
insert into historico_categorias values(3,3,CONVERT(DATE, '2011.02.19'));
insert into historico_categorias values(4,2,CONVERT(DATE, '2000.02.03'));
insert into historico_categorias values(4,3,CONVERT(DATE, '2004.10.21'));
insert into historico_categorias values(4,4,CONVERT(DATE, '2009.09.17'));
insert into historico_categorias values(5,3,CONVERT(DATE, '2011.03.22'));
insert into historico_categorias values(6,3,CONVERT(DATE, '2009.05.02'));
insert into historico_categorias values(7,1,CONVERT(DATE, '2005.01.05'));
insert into historico_categorias values(8,2,CONVERT(DATE, '2010.11.07'));
insert into historico_categorias values(9,2,CONVERT(DATE, '2000.11.07'));

/* Tabela precedencias */
/* cod_curso, cod_cadeira, cod_cadeira_p */

insert into precedencias values(1,5,4);
insert into precedencias values(1,5,3);
insert into precedencias values(1,7,3);
insert into precedencias values(1,4,6);
insert into precedencias values(1,3,1);
insert into precedencias values(1,6,1);
insert into precedencias values(4,12,13);
insert into precedencias values(4,13,11);

commit;
