-------5-------

use UNIVER;

DECLARE @capact int = (select cast(sum (AUDITORIUM_CAPACITY) as int) from AUDITORIUM)
	if @capact > 200
		begin

			print 'Общая вместимость = '+ cast(@capact as varchar(10));			
		end

		else 
			begin
				print 'Общая вместимость = '+ cast(@capact as varchar(10))+ '(меньше 200)';
			end

-------6-------

SELECT CASE
		when (pr.NOTE = 5) then 'пять'
		when (pr.NOTE = 6) then 'шесть'
		when (pr.NOTE between 6 and 7) then 'семь'
		when (pr.NOTE between 7 and 8) then 'восемь'
		else 'другая отметка'
		end [Оценка]
	FROM PROGRESS pr
	Inner Join STUDENT ON pr.IDSTUDENT = STUDENT.IDSTUDENT
		GROUP BY CASE 
			when (pr.NOTE = 5) then 'пять'
			when (pr.NOTE = 6) then 'шесть'
			when (pr.NOTE between 6 and 7) then 'семь'
			when (pr.NOTE between 7 and 8) then 'восемь'
			else 'другая отметка'
			end
		

-------7 Локальные временные таблицы -------

CREATE table #EXAMPLE
(
		Name nvarchar(20),
		Age int,
		Statuss nvarchar(20)
	);

SET nocount on;-- не выводить соообщ о вводе строк
DECLARE @i int=18;
	WHILE @i<28
		begin
			INSERT #EXAMPLE(Name,Age,Statuss)
				values('кто-то', @i, 'Человек' );
			SET @i=@i+1;
		end;
select * from  #EXAMPLE
go
drop table #EXAMPLE


-------8-------


DECLARE @i int = 48;
	print @i+1;
	print power(@i,3);

	return
	print @i+10;

-------9-------


	begin try
		update PROGRESS set NOTE = '' where NOTE = 9
	end try

	begin catch
		print 'код последней ошибки:' 
		print  ERROR_NUMBER()  
		print  'сообщение об ошибке:' 
		print   ERROR_MESSAGE() 
		print 'код последней ошибки:' 
		print ERROR_LINE() 
		print  'имя процедуры или NULL:' 
		print  ERROR_PROCEDURE() 
		print  'уровень серьезности ошибки:' 
		print  ERROR_SEVERITY()
		print  'метка ошибки:' 
		print  ERROR_STATE() 

	end catch	