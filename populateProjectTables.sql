USE Proj_B3

INSERT INTO tblPhoneNumType(PhoneTypeName, PhoneTypeDescr)
VALUES ('Home', 'A landline phone number'),
('Emergency', 'A number you call in case of emergencies'),
('Main', 'Primary contact phone number'),
('Alternative', 'An alternative phone number to contact'),
('Other', 'Any other miscellaneous phone number type')

INSERT INTO tblRole(RoleName, RoleDescr)
VALUES
('Speaker', 'Was a speaker at an event'),
('Sign in', 'Responsible for signing in people into the event'),
('Assisting', 'Helping students who need extra assistance throughout the event'),
('Navigator', 'Showing people where to go/sit during the event'),
('Host', 'Announces the agenda for the day, or each segment of the event')

INSERT INTO tblTask(TaskName, TaskDescr)
VALUES
('Create flyer', 'Creates flyers for an event or for the club'),
('Book venue', 'Book venue for an event appropriate for the purposes'),
('Increase awareness', 'Find ways to spread the word about events'),
('Print outline', 'Print copies of event outline to distribute to attendees'),
('Post on Social media', 'Post about events, intiation or goal of the club on social media platforms')

-- Populate Members
EXEC AddNewMember 'Uriel', 'Mooney', '6/12/2001', '2018', 'umooney0@linkedin.com', 'Informatics'
EXEC AddNewMember 'Aleece', 'Bullin', '7/3/1998', '2018', 'abullin1@fda.gov', 'Business'
EXEC AddNewMember 'Modestine', 'Tomich', '8/30/2000', '2016', 'mtomich2@pagesperso-orange.fr', 'Computer Science'
EXEC AddNewMember 'Eleni', 'Burl', '11/16/2001', '2017', 'eburl3@businesswire.com', 'Informatics'
EXEC AddNewMember 'Wendell', 'Rasher', '12/3/1997','2017', 'wrasher4@ifeng.com', 'Mathematics'
EXEC AddNewMember 'Taddeo', 'Renol', '12/23/1996', '2017', 'trenol5@scientificamerican.com', 'Human Centered Design and Engineering'
EXEC AddNewMember 'Noam', 'Johnsee', '8/24/1999', '2016', 'njohnsee6@amazon.co.uk', 'Informatics'
EXEC AddNewMember 'Gwyn', 'Muslim', '3/21/1998', '2016', 'gmuslim7@ebay.com', 'Computer Science'
EXEC AddNewMember 'Hervey', 'Olenchenko', '9/12/1998','2016', 'holenchenko8@fastcompany.com', 'Business'
EXEC AddNewMember 'Brandi', 'Lill', '3/12/1996', '2017', 'blill9@123-reg.co.uk','Informatics'

insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Gabbey', 'Castleman', '7/12/1980', 'gcastleman0@cnbc.com', 3, '1998');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Haslett', 'Camus', '10/31/1977', 'hcamus1@jimdo.com', 2, '1995');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Ulric', 'Glandfield', '7/8/1972', 'uglandfield2@eventbrite.com', 1, '1990');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Ferne', 'Bunyan', '2/3/1988', 'fbunyan3@arizona.edu', 5, '2006');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Cecil', 'Aitkin', '6/15/1970', 'caitkin4@tumblr.com', 4, '1988');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Priscella', 'Kleinber', '2/24/1987', 'pkleinber5@noaa.gov', 6, '2005');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Gleda', 'Bryan', '12/2/1979', 'gbryan6@foxnews.com', 6, '1997');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Crichton', 'Elbourne', '10/22/1991', 'celbourne7@people.com.cn', 6,'2009');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Teresita', 'Peyton', '11/21/1971', 'tpeyton8@hhs.gov', 1, '1989');
insert into tblMEMBER (FName, LName, DOB, Email, MajorID, MemYear) values ('Jackson', 'Arthur', '8/13/1983', 'jarthur9@oracle.com', 6, '2001');

INSERT INTO tblPositionType(PositionTypeName, PositionTypeDescr)
VALUES('Member', 'Any member of the club that doesnt have administrative responsibilities'),
('Executive', 'Any member of the club that has administrative responsibilities')

INSERT INTO tblPosition(PositionTypeID, PositionName)
VALUES(2, 'President'), (2, 'Vice President'), (2, 'Outreach Coordinator'), (2, 'Creative Director'), (1, 'Member')

INSERT INTO tblMemberPosition(MemberID, PositionID, BeginDate, EndDate)
VALUES(14, 5, '1999', '9/30/2001'), (15, 5, '9/30/1995', '6/10/1999'),
(16, 5, '1991','1993'),
(17, 5, '2007', '2009'),
(18, 5, '1988', '1991'),
(19, 5, '2005', '2009'),
(21, 1, '1/9/1998', '2/12/1999'),
(22, 2,'1990', '1993'),
(23, 3, '2002', '2005')
INSERT INTO tblMemberPosition(MemberID, PositionID, BeginDate, EndDate)
VALUES(20, 4, '1998', '1999')


