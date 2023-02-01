SELECT *
	 FROM PATIENTS FULL OUTER JOIN PATIENTS_ROOM
	ON PATIENTS.patient_room =PATIENTS_ROOM.room

-- запрос, результат которого содержит данные левой (в операции FULL OUTER JOIN) таблицы и не содержит данные правой; 
SELECT *
	 FROM PATIENTS A FULL OUTER JOIN PATIENTS_ROOM B
	ON A.patient_room =B.room
	WHERE A.patient_room IS NOT NULL and B.room IS NULL

-- запрос, результат которого содержит данные правой таблицы и не содержащие данные левой; 
SELECT *
	 FROM PATIENTS A RIGHT OUTER JOIN PATIENTS_ROOM B
	ON A.patient_room =B.room
	WHERE A.patient_room IS NULL and B.room IS NOT NULL

-- запрос, результат которого содержит данные правой таблицы и левой таблиц;
SELECT *
	 FROM PATIENTS A FULL OUTER JOIN PATIENTS_ROOM B
	ON A.patient_room =B.room
	WHERE A.patient_room IS NOT NULL or B.room IS NOT NULL




