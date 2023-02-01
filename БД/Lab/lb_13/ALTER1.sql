USE [UNIVER]
GO

/****** Object:  UserDefinedFunction [dbo].[COUNT_STUDENTS]    Script Date: 30.11.2022 3:58:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER FUNCTION [dbo].[COUNT_STUDENTS] (@faculty varchar(20)=NULL, @prof varchar(20)=NULL) returns int
	as begin
		DECLARE @kol_voStud int=0;
		set @kol_voStud= (SELECT COUNT(ST.IDSTUDENT)[Количество студентов]
									FROM STUDENT ST JOIN GROUPS GR 
									on	ST.IDGROUP = GR.IDGROUP
									INNER JOIN FACULTY FC on GR.FACULTY=FC.FACULTY
									WHERE FC.FACULTY= @faculty AND GR.PROFESSION=@prof
									);
		return @kol_voStud;
	end;

GO



	DECLARE @f int= dbo.COUNT_STUDENTS('ТОВ','1-48 01 02 ');
	print 'Kol-vo p= '+ cast(@f as varchar(4));

go
