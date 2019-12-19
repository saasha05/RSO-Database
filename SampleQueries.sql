-- Example queries for RSO Database
-- Which members are studying Informatics who has an executive position in
--  the club and also has more than 3 assigned task
SELECT M.MemberID, M.Fname, M.Lname
FROM tblMEMBER M
JOIN tblMAJOR tM on M.MajorID = tM.MajorID
JOIN tblMemberPosition tMP on M.MemberID = tMP.MemberID
JOIN tblPOSITION tP on tMP.PositionID = tP.PositionID
JOIN tblPositionType tPT2 on tP.PositionTypeID = tPT2.PositionTypeID
JOIN tblPositionTask tPT on tMP.PositionID = tPT.PositionID
JOIN tblTASK tT on tPT.TaskID = tT.TaskID
WHERE tM.MajorName = 'Informatics' AND tPT2.PositionTypeName = 'Executive'
GROUP BY M.MemberID, M.Fname, M.Lname
HAVING COUNT(tT.TaskID) > 3

-- Which Event received the most sponsorship which more than 100 people attending the event of type fundraiser
SELECT TOP 1 E.EventID, E.EventName
FROM tblEVENT E
JOIN tblSponsorship S ON E.EventID = S.EventID
JOIN tblAttendance A ON A.EventID = E.EventID
GROUP BY E.EventID, E.EventName, S.Amount
HAVING COUNT(A.AttendanceID) > 100
ORDER BY S.Amount

/*Which event had more than 120 members attends and with an event
type social located in the Lander Hall?*/
SELECT E.EventID, E.EventName, COUNT(M.MemberID) AS TotalAttended
FROM tblMember M
JOIN tblAttendance A ON M.MemberID = A.MemberID
JOIN tblEvent E ON A.EventID = E.EventID
JOIN tblEventType ET ON E.EventTypeID = ET.EventTypeID
JOIN tblLocation L ON E.LocationID = L.LocationID
WHERE L.LocationName = 'Lander Hall'
AND ET.EventTypeName = 'Social'
GROUP BY E.EventID, E.EventName
HAVING COUNT(M.MemberID) > 120
/*Which Club has more than 100 Informatics and Computer Science
Majors within their club?*/
SELECT C.ClubID, C.ClubName
FROM tblClub C
JOIN tblMembership MS ON C.ClubID = MS.ClubID
JOIN tblMember M ON MS.MemberID = M.MemberID
JOIN tblMajor tM ON M.MajorID = tM.MajorID
WHERE tM.MajorName = 'Informatics' OR tM.MajorName = 'Computer
Science'
GROUP BY C.ClubID, C.ClubName
HAVING COUNT(M.MemberID) > 100

-- Top 5 clubs at the University of Washington with more than 5
-- financial transactions (IDs) of financial type supplies
SELECT TOP 5 with ties C.ClubID, C.ClubName
FROM tblSchool S
JOIN tblCLUB C ON S.SchoolID = C.SchoolID
JOIN tblMEMBER M ON C.ClubID = M.MemberID
JOIN tblATTENDANCE A ON M.MemberID = A.MemberID
JOIN tblFINANCIAL F ON A.FinancialID = F.FinancialID
JOIN tblFinancialType FT on F.FinancialTypeID =
FT.FinancialTypeID
WHERE FT.FinancialTypeName = 'Supplies'
AND S.SchoolName = 'University of Washington'
GROUP BY M.MemberID, C.ClubID, C.ClubName
HAVING COUNT(F.FinancialID) > 5

-- Clubs who have had total sponsorships of over $1000 at social events
SELECT C.ClubName
JOIN tblEVENT E ON A.EventID = E.EventID
JOIN tblClub C ON E.ClubID = C.ClubID
JOIN tblEventType ET ON E.EventTypeID = ET.EventTypeID
JOIN tblSponsorship S ON E.EventID = S.EventID
WHERE ET.EventTypeName =
GROUP BY S.SponsorshipID, C.ClubName
HAVING SUM(S.AMOUNT) > '1000'