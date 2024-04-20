-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.

-- DROP DATABASE ClubHub;
CREATE DATABASE ClubHub;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on ClubHub.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use ClubHub;

-- -----------------------------------------------------
-- Table `ClubHub`.`Club`
-- -----------------------------------------------------
CREATE TABLE Club (
    clubID VARCHAR(255) NOT NULL PRIMARY KEY,
    clubName VARCHAR(255) NOT NULL,
    instagramHandle VARCHAR(255),
    clubEmail VARCHAR(255) UNIQUE,
    complianceStatus VARCHAR(255)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`President`
-- -----------------------------------------------------
CREATE TABLE Club_President (
    email VARCHAR(255) UNIQUE PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(15),
    clubID VARCHAR(255),
    FOREIGN KEY (clubID) REFERENCES Club(clubID)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Faculty Advisor`
-- -----------------------------------------------------
CREATE TABLE Faculty (
    email VARCHAR(255) UNIQUE PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    clubID VARCHAR(255),
    FOREIGN KEY (clubID) REFERENCES Club(clubID)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`User Profile`
-- -----------------------------------------------------
CREATE TABLE User_Profile (
    userID VARCHAR(255) UNIQUE PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    position VARCHAR(255),
    graduationYear YEAR,
    interests VARCHAR(255),
    status VARCHAR(255),
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(15),
    age INT,
    major VARCHAR(255)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Members`
-- -----------------------------------------------------
CREATE TABLE Club_Members (
    email VARCHAR(255) UNIQUE PRIMARY KEY,
    memberID VARCHAR(255) NOT NULL,
    status VARCHAR(255),
    lastName VARCHAR(255) NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(15),
    position VARCHAR(255),
    clubID VARCHAR(255),
    FOREIGN KEY (email) REFERENCES User_Profile(email),
    FOREIGN KEY (clubID) REFERENCES Club(clubID)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Junction(Club Members and User Profile)`
-- -----------------------------------------------------
CREATE TABLE Club_Members_User_Profile (
    clubMemberID INT AUTO_INCREMENT PRIMARY KEY,
    clubMemberEmail VARCHAR(255),
    userProfileID VARCHAR(255),
    FOREIGN KEY (clubMemberEmail) REFERENCES Club_Members(email),
    FOREIGN KEY (userProfileID) REFERENCES User_Profile(userID)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Events`
-- -----------------------------------------------------
CREATE TABLE Events (
    eventID INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    time TIME,
    location VARCHAR(255),
    eventName VARCHAR(255) NOT NULL,
    clubID VARCHAR(255),
    presidentEmail VARCHAR(255),
    membersAttending INT,
    FOREIGN KEY (clubID) REFERENCES Club(clubID),
    FOREIGN KEY (presidentEmail) REFERENCES Club_President(email)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Event Schedule`
-- -----------------------------------------------------
CREATE TABLE Club_Event_Schedule (
    eventID INT,
    clubID VARCHAR(255),
    eventName VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    membersAttending INT,
    PRIMARY KEY (eventID),
    FOREIGN KEY (clubID) REFERENCES Club(clubID)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Budget`
-- -----------------------------------------------------
CREATE TABLE Budget (
    accountNumber VARCHAR(255) PRIMARY KEY,
    totalClubBudget DECIMAL(10,2),
    totalClubBudgetSpent DECIMAL(10,2),
    clubID VARCHAR(255),
    FOREIGN KEY (clubID) REFERENCES Club(clubID)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Donations`
-- -----------------------------------------------------
CREATE TABLE Donations (
    donationID INT AUTO_INCREMENT PRIMARY KEY,
    donorEmail VARCHAR(255),
    donationAmount DECIMAL(10,2),
    accountNumber VARCHAR(255),
    FOREIGN KEY (donorEmail) REFERENCES User_Profile(email),
    FOREIGN KEY (accountNumber) REFERENCES Budget(accountNumber)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Documents`
-- -----------------------------------------------------
CREATE TABLE Documents (
    documentID INT AUTO_INCREMENT PRIMARY KEY,
    documentTitle VARCHAR(255) NOT NULL,
    dateCreated DATE,
    dateLastUpdated DATE,
    presidentEmail VARCHAR(255),
    FOREIGN KEY (presidentEmail) REFERENCES Club_President(email)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`DocEmails`
-- -----------------------------------------------------
CREATE TABLE DocEmails (
    accessEmail VARCHAR(255) NOT NULL,
    documentID INT NOT NULL,
    PRIMARY KEY (accessEmail, documentID),
    FOREIGN KEY (documentID) REFERENCES Documents(documentID)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `ClubHub`.`Network Job Board`
-- -----------------------------------------------------
CREATE TABLE Club_Network_Job_Board (
    roleID INT AUTO_INCREMENT PRIMARY KEY,
    companyDescription TEXT,
    roleDescription TEXT,
    positionName VARCHAR(255) NOT NULL,
    companyName VARCHAR(255) NOT NULL,
    clubID VARCHAR(255),
    FOREIGN KEY (clubID) REFERENCES Club(clubID)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;




SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

USE ClubHub;


# ----- 60 Examples
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('galsobrook0@un.org', 'Marketing Assistant', 2023, 'archery', 'current_member', 'Gertie', 'Alsobrook', '209-223-8444', 20, 'Political Science', 1);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('asitford1@bbc.co.uk', 'Operator', 2024, 'pottery', 'alumni_member', 'Avril', 'Sitford', '356-296-1554', 30, 'Civil Engineering', 2);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('kiacobo2@sourceforge.net', 'Health Coach I', 2016, 'beekeeping', 'current_member', 'Katy', 'Iacobo', '739-370-3412', 23, 'Software Engineering', 3);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('cheard3@edublogs.org', 'Administrative Officer', 2026, 'dancing', 'current_member', 'Chrisse', 'Heard', '622-894-1141', 30, 'Materials Science', 4);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('kblainey4@mail.ru', 'Programmer Analyst I', 2022, 'surfing', 'current_member', 'Keslie', 'Blainey', '993-819-8282', 22, 'Chemistry', 5);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('llapidus5@spotify.com', 'Recruiting Manager', 2014, 'knitting', 'alumni_member', 'Lilyan', 'Lapidus', '734-671-1677', 31, 'Information Technology', 6);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('hpancoast6@bloglovin.com', 'VP Accounting', 2028, 'video gaming', 'alumni_member', 'Holly', 'Pancoast', '761-726-8922', 33, 'Electrical Engineering', 7);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('dbrouncker7@army.mil', 'Software Consultant', 2027, 'kayaking', 'alumni_member', 'Dermot', 'Brouncker', '485-363-5500', 20, 'Aerospace Engineering', 8);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('epeaden8@people.com.cn', 'Information Systems Manager', 2027, 'cycling', 'current_member', 'Ethelda', 'Peaden', '869-324-6030', 28, 'Finance', 9);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('mbaskeyfied9@miitbeian.gov.cn', 'Information Systems Manager', 2013, 'baking', 'alumni_member', 'Maurine', 'Baskeyfied', '737-680-0919', 26, 'Computer Science', 10);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('bfusta@chron.com', 'Office Assistant I', 2022, 'journaling', 'alumni_member', 'Byram', 'Fust', '743-804-4374', 26, 'Human Resources', 11);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('scarnilianb@xrea.com', 'Assistant Manager', 2018, 'video gaming', 'current_member', 'Stanislaus', 'Carnilian', '657-124-9285', 26, 'Biomedical Engineering', 12);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('gartheyc@friendfeed.com', 'Director of Sales', 2023, 'calligraphy', 'alumni_member', 'Gregoire', 'Arthey', '105-888-6923', 27, 'Genetics', 13);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('choggand@boston.com', 'Web Developer III', 2022, 'reading', 'current_member', 'Cory', 'Hoggan', '767-177-5047', 18, 'Economics', 14);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('mbere@google.com.br', 'Administrative Officer', 2023, 'cycling', 'alumni_member', 'Maren', 'Ber', '143-655-7515', 29, 'Accounting', 15);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('kguidellif@bizjournals.com', 'Geological Engineer', 2021, 'yoga', 'current_member', 'Kellsie', 'Guidelli', '163-749-6504', 18, 'Accounting', 16);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('pworshallg@blogs.com', 'Automation Specialist IV', 2028, 'cooking', 'alumni_member', 'Petrina', 'Worshall', '807-890-7218', 34, 'Statistics', 17);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('lcattersonh@tamu.edu', 'Web Developer II', 2024, 'reading', 'current_member', 'Lockwood', 'Catterson', '393-230-8946', 26, 'Statistics', 18);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('qhynami@chronoengine.com', 'Health Coach I', 2020, 'calligraphy', 'alumni_member', 'Quintana', 'Hynam', '454-480-6936', 30, 'Civil Engineering', 19);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('lhanningj@auda.org.au', 'Data Coordinator', 2028, 'calligraphy', 'current_member', 'Lorraine', 'Hanning', '170-242-1000', 34, 'Environmental Science', 20);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('gstellik@flickr.com', 'Food Chemist', 2021, 'archery', 'alumni_member', 'Godfry', 'Stelli', '333-265-6187', 27, 'Biology', 21);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('mwingattl@theatlantic.com', 'Speech Pathologist', 2023, 'hiking', 'current_member', 'Margi', 'Wingatt', '233-825-5472', 18, 'Political Science', 22);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('imenicom@devhub.com', 'Quality Control Specialist', 2028, 'drawing', 'current_member', 'Ilsa', 'Menico', '829-750-8196', 32, 'Materials Science', 23);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('csaywoodn@histats.com', 'Associate Professor', 2025, 'sewing', 'current_member', 'Clemmie', 'Saywood', '136-172-1311', 25, 'Environmental Science', 24);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('sgruczkao@vimeo.com', 'Safety Technician IV', 2017, 'playing musical instruments', 'current_member', 'Staffard', 'Gruczka', '456-598-5830', 19, 'Human Resources', 25);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('dteapep@photobucket.com', 'Registered Nurse', 2013, 'knitting', 'current_member', 'Doralin', 'Teape', '125-853-1619', 34, 'Computer Science', 26);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('bgaynsfordq@123-reg.co.uk', 'Legal Assistant', 2024, 'kayaking', 'alumni_member', 'Berke', 'Gaynsford', '574-471-9146', 20, 'Mathematics', 27);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('lpoultonr@nsw.gov.au', 'Geological Engineer', 2012, 'fishing', 'current_member', 'Leshia', 'Poulton', '171-584-5084', 29, 'Mechanical Engineering', 28);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('csayerss@psu.edu', 'GIS Technical Architect', 2023, 'hiking', 'current_member', 'Charlotta', 'Sayers', '911-737-7202', 18, 'Sociology', 29);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('tjobket@illinois.edu', 'Cost Accountant', 2017, 'model building', 'alumni_member', 'Tull', 'Jobke', '184-105-7639', 25, 'Environmental Science', 30);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('kspurrittu@pcworld.com', 'Developer IV', 2013, 'scuba diving', 'current_member', 'Kennedy', 'Spurritt', '731-141-6093', 32, 'Microbiology', 31);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('sousbiev@omniture.com', 'Systems Administrator I', 2023, 'cycling', 'alumni_member', 'Sigfrid', 'Ousbie', '552-388-1033', 30, 'Chemistry', 32);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('cmettsw@stumbleupon.com', 'VP Accounting', 2022, 'baking', 'alumni_member', 'Cristy', 'Metts', '400-439-6426', 28, 'Biomedical Engineering', 33);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('rjimmesx@uiuc.edu', 'Environmental Tech', 2021, 'dancing', 'current_member', 'Robinett', 'Jimmes', '762-638-6584', 24, 'Aerospace Engineering', 34);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('hflanneryy@netscape.com', 'Statistician II', 2015, 'knitting', 'current_member', 'Hagen', 'Flannery', '632-406-6398', 21, 'Economics', 35);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('upostiansz@dyndns.org', 'Budget/Accounting Analyst I', 2013, 'archery', 'alumni_member', 'Urbano', 'Postians', '288-251-6821', 33, 'Mechanical Engineering', 36);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('acarl10@nsw.gov.au', 'Recruiting Manager', 2023, 'kayaking', 'current_member', 'Alisa', 'Carl', '572-824-7839', 24, 'Human Resources', 37);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('fdenziloe11@tinypic.com', 'Physical Therapy Assistant', 2018, 'painting', 'current_member', 'Far', 'Denziloe', '996-475-8072', 30, 'Business Administration', 38);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('ferskine12@msn.com', 'VP Quality Control', 2025, 'chess', 'alumni_member', 'Felicle', 'Erskine', '995-883-1746', 31, 'Business Administration', 39);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('mmatussov13@stanford.edu', 'Senior Cost Accountant', 2019, 'surfing', 'current_member', 'Mark', 'Matussov', '866-409-2891', 18, 'Accounting', 40);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('vdougharty14@paypal.com', 'Project Manager', 2027, 'cycling', 'alumni_member', 'Valentina', 'Dougharty', '234-786-6388', 23, 'Materials Science', 41);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('syerlett15@drupal.org', 'Compensation Analyst', 2013, 'calligraphy', 'current_member', 'Sarita', 'Yerlett', '297-506-3000', 23, 'Business Administration', 42);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('gwadlow16@home.pl', 'Information Systems Manager', 2025, 'gardening', 'current_member', 'Georgina', 'Wadlow', '329-842-5576', 32, 'Software Engineering', 43);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('rsmalley17@seesaa.net', 'Operator', 2028, 'photography', 'current_member', 'Rice', 'Smalley', '141-916-7223', 25, 'Biochemistry', 44);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('iinfantino18@dot.gov', 'Nurse', 2025, 'surfing', 'alumni_member', 'Ives', 'Infantino', '215-965-4242', 24, 'Statistics', 45);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('kmancell19@etsy.com', 'Nurse', 2024, 'birdwatching', 'current_member', 'Katharina', 'Mancell', '662-840-5471', 25, 'Chemistry', 46);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('aborsi1a@oakley.com', 'GIS Technical Architect', 2028, 'scuba diving', 'alumni_member', 'Analiese', 'Borsi', '455-719-5740', 25, 'Computer Science', 47);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('hmussington1b@ted.com', 'Desktop Support Technician', 2018, 'journaling', 'alumni_member', 'Hildegarde', 'Mussington', '469-413-8003', 32, 'International Business', 48);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('jcaistor1c@opensource.org', 'Human Resources Assistant II', 2023, 'yoga', 'alumni_member', 'Jolie', 'Caistor', '606-755-8946', 30, 'Genetics', 49);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('eewbanck1d@walmart.com', 'VP Marketing', 2022, 'astronomy', 'alumni_member', 'Ericha', 'Ewbanck', '678-322-9335', 34, 'Microbiology', 50);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('amilner1e@goodreads.com', 'Systems Administrator IV', 2022, 'surfing', 'alumni_member', 'Angelico', 'Milner', '359-892-6301', 30, 'Human Resources', 51);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('eragborne1f@github.com', 'Physical Therapy Assistant', 2024, 'dancing', 'alumni_member', 'Erwin', 'Ragborne', '811-719-6752', 30, 'Microbiology', 52);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('hdossettor1g@4shared.com', 'VP Accounting', 2025, 'reading', 'alumni_member', 'Harald', 'Dossettor', '542-375-2630', 18, 'Biochemistry', 53);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('tkingsley1h@alibaba.com', 'Structural Engineer', 2028, 'birdwatching', 'current_member', 'Tito', 'Kingsley', '494-342-7596', 29, 'Genetics', 54);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('redward1i@opera.com', 'Director of Sales', 2024, 'woodworking', 'alumni_member', 'Remus', 'Edward', '961-330-7946', 27, 'Marketing', 55);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('mmenzies1j@nbcnews.com', 'Operator', 2024, 'fishing', 'current_member', 'Mildrid', 'Menzies', '919-680-1436', 19, 'Materials Science', 56);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('grobken1k@jalbum.net', 'Marketing Assistant', 2016, 'astronomy', 'alumni_member', 'Gratia', 'Robken', '962-709-6235', 24, 'Materials Science', 57);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('wmumby1l@yahoo.co.jp', 'Geological Engineer', 2026, 'knitting', 'current_member', 'Wilone', 'Mumby', '908-575-2743', 18, 'Mathematics', 58);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('pisard1m@dailymail.co.uk', 'Senior Sales Associate', 2023, 'reading', 'current_member', 'Pierce', 'Isard', '386-259-2915', 30, 'Statistics', 59);
insert into User_Profile (email, position, graduationYear, interests, status, firstName, lastName, phoneNumber, age, major, userID) values ('dhaliburton1n@eepurl.com', 'Structural Analysis Engineer', 2013, 'cooking', 'alumni_member', 'Dukey', 'Haliburton', '709-385-2356', 22, 'Civil Engineering', 60);

# ----- 60 Examples

insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Broadway Melody of 1936', 'sbiasini0', 'kreolfo0@zdnet.com', true, '1');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Hour of the Pig, The', 'adohrmann1', 'nragge1@prnewswire.com', false, '2');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Déjà Vu (Deja Vu)', 'aerni2', 'fmeeking2@cdc.gov', false, '3');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Miss Kicki', 'mantoniak3', 'tshirley3@nsw.gov.au', false, '4');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Romance on the High Seas', 'fheight4', 'hdeglanville4@whitehouse.gov', true, '5');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Life of Jesus, The (La vie de Jésus)', 'tlicari5', 'mdougharty5@simplemachines.org', true, '6');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Judge, The', 'gyockley6', 'mjakubiak6@ustream.tv', false, '7');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Dr. T and the Women', 'callbon7', 'rgiaomozzo7@list-manage.com', false, '8');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Puckoon', 'jjery8', 'dbellini8@exblog.jp', false, '9');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('''Neath the Arizona Skies', 'wbaldelli9', 'mskermer9@geocities.com', true, '10');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Waste Land', 'rsherela', 'lmaplestonea@joomla.org', false, '11');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Room for Romeo Brass, A', 'lfallab', 'cranyelldb@clickbank.net', false, '12');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Ella Lola, a la Trilby', 'jrobunc', 'dvanderbrugc@army.mil', false, '13');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Valley of the Bees (Údolí vcel)', 'abaylied', 'vcapozzid@webnode.com', true, '14');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Backfire', 'mchisnelle', 'vlembricke@huffingtonpost.com', false, '15');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Anarchist Cookbook, The', 'fwayf', 'tdudsonf@163.com', true, '16');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('To Kill a Mockingbird', 'nhiggonetg', 'hgristhwaiteg@booking.com', true, '17');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Tupac: Resurrection', 'fcardenosah', 'gsemirash@dailymail.co.uk', true, '18');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('The Count of Monte Cristo', 'sfiggsi', 'jstowei@vk.com', true, '19');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Fed Up', 'agollardj', 'dshilstonej@census.gov', true, '20');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Manhattan Project, The', 'mjankowskik', 'lfoardk@cbsnews.com', true, '21');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Night of the Living Dead', 'kjallinl', 'tdeppel@twitter.com', true, '22');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Hidalgo', 'jburbridgem', 'mwastellm@rambler.ru', false, '23');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Headquarters (Päämaja) ', 'dgreimn', 'dlovelacen@boston.com', false, '24');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Dance of Reality, The (Danza de la realidad, La)', 'kgreatlando', 'edoleso@google.es', false, '25');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Boys'' Night Out', 'bfarnsworthp', 'jseedsp@ocn.ne.jp', false, '26');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Blind Massage (Tui na)', 'jskateq', 'jlarkworthyq@tinyurl.com', false, '27');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Direct Contact', 'ypridier', 'vgarnseyr@1688.com', false, '28');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('The Linguists', 'awoodyers', 'mwickenss@twitpic.com', true, '29');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Nun''s Story, The', 'hantonnikovt', 'ibeadmant@homestead.com', false, '30');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Frozen Fever', 'sparkmanu', 'epullenu@omniture.com', false, '31');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Ice-Cold in Alex', 'tjurkiewiczv', 'dglashbyv@alibaba.com', true, '32');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Porky''s II: The Next Day', 'sortigerw', 'fcollabinew@mozilla.org', true, '33');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Shanghai', 'jgrimsteadx', 'drushsorthx@salon.com', true, '34');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Picking Up the Pieces', 'bcasettiy', 'fcriminy@blinklist.com', true, '35');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Lost Reels of Pancho Villa, The (Los rollos perdidos de Pancho Villa)', 'hblondellz', 'wslineyz@ftc.gov', false, '36');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Raise Your Voice', 'btennant10', 'dkupker10@patch.com', true, '37');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Dagon', 'tshepperd11', 'tblaschek11@jigsy.com', true, '38');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Love Affair', 'rdoodson12', 'adeabill12@shutterfly.com', false, '39');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('How I Got Into College', 'lstickel13', 'jhansel13@bbc.co.uk', true, '40');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Uninvited, The', 'crearden14', 'zourry14@ustream.tv', false, '41');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Rush Hour 2', 'bcammidge15', 'gkinman15@unicef.org', false, '42');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Eddie Izzard: Force Majeure Live', 'gguwer16', 'snannizzi16@uiuc.edu', false, '43');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Dispatch from Reuter''s, A', 'eclinkard17', 'aaspinwall17@globo.com', false, '44');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Gilded Lily, The', 'vendacott18', 'bdrain18@flavors.me', true, '45');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Inside Job', 'sreavell19', 'lorteau19@wikipedia.org', false, '46');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Banshee Chapter, The', 'orizzolo1a', 'taustins1a@time.com', false, '47');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Making a Killing: The Untold Story of Psychotropic Drugging', 'fselwyne1b', 'tdedomenico1b@mediafire.com', false, '48');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('NeverEnding Story II: The Next Chapter, The', 'bgoathrop1c', 'mmansfield1c@geocities.com', false, '49');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Crisis (Kris)', 'cveart1d', 'hmcrannell1d@tinypic.com', false, '50');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Newlyweds', 'akepe1e', 'vheinritz1e@4shared.com', false, '51');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Where East Is East', 'rkmiec1f', 'sbinder1f@netvibes.com', false, '52');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Limbo', 'odenisyuk1g', 'ghellikes1g@omniture.com', false, '53');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Eclisse, L'' (Eclipse)', 'crowesby1h', 'dcordeix1h@pen.io', false, '54');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Almighty Thor', 'ewestmancoat1i', 'asutterby1i@dailymotion.com', true, '55');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Taxidermia', 'glumsdall1j', 'lhardman1j@moonfruit.com', true, '56');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Hollywood Canteen', 'ebernaldez1k', 'lfursland1k@usgs.gov', true, '57');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Blackout', 'alardeur1l', 'doslar1l@mysql.com', false, '58');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Monster in the Closet', 'mcaherny1m', 'aurpeth1m@tripadvisor.com', true, '59');
insert into Club (clubName, instagramHandle, clubEmail, complianceStatus, clubID) values ('Matrix Revolutions, The', 'hurwin1n', 'dsynder1n@delicious.com', false, '60');


# ----- 60 Examples
insert into Faculty (firstName, lastName, clubID, email) values ('Leon', 'Dodgson', '1', 'ldodgson0@com.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Britte', 'Jimenez', '22', 'bjimenez1@google.ca');
insert into Faculty (firstName, lastName, clubID, email) values ('Meta', 'Heritege', '38', 'mheritege2@hhs.gov');
insert into Faculty (firstName, lastName, clubID, email) values ('Dukie', 'Deek', '3', 'ddeek3@usgs.gov');
insert into Faculty (firstName, lastName, clubID, email) values ('Kleon', 'Timothy', '10', 'ktimothy4@psu.edu');
insert into Faculty (firstName, lastName, clubID, email) values ('Corey', 'Hilary', '54', 'chilary5@google.co.uk');
insert into Faculty (firstName, lastName, clubID, email) values ('Idalia', 'Kilmurry', '55', 'ikilmurry6@state.tx.us');
insert into Faculty (firstName, lastName, clubID, email) values ('Maximilien', 'McGrail', '19', 'mmcgrail7@51.la');
insert into Faculty (firstName, lastName, clubID, email) values ('Siegfried', 'Dinnis', '5', 'sdinnis8@forbes.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Madelaine', 'Lackington', '14', 'mlackington9@deviantart.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Sybille', 'Glaysher', '32', 'sglayshera@tamu.edu');
insert into Faculty (firstName, lastName, clubID, email) values ('Kellsie', 'Grinvalds', '45', 'kgrinvaldsb@simplemachines.org');
insert into Faculty (firstName, lastName, clubID, email) values ('Reyna', 'Haymes', '40', 'rhaymesc@illinois.edu');
insert into Faculty (firstName, lastName, clubID, email) values ('Jilly', 'Northleigh', '53', 'jnorthleighd@etsy.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Bobbie', 'Hubery', '25', 'bhuberye@indiegogo.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Clint', 'Moehler', '43', 'cmoehlerf@squarespace.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Leontine', 'Planque', '56', 'lplanqueg@wp.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Shelley', 'Aberchirder', '50', 'saberchirderh@yolasite.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Bram', 'Duigenan', '21', 'bduigenani@house.gov');
insert into Faculty (firstName, lastName, clubID, email) values ('Maxwell', 'Witcomb', '44', 'mwitcombj@arizona.edu');
insert into Faculty (firstName, lastName, clubID, email) values ('Winne', 'Bridgewater', '59', 'wbridgewaterk@cyberchimps.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Annadiane', 'McKeney', '4', 'amckeneyl@mashable.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Vidovic', 'Frisch', '11', 'vfrischm@nih.gov');
insert into Faculty (firstName, lastName, clubID, email) values ('Rinaldo', 'Bernier', '28', 'rberniern@yelp.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Hewie', 'Colbertson', '18', 'hcolbertsono@amazon.co.jp');
insert into Faculty (firstName, lastName, clubID, email) values ('Rochelle', 'Hearley', '36', 'rhearleyp@1und1.de');
insert into Faculty (firstName, lastName, clubID, email) values ('Anthia', 'MacGibbon', '20', 'amacgibbonq@ibm.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Boote', 'Mauchlen', '47', 'bmauchlenr@ucsd.edu');
insert into Faculty (firstName, lastName, clubID, email) values ('Elvyn', 'Dmitrienko', '34', 'edmitrienkos@vinaora.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Nilson', 'Wildash', '58', 'nwildasht@last.fm');
insert into Faculty (firstName, lastName, clubID, email) values ('Dimitri', 'Matas', '31', 'dmatasu@paypal.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Clem', 'Cussen', '46', 'ccussenv@artisteer.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Bernardina', 'Ripley', '13', 'bripleyw@buzzfeed.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Betsy', 'Mabley', '16', 'bmableyx@multiply.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Kara-lynn', 'Josefsohn', '12', 'kjosefsohny@qq.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Malynda', 'Gallimore', '27', 'mgallimorez@wix.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Rory', 'Hugues', '23', 'rhugues10@sogou.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Jessamyn', 'De la Perrelle', '33', 'jdelaperrelle11@samsung.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Sky', 'Betonia', '39', 'sbetonia12@mail.ru');
insert into Faculty (firstName, lastName, clubID, email) values ('Joellyn', 'Blewmen', '49', 'jblewmen13@japanpost.jp');
insert into Faculty (firstName, lastName, clubID, email) values ('Toddie', 'Gowdy', '52', 'tgowdy14@gov.uk');
insert into Faculty (firstName, lastName, clubID, email) values ('Rosella', 'Manneville', '35', 'rmanneville15@skype.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Gusella', 'Dargue', '30', 'gdargue16@theatlantic.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Muffin', 'Chaters', '15', 'mchaters17@globo.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Cornell', 'Rumming', '29', 'crumming18@apple.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Catina', 'Ralls', '17', 'cralls19@github.io');
insert into Faculty (firstName, lastName, clubID, email) values ('Ferdy', 'Colbrun', '24', 'fcolbrun1a@huffingtonpost.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Ennis', 'Rubie', '60', 'erubie1b@elegantthemes.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Shanie', 'Lovart', '48', 'slovart1c@vkontakte.ru');
insert into Faculty (firstName, lastName, clubID, email) values ('Xymenes', 'Lowthian', '6', 'xlowthian1d@statcounter.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Laughton', 'Sive', '42', 'lsive1e@php.net');
insert into Faculty (firstName, lastName, clubID, email) values ('Mirabella', 'Flannigan', '8', 'mflannigan1f@addthis.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Javier', 'Messer', '57', 'jmesser1g@cdbaby.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Homere', 'Ffoulkes', '51', 'hffoulkes1h@webs.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Ronald', 'Fries', '7', 'rfries1i@paginegialle.it');
insert into Faculty (firstName, lastName, clubID, email) values ('Korie', 'Mil', '26', 'kmil1j@booking.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Skip', 'Yeiles', '41', 'syeiles1k@surveymonkey.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Sarina', 'Stellman', '9', 'sstellman1l@va.gov');
insert into Faculty (firstName, lastName, clubID, email) values ('Kaylil', 'Wickett', '37', 'kwickett1m@constantcontact.com');
insert into Faculty (firstName, lastName, clubID, email) values ('Leeanne', 'Offell', '2', 'loffell1n@mashable.com');

# ----- 60 Examples
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Maris', 'Lantaph', '951-231-0065', '11', 'mlantaph0@creativecommons.org');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Cornell', 'Wixey', '908-831-8842', '6', 'cwixey1@joomla.org');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Lauree', 'Tooth', '295-155-8957', '31', 'ltooth2@chron.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Winne', 'Glasebrook', '285-368-6699', '41', 'wglasebrook3@amazon.de');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Vernor', 'Cardoso', '550-894-7328', '8', 'vcardoso4@hexun.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Blinny', 'Petrescu', '533-569-0943', '19', 'bpetrescu5@123-reg.co.uk');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Hannis', 'Schwanden', '209-980-2908', '37', 'hschwanden6@illinois.edu');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Audrey', 'Martino', '622-978-5378', '5', 'amartino7@senate.gov');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Lambert', 'Shaefer', '723-108-5573', '60', 'lshaefer8@weibo.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Axel', 'Dent', '713-522-6470', '34', 'adent9@wsj.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Lenka', 'Formie', '489-533-5080', '49', 'lformiea@gmpg.org');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Jeth', 'Trunchion', '559-177-8268', '48', 'jtrunchionb@comsenz.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Porty', 'Jehu', '156-883-7555', '38', 'pjehuc@fema.gov');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Natala', 'Mogey', '350-342-3908', '26', 'nmogeyd@tinyurl.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Minette', 'Ralfe', '356-173-5059', '43', 'mralfee@naver.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Sher', 'Purple', '202-925-1206', '47', 'spurplef@biglobe.ne.jp');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Sibbie', 'Spier', '428-842-2473', '46', 'sspierg@cbc.ca');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Anson', 'Kirman', '151-381-9595', '52', 'akirmanh@youtube.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Avis', 'Nabarro', '316-790-7355', '7', 'anabarroi@mail.ru');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Kristine', 'Pottinger', '926-170-7701', '13', 'kpottingerj@ask.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Kimmi', 'Charman', '207-304-3930', '42', 'kcharmank@usgs.gov');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Jennette', 'Vowles', '453-479-9247', '55', 'jvowlesl@loc.gov');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Tawsha', 'Artingstall', '586-997-9467', '2', 'tartingstallm@vimeo.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Bud', 'Duckerin', '484-613-0590', '25', 'bduckerinn@tiny.cc');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Maryl', 'McLaverty', '256-464-5411', '58', 'mmclavertyo@1688.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Dukie', 'Akers', '518-546-4035', '32', 'dakersp@samsung.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Gretchen', 'Pimm', '138-163-0191', '16', 'gpimmq@webmd.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Rose', 'Pratley', '780-529-0204', '1', 'rpratleyr@qq.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Rica', 'Mackelworth', '515-175-9695', '20', 'rmackelworths@craigslist.org');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Betty', 'Woolward', '175-842-2836', '51', 'bwoolwardt@dion.ne.jp');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Barty', 'Balsdon', '545-985-5411', '57', 'bbalsdonu@epa.gov');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Tabor', 'Perks', '977-407-2106', '17', 'tperksv@mediafire.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Florentia', 'Boncore', '224-900-6144', '50', 'fboncorew@exblog.jp');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Glenine', 'Zoane', '551-690-3668', '39', 'gzoanex@webs.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Sammy', 'De Blasio', '638-625-9984', '36', 'sdeblasioy@prnewswire.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Barbaraanne', 'Lumbley', '312-579-7546', '10', 'blumbleyz@list-manage.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Angel', 'Tudbald', '617-658-9205', '35', 'atudbald10@nyu.edu');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Lacey', 'Kraft', '598-525-8640', '24', 'lkraft11@chron.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Fallon', 'Kuschel', '783-131-9013', '40', 'fkuschel12@moonfruit.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Eran', 'Jaume', '973-833-2538', '3', 'ejaume13@photobucket.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Rudd', 'Gullan', '235-735-6390', '12', 'rgullan14@sun.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Junina', 'Margetson', '866-266-8331', '28', 'jmargetson15@army.mil');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Benoite', 'Nortunen', '368-316-8166', '30', 'bnortunen16@globo.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Hanson', 'Bisset', '247-321-7908', '29', 'hbisset17@mediafire.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Stace', 'Sumsion', '229-209-8368', '33', 'ssumsion18@hatena.ne.jp');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Gipsy', 'Blaymires', '276-158-4600', '18', 'gblaymires19@issuu.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Tessy', 'Dybell', '173-533-5320', '21', 'tdybell1a@nih.gov');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Murray', 'Dencs', '567-642-8749', '14', 'mdencs1b@squarespace.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Arthur', 'Buttrum', '571-994-3311', '22', 'abuttrum1c@wp.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Kristy', 'Leeburn', '457-574-6946', '59', 'kleeburn1d@t-online.de');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Consuela', 'Walden', '370-191-9259', '45', 'cwalden1e@yahoo.co.jp');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Tybie', 'Libero', '904-755-3231', '53', 'tlibero1f@toplist.cz');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Gery', 'Treadgall', '733-874-0539', '15', 'gtreadgall1g@merriam-webster.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Berti', 'Soreau', '918-520-3297', '44', 'bsoreau1h@ask.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Hugibert', 'Flowitt', '766-707-0418', '23', 'hflowitt1i@globo.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Velma', 'Jailler', '224-448-7790', '9', 'vjailler1j@symantec.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Bernice', 'Lipsett', '345-106-7464', '27', 'blipsett1k@phpbb.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Prince', 'Bridgeman', '878-925-3146', '54', 'pbridgeman1l@netlog.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Kristin', 'Blaxton', '403-596-2873', '56', 'kblaxton1m@sbwire.com');
insert into Club_President (firstName, lastName, phoneNumber, clubID, email) values ('Judye', 'Rainsdon', '532-137-7765', '4', 'jrainsdon1n@networkadvertising.org');


# ----- 60 Examples
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9542.43, 5117.35, '35', 44988198);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9603.32, 7421.09, '59', 26791677);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9747.83, 1847.27, '14', 32335882);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9835.89, 5896.98, '19', 90204595);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9509.59, 2747.33, '51', 46521574);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9938.89, 7190.61, '16', 84568925);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9883.55, 2856.70, '5', 80486408);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9100.60, 5959.14, '50', 49380676);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9989.93, 4765.05, '1', 19383552);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9310.29, 3029.43, '60', 72340895);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9781.19, 6196.80, '28', 95067758);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9985.36, 6429.93, '49', 11802822);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9612.94, 4064.66, '29', 82382471);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9210.82, 107.99, '17', 38695279);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9173.32, 1906.18, '20', 69864288);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9819.65, 4838.79, '56', 44524216);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9713.63, 2446.57, '31', 85920624);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9398.99, 5136.60, '30', 45154295);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9319.46, 7617.49, '48', 30045037);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9658.12, 5887.44, '44', 37594736);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9128.26, 1808.93, '45', 46616638);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9417.72, 7285.26, '9', 59335758);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9292.70, 6655.34, '39', 50728380);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9312.10, 2259.77, '53', 40274236);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9987.17, 2428.90, '21', 28544814);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9700.27, 3382.31, '13', 42628944);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9702.75, 7181.24, '23', 45015343);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9945.44, 3902.36, '38', 87589369);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9964.96, 648.56, '18', 45367851);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9230.70, 4731.66, '47', 87613587);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9194.23, 3643.03, '7', 80254822);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9059.32, 108.35, '2', 66392613);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9669.38, 3934.08, '58', 71080554);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9915.22, 6718.26, '55', 39033669);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9021.16, 4229.16, '10', 93513128);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9138.39, 5452.95, '8', 48438294);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9267.84, 2042.23, '22', 20148350);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9736.74, 6789.12, '33', 17238537);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9573.04, 4155.45, '26', 57213558);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9926.72, 4772.83, '27', 60998300);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9517.76, 1397.46, '43', 86521076);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9694.29, 4739.42, '41', 10704015);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9610.89, 5033.60, '40', 21841767);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9829.32, 1013.56, '34', 98006007);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9965.63, 5437.94, '42', 38646167);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9744.58, 5604.06, '52', 38698788);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9997.05, 3037.20, '32', 77814596);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9393.48, 2171.80, '37', 40332699);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9736.57, 793.90, '46', 33785518);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9503.92, 1446.60, '6', 21049565);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9135.16, 7640.78, '57', 27865265);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9021.28, 2057.09, '25', 93666442);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9543.77, 7570.33, '12', 87437377);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9222.18, 1366.97, '3', 80538274);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9697.15, 7911.30, '4', 25894672);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9922.98, 5161.07, '11', 64779319);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9257.16, 6424.11, '15', 65624457);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9701.75, 2538.97, '36', 58356574);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9937.49, 5666.21, '54', 28839716);
insert into Budget (totalClubBudget, totalClubBudgetSpent, clubID, accountNumber) values (9123.18, 3512.54, '24', 39616206);


# ----- 60 Examples
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (1, 'current_member', 'O''Neill', 'Rayshell', '101-940-1112', 'Developer II', '9', 'galsobrook0@un.org');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (2, 'alumni_member', 'Pengilly', 'Riki', '970-939-9005', 'Graphic Designer', '22', 'asitford1@bbc.co.uk');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (3, 'current_member', 'Trenchard', 'Gardy', '296-230-9586', 'Budget/Accounting Analyst I', '1', 'kiacobo2@sourceforge.net');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (4, 'current_member', 'Antecki', 'Britteny', '557-465-4986', 'Civil Engineer', '15', 'cheard3@edublogs.org');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (5, 'alumni_member', 'Mariyushkin', 'Nolan', '423-307-7364', 'Payment Adjustment Coordinator', '54', 'kblainey4@mail.ru');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (6, 'alumni_member', 'Gentle', 'Meredeth', '525-439-8563', 'Product Engineer', '13', 'llapidus5@spotify.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (7, 'current_member', 'McCromley', 'Myra', '824-481-8165', 'Junior Executive', '51', 'hpancoast6@bloglovin.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (8, 'current_member', 'Breen', 'Roman', '539-618-4597', 'Product Engineer', '6', 'dbrouncker7@army.mil');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (9, 'alumni_member', 'Elloy', 'Konrad', '776-285-2010', 'Research Nurse', '42', 'epeaden8@people.com.cn');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (10, 'alumni_member', 'Nissle', 'Felita', '919-150-2213', 'Social Worker', '38', 'mbaskeyfied9@miitbeian.gov.cn');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (11, 'alumni_member', 'Oldroyde', 'Dari', '559-637-0246', 'Senior Quality Engineer', '48', 'bfusta@chron.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (12, 'current_member', 'Begin', 'Karl', '414-501-3573', 'Database Administrator IV', '28', 'scarnilianb@xrea.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (13, 'current_member', 'Rolfs', 'Matias', '704-717-0816', 'Executive Secretary', '59', 'gartheyc@friendfeed.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (14, 'alumni_member', 'Clarabut', 'Darrell', '122-534-8450', 'Budget/Accounting Analyst IV', '27', 'choggand@boston.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (15, 'alumni_member', 'Ellcome', 'Jillana', '410-299-4188', 'Research Nurse', '7', 'mbere@google.com.br');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (16, 'alumni_member', 'Dominighi', 'Vernon', '414-354-0981', 'Health Coach III', '11', 'kguidellif@bizjournals.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (17, 'alumni_member', 'O''Grada', 'Vale', '562-769-0112', 'Automation Specialist I', '12', 'pworshallg@blogs.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (18, 'alumni_member', 'Newsham', 'Maurise', '355-531-9226', 'Product Engineer', '30', 'lcattersonh@tamu.edu');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (19, 'current_member', 'Rowbottom', 'Gianina', '489-612-5644', 'Product Engineer', '35', 'qhynami@chronoengine.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (20, 'alumni_member', 'Dray', 'Cherey', '676-159-0158', 'Legal Assistant', '43', 'lhanningj@auda.org.au');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (21, 'alumni_member', 'Gearing', 'Isa', '890-102-6991', 'Senior Editor', '8', 'gstellik@flickr.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (22, 'alumni_member', 'Edwinson', 'Deni', '953-141-0676', 'Developer III', '18', 'mwingattl@theatlantic.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (23, 'current_member', 'Wheelan', 'Paolina', '589-658-7409', 'Analyst Programmer', '4', 'imenicom@devhub.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (24, 'current_member', 'Ciepluch', 'Free', '256-457-5224', 'Electrical Engineer', '50', 'csaywoodn@histats.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (25, 'current_member', 'Woodley', 'Richmond', '367-245-6595', 'Community Outreach Specialist', '60', 'sgruczkao@vimeo.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (26, 'alumni_member', 'Kembley', 'Marvin', '610-720-7930', 'Office Assistant I', '23', 'dteapep@photobucket.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (27, 'alumni_member', 'Jockle', 'Daphna', '855-247-2793', 'Actuary', '45', 'bgaynsfordq@123-reg.co.uk');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (28, 'current_member', 'Andreutti', 'Rosalie', '971-816-9515', 'Programmer I', '56', 'lpoultonr@nsw.gov.au');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (29, 'alumni_member', 'Telezhkin', 'Beaufort', '592-333-8902', 'Information Systems Manager', '55', 'csayerss@psu.edu');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (30, 'alumni_member', 'Nucciotti', 'Corinna', '679-409-2383', 'Payment Adjustment Coordinator', '40', 'tjobket@illinois.edu');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (31, 'alumni_member', 'Marriot', 'Jehu', '999-794-0872', 'Chemical Engineer', '3', 'kspurrittu@pcworld.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (32, 'current_member', 'Lightbourn', 'Allin', '235-445-0671', 'Community Outreach Specialist', '20', 'sousbiev@omniture.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (33, 'current_member', 'Dict', 'Leonie', '263-765-1865', 'Data Coordinator', '39', 'cmettsw@stumbleupon.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (34, 'current_member', 'Amoore', 'Stacee', '940-172-6835', 'Help Desk Technician', '32', 'rjimmesx@uiuc.edu');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (35, 'current_member', 'Morten', 'Muffin', '365-145-2679', 'VP Sales', '41', 'hflanneryy@netscape.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (36, 'current_member', 'Goodridge', 'Madelina', '724-491-2475', 'Pharmacist', '21', 'upostiansz@dyndns.org');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (37, 'current_member', 'Quested', 'Nanon', '173-737-7669', 'Health Coach I', '29', 'acarl10@nsw.gov.au');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (38, 'alumni_member', 'Livesey', 'Astrid', '310-784-2039', 'Geologist III', '52', 'fdenziloe11@tinypic.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (39, 'current_member', 'McBrearty', 'Jordan', '976-995-7061', 'Statistician IV', '34', 'ferskine12@msn.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (40, 'current_member', 'Karpushkin', 'Natalee', '584-620-6046', 'Assistant Manager', '49', 'mmatussov13@stanford.edu');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (41, 'current_member', 'Leveritt', 'Adolpho', '927-746-2436', 'Senior Editor', '31', 'vdougharty14@paypal.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (42, 'alumni_member', 'Dubock', 'Chery', '953-772-5676', 'Occupational Therapist', '37', 'syerlett15@drupal.org');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (43, 'alumni_member', 'Orcott', 'Frasier', '591-430-4373', 'Automation Specialist II', '24', 'gwadlow16@home.pl');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (44, 'alumni_member', 'Pasticznyk', 'Lydie', '414-343-1143', 'Associate Professor', '10', 'rsmalley17@seesaa.net');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (45, 'alumni_member', 'Clapham', 'Briney', '536-806-4050', 'Help Desk Operator', '2', 'iinfantino18@dot.gov');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (46, 'current_member', 'Atkyns', 'Lyssa', '594-626-2506', 'Safety Technician I', '44', 'kmancell19@etsy.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (47, 'alumni_member', 'Santus', 'Ellis', '252-881-1090', 'Occupational Therapist', '19', 'aborsi1a@oakley.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (48, 'alumni_member', 'Endon', 'Tove', '789-601-8741', 'Software Consultant', '17', 'hmussington1b@ted.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (49, 'current_member', 'Corney', 'Idelle', '441-168-8569', 'Social Worker', '58', 'jcaistor1c@opensource.org');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (50, 'current_member', 'Agron', 'Kessia', '229-391-5967', 'Electrical Engineer', '36', 'eewbanck1d@walmart.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (51, 'alumni_member', 'O'' Bee', 'Gun', '502-653-1954', 'Marketing Assistant', '26', 'amilner1e@goodreads.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (52, 'alumni_member', 'Clive', 'Bernadine', '602-912-2847', 'Product Engineer', '57', 'ragborne1f@github.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (53, 'current_member', 'Falla', 'Bent', '390-674-0811', 'Safety Technician II', '25', 'hdossettor1g@4shared.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (54, 'alumni_member', 'Honniebal', 'Ximenes', '973-829-9243', 'Environmental Tech', '46', 'tkingsley1h@alibaba.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (55, 'current_member', 'Keoghane', 'Madelina', '927-753-4764', 'Editor', '47', 'redward1i@opera.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (56, 'current_member', 'Cowley', 'Elston', '857-832-6690', 'Media Manager IV', '16', 'mmenzies1j@nbcnews.com');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (57, 'alumni_member', 'Pedrick', 'Patrica', '315-682-1271', 'Executive Secretary', '5', 'grobken1k@jalbum.net');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (58, 'alumni_member', 'Vanelli', 'Ollie', '745-223-3680', 'Account Executive', '53', 'wmumby1l@yahoo.co.jp');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (59, 'alumni_member', 'Bruff', 'Alwin', '961-238-0929', 'Social Worker', '14', 'pisard1m@dailymail.co.uk');
insert into Club_Members (memberID, status, lastName, firstName, phoneNumber, position, clubID, email) values (60, 'alumni_member', 'Griffitt', 'Jackie', '518-913-4205', 'Cost Accountant', '33', 'dhaliburton1n@eepurl.com');


# ----- 60 Examples
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('galsobrook0@un.org', 902704.71, 44988198, 1);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('asitford1@bbc.co.uk', 581718.09, 26791677, 2);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('kiacobo2@sourceforge.net', 3462766.50, 32335882, 3);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('cheard3@edublogs.org', 1245123.62, 90204595, 4);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('kblainey4@mail.ru', 8113123.26, 46521574, 5);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('llapidus5@spotify.com', 4258615.17, 84568925, 6);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('hpancoast6@bloglovin.com', 8192599.94, 80486408, 7);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('dbrouncker7@army.mil', 9435110.77, 49380676, 8);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('epeaden8@people.com.cn', 1199133.21, 19383552, 9);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('mbaskeyfied9@miitbeian.gov.cn', 1071015.31, 72340895, 10);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('bfusta@chron.com', 9603523.34, 95067758, 11);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('scarnilianb@xrea.com', 2809719.57, 11802822, 12);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('gartheyc@friendfeed.com', 6372065.94, 82382471, 13);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('choggand@boston.com', 7264107.70, 38695279, 14);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('mbere@google.com.br', 5013267.54, 69864288, 15);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('kguidellif@bizjournals.com', 7390997.20, 44524216, 16);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('pworshallg@blogs.com', 6668846.03, 85920624, 17);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('lcattersonh@tamu.edu', 8609541.73, 45154295, 18);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('qhynami@chronoengine.com', 2614249.84, 30045037, 19);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('lhanningj@auda.org.au', 468262.66, 37594736, 20);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('gstellik@flickr.com', 3101303.56, 46616638, 21);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('mwingattl@theatlantic.com', 4782143.13, 59335758, 22);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('imenicom@devhub.com', 8836480.67, 50728380, 23);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('csaywoodn@histats.com', 7845875.23, 40274236, 24);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('sgruczkao@vimeo.com', 8164124.56, 28544814, 25);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('dteapep@photobucket.com', 2580023.13, 42628944, 26);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('bgaynsfordq@123-reg.co.uk', 3164063.71, 45015343, 27);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('lpoultonr@nsw.gov.au', 6712556.89, 87589369, 28);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('csayerss@psu.edu', 1702185.55, 45367851, 29);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('tjobket@illinois.edu', 3068481.61, 87613587, 30);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('kspurrittu@pcworld.com', 1429956.78, 80254822, 31);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('sousbiev@omniture.com', 1753257.24, 66392613, 32);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('cmettsw@stumbleupon.com', 7061348.28, 71080554, 33);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('rjimmesx@uiuc.edu', 8001911.44, 39033669, 34);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('hflanneryy@netscape.com', 8523864.77, 93513128, 35);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('upostiansz@dyndns.org', 8452204.58, 48438294, 36);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('acarl10@nsw.gov.au', 8495857.82, 20148350, 37);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('fdenziloe11@tinypic.com', 3475592.00, 17238537, 38);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('ferskine12@msn.com', 17358.39, 57213558, 39);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('mmatussov13@stanford.edu', 6393102.23, 60998300, 40);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('vdougharty14@paypal.com', 9535361.76, 86521076, 41);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('syerlett15@drupal.org', 729956.52, 10704015, 42);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('gwadlow16@home.pl', 2142305.59, 21841767, 43);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('rsmalley17@seesaa.net', 4132499.16, 98006007, 44);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('iinfantino18@dot.gov', 5550579.68, 38646167, 45);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('kmancell19@etsy.com', 8423234.90, 38698788, 46);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('aborsi1a@oakley.com', 1816809.14, 77814596, 47);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('hmussington1b@ted.com', 595106.99, 40332699, 48);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('jcaistor1c@opensource.org', 949401.61, 33785518, 49);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('eewbanck1d@walmart.com', 5349549.60, 21049565, 50);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('amilner1e@goodreads.com', 6692310.74, 27865265, 51);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('ragborne1f@github.com', 7155773.50, 93666442, 52);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('hdossettor1g@4shared.com', 3187515.86, 87437377, 53);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('tkingsley1h@alibaba.com', 7597224.28, 80538274, 54);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('redward1i@opera.com', 9521173.42, 25894672, 55);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('mmenzies1j@nbcnews.com', 5791736.50, 64779319, 56);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('grobken1k@jalbum.net', 6926666.83, 65624457, 57);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('wmumby1l@yahoo.co.jp', 5456224.91, 58356574, 58);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('pisard1m@dailymail.co.uk', 2386337.95, 28839716, 59);
insert into Donations (donorEmail, donationAmount, accountNumber, donationID) values ('dhaliburton1n@eepurl.com', 5247325.30, 39616206, 60);



# ----- 60 Examples
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('3', 'Sun Don''t Shine', '2024-03-05', '22:02:00', 'Baláo', 9195, 1);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('17', 'Blue Valentine', '2024-01-25', '21:26:00', 'Xiangzhu', 2462, 2);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('48', 'Rough Riders', '2023-10-28', '15:41:00', 'Krujë', 698, 3);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('14', 'Married to the Mob', '2023-07-27', '14:00:00', 'Jämsänkoski', 2734, 4);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('18', 'Superclásico', '2023-06-26', '10:42:00', 'Chaupimarca', 7022, 5);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('50', 'Low Down, The', '2023-05-24', '11:52:00', 'Sindangsuka', 2188, 6);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('33', 'Grapes of Death, The (Raisins de la mort, Les)', '2023-12-08', '17:56:00', 'Baddomalhi', 7610, 7);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('53', 'Snow Queen', '2023-05-18', '03:54:00', 'Luozhuang', 5071, 8);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('22', 'Luther', '2023-08-13', '22:03:00', 'Tokyo', 1039, 9);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('9', 'Chuck Norris vs Communism', '2024-01-06', '07:38:00', 'Mushu', 3734, 10);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('24', 'Devil''s Knot', '2024-03-03', '11:02:00', 'Vale de Mendiz', 6664, 11);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('57', 'Unrated II: Scary as Hell', '2023-06-11', '15:10:00', 'Kobleve', 9423, 12);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('30', 'Alien Abduction', '2023-08-25', '21:41:00', 'Syktyvkar', 2956, 13);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('45', 'Kismet', '2023-12-14', '09:13:00', 'Dębno', 7792, 14);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('55', 'Prisoner of Zenda, The', '2024-01-05', '01:40:00', 'Dąbrowa', 2785, 15);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('40', 'Singin'' in the Rain', '2023-12-02', '20:38:00', 'Takāb', 7228, 16);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('2', 'Sea Wolves, The', '2023-09-10', '16:43:00', 'Maicao', 3963, 17);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('7', 'Small Cuts (Petites coupures)', '2023-10-06', '19:00:00', 'Sinŭiju', 3595, 18);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('16', 'Clear History', '2023-09-01', '00:48:00', 'Ribeiro', 8910, 19);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('37', 'Cloverfield', '2023-11-18', '01:10:00', 'Nonghe', 1246, 20);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('15', 'Uwasa No Onna (The Woman in the Rumor) (Her Mother''s Profession)', '2023-05-20', '14:12:00', 'Peña', 1986, 21);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('10', 'Foodfight!', '2023-05-26', '05:46:00', 'Donskoy', 3664, 22);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('51', 'Alien Escape', '2023-09-24', '11:44:00', 'Žirovnica', 3116, 23);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('26', 'From Here to Eternity', '2024-02-07', '16:21:00', 'Xiaqiao', 9702, 24);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('58', 'Jack the Giant Killer', '2023-12-19', '06:28:00', 'Moguqi', 3542, 25);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('27', 'Miss Castaway and the Island Girls', '2023-08-05', '19:51:00', 'Zhifang', 2403, 26);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('29', 'Speed & Angels', '2024-03-14', '05:24:00', 'Perštejn', 569, 27);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('49', 'Sophie Scholl: The Final Days (Sophie Scholl - Die letzten Tage)', '2023-06-29', '18:07:00', 'Cannes', 6012, 28);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('42', 'Italian Job, The', '2024-02-16', '18:03:00', 'Dayeuhluhur', 495, 29);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('1', 'At Land', '2024-02-02', '00:16:00', 'Masḩah', 3884, 30);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('19', 'Men in Black (a.k.a. MIB)', '2023-04-24', '19:09:00', 'Chaplygin', 2334, 31);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('23', 'Heirloom, The (Zhai Ban)', '2024-04-01', '11:56:00', 'Basel', 1110, 32);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('39', 'Very Ordinary Couple (Yeonaeui Wondo)', '2023-06-02', '09:27:00', 'Itamaraju', 4718, 33);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('43', 'Romance in Manhattan', '2024-02-17', '08:01:00', 'Villa Consuelo', 2934, 34);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('11', 'Birdman of Alcatraz', '2023-06-07', '01:44:00', 'Likiep', 3110, 35);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('36', 'Ran', '2024-03-18', '18:51:00', 'Arāk', 8774, 36);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('21', 'Single White Female 2: The Psycho', '2024-01-15', '00:45:00', 'Sunzhen', 1467, 37);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('4', 'Truth About Charlie, The', '2023-09-04', '07:53:00', 'Ibung', 2624, 38);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('6', 'Bikes vs Cars', '2023-07-12', '10:45:00', 'Jobabo', 2977, 39);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('34', 'Sailor of the King', '2023-05-15', '16:42:00', 'Ning’an', 5665, 40);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('20', 'Pleasure of Being Robbed, The', '2023-12-12', '06:41:00', 'Jiexiu', 789, 41);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('56', 'The Do-Deca-Pentathlon', '2024-02-17', '07:22:00', 'Cristalina', 244, 42);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('52', 'Footloose', '2023-05-19', '09:27:00', 'Limoges', 1384, 43);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('5', 'Dazed and Confused', '2023-10-27', '00:08:00', 'Roxas', 6178, 44);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('54', 'On the Silver Globe (Na srebrnym globie)', '2024-03-27', '15:50:00', 'Yongdong', 4912, 45);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('46', 'Suspiria', '2023-10-16', '00:03:00', 'Sliema', 2036, 46);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('47', 'Return to Homs, The', '2024-03-11', '19:28:00', 'Gunziying', 5938, 47);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('28', 'Only When I Laugh', '2023-07-13', '22:43:00', 'Karangbayat', 2577, 48);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('32', 'Once Upon a Time in the Midlands', '2023-04-18', '01:55:00', 'Hang Dong', 4843, 49);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('44', 'Dinner, The (Cena, La)', '2024-02-16', '14:10:00', 'Longonjo', 8760, 50);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('31', 'One Nine Nine Four', '2024-04-11', '06:40:00', 'Tibro', 784, 51);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('60', 'Soldier Blue', '2024-02-23', '00:35:00', 'Yucun', 4995, 52);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('35', 'Highwaymen', '2024-03-23', '14:58:00', 'Balboa', 702, 53);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('59', 'Bow, The (Hwal)', '2024-02-05', '00:46:00', 'Lucerna', 4275, 54);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('8', 'Would You Rather', '2024-02-09', '15:31:00', 'North Little Rock', 9397, 55);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('38', 'Two Men Went to War', '2023-11-29', '14:21:00', 'Santiago', 644, 56);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('12', 'King and the Mockingbird, The (Le roi et l''oiseau)', '2023-06-19', '08:31:00', 'Brunflo', 8850, 57);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('41', 'Life is a Miracle (Zivot je cudo)', '2023-11-24', '22:09:00', 'Sudimara', 2114, 58);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('13', 'Falling Angels', '2023-06-18', '13:11:00', 'Tuanchengshan', 4923, 59);
insert into Club_Event_Schedule (clubID, eventName, date, time, location, membersAttending, eventID) values ('25', 'Zulu', '2024-01-02', '23:06:00', 'Cai Doi Vam', 3977, 60);

# ----- 60 Examples
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-05-02', '20:44:00', 'Zhanping', 'Le Mans', '34', 'htorry0@slideshare.net', 6616, 1);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-07-26', '23:06:00', 'Nart', 'Common Thread, A (a.k.a. Sequins) (Brodeuses)', '29', 'pbrimmacombe1@stanford.edu', 6881, 2);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-09-19', '14:58:00', 'Catanauan', 'Wild Thornberrys Movie, The', '29', 'hgalbraith2@wsj.com', 8098, 3);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-08-10', '00:45:00', 'Dumaguil', 'Protector (Protektor)', '60', 'lbraiden3@geocities.com', 9540, 4);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-01-24', '07:42:00', 'Saraburi', 'WW III: World War III (Der 3. Weltkrieg)', '2', 'eprose4@theguardian.com', 9110, 5);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-05-28', '07:01:00', 'Yanwang', 'Carolina', '27', 'kfranscioni5@noaa.gov', 3503, 6);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-09-06', '05:05:00', 'Culeng', 'Sea Inside, The (Mar adentro)', '34', 'aranscombe6@last.fm', 9021, 7);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-12-15', '15:09:00', 'Troitsk', 'Weekend at Bernie''s II', '6', 'maskham7@zimbio.com', 1088, 8);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-08-15', '18:10:00', 'Malusay', 'Agent Vinod', '30', 'rfrere8@odnoklassniki.ru', 792, 9);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-07-19', '13:42:00', 'Gotputuk', 'River Queen', '24', 'ddavys9@hostgator.com', 4888, 10);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-10-11', '03:35:00', 'Kalpin', 'Fury', '6', 'ccoultassa@is.gd', 6724, 11);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-02-01', '17:45:00', 'Cercal', 'The Casino Murder Case', '14', 'dhextb@vkontakte.ru', 8871, 12);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-12-06', '02:30:00', 'Carpentras', 'Appleseed (Appurushîdo)', '29', 'rjiroutkac@narod.ru', 1989, 13);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-10-17', '03:46:00', 'Krasnoye', 'Blind (Beul-la-in-deu)', '5', 'lmeneard@dazonaws.com', 430, 14);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-07-23', '14:50:00', 'Strabychovo', 'Camilla', '34', 'sstockere@google.com', 3318, 15);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-02-06', '05:35:00', 'Maebashi-shi', 'New Tale of Zatoichi (Shin Zatôichi monogatari) (Zatôichi 3)', '42', 'dpeatmanf@answers.com', 4013, 16);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-11-24', '22:16:00', 'Dujiajing', 'My Louisiana Sky', '14', 'bdanieliang@sitemeter.com', 3707, 17);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-08-04', '20:58:00', 'Siguiri', 'The Salt of the Earth', '20', 'cfeedomeh@yale.edu', 9460, 18);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-06-14', '18:42:00', 'Sahagún', 'British Sounds', '48', 'ekiggeli@irs.gov', 8227, 19);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-10-04', '13:31:00', 'Kotido', 'Point Men, The', '56', 'bboyatj@hugedomains.com', 3337, 20);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-03-09', '08:04:00', 'Bosaso', 'Momo', '39', 'drillattk@yale.edu', 3789, 21);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-03-18', '22:20:00', 'Stockholm', '50 Children: The Rescue Mission of Mr. And Mrs. Kraus', '59', 'zwasbeyl@bandcamp.com', 6202, 22);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-07-01', '21:57:00', 'Kubang', 'St. Trinian''s', '2', 'jmansellm@businessinsider.com', 2064, 23);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-02-24', '11:51:00', 'Jūrmala', 'Harriet the Spy', '40', 'olayen@sciencedirect.com', 3993, 24);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-12-06', '03:46:00', 'Huogezhuang', 'Tarzan and His Mate', '17', 'rcomero@newsvine.com', 1430, 25);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-02-11', '01:22:00', 'Xiangtan', 'Miss Farkku-Suomi', '57', 'lwignallp@state.gov', 2134, 26);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-12-30', '13:06:00', 'Heřmanův Městec', 'History of the Eagles', '24', 'ableesingq@nih.gov', 9289, 27);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-10-12', '09:25:00', 'Shangyu', 'Titicut Follies', '8', 'dclutterhamr@trellian.com', 3957, 28);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-07-09', '05:27:00', 'Larreynaga', 'You Only Live Once', '59', 'uhamblys@addtoany.com', 6592, 29);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-02-01', '19:57:00', 'Lila', 'Phantom of the Opera, The', '9', 'bcorderot@yale.edu', 5875, 30);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-06-26', '15:15:00', 'Tanjay', 'Who Framed Roger Rabbit?', '39', 'snucatoru@economist.com', 5878, 31);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-03-24', '12:15:00', 'Kansas City', 'Kagi (Odd Obsession)', '16', 'amatteiniv@slate.com', 6166, 32);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-10-22', '21:55:00', 'Adani', 'Bleeder', '1', 'fblakeboroughw@mail.ru', 7809, 33);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-09-17', '21:39:00', 'Simunul', 'Charlie Chan on Broadway', '30', 'fcureex@yellowbook.com', 1529, 34);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-10-28', '21:14:00', 'Kulykiv', 'Transit', '15', 'acominoy@yale.edu', 3647, 35);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-03-16', '23:54:00', 'Suicheng', 'Christmas Comes but Once a Year', '17', 'ikylez@163.com', 871, 36);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-02-06', '05:48:00', 'Baisha', 'Skeleton Crew', '34', 'aravenscroft10@ted.com', 370, 37);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-01-18', '02:26:00', 'Dajie', 'Taking Woodstock', '9', 'acatcheside11@gov.uk', 7534, 38);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-09-25', '15:46:00', 'Cilegi', 'Girl on a Motorcycle, The', '37', 'cfenton12@sbwire.com', 7262, 39);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-09-13', '23:21:00', 'Eira da Pedra', 'Unknown Pleasures (Ren xiao yao)', '48', 'mnorwell13@umich.edu', 331, 40);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-08-31', '09:18:00', 'Seattle', 'Hunted City', '18', 'cdate14@google.com.br', 6999, 41);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-10-04', '12:52:00', 'Duncans', 'Night of the Demons', '44', 'pshoebottom15@state.tx.us', 1114, 42);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-04-05', '15:29:00', 'Söderhamn', 'Forest (Rengeteg)', '56', 'bmcgeown16@reference.com', 9578, 43);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-08-04', '01:45:00', 'Baler Baleagung', 'Edward II', '46', 'mmongin17@craigslist.org', 2445, 44);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-04-21', '09:12:00', 'Tsiroanomandidy', 'Triangle (Tie saam gok)', '36', 'awinsom18@virginia.edu', 5886, 45);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-10-14', '10:16:00', 'Kaczory', 'Old School', '49', 'rmacgorman19@gravatar.com', 256, 46);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-04-10', '13:26:00', 'Tabio', 'Do We Really Need the Moon?', '57', 'scrowcombe1a@google.es', 4676, 47);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-03-06', '17:24:00', 'Abonnema', 'Make Them Die Slowly (Cannibal Ferox)', '27', 'aharfoot1b@4shared.com', 1971, 48);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2023-11-27', '15:34:00', 'Peso da Régua', 'Mickey', '4', 'mwinsor1c@ted.com', 1310, 49);
insert into Events (date, time, location, eventName, clubID, presidentEmail, membersAttending, eventID) values ('2024-04-03', '07:56:00', 'Padang', 'Bad Guy (Nabbeun namja)', '57', 'shue1d@alexa.com', 3353, 50);

# ----- 60 Examples
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Wes Craven''s New Nightmare (Nightmare on Elm Street Part 7: Freddy''s Finale, A)', '2024-03-31', '2024-03-02', 'htorry0@slideshare.net', 1);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Fires Were Started', '2023-11-29', '2023-08-21', 'pbrimmacombe1@stanford.edu', 2);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('I Saw the Sun (Günesi gördüm)', '2023-07-07', '2023-06-08', 'hgalbraith2@wsj.com', 3);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Without a Paddle: Nature''s Calling', '2024-01-22', '2024-03-13', 'lbraiden3@geocities.com', 4);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Unprecedented: The 2000 Presidential Election', '2023-08-23', '2024-04-15', 'eprose4@theguardian.com', 5);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Possible Loves (Amores Possíveis)', '2023-07-19', '2024-04-13', 'kfranscioni5@noaa.gov', 6);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Possible Worlds', '2023-11-02', '2024-02-29', 'aranscombe6@last.fm', 7);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Grass: A Nation''s Battle for Life', '2024-03-29', '2023-06-25', 'maskham7@zimbio.com', 8);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Card Subject To Change', '2023-04-23', '2023-12-01', 'rfrere8@odnoklassniki.ru', 9);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Devils, The', '2023-06-09', '2023-06-19', 'ddavys9@hostgator.com', 10);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Dangerous Liaisons', '2024-04-09', '2023-11-25', 'ccoultassa@is.gd', 11);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Dangerous Minds', '2023-11-13', '2023-07-31', 'dhextb@vkontakte.ru', 12);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Big Empty, The', '2024-02-08', '2023-12-19', 'rjiroutkac@narod.ru', 13);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Revolutionary Road', '2023-07-10', '2024-04-11', 'lmeneard@danny.ai', 14);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Enemies of Reason, The', '2023-10-27', '2023-11-27', 'sstockere@google.com', 15);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Hello, Friend', '2024-04-06', '2023-07-20', 'dpeatmanf@answers.com', 16);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Stroszek', '2024-02-20', '2024-01-26', 'bdanieliang@sitemeter.com', 17);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Paper Soldier (Bumazhnyy soldat)', '2023-09-07', '2023-10-22', 'cfeedomeh@yale.edu', 18);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Theremin: An Electronic Odyssey', '2023-11-17', '2023-07-02', 'ekiggeli@irs.gov', 19);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Midnight Crossing', '2023-09-26', '2023-10-12', 'bboyatj@hugedomains.com', 20);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Silkwood', '2023-05-26', '2024-04-04', 'drillattk@yale.edu', 21);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Deep End of the Ocean, The', '2023-09-25', '2023-12-22', 'zwasbeyl@bandcamp.com', 22);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Goddess, The (Shen nu)', '2023-12-06', '2024-03-18', 'jmansellm@businessinsider.com', 23);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Nobody Knows Anything!', '2023-08-15', '2023-04-19', 'olayen@sciencedirect.com', 24);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Outlaw of Gor', '2023-04-28', '2023-07-07', 'rcomero@newsvine.com', 25);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Candyman 3: Day of the Dead', '2023-05-12', '2023-07-06', 'lwignallp@state.gov', 26);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Dear John', '2023-08-02', '2023-10-21', 'ableesingq@nih.gov', 27);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Colombiana', '2023-10-06', '2024-03-01', 'dclutterhamr@trellian.com', 28);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Freddy Got Fingered', '2024-03-16', '2024-03-16', 'uhamblys@addtoany.com', 29);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Chasing Ice', '2023-10-26', '2023-08-01', 'bcorderot@yale.edu', 30);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Maniac', '2023-09-25', '2023-09-20', 'snucatoru@economist.com', 31);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Into the Abyss', '2023-12-16', '2024-04-13', 'amatteiniv@slate.com', 32);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Sunfish, The (Klumpfisken)', '2023-06-25', '2023-06-30', 'fblakeboroughw@mail.ru', 33);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Once Upon a Forest', '2023-06-30', '2023-10-22', 'fcureex@yellowbook.com', 34);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Jack-O', '2023-04-19', '2023-10-11', 'acominoy@yale.edu', 35);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Blood and Sand (Sangre y Arena)', '2023-07-13', '2024-02-21', 'ikylez@163.com', 36);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Imagine: John Lennon', '2023-09-22', '2023-07-26', 'aravenscroft10@ted.com', 37);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Exit Humanity', '2023-05-01', '2023-07-08', 'acatcheside11@gov.uk', 38);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Above Suspicion', '2023-09-13', '2023-10-15', 'cfenton12@sbwire.com', 39);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Block-Heads', '2023-05-13', '2024-03-17', 'mnorwell13@umich.edu', 40);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Scenes of a Sexual Nature', '2024-01-30', '2024-03-03', 'cdate14@google.com.br', 41);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Dune', '2023-06-05', '2023-07-12', 'pshoebottom15@state.tx.us', 42);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Mansion of Madness, The', '2023-07-10', '2024-01-24', 'bmcgeown16@reference.com', 43);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Rewind This!', '2023-04-24', '2024-01-07', 'mmongin17@craigslist.org', 44);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Red Dawn', '2023-05-08', '2024-02-22', 'awinsom18@virginia.edu', 45);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Mating Game, The', '2024-02-22', '2024-02-03', 'rmacgorman19@gravatar.com', 46);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Wrong Rosary (Uzak ihtimal)', '2024-01-24', '2023-08-29', 'scrowcombe1a@google.es', 47);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Subspecies IV: Bloodstorm', '2023-12-09', '2023-11-05', 'aharfoot1b@4shared.com', 48);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Taras Bulba', '2023-04-20', '2023-05-24', 'mwitherby1c@usa.gov', 49);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Faculty, The', '2024-02-05', '2024-04-04', 'rbleeze1d@patch.com', 50);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('When Nietzsche Wept', '2024-02-08', '2023-05-31', 'hboyton1e@discovery.com', 51);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('I''m All Right Jack', '2024-04-09', '2023-11-29', 'cwollacott1f@mysql.com', 52);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Slow Southern Steel', '2023-12-31', '2023-06-03', 'dmccowan1g@blogger.com', 53);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Dance, Girl, Dance', '2024-03-16', '2024-02-09', 'nconstantine1h@google.com.hk', 54);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Circle of Eight', '2024-02-17', '2024-03-28', 'averrick1i@goo.gl', 55);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Berlin Calling', '2023-10-08', '2024-03-03', 'pwillbraham1j@huffingtonpost.com', 56);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Ring Finger, The (L''annulaire)', '2023-06-18', '2024-01-08', 'gbolens1k@yandex.ru', 57);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Twelve Angry Men', '2023-10-28', '2024-01-18', 'fgrills1l@prweb.com', 58);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Anchorman: The Legend of Ron Burgundy', '2023-05-09', '2024-03-13', 'nhavard1m@opera.com', 59);
insert into Documents (documentTitle, dateCreated, dateLastUpdated, presidentEmail, documentID) values ('Piranhaconda', '2023-11-08', '2024-04-04', 'anettle1n@newyorker.com', 60);


# ----- 60 Examples
insert into DocEmails (accessEmail, documentID) values ('eklassman0@discovery.com', '1');
insert into DocEmails (accessEmail, documentID) values ('khounsome1@bloomberg.com', '2');
insert into DocEmails (accessEmail, documentID) values ('pnewick2@ow.ly', '3');
insert into DocEmails (accessEmail, documentID) values ('rboggish3@twitpic.com', '4');
insert into DocEmails (accessEmail, documentID) values ('ttarborn4@google.com.hk', '5');
insert into DocEmails (accessEmail, documentID) values ('hrumble5@devhub.com', '6');
insert into DocEmails (accessEmail, documentID) values ('mbentson6@google.pl', '7');
insert into DocEmails (accessEmail, documentID) values ('troskeilly7@seesaa.net', '8');
insert into DocEmails (accessEmail, documentID) values ('kbrockwell8@feedburner.com', '9');
insert into DocEmails (accessEmail, documentID) values ('raddington9@gravatar.com', '10');
insert into DocEmails (accessEmail, documentID) values ('nmertschinga@netvibes.com', '11');
insert into DocEmails (accessEmail, documentID) values ('zmcgettrickb@163.com', '12');
insert into DocEmails (accessEmail, documentID) values ('prexworthyc@harvard.edu', '13');
insert into DocEmails (accessEmail, documentID) values ('rsterryd@dell.com', '14');
insert into DocEmails (accessEmail, documentID) values ('bwedderburne@sbwire.com', '15');
insert into DocEmails (accessEmail, documentID) values ('candrellif@lulu.com', '16');
insert into DocEmails (accessEmail, documentID) values ('jglancyg@php.net', '17');
insert into DocEmails (accessEmail, documentID) values ('rbrodleyh@liveinternet.ru', '18');
insert into DocEmails (accessEmail, documentID) values ('mellsworthei@typepad.com', '19');
insert into DocEmails (accessEmail, documentID) values ('gattackj@infoseek.co.jp', '20');
insert into DocEmails (accessEmail, documentID) values ('leptonk@mac.com', '21');
insert into DocEmails (accessEmail, documentID) values ('mcastelowl@bloglines.com', '22');
insert into DocEmails (accessEmail, documentID) values ('jtittletrossm@webnode.com', '23');
insert into DocEmails (accessEmail, documentID) values ('mstirrupn@apple.com', '24');
insert into DocEmails (accessEmail, documentID) values ('ddimmneo@tuttocitta.it', '25');
insert into DocEmails (accessEmail, documentID) values ('mboothep@ow.ly', '26');
insert into DocEmails (accessEmail, documentID) values ('dduddleq@weather.com', '27');
insert into DocEmails (accessEmail, documentID) values ('ldankovr@freewebs.com', '28');
insert into DocEmails (accessEmail, documentID) values ('mmcasgills@dot.gov', '29');
insert into DocEmails (accessEmail, documentID) values ('lswetlandt@last.fm', '30');
insert into DocEmails (accessEmail, documentID) values ('qbeenhamu@mysql.com', '31');
insert into DocEmails (accessEmail, documentID) values ('cchoupinv@hubpages.com', '32');
insert into DocEmails (accessEmail, documentID) values ('agreggsw@acquirethisname.com', '33');
insert into DocEmails (accessEmail, documentID) values ('sdaultonx@example.com', '34');
insert into DocEmails (accessEmail, documentID) values ('bfraczaky@liveinternet.ru', '35');
insert into DocEmails (accessEmail, documentID) values ('ttetsallz@kickstarter.com', '36');
insert into DocEmails (accessEmail, documentID) values ('jszwarc10@alibaba.com', '37');
insert into DocEmails (accessEmail, documentID) values ('eblundin11@virginia.edu', '38');
insert into DocEmails (accessEmail, documentID) values ('rbrunotti12@ucla.edu', '39');
insert into DocEmails (accessEmail, documentID) values ('gdukes13@cnet.com', '40');
insert into DocEmails (accessEmail, documentID) values ('cguirardin14@last.fm', '41');
insert into DocEmails (accessEmail, documentID) values ('oabbatini15@hud.gov', '42');
insert into DocEmails (accessEmail, documentID) values ('cdoran16@dailymotion.com', '43');
insert into DocEmails (accessEmail, documentID) values ('acheckley17@chron.com', '44');
insert into DocEmails (accessEmail, documentID) values ('jwilde18@usa.gov', '45');
insert into DocEmails (accessEmail, documentID) values ('wchristol19@jugem.jp', '46');
insert into DocEmails (accessEmail, documentID) values ('elange1a@disqus.com', '47');
insert into DocEmails (accessEmail, documentID) values ('lsquire1b@blogtalkradio.com', '48');
insert into DocEmails (accessEmail, documentID) values ('clewton1c@wikimedia.org', '49');
insert into DocEmails (accessEmail, documentID) values ('zsmewing1d@diigo.com', '50');
insert into DocEmails (accessEmail, documentID) values ('lcoppeard1e@tripadvisor.com', '51');
insert into DocEmails (accessEmail, documentID) values ('lhanigan1f@springer.com', '52');
insert into DocEmails (accessEmail, documentID) values ('kfinlason1g@tuttocitta.it', '53');
insert into DocEmails (accessEmail, documentID) values ('mgazey1h@hhs.gov', '54');
insert into DocEmails (accessEmail, documentID) values ('kwyleman1i@kickstarter.com', '55');
insert into DocEmails (accessEmail, documentID) values ('cclurow1j@tinyurl.com', '56');
insert into DocEmails (accessEmail, documentID) values ('tdusey1k@elegantthemes.com', '57');
insert into DocEmails (accessEmail, documentID) values ('bjzak1l@google.com', '58');
insert into DocEmails (accessEmail, documentID) values ('tbeadell1m@1und1.de', '59');
insert into DocEmails (accessEmail, documentID) values ('msoldner1n@ucoz.ru', '60');

# ----- 250 Examples
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('galsobrook0@un.org', 1, 1);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('asitford1@bbc.co.uk', 2, 2);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kiacobo2@sourceforge.net', 3, 3);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cheard3@edublogs.org', 4, 4);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kblainey4@mail.ru', 5, 5);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('llapidus5@spotify.com', 6, 6);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hpancoast6@bloglovin.com', 7, 7);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dbrouncker7@army.mil', 8, 8);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('epeaden8@people.com.cn', 9, 9);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbaskeyfied9@miitbeian.gov.cn', 10, 10);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('bfusta@chron.com', 11, 11);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('scarnilianb@xrea.com', 12, 12);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gartheyc@friendfeed.com', 13, 13);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('choggand@boston.com', 14, 14);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbere@google.com.br', 15, 15);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kguidellif@bizjournals.com', 16, 16);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('pworshallg@blogs.com', 17, 17);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lcattersonh@tamu.edu', 18, 18);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('qhynami@chronoengine.com', 19, 19);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lhanningj@auda.org.au', 20, 20);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gstellik@flickr.com', 21, 21);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mwingattl@theatlantic.com', 22, 22);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('imenicom@devhub.com', 23, 23);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('csaywoodn@histats.com', 24, 24);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('sgruczkao@vimeo.com', 25, 25);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dteapep@photobucket.com', 26, 26);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('bgaynsfordq@123-reg.co.uk', 27, 27);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lpoultonr@nsw.gov.au', 28, 28);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('csayerss@psu.edu', 29, 29);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('tjobket@illinois.edu', 30, 30);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kspurrittu@pcworld.com', 31, 31);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('sousbiev@omniture.com', 32, 32);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cmettsw@stumbleupon.com', 33, 33);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('rjimmesx@uiuc.edu', 34, 34);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hflanneryy@netscape.com', 35, 35);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('upostiansz@dyndns.org', 36, 36);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('acarl10@nsw.gov.au', 37, 37);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('fdenziloe11@tinypic.com', 38, 38);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('ferskine12@msn.com', 39, 39);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mmatussov13@stanford.edu', 40, 40);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('vdougharty14@paypal.com', 41, 41);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('syerlett15@drupal.org', 42, 42);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gwadlow16@home.pl', 43, 43);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('rsmalley17@seesaa.net', 44, 44);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('iinfantino18@dot.gov', 45, 45);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kmancell19@etsy.com', 46, 46);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('aborsi1a@oakley.com', 47, 47);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hmussington1b@ted.com', 48, 48);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('jcaistor1c@opensource.org', 49, 49);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('eewbanck1d@walmart.com', 50, 50);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('amilner1e@goodreads.com', 51, 51);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('ragborne1f@github.com', 52, 52);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hdossettor1g@4shared.com', 53, 53);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('tkingsley1h@alibaba.com', 54, 54);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('redward1i@opera.com', 55, 55);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mmenzies1j@nbcnews.com', 56, 56);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('grobken1k@jalbum.net', 57, 57);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('wmumby1l@yahoo.co.jp', 58, 58);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('pisard1m@dailymail.co.uk', 59, 59);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dhaliburton1n@eepurl.com', 60, 60);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('galsobrook0@un.org', 61, 61);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('asitford1@bbc.co.uk', 62, 62);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kiacobo2@sourceforge.net', 63, 63);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cheard3@edublogs.org', 64, 64);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kblainey4@mail.ru', 65, 65);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('llapidus5@spotify.com', 66, 66);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hpancoast6@bloglovin.com', 67, 67);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dbrouncker7@army.mil', 68, 68);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('epeaden8@people.com.cn', 69, 69);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbaskeyfied9@miitbeian.gov.cn', 70, 70);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('bfusta@chron.com', 71, 71);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('scarnilianb@xrea.com', 72, 72);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gartheyc@friendfeed.com', 73, 73);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('choggand@boston.com', 74, 74);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbere@google.com.br', 75, 75);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kguidellif@bizjournals.com', 76, 76);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('pworshallg@blogs.com', 77, 77);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lcattersonh@tamu.edu', 78, 78);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('qhynami@chronoengine.com', 79, 79);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lhanningj@auda.org.au', 80, 80);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gstellik@flickr.com', 81, 81);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mwingattl@theatlantic.com', 82, 82);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('imenicom@devhub.com', 83, 83);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('csaywoodn@histats.com', 84, 84);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('sgruczkao@vimeo.com', 85, 85);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dteapep@photobucket.com', 86, 86);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('bgaynsfordq@123-reg.co.uk', 87, 87);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lpoultonr@nsw.gov.au', 88, 88);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('csayerss@psu.edu', 89, 89);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('tjobket@illinois.edu', 90, 90);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kspurrittu@pcworld.com', 91, 91);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('sousbiev@omniture.com', 92, 92);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cmettsw@stumbleupon.com', 93, 93);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('rjimmesx@uiuc.edu', 94, 94);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hflanneryy@netscape.com', 95, 95);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('upostiansz@dyndns.org', 96, 96);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('acarl10@nsw.gov.au', 97, 97);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('fdenziloe11@tinypic.com', 98, 98);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('ferskine12@msn.com', 99, 99);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mmatussov13@stanford.edu', 100, 100);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('vdougharty14@paypal.com', 101, 101);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('syerlett15@drupal.org', 102, 102);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gwadlow16@home.pl', 103, 103);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('rsmalley17@seesaa.net', 104, 104);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('iinfantino18@dot.gov', 105, 105);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kmancell19@etsy.com', 106, 106);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('aborsi1a@oakley.com', 107, 107);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hmussington1b@ted.com', 108, 108);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('jcaistor1c@opensource.org', 109, 109);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('eewbanck1d@walmart.com', 110, 110);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('amilner1e@goodreads.com', 111, 111);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('ragborne1f@github.com', 112, 112);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hdossettor1g@4shared.com', 113, 113);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('tkingsley1h@alibaba.com', 114, 114);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('redward1i@opera.com', 115, 115);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mmenzies1j@nbcnews.com', 116, 116);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('grobken1k@jalbum.net', 117, 117);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('wmumby1l@yahoo.co.jp', 118, 118);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('pisard1m@dailymail.co.uk', 119, 119);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dhaliburton1n@eepurl.com', 120, 120);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('galsobrook0@un.org', 121, 121);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('asitford1@bbc.co.uk', 122, 122);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kiacobo2@sourceforge.net', 123, 123);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cheard3@edublogs.org', 124, 124);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kblainey4@mail.ru', 125, 125);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('llapidus5@spotify.com', 126, 126);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hpancoast6@bloglovin.com', 127, 127);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dbrouncker7@army.mil', 128, 128);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('epeaden8@people.com.cn', 129, 129);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbaskeyfied9@miitbeian.gov.cn', 130, 130);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('bfusta@chron.com', 131, 131);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('scarnilianb@xrea.com', 132, 132);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gartheyc@friendfeed.com', 133, 133);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('choggand@boston.com', 134, 134);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbere@google.com.br', 135, 135);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kguidellif@bizjournals.com', 136, 136);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('pworshallg@blogs.com', 137, 137);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lcattersonh@tamu.edu', 138, 138);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('qhynami@chronoengine.com', 139, 139);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lhanningj@auda.org.au', 140, 140);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gstellik@flickr.com', 141, 141);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mwingattl@theatlantic.com', 142, 142);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('imenicom@devhub.com', 143, 143);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('csaywoodn@histats.com', 144, 144);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('sgruczkao@vimeo.com', 145, 145);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dteapep@photobucket.com', 146, 146);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('bgaynsfordq@123-reg.co.uk', 147, 147);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lpoultonr@nsw.gov.au', 148, 148);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('csayerss@psu.edu', 149, 149);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('tjobket@illinois.edu', 150, 150);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kspurrittu@pcworld.com', 151, 151);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('sousbiev@omniture.com', 152, 152);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cmettsw@stumbleupon.com', 153, 153);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('rjimmesx@uiuc.edu', 154, 154);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hflanneryy@netscape.com', 155, 155);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('upostiansz@dyndns.org', 156, 156);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('acarl10@nsw.gov.au', 157, 157);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('fdenziloe11@tinypic.com', 158, 158);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('ferskine12@msn.com', 159, 159);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mmatussov13@stanford.edu', 160, 160);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('vdougharty14@paypal.com', 161, 161);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('syerlett15@drupal.org', 162, 162);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gwadlow16@home.pl', 163, 163);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('rsmalley17@seesaa.net', 164, 164);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('iinfantino18@dot.gov', 165, 165);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kmancell19@etsy.com', 166, 166);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('aborsi1a@oakley.com', 167, 167);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hmussington1b@ted.com', 168, 168);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('jcaistor1c@opensource.org', 169, 169);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('eewbanck1d@walmart.com', 170, 170);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('amilner1e@goodreads.com', 171, 171);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('ragborne1f@github.com', 172, 172);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hdossettor1g@4shared.com', 173, 173);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('tkingsley1h@alibaba.com', 174, 174);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('redward1i@opera.com', 175, 175);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mmenzies1j@nbcnews.com', 176, 176);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('grobken1k@jalbum.net', 177, 177);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('wmumby1l@yahoo.co.jp', 178, 178);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('pisard1m@dailymail.co.uk', 179, 179);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dhaliburton1n@eepurl.com', 180, 180);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('galsobrook0@un.org', 181, 181);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('asitford1@bbc.co.uk', 182, 182);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kiacobo2@sourceforge.net', 183, 183);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cheard3@edublogs.org', 184, 184);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kblainey4@mail.ru', 185, 185);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('llapidus5@spotify.com', 186, 186);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hpancoast6@bloglovin.com', 187, 187);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dbrouncker7@army.mil', 188, 188);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('epeaden8@people.com.cn', 189, 189);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbaskeyfied9@miitbeian.gov.cn', 190, 190);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('bfusta@chron.com', 191, 191);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('scarnilianb@xrea.com', 192, 192);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gartheyc@friendfeed.com', 193, 193);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('choggand@boston.com', 194, 194);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbere@google.com.br', 195, 195);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kguidellif@bizjournals.com', 196, 196);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('pworshallg@blogs.com', 197, 197);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lcattersonh@tamu.edu', 198, 198);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('qhynami@chronoengine.com', 199, 199);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lhanningj@auda.org.au', 200, 200);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gstellik@flickr.com', 201, 201);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mwingattl@theatlantic.com', 202, 202);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('imenicom@devhub.com', 203, 203);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('csaywoodn@histats.com', 204, 204);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('sgruczkao@vimeo.com', 205, 205);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dteapep@photobucket.com', 206, 206);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('bgaynsfordq@123-reg.co.uk', 207, 207);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('lpoultonr@nsw.gov.au', 208, 208);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('csayerss@psu.edu', 209, 209);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('tjobket@illinois.edu', 210, 210);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kspurrittu@pcworld.com', 211, 211);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('sousbiev@omniture.com', 212, 212);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cmettsw@stumbleupon.com', 213, 213);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('rjimmesx@uiuc.edu', 214, 214);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hflanneryy@netscape.com', 215, 215);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('upostiansz@dyndns.org', 216, 216);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('acarl10@nsw.gov.au', 217, 217);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('fdenziloe11@tinypic.com', 218, 218);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('ferskine12@msn.com', 219, 219);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mmatussov13@stanford.edu', 220, 220);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('vdougharty14@paypal.com', 221, 221);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('syerlett15@drupal.org', 222, 222);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('gwadlow16@home.pl', 223, 223);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('rsmalley17@seesaa.net', 224, 224);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('iinfantino18@dot.gov', 225, 225);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kmancell19@etsy.com', 226, 226);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('aborsi1a@oakley.com', 227, 227);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hmussington1b@ted.com', 228, 228);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('jcaistor1c@opensource.org', 229, 229);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('eewbanck1d@walmart.com', 230, 230);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('amilner1e@goodreads.com', 231, 231);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('ragborne1f@github.com', 232, 232);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hdossettor1g@4shared.com', 233, 233);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('tkingsley1h@alibaba.com', 234, 234);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('redward1i@opera.com', 235, 235);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mmenzies1j@nbcnews.com', 236, 236);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('grobken1k@jalbum.net', 237, 237);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('wmumby1l@yahoo.co.jp', 238, 238);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('pisard1m@dailymail.co.uk', 239, 239);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dhaliburton1n@eepurl.com', 240, 240);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('galsobrook0@un.org', 241, 241);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('asitford1@bbc.co.uk', 242, 242);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kiacobo2@sourceforge.net', 243, 243);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('cheard3@edublogs.org', 244, 244);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('kblainey4@mail.ru', 245, 245);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('llapidus5@spotify.com', 246, 246);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('hpancoast6@bloglovin.com', 247, 247);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('dbrouncker7@army.mil', 248, 248);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('epeaden8@people.com.cn', 249, 249);
insert into Club_Members_User_Profile (clubMemberEmail, userProfileID, clubMemberID) values ('mbaskeyfied9@miitbeian.gov.cn', 250, 250);

# ----- 60 Examples
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier manufacturer of electric vehicles, revolutionizing the automotive industry', 'Personal Trainer delivering customized workouts for a fitness brand', 'E-commerce Specialist', 'Boat, The', '43', 1);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Leading fashion brand renowned for its avant-garde designs and commitment to ethical manufacturing', 'Logistics Coordinator optimizing supply chain operations for a global logistics firm', 'Marketing Manager', 'Oasis', '25', 2);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Top-tier entertainment studio producing acclaimed films and television series', 'Film Producer overseeing production for an entertainment studio', 'Education Administrator', 'Father of Invention', '24', 3);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Leading provider of remote work solutions, enabling virtual collaboration', 'Telecommunications Engineer maintaining global connectivity for a telecom provider', 'Sports Equipment Designer', 'Last American Hero, The', '51', 4);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier supplier of gourmet foods and specialty ingredients', 'Fitness Equipment Designer creating workout equipment for a manufacturer', 'Pharmaceutical Research Scientist', 'Living Room of the Nation, The (Kansakunnan olohuone)', '57', 5);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted financial institution providing comprehensive banking services and investment solutions', 'Sustainability Specialist developing eco-friendly packaging for a startup', 'Corporate Lawyer', 'Shadows (Senki)', '36', 6);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted provider of financial advisory services, helping clients achieve their goals', 'Legal Counsel providing legal services for a law firm', 'Hospitality Manager', 'Johnny Tremain', '34', 7);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier manufacturer of electric vehicles, revolutionizing the automotive industry', 'Legal Counsel providing legal services for a law firm', 'Head Chef', 'Pigsty (Porcile)', '47', 8);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier advertising agency creating impactful campaigns and brand strategies', 'Strategy Consultant providing advice to Fortune 500 companies for a top-tier consulting firm', 'Environmental Compliance Officer', 'Anatomy of a Murder', '10', 9);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted healthcare provider offering a wide range of medical services and specialties', 'Financial Analyst analyzing investment opportunities for a trusted financial institution', 'Fitness Equipment Manufacturer', 'Postcards From the Edge', '5', 10);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Global leader in aerospace engineering, designing cutting-edge aircraft and spacecraft', 'Senior Software Engineer specializing in AI-driven email marketing campaigns', 'Biomedical Research Scientist', 'Born Wild', '1', 11);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted healthcare provider offering a wide range of medical services and specialties', 'Digital Marketer managing online campaigns for a marketing agency', 'Real Estate Agent', 'Archangel', '32', 12);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Leading provider of cybersecurity solutions, protecting businesses from digital threats', 'Head Chef managing restaurant operations for a top-rated chain', 'Agricultural Engineer', 'Silvestre', '45', 13);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted provider of telecommunications services, connecting people around the globe', 'Sustainability Specialist developing eco-friendly packaging for a startup', 'Gourmet Chef', 'Secret Glory, The', '48', 14);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier audio equipment manufacturer known for its high-fidelity sound systems', 'Robotics Engineer developing automation solutions for various industries', 'Software Engineer - AI Email Marketing', 'Cairo Station (a.k.a. Iron Gate, The) (Bab el hadid)', '56', 15);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Innovative tech startup disrupting traditional retail with its online marketplace platform', 'Renewable Energy Engineer designing sustainable solutions for an energy provider', 'Environmental Scientist', 'Summer of ''04 (Sommer ''04)', '22', 16);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Global leader in aerospace engineering, designing cutting-edge aircraft and spacecraft', 'Financial Analyst analyzing investment opportunities for a trusted financial institution', 'Cloud Solutions Architect', 'Charley Varrick', '23', 17);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Renowned educational institution offering diverse academic programs and research opportunities', 'Environmental Scientist studying conservation efforts for an environmental organization', 'E-commerce Specialist', 'Million Dollar Arm', '18', 18);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Renowned research hospital conducting clinical trials and medical research', 'E-commerce Specialist managing online sales for a global fashion retailer', 'Culinary Instructor', 'Tell Me Something (Telmisseomding)', '14', 19);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier supplier of gourmet foods and specialty ingredients', 'Film Producer overseeing production for an entertainment studio', 'Security Specialist', 'Journey to Italy (Viaggio in Italia) (Voyage to Italy) (Voyage in Italy)', '41', 20);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Top-tier entertainment studio producing acclaimed films and television series', 'Marketing Manager developing campaigns for an advertising agency', 'Fashion Designer', '13th Letter, The', '3', 21);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Top-rated restaurant chain serving authentic cuisine from around the world', 'Real Estate Agent facilitating property transactions for a trusted agency', 'Digital Marketer', 'Jerusalem Countdown', '28', 22);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Global leader in logistics and supply chain management, optimizing operations for efficiency', 'Textile Designer creating sustainable fashion for a global fashion brand', 'Fashion Designer', 'Film ist. 7-12', '39', 23);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Innovative startup developing sustainable alternatives to single-use plastics', 'Strategy Consultant providing advice to Fortune 500 companies for a top-tier consulting firm', 'Sustainable Architect', 'Messenger of Death', '42', 24);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Innovative tech startup disrupting traditional retail with its online marketplace platform', 'E-commerce Specialist managing online marketplace operations for a tech startup', 'Telecommunications Engineer', 'Leatherface: Texas Chainsaw Massacre III', '4', 25);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier fitness brand offering state-of-the-art equipment and personalized training programs', 'Telecom Engineer maintaining telecommunications networks for a provider', 'Cloud Solutions Architect', 'Camp X-Ray', '37', 26);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted provider of telecommunications services, connecting people around the globe', 'Sustainable Architect designing eco-friendly buildings for a renowned firm', 'Textile Designer', 'Out 1: Spectre', '54', 27);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Renowned architecture firm known for its iconic buildings and sustainable design approach', 'Sports Equipment Designer creating innovative gear for a sports manufacturer', 'Sports Equipment Designer', 'Cage aux Folles II, La', '55', 28);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Innovative startup developing eco-friendly alternatives to traditional packaging', 'Financial Advisor providing investment guidance for a fintech startup', 'Medical Researcher', 'Another Chance', '27', 29);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Top-tier fitness equipment manufacturer known for its quality and durability', 'Pharmaceutical Research Scientist developing treatments for critical illnesses', 'Fitness Coach', 'As Long as You''ve Got Your Health (Tant qu''on a la santé)', '12', 30);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Innovative startup developing eco-friendly alternatives to traditional packaging', 'Telecom Engineer maintaining telecommunications networks for a provider', 'Culinary Instructor', 'Americanization of Emily, The', '60', 31);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier supplier of gourmet foods and specialty ingredients', 'E-commerce Manager overseeing online sales for an e-commerce solutions provider', 'Art Curator', 'Charlie Chan in Honolulu', '33', 32);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Leading provider of cybersecurity solutions, protecting businesses from digital threats', 'Security Specialist monitoring home security systems for a provider', 'Gourmet Chef', 'Fugitive, The', '16', 33);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier travel agency specializing in luxury vacations and personalized travel experiences', 'Medical Researcher conducting studies at a research institute', 'Biomedical Research Scientist', 'Jekyll', '40', 34);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Top-rated wellness app offering meditation and mindfulness exercises', 'Agricultural Engineer improving farming practices for an agtech company', 'Security Specialist', 'Legend of the Village Warriors (Bangrajan)', '31', 35);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted provider of online learning platforms, offering courses in various subjects', 'Travel Concierge arranging luxury vacations for a premier travel agency', 'Security Specialist', 'It''s a Mad, Mad, Mad, Mad World', '21', 36);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier travel agency specializing in luxury vacations and personalized travel experiences', 'Head Chef managing restaurant operations for a top-rated chain', 'Textile Designer', 'Zombies of Mora Tau', '13', 37);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier manufacturer of luxury watches and timepieces', 'Education Administrator overseeing academic programs for an educational institution', 'Legal Counsel', 'Rampo (a.k.a. The Mystery of Rampo)', '17', 38);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Leading provider of e-commerce solutions, helping businesses thrive online', 'Legal Counsel providing legal services for a law firm', 'Biomedical Research Scientist', 'Harry Potter and the Goblet of Fire', '9', 39);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Cutting-edge robotics company revolutionizing automation across various industries', 'Pharmaceutical Research Scientist developing treatments for critical illnesses', 'E-commerce Specialist', 'Son of No One, The', '52', 40);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Innovative software company developing cutting-edge solutions for businesses', 'Robotics Engineer developing automation solutions for various industries', 'Personal Trainer', 'Red Heat', '8', 41);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Renowned culinary institute offering world-class culinary education and training programs', 'E-commerce Manager overseeing online sales for an e-commerce solutions provider', 'Financial Advisor', 'Seeking a Friend for the End of the World', '29', 42);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Innovative fintech startup revolutionizing personal finance management', 'Textile Designer creating sustainable fashion for a global fashion brand', 'Software Developer', 'Midnight Crossing', '44', 43);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Top-tier fashion retailer offering curated collections from designer brands', 'Travel Concierge arranging luxury vacations for a premier travel agency', 'Personal Trainer', 'Kids Are All Right, The', '59', 44);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier gaming studio creating immersive experiences for gamers worldwide', 'Renewable Energy Engineer designing sustainable solutions for an energy provider', 'Fashion Designer', 'Desert Heat (Inferno)', '49', 45);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Renowned architectural firm known for its innovative designs and sustainable building practices', 'Environmental Compliance Officer ensuring sustainability practices in home furnishings manufacturing', 'Marketing Manager', 'Story of a Cheat, The (Roman d''un tricheur, Le)', '35', 46);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted provider of online learning platforms, offering courses in various subjects', 'Financial Analyst analyzing investment opportunities for a trusted financial institution', 'Architectural Designer', 'Ugly, The', '38', 47);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Innovative startup developing sustainable alternatives to single-use plastics', 'Senior Software Engineer specializing in AI-driven email marketing campaigns', 'Hospitality Manager', 'After Image (Seeing in the Dark)', '50', 48);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Global telecommunications provider delivering reliable connectivity solutions worldwide', 'Pharmaceutical Research Scientist developing treatments for critical illnesses', 'Strategy Consultant', 'Last Time I Committed Suicide, The', '20', 49);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Top-tier entertainment studio producing acclaimed films and television series', 'Organic Farming Specialist overseeing crop cultivation for a produce supplier', 'Architectural Designer', 'Shake Hands with the Devil', '2', 50);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted provider of home security systems and monitoring services', 'Hospitality Manager overseeing resort operations for a hospitality group', 'Culinary Instructor', 'Great Escape, The', '53', 51);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Global leader in agricultural technology, improving crop yields and farming efficiency', 'Environmental Compliance Officer ensuring sustainability practices in home furnishings manufacturing', 'Organic Farming Specialist', 'Girlhood', '15', 52);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Global retailer offering a wide selection of clothing and accessories for online shoppers worldwide', 'Fashion Designer creating avant-garde designs for a leading fashion brand', 'Digital Marketer', 'Tale of Sweeney Todd, The', '19', 53);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Leading provider of remote work solutions, enabling virtual collaboration', 'Fashion Designer creating avant-garde designs for a leading fashion brand', 'Financial Analyst', 'Bad Seed, The', '7', 54);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Top-rated wellness app offering meditation and mindfulness exercises', 'Legal Counsel providing legal services for a law firm', 'Cloud Solutions Architect', 'Miracles - Mr. Canton and Lady Rose', '58', 55);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier travel agency specializing in luxury vacations and personalized travel experiences', 'Legal Counsel providing legal services for a law firm', 'Agricultural Engineer', 'Reminiscences of a Journey to Lithuania', '30', 56);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Premier manufacturer of electric vehicles, revolutionizing the automotive industry', 'Watchmaker crafting luxury timepieces for a watch manufacturer', 'E-commerce Specialist', 'Hedd Wyn', '6', 57);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Leading fashion brand renowned for its avant-garde designs and commitment to ethical manufacturing', 'Environmental Scientist studying conservation efforts for an environmental organization', 'Real Estate Agent', 'Resurrecting the Street Walker', '46', 58);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Trusted provider of legal services, representing clients in various legal matters', 'Automotive Engineer designing innovative vehicles for a premier manufacturer', 'Textile Designer', 'Nothing Sacred', '26', 59);
insert into Club_Network_Job_Board (companyDescription, roleDescription, positionName, companyName, clubID, roleID) values ('Renowned educational institution offering diverse academic programs and research opportunities', 'Head Chef managing restaurant operations for a top-rated chain', 'Personal Trainer', 'Sick Girl', '11', 60);
