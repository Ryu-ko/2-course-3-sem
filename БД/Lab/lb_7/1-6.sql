-------1-------

USE [UNIVER-7]
go
CREATE VIEW [Преподаватель]
	as SELECT TEACHER.TEACHER[Код],
				TEACHER.TEACHER_NAME[Имя преподавателя],
				TEACHER.GENDER[Пол],
				TEACHER.PULPIT[Код кафедры]
					from TEACHER
go
SELECT * FROM [Преподаватель]

go
SELECT * FROM [Преподаватель] order by [Код]

go

ALTER VIEW [Преподаватель]
	as SELECT TEACHER.TEACHER[Код],
				TEACHER.TEACHER_NAME[Имя преподавателя],
				TEACHER.PULPIT[Код кафедры]
					from TEACHER

go

  DROP VIEW [Преподаватель]


--------2----------
go
CREATE VIEW [Количество кафедр]
	as SELECT FC.FACULTY_NAME [Факультет], COUNT(*)[Кол-во]
	FROM  FACULTY FC JOIN PULPIT PL
		on FC.FACULTY = PL.FACULTY
			group by FC.FACULTY_NAME
go
SELECT * from [Количество кафедр]

DROP VIEW [Количество кафедр]

--------3---------

go
CREATE VIEW [Аудитории]([Код аудитории], [Наименование аудитории],[Номер])
	as SELECT AUDITORIUM.AUDITORIUM, 
	AUDITORIUM.AUDITORIUM_TYPE,
	AUDITORIUM.AUDITORIUM_NAME
	FROM AUDITORIUM
		WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE ('ЛК%')

go

SELECT * FROM [Аудитории]

INSERT [Аудитории]([Код аудитории], [Наименование аудитории],[Номер]) values ('103-1','ЛК','103-1' )

UPDATE [Аудитории] set  [Номер] = '224-1' where [Номер] = '200-1'

DELETE from  [Аудитории] where [Код аудитории] = '103-1'

go
DROP VIEW [Аудитории]

-------4-------

go 
CREATE VIEW [Лекционные аудитории] ([Код аудитории], [Наименование аудитории],[Номер])
	as SELECT AUDITORIUM.AUDITORIUM, 
	AUDITORIUM.AUDITORIUM_TYPE,
	AUDITORIUM.AUDITORIUM_NAME
	FROM AUDITORIUM
		WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE ('ЛК%')  WITH CHECK OPTION

go

SELECT * FROM [Лекционные аудитории]

INSERT [Лекционные аудитории] ([Код аудитории], [Наименование аудитории],[Номер])
					 values ('103-1','ЛБ','103-1' )

UPDATE [Лекционные аудитории] set  [Номер] = '324-1' where [Номер] = '236-1'

go
DROP VIEW [Лекционные аудитории]

-------5-------

go
 CREATE VIEW Дисциплины(Код, [Наименование дисциплины], [Код кафедры])
	as select TOP 10 SB.SUBJECT,SB.SUBJECT_NAME, SB.PULPIT
		FROM SUBJECT SB
				Order by SB.SUBJECT_NAME;
go
select * from SUBJECT;

DROP VIEW Дисциплины

-------6-------

go
ALTER VIEW [Количество кафедр] WITH SCHEMABINDING --устанавливает запрещение на операции с таблицами и представлениями, которые могут привести к нарушению работоспособности представления.
	as SELECT FC.FACULTY_NAME [Факультет], COUNT(*)[Кол-во]
	FROM  FACULTY FC JOIN PULPIT PL
		on FC.FACULTY = PL.FACULTY
			group by FC.FACULTY_NAME
go
SELECT * from [Количество кафедр]

DROP VIEW [Количество кафедр]



