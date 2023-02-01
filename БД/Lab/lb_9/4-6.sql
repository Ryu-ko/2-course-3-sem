-------4-------

CREATE table #TEST4
(
	TKEY int,
	CC int identity(1,1),
	TF varchar(100)
);
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST4(TKEY, TF)
			values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

SELECT TKEY from #TEST4 WHERE TKEY between 5000 and 1999;--0.00000012
SELECT TKEY from #TEST4 WHERE TKEY>15000 and  TKEY < 20000; -- 0.088245
SELECT TKEY from  #TEST4 WHERE TKEY=17000;-- 0.0220785

CREATE index #TEST4_WHERE on #TEST4(TKEY)
							WHERE (TKEY>-1500 and TKEY<20000)

SELECT TKEY from  #TEST4 WHERE TKEY between 5000 and 19999; -- 0.441751
SELECT TKEY from  #TEST4 WHERE TKEY > 15000 and  TKEY < 20000; --- 0.168664
SELECT TKEY from  #TEST4 WHERE TKEY = 17000;-- 0.0032836

DROP index #TEST4_WHERE on #TEST4
DROP TABLE #TEST4


-------5-------

CREATE table #TEST5
(
	TKEYY int,
	CCC int identity(1,1),
	TFF varchar(100)
);

SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST5(TKEYY, TFF)
			values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

CREATE index #TEST5_TKEYY ON #TEST5(TKEYY); 

SELECT name [������], avg_fragmentation_in_percent [������������ (%)]--������� ������������ �������
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), --���������� �������� � ������� � ������������ ��� ������ � �������� ��������� ������� ��� ������������� � SQL Server.
        OBJECT_ID(N'#TEST5'), NULL, NULL, NULL) ss --���������� ����������������� ����� ������� ���� ������ ��� ������� ������� �����.
        JOIN sys.indexes ii 
		ON ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;

INSERT top(10000) #TEST5(TKEYY, TFF) select TKEYY, TFF from #TEST5;


ALTER index #TEST5_TKEYY on #TEST5 reorganize --������������� (-����� �� ������)

ALTER index #TEST5_TKEYY on #TEST5 rebuild with (online = off) --(������ ����� �������) �������� ����� ��� ������ => �����=0


DROP index #TEST5_TKEYY on #TEST5
DROP TABLE #TEST5


-------6-------

CREATE table #TEST6
(
	TKEYyy int,
	CCcc int identity(1,1),
	TFfff varchar(100)
);
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST6(TKEYyy, TFfff)
				values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

CREATE index #TEST6_TKEYyyy on #TEST6(TKEYyy) with (fillfactor = 65); --��������� ������� ���������� ��������� ������� ������� ������.

INSERT top(50) percent INTO #TEST6(TKEYyy, TFfff) 
                       SELECT TKEYyy, TFfff  FROM #TEST6;

SELECT name [������], avg_fragmentation_in_percent [������������ (%)]
       FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
       OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
                                     ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                                                                                          WHERE name is not null;

DROP index #TEST6_TKEYyyy on #TEST6
DROP TABLE #TEST6

