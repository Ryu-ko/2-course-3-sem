use UNIVER
go
---1---PATH независ конфигур с пом псевдон
SELECT * FROM TEACHER T
				WHERE T.PULPIT='ИСиТ' for XML PATH('T'), root('Преподаватели_кафедры_ИСиТ'),elements

go

---2---AUTO

SELECT A.AUDITORIUM,AT.AUDITORIUM_TYPE, A.AUDITORIUM_CAPACITY 
	FROM AUDITORIUM A join AUDITORIUM_TYPE AT 
			ON AT.AUDITORIUM_TYPE=A.AUDITORIUM_TYPE WHERE A.AUDITORIUM_TYPE='ЛК'
			for XML AUTO,root('Лекционные_аудитории'),elements;
			

---3---OPENXML и INSERT 

DECLARE @h int = 0,
		@x varchar(1500)='<?xml version="1.0" encoding="windows-1251" ?>
							<SUBJECTS> 
								<SUBJECT SUBJECT="РПР" SUBJECT_NAME="Разработка программных роботов" PULPIT="ИСиТ" /> 
								<SUBJECT SUBJECT="ИГИГ" SUBJECT_NAME="Инженерная геометрия и графика" PULPIT="ТЛ" /> 
								<SUBJECT SUBJECT="ПГИГ" SUBJECT_NAME="Полиграфическая геометрия и графика" PULPIT="ТиП"  />  
							</SUBJECTS>'
		EXEC sp_xml_preparedocument  @h output,@x; -- процедура определ дескриптор
		
		--извелечь данные из и добавить 
		SELECT * FROM openxml (@h, '/SUBJECTS/SUBJECT', 0) --дескриптор,выраж XPATH(выборка данных), кажд хмл атриб в столбец
		with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20)) --структура формир реза  
		
		INSERT into SUBJECT select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)
			with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20)) 


		SELECT * from SUBJECT where SUBJECT LIKE '%ИГ'
		EXEC sp_xml_removedocument @h   -- удаление документа
		SELECT * from SUBJECT


---4---INSERT/ UPDATE/ SELECT QUERY и VALUEXML-типа.
USE UNIVER
create table Students
(
	STUDENT nvarchar(200) primary key ,
	PasportData xml
);
 
insert into Students 
values ('Манакова Анастасия Владимировна',
		'<Pasport>
			<Sereal>MP</Sereal>
				<Number>22223333</Number>
				<PersonalNumber>124124124</PersonalNumber>
				<Date>15/05/2015</Date>
				<Addres>ул.Первомайская, д.110</Addres>
		</Pasport>'),
	   ('Махно Нестр Петрович',
		'<Pasport>
			<Sereal>MP</Sereal>
			<Number>1234555</Number>
			<PersonalNumber>9412412</PersonalNumber>
			<Date>01/04/2014</Date>
			<Addres>ул.Свердлова, д.53</Addres>
		</Pasport>'),
		('Дыбенко Павел Ефримович',
							'<Pasport>
							<Sereal>MM</Sereal>
							<Number>55666777</Number>
							<PersonalNumber>123456</PersonalNumber>
							<Date>16/06/2015</Date>
							<Addres>ул.Свердлова, д.53</Addres>
						</Pasport>')
 select Students.STUDENT,
		PasportData.value('(/Pasport/Sereal)[1]','varchar(5)')[Серия паспорта], --[1] выбор первого экземпляра
		PasportData.value('(/Pasport/Number)[1]','int')[Номер паспорта],
		PasportData.value('(/Pasport/PersonalNumber)[1]','varchar(100)')[Личный номер],
		PasportData.value('(/Pasport/Date)[1]','varchar(100)')[Дата выдачи],
		PasportData.value('(/Pasport/Addres)[1]','varchar(100)')[Адрес студента],
		PasportData.query('/Pasport') [Паспортные данные] ---хмл фрагмент
			from Students;

update Students 
	  set PasportData = ('<Pasport>
							<Sereal>MM</Sereal>
							<Number>99000888</Number>
							<PersonalNumber>123456</PersonalNumber>
							<Date>16/06/2015</Date>
							<Addres>ул.Свердлова, д.53</Addres>
						</Pasport>')
				where PasportData.value('(/Pasport/Number)[1]','int')=1234555
 go
  select Students.STUDENT[Name],
		PasportData.value('(/Pasport/Sereal)[1]','varchar(5)')[Серия паспорта],
		PasportData.value('(/Pasport/Number)[1]','int')[Номер паспорта],
		PasportData.query('/Pasport') [Паспортные данные]
			from Students;



drop table Students

---5---


USE UNIVER;
	CREATE XML SCHEMA COLLECTION STUDENTSS as 
	N'<?xml version="1.0" encoding="utf-16" ?>
	<xs:schema attributeFormDefault="unqualified" 
			elementFormDefault="qualified"
			xmlns:xs="http://www.w3.org/2001/XMLSchema">

		<xs:element name="студент">
			<xs:complexType>
			<xs:sequence>
			<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
				<xs:complexType>
				<xs:attribute name="серия" type="xs:string" use="required" />
				<xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
				<xs:attribute name="дата"  use="required"  >
					<xs:simpleType>  
						<xs:restriction base ="xs:string">
							<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
						</xs:restriction>
					</xs:simpleType>
				</xs:attribute>
				  </xs:complexType>
			</xs:element>

			<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
				<xs:element name="адрес">   
					<xs:complexType>
					<xs:sequence>
						<xs:element name="страна" type="xs:string" />
						<xs:element name="город" type="xs:string" />
						<xs:element name="улица" type="xs:string" />
						<xs:element name="дом" type="xs:string" />
						<xs:element name="квартира" type="xs:string" />
					</xs:sequence>
					</xs:complexType>  
				</xs:element>
			</xs:sequence>
			</xs:complexType>
		</xs:element>

	</xs:schema>';

go
	CREATE table STUDENTSS
	( 
		IDSTUDENT integer  identity(1000,1) 
			 constraint STUDENTSS_PK  primary key,
	   IDGROUP integer constraint STUDENTSS_GROUP_FK
			 foreign key  references GROUPS(IDGROUP),        
	  NAME nvarchar(100), 
	  BDAY  date,
	  STAMP timestamp,
	  INFO  xml(STUDENTSS),    -- типизированный столбец XML-типа
	  FOTO   varbinary
	);
	go 

alter table STUDENTSS 
alter column INFO xml(STUDENTSS)

begin tran

	insert into STUDENTSS (IDGROUP,NAME,BDAY,INFO)
		values (2,'Котова Катя Котовна', '1978-07-28',
		'<студент>
		<паспорт серия="CI" номер="1111111" дата="05.09.2017"/>
		<телефон>1234567</телефон>
		<адрес>
			   <страна>Беларусь</страна>
			   <город>Брест</город>
			   <улица>Горбушевского</улица>
			   <дом>20</дом>
			   <квартира>128</квартира>
		</адрес>
		</студент>')

	update STUDENTSS set INFO= '
		<студент>
			<паспорт серия="MP" номер="1234567" дата="13.03.2022"/>
			<телефон>1234567</телефон>
			<адрес>
				   <страна>Беларусь</страна>
				   <город>Минск</город>
				   <улица>Белорусская</улица>
				   <дом>21</дом>
				   <квартира>414</квартира>
			</адрес>
		</студент>'
			 where INFO.value('(студент/адрес/город)[1]','varchar(10)')='Брест';

	select IDGROUP,NAME,BDAY, 
		INFO.value('(/студент/адрес/страна)[1]','varchar(10)') [страна],
		INFO.query('/студент/адрес')[адрес]
	from  STUDENTSS;

rollback


drop table STUDENTSS;
drop xml schema collection Studentss









