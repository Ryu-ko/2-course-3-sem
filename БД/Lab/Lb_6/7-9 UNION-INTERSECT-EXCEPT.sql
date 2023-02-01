USE UNIVER

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '���'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

	UNION

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '����'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

--UNION ALL

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '���'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

	UNION ALL

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '����'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

--INTERSECT

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '���'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

	INTERSECT

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '����'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

--EXCEPT

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '����'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

	EXCEPT

SELECT F.FACULTY[���������], GR.PROFESSION[�������������], PR.SUBJECT [����������],
		round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE '���'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT
