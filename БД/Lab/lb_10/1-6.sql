USE UNIVER

DECLARE @one char(20), @all char(200)='';
DECLARE Curs CURSOR
			for select SUBJECT.SUBJECT
				FROM SUBJECT 
					WHERE SUBJECT.PULPIT LIKE 'ИСиТ';

	OPEN CURS;
	FETCH CURS INTO @one; ---Оператор FETCH считывает одну строку из результирующего набора и продвигает указатель на следующую строку. 
		print 'Дисциплины на кафедре ИСиТ';
		 while @@FETCH_STATUS=0
			begin 
				set @all=RTRIM(@one)+','+@all; --удаляет конечные пробелы из строки
				FETCH CURS into @one;
			end;
		print @all;
		CLOSE CURS; 
		
		print '';
DEALLOCATE CURS;
GO

----2----

DECLARE CRS CURSOR LOCAL
			for SELECT A.AUDITORIUM_TYPE,A.AUDITORIUM_CAPACITY FROM AUDITORIUM as A
	DECLARE @at nvarchar(20),@capat int;
		OPEN CRS;
			fetch CRS into @at,@capat;
				print '1.' +@at+cast(@capat as varchar(6));
				go
	DECLARE @at nvarchar(20),@capat int;
			fetch CRS into @at,@capat;
				print '2.' +@at+cast(@capat as varchar(6));
				go

DECLARE CRS CURSOR GLOBAL --
			for SELECT A.AUDITORIUM_TYPE,A.AUDITORIUM_CAPACITY FROM AUDITORIUM as A
	DECLARE @at nvarchar(20),@capat int;
		OPEN CRS;
			fetch CRS into @at,@capat;
				print '1.' +@at+cast(@capat as varchar(6));
				go
	DECLARE @at nvarchar(20),@capat int;
			fetch CRS into @at,@capat;
				print '2.' +@at+cast(@capat as varchar(6));
				close CRS;--
				deallocate CRS;--
				go

----3----

USE [UNIVER-7]
DECLARE CRS CURSOR LOCAL STATIC
			for SELECT PR.IDSTUDENT,PR.SUBJECT,PR.NOTE FROM PROGRESS as PR
											WHERE PR.SUBJECT ='СУБД';
	DECLARE @idST nvarchar(20),@subj nvarchar(20),@progr int;
		OPEN CRS;
			print 'Открыт курсор'
			print 'Количество строк:'+ cast(@@CURSOR_ROWS as varchar(5));
			UPDATE  PROGRESS set SUBJECT= 'КС' where SUBJECT='КГ';
			DELETE PROGRESS where SUBJECT ='КС';
			INSERT PROGRESS(SUBJECT,IDSTUDENT,PDATE,NOTE) values('СУБД',1004,'2013-01-12',9);
			DELETE PROGRESS  where IDSTUDENT =1004;

			fetch CRS into @idST,@subj,@progr;
			while @@FETCH_STATUS=0
				begin
					print @idST+' '+@subj+' '+cast(@progr as varchar(6));
					fetch CRS into @idST,@subj,@progr;
				end;
				CLOSE CRS
				
		

USE [UNIVER-7]
DECLARE CRS CURSOR LOCAL DYNAMIC
			for SELECT PR.IDSTUDENT,PR.SUBJECT,PR.NOTE FROM PROGRESS as PR
											WHERE PR.SUBJECT ='СУБД';
	DECLARE @idST nvarchar(20),@subj nvarchar(20),@progr int;
		OPEN CRS;
			print 'Открыт курсор'
			print 'Количество строк:'+ cast(@@CURSOR_ROWS as varchar(5));
			UPDATE  PROGRESS set SUBJECT= 'КС' where SUBJECT='КГ';
			DELETE PROGRESS where SUBJECT ='КС';
			INSERT PROGRESS(SUBJECT,IDSTUDENT,PDATE,NOTE) values('СУБД',1004,'2013-01-12',9);
			DELETE PROGRESS  where IDSTUDENT =1004;

			fetch CRS into @idST,@subj,@progr;
			while @@FETCH_STATUS=0
				begin
					print @idST+' '+@subj+' '+cast(@progr as varchar(6));
					fetch CRS into @idST,@subj,@progr;
				end;
				CLOSE CRS
				

----4----атрибут SCROLL доп опц позиционир. 

USE [UNIVER-7]
DECLARE CRS CURSOR LOCAL DYNAMIC SCROLL
			for SELECT ROW_NUMBER() over(ORDER by PR.IDSTUDENT),PR.SUBJECT,PR.NOTE FROM PROGRESS as PR
											WHERE PR.SUBJECT ='СУБД';
	DECLARE @idST4 nvarchar(20),@subj4 nvarchar(20),@progr4 int;
		
		OPEN CRS;	
		fetch CRS into @idST4,@subj4,@progr4;
		while @@FETCH_STATUS=0
				begin
					print @idST4+' '+rtrim(cast(@subj4 as varchar(6)))+' '+cast(@progr4 as varchar(6));
					fetch CRS into @idST4,@subj4,@progr4;
				end;	
			fetch FIRST from CRS into @idST4,@subj4,@progr4;
			print'Первая строка   '+@idST4+' '+rtrim(cast(@subj4 as varchar(6))) +' '+rtrim(cast(@progr4 as varchar(6)));
			
			fetch NEXT from CRS into @idST4,@subj4,@progr4;
			print'Cледующая строка за текущей   '+@idST4+' '+rtrim(cast(@subj4 as varchar(6)))+'  '+rtrim(cast(@progr4 as varchar(6)));
			
			fetch PRIOR from CRS into @idST4,@subj4,@progr4;
			print'Предыдущая строка от текущей   '+@idST4+' '+rtrim(cast(@subj4 as varchar(6))) +' '+rtrim(cast(@progr4 as varchar(6)));
			
			fetch ABSOLUTE 3 from CRS into @idST4,@subj4,@progr4;
			print'Третья строка от начала   '+@idST4+' '+rtrim(cast(@subj4 as varchar(6))) +' '+rtrim(cast(@progr4 as varchar(6)));
			
			fetch ABSOLUTE -3 from CRS into @idST4,@subj4,@progr4;
			print'Третья строка от конца   '+@idST4+' '+rtrim(cast(@subj4 as varchar(6))) +' '+rtrim(cast(@progr4 as varchar(6)));
			fetch RELATIVE 2 from CRS into @idST4,@subj4,@progr4;
			print'Вторая строка вперед от текущей   '+@idST4+' '+rtrim(cast(@subj4 as varchar(6))) +' '+rtrim(cast(@progr4 as varchar(6)));
			fetch RELATIVE -2 from CRS into @idST4,@subj4,@progr4;
			print'Вторая строка назад от текущей   '+@idST4+' '+rtrim(cast(@subj4 as varchar(6))) +' '+rtrim(cast(@progr4 as varchar(6)));			
				CLOSE CRS;
deallocate CRS;--!

----5----CURRENT OF 

USE [UNIVER-7]
DECLARE CRS CURSOR LOCAL DYNAMIC
			for SELECT PR.IDSTUDENT,PR.SUBJECT,PR.NOTE FROM PROGRESS as PR FOR UPDATE;--
	DECLARE @idST nvarchar(20),@subj nvarchar(20),@progr int;
		OPEN CRS;
			fetch CRS into @idST,@subj,@progr;
			DELETE PROGRESS where CURRENT OF CRS;--
			fetch CRS into @idST,@subj,@progr;
			UPDATE  PROGRESS set PROGRESS.NOTE=PROGRESS.NOTE+1 where CURRENT OF CRS;
			
			while @@FETCH_STATUS=0
				begin
					print @idST+' '+@subj+' '+cast(@progr as varchar(6));
					fetch CRS into @idST,@subj,@progr;
				end;
				CLOSE CRS
deallocate CRS;--!

----6----

USE [UNIVER-7]
SELECT GROUPS.FACULTY, STUDENT.NAME, PROGRESS.NOTE 
	FROM STUDENT 
	Inner Join GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
	Inner Join PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE PROGRESS.NOTE < 4

	DECLARE @faclt nvarchar(4), @name nvarchar(30), @prNote int
	DECLARE Badmark CURSOR LOCAL DYNAMIC
		for SELECT GROUPS.FACULTY, STUDENT.NAME, PROGRESS.NOTE 
			FROM STUDENT 
			Inner Join GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
			Inner Join PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
			WHERE PROGRESS.NOTE < 4

		OPEN Badmark
		FETCH Badmark into @faclt, @name, @prNote
		print cast(@faclt as nvarchar(10)) + ' ' + @name + ' ' + cast(@prNote as nvarchar(2))
		DELETE PROGRESS WHERE CURRENT OF Badmark
		CLOSE Badmark


			DECLARE @faclt2 nvarchar(4), @name2 nvarchar(30),@prNote2  int
			DECLARE UPDNote CURSOR LOCAL DYNAMIC
				for SELECT GROUPS.FACULTY, STUDENT.NAME, PROGRESS.NOTE 
					FROM STUDENT 
					Inner Join GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
					Inner Join PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
												WHERE PROGRESS.IDSTUDENT =1022  FOR UPDATE;
			
			OPEN UPDNote
					FETCH UPDNote into @faclt2, @name2, @prNote2;
					UPDATE PROGRESS set PROGRESS.NOTE=PROGRESS.NOTE +1 WHERE CURRENT OF UPDNote;
					print cast(@faclt2 as nvarchar(10)) + ' ' + @name2 + ' ' + cast(@prNote2 as nvarchar(2))
					CLOSE UPDNote
		




