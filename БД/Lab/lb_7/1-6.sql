-------1-------

USE [UNIVER-7]
go
CREATE VIEW [�������������]
	as SELECT TEACHER.TEACHER[���],
				TEACHER.TEACHER_NAME[��� �������������],
				TEACHER.GENDER[���],
				TEACHER.PULPIT[��� �������]
					from TEACHER
go
SELECT * FROM [�������������]

go
SELECT * FROM [�������������] order by [���]

go

ALTER VIEW [�������������]
	as SELECT TEACHER.TEACHER[���],
				TEACHER.TEACHER_NAME[��� �������������],
				TEACHER.PULPIT[��� �������]
					from TEACHER

go

  DROP VIEW [�������������]


--------2----------
go
CREATE VIEW [���������� ������]
	as SELECT FC.FACULTY_NAME [���������], COUNT(*)[���-��]
	FROM  FACULTY FC JOIN PULPIT PL
		on FC.FACULTY = PL.FACULTY
			group by FC.FACULTY_NAME
go
SELECT * from [���������� ������]

DROP VIEW [���������� ������]

--------3---------

go
CREATE VIEW [���������]([��� ���������], [������������ ���������],[�����])
	as SELECT AUDITORIUM.AUDITORIUM, 
	AUDITORIUM.AUDITORIUM_TYPE,
	AUDITORIUM.AUDITORIUM_NAME
	FROM AUDITORIUM
		WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE ('��%')

go

SELECT * FROM [���������]

INSERT [���������]([��� ���������], [������������ ���������],[�����]) values ('103-1','��','103-1' )

UPDATE [���������] set  [�����] = '224-1' where [�����] = '200-1'

DELETE from  [���������] where [��� ���������] = '103-1'

go
DROP VIEW [���������]

-------4-------

go 
CREATE VIEW [���������� ���������] ([��� ���������], [������������ ���������],[�����])
	as SELECT AUDITORIUM.AUDITORIUM, 
	AUDITORIUM.AUDITORIUM_TYPE,
	AUDITORIUM.AUDITORIUM_NAME
	FROM AUDITORIUM
		WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE ('��%')  WITH CHECK OPTION

go

SELECT * FROM [���������� ���������]

INSERT [���������� ���������] ([��� ���������], [������������ ���������],[�����])
					 values ('103-1','��','103-1' )

UPDATE [���������� ���������] set  [�����] = '324-1' where [�����] = '236-1'

go
DROP VIEW [���������� ���������]

-------5-------

go
 CREATE VIEW ����������(���, [������������ ����������], [��� �������])
	as select TOP 10 SB.SUBJECT,SB.SUBJECT_NAME, SB.PULPIT
		FROM SUBJECT SB
				Order by SB.SUBJECT_NAME;
go
select * from SUBJECT;

DROP VIEW ����������

-------6-------

go
ALTER VIEW [���������� ������] WITH SCHEMABINDING --������������� ���������� �� �������� � ��������� � ���������������, ������� ����� �������� � ��������� ����������������� �������������.
	as SELECT FC.FACULTY_NAME [���������], COUNT(*)[���-��]
	FROM  FACULTY FC JOIN PULPIT PL
		on FC.FACULTY = PL.FACULTY
			group by FC.FACULTY_NAME
go
SELECT * from [���������� ������]

DROP VIEW [���������� ������]



