----1----

set nocount on
	if  exists (select * from  SYS.OBJECTS        -- таблица Lb11 есть?
	            where OBJECT_ID= object_id(N'DBO.Lb11') )	            
	drop table Lb11; 
	          
	declare @c int, @flag char = 'c';  
	SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции

	CREATE table Lb11(K int );  -- начало транзакции 
		INSERT Lb11 values (1),(2),(3);
		set @c = (select count(*) from Lb11);
		print 'количество строк в таблице Lb11: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;   -- завершение транзакции: фиксация 
		   else   rollback;  -- завершение транзакции: откат 
		    
      SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	
	if  exists (select * from  SYS.OBJECTS     -- таблица Lb11 есть?
	            where OBJECT_ID= object_id(N'DBO.Lb11') )
	print 'таблица Lb11 есть';  
      else print 'таблицы Lb11 нет'


----2----
use [UNIVER-7]

	begin try
		begin TRAN --нач явн транз
			insert into FACULTY(FACULTY,FACULTY_NAME)	
					values ('TEST','testovoe znach')
			delete from FACULTY where FACULTY_NAME='TEST'
		commit TRAN --фиксирование
	end try

	begin catch
		print 'ERROR '+ cast(error_number() as nvarchar(20));
		print error_message();
		print ' '
			if @@TRANCOUNT>0 rollback TRAN; --откат
	end catch;
		

----3----оператор SAVE TRANSACTION (контрольная точка )
use [UNIVER-7]

declare @contrPoint varchar(32);
	begin try
		begin TRAN
			delete from FACULTY where FACULTY_NAME='TEST'				
				set @contrPoint='point 1';
					save TRAN @contrPoint;
			insert into FACULTY(FACULTY,FACULTY_NAME)
						values ('TEST','testovoe znach')	
				set @contrPoint='point 2';
					save TRAN @contrPoint;
			insert into FACULTY(FACULTY,FACULTY_NAME)	
					values ('TEST','testovoe znach ')
		commit tran;
	end try

	begin catch
		print 'Ошибка: ' + case 
						when error_number() = 2627 and patindex('%FACULTY_PK%', error_message()) > 0
								then 'дублирование факультета'
						ELSE 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
						   end;

		if @@TRANCOUNT > 0
			begin 
				print 'контрольная точка: ' + @contrPoint;
				print ' '
				rollback TRAN @contrPoint;		--откат к контрольной точке
				commit TRAN;				--фиксация изменений, выпоолненных до контрольной точки
			end
		end catch;


----4----

use UNIVER
set transaction isolation level READ UNCOMMITTED --каждая трнз видит незафикс изменения другой транз

--------- A ---------
	begin transaction 
-------------------------- t1 ------------------
		select @@SPID Процесс, 'INSERT AUDITORIUM' Результат, * from AUDITORIUM  --возвращает системный идентификатор процесса, назначенный сервером текущему подключению.
					where AUDITORIUM = '123456'
		select @@SPID Процесс, 'UPDATE AUDITORIUM' Результат, * from AUDITORIUM 
					where AUDITORIUM = '123456' 
		commit;
-------------------------- t2 -----------------
--------- B ---------
	begin transaction 
		insert AUDITORIUM values ('123456', 'ЛК-К', 80, '1234') --неподтвержден /неповатор чтение
		update AUDITORIUM set AUDITORIUM = '123456'
						  where AUDITORIUM = '1234567' 
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback


----5----

use UNIVER
set transaction isolation level READ COMMITTED  -- только зафиксированные изменения из других тр
-- A ---
	begin transaction 
		select count(*) from AUDITORIUM where AUDITORIUM = '1234'
-------------------------- t1 ------------------ 
-------------------------- t2 -----------------
		select 'update' результат, count(*) from AUDITORIUM where AUDITORIUM = '1234'
	commit

--- B ---	
begin transaction 	  
-------------------------- t1 --------------------
		update AUDITORIUM set AUDITORIUM = '1234' where AUDITORIUM = '123456' 
	commit;
-------------------------- t2 --------------------


----6----

-- A ---
set transaction isolation level  REPEATABLE READ --не видим в исполняющейся транзакции измененные/удаленные записи другой транзакцией. Но все еще видим вставленные записи из другой транзакции
	begin transaction 
		select AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM = '1234'
-------------------------- t1 ------------------ 
-------------------------- t2 ------------------
	select case
       when AUDITORIUM_CAPACITY = 50 then 'insert' 
	   else '---' 
	end 'результат', AUDITORIUM from AUDITORIUM where AUDITORIUM = '1234'
commit


----7----

-- A ---
set transaction isolation level SERIALIZABLE -- никакого влияния друг на друга нет.
	begin transaction 
		delete AUDITORIUM where AUDITORIUM = '1234'
		insert AUDITORIUM values ('1234', 'ЛК-К', 10, 'Луч')
		update AUDITORIUM set AUDITORIUM_NAME = 'Луч' where AUDITORIUM = '1234'
		select AUDITORIUM from AUDITORIUM where AUDITORIUM = '1234'
-------------------------- t1 -----------------
	select AUDITORIUM from AUDITORIUM where AUDITORIUM = '1234'
-------------------------- t2 ------------------ 
commit 	

--- B ---	
	begin transaction 	  
		delete AUDITORIUM where AUDITORIUM_NAME = 'Луч'; 
		insert AUDITORIUM values ('1234', 'ЛК-К', 10, 'Луч')
		update AUDITORIUM set AUDITORIUM_NAME = 'Луч' where AUDITORIUM = '1234'
		select AUDITORIUM from AUDITORIUM  where AUDITORIUM = '1234'
-------------------------- t1 --------------------
commit

	select AUDITORIUM from AUDITORIUM  where AUDITORIUM = '1234'
-------------------------- t2 -------------------


----8---- вложенные транзакции
	begin tran
		insert AUDITORIUM_TYPE values ('ЛБ-М', 'какой то тип')
		begin tran  -- внутренняя транзакция
			update AUDITORIUM set AUDITORIUM = '1234' where AUDITORIUM_TYPE = 'ЛК-К'
			commit  --внутреняя
		if @@TRANCOUNT > 0 -- внешняя транзакция уровень вложенности транзакции 
	rollback

	select (select count(*) from AUDITORIUM where AUDITORIUM_TYPE = 'ЛБ-М') Аудитории,
		   (select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛБ-М') Тип

