
CREATE DATABASE ohd;
USE ohd;

-- User table
CREATE TABLE EndUsers (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(15),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Facilities table
CREATE TABLE Facilities (
    FacilityID INT PRIMARY KEY IDENTITY(1,1),
FacilityHeadID INT,
    FacilityName NVARCHAR(100) UNIQUE NOT NULL,
    Description TEXT,
    Status NVARCHAR(10) NOT NULL CHECK (Status IN ('Active', 'Inactive')),
FOREIGN KEY (FacilityHeadID) REFERENCES FacilityHeads(FacilityHeadID)
);

-- Request table
CREATE TABLE Requests (
    RequestID INT PRIMARY KEY IDENTITY(1,1),
    RequestorID INT,
    FacilityID INT,
    RequestDate DATETIME NOT NULL,
    AssigneeID INT,
FacilityHeadID INT,
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Unassigned', 'Assigned', 'Work in Progress', 'Closed', 'Rejected', 'Need More Info')),
    Severity NVARCHAR(10) NOT NULL CHECK (Severity IN ('Low', 'Medium', 'High', 'Critical')),
    Description TEXT NOT NULL,
    Remarks NVARCHAR(255),
    FOREIGN KEY (RequestorID) REFERENCES EndUsers(UserID),
    FOREIGN KEY (FacilityID) REFERENCES Facilities(FacilityID),
	    FOREIGN KEY (AssigneeID) REFERENCES Assignees(AssigneeID),
FOREIGN KEY (FacilityHeadID) REFERENCES FacilityHeads(FacilityHeadID)

);



-- Reports table
CREATE TABLE Reports (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    FacilityID INT,
    ReportDate DATE NOT NULL,
    Summary TEXT NOT NULL,
    FOREIGN KEY (FacilityID) REFERENCES Facilities(FacilityID)
);

-- Admin table
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY IDENTITY(1,1),
    Usernaem nvarchar(250) not null,
AdminEmail nvarchar(250) Unique not null,
AdminPass nvarchar(250) not null,

);

-- FAQs table
CREATE TABLE FAQs (
    FAQID INT PRIMARY KEY IDENTITY(1,1),
    Question TEXT NOT NULL,
    Answer TEXT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Assignees table
CREATE TABLE Assignees (
    AssigneeID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    AssignedTasks INT DEFAULT 0,
    SkillSet TEXT
);

-- Facilities Head table

CREATE TABLE FacilityHeads (
    FacilityHeadID INT PRIMARY KEY IDENTITY(1,1),
    FacilityID INT NOT NULL,
  AssigneeID INT,
    UNIQUE ( FacilityID)
);

ALTER TABLE Assignees
ADD FOREIGN KEY (UserID) REFERENCES EndUsers(UserID);

ALTER TABLE FacilityHeads
ADD  FOREIGN KEY (AssigneeID) REFERENCES Assignees(AssigneeID);

  ALTER TABLE FacilityHeads
ADD FOREIGN KEY (FacilityID) REFERENCES Facilities(FacilityID);