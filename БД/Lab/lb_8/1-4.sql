-------1-------
use master

DECLARE @ch char='c',
		@vch varchar(3)='rrr',
		@dt datetime,
		@tm time,
		@it int,
		@smli smallint,
		@tni tinyint,
		@nmr numeric(12,5);

	SET @dt=GETDATE();
	SET @tm=(SELECT GETDATE() );

	SELECT @it=127, @smli=4,@tni=47;

SELECT @ch char,@vch varchar ,@dt datetime,@tm time;

PRINT 'tm=' + cast(@tm as varchar);
PRINT 'Int=' + convert(varchar, @it);
PRINT 'Smallint=' + convert(varchar, @smli);
PRINT 'tinyint=' + convert(varchar, @tni);
PRINT 'numeric=' + convert(varchar, @nmr);

-------2-------

use UNIVER;

DECLARE @capact int = (select cast(sum (AUDITORIUM_CAPACITY) as int) from AUDITORIUM),
		@kol_vo_Audit int,
		@avg int,
		@kol_vo_min_avg int,
		@proc_min_avg numeric(4,2)

	if @capact < 200
		begin
			set @kol_vo_Audit = (select cast(count(*) as int) from AUDITORIUM);
			set @avg = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM);
			set @kol_vo_min_avg = (select cast(count (*) as int)from AUDITORIUM	
																where AUDITORIUM_CAPACITY<@avg);
			set @proc_min_avg = @kol_vo_min_avg *100 / @kol_vo_Audit;

			select @capact 'Общая вместимость',
					@kol_vo_Audit 'Количество аудиторий',
					@avg 'Средняя вместиомсть',
					@kol_vo_min_avg 'Вместимость меньше ср',
					@proc_min_avg 'Процент меньше ср';
		end

		else 
			begin
				print 'Общая вместимость = '+ cast(@capact as varchar(10))+ '(меньше 200)';
			end
		

-------3-------


print ' ';
print ' ';
print 'Число обработанных строк :' + cast(@@ROWCOUNT as nvarchar(20)) ;
print 'Версия SQL Server : ' + cast(@@VERSION  as nvarchar(20));
print 'Возвращает системный идентификатор процесса, назначенный сервером текущему подключению :' + cast(@@SPID  as nvarchar(20));
print 'Код последней ошибки :' + cast(@@ERROR  as nvarchar(20));
print 'Имя сервера :' + cast(@@SERVERNAME   as nvarchar(20));
print 'Возвращает уровень вложенности транзакции :' + cast(@@TRANCOUNT   as nvarchar(20));
print 'Проверка результата считывания строк результирующего набора :' + cast(@@FETCH_STATUS   as nvarchar(20));
print 'Уровень вложенности текущей процедуры :' + cast(@@FETCH_STATUS   as nvarchar(20));



-------4-------

DECLARE @z float, @x float = 27, @t float=14;
	if (@t>@x)
		set @z = POWER(sin(@t),2);
	else if (@t<@x)
		set @z = 4*(@t + @x);
	else 
		set @z = 1 - EXP(@x-2);


-------4.2-------

DECLARE @F nvarchar(30)= 'Макейчик',
		@I nvarchar(30)= 'Татьяна',
		@O nvarchar(30)='Леонидовна',
		@FullName nvarchar(60),
		@ShortName nvarchar(60);

		set @FullName = @F + ' '+ @I + ' '+ @O;
		set @O = substring(@O, 1,1)+'.';
		set @I = substring(@I, 1,1)+'.';
		set @ShortName =@F + ' ' + @I + ' ' + @O;

		select @FullName [Полное];
		select @ShortName[Сокращенное];

-------4.3-------
USE UNIVER;

SELECT STUDENT.NAME [Имя студента],
	   STUDENT.BDAY [День рождения],
	   DATEDIFF(YEAR, STUDENT.BDAY, SYSDATETIME()) AS [Количество полных лет]
FROM STUDENT 
WHERE MONTH(STUDENT.BDAY) = MONTH(DATEADD(m, 1, SYSDATETIME()))

-------4.4-------

DECLARE @testday date

SET @testday = (SELECT PROGRESS.PDATE 
				FROM PROGRESS Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
				WHERE PROGRESS.SUBJECT in('СУБД') and STUDENT.IDSTUDENT in('1026'))

PRINT 'День недели, в который студенты сдавали экзамен по СУБД: ' + CONVERT (varchar(12), DATEPART(dw, @testday))

