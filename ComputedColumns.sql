-- Computed Columns for RSO Database
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

-- # of members in each major who began memberships YTD at UW
CREATE FUNCTION FN_MajorsinClub(@PK varchar(20))
RETURNS INT
AS
BEGIN
DECLARE @RET Int
SET @RET = (SELECT COUNT(MS.MemberID)
FROM tblMAJOR M
JOIN tblMEMBER MB ON M.MajorID=MB.MajorID
JOIN tblMEMBERSHIP MS ON MB.MemberID = MS.MemberID
JOIN tblCLUB C ON MS.ClubID = C.ClubID
JOIN tblSchool S ON C.SchoolID = S.SchoolID
WHERE M.MajorName = @PK
AND YEAR(MS.BeginDate) = YEAR(GetDate())
AND S.SchoolName LIKE '%University of Washington%')
RETURN @RET
END
ALTER TABLE tblMAJOR
ADD TotalNewMembersatUW AS (dbo.FN_MajorsinClub(MajorName))

--Amount of money raised from sponsors for fundraisers in the past 6 MO
GO
CREATE FUNCTION FN_SponsorsforClub(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT
SET @RET = (SELECT SUM(S.Amount) AS MoneyfromSponsorship
FROM tblSPONSORSHIP S
JOIN tblEVENT E on S.EventID = E.EventID
JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
JOIN tblClUB C on E.ClubID = C.ClubID
WHERE C.ClubID = @PK
AND ET.EventTypeName LIKE '%fundraiser%'
AND E.Date > (SELECT GetDate() - (365.25*0.5)))
RETURN @RET
END
ALTER TABLE tblClUB
ADD AmountfromSponsor6Mo AS (dbo.FN_SponsorsforClub(ClubID)))
-- The amount of time in club
CREATE FUNCTION CALC_DurationInClub(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = (SELECT DATEDIFF(month, MP.BeginDate, MP.EndDate)
					FROM tblMEMBER M
					JOIN tblMemberPosition MP ON M.MemberID = MP.MemberID
					WHERE M.MemberID = @PK AND MP.EndDate IS NOT NULL
					)
RETURN @Ret
END
GO
ALTER TABLE tblMEMBER
ADD Duration
AS(dbo.CALC_DurationInClub(MemberID))


-- Total amount of financial type expense
USE Proj_B3
CREATE FUNCTION CALC_TotalExpenses(@PK INT)
RETURNS INT
AS
BEGIN
   DECLARE @Ret INT = (SELECT SUM(FeeAmount)
                       FROM tblFinancial F
                       JOIN tblFinancialType FT ON F.FinancialTypeID = FT.FinancialTypeID
                       WHERE FT.FinancialTypeName LIKE '%Expense%')
   RETURN @Ret
END
GO
ALTER TABLE tblFinancial
ADD TotalExpense
AS(dbo.CALC_TotalExpenses(FinancialID))

/*Total Number of Active Execs for the Club*/
CREATE FUNCTION FN_TotalActiveExec(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (
SELECT COUNT(*)
FROM tblClub C
JOIN tblMembership MS ON C.ClubID = MS.ClubID
JOIN tblMember M ON MS.MemberID = M.MemberID
JOIN tblMemberPosition MP ON M.MemberID = MP.MemberID
WHERE C.ClubID = @PK
AND MP.EndDate > (SELECT GetDate())
)
RETURN @RET
END
GO
ALTER TABLE tblClub
ADD TotalActiveExec AS (dbo.FN_TotalActiveExec(ClubID))
