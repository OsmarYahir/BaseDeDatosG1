use AdventureWorks2019

select BusinessEntityID, SalariedFlag
FROM HumanResources.Employee
ORDER BY 
case SalariedFlag
when 1 then BusinessEntityID
end DESC,
case 
when SalariedFlag = 0 then BusinessEntityID
end ASC;


SELECT BusinessEntityID,
      LastName,
      TerritoryName,
      CountryRegionName
FROM Sales.vSalesPerson
WHERE TerritoryName is not null
ORDER by 
    case CountryRegionName
        when 'United States' then TerritoryName
        else CountryRegionName
        END DESC

-- ISNULL si tiene valores nulos 

SELECT v.AccountNumber,
      v.Name,
      v.PurchasingWebServiceURL as 'PurchasingWebServiceURL'
FROM [Purchasing].[Vendor] as v


SELECT v.AccountNumber,
      v.Name,
      ISNULL( v.PurchasingWebServiceURL, 'El viernes no van a pasar' ) as 'PurchasingWebServiceURL'
FROM [Purchasing].[Vendor] as v


SELECT v.AccountNumber,
      v.Name,
      case  v.PurchasingWebServiceURL IS NULL then 'NO URL'
       end
       as 'PurchasingWebServiceURL'
FROM [Purchasing].[Vendor] as v






use AdventureWorks2019

-- funcion IIF
SELECT IIF (1=1, 'Verdadero','Falso')


CREATE VIEW vista_genero
as 
SELECT e.LoginID, e.JobTitle, IIF(e.Gender='F','Mujer','Hombre') as 'Sexo' FROM 
HumanResources.Employee as e 

SELECT UPPER(JobTitle) as [Titulo] from vista_genero
WHERE sexo = 'Mujer';



SELECT OBJECT_ID(N'tempdb..#StudentsC1')

IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)




IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)



SELECT * FROM 
#StudentsC1 AS C1 
INNER JOIN #StudentsC2 AS C2 
ON C1.StudentID = C2.StudentID

SELECT * FROM 
#StudentsC1 AS C1 
RIGHT JOIN #StudentsC2 AS C2 
ON C1.StudentID = C2.StudentID

INSERT INTO #StudentsC2 (StudentID,StudentName,StudentStatus)
SELECT C1.StudentID, C1.StudentName, C1.StudentStatus FROM 
#StudentsC1 AS C1 
LEFT JOIN #StudentsC2 AS C2 
ON C1.StudentID = C2.StudentID
WHERE C2.StudentID IS NULL 


UPDATE C2
SET C2.StudentName = C1.StudentName,
      c2.StudentStatus = c1.StudentStatus
FROM 
#StudentsC1 AS C1 
INNER JOIN #StudentsC2 AS C2 
ON C1.StudentID = C2.StudentID


SELECT * FROM 
#StudentsC1 AS C1 
LEFT JOIN #StudentsC2 AS C2 
ON C1.StudentID = C2.StudentID
