--USE master;
--CREATE DATABASE Shi_MyBase_3lb;

use Shi_MyBase_3lb;

create table ТОВАРЫ_3
(
	Название_товара nvarchar(50) primary key,
	Количество_на_складе int,
	Цена smallmoney not null,
	Единица_измерения nvarchar(20) not null
);

create table ЗАКАЗЧИК_3
(
	Id_клиента int primary key not null,
	Фамилия_клиента nvarchar(50) not null,
	Имя nvarchar(20) not null,
	Отчество nvarchar(50) not null,
	Адрес nvarchar(50) not null,
	Телефон nvarchar(20) not null,
	E_mail nvarchar(50) not null,
);

create table ЗАКАЗЫ_3
(
	Номер_заказа int primary key not null,
	Название_заказанного_товара nvarchar(50) not null foreign key references ТОВАРЫ_3(Название_товара),
	Количество_заказанного_товара int not null,
	Дата_продажи date not null,
	Id_заказчика int not null foreign key references ЗАКАЗЧИК_3(Id_клиента)
);

Alter table ЗАКАЗЫ_3 add Скидка int;

--Alter table ЗАКАЗЫ_3 drop column Скидка;