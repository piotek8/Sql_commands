
--- zad 1 
SELECT TOP 8 DepartmentID AS "Numer_Departamentu", "Name" AS "Nazwa Departamentu"
FROM HumanResources.Department ;
okokokok

--- zad 2
SELECT Address ID, AddressLine1 + ", " + City + " " + PostalCode AS Adres  
FROM Person.Address;

--- zad 3 
SELECT *
FROM HumanResources.EmployeeDepartmentHistory
WHERE BusinessEntityID >= 200 AND (DepartmentID = 4 or DepartmentID = 6);

--- zad 4 
SELECT BusinessEntityID, Rate, RateChangeDate
FROM HumanResources.EmployeePayHistory
WHERE Rate BETWEEN 60 AND 100 AND RateChangeDate >= '20090101' ;

--- zad 5
SELECT TOP 1 LocationID,Name,CostRate
FROM Production.Location	
ORDER BY 3 DESC ;

--- zad 6
SELECT BusinessEntityID, RateChangeDate,
CAST( RateChangeDate AS DATE ) AS "Data zmiany",
Rate,
STR (Rate,7,3) AS "Sformatowana stawka"
FROM  HumanResources.EmployeePayHistory;

--- zad 7
SELECT Name, ProductNumber,ListPrice,ISNULL(Color,'No color') AS Color
FROM Production.Product 
WHERE ListPrice BETWEEN 100 AND 200 
ORDER BY ListPrice ASC;

--- zad 8
SELECT  SalesYTD,
		ROUND(SalesYTD,2) AS " ori (2 miejsca po przecinku)",
		FLOOR(SalesYTD) AS "Zaokr¹gla nie zwracaj¹c uwagi na wartoœci po przecinku",
		ROUND(SalesYTD,0) AS "Zwraca uwage na wartoœci po przecinku",
/*git*/	ROUND(SalesYTD,0,1),
/*git*/	STR(SalesYTD /1000000,5,2) + 'mln' 	  
FROM Sales.SalesPerson ;

--- zad 9
SELECT  MAX ( SalesQuota ) AS "Maksymalna wartoœæ z kolumny SalesQuota",
    	AVG( SalesQuota ) AS "Œrednia wartoœæ z kolumny SalesQuota (B£ÊDNA)",
		AVG(ISNULL( SalesQuota, 0 ))  AS "Œrednia wartoœæ z kolumny SalesQuota (PRAWID£OWA)"
FROM Sales.SalesPerson;

--- zad 10
SELECT MaritalStatus, Gender,
SUM(VacationHours - SickLeaveHours) AS "Róznice" 
FROM HumanResources.Employee
GROUP BY MaritalStatus, Gender ; 

--- zad 11
SELECT BusinessEntityID,JobTitle,
     CASE WHEN OrganizationLevel IS NULL THEN 'Szef wszystkich szefów'
	 WHEN OrganizationLevel < 3 THEN  'Wizeprezesi i managerowie'
	 ELSE 'Pracownicy'
	 END AS "Status"
FROM HumanResources.Employee
ORDER BY OrganizationLevel ASC;

--- zad 12
SELECT Name,
LOWER (left(Name,1)) + UPPER (right(Name,1)) AS "Alias",
CASE WHEN CHARINDEX(' ', Name) = 0 then Name
ELSE right ( Name, CHARINDEX ( ' ', REVERSE(Name))-1)
END AS "Ostatnie s³owo"
FROM Person.CountryRegion;

--- zad 13
SELECT BusinessEntityID, StartDate, 
	DATEDIFF (Year,StartDate,CAST (GETDATE() AS DATE)),
	CASE WHEN MONTH(GETDATE())>=MONTH(StartDate) THEN
	'Pracownik o numerze '+ CAST (BusinessEntityID AS varchar) + ' zacz¹³ pracê' +
	CAST(DATEDIFF(Year,StartDate,GETDATE()) AS varchar) + 'lat i ' +
	CAST(DATEDIFF(Month,StartDate,GETDATE()) % 12 AS varchar) + 'miesiêcy temu'
ELSE
	'Pracownik o numerze '+ CAST (BusinessEntityID AS varchar) + ' zacz¹³ pracê' +
	CAST(DATEDIFF(Year,StartDate,GETDATE()) -1 AS varchar) + 'lat i ' +
	CAST(DATEDIFF(Month,StartDate,GETDATE()) % 12 AS varchar) + 'miesiêcy temu'
	END	AS  "Praca "
FROM HumanResources.EmployeeDepartmentHistory;

-- MY BETTER VERSION --
SELECT BusinessEntityID, StartDate, 
	'Pracownik o numerze '+ CAST (BusinessEntityID AS varchar) + ' zacz¹³ pracê' +
	CAST(DATEDIFF(Year,StartDate,GETDATE()) AS varchar) + 'lat i ' +
	CAST(DATEDIFF(Month,StartDate,GETDATE()) % 12 AS varchar) + 'miesiêcy temu'
	AS  "Praca "
FROM HumanResources.EmployeeDepartmentHistory;

--- zad 14
SELECT B.BusinessEntityID, T.Name, A.AddressLine1, A.PostalCode, A.City
FROM Person.BusinessEntityaddress AS B 
INNER JOIN Person.Address AS A ON B.AddressID=A.AddressID
INNER JOIN Person.AddressType AS T ON B.AddressTypeID=T.AddressTypeID;


-- MY BETTER VERSION --
SELECT  BusinessEntityID, Name, AddressLine1, PostalCode, City	
FROM Person.Address AS PA
INNER JOIN Person.BusinessEntityAddress AS PBEA ON  PA.AddressID=PBEA.AddressID
INNER JOIN Person.AddressType AS PAT ON PBEA.AddressTypeID=PAT.AddressTypeID;

--- zad 15
SELECT J.JobCandidateID,E.*
FROM HumanResources.Employee AS E
right join HumanResources.JobCandidate AS J ON E.BusinessEntityID=J.BusinessEntityID
ORDER BY E.BusinessEntityID DESC;

-- MY BETTER VERSION --
SELECT JC.JobCandidateID, E. *
FROM   HumanResources.Employee AS E
RIGHT JOIN HumanResources.JobCandidate AS JC  ON E.BusinessEntityID=JC.BusinessEntityID
ORDER BY E.BusinessEntityID DESC;

--- zad 16
SELECT ProductID, Name, ProductNumber, Color, SafetyStockLevel
FROM Production.Product

WHERE Color = (SELECT Color
			FROM Production.Product			
			WHERE ProductNumber = 'FL-2301' )
AND	SafetyStockLevel >=  (SELECT SafetyStockLevel
			FROM Production.Product
			WHERE Name = 'Chain');

-- MY (NOT)BETTER VERSION --
SELECT ProductID, Name, ProductNumber, Color, SafetyStockLevel
FROM Production.Product

WHERE Color = (SELECT *
			FROM Production.Product			
			WHERE ProductNumber = 'FL-2301' )
AND	SafetyStockLevel >=  (SELECT *
			FROM Production.Product
			WHERE Name = 'Chain');

--- zad 17
SELECT ProductID, Name, ProductNumber, Color, SafetyStockLevel
FROM Production.Product

WHERE Color IN (SELECT Color
			FROM Production.Product			
			WHERE ProductNumber LIKE 'C%' )
AND	SafetyStockLevel <= ALL (SELECT SafetyStockLevel
			FROM Production.Product
			WHERE ProductID > 900 );

--- zad 18			
ALTER TABLE Person.Person
DROP COLUMN Title;

--- zad 19	
INSERT INTO HumanResources.Department  (Name, GroupName )
 VALUES ('Ochrona' , 'Ludzie pilnuj¹cy porz¹dku');


--- zad 20	
UPDATE HumanResources.Parents
SET FirstName = 'Andrzej', LastName ='Nowak'
WHERE FirstName = 'Jo' AND LastName = 'Brown';

select*
from humanresources.Parents

--- zad 21
SELECT FirstName, LastName 
FROM HumanResources.Parents
INTERSECT 
SELECT FirstName, LastName 
from Person.Person ;

--- zad 22
WITH AdresyLudzi AS (
SELECT PP.FirstName	, PP.LastName , A.City
FROM Person.Person AS PP
LEFT JOIN Person.BusinessEntityAddress AS BEA
ON PP.BusinessEntityID = BEA.BusinessEntityID
LEFT JOIN Person.Address AS A
ON BEA.AddressID = A.AddressID)

SELECT *
FROM AdresyLudzi
WHERE City IS  NULL; 

--- zad 23
DECLARE @NowyWiek INT = 3
DECLARE @NowaData DATE = DATEADD(YEAR,-@NowyWiek, GETDATE()) 

UPDATE HumanResources.Dzieciaczki
SET	Aktualny_Wiek = @NowyWiek, Data_urodzenia = @NowaData
WHERE Imie = 'Adas';
 
 SELECT *
 FROM HumanResources.Dzieciaczki;


--- zad 24
SELECT Name, ProductNumber, ListPrice,
DENSE_RANK() OVER (ORDER BY ListPrice DESC) AS "Najwy¿sze wartoœci"
FROM Production.Product
WHERE ListPrice > 0	;

------------------------ Stworzenie klucza ------------------------
ALTER TABLE HumanResources.Parents
ALTER COLUMN  BusinessEntityID INT not null;

ALTER TABLE HumanResources.Parents
ADD CONSTRAINT BusinessEntityID_KEY PRIMARY KEY (BusinessEntityID);

ALTER TABLE HumanResources.Parents
ADD UNIQUE(BusinessEntityID);

ALTER TABLE HumanResources.Parents
------------------------                   ------------------------

INSERT INTO HumanResources.Parents (BusinessEntityID, FirstName, LastName, PersonType) 
VALUES ('Jo', 'Brown')

select *
from HumanResources.Parents
set language english
set language polish

--- zad 20--- zad 20--- zad 20--- zad 20--- zad 20--- zad 20--- zad 20

--- zad 19
INSERT INTO HumanResources.Department (Name, GroupName)
VALUES ('Ochrona', 'Ludzie pilnuj¹cy porz¹dku');




SELECT * 
FROM HumanResources.Department

/////////////////////////////////////////////////////////////////////////////////////////////////////////
SELECT ProductID, Name, ProductNumber, Color, SafetyStockLevel
FROM Production.Product

WHERE Color IN (SELECT Color
			FROM Production.Product			
			WHERE ProductNumber = "C%" )
AND	SafetyStockLevel <= ALL  (SELECT SafetyStockLevel
			FROM Production.Product
			WHERE ProductID > 900);





SELECT BusinessEntityID, StartDate, 
  
	CASE WHEN 'Pracownik o numerze '+ CAST (BusinessEntityID AS VARCHAR) + ' zacz¹³ pracê' +
	DATEDIFF (MONTH,StartDate,CAST (GETDATE() AS DATE)),

FROM HumanResources.EmployeeDepartmentHistory



SELECT *
FROM  HumanResources.Employee;

EXEC SP_HELP 'HumanResources.Parents';

select CAST( GETDATE() AS date) AS "Dataaaaaa", 
select CAST( GETDATE() AS time) as "tajm",
       STR( "Time, 7,3) AS "TAJM" ;
 select STR( "Time, 7,3) AS "TAJM" ;
  select CAST(Hour,minute,second) as "time"
  SELECT CAST( GETDATE() AS time) AS "TAJM"	
///////////////
\\\\\\\\\\\\\\\

SELECT BusinessEntityID, StartDate, ISNULL( EndDate, CAST (GETDATE() AS Date )) 
FROM HumanResources.EmployeeDepartmentHistory;


SELECT JobCandidateID, ISNULL(BusinessEntityID,0) AS "BBB" 
FROM HumanResources.JobCandidate
ORDER BY BBB ASC ;

\\\\\\\\\\\\\\\

SELECT 3500/ 1500 ,
 3500 % 1500,
 CAST( 3500 AS FLOAT ) /1500 ;




///////////////
SELECT SalesYTD, SalesLastYear,
	CASE WHEN SalesYTD > SalesLastYear THEN ' Wiêcej ni¿ w ubieg³ym roku '
	ELSE  'Zosta³o' + CAST (SalesLastYear - SalesYTD AS varchar )
	END AS ' Porównanie lat '
FROM Sales.SalesPerson;

SET Dateformat dmy
SELECT '12-06-2222' AS "DATA"
 

select datename (weekday, getdate());

set dateformat dmy;
select ('12-11-2222') AS "Data", 
MONTH ss('12-11-2222') AS "Miesi¹c";





set language polish;



SELECT BusinessEntityID, StartDate, 
	'Pracownik o numerze '+ CAST (BusinessEntityID AS varchar) + ' zacz¹³ pracê' +
	CAST(DATEDIFF(Year,StartDate,GETDATE()) AS varchar) + 'lat i ' +
	CAST(DATEDIFF(Month,StartDate,GETDATE()) % 12 AS varchar) + 'miesiêcy temu'
	AS  "Praca "
FROM HumanResources.EmployeeDepartmentHistory;




SELECT BusinessEntityID, StartDate, 
	'Pracownik o numerze '+ CAST(BusinessEntityID AS varchar)  + ' zacz¹³ pracê' +
	 CAST(DATEDIFF(Year,StartDate,GETDATE())  AS varchar)+ 'lat i ' +
	 CAST(DATEDIFF(Month,StartDate,GETDATE()) % 12 AS varchar) + 'miesiêcy temu'
	AS  "Praca "			
FROM HumanResources.EmployeeDepartmentHistory;


ALTER TABLE HumanResources.Dzieciaczki 
ALTER COLUMN ID INT NOT NULL		

ALTER TABLE HumanResources.Dzieciaczki 
ADD CONSTRAINT dzeciaki_kej PRIMARY KEY

ALTER TABLE HumanResources.Dzieciaczki 
ADD UNIQUE (ID);

CREATE Table HumanResources.Skurwysynki
(ID int NOT NULL IDENTITY (1,1) CONSTRAINT Klucz_ID_Skurwysynki PRIMARY KEY,
Imie varchar(50),
Nazwisko varchar(50),
Data_urodzenia date ); 

SELECT *
FROM HumanResources.Skurwysynki


INSERT INTO HumanResources.Skurwysynki (Imie,Nazwisko,Data_urodzenia)
VALUES ('Piotr', 'Psikuta', '20000614');

INSERT INTO HumanResources.Skurwysynki (Imie,Nazwisko,Data_urodzenia)
VALUES ('Piotr', 'Psikuta', '20000614'),
('Bartek', 'Sekator', '19991203'),
('Artek', 'Ser', '19890314'),
('Darek', 'Kator', '19941105');

DELETE FROM HumanResources.Skurwysynki
WHERE ID = '2'

DELETE FROM HumanResources.Skurwysynki VALUES


TRUNCATE TABLE HumanResources.Skurwysynki






	CREATE TABLE test 
	(
		BusinessEntityID INT NOT NULL,
		PersonType NCHAR(2) NOT NULL,
		NameStyle dbo.NameStyle NOT NULL CONSTRAINT DF_Person_NameStyle DEFAULT ((0)),
		Title NVARCHAR(8) NULL,
		FirstName dbo.Name NOT NULL,
		MiddleName dbo.Name NULL,
		LastName dbo.Name NOT NULL,
		Suffix NVARCHAR(10) NULL,
		EmailPromotion INT NOT NULL CONSTRAINT DF_Person_EmailPromotion DEFAULT ((0)),
		AdditionalContactInfo XML(CONTENT Person.AdditionalContactInfoSchemaCollection) NULL,
		Demographics  XML(CONTENT Person.IndividualSurveySchemaCollection) NULL,
		rowguid UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL CONSTRAINT DF_Person_rowguid DEFAULT (NEWID()),
		ModifiedDate DATETIME NOT NULL CONSTRAINT DF_Person_ModifiedDate DEFAULT (GETDATE (()
	);