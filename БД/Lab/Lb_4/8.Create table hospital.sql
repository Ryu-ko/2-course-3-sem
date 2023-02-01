use master

create database HOSPITAL

create table PATIENTS_ROOM
(
	room int primary key,
	room_capasity int
);

create table PATIENTS
(
	patient_id int primary key,
	patient_name nvarchar(70),
	diagnosis nvarchar (70),
	patient_room int foreign key references PATIENTs_ROOM (room)
)

insert into PATIENTS_ROOM(room, room_capasity)
	values (230,6),
			(231,6),
			(232,6),
			(233,6),
			(310,4),
			(311,4),
			(312,4);

insert into PATIENTS(patient_id,patient_name,diagnosis,patient_room)
	values (472,'������� �. �.','������ ����������',230),
			(473,'������� �. �.','���� �������',231),
			(474,'������ �. �.','������������ �����',232),
			(475,'������ �. �.','������',233),
			(476,' ������� �. �.','����� 2 �������',233),
			(477,'�������� �. �.' ,'���������',310),
			(478,'������� �. �.','�����',230),
			(479,'����� �. �.','���������� ����������',230);