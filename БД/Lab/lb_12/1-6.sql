use UNIVER
go
	CREATE PROCEDURE PSUBJECT
		as 
		begin
			DECLARE @cnt int=(select count(*) from SUBJECT);
			SELECT S.SUBJECT,S.SUBJECT_NAME,S.PULPIT From SUBJECT as S;
			return @cnt;
		end;
		

		declare @cnt_out int=0;
		EXEC @cnt_out=PSUBJECT;
		print 'kol-vo '+ cast(@cnt_out as varchar(3));			

	DROP PROCEDURE PSUBJECT


----3----

CREATE TABLE #SUBJECT
(
	SUBJECTT nvarchar(20) ,
	SUBJECTT_NAME nvarchar(50) ,
	PULPITT nvarchar(20)
)

go
	ALTER PROC PSUBJECT @p varchar(20)= null 
		as begin
			select SUBJECT [Код], SUBJECT_NAME [Дисциплина], PULPIT [Кафедра] from SUBJECT 
										where PULPIT = @p;
		end
go

go
	INSERT #SUBJECT EXEC PSUBJECT @p='ИСИТ'
	INSERT #SUBJECT EXEC PSUBJECT @p='ЛУ'
	SELECT * FROM #SUBJECT
go

DROP TABLE #SUBJECT;


----4----
go
CREATE PROC PAUDITORIUM_INSERT
			@a char(20), @n varchar(50),@c int = 0, @t char(10)
as begin
	begin try
		INSERT INTO  AUDITORIUM(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_CAPACITY,AUDITORIUM_TYPE)
					values(@a,@n,@c,@t)
				return 1;
	end try
	begin catch
		print 'ERROR NUM: '+ cast(error_number() as varchar(20));
		print 'Сообщение: '+ error_message();
		print 'Уровень: '+ cast(error_severity() as varchar(20));
		return -1;
	end catch;
end;

go
	set nocount on
	DECLARE @res int
		begin tran 
			EXEC @res= PAUDITORIUM_INSERT @a='222-1',@n='ЛБ-К' ,@c=20, @t='222-1' print ' ';
				if @res=1
					print('Процедура: выполнена')
				else print('Процедура: не выполнена')
			rollback

	DECLARE @res2 int
			begin tran 
				EXEC @res2= PAUDITORIUM_INSERT @a='111-2',@n='ЛК-К' ,@c=80, @t='111-2'print ' ';
					if @res2=1
						print('Процедура: выполнена')
					else print('Процедура: не выполнена')
				rollback

DROP PROC PAUDITORIUM_INSERT


----5----
go
CREATE PROC SUBJECT_REPORT @p char(10)--kod kafedri
	as 
	begin
		DECLARE @counter int = 0;

	begin try
		DECLARE @sub nvarchar(10), @line_sub nvarchar(500) = ''
		DECLARE Subjects cursor local static for
		select SUBJECT from SUBJECT 
						where PULPIT = @p order by PULPIT
			if not exists (select PULPIT from SUBJECT where PULPIT = @p)
				begin
					raiserror('Ошибка, нет таких кафедр', 11, 1);
					/*RAISERROR, которая содержит три параметра: текстовое сообщение об ошибке, уровень серьезности ошибки и метку. 
					Если уровень серьез-ности равен 11, то управление передается в блок обработки ошибок*/
				end
			else
				begin
					open Subjects
					fetch Subjects into @sub
					set @line_sub = rtrim(@sub)
					--rtrim возвращает строку символов, из которой удалены все завершающие пробелы.
					set @counter +=1
					fetch Subjects into @sub
					while @@FETCH_STATUS = 0
						begin
							set @line_sub = '' + rtrim(@sub) + ', ' + @line_sub
							set @counter +=1
							fetch Subjects into @sub
						end
					print 'Предметы на кафедре ' + rtrim(@p) + ': ' + @line_sub
					return @counter
				end
		end try

		begin catch
			print 'Ошибка в параметрах' 
			if error_procedure() is not null   
				print 'Имя процедуры : ' + error_procedure()
			return @counter
		end catch

	end
go

	DECLARE @c int
	EXEC @c = Subject_Report @p = 'ИСиТ'
	print 'Количество предметов на специальности: ' + cast(@c as nvarchar)

	drop procedure SUBJECT_REPORT;


----6----

go

CREATE PROC PAUDITORIUM_INSERTX
		 @a_ char(20), @n_ varchar(50), @c_ int = 0, @t_ char(10), @tn_ varchar(50)
	as begin
		declare @err nvarchar(50) = 'Ошибка: '
	declare @rez int
		set transaction isolation level serializable
			begin tran
				begin try
					insert into AUDITORIUM_TYPE values (@t_, @tn_)
						exec @rez = PASUDITORIUM_INSERT @a = @a_, @n = @n_, @c = @c_, @t = @t_
						if (@rez = -1)
								return -1		
				end try

				begin catch
					set @err = @err + error_message()
					raiserror(@err, 11, 1)
					rollback
					return -1
				end catch

			commit tran

		return 1
end
go

declare @rez int
begin tran
exec @rez = PAUDITORIUM_INSERTX @a_ = '208-1', @n_ = '208-1', @c_ = 90, @t_ = '208-1', @tn_ = '----' 
print @rez
if @rez = 1
	select * from AUDITORIUM
	select * from AUDITORIUM_TYPE
rollback
go

drop procedure PAUDITORIUM_INSERTX;









