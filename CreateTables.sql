CREATE TABLE tblMembership
(MembershipID INTEGER IDENTITY(1, 1) primary key not null,
ClubID  INT FOREIGN KEY REFERENCES tblClub(ClubID) not null,
MemberID  INT FOREIGN KEY REFERENCES tblMEMBER(MemberID) not null,
BeginDate Date DEFAULT GetDate() not null,
EndDate Date NULL)

CREATE TABLE tblROLE
(RoleID INTEGER IDENTITY(1, 1) primary key not null,
RoleName varchar(50) not null,
RoleDescr varchar(500) NULL)

CREATE TABLE tblMAJOR
(MajorID INTEGER IDENTITY(1, 1) primary key not null,
MajorName varchar(100) not null,
MajorDescr varchar(500) NULL)

CREATE TABLE tblMEMBER
(MemberID INTEGER IDENTITY(1, 1) primary key not null,
FName varchar(50) not null,
Lname varchar(50) not null,
DOB Date NULL,
MemYear varchar(20),
MajorID INT FOREIGN KEY REFERENCES tblMAJOR(MajorID) not null,
Email varchar(80) not null)

CREATE TABLE tblPositionType
(PositionTypeID INTEGER IDENTITY(1, 1) primary key not null,
PositionTypeName varchar(50) not null,
PositionTypeDescr varchar(500) not null
)
CREATE TABLE tblTASK
(TaskID INTEGER IDENTITY(1, 1) primary key not null,
TaskName varchar(100) not null,
TaskDescr varchar(500))

CREATE TABLE tblPOSITION
(PositionID INTEGER IDENTITY(1, 1) primary key not null,
PositionTypeID INT FOREIGN KEY REFERENCES tblPositionType(PositionTypeID) not null,
TaskID INT FOREIGN KEY REFERENCES tblTask(TaskID) null,
PositionName varchar(100) not null,
PositionDescr varchar(500) NULL)

CREATE TABLE tblMemberPosition
(MemberPositionID INTEGER IDENTITY(1, 1) primary key not null,
MemberID INT FOREIGN KEY REFERENCES tblMEMBER(MemberID) not null,
PositionID INT FOREIGN KEY REFERENCES tblPOSITION(PositionID) not null,
BeginDate Date DEFAULT GetDate() not null,
EndDate Date NULL)

CREATE TABLE tblPositionTask
(PositionTaskID INTEGER IDENTITY(1,1) primary key not null,
TaskID INT FOREIGN KEY REFERENCES tblTASK(TaskID) not null,
PositionID INT FOREIGN KEY REFERENCES tblPOSITION(PositionID) not null)

CREATE TABLE tblPreferenceType (
PreferenceTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PreferenceTypeName VARCHAR(50) NOT NULL,
PreferenceTypeDescr VARCHAR(150) NOT NULL
)
CREATE TABLE tblPreference (
PreferenceID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PreferenceTypeID INT FOREIGN KEY REFERENCES
tblPreferenceType(PreferenceTypeID) NOT NULL,
PreferenceName VARCHAR(50) NOT NULL,
PreferenceDescr VARCHAR(150) NOT NULL
)
CREATE TABLE tblMemberPreference (
MemberPreferenceID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
MemberID INT FOREIGN KEY REFERENCES tblMember(MemberID) NOT
NULL,
PreferenceID INT FOREIGN KEY REFERENCES
tblPreference(PreferenceID) NOT NULL
)
CREATE TABLE tblClub (
ClubID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ClubTypeID INT FOREIGN KEY REFERENCES tblClubType(ClubTypeID)
NOT NULL,
DateCreated DATE NOT NULL,
SchoolID INT FOREIGN KEY REFERENCES tblSchool(SchoolID) NOT
NULL,
ClubName VARCHAR(50) NOT NULL
)
CREATE TABLE tblClubType (
ClubTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ClubTypeName VARCHAR(50) NOT NULL,
ClubTypeDescr VARCHAR(100) NOT NULL
)
CREATE TABLE tblSchool (
SchoolID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
SchoolName VARCHAR(50) NOT NULL,
SchoolDescr VARCHAR(150) NOT NULL
)
CREATE TABLE tblTemplate (
TemplateID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
TemplateTypeID INT FOREIGN KEY REFERENCES
tblTemplateType(TemplateTypeID) NOT NULL,
TemplateName VARCHAR(50) NOT NULL,
TemplateDescr VARCHAR(100) NOT NULL,
DateMade DATE NOT NULL
)
CREATE TABLE tblTemplateType (
TemplateTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
TemplateTypeName VARCHAR(50),
TemplateTypeDescr VARCHAR(100)
)

CREATE TABLE tblEVENT(
EventID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
EventName varchar(50) NOT NULL,
EventDescr varchar(500) NULL,
EventDate DATE NOT NULL,
TemplateID INT FOREIGN KEY REFERENCES tblTEMPLATE (TemplateID)
NOT NULL,
LocationID INT FOREIGN KEY REFERENCES tblLOCATION (LocationID)
NOT NULL,
EventTypeID INT FOREIGN KEY REFERENCES tblEVENT_TYPE
(EventTypeID) NOT NULL,
ClubID INT FOREIGN KEY REFERENCES tblCLUB (ClubID) NOT NULL
)
CREATE TABLE tblLOCATION(
LocationID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
LocationTypeID INT FOREIGN KEY REFERENCES tblLOCATION_TYPE
(LocationTypeID) NOT NULL,
LocationName varchar(50) NOT NULL,
LocationDescr varchar(500) NULL
)
CREATE TABLE tblEVENT_TYPE(
EventTypeID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
EventTypeName varchar(50) NOT NULL,
EventTypeDescr varchar(500) NULL
)
CREATE TABLE tblLOCATION_TYPE(
LocationTypeID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
LocationTypeName varchar(50) NOT NULL,
LocationTypeDescr varchar(500) NULL
)
CREATE TABLE tblSPONSORSHIP(
SponsorshipID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
SponsorID INT FOREIGN KEY REFERENCES tblSPONSOR (SponsorID) NOT
NULL,
EventID INT FOREIGN KEY REFERENCES tblEVENT (SponsorID) NOT NULL,
Amount NUMERIC(7,2) NOT NULL
)
CREATE TABLE tblSPONSOR(
SponsorID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
SponsorName varchar(50) NOT NULL,
SponsorTypeID INT FOREIGN KEY REFERENCES tblSPONSOR_TYPE
(SponsorTypeID) NOT NULL
)
CREATE TABLE tblSPONSOR_TYPE(
SponsorTypeID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
SponsorTypeName varchar(50) NOT NULL,
SponsorTypeDescr varchar(500) NULL
)
CREATE TABLE tblMemberPhone(
MemberPhoneId INT IDENTITY(1, 1) primary key not null,
MemberID INT FOREIGN KEY REFERENCES tblMember(MemberID) not
null,
PhoneID INT FOREIGN KEY REFERENCES tblPhone(PhoneID) not null,,
PhoneTypeID INT FOREIGN KEY REFERENCES
tblPhoneNumType(tblPhoneNumType) not null,
);
CREATE TABLE tblPhoneNumType(
phoneNumTypeID INT IDENTITY(1, 1) primary key not null,
phoneTypeName varchar(50),
phoneTypeDescr varchar(50)
);
CREATE TABLE tblPhone(
phoneID INT IDENTITY(1, 1) primary key not null,
phoneNumber int,
);
CREATE TABLE tblMember(
MemberID int IDENTITY(1, 1) primary key not null,
FName varchar(50),
LName varchar(50),
DOB numeric,
[Year] INT,
MajorID INT,
email varchar(50)
);
CREATE TABLE tblAttendance(
AttendanceID INT IDENTITY(1, 1) primary key not null,
MemberID INT REFERENCES tblMember(MemberID) NOT NULL,
EventID INT,
FinancialID INT REFERENCES tblFinancial(FinancialID) NOT NULL,
RoleID INT,
);
CREATE TABLE tblFinancial(
FinancialID INT IDENTITY(1, 1) primary key not null,
FinancialTypeID INT REFERENCES
tblFinancialType(FinancialTypeID) NOT NULL,
FinancialName varchar(50),
FeeAmount numeric(5,2)
);
CREATE TABLE tblFinancialType(
FinancialTypeID INT IDENTITY(1, 1) primary key not null,
FinancialTypeName varchar(50),
FinancialTypeDescr varchar(50)
);
