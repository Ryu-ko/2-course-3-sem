use UNIVER
go
---1---PATH ������� �������� � ��� �������
SELECT * FROM TEACHER T
				WHERE T.PULPIT='����' for XML PATH('T'), root('�������������_�������_����'),elements

go

---2---AUTO

SELECT A.AUDITORIUM,AT.AUDITORIUM_TYPE, A.AUDITORIUM_CAPACITY 
	FROM AUDITORIUM A join AUDITORIUM_TYPE AT 
			ON AT.AUDITORIUM_TYPE=A.AUDITORIUM_TYPE WHERE A.AUDITORIUM_TYPE='��'
			for XML AUTO,root('����������_���������'),elements;
			

---3---OPENXML � INSERT 

DECLARE @h int = 0,
		@x varchar(1500)='<?xml version="1.0" encoding="windows-1251" ?>
							<SUBJECTS> 
								<SUBJECT SUBJECT="���" SUBJECT_NAME="���������� ����������� �������" PULPIT="����" /> 
								<SUBJECT SUBJECT="����" SUBJECT_NAME="���������� ��������� � �������" PULPIT="��" /> 
								<SUBJECT SUBJECT="����" SUBJECT_NAME="��������������� ��������� � �������" PULPIT="���"  />  
							</SUBJECTS>'
		EXEC sp_xml_preparedocument  @h output,@x; -- ��������� ������� ����������
		
		--�������� ������ �� � �������� 
		SELECT * FROM openxml (@h, '/SUBJECTS/SUBJECT', 0) --����������,����� XPATH(������� ������), ���� ��� ����� � �������
		with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20)) --��������� ������ ����  
		
		INSERT into SUBJECT select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)
			with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20)) 


		SELECT * from SUBJECT where SUBJECT LIKE '%��'
		EXEC sp_xml_removedocument @h   -- �������� ���������
		SELECT * from SUBJECT


---4---INSERT/ UPDATE/ SELECT QUERY � VALUEXML-����.
USE UNIVER
create table Students
(
	STUDENT nvarchar(200) primary key ,
	PasportData xml
);
 
insert into Students 
values ('�������� ��������� ������������',
		'<Pasport>
			<Sereal>MP</Sereal>
				<Number>22223333</Number>
				<PersonalNumber>124124124</PersonalNumber>
				<Date>15/05/2015</Date>
				<Addres>��.������������, �.110</Addres>
		</Pasport>'),
	   ('����� ����� ��������',
		'<Pasport>
			<Sereal>MP</Sereal>
			<Number>1234555</Number>
			<PersonalNumber>9412412</PersonalNumber>
			<Date>01/04/2014</Date>
			<Addres>��.���������, �.53</Addres>
		</Pasport>'),
		('������� ����� ���������',
							'<Pasport>
							<Sereal>MM</Sereal>
							<Number>55666777</Number>
							<PersonalNumber>123456</PersonalNumber>
							<Date>16/06/2015</Date>
							<Addres>��.���������, �.53</Addres>
						</Pasport>')
 select Students.STUDENT,
		PasportData.value('(/Pasport/Sereal)[1]','varchar(5)')[����� ��������], --[1] ����� ������� ����������
		PasportData.value('(/Pasport/Number)[1]','int')[����� ��������],
		PasportData.value('(/Pasport/PersonalNumber)[1]','varchar(100)')[������ �����],
		PasportData.value('(/Pasport/Date)[1]','varchar(100)')[���� ������],
		PasportData.value('(/Pasport/Addres)[1]','varchar(100)')[����� ��������],
		PasportData.query('/Pasport') [���������� ������] ---��� ��������
			from Students;

update Students 
	  set PasportData = ('<Pasport>
							<Sereal>MM</Sereal>
							<Number>99000888</Number>
							<PersonalNumber>123456</PersonalNumber>
							<Date>16/06/2015</Date>
							<Addres>��.���������, �.53</Addres>
						</Pasport>')
				where PasportData.value('(/Pasport/Number)[1]','int')=1234555
 go
  select Students.STUDENT[Name],
		PasportData.value('(/Pasport/Sereal)[1]','varchar(5)')[����� ��������],
		PasportData.value('(/Pasport/Number)[1]','int')[����� ��������],
		PasportData.query('/Pasport') [���������� ������]
			from Students;



drop table Students

---5---


USE UNIVER;
	CREATE XML SCHEMA COLLECTION STUDENTSS as 
	N'<?xml version="1.0" encoding="utf-16" ?>
	<xs:schema attributeFormDefault="unqualified" 
			elementFormDefault="qualified"
			xmlns:xs="http://www.w3.org/2001/XMLSchema">

		<xs:element name="�������">
			<xs:complexType>
			<xs:sequence>
			<xs:element name="�������" maxOccurs="1" minOccurs="1">
				<xs:complexType>
				<xs:attribute name="�����" type="xs:string" use="required" />
				<xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
				<xs:attribute name="����"  use="required"  >
					<xs:simpleType>  
						<xs:restriction base ="xs:string">
							<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
						</xs:restriction>
					</xs:simpleType>
				</xs:attribute>
				  </xs:complexType>
			</xs:element>

			<xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
				<xs:element name="�����">   
					<xs:complexType>
					<xs:sequence>
						<xs:element name="������" type="xs:string" />
						<xs:element name="�����" type="xs:string" />
						<xs:element name="�����" type="xs:string" />
						<xs:element name="���" type="xs:string" />
						<xs:element name="��������" type="xs:string" />
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
	  INFO  xml(STUDENTSS),    -- �������������� ������� XML-����
	  FOTO   varbinary
	);
	go 

alter table STUDENTSS 
alter column INFO xml(STUDENTSS)

begin tran

	insert into STUDENTSS (IDGROUP,NAME,BDAY,INFO)
		values (2,'������ ���� �������', '1978-07-28',
		'<�������>
		<������� �����="CI" �����="1111111" ����="05.09.2017"/>
		<�������>1234567</�������>
		<�����>
			   <������>��������</������>
			   <�����>�����</�����>
			   <�����>�������������</�����>
			   <���>20</���>
			   <��������>128</��������>
		</�����>
		</�������>')

	update STUDENTSS set INFO= '
		<�������>
			<������� �����="MP" �����="1234567" ����="13.03.2022"/>
			<�������>1234567</�������>
			<�����>
				   <������>��������</������>
				   <�����>�����</�����>
				   <�����>�����������</�����>
				   <���>21</���>
				   <��������>414</��������>
			</�����>
		</�������>'
			 where INFO.value('(�������/�����/�����)[1]','varchar(10)')='�����';

	select IDGROUP,NAME,BDAY, 
		INFO.value('(/�������/�����/������)[1]','varchar(10)') [������],
		INFO.query('/�������/�����')[�����]
	from  STUDENTSS;

rollback


drop table STUDENTSS;
drop xml schema collection Studentss









