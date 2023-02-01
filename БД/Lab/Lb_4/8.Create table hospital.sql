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
	values (472,'Коринов Е. Д.','Острый аппендицит',230),
			(473,'Милорин Ф. Е.','Язва желудка',231),
			(474,'Мойнов А. А.','Бронхиальная астма',232),
			(475,'Якутин С. Н.','Ангина',233),
			(476,' Гордова Н. С.','Ожоги 2 степени',233),
			(477,'Симонова Е. Д.' ,'Анорексия',310),
			(478,'Цидорин О. Ф.','Грипп',230),
			(479,'Щеков Д. Д.','Воспаление лимфоузлов',230);