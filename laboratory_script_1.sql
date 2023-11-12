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

CREATE TABLE IF NOT EXISTS Analysis(
	labNoteBookID CHAR(10) NOT NULL,
    analyticalMethod VARCHAR(30),
    specification VARCHAR(20),
    employeeID CHAR(8) NOT NULL,
    PRIMARY KEY (labNoteBookID),
    FOREIGN KEY (employeeID) REFERENCES Scientist(employeeID) ON UPDATE CASCADE ON  DELETE NO ACTION
    );
    
-- -----------------------------------------------------
-- Create table LabInstruments
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS LabInstruments(
	equipmentID VARCHAR(10) NOT NULL,
    nextCalDate DATE NOT NULL,
    PRIMARY KEY (equipmentID)
    );
    
-- -----------------------------------------------------
-- Create table Uses
-- -----------------------------------------------------
    
CREATE TABLE IF NOT EXISTS Uses(
	equipmentID VARCHAR(10) NOT NULL,
    labNoteBookID CHAR(10) NOT NULL,
    measurementTime DATETIME,
    PRIMARY KEY (equipmentID, labNoteBookID),
    FOREIGN KEY (equipmentID) REFERENCES LabInstruments(equipmentID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (labNoteBookID) REFERENCES Analysis(labNoteBookID) ON UPDATE CASCADE ON DELETE CASCADE
    );
               
-- -----------------------------------------------------
-- Create table Supplier
-- -----------------------------------------------------        

CREATE TABLE IF NOT EXISTS Supplier(
	supplierID VARCHAR(20) NOT NULL,
    supplierName VARCHAR(40) NOT NULL,
    street VARCHAR(20),
    city VARCHAR(20),
    country VARCHAR(30),
    postCode VARCHAR(10),
    supplierPhones VARCHAR(20),
    email VARCHAR(30),
    PRIMARY KEY (supplierID)
    );

-- -----------------------------------------------------
-- Create table Reagent
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Reagent(
	lotNumber VARCHAR(20) NOT NULL,
    partNumber VARCHAR(20) NOT NULL,
    quantityInStock INT UNSIGNED DEFAULT 0,
    storageCondition VARCHAR(20),
    expiryDate DATE NOT NULL,
    hazardClassification VARCHAR(20),
    purity FLOAT,
    form VARCHAR(20),
    supplierID VARCHAR(20),
    PRIMARY KEY (lotNumber),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID) ON UPDATE CASCADE ON DELETE NO ACTION
    );
 
-- -----------------------------------------------------
-- Create table Solvent
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Solvent(
	lotNumber VARCHAR(20) NOT NULL,
    partNumber VARCHAR(20) NOT NULL,
    quantityInStock INT UNSIGNED DEFAULT 0,
    storageCondition VARCHAR(20),
    expiryDate DATE NOT NULL,
    hazardClassification VARCHAR(20),
    purity FLOAT,
    grade VARCHAR(20),
    supplierID VARCHAR(20),
    PRIMARY KEY (lotNumber),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID) ON UPDATE CASCADE ON DELETE NO ACTION
    );

-- -----------------------------------------------------
-- Create table Reference Standard
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS ReferenceStandard(
	lotNumber VARCHAR(20) NOT NULL,
    partNumber VARCHAR(20) NOT NULL,
    quantityInStock INT UNSIGNED DEFAULT 0,
    storageCondition VARCHAR(20),
    expiryDate DATE NOT NULL,
    hazardClassification VARCHAR(20),
    purity FLOAT,
    certOfAnalysis VARCHAR(20),
    supplierID VARCHAR(20),
    PRIMARY KEY (lotNumber),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID) ON UPDATE CASCADE ON DELETE NO ACTION
    ); 
    
-- -----------------------------------------------------
-- Create table Material
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Material(
	lotNumber VARCHAR(20) NOT NULL,
    partNumber VARCHAR(20) NOT NULL,
    quantityInStock INT UNSIGNED DEFAULT 0,
    storageCondition VARCHAR(20),
    expiryDate DATE NOT NULL,
    hazardClassification VARCHAR(20),
    purity FLOAT,
    supplierID VARCHAR(20),
    PRIMARY KEY (lotNumber),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID) ON UPDATE CASCADE ON DELETE NO ACTION
    ); 
    
-- -----------------------------------------------------
-- Create table Consumes
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Consumes (
    labNoteBookID CHAR(10) NOT NULL,
    lotNumber VARCHAR(20) NOT NULL,
    quantityUsed INT UNSIGNED DEFAULT 0,
    PRIMARY KEY (labNoteBookID, lotNumber),
    FOREIGN KEY (lotNumber) REFERENCES Material(lotNumber) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (labNoteBookID) REFERENCES Analysis(labNoteBookID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table Client
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Client (
	clientID VARCHAR(15) NOT NULL,
    companyName VARCHAR(30) NOT NULL,
    street VARCHAR(20),
    city VARCHAR(20),
    country VARCHAR(30),
    postCode VARCHAR(10),
    PRIMARY KEY (clientID)
    );
    
-- -----------------------------------------------------
-- Create table ClientPhones
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS ClientPhones (
	contactNumber VARCHAR(20),
    clientID VARCHAR(15),
    PRIMARY KEY (contactNumber),
    FOREIGN KEY (clientID) REFERENCES Client(clientID) ON UPDATE CASCADE ON DELETE CASCADE
    );

-- -----------------------------------------------------
-- Create table Batch
-- -----------------------------------------------------
    
CREATE TABLE IF NOT EXISTS Batch (
	batchNumber VARCHAR(20) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    dateOfManufacture DATE,
    clientID VARCHAR(15) NOT NULL,
	PRIMARY KEY (batchNumber),
    FOREIGN KEY (clientID) REFERENCES Client(clientID) ON UPDATE CASCADE ON DELETE NO ACTION
    );
    
-- -----------------------------------------------------
-- Create table RawMaterial
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS RawMaterial (
	batchNumber VARCHAR(20) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    dateOfManufacture DATE,
    clientID VARCHAR(15) NOT NULL,
    processID VARCHAR(10),
	PRIMARY KEY (batchNumber),
    FOREIGN KEY (clientID) REFERENCES Client(clientID) ON UPDATE CASCADE ON DELETE NO ACTION
    );
    
-- -----------------------------------------------------
-- Create table FinishedProduct
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS FinishedProduct (
	batchNumber VARCHAR(20) NOT NULL, 
    productName VARCHAR(100) NOT NULL,
    dateOfManufacture DATE,
    clientID VARCHAR(15) NOT NULL,
    presentation VARCHAR(20),
	PRIMARY KEY (batchNumber),
    FOREIGN KEY (clientID) REFERENCES Client(clientID) ON UPDATE CASCADE ON DELETE NO ACTION
    );
    
-- -----------------------------------------------------
-- Create table Sample
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Sample (
	sampleID VARCHAR(15) NOT NULL,
    storageCondition VARCHAR(30),
    expiryDate DATE,
    progressStatus VARCHAR(20) DEFAULT "Awaiting Testing",
    batchNumber VARCHAR(20) NOT NULL,
    PRIMARY KEY (sampleID),
    FOREIGN KEY (batchNumber) REFERENCES Batch(batchNumber) ON UPDATE CASCADE ON DELETE NO ACTION
    );
    
-- -----------------------------------------------------
-- Create table Tests
-- -----------------------------------------------------    

CREATE TABLE IF NOT EXISTS Tests (
	labNoteBookID CHAR(10) NOT NULL,
    sampleID VARCHAR(15) NOT NULL,
    resultID VARCHAR(15),
    dateCompleted DATE,
    PRIMARY KEY (labNoteBooKID, sampleID),
    FOREIGN KEY (labNoteBookID) REFERENCES Analysis(LabNoteBookID) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (sampleID) REFERENCES Sample(sampleID) ON UPDATE CASCADE ON DELETE NO ACTION
    );