USE UNIVER

SELECT F.FACULTY[Факультет], GR.PROFESSION[специальность], PR.SUBJECT [Дисциплина],
		round(avg(cast(PR.NOTE as float(4))), 2) [Средняя оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE 'ТОВ'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

	UNION

SELECT F.FACULTY[Факультет], GR.PROFESSION[специальность], PR.SUBJECT [Дисциплина],
		round(avg(cast(PR.NOTE as float(4))), 2) [Средняя оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE 'ХТиТ'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

--UNION ALL

SELECT F.FACULTY[Факультет], GR.PROFESSION[специальность], PR.SUBJECT [Дисциплина],
		round(avg(cast(PR.NOTE as float(4))), 2) [Средняя оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE 'ТОВ'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

	UNION ALL

SELECT F.FACULTY[Факультет], GR.PROFESSION[специальность], PR.SUBJECT [Дисциплина],
		round(avg(cast(PR.NOTE as float(4))), 2) [Средняя оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE 'ХТиТ'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

--INTERSECT

SELECT F.FACULTY[Факультет], GR.PROFESSION[специальность], PR.SUBJECT [Дисциплина],
		round(avg(cast(PR.NOTE as float(4))), 2) [Средняя оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE 'ТОВ'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

	INTERSECT

SELECT F.FACULTY[Факультет], GR.PROFESSION[специальность], PR.SUBJECT [Дисциплина],
		round(avg(cast(PR.NOTE as float(4))), 2) [Средняя оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE 'ХТиТ'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

--EXCEPT

SELECT F.FACULTY[Факультет], GR.PROFESSION[специальность], PR.SUBJECT [Дисциплина],
		round(avg(cast(PR.NOTE as float(4))), 2) [Средняя оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE 'ХТиТ'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT

	EXCEPT

SELECT F.FACULTY[Факультет], GR.PROFESSION[специальность], PR.SUBJECT [Дисциплина],
		round(avg(cast(PR.NOTE as float(4))), 2) [Средняя оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE F.FACULTY LIKE 'ТОВ'
	GROUP BY F.FACULTY, GR.PROFESSION, PR.SUBJECT
