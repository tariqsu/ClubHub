SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `ClubHub` ;
CREATE SCHEMA IF NOT EXISTS `ClubHub` DEFAULT CHARACTER SET latin1 ;
USE `ClubHub` ;

-- -----------------------------------------------------
-- Table `ClubHub`.`Club`
-- -----------------------------------------------------
CREATE TABLE Club (
    clubID VARCHAR(255) NOT NULL PRIMARY KEY,
    clubName VARCHAR(255) NOT NULL,
    instagramHandle VARCHAR(255),
    clubEmail VARCHAR(255) UNIQUE,
    complianceStatus VARCHAR(255)
);
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
);
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
);
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
);
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
);
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
);
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
);
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
);
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
);
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
);
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
);
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
);
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
);
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;