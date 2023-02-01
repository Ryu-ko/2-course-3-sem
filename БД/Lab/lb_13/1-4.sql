use UNIVER
go

CREATE FUNCTION COUNT_STUDENTS (@faculty varchar(20)) returns int
	as begin
		DECLARE @kol_voStud int=0;
		set @kol_voStud= (SELECT COUNT(ST.IDSTUDENT)[Количество студентов]
									FROM STUDENT ST JOIN GROUPS GR 
									on	ST.IDGROUP = GR.IDGROUP
									INNER JOIN FACULTY FC on GR.FACULTY=FC.FACULTY
									WHERE FC.FACULTY= @faculty
									);
		return @kol_voStud;
	end;
	go

	DECLARE @f int= dbo.COUNT_STUDENTS('ТОВ');
	print 'Kol-vo p= '+ cast(@f as varchar(4));

go

DROP FUNCTION COUNT_STUDENTS

---2---

go

CREATE FUNCTION FSUBJECTS (@p varchar(20)) returns varchar(300)
	as begin
		DECLARE @pulpt varchar(20) , @tx varchar(300)='Дисциплины: ';
		DECLARE PulpCurs CURSOR LOCAL 
				for SELECT SUBJECT.SUBJECT FROM SUBJECT 
							WHERE SUBJECT.PULPIT=@p;
		open PulpCurs;
		FETCH PulpCurs into @pulpt;
			while @@FETCH_STATUS = 0
				begin
					SET @tx=@tx+ rtrim(@pulpt) + ',';
					FETCH PulpCurs into @pulpt;
				end;
			return @tx;
	end;
go

SELECT PULPIT.PULPIT, dbo.FSUBJECTS(PULPIT.PULPIT) from PULPIT;

DROP FUNCTION FSUBJECTS

---3---

go

CREATE FUNCTION FFACPUL (@idFac varchar(20), @idPulp varchar(20)) returns table
	as return
		SELECT FC.FACULTY , PLP.PULPIT
			FROM FACULTY FC left outer join PULPIT PLP ON PLP.FACULTY=FC.FACULTY
				WHERE FC.FACULTY = isnull(@idFac, FC.FACULTY)
					AND  PLP.PULPIT = isnull(@idPulp,  PLP.PULPIT);

GO

	SELECT * FROM dbo.FFACPUL(NULL,NULL);
	SELECT * FROM dbo.FFACPUL('ЛХФ',NULL);
	SELECT * FROM dbo.FFACPUL(NULL,'ИСиТ');
	SELECT * FROM dbo.FFACPUL('ТТЛП','ТДП');

DROP FUNCTION FFACPUL


---4---
go

CREATE FUNCTION FCTEACHER(@kodPulpt varchar(20)) returns int
	as begin
	DECLARE @kolPrepod int =(SELECT count(*) FROM TEACHER TCH
									WHERE TCH.PULPIT= isnull(@kodPulpt,TCH.PULPIT))
			return @kolPrepod;
	end;
go
	print 'Общее количество преподавателей: ' + cast(dbo.FCTEACHER(null) as varchar)
	SELECT PULPIT Кафедра, dbo.FCTEACHER(PULPIT) [Кол-во преподавателей] FROM  PULPIT


DROP FUNCTION FCTEACHER



