SELECT TOP 1
	( SELECT AVG (PROGRESS.NOTE) FROM PROGRESS
			WHERE SUBJECT LIKE '????')[????],
	( SELECT AVG (PROGRESS.NOTE) FROM PROGRESS
			WHERE SUBJECT LIKE '??')[??],
	( SELECT AVG (PROGRESS.NOTE) FROM PROGRESS
			WHERE SUBJECT LIKE '????')[????]
	FROM PROGRESS

SELECT  ST.IDSTUDENT, ST.NAME, PR.NOTE
	FROM PROGRESS as PR, STUDENT as ST
	Where PR.NOTE <= all (SELECT PRR.NOTE
							FROM PROGRESS as PRR
							where PRR.NOTE like '6')
	ORDER BY PR.NOTE 

SELECT  ST.IDSTUDENT, ST.NAME, PR.NOTE
	FROM PROGRESS as PR, STUDENT as ST
	Where PR.NOTE < any (SELECT PRR.NOTE
							FROM PROGRESS as PRR
							where PRR.NOTE like '6')
	ORDER BY PR.NOTE 
