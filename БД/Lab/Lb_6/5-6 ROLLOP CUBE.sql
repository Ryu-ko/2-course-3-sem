use UNIVER

----	
SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT1
	WHERE F.FACULTY LIKE '���'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT
	
---ROLLUP

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '���'
	GROUP BY ROLLUP (F.FACULTY, GR.PROFESSION, PR.SUBJECT)

---CUBE

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '���'
	GROUP BY CUBE (F.FACULTY, GR.PROFESSION, PR.SUBJECT)
