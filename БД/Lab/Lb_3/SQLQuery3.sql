--USE master;
--CREATE DATABASE Shi_MyBase_3lb;

use Shi_MyBase_3lb;

create table ������_3
(
	��������_������ nvarchar(50) primary key,
	����������_��_������ int,
	���� smallmoney not null,
	�������_��������� nvarchar(20) not null
);

create table ��������_3
(
	Id_������� int primary key not null,
	�������_������� nvarchar(50) not null,
	��� nvarchar(20) not null,
	�������� nvarchar(50) not null,
	����� nvarchar(50) not null,
	������� nvarchar(20) not null,
	E_mail nvarchar(50) not null,
);

create table ������_3
(
	�����_������ int primary key not null,
	��������_�����������_������ nvarchar(50) not null foreign key references ������_3(��������_������),
	����������_�����������_������ int not null,
	����_������� date not null,
	Id_��������� int not null foreign key references ��������_3(Id_�������)
);

Alter table ������_3 add ������ int;

--Alter table ������_3 drop column ������;