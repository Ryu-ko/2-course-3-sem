USE UNIVER

SELECT F.FACULTY[���������],GR.PROFESSION[�������������],GR.YEAR_FIRST [��� �����������],
			round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
		GROUP BY F.FACULTY ,GR.PROFESSION,GR.YEAR_FIRST,PR.NOTE
		order by [������� ������] desc

---������ ������ �� ����������� � ������ �� � ����. ������������ WHERE.
 SELECT F.FACULTY[���������],GR.PROFESSION[�������������],GR.YEAR_FIRST [��� �����������],
			round(avg(cast(PR.NOTE as float(4))), 2) [������� ������]
	FROM FACULTY F 
			inner join GROUPS GR on F.FACULTY= Gr.FACULTY
			inner join STUDENT ST on ST.IDGROUP= GR.IDGROUP
			inner join PROGRESS PR on PR.IDSTUDENT= ST.IDSTUDENT
	WHERE PR.SUBJECT IN ('��', '����')--like '��' or PR.SUBJECT= '����' 
	 	GROUP BY F.FACULTY ,GR.PROFESSION,GR.YEAR_FIRST,PR.NOTE
		order by [������� ������] desc

