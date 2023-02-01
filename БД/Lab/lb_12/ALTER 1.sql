USE [UNIVER]
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 29.11.2022 23:44:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20)= NULL,@c int output--кл сл выходного параметра
		as begin
			DECLARE @cnt int=(select count(*) from SUBJECT WHERE PULPIT = @p);
			print 'входной параметр @p= '+ @p+ ' @c= '+ cast(@c as varchar(3));
			SELECT S.SUBJECT,S.SUBJECT_NAME,S.PULPIT From SUBJECT as S
														WHERE S.PULPIT= @p;
			set @c=@@ROWCOUNT;
			return @cnt;
		end;
		

		declare @cntOUT int=0, @r int=0, @pIn varchar(20)='ИСиТ';
		EXEC @cntOUT=PSUBJECT @p=@pIn, @c=@r output; 
		print 'kol-vo '+ cast(@cntOUT as varchar(3));	
		print 'kol-vo ISiT'+ cast(@pIn as varchar(3))+ '= ' +cast(@r as varchar);		

GO


