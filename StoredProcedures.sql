
-- STORED PROCEDURES for RSO Database
-- Event
CREATE PROCEDURE SP_Event
@Name varchar(50),
@Descr varchar(500),
@Date DATE,
@Template varchar(50),
@Loc varchar(50),
@EventType varchar(50),
@Club varchar(50)
AS
DECLARE @T_ID INT
DECLARE @L_ID INT
DECLARE @ET_ID INT
DECLARE @C_ID INT
SET @T_ID = (SELECT TemplateID FROM tblTEMPLATE WHERE
TemplateName = @Template)
SET @L_ID = (SELECT LocationID FROM tblLOCATION WHERE
LocationName = @Loc)
SET @ET_ID = (SELECT EventTypeID FROM tblEVENT_TYPE WHERE
EventTypeName = @EventType)
SET @C_ID = (SELECT ClubID FROM tblCLUB WHERE ClubName = @Club)
INSERT INTO tblEvent(EventName, EventDescr, Date, MediaID,
LocationID, EventTypeID, ClubID)
VALUES (@Name, @Descr, @Date, @M_ID, @L_ID, @ET_ID, @C_ID)

-- Location
CREATE PROCEDURE SP_Location
@LocName varchar(50),
@LocDescr varchar(500),
@LocType varchar(50)
AS
DECLARE @LT_ID INT
SET @LT_ID = (SELECT LocationTypeID FROM tblLOCATION_TYPE WHERE
LocationTypeName =
@LocType)
INSERT INTO tblLocation(LocationTypeID, LocationName,
LocationDescr)
VALUES (@LT_ID, @LocName, @LocDescr)
-- Add an position to table position
CREATE PROCEDURE AddPositionInExec
@PositionName varchar(100),
@PositionDescr varchar(500),
@PosTypeName varchar(50),
@TaskName varchar(100)
AS
DECLARE @PositionTypeID INT, @TaskID INT
SET @PositionTypeID = (SELECT PositionTypeID FROM tblPositionType WHERE PositionTypeName = @PosTypeName)
SET @TaskID = (SELECT TaskID FROM tblTASK WHERE TaskName = @TaskName)
BEGIN TRANSACTION H1
INSERT INTO tblPOSITION(PositionTypeID, TaskID, PositionName, PositionDescr)
VALUES(@PositionTypeID, @TaskID, @PositionName, @PositionDescr)
COMMIT TRANSACTION H1

-- add a new member to existing position
CREATE PROCEDURE AddewMemberToPos
@Fname varchar(50),
@Lname varchar(50),
@Birth Date,
@Yr varchar(20),
@Major varchar(50),
@email varchar(80),
@PosName varchar(50)
AS
DECLARE @MemID INT, @PosID INT, @MajID INT
SET @MajID = (SELECT MajorID FROM tblMAJOR WHERE MajorName = @Major)
SET @PosID = (SELECT PositionID FROM tblPOSITION WHERE PositionName = @PosName)
BEGIN TRANSACTION H1
INSERT INTO tblMember(FName, Lname, DOB, MemYear, MajorID, Email)
VALUES(@Fname, @Lname, @Birth, @Yr, @MajID, @email)
SET @MemID = (SELECT SCOPE_IDENTITY())
INSERT INTO tblMemberPosition(MemberID, PositionID, BeginDate)
VALUES (@MemID, @PosID, GETDATE())
COMMIT TRANSACTION H1

-- Add a new task to an existing position
CREATE PROCEDURE AddNewTaskToPos
@TName varchar(80),
@TDescr varchar(500),
@PosName varchar(50)
AS
DECLARE @PosID INT, @TaskID INT
SET @PosID = (SELECT PositionID FROM tblPOSITION WHERE PositionName = @PosName)
BEGIN TRANSACTION H1
   INSERT INTO tblTASK(TaskName, TaskDescr)
   VALUES(@Tname, @TDescr)
   SET @TaskID = (SELECT SCOPE_IDENTITY())
   INSERT INTO tblPositionTask(TaskID, PositionID)
   VALUES (@TaskID, @PosID)
COMMIT TRANSACTION H1

/*SPROC Member Preference*/
CREATE PROCEDEURE newMemberPreference
@Fname VARCHAR(50),
@Lname VARCHAR(50),
@Year INT,
@PreferenceName VARCHAR(50)
AS
DECLARE @M_ID INT, @P_ID INT
SET @M_ID = (
SELECT M.MemberID
FROM tblMember M
WHERE M.Fname = @Fname
AND M.Lname = @Fname
AND M.MemYear = @Year
)
SET @P_ID = (
SELECT P.PreferenceID
FROM tblPreference P
WHERE P.PreferenceName = @PreferenceName
)
INSERT INTO tblMemberPreference (MemberID, PreferenceID)
VALUES (@M_ID, @P_ID)
/*SPROC Club*/
CREATE PROCEDURE newClub
@DateCreated DATE,
@School VARCHAR(50),
@ClubName VARCHAR(50),
@ClubTypeName VARCHAR(50)
AS
DECLARE @C_ID INT = (
SELECT CT.ClubTypeID
FROM tblClubType CT
WHERE CT.ClubTypeName = @ClubTypeName
)
DECLARE @S_ID INT = (
SELECT S.SchoolID
FROM tblSchool S
WHERE S.SchoolName = @School
)
INSERT INTO tblClub (ClubTypeID, DateCreated, SchoolID, ClubName)
VALUES (@C_ID, @DateCreated, @S_ID, @ClubName)
