----1----

set nocount on
	if  exists (select * from  SYS.OBJECTS        -- ������� Lb11 ����?
	            where OBJECT_ID= object_id(N'DBO.Lb11') )	            
	drop table Lb11; 
	          
	declare @c int, @flag char = 'c';  
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������

	CREATE table Lb11(K int );  -- ������ ���������� 
		INSERT Lb11 values (1),(2),(3);
		set @c = (select count(*) from Lb11);
		print '���������� ����� � ������� Lb11: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;   -- ���������� ����������: �������� 
		   else   rollback;  -- ���������� ����������: ����� 
		    
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	
	if  exists (select * from  SYS.OBJECTS     -- ������� Lb11 ����?
	            where OBJECT_ID= object_id(N'DBO.Lb11') )
	print '������� Lb11 ����';  
      else print '������� Lb11 ���'


----2----
use [UNIVER-7]

	begin try
		begin TRAN --��� ��� �����
			insert into FACULTY(FACULTY,FACULTY_NAME)	
					values ('TEST','testovoe znach')
			delete from FACULTY where FACULTY_NAME='TEST'
		commit TRAN --������������
	end try

	begin catch
		print 'ERROR '+ cast(error_number() as nvarchar(20));
		print error_message();
		print ' '
			if @@TRANCOUNT>0 rollback TRAN; --�����
	end catch;
		

----3----�������� SAVE TRANSACTION (����������� ����� )
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
		print '������: ' + case 
						when error_number() = 2627 and patindex('%FACULTY_PK%', error_message()) > 0
								then '������������ ����������'
						ELSE '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
						   end;

		if @@TRANCOUNT > 0
			begin 
				print '����������� �����: ' + @contrPoint;
				print ' '
				rollback TRAN @contrPoint;		--����� � ����������� �����
				commit TRAN;				--�������� ���������, ������������ �� ����������� �����
			end
		end catch;


----4----

use UNIVER
set transaction isolation level READ UNCOMMITTED --������ ���� ����� �������� ��������� ������ �����

--------- A ---------
	begin transaction 
-------------------------- t1 ------------------
		select @@SPID �������, 'INSERT AUDITORIUM' ���������, * from AUDITORIUM  --���������� ��������� ������������� ��������, ����������� �������� �������� �����������.
					where AUDITORIUM = '123456'
		select @@SPID �������, 'UPDATE AUDITORIUM' ���������, * from AUDITORIUM 
					where AUDITORIUM = '123456' 
		commit;
-------------------------- t2 -----------------
--------- B ---------
	begin transaction 
		insert AUDITORIUM values ('123456', '��-�', 80, '1234') --������������� /��������� ������
		update AUDITORIUM set AUDITORIUM = '123456'
						  where AUDITORIUM = '1234567' 
-------------------------- t1 --------------------
-------------------------- t2 --------------------
rollback


----5----

use UNIVER
set transaction isolation level READ COMMITTED  -- ������ ��������������� ��������� �� ������ ��
-- A ---
	begin transaction 
		select count(*) from AUDITORIUM where AUDITORIUM = '1234'
-------------------------- t1 ------------------ 
-------------------------- t2 -----------------
		select 'update' ���������, count(*) from AUDITORIUM where AUDITORIUM = '1234'
	commit

--- B ---	
begin transaction 	  
-------------------------- t1 --------------------
		update AUDITORIUM set AUDITORIUM = '1234' where AUDITORIUM = '123456' 
	commit;
-------------------------- t2 --------------------


----6----

-- A ---
set transaction isolation level  REPEATABLE READ --�� ����� � ������������� ���������� ����������/��������� ������ ������ �����������. �� ��� ��� ����� ����������� ������ �� ������ ����������
	begin transaction 
		select AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM = '1234'
-------------------------- t1 ------------------ 
-------------------------- t2 ------------------
	select case
       when AUDITORIUM_CAPACITY = 50 then 'insert' 
	   else '---' 
	end '���������', AUDITORIUM from AUDITORIUM where AUDITORIUM = '1234'
commit


----7----

-- A ---
set transaction isolation level SERIALIZABLE -- �������� ������� ���� �� ����� ���.
	begin transaction 
		delete AUDITORIUM where AUDITORIUM = '1234'
		insert AUDITORIUM values ('1234', '��-�', 10, '���')
		update AUDITORIUM set AUDITORIUM_NAME = '���' where AUDITORIUM = '1234'
		select AUDITORIUM from AUDITORIUM where AUDITORIUM = '1234'
-------------------------- t1 -----------------
	select AUDITORIUM from AUDITORIUM where AUDITORIUM = '1234'
-------------------------- t2 ------------------ 
commit 	

--- B ---	
	begin transaction 	  
		delete AUDITORIUM where AUDITORIUM_NAME = '���'; 
		insert AUDITORIUM values ('1234', '��-�', 10, '���')
		update AUDITORIUM set AUDITORIUM_NAME = '���' where AUDITORIUM = '1234'
		select AUDITORIUM from AUDITORIUM  where AUDITORIUM = '1234'
-------------------------- t1 --------------------
commit

	select AUDITORIUM from AUDITORIUM  where AUDITORIUM = '1234'
-------------------------- t2 -------------------


----8---- ��������� ����������
	begin tran
		insert AUDITORIUM_TYPE values ('��-�', '����� �� ���')
		begin tran  -- ���������� ����������
			update AUDITORIUM set AUDITORIUM = '1234' where AUDITORIUM_TYPE = '��-�'
			commit  --���������
		if @@TRANCOUNT > 0 -- ������� ���������� ������� ����������� ���������� 
	rollback

	select (select count(*) from AUDITORIUM where AUDITORIUM_TYPE = '��-�') ���������,
		   (select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��-�') ���

