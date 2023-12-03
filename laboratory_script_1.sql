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
	employeeID VARCHAR(8) NOT NULL,
    fName VARCHAR(40) NOT NULL,
    lName VARCHAR(40) NOT NULL,
    dateOfBirth DATE,
    street VARCHAR(50),
    town VARCHAR(50),
    county VARCHAR(50),
    eircode CHAR(8),
    phoneNumber VARCHAR(15),
    salary MEDIUMINT UNSIGNED,
    supervisor VARCHAR(8),
    PRIMARY KEY (employeeID),
    FOREIGN KEY (supervisor) REFERENCES Scientist(employeeID)
    );

-- -----------------------------------------------------
-- Create table Analysis
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Analysis(
	labNoteBookID CHAR(10) NOT NULL,
    analyticalMethod VARCHAR(30),
    specification VARCHAR(40),
    employeeID VARCHAR(8) NOT NULL,
    PRIMARY KEY (labNoteBookID),
    FOREIGN KEY (employeeID) REFERENCES Scientist(employeeID) 
    );
    
-- -----------------------------------------------------
-- Create table LabInstruments
-- NOTE: Additional attribute instrumentName is included here (not present in design document)
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS LabInstruments(
	equipmentID VARCHAR(10) NOT NULL,
    instrumentName VARCHAR(40) NOT NULL,
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
-- Create table Material
-- NOTE: Additional attribute materialName is included here (not present in design document)
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Material(
	lotNumber VARCHAR(20) NOT NULL,
    partNumber VARCHAR(20) NOT NULL,
    materialName VARCHAR(50),
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
-- Create table Reagent
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Reagent(
	lotNumber VARCHAR(20) NOT NULL,
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
    certOfAnalysis VARCHAR(20),
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
    processID VARCHAR(10),
    clientID VARCHAR(15),
	PRIMARY KEY (batchNumber),
    FOREIGN KEY (clientID) REFERENCES Client(clientID) ON UPDATE CASCADE ON DELETE NO ACTION
    );
    
-- -----------------------------------------------------
-- Create table FinishedProduct
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS FinishedProduct (
	batchNumber VARCHAR(20) NOT NULL, 
    presentation VARCHAR(20),
    clientID VARCHAR(15),
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
    dateCompleted DATE DEFAULT NULL,
    PRIMARY KEY (labNoteBooKID, sampleID),
    FOREIGN KEY (labNoteBookID) REFERENCES Analysis(LabNoteBookID) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (sampleID) REFERENCES Sample(sampleID) ON UPDATE CASCADE ON DELETE NO ACTION
    );
    
-- -----------------------------------------------------
-- POPULATE WITH RECORDS
-- -----------------------------------------------------    
INSERT INTO Scientist VALUES
('RS112233', 'Aisling', 'Gallagher', '1991-04-12', '43 Crescent Road', 'Ennis', 'Clare', 'V95 DEF3', '0446632552', '90000', NULL);

INSERT INTO Scientist VALUES
('CC182270', 'Conor', 'Fogarty', '1992-11-11', 'Loftus Square', 'Rathfarnham', 'Dublin 16', 'D16 FE82', '0879385399', '45000', 'RS112233'),
('AB123456', 'Aoife', 'Murphy', '1990-05-22', '45 Birch Street', 'Cork', 'Cork', 'T12 AB34', '0896665214','50000', 'RS112233'),
('DE789012', 'Liam', 'Doherty', '1988-12-10', '78 Oak Road', 'Galway', 'Galway', 'H91 CD56', '0215578585','55000',  'RS112233'),
('FG345678', 'Siobhan', 'Kavanagh', '1992-03-18', '34 Elm Terrace', 'Limerick', 'Limerick', 'V94 EF89', '0874445852', '60000', 'RS112233'),
('HI901234', 'Ciaran', 'Fitzpatrick', '1986-09-03', '56 Pine Street', 'Waterford', 'Waterford', 'X91 JK45', '0563259788', '65000', 'RS112233'),
('JK567890', 'Niamh', 'O\'Sullivan', '1994-11-20', '89 Green Lane', 'Belfast', 'Antrim', 'BT1 2XY', '0862254731', '70000',  'RS112233'),
('LM112233', 'Eoin', 'Walsh', '1989-02-15', '23 Meadow Drive', 'Derry', 'Derry', 'BT48 6AB', '0212258447', '75000', 'RS112233'),
('NO445566', 'Fiona', 'Doyle', '1993-06-01', '67 Main Street', 'Kilkenny', 'Kilkenny', 'R95 XYZ1', '0861136452', '80000', 'RS112233'),
('PQ778899', 'Padraig', 'Ryan', '1987-08-28', '101 Hillside Avenue', 'Sligo', 'Sligo', 'F91 ABC2', '0853369655', '85000', 'RS112233');

INSERT INTO Scientist VALUES
('CE992240', 'Chloe', 'Brennan', '1996-08-16', 'Glendine Heights', 'Castlecomer Road', 'Kilkenny', 'R95 U9OL', '0839385459', '30000', 'BL339333');

INSERT INTO Analysis VALUES
('AN001', 'Impurities', 'NGT 0.1%', 'CC182270'),
('AN002', 'Water Content', 'NGT 5%', 'AB123456'),
('AN003', 'Heavy Metals Content', 'NGT 10 ppm', 'PQ778899'),
('AN004', 'Identity', 'Meets Standard Peaks', 'NO445566'),
('AN005', 'Assay', '99-101%','FG345678'),
('AN006', 'Impurity Profile', '<0.5%', 'DE789012'),
('AN007', 'Crystal Structure', 'Identical to Standard', 'NO445566'),
('AN008', 'Structural Conformation', 'Matches Reference Spectrum', 'CC182270'),
('AN009', 'Acid Content', '0.5-1.5%', 'CC182270'),
('AN010', 'Residual Solvents', '<0.1%', 'FG345678');

INSERT INTO LabInstruments VALUES
('LC-MS001', 'LC-Mass Spectrometer', '2023-12-01'),
('GC-MS002', 'Gas Chromatograph', '2023-11-15'),
('FTIR003', 'FTIR', '2023-12-05'),
('UV004', 'Ultraviolet Spectrophotometer', '2023-11-20'),
('NMR005', 'NMR', '2023-12-10'),
('HPLC006', 'HPLC', '2023-11-25'),
('GC007', 'Gas Chromatograph', '2023-12-15'),
('TI008', 'Auto Titrator', '2023-11-30'),
('ICP-OES009', 'ICP-OES', '2023-12-20'),
('XRD010', 'X-ray Diffractometer', '2023-11-10'),
('UV011', 'Ultraviolet Spectrophotometer', '2023-12-02'),
('BAL001', 'Analytical Balance', '2024-04-05'),
('BAL002', 'Analytical Balance', '2024-04-05'),
('PH001', 'pH Meter', '2023-11-26'),
('HPLC012', 'HPLC', '2023-11-18');

INSERT INTO Uses VALUES
('LC-MS001', 'AN001', '2023-11-01 08:30:00'),
('GC-MS002', 'AN002', '2023-11-02 09:45:00'),
('FTIR003', 'AN003', '2023-11-03 11:15:00'),
('UV004', 'AN004', '2023-11-04 13:30:00'),
('NMR005', 'AN005', '2023-11-05 15:45:00'),
('HPLC006', 'AN006', '2023-11-06 08:30:00'),
('GC007', 'AN007', '2023-11-07 09:45:00'),
('TI008', 'AN008', '2023-11-08 11:15:00'),
('ICP-OES009', 'AN009', '2023-11-09 13:30:00'),
('XRD010', 'AN010', '2023-11-10 15:45:00'),
('BAL001', 'AN001', '2023-11-01 08:35:00'),
('BAL002', 'AN002', '2023-11-02 09:50:00'),
('PH001', 'AN003', '2023-11-03 11:20:00'),
('BAL001', 'AN004', '2023-11-04 13:35:00'),
('BAL002', 'AN005', '2023-11-05 15:50:00'),
('PH001', 'AN006', '2023-11-06 08:35:00'),
('BAL001', 'AN007', '2023-11-07 09:50:00'),
('BAL002', 'AN008', '2023-11-08 11:20:00'),
('PH001', 'AN009', '2023-11-09 13:35:00'),
('BAL001', 'AN010', '2023-11-10 15:50:00');

INSERT INTO Supplier VALUES
('MERCK001', 'Merck', 'Hauptstraße 123', 'Heidelberg', 'Germany', '69115', '+49 123 4567890', 'mike@merck.com'),
('SIGMA001', 'Sigma-Aldrich', 'Science Avenue 456', 'Cambridge', 'USA', '02138', '+1 987-654-3210', 'paul@sigma.com'),
('TCI002', 'TCI', 'Experiment Road 789', 'Tokyo', 'Japan', '100-0004', '+81 456-789-0123', 'kate@tci.com'),
('FISHER003', 'Fisher Scientific', 'Lab Lane 101', 'London', 'United Kingdom', 'SW1A 1AA', '+44 7890 123456', 'holly@fishersci.com'),
('LGC004', 'LGC', 'Rue Du Lab 21', 'Paris', 'France', '75001', '+33 12-345-6789', 'xavier@lgc.com');

INSERT INTO Material VALUES
('ABC123', 'RP12345', 'Acetone', 100, 'Cool and Dry', '2025-12-01', 'Non-Hazardous', 98.5, 'MERCK001'),        -- Reagent
('XYZ456', 'LP67890', 'Methanol', 50, 'Room Temperature', '2022-11-15', 'Flammable', 99.8, 'SIGMA001'),         -- Solvent
('123DEF', 'RS78901', 'Phenazone Impurity A', 30, 'Cold Storage', '2025-12-05', 'Corrosive', 99.9, 'TCI002'),             -- Reference Standard
('789GHI', 'RP23456', 'Ethanol', 75, 'Cool and Dry', '2023-11-20', 'Irritant', 97.5, 'FISHER003'),            -- Reagent
('456JKL', 'LP34567', 'Water', 40, 'Room Temperature', '2023-12-10', 'Non-Hazardous', 98.0, 'LGC004'),         -- Solvent
('789MNO', 'RS45678', 'Paracetamol', 25, 'Cold Storage', '2026-11-25', 'Corrosive', 99.5, 'MERCK001'),          -- 			Reference Standard
('XYZABC', 'RP56789', 'Methanol', 90, 'Cool and Dry', '2025-12-15', 'Flammable', 98.7, 'SIGMA001'),          -- Reagent
('123GHI', 'LP67890', 'Acetone', 60, 'Room Temperature', '2023-11-30', 'Non-Hazardous', 99.2, 'TCI002'),       -- Solvent
('789JKL', 'RS78901', 'Paracetamol Impurity Test Mix', 35, 'Cold Storage', '2024-12-20', 'Corrosive', 99.8, 'FISHER003'),       -- Reference Standard
('456MNO', 'AN12345', 'Acetonitrile', 80, 'Cool and Dry', '2027-09-01', 'Flammable', 99.5, 'MERCK001'),       -- Solvent
('789PQR', 'HA67890', 'Hydrochloric Acid', 25, 'Ventilated Area', '2027-06-15', 'Corrosive', 36.0, 'SIGMA001'),-- Reagent
('ABCXYZ', 'SA12345', 'Sulfuric Acid', 40, 'Cool and Dry', '2027-08-10', 'Corrosive', 98.0, 'TCI002'),        -- Reagent
('GALL42', 'HE56789', 'Helium', 60, 'Compressed Gas', '2029-11-30', 'Non-Flammable', NULL, 'FISHER003'),     -- Gas reagent
('ARSEN1', 'GA23456', 'Gallium Arsenide', 20, 'Cold Storage', '2029-07-20', 'Toxic', NULL, 'LGC004'),        -- Semiconductor reference standard
('SODIUM1', 'CH34567', 'Sodium Chloride', 50, 'Room Temperature', '2028-10-05', 'Non-Hazardous', 99.9, 'MERCK001'), -- Salt reagent
('AMMO1', 'AH56789', 'Ammonium Hydroxide', 30, 'Cool and Dry', '2028-12-15', 'Corrosive', 25.0, 'SIGMA001'),-- Reagent
('NITR06', 'NN558', 'Nitric Acid', 5, 'Ventilated Area', '2028-12-15', 'Corrosive', '75.4', 'MERCK001'); -- reagent 

-- Populating the ReferenceStandard table
INSERT INTO ReferenceStandard (lotNumber, certOfAnalysis, supplierID)
SELECT lotNumber, 'COA12345', supplierID
FROM Material
WHERE lotNumber IN ('123DEF');

INSERT INTO ReferenceStandard (lotNumber, certOfAnalysis, supplierID)
SELECT lotNumber, 'COA65654', supplierID
FROM Material
WHERE lotNumber IN ('789MNO');

INSERT INTO ReferenceStandard (lotNumber, certOfAnalysis, supplierID)
SELECT lotNumber, 'COA11256', supplierID
FROM Material
WHERE lotNumber IN ('789JKL');

INSERT INTO ReferenceStandard (lotNumber, certOfAnalysis, supplierID)
SELECT lotNumber, 'COA75511', supplierID
FROM Material
WHERE lotNumber IN ('ARSEN1');

-- Populating the Solvent table
INSERT INTO Solvent (lotNumber, grade, supplierID)
SELECT lotNumber, 'HPLC Grade', supplierID
FROM Material
WHERE lotNumber IN ('XYZ456', '456JKL', '456MNO');

INSERT INTO Solvent (lotNumber, grade, supplierID)
SELECT lotNumber, 'GC Grade', supplierID
FROM Material
WHERE lotNumber IN ('123GHI');

-- Populating the Reagent table
INSERT INTO Reagent (lotNumber, form, supplierID)
SELECT lotNumber, 'Liquid', supplierID
FROM Material
WHERE lotNumber IN ('ABC123', '789GHI', 'XYZABC', 'NITR06', '789PQR', 'ABCXYZ');

INSERT INTO Reagent (lotNumber, form, supplierID)
SELECT lotNumber, 'Gas', supplierID
FROM Material
WHERE lotNumber IN ('GALL42');

INSERT INTO Reagent (lotNumber, form, supplierID)
SELECT lotNumber, 'Solid', supplierID
FROM Material
WHERE lotNumber IN ('SODIUM1', 'AMM01');

-- Populating the Consumes table
INSERT INTO Consumes (labNoteBookID, lotNumber, quantityUsed)
VALUES
('AN001', 'ABC123', 10),
('AN001', 'XYZ456', 5),
('AN002', '789GHI', 8),
('AN002', '456JKL', 3),
('AN003', '123DEF', 15),
('AN003', '789MNO', 12),
('AN004', 'XYZABC', 6),
('AN005', '789PQR', 7),
('AN006', 'ABCXYZ', 9),
('AN006', '123GHI', 4),
('AN007', '789JKL', 11),
('AN008', '456MNO', 14),
('AN009', '789PQR', 10),
('AN010', 'ABCXYZ', 5),
('AN010', 'XYZABC', 3);

-- Populating the Client table with records
INSERT INTO Client (clientID, companyName, street, city, country, postCode)
VALUES
('PFI001', 'Pfizer', 'Grange Castle', 'Dublin 14', 'Ireland', 'D14 OP13'),
('PFI002', 'PFizer', 'Ringaskiddy', 'Cork', 'Ireland', 'T15 LLCJ'),
('TAK454', 'Takeda', '101 Coast Road', 'Bray', 'Ireland', 'G12 PL14'),
('TF010' , 'Thermo Fisher', 'Ringaskiddy', 'Cork', 'Ireland', 'T11 P0LI'),
('AGRI002', 'Nature\'s Harvest Farms', '234 Marino Road', 'Bantry', 'Ireland', 'P78 I99R'),
('GSK502', 'GlaxoSmithKline', '10 Oak Avenue', 'Stevenage', 'United Kingdom', 'OKP 9O1');

INSERT INTO CLIENT (clientID, companyName, street, city, country, postCode) VALUES
('ABB001', 'AbbVie', 'Carrigtohill', 'Cork', 'Ireland', 'T45 OL8I'),
('AMG050', 'AMGEN', 'Dun Laoighre', 'Dublin', 'Ireland', 'D14 UP23');

-- Populating the ClientPhones table with sample data
INSERT INTO ClientPhones (contactNumber, clientID)
VALUES
('0871234567', 'PFI001'),
('013366522','PFI001'),
('0869876543', 'PFI001'),
('0835551122', 'PFI002'),
('012551122', 'PFI002'),
('0898887766', 'TAK454'),
('0854433221', 'TF010'),
('0866543210', 'AGRI002'),
('7747778889', 'GSK502'),
('7747711119', 'GSK502');

-- Populating the Batch table Finished products only
INSERT INTO Batch (batchNumber, productName, dateOfManufacture, clientID)
VALUES
('B12346', 'Viagra', '2023-10-18', 'PFI001'),
('B67891', 'Temivir Antiviral', '2023-09-30', 'PFI002'),
('B45455', 'Amoxicillin', '2023-11-05', 'TAK454'),
('B01011', 'Thermo Fisher RNA Test Kit', '2023-10-08', 'TF010'),
('B20203', 'MultiVitamins', '2023-11-12', 'AGRI002'),
('B50203', 'Lemonivir', '2023-09-18', 'GSK502'),
('B12347', 'Enbrel', '2023-10-21', 'PFI001'),
('B67892', 'Paracetamol', '2023-10-02', 'PFI002'),
('B45456', 'Haemorrhoid Cream', '2023-11-08', 'TAK454'),
('B01012', 'In Vitro Diagnostic Kit', '2023-10-12', 'TF010'),
('B20204', 'Nature\'s Harvest Minerals', '2023-11-15', 'AGRI002'),
('B50204', 'Penicillin', '2023-09-21', 'GSK502');

-- Populating the batch table with raw materials

INSERT INTO Batch (batchNumber, productName, dateOfManufacture, clientID)
VALUES
('B78901', 'N-Bromosuccinimide', '2023-11-25', 'PFI001'),
('B34567', '3-Azido-1-propanamine', '2023-12-01', 'PFI002'),
('B89012', 'p-Toluenesulfonyl chloride', '2023-12-05', 'TAK454'),
('B56789', 'Lithium aluminium hydride', '2023-12-10', 'TF010'),
('B12378', 'Ascorbic Acid', '2023-12-15', 'AGRI002'),
('B23456', 'Thionyl Chloride', '2023-12-20', 'GSK502');

-- Populating the RawMaterial table
INSERT INTO RawMaterial (batchNumber, processID, clientID)
VALUES
('B78901', 'PR123', 'PFI001'),
('B34567', 'PR456', 'PFI002'),
('B89012', 'PR789', 'TAK454'),
('B56789', 'PR012', 'TF010'),
('B12378', 'PR345', 'AGRI002'),
('B23456', 'PR678', 'GSK502');

-- Populating the FinishedProduct table
INSERT INTO FinishedProduct (batchNumber, presentation, clientID)
VALUES
('B12346', 'Tablet', 'PFI001'),
('B67891', 'Capsule', 'PFI002'),
('B45455', 'Capsule', 'TAK454'),
('B01011', 'Kit', 'TF010'),
('B20203', 'Tablet', 'AGRI002'),
('B50203', 'Cream', 'GSK502'),
('B12347', 'Injection', 'PFI001'),
('B67892', 'Tablet', 'PFI002'),
('B45456', 'Cream', 'TAK454'),
('B01012', 'Kit', 'TF010'),
('B20204', 'Tablet', 'AGRI002'),
('B50204', 'Injection', 'GSK502');

-- Populating the Sample table
INSERT INTO Sample (sampleID, storageCondition, expiryDate, progressStatus, batchNumber)
VALUES
('SMP001', '2-8°C', '2024-01-31', 'Completed', 'B12346'),
('SMP002', 'Ambient', '2023-12-20', 'Awaiting Testing', 'B67891'),
('SMP003', 'Room Temperature', '2023-12-15', 'Awaiting Testing', 'B45455'),
('SMP004', '2-8°C', '2024-02-28', 'In Progress', 'B01011'),
('SMP005', 'Ambient', '2023-12-25', 'Completed', 'B20203'),
('SMP006', 'Room Temperature', '2023-12-30', 'Awaiting Testing', 'B50203'),
('SMP007', '2-8°C', '2024-01-15', 'In Progress', 'B12347'),
('SMP008', 'Ambient', '2023-12-22', 'Completed', 'B67892'),
('SMP009', 'Room Temperature', '2023-12-18', 'Awaiting Testing', 'B45456'),
('SMP010', '2-8°C', '2024-03-05', 'Completed', 'B01012'),
('SMP011', 'Ambient', '2023-12-28', 'Awaiting Testing', 'B20204'),
('SMP012', 'Room Temperature', '2024-01-10', 'Awaiting Testing', 'B50204'),
('SMP013', '2-8°C', '2024-01-25', 'In Progress', 'B78901'),
('SMP014', 'Ambient', '2024-02-01', 'Completed', 'B34567'),
('SMP015', 'Room Temperature', '2024-02-05', 'Awaiting Testing', 'B89012'),
('SMP016', '2-8°C', '2024-02-10', 'In Progress', 'B56789'),
('SMP017', 'Ambient', '2024-02-15', 'Awaiting Testing', 'B12378'),
('SMP018', 'Room Temperature', '2024-02-20', 'Awaiting Testing', 'B23456');

-- Populating the Tests table
INSERT INTO Tests (labNoteBookID, sampleID, resultID, dateCompleted)
VALUES
('AN001', 'SMP001', 'R001', '2022-06-15'),
('AN002', 'SMP002', 'R002', NULL),
('AN003', 'SMP003', 'R003', NULL),
('AN004', 'SMP004', 'R004', NULL),
('AN005', 'SMP005', 'R005', '2022-11-28'),
('AN006', 'SMP006', 'R006', NULL),
('AN007', 'SMP007', 'R007', NULL),
('AN008', 'SMP008', 'R008', '2023-02-28'),
('AN009', 'SMP009', 'R009', NULL),
('AN010', 'SMP010', 'R010', '2023-04-10'),
('AN001', 'SMP011', 'R011', NULL),
('AN002', 'SMP012', 'R012', NULL),
('AN003', 'SMP013', 'R013', NULL),
('AN004', 'SMP014', 'R014', '2023-08-05'),
('AN005', 'SMP015', 'R015', NULL),
('AN006', 'SMP016', 'R016', NULL),
('AN007', 'SMP017', 'R017', NULL),
('AN008', 'SMP018', 'R018', NULL);


-- Creating Indexes

CREATE INDEX analysisType
ON Analysis (analyticalMethod);

CREATE INDEX product
ON Batch (productName);

CREATE INDEX supplName
ON Supplier (supplierName);

CREATE INDEX clientind
ON Client (companyName);

CREATE INDEX materialind
ON Material (materialName);

-- created an audit trail table to log any changes that are made to analysis, essential for lab data integrity and regulatory inspections.. 
CREATE TABLE auditTrail(
	id INT AUTO_INCREMENT PRIMARY KEY,
    labNotebookID CHAR(10),
    analyticalMethod VARCHAR(30),
    changeDate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
    );

-- CREATING TRIGGERS

-- - This is a trigger which will auto-update the audit trail
   
DELIMITER $$
CREATE TRIGGER before_analysis_update
	BEFORE UPDATE ON Analysis
    FOR EACH ROW
BEGIN
	INSERT INTO auditTrail
    SET action = 'update',
		labNoteBookID = OLD.labNoteBookID,
        analyticalMethod = OLD.analyticalMethod,
        changeDate = NOW();
END $$
DELIMITER ;


-- This trigger will automatically set the next Calibration date in the lab instruments table every time a new record is added to the uses table.
-- The default next calibration date is set to 6 months

DELIMITER $$
CREATE TRIGGER updateCalDate
BEFORE INSERT ON labInstruments
FOR EACH ROW
BEGIN
    IF DATEDIFF(CURDATE(), NEW.nextCalDate) < 180 THEN 
        SET NEW.nextCalDate = DATE_ADD(CURDATE(), INTERVAL 6 MONTH);
    END IF;
END; 
$$
DELIMITER ;

-- Trigger which prevents the deletion of a client if there are batches associated with it
DELIMITER $$
CREATE TRIGGER restrictClientDeletion
BEFORE DELETE ON Client
FOR EACH ROW
BEGIN
    DECLARE batchCount INT;

    SELECT COUNT(*)
    INTO batchCount
    FROM Batch
    WHERE clientID = OLD.clientID;

    IF batchCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete client with associated batches';
    END IF;
END;
$$
DELIMITER ;

-- Create a trigger that updates the material quantity in stock every time consumes table is updated

DELIMITER $$
CREATE TRIGGER updateStock
BEFORE INSERT ON Consumes
FOR EACH ROW
BEGIN
   
    UPDATE Material
    SET quantityInStock = quantityInStock - NEW.quantityUsed
    WHERE lotNumber = NEW.lotNumber;

END;
$$
DELIMITER ;

-- Trigger which updates the date completed to current date when the progress status of a sample is changed to completed.
DELIMITER $$ 
CREATE TRIGGER updateCompleteDate
AFTER UPDATE ON Sample
FOR EACH ROW
BEGIN
	IF NEW.progressStatus = 'Completed' THEN
		UPDATE Tests
		SET dateCompleted = CURDATE()
		WHERE sampleID = OLD.SampleID;
    END IF;
END;
$$
DELIMITER ;

/* 
		CREATING VIEWS
*/
        
-- this view gives the equipment currently in use for testing in progress
CREATE OR REPLACE VIEW labInstAnalysis AS
	SELECT equipmentID, instrumentName, COUNT(equipmentID) AS 'Number of current tests'
    FROM LabInstruments NATURAL JOIN Uses 
    NATURAL JOIN Analysis
    NATURAL JOIN Tests
    NATURAL JOIN Sample
    WHERE progressStatus LIKE "In Progress"
    GROUP BY equipmentID;

-- creates a view that allows users to view the lab instruments which are due to be calibrated in the next month, to in order to contact an engineer for scheduled maintenance
CREATE OR REPLACE VIEW urgentCal AS
	SELECT instrumentName, equipmentID
    FROM LabInstruments 
    WHERE DATEDIFF(nextCalDate, CURDATE()) < 30;
  
-- creates a view that allows the user to see all the materials with expiry dates closer than two weeks - to notify them to replace thme
CREATE OR REPLACE VIEW replaceMaterial AS
	SELECT lotNumber, materialName 
    FROM Material
    WHERE DATEDIFF(expiryDate, CURDATE()) < 14;
    
-- Creates a view to allow a user to get contact details of the suppliers of materials which are reaching their expiry soon (2 weeks), as well as deltails of these materials
CREATE OR REPLACE VIEW contactSupplier AS
	SELECT supplierName, supplierPhones, email, materialName, partNumber
    FROM Supplier NATURAL JOIN Material
    WHERE DATEDIFF(expiryDate, CURDATE()) < 14;
    
-- Creates a view to allow a user to get contact details of the suppliers for materials of which stock quantities are running low, as well as deltails of these materials
CREATE OR REPLACE VIEW contactStock AS
	SELECT supplierName, supplierPhones, email, materialName, partNumber
    FROM Supplier NATURAL JOIN Material
    WHERE quantityInStock <= 5;
    
-- creates a view that allwos a user to see all expired materials.
CREATE OR REPLACE VIEW expiredMaterial AS
	SELECT lotNumber, materialName 
    FROM Material
    WHERE DATEDIFF(expiryDate, CURDATE()) < 0;
    
-- this view shows batches in progress
CREATE OR REPLACE VIEW productInTesting AS  
	SELECT productName, batchNumber, sampleID FROM Batch
    NATURAL JOIN Sample
    WHERE progressStatus LIKE "In Progress";
    
select * from urgentCal;
select * from LabInstruments;
select * from labInstAnalysis;
select * from replaceMaterial;
select * from expiredMaterial;
select * from productInTesting;
select * from contactSupplier;
select * from contactStock;

DROP USER IF EXISTS Scientist;
DROP USER IF EXISTS LabSupervisor;
DROP USER IF EXISTS LabDirector;
CREATE USER IF NOT EXISTS Scientist identified by 'science';
CREATE USER IF NOT EXISTS LabSupervisor identified by 'science';
CREATE USER IF NOT EXISTS LabDirector identified by 'director';

-- Scientist cannot have access to deleting any records of samples, analysis, clients etc.. they are just generating the results

GRANT INSERT(labnotebookID), UPDATE(labnotebookID), SELECT(labnotebookID) ON analysis to Scientist;
grant insert, select on sample to Scientist;
grant select on laboratory.* to Scientist;
grant update(progressStatus) on sample to Scientist;
grant insert, update on consumes to Scientist;
grant insert, update(labNoteBookID, dateCompleted, sampleID) on tests to Scientist;
grant insert, update on Material to Scientist;
grant insert, update on batch to Scientist;
grant insert, update on Uses to Scientist;
grant insert, update on Reagent to Scientist;
grant insert, update on Solvent to Scientist;
grant insert, update on ReferenceStandard to Scientist;

-- Privileges for the lab supervisor
-- supervisor should still not be able to delete some data such as results, or analysis lab notebooks for data integrity reasons
grant select, insert, update on laboratory.* to LabSupervisor;
grant delete on Batch to LabSupervisor;
grant delete on RawMaterial to LabSupervisor;
grant delete on FinishedProduct to LabSupervisor;
grant delete on Sample to LabSupervisor;
grant delete on Uses to LabSupervisor; -- may need to delete here in case a scientist makes a dog's dinner of filling out the analysis data
grant delete on Consumes to LabSupervisor;
grant delete on labInstruments to LabSupervisor;
grant delete on Material to LabSupervisor;
grant delete on Supplier to LabSupervisor;
grant delete on clientPhones to LabSupervisor;
grant delete on Reagent to LabSupervisor;
grant delete on Solvent to LabSupervisor;
grant delete on ReferenceStandard to LabSupervisor;
grant select on auditTrail to LabSupervisor; -- Nobody should be able to delete the audit trail, not even the supervisor or director. not accessible by regular staff

/* 
Privileges for the lab Director
director should be able to make high level business decisions, 
i.e. firing staff, deleting clients, and choosing who to grant privileges to 
*/
grant all on laboratory.* to LabDirector WITH GRANT OPTION; 

show grants for Scientist;
show grants for LabSupervisor;
show grants for LabDirector;


