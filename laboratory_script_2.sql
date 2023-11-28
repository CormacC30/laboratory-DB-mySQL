USE Laboratory;

SELECT concat(fName, ' ', lName) as Name from Scientist
WHERE county IN ("Waterford", "Kilkenny", "Clare");

-- gives the name of suppliers who supply toxic and corrosive materials
SELECT supplierName from Supplier 
JOIN Material ON Supplier.supplierID = Material.supplierID
WHERE hazardClassification in ("Toxic", "Corrosive");

-- Return the laboratory instruments that have their next external PM due between now and the new year
SELECT instrumentName, equipmentID as "Tag No." FROM labInstruments
WHERE nextCalDate between CURDATE() AND "2024-01-01";

-- Return the names and phone numbers of Scientists who earn 60 grand or more a year
SELECT concat(fName, ' ', lName) as Name, phoneNumber from Scientist
where salary >= "60000";

-- Return number of reference standards from each supplier
SELECT count(lotNumber) as "number of Standards", supplierName as "Supplier" FROM ReferenceStandard
NATURAL JOIN Material NATURAL JOIN SUPPLIER
WHERE certOFAnalysis is NOT NULL GROUP BY supplierName;

-- return the number of different HPLC solvents supplied by each supplier
SELECT count(lotNumber) "As Number of HPLC Solvents", supplierName as "Supplier" FROM Solvent
NATURAL JOIN Material NATURAL JOIN Supplier
WHERE grade LIKE "%HPLC%" GROUP BY supplierName;

-- return the number of high purity reagent and the supplier
SELECT count(lotNumber) "As Number of High Purity Reagents", supplierName as "Supplier" FROM Reagent
NATURAL JOIN Material NATURAL JOIN Supplier
WHERE purity >= "99%" GROUP BY supplierName;

-- number of Scientist who are conducting HPLC
SELECT concat(fName, ' ', lName) as Name, count(labNoteBookID) as "HPLC Analyses" from Scientist 
NATURAL JOIN Analysis
NATURAL JOIN labInstruments
WHERE instrumentName LIKE "%HPLC%" GROUP BY lName, fName;

-- average amount of material used per analysis
SELECT ROUND(AVG(quantityUsed)) as "Average Quantity of material used per analysis" FROM Consumes;

-- average salary of a Scientist
SELECT ROUND(AVG(salary), 2) as "Average Salary" From Scientist;

-- Total quantity of materials in stock
SELECT SUM(quantityInStock) as "Total Materials" From Material;

-- counties from which there are more than one scientist
SELECT county, COUNT(employeeID) FROM Scientist
Group by county
having count(employeeID) > 1;

select * from labInstruments;

-- return the total number of analyses per scientsist who has analyses assigned to them
select concat(fName, ' ', lName) as Name, count(labNoteBookID) as "Number of Analyses" from Scientist
NATURAL JOIN Analysis
GROUP BY lName, fName;

-- return the scientists who have NO analyses assigned to them using outer left join
select concat(fName, ' ', lName) as 'Name', employeeID from Scientist
NATURAL LEFT JOIN Analysis WHERE labNoteBookID IS NULL ORDER BY fName, lName;

-- return overworked employees not being paid enough
select concat(fName, ' ', lName) as Name, count(labNoteBookID) as "Number of Analyses", salary from Scientist
NATURAL JOIN Analysis NATURAL JOIN labInstruments
WHERE salary < 60000 GROUP BY lName, fName, salary having count(labNoteBookID) > 20;

-- return under worked employees being paid too much
select concat(fName, ' ', lName) as Name, count(labNoteBookID) as "Number of Analyses", salary from Scientist
NATURAL JOIN Analysis NATURAL JOIN labInstruments
WHERE salary > 60000 GROUP BY lName, fName, salary having count(labNoteBookID) < 20;

-- Return the Scientist, employee IDs and product details and sample IDs of the matierals awaiting testing
SELECT concat(fName, ' ', lName) as Scientist, employeeID, productName, sampleID, batchNumber
FROM Scientist NATURAL JOIN Analysis NATURAL JOIN Tests NATURAL JOIN Sample
NATURAL JOIN Batch
WHERE progressStatus LIKE "Awaiting Testing" order by fName, lName;

-- Return the Scientist, employee IDs and number of products that they're still due to test
SELECT concat(fName, ' ', lName) as Scientist, employeeID, count(batchNumber) as "Number of products in test"
FROM Scientist NATURAL JOIN Analysis NATURAL JOIN Tests NATURAL JOIN Sample
NATURAL JOIN Batch
WHERE progressStatus LIKE "Awaiting Testing" 
group by fName, lName, employeeID order by employeeID;

-- return the numner of batches of tableted products
SELECT productName, count(BatchNumber) as "Number of Tablet Products" from
Batch NATURAL JOIN FinishedProduct WHERE presentation LIKE "%Tablet%" group by productName order by productName;

-- return the result ID batch number and sampleID of products which have been tested (to enable scientists to pull results data)
SELECT productName, resultID, batchNumber, sampleID 
FROM Batch NATURAL JOIN Sample NATURAL JOIN Tests
WHERE progressStatus LIKE "%Complete%" order by productName;

-- using subquery, returning the material name and lotNumber of the material with minimum quantity in stock
SELECT materialName, lotNumber From Material
WHERE quantityInStock = 
	(SELECT min(quantityInStock)
    FROM Material);
    
-- using subquery, returning the material name and lotNumber of the material with maximum quantity in stock
SELECT materialName, lotNumber From Material
WHERE quantityInStock = 
	(SELECT max(quantityInStock)
    FROM Material);

-- SUBQUERY to select just the material names of referenceStandards
SELECT materialName as Material FROM Material
WHERE lotNumber in
(SELECT lotNumber FROM referenceStandard);

-- SUBQUERY to select just the material names of referenceStandards
SELECT materialName as Material FROM Material
WHERE lotNumber in
(SELECT lotNumber FROM reagent);

-- SUBQUERY to select just the material names of referenceStandards
SELECT materialName as Material FROM Material
WHERE lotNumber in
(SELECT lotNumber FROM Solvent);

-- SubQuery to select the raw material names
SELECT productName as Product FROM Batch
WHERE batchNumber IN 
(SELECT batchNumber From RawMaterial);

-- SubQuery to select the finished product names
SELECT productName as Product FROM Batch
WHERE batchNumber IN 
(SELECT batchNumber From FinishedProduct);

-- subquery to return the materials for which the quantity in stock is less than the quantity used in an analysis
SELECT materialName, lotNumber, partNumber FROM Material
WHERE quantityInStock < ANY
	(SELECT quantityUsed
    FROM Consumes);
    
SELECT * from Scientist LEFT JOIN Analysis
ON Scientist.employeeID = Analysis.employeeID;

-- get the supervisors details
Select * from Scientist where supervisor IS NULL;

-- get the supervisors details
Select * from Scientist where supervisor IS NOT NULL;

-- return the number of samples per batch
SELECT productName as "Product Name", batchNumber, count(SampleID) FROM Batch
Natural Join Sample GROUP BY productName, batchNumber;

-- return the client companies without any active projects 
SELECT companyName as "Company Name", clientID FROM Client
NATURAL LEFT JOIN Batch where batchNumber IS NULL;

-- Find the scientist testing the viagra
SELECT concat(fName, ' ', lName) as "Scientist Name" FROM Scientist
NATURAL JOIN Analysis NATURAL JOIN Tests NATURAL JOIN Sample NATURAL JOIN Batch WHERE ProductName LIKE "Viagra";

-- Find the instruments being used in finished product testing
SELECT DISTINCT instrumentName, equipmentID FROM labInstruments
Natural JOIN Uses NATURAL JOIN Analysis NATURAL JOIN Tests NATURAL JOIN Sample NATURAL JOIN Batch
NATURAL RIGHT JOIN FinishedProduct ORDER BY instrumentName;

-- Find the instruments being used in raw material testing
SELECT DISTINCT instrumentName, equipmentID FROM labInstruments
Natural JOIN Uses NATURAL JOIN Analysis NATURAL JOIN Tests NATURAL JOIN Sample NATURAL JOIN Batch
NATURAL RIGHT JOIN RawMaterial ORDER BY instrumentName;

-- Find products, associated reference standards used for their analysis and the suppliers forthe reference standards
SELECT productName, Batch.batchNumber, ReferenceStandard.lotNumber AS "Reference Standard Lot Number", certOfAnalysis, supplierName
FROM Batch JOIN Client ON Batch.clientID = Client.clientID
JOIN FinishedProduct ON Batch.batchNumber = FinishedProduct.batchNumber
JOIN Sample ON Batch.batchNumber = Sample.batchNumber
JOIN Tests ON Sample.sampleID = Tests.sampleID
JOIN Analysis ON Tests.labNoteBookID = Analysis.labNoteBookID
JOIN Consumes ON Analysis.labNoteBookID = Consumes.labNoteBookID
JOIN ReferenceStandard ON Consumes.lotNumber = ReferenceStandard.lotNumber
JOIN Supplier ON ReferenceStandard.supplierID = Supplier.supplierID;

-- Find products, associated reagents used for their analysis and the suppliers forthe reagents
SELECT productName, Batch.batchNumber, Reagent.lotNumber AS "Reagent Lot Number", form, supplierName
FROM Batch JOIN Client ON Batch.clientID = Client.clientID
JOIN FinishedProduct ON Batch.batchNumber = FinishedProduct.batchNumber
JOIN Sample ON Batch.batchNumber = Sample.batchNumber
JOIN Tests ON Sample.sampleID = Tests.sampleID
JOIN Analysis ON Tests.labNoteBookID = Analysis.labNoteBookID
JOIN Consumes ON Analysis.labNoteBookID = Consumes.labNoteBookID
JOIN Reagent ON Consumes.lotNumber = Reagent.lotNumber
JOIN Supplier ON Reagent.supplierID = Supplier.supplierID;

-- Find products, associated solvents used for their analysis and the suppliers forthe reagents
SELECT productName, Batch.batchNumber, Solvent.lotNumber AS "Solvent Lot Number", grade, supplierName
FROM Batch JOIN Client ON Batch.clientID = Client.clientID
JOIN FinishedProduct ON Batch.batchNumber = FinishedProduct.batchNumber
JOIN Sample ON Batch.batchNumber = Sample.batchNumber
JOIN Tests ON Sample.sampleID = Tests.sampleID
JOIN Analysis ON Tests.labNoteBookID = Analysis.labNoteBookID
JOIN Consumes ON Analysis.labNoteBookID = Consumes.labNoteBookID
JOIN Solvent ON Consumes.lotNumber = Solvent.lotNumber
JOIN Supplier ON Solvent.supplierID = Supplier.supplierID;