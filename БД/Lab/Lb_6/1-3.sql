SELECT max(AUDITORIUM.AUDITORIUM_CAPACITY) [Максимальная вместимость],
		min(AUDITORIUM.AUDITORIUM_CAPACITY) [Минимальная вместимость],
		avg(AUDITORIUM.AUDITORIUM_CAPACITY) [Средняя вместимость],
		count(*)[Общее кол-во аудиторий],
		sum(AUDITORIUM.AUDITORIUM_CAPACITY) [Суммарная вместимость]
FROM AUDITORIUM

SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,
		max(AUDITORIUM.AUDITORIUM_CAPACITY) [Максимальная вместимость],
		min(AUDITORIUM.AUDITORIUM_CAPACITY) [Минимальная вместимость],
		avg(AUDITORIUM.AUDITORIUM_CAPACITY) [Средняя вместимость],
		count(*)[Общее кол-во аудиторий],
		sum(AUDITORIUM.AUDITORIUM_CAPACITY) [Суммарная вместимость]
	FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
		ON AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
		GROUP BY AUDITORIUM_TYPE.AUDITORIUM_TYPENAME

SELECT *
	FROM ( SELECT 
				CASE
					when (PROGRESS.NOTE = 10) then '10'
					when (PROGRESS.NOTE IN(8,9)) then '8-9'
					when (PROGRESS.NOTE IN(6,7)) then '6-7'
					when (PROGRESS.NOTE IN(4,5)) then '4-5'
					else ''
				end [Оценки] , COUNT(*)[Количество]

		FROM PROGRESS GROUP BY 
					CASE
						when (PROGRESS.NOTE = 10) then '10'
						when (PROGRESS.NOTE IN(8,9)) then '8-9'
						when (PROGRESS.NOTE IN(6,7)) then '6-7'
						when (PROGRESS.NOTE IN(4,5)) then '4-5'
						else ''
					end 
		) as T
		ORDER BY	
				CASE[Оценки]
					when '10' then 1
					when '8-9' then 2
					when '6-7' then 3
					when '4-5' then 4
					else 0
				end											