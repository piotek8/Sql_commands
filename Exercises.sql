
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




