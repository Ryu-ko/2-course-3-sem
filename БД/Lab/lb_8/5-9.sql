-------5-------

use UNIVER;

DECLARE @capact int = (select cast(sum (AUDITORIUM_CAPACITY) as int) from AUDITORIUM)
	if @capact > 200
		begin

			print '����� ����������� = '+ cast(@capact as varchar(10));			
		end

		else 
			begin
				print '����� ����������� = '+ cast(@capact as varchar(10))+ '(������ 200)';
			end

-------6-------

SELECT CASE
		when (pr.NOTE = 5) then '����'
		when (pr.NOTE = 6) then '�����'
		when (pr.NOTE between 6 and 7) then '����'
		when (pr.NOTE between 7 and 8) then '������'
		else '������ �������'
		end [������]
	FROM PROGRESS pr
	Inner Join STUDENT ON pr.IDSTUDENT = STUDENT.IDSTUDENT
		GROUP BY CASE 
			when (pr.NOTE = 5) then '����'
			when (pr.NOTE = 6) then '�����'
			when (pr.NOTE between 6 and 7) then '����'
			when (pr.NOTE between 7 and 8) then '������'
			else '������ �������'
			end
		

-------7 ��������� ��������� ������� -------

CREATE table #EXAMPLE
(
		Name nvarchar(20),
		Age int,
		Statuss nvarchar(20)
	);

SET nocount on;-- �� �������� ������ � ����� �����
DECLARE @i int=18;
	WHILE @i<28
		begin
			INSERT #EXAMPLE(Name,Age,Statuss)
				values('���-��', @i, '�������' );
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
		print '��� ��������� ������:' 
		print  ERROR_NUMBER()  
		print  '��������� �� ������:' 
		print   ERROR_MESSAGE() 
		print '��� ��������� ������:' 
		print ERROR_LINE() 
		print  '��� ��������� ��� NULL:' 
		print  ERROR_PROCEDURE() 
		print  '������� ����������� ������:' 
		print  ERROR_SEVERITY()
		print  '����� ������:' 
		print  ERROR_STATE() 

	end catch	