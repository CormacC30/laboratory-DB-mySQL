-- -----------------------------------------------------
-- Drop the 'laboratory' database/schema
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS laboratory;

-- -----------------------------------------------------
-- Create 'laboratory' database/schema and use this database
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS laboratory;

USE laboratory;

-- -----------------------------------------------------
-- Create table Scientist
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Scientist(
	employeeID CHAR(8) NOT NULL,
    fName VARCHAR(40) NOT NULL,
    lName VARCHAR(40) NOT NULL,
    dateOfBirth DATE,
    street VARCHAR(50),
    town VARCHAR(50),
    county VARCHAR(50),
    eircode CHAR(8),
    phoneNumber INT UNSIGNED,
    salary MEDIUMINT UNSIGNED,
    supervisor VARCHAR(40),
    PRIMARY KEY (employeeID),
    FOREIGN KEY (supervisor) REFERENCES Scientist(employeeID) ON UPDATE CASCADE ON  DELETE CASCADE
    );

-- -----------------------------------------------------
-- Create table Analysis
-- -----------------------------------------------------

CREATE TABLE IF