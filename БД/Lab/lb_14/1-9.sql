USE UNIVER
go

---1--- INSERT
go 
CREATE TABLE TR_AUDIT
(
	ID int identity, -- номер
	STMT varchar(20) check(STMT in ('INS','DEL','UPD')),  -- DML-оператор
	TRNAME varchar(50), --имя триггера
	CC varchar(300) -- комментарий
);

--ALTER-триггер
go

go
 CREATE TRIGGER TR_TEACHER_INS ON TEACHER after INSERT --тригер реагирующий на событие INSERT

	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@in varchar(300);
		print 'Vstavka: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @in) --событие на котор реагир, собств имя знач вводимо	 строки
		return;

		INSERT into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values ('ККВ','Котов Алексей Владимирович','м','ИСиТ');
		SELECT * FROM TR_AUDIT order by ID


DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER_INS
go

---2--- DELETE

CREATE TRIGGER TR_TEACHER_DEL ON TEACHER after DELETE --тригер реагирующий на событие INSERT

	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@del varchar(300);
		print 'Delete: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @del=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL', @del)
		return;

		DELETE  TEACHER WHERE TEACHER='КАВ'
		SELECT * FROM TR_AUDIT order by ID


DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER_DEL

---3--- UPDATE
go
CREATE TRIGGER TR_TEACHER_UPD ON TEACHER after UPDATE --тригер реагирующий на событие UPDATE

	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@upd varchar(300);
		print 'Update: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @upd=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_UPD', @upd)
		return;

		update TEACHER set PULPIT = 'ЛВ' where TEACHER in('НВРВ');
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
					print 'Событие INSERT';
					SET @teacher=(SELECT TEACHER from inserted);
					SET @teacher_name=(SELECT TEACHER_NAME from inserted);
					SET @gender=(SELECT GENDER from inserted);
					SET @pulpit=(SELECT PULPIT from inserted);
					SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

					INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER', @in)
				end;
				else if @ins=0 and @del>0
					begin
						print 'Событие DELETE: ';
						SET @teacher=(SELECT TEACHER from inserted);
						SET @teacher_name=(SELECT TEACHER_NAME from inserted);
						SET @gender=(SELECT GENDER from inserted);
						SET @pulpit=(SELECT PULPIT from inserted);
						SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

						INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER', @in)
					end;

					else if @ins>0 and @del>0
					begin
						print 'Событие UPDATE: ';
						SET @teacher=(SELECT TEACHER from inserted);
						SET @teacher_name=(SELECT TEACHER_NAME from inserted);
						SET @gender=(SELECT GENDER from inserted);
						SET @pulpit=(SELECT PULPIT from inserted);
						SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

						INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER', @in)	
					end;
					return;

		INSERT into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values ('КАВ','Котов Алексей Владимирович','м','ИСиТ');
		DELETE  TEACHER WHERE TEACHER='КАВ'
		UPDATE TEACHER set PULPIT = 'ЛВ' where TEACHER in('НВРВ');

		SELECT * FROM TR_AUDIT order by ID


DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER

go

---5---

insert into TEACHER values ('----', '-----', 'Т', '----')
select * from TR_AUDIT order by ID	--не выполняется из-за ограничения целостности check(GENDER)
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

	--проверить наличие триггеров на действия
	
	SELECT t.name, e.type_desc
			FROM sys.triggers t join  sys.trigger_events e
				 ON t.object_id = e.object_id
					WHERE OBJECT_NAME(t.parent_id)='TEACHER' and e.type_desc = 'DELETE';  

	--Изменение порядка выполнения триггеров 

	EXEC SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3',
	 @order = 'First', @stmttype = 'DELETE';

	EXEC SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2',
	 @order = 'Last', @stmttype = 'DELETE';

	INSERT into TEACHER values ('-1-', '-1-', 'ж', 'ИСиТ')
	INSERT into TEACHER values ('-2-', '-2-', 'м', 'ИСиТ')
	INSERT into TEACHER values ('-3-', '-3-', 'ж', 'ИСиТ')

	DELETE FROM TEACHER WHERE TEACHER = '-1-'
	DELETE FROM TEACHER WHERE TEACHER = '-2-'
	DELETE FROM TEACHER WHERE TEACHER = '-3-'

	SELECT * FROM TR_AUDIT

DROP TABLE TR_AUDIT
DROP TRIGGER TR_TEACHER_DEL1
DROP TRIGGER TR_TEACHER_DEL2
DROP TRIGGER TR_TEACHER_DEL3

go

---7---AFTER-триггер является частью транзакции, в рамках которого выполняется оператор, активизировавший триггер.
CREATE TRIGGER TRANS_TRIG ON TEACHER after INSERT 

	as DECLARE @teacher varchar(15),@teacher_name varchar(100),@gender varchar(1),@pulpit varchar(15),@in varchar(300);
		print 'Тригер часть транзакции: ';
		SET @teacher=(SELECT TEACHER from inserted);
		SET @teacher_name=(SELECT TEACHER_NAME from inserted);
		SET @gender=(SELECT GENDER from inserted);
		SET @pulpit=(SELECT PULPIT from inserted);
		SET @in=@teacher+ ' '+ @teacher_name+ ' ' + @gender+ ' ' + @pulpit;

		if @teacher_name like '---'
			begin 
				INSERT into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TRANS_TRIG', @in)
				raiserror ('нельзя добавить',10,1);
				rollback
			end;
		
			INSERT into TEACHER values ('-', '---', 'м', 'ИСиТ')
			
			SELECT * FROM TR_AUDIT

			DROP TABLE TR_AUDIT
			DROP TRIGGER TRANS_TRIG

---8---INSTEAD OF-триггер
go

CREATE TRIGGER FAC_INSTEAD_OF 
			ON FACULTY INSTEAD OF DELETE
			as raiserror('Удаление запрещено', 10, 1);
return;


	delete from FACULTY where FACULTY = 'ЛХФ'
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
		print 'Тип события: '+@t;
		print 'Имя объекта: '+@t1;
		print 'Тип объекта: '+@t2;
		raiserror( N'операции с таблицами запрещены', 16, 1);  
		rollback;    
	end;

	CREATE TABLE tbl(c int);-- выполнение запрещено
	go

	DISABLE TRIGGER DDL_UNIVER ON DATABASE;
	DROP TRIGGER DDL_UNIVER ON DATABASE;










