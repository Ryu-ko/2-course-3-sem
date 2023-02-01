SELECT *
	 FROM PATIENTS FULL OUTER JOIN PATIENTS_ROOM
	ON PATIENTS.patient_room =PATIENTS_ROOM.room

-- ������, ��������� �������� �������� ������ ����� (� �������� FULL OUTER JOIN) ������� � �� �������� ������ ������; 
SELECT *
	 FROM PATIENTS A FULL OUTER JOIN PATIENTS_ROOM B
	ON A.patient_room =B.room
	WHERE A.patient_room IS NOT NULL and B.room IS NULL

-- ������, ��������� �������� �������� ������ ������ ������� � �� ���������� ������ �����; 
SELECT *
	 FROM PATIENTS A RIGHT OUTER JOIN PATIENTS_ROOM B
	ON A.patient_room =B.room
	WHERE A.patient_room IS NULL and B.room IS NOT NULL

-- ������, ��������� �������� �������� ������ ������ ������� � ����� ������;
SELECT *
	 FROM PATIENTS A FULL OUTER JOIN PATIENTS_ROOM B
	ON A.patient_room =B.room
	WHERE A.patient_room IS NOT NULL or B.room IS NOT NULL




