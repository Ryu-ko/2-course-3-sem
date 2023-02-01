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

			select @capact '����� �����������',
					@kol_vo_Audit '���������� ���������',
					@avg '������� �����������',
					@kol_vo_min_avg '����������� ������ ��',
					@proc_min_avg '������� ������ ��';
		end

		else 
			begin
				print '����� ����������� = '+ cast(@capact as varchar(10))+ '(������ 200)';
			end
		

-------3-------


print ' ';
print ' ';
print '����� ������������ ����� :' + cast(@@ROWCOUNT as nvarchar(20)) ;
print '������ SQL Server : ' + cast(@@VERSION  as nvarchar(20));
print '���������� ��������� ������������� ��������, ����������� �������� �������� ����������� :' + cast(@@SPID  as nvarchar(20));
print '��� ��������� ������ :' + cast(@@ERROR  as nvarchar(20));
print '��� ������� :' + cast(@@SERVERNAME   as nvarchar(20));
print '���������� ������� ����������� ���������� :' + cast(@@TRANCOUNT   as nvarchar(20));
print '�������� ���������� ���������� ����� ��������������� ������ :' + cast(@@FETCH_STATUS   as nvarchar(20));
print '������� ����������� ������� ��������� :' + cast(@@FETCH_STATUS   as nvarchar(20));



-------4-------

DECLARE @z float, @x float = 27, @t float=14;
	if (@t>@x)
		set @z = POWER(sin(@t),2);
	else if (@t<@x)
		set @z = 4*(@t + @x);
	else 
		set @z = 1 - EXP(@x-2);


-------4.2-------

DECLARE @F nvarchar(30)= '��������',
		@I nvarchar(30)= '�������',
		@O nvarchar(30)='����������',
		@FullName nvarchar(60),
		@ShortName nvarchar(60);

		set @FullName = @F + ' '+ @I + ' '+ @O;
		set @O = substring(@O, 1,1)+'.';
		set @I = substring(@I, 1,1)+'.';
		set @ShortName =@F + ' ' + @I + ' ' + @O;

		select @FullName [������];
		select @ShortName[�����������];

-------4.3-------
USE UNIVER;

SELECT STUDENT.NAME [��� ��������],
	   STUDENT.BDAY [���� ��������],
	   DATEDIFF(YEAR, STUDENT.BDAY, SYSDATETIME()) AS [���������� ������ ���]
FROM STUDENT 
WHERE MONTH(STUDENT.BDAY) = MONTH(DATEADD(m, 1, SYSDATETIME()))

-------4.4-------

DECLARE @testday date

SET @testday = (SELECT PROGRESS.PDATE 
				FROM PROGRESS Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
				WHERE PROGRESS.SUBJECT in('����') and STUDENT.IDSTUDENT in('1026'))

PRINT '���� ������, � ������� �������� ������� ������� �� ����: ' + CONVERT (varchar(12), DATEPART(dw, @testday))

