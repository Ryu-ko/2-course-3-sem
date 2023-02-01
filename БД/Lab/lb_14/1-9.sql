USE UNIVER
go

---1--- INSERT
go 
CREATE TABLE TR_AUDIT
(
	ID int identity, -- �����
	STMT varchar(20) check(STMT in ('INS','DEL','UPD')),  -- DML-��������
	TRNAME varchar(50), --��� ��������
	CC varchar(300) -- �����������
);

--ALTER-�������
go

go
 CREATE TRIGGER TR_TEACHER_INS ON TEACHER after INSERT --������ ����������� �� ������� INSERT

	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@in varchar(300);
		print 'Vstavka: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @in) --������� �� ����� ������, ������ ��� ���� �������	 ������
		return;

		INSERT into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values ('���','����� ������� ������������','�','����');
		SELECT * FROM TR_AUDIT order by ID


DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER_INS
go

---2--- DELETE

CREATE TRIGGER TR_TEACHER_DEL ON TEACHER after DELETE --������ ����������� �� ������� INSERT

	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@del varchar(300);
		print 'Delete: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @del=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL', @del)
		return;

		DELETE  TEACHER WHERE TEACHER='���'
		SELECT * FROM TR_AUDIT order by ID


DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER_DEL

---3--- UPDATE
go
CREATE TRIGGER TR_TEACHER_UPD ON TEACHER after UPDATE --������ ����������� �� ������� UPDATE

	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@upd varchar(300);
		print 'Update: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @upd=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_UPD', @upd)
		return;

		update TEACHER set PULPIT = '��' where TEACHER in('����');
		SELECT * FROM TR_AUDIT order by ID


DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER_UPD


---4---
go
CREATE TRIGGER TR_TEACHER on TEACHER after INSERT,DELETE,UPDATE
	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@in varchar(300);
		DECLARE @ins int = (select count(*) from inserted),
				@del int = (select count(*) from deleted);
			if @ins > 0 and @del = 0 
				begin
					print '������� INSERT';
					SET @teacher=(SELECT TEACHER from inserted);
					SET @teacher_name=(SELECT TEACHER_NAME from inserted);
					SET @gender=(SELECT GENDER from inserted);
					SET @pulpit=(SELECT PULPIT from inserted);
					SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

					INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER', @in)
				end;
				else if @ins=0 and @del>0
					begin
						print '������� DELETE: ';
						SET @teacher=(SELECT TEACHER from inserted);
						SET @teacher_name=(SELECT TEACHER_NAME from inserted);
						SET @gender=(SELECT GENDER from inserted);
						SET @pulpit=(SELECT PULPIT from inserted);
						SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

						INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER', @in)
					end;

					else if @ins>0 and @del>0
					begin
						print '������� UPDATE: ';
						SET @teacher=(SELECT TEACHER from inserted);
						SET @teacher_name=(SELECT TEACHER_NAME from inserted);
						SET @gender=(SELECT GENDER from inserted);
						SET @pulpit=(SELECT PULPIT from inserted);
						SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

						INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER', @in)	
					end;
					return;

		INSERT into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values ('���','����� ������� ������������','�','����');
		DELETE  TEACHER WHERE TEACHER='���'
		UPDATE TEACHER set PULPIT = '��' where TEACHER in('����');

		SELECT * FROM TR_AUDIT order by ID


DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER

go

---5---

insert into TEACHER values ('----', '-----', '�', '----')
select * from TR_AUDIT order by ID	--�� ����������� ��-�� ����������� ����������� check(GENDER)
GO
---6---

	CREATE TRIGGER TR_TEACHER_DEL1 on TEACHER after DELETE
	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@del varchar(300);
		print 'TR_TEACHER_DEL1: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @del=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL1', @del)
	return;

	go
	CREATE TRIGGER TR_TEACHER_DEL2 on TEACHER after DELETE
	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@del varchar(300);
		print 'TR_TEACHER_DEL2: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @del=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL2', @del)
	return;

	 go
	CREATE TRIGGER TR_TEACHER_DEL3 on TEACHER after DELETE
	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@del varchar(300);
		print 'TR_TEACHER_DEL3: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @del=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL3', @del)
	return;

	--��������� ������� ��������� �� ��������
	
	SELECT t.name, e.type_desc
			FROM sys.triggers t join  sys.trigger_events e
				 ON t.object_id = e.object_id
					WHERE OBJECT_NAME(t.parent_id)='TEACHER' and e.type_desc = 'DELETE';  

	--��������� ������� ���������� ��������� 

	EXEC SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3',
	 @order = 'First', @stmttype = 'DELETE';

	EXEC SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2',
	 @order = 'Last', @stmttype = 'DELETE';

	INSERT into TEACHER values ('-1-', '-1-', '�', '����')
	INSERT into TEACHER values ('-2-', '-2-', '�', '����')
	INSERT into TEACHER values ('-3-', '-3-', '�', '����')

	DELETE FROM TEACHER WHERE TEACHER = '-1-'
	DELETE FROM TEACHER WHERE TEACHER = '-2-'
	DELETE FROM TEACHER WHERE TEACHER = '-3-'

	SELECT * FROM TR_AUDIT

DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER_DEL1
DROP TRIGGER TR_TEACHER_DEL2
DROP TRIGGER TR_TEACHER_DEL3

go

---7---AFTER-������� �������� ������ ����������, � ������ �������� ����������� ��������, ���������������� �������.
CREATE TRIGGER TRANS_TRIG ON TEACHER after INSERT 

	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@in varchar(300);
		print '������ ����� ����������: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		if @teacher_name like '---'
			begin 
				INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TRANS_TRIG', @in)
				raiserror ('������ ��������',10,1);
				rollback
			end;
		
			INSERT into TEACHER values ('-', '---', '�', '����')
			
			SELECT * FROM TR_AUDIT

			DROP TABLE TR_AUDIT
			DROP TRIGGER TRANS_TRIG

---8---INSTEAD OF-�������
go

CREATE TRIGGER FAC_INSTEAD_OF 
			ON FACULTY INSTEAD OF DELETE
			as raiserror('�������� ���������', 10, 1);
return;


	delete from FACULTY where FACULTY = '���'
	select * from TR_AUDIT order by ID

DROP TABLE TR_AUDIT
DROP TRIGGER FAC_INSTEAD_OF


---9--- DDL
go
	CREATE TRIGGER DDL_UNIVER ON DATABASE FOR DDL_DATABASE_LEVEL_EVENTS  
	as  
	DECLARE @t varchar(50)= EVENTDATA().value ('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
	DECLARE @t1 varchar(50)=EVENTDATA().value ('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
	DECLARE @t2 varchar(50)=EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
	
	if @t2 = 'TABLE' 
	begin
		print '��� �������: '+@t;
		print '��� �������: '+@t1;
		print '��� �������: '+@t2;
		raiserror( N'�������� � ��������� ���������', 16, 1);  
		rollback;    
	end;

	CREATE TABLE tbl(c int);-- ���������� ���������
	go

	DISABLE TRIGGER DDL_UNIVER ON DATABASE;
	DROP TRIGGER DDL_UNIVER ON DATABASE;










