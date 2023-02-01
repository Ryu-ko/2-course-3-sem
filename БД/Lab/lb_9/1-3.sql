-------1-------

USE UNIVER
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'STUDENT'

CREATE TABLE #LCTBL
	(
		intt int,
		ttfld varchar(100)
	);

SET nocount on;
DECLARE @i1 int = 0;
WHILE @i1 < 1000
	begin
		INSERT #LCTBL(intt, ttfld)
			values(floor(20000*RAND()),REPLICATE('_txt_',2));
	IF(@i1 % 100 = 0) PRINT @i1;
	SET @i1 = @i1 + 1;
	end;

SELECT * FROM #LCTBL where intt between 1500 and 2500 order by intt --0.066042

checkpoint;  --фиксация БД

DBCC DROPCLEANBUFFERS  --очистить буферный кэш

CREATE clustered index #LCTBL_CL on #LCTBL(intt asc)

SELECT * FROM #LCTBL where intt between 1500 and 2500 order by intt --0.0033284
  
DROP index #LCTBL_CL ON #LCTBL
DROP TABLE #LCTBL


-------2-------

CREATE table #TEST2
(
	TKEY int,
	CC int identity(1,1),
	TF varchar(100)
);

SET nocount on;
DECLARE @i2 int = 0;
WHILE @i2 < 20000
	begin
		INSERT #TEST2(TKEY, TF)
			values(floor(20000*RAND()),REPLICATE('_txt_',2));
	SET @i2 = @i2 + 1;
	end;

SELECT count(*)[количество строк] FROM #TEST2;
SELECT * FROM #TEST2


CREATE index #TEST2_NONCLU on #TEST2(TKEY, CC)--- составной индекс

SELECT * from  #TEST2 where  TKEY > 1500 and  CC < 4500;  --не оптимиз 0.0845413
SELECT * from  #TEST2 order by  TKEY, CC

SELECT * from  #TEST2 where  TKEY = 556 and  CC > 3	 --оптимиз	 

DROP index #TEST2_NONCLU on #TEST2
DROP TABLE #TEST2


-------3-------

CREATE table #TEST3
(
	tkeyy int,
	ccc int identity(1,1),
	tff varchar(100)
);
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST3(tkeyy, tff)
			values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

SELECT ccc from #TEST3 where tkeyy>15000 --0.008245

CREATE  index #TEST3_TKEY_X on #TEST3(tkeyy) INCLUDE (ccc) --Некластеризованный индекс покрытия 

SELECT ccc from #TEST3 where tkeyy>15000 --0.0183955

DROP index #TEST3_TKEYY_X on #TEST3
DROP TABLE #TEST3










