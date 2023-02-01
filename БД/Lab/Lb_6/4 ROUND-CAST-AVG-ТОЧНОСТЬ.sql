USE UNIVER

SELECT F.FACULTY[‘акультет],GR.PROFESSION[специальность],GR.YEAR_FIRST [год поступлени€],
			round(avg(cast(PR.NOTE as float(4))), 2) [—редн€€ оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
		GROUP BY F.FACULTY ,GR.PROFESSION,GR.YEAR_FIRST,PR.NOTE
		order by [—редн€€ оценка] desc

---оценки только по дисциплинам с кодами Ѕƒ и ќјиѕ. »спользовать WHERE.
 SELECT F.FACULTY[‘акультет],GR.PROFESSION[специальность],GR.YEAR_FIRST [год поступлени€],
			round(avg(cast(PR.NOTE as float(4))), 2) [—редн€€ оценка]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE PR.SUBJECT IN ('Ѕƒ', 'ќјиѕ')--like 'Ѕƒ' or PR.SUBJECT= 'ќјиѕ' 
	 	GROUP BY F.FACULTY ,GR.PROFESSION,GR.YEAR_FIRST,PR.NOTE
		order by [—редн€€ оценка] desc

