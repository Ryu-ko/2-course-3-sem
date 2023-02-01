USE master;
go
CREATE DATABASE PP_MyBase
ON PRIMARY
(name = N'PP_MyBase_mdf', filename = N'F:\.Уник\2 курс\БД\Lab\Lb_3\PP_MyBase_mdf.mdf',
size = 10240Kb, maxsize = UNLIMITED, filegrowth = 10240Kb),
(name = N'PP_MyBase_ndf', filename = N'F:\.Уник\2 курс\БД\Lab\Lb_3\PP_MyBase_ndf',
size = 10240Kb, maxsize = 1Gb, filegrowth = 25%),
filegroup FG1
(name = N'PP_MyBase_fg1_1', filename = N'F:\.Уник\2 курс\БД\Lab\Lb_3\PP_MyBase_fgq-1.ndf',
size = 10240Kb, maxsize = 1Gb, filegrowth = 25%),
(name = N'PP_MyBase_fg1_2', filename = N'F:\.Уник\2 курс\БД\Lab\Lb_3\PP_MyBase_fgq-2.ndf',
size = 10240Kb, maxsize = 1Gb, filegrowth = 25%)
log on
(name = N'PP_MyBase_log', filename = N'F:\.Уник\2 курс\БД\Lab\Lb_3\PP_MyBase_log.log',
size = 10240Kb, maxsize = 2048Gb, filegrowth = 10%)
go