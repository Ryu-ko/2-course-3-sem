SELECT FACULTY.FACULTY [Факультет], PULPIT.PULPIT [Кафедра], PROFESSION.PROFESSION_NAME [Специальность], STUDENT.NAME [Имя студента],PROGRESS.NOTE [Оценка],
	Case
		when (PROGRESS.NOTE = 6) then 'шесть'
		when (PROGRESS.NOTE = 7) then 'семь'
		when (PROGRESS.NOTE = 8) then 'восемь'
		else 'другие оценки'
	 end [Оценка]

	 From  PROGRESS 
		Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
		Inner Join SUBJECT ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
		Inner Join PULPIT ON SUBJECT.PULPIT = PULPIT.PULPIT
		Inner Join PROFESSION ON PULPIT.FACULTY = PROFESSION.FACULTY
		Inner Join FACULTY ON PROFESSION.FACULTY = FACULTY.FACULTY
		
		Where PROGRESS.NOTE Between 6 and 8
		Order By PROGRESS.NOTE desc, FACULTY.FACULTY asc, PULPIT.PULPIT asc, PROFESSION.PROFESSION asc

 SELECT FACULTY.FACULTY [Факультет], PULPIT.PULPIT [Кафедра], PROFESSION.PROFESSION_NAME [Специальность], STUDENT.NAME [Имя студента],PROGRESS.NOTE [Оценка],
	Case
		when (PROGRESS.NOTE = 6) then 'шесть'
		when (PROGRESS.NOTE = 7) then 'семь'
		when (PROGRESS.NOTE = 8) then 'восемь'
		else 'другие оценки'
	 end [Оценка]

	 From PROGRESS 
		Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
		Inner Join SUBJECT ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
		Inner Join PULPIT ON SUBJECT.PULPIT = PULPIT.PULPIT
		Inner Join PROFESSION ON PULPIT.FACULTY = PROFESSION.FACULTY
		Inner Join FACULTY ON PROFESSION.FACULTY = FACULTY.FACULTY
		
		Where PROGRESS.NOTE Between 6 and 8
		Order By ( Case 
						when (PROGRESS.NOTE = 6) then 3
						when (PROGRESS.NOTE = 7) then 1
						when (PROGRESS.NOTE = 8) then 2
					end
					)
