-- BUSINESS RULES for RSO Database
-- Non-executive members cannot make purchases
CREATE FUNCTION FN_NonExecsNoPurchase()
RETURNS INT
AS
BEGIN
DECLARE @RET INT = 0
IF EXISTS (SELECT *
JOIN tblPOSITION P
JOIN tblMEMBER M ON P.MemberID = M.MemberID
JOIN tblATTENDANCE A ON M.MemberID = A.MemberID
JOIN tblFINANCIAL F ON A.FinancialID = F.FinancialID
WHERE F.Amount > 0
AND PT.PositionTypeDescr LIKE
)
BEGIN
SET @RET = 1
END
RETURN @RET
END
ALTER TABLE tblFINANCIAL
ADD CONSTRAINT CK_NoNonExec
CHECK (dbo.FN_NonExecsNoPurchase() = 0)

-- People who are no longer members or who have joined less than
-- a week before the event cannot have a task
CREATE FUNCTION FN_NoTaskNotActiveMem()
RETURNS INT
AS
BEGIN
DECLARE @RET INT = 0
IF EXISTS (Select *
FROM tblMEMBERSHIP M
JOIN tblMEMBER MR ON M.MemberID = MR.MemberID
JOIN tblATTENDANCE A ON MR.MemberID = A.MemberID
JOIN tblEVENT E ON A.EventID = E.EventID
JOIN tblROLE R ON A.RoleID = R.RoleID
WHERE M.EndDate IS NOT NULL
OR ((E.EventDate - M.BeginDate) > 7)
)
BEGIN
SET @RET = 1
END
RETURN @RET
END
ALTER TABLE tblTask
ADD CONSTRAINT CK_NoTaskforMem
CHECK (dbo.FN_NoTaskNotActiveMem() = 0)
/*Exec can't be President or Vice President if you haven't been a
exec for 1 year*/
CREATE FUNCTION FN_ExecOneYearReq()
RETURNS INT
AS
BEGIN
DECLARE @RET INT = 0
IF EXISTS (
SELECT *
FROM tblPosition P
JOIN tblMemberPosition M ON P.PositionID = M.PositionID
WHERE M.BeginDate > (SELECT GetDate() - 365.25 * 1)
AND (P.PositionName = 'President' OR P.PositionName = 'Vice
President')
)
BEGIN
SET @RET = 1
END
RETURN @RET
END
GO
SELECT dbo.FN_ExecOneYearReq()
ALTER TABLE tblMemberPosition
ADD CONSTRAINT CK_MoreThanOneyear
CHECK (dbo.FN_ExecOneYearReq() = 0)

/*You can't enter an event if your membership isn't valid*/
CREATE FUNCTION FN_ValidMembership()
RETURNS INT
AS
BEGIN
DECLARE @RET = 0
IF EXISTS (
SELECT *
FROM tblMembership MS
JOIN tblMember M ON M.MemberID = MS.MemberID
JOIN tblAttendance A ON M.MemberID = A.MemberID
JOIN tblEvent E ON A.EventID = E.EventID
WHERE MS.Endate < E.Date
)
BEGIN
SET @RET = 1
END
RETURN @RET
END
GO
SELECT dbo.FN_ValidMembership()
ALTER TABLE tblAttendance
ADD CONSTRAINT CK_ValidMember
CHECK (dbo.FN_ValidMembership() = 0)

-- No Member under 17 years old
CREATE FUNCTION FN_NoMemberUnder17()
   RETURNS INT
   AS
   BEGIN
       DECLARE @Ret INT = 0
       IF EXISTS (SELECT *
                   FROM tblMEMBER M
                   WHERE DOB > (SELECT GetDate() - (365.25 * 17)))

       BEGIN
           SET @Ret = 1
       END
       RETURN @Ret
   END
GO
ALTER TABLE tblMEMBER
ADD CONSTRAINT MemberAgeRestrict
CHECK (dbo.FN_NoMemberUnder17() = 0)
GO

-- Phone number can't be longer than 10 digits
CREATE FUNCTION dbo.FN_PhoneNumLengthRestrict()
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0
IF EXISTS(SELECT *
                   FROM tblPhone
                   WHERE len(PhoneNumber) > 10
)
BEGIN
Set @Ret = 1
END
RETURN @Ret
END
GO
SELECT dbo.FN_PhoneNumLengthRestrict()
ALTER TABLE tblPhone with nocheck
ADD CONSTRAINT PhoneNumLengthRestriction
CHECK (dbo.FN_PhoneNumLengthRestrict() = 0)

