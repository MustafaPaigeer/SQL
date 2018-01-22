IF  EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ASMIS')
drop database ASMIS
go

CREATE DATABASE ASMIS
ON PRIMARY 
(
NAME =ASMIS,
FILENAME='C:\ASMIS\ASMIS.mdf',
SIZE =3MB,
MAXSIZE =10MB,
FILEGROWTH =10%)

LOG ON 
(
NAME =ASMIS_LOG,
FILENAME='C:\ASMIS\ASMIS.ldf',
SIZE =2MB,
MAXSIZE =10MB,
FILEGROWTH =10%)
GO

USE [ASMIS]
GO


CREATE TABLE [dbo].[Province](
	[ProvinceID] [varchar](2) NOT NULL,
	[Province] [varchar](100) NULL,
 CONSTRAINT [PK__province__D445B64231EC6D26] PRIMARY KEY CLUSTERED 
(
	[ProvinceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [ASMIS]
GO


CREATE TABLE [dbo].[District](
	[DistrictID] [varchar](4) NOT NULL,
	[ProvinceID] [varchar](2) NOT NULL,
	[District] [varchar](50) NULL,
 CONSTRAINT [PK__district__51E7C0022A4B4B5E] PRIMARY KEY CLUSTERED 
(
	[DistrictID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[district]  WITH CHECK ADD  CONSTRAINT [fk_district] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[province] ([ProvinceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[district] CHECK CONSTRAINT [fk_district]
GO



USE [ASMIS]
GO

CREATE TABLE [dbo].[Student](
	[StudentID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[Sex] [varchar](20) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[TazkiraNumber] [int] NOT NULL,
	[MaritalStatus] [varchar](20) NOT NULL,
	[PreviousSchool] [varchar](150) NULL,
	[Grade] [varchar](20) NULL,
	[HealthStatus] [varchar](120) NOT NULL,
	[Shift] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[studentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [ASMIS]
GO


CREATE TABLE [dbo].[CurrentAddress](
	[Cur_AddressID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[Districtid] [varchar](4) NULL,
	[Nahia] [varchar](100) NULL,
	[Village] [varchar](100) NULL,
	[Street] [varchar](100) NULL,
	[HouseNo] [varchar](500) NULL,
 CONSTRAINT [PK__current___98F8995F398D8EEE] PRIMARY KEY CLUSTERED 
(
	[Cur_AddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[currentAddress]  WITH CHECK ADD  CONSTRAINT [fk_current] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[district] ([DistrictID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[currentAddress] CHECK CONSTRAINT [fk_current]
GO

ALTER TABLE [dbo].[currentAddress]  WITH CHECK ADD  CONSTRAINT [fk_currentadddress] FOREIGN KEY([StudentID])
REFERENCES [dbo].[student] ([studentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[currentAddress] CHECK CONSTRAINT [fk_currentadddress]
GO

USE [ASMIS]
GO


CREATE TABLE [dbo].[Assignment](
	[AssignmentID] varchar(10) NOT NULL,
	[TeacherID] [int] NOT NULL,
	[ClassID] int not null,
	[SubjectID] int not null,
	[Assignment] [varchar](250) NULL,
	[Dated] [date] NOT NULL,
	[Title] varchar(100),
	[Comments] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
 [AssignmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

use asmis

Create table dbo.AssignmentResult 
(
AssignmentID varchar(10) NOT NULL,
StudentID int not null,
Result int,
Comments int,
Primary key
(
[AssignmentID] ASC,
StudentId ASC
)
)

alter table dbo.AssignmentResult with check add constraint fk_AssignmentResult_assignment foreign key ([AssignmentID])
references [dbo].[Assignment]  ([AssignmentID])
on delete cascade
on update cascade
go

alter table dbo.AssignmentResult with check add constraint fk_AssignmentResult_student foreign key (StudentId)
references [dbo].[Student]  (StudentId)
on delete cascade
on update cascade
go

USE [ASMIS]
GO


CREATE TABLE [dbo].[Class](
	[ClassID] [int] NOT NULL,
	[ClassName] [varchar](100) NULL,
	[Description] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [ASMIS]
GO


CREATE TABLE [dbo].[Attendance](
	[AttendanceID] varchar(12) NOT NULL,
	 ClassID int not null,
	[TeacherID] [int] NOT NULL,
	[SubjectID] [int] NOT NULL,
	[Dated] [date] NOT NULL,
	[Comments] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[AttendanceID]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

create table AttendanceRecord
(
AttendanceID varchar(12) not null,
StudentID int not null,
Status varchar(50) not null,
Comments varchar(300),

primary key clustered 
(
StudentID ASC,
AttendanceID
)
)
go
alter table dbo.AttendanceRecord with check add constraint fk_AttendanceRecords foreign key (AttendanceID)
references dbo.[Attendance] (AttendanceID) on delete cascade on update cascade

alter table dbo.AttendanceRecord with check add constraint fk_AttendanceRecords_student foreign key (studentid)
references dbo.Student (studentid) on delete cascade on update cascade

USE [ASMIS]
GO


CREATE TABLE [dbo].[Examination](
	[ExamID] varchar(15) NOT NULL,
	[TermID] [int] NOT NULL,
	[SubjectID] [int] NOT NULL,
	[TeacherID] [int] NOT NULL,
	[ClassID] int not null,
	[Date] [date] NOT NULL,
	[Comments] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

create table dbo.ExaminationScore 
(
ExamID varchar(15) not null,
StudentID int not null,
Score int,
Comments varchar(300)
primary key clustered 
(
ExamID ASC,
StudentID ASC
)
)

alter table dbo.ExaminationScore with check add constraint fk_examinationscore foreign key (ExamID)
references dbo.Examination (ExamID)
on delete cascade
on update cascade
go

USE [ASMIS]
GO


CREATE TABLE [dbo].[Fee](
	[FeeID] [int] NOT NULL,
	[StudentID] [int] not NULL,
	[FeeTypeID] [int] not NULL,
	[ClassID] int not null,
	[Year] int not NULL,
	[Month]int not NULL,
	[Amount] [int] NULL,
	[Discount] [int] NULL,
	[AccountNo] [varchar](300) NULL,
	[BankName] [varchar](200) NULL,
	[Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Year] ASC,
	[Month] ASC,
	[ClassID] ASC,
	[FeeTypeID] ASC,
	[StudentID]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
USE [ASMIS]
GO


CREATE TABLE [dbo].[FeeType](
	[FeeTypeID] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Discription] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[FeetypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


USE [ASMIS]
GO


CREATE TABLE [dbo].[Parent](
	[ContactID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[Phone] [int] NULL,
	[Mobile] [int] NULL,
	[Email] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Relation] [varchar](100) NULL,
	[Province] [varchar](150) NULL,
	[District] [varchar](150) NULL,
	[Village] [varchar](150) NULL,
	[UserID] [int] NULL,
	[LastUpdate] [date] NULL,
 CONSTRAINT [PK__Parents__5C6625BB1367E606] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[Parent]  WITH CHECK ADD  CONSTRAINT [FK_Parents_student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[student] ([studentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Parent] CHECK CONSTRAINT [FK_Parents_student]
GO

USE [ASMIS]
GO


CREATE TABLE [dbo].[PermanentAddress](
	[Addressid] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[DistrictID] [varchar](4) NULL,
	[Nahia] [varchar](50) NULL,
	[Village] [varchar](100) NULL,
	[Street] [varchar](100) NULL,
	[HouseNo] [varchar](50) NULL,
 CONSTRAINT [PK__permanen__091B36D33D5E1FD2] PRIMARY KEY CLUSTERED 
(
	[Addressid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[permanentAddress]  WITH CHECK ADD  CONSTRAINT [fk_permanent] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[district] ([DistrictID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[permanentAddress] CHECK CONSTRAINT [fk_permanent]
GO

ALTER TABLE [dbo].[permanentAddress]  WITH CHECK ADD  CONSTRAINT [fk_permanentadddress] FOREIGN KEY([StudentID])
REFERENCES [dbo].[student] ([studentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[permanentAddress] CHECK CONSTRAINT [fk_permanentadddress]
GO

USE [ASMIS]
GO


CREATE TABLE [dbo].[Subject](
	[SubjectID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[Subject] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[Discription] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [ASMIS]
GO

CREATE TABLE [dbo].[Teacher](
	[TeacherID] [int] NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [ASMIS]
GO

CREATE TABLE [dbo].[Term](
	[TermID] [int] NOT NULL,
	[Description] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[TermID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [ASMIS]
GO


CREATE TABLE [dbo].[UserRole](
	[RoleID] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [ASMIS]
GO



CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[UserName] [varchar](50) NOT NULL Unique,
	[Password] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Phone] [varchar](25) NULL,
	[Email] [varchar](80) NULL,
	[Activated] [varchar](100) NULL,
	[OldPassword] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	UserID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [fk_users] FOREIGN KEY([RoleID])
REFERENCES [dbo].[UserRole] ([RoleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [fk_users]
GO

alter table dbo.Fee with check add constraint fk_fee foreign key (FeetypeID) 
references dbo.Feetype (FeetypeID)
on delete cascade
on update cascade
Go

alter table dbo.Fee with check add constraint fk_fee_student foreign key (StudentID) 
references dbo.Student(StudentID)
on delete cascade
on update cascade
Go

alter table dbo.Subject with check add constraint fk_subject foreign key (ClassID)
references dbo.Class (ClassID) 
on delete cascade
on update cascade
Go


alter table dbo.Examination with check add constraint fk_terms_examination foreign key (TermID)
references dbo.Term (TermID) 
on delete cascade
on update cascade
Go

alter table dbo.Examination with check add constraint fk_teacher_examination foreign key(TeacherID)
references dbo.Teacher (TeacherID) 
on delete cascade
on update cascade
Go

alter table dbo.Fee with check add constraint fk_fee_class foreign key (ClassID)
references dbo.Class (ClassID)
on delete cascade
on update cascade
go

alter table dbo.Attendance with check add constraint fk_attendance_teacher foreign key (TeacherID)
references dbo.Teacher (TeacherID)
on delete cascade
on update cascade
go

alter table dbo.Attendance with check add constraint fk_subject_teacher foreign key (SubjectID)
references dbo.Subject (SubjectID)
on delete cascade
on update cascade
go

alter table dbo.Assignment with check add constraint fk_subject_assignement foreign key (SubjectID)
references dbo.Subject (SubjectID) 
on delete cascade
on update cascade
Go

alter table dbo.Examination with check add constraint fk_examination_subject foreign key 
(SubjectID)
references dbo.Subject (SubjectID) 
on delete cascade
on update cascade


alter table dbo.ExaminationScore with check add constraint fk_examinationscore_student foreign key (StudentID)
references dbo.Student (StudentID) 
on delete cascade
on update cascade
go

use asmis
alter table dbo.Attendance add UserID int not null
alter table dbo.Assignment add UserID int not null
alter table dbo.Examination add UserID int not null
alter table dbo.Fee add UserID int not null
alter table dbo.Subject add UserID int not null
alter table dbo.Teacher add UserID int not null

alter table dbo.Attendance add LastUpdate date 
alter table dbo.Assignment add  LastUpdate date
alter table dbo.Examination add  LastUpdate date
alter table dbo.Fee add  LastUpdate date
alter table dbo.Subject add  LastUpdate date
alter table dbo.Teacher add  LastUpdate date
go

use asmis
alter table dbo.Attendance with check add constraint fk_user_attendance foreign key(UserID) references dbo.Users(UserID) 
on update cascade 
alter table dbo.Examination with check add constraint fk_user_Examination foreign key (UserID) references dbo.Users (UserID) on update cascade 
alter table dbo.Assignment with check add constraint fk_user_Assignment foreign key (UserID) references dbo.Users (UserID) on update cascade 
alter table dbo.Fee with check add constraint fk_user_Fee foreign key (UserID) references dbo.Users (UserID) on update cascade 
alter table dbo.Parent with check add constraint fk_user_Parent foreign key (UserID) references dbo.Users (UserID) on update cascade 
alter table dbo.Subject with check add constraint fk_user_Subject foreign key (UserID) references dbo.Users (UserID)
alter table dbo.Teacher with check add constraint fk_user_Teacher foreign key (UserID) references dbo.Users (UserID)
go