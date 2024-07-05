use NORTHWND;

-- lenguaje SQL-LMD
-- seleccionar toos los productos 

select * from Products

--seleccionar todas las categorias de productos 
select * from Categories

-- seleccionar los provedores 
select * from Suppliers

-- seleccionar losclientres 
select * from Customers

-- seleccinar los empleados 
select * from Employees

--seleccinar todas las paqueterias 
select * from Shippers

--elleccionar todas las ordenes 
select * from Orders

--seleccinar todos los detalles de ordenes 
select * from [Order Details];

--consultas simples
--proyeccion


SELECT ProductID, ProductName, UnitsInStock, UnitPrice  FROM Products;

-- alias de columna 
SELECT ProductID as NumeroProducto, ProductName as "Nombre producto", UnitsInStock existencia, UnitPrice as 'Precio'  FROM Products;

-- Alias de tablas 
SELECT Products.ProductID as NumeroProducto, Products.ProductName as "Nombre producto", Products.UnitsInStock existencia, Products.UnitPrice as 'Precio'  
FROM Products;

SELECT * FROM Products, Categories
WHERE Categories.CategoryID = Products.CategoryID;

SELECT * FROM Products as P, Categories as C
WHERE C.CategoryID = P.CategoryID;

-- Caampo cakculado
-- selelccionar todos los productos mostrando el id del producto
-- el nombre del producto, las existencia, el precio y el importe 
SELECT *, (UnitPrice * UnitsInStock) as 'Importe' FROM Products

SELECT  ProductID, ProductName, UnitsInStock, UnitPrice,
(UnitPrice * UnitsInStock) as 'Importe' FROM Products

SELECT  ProductID as 'Numero producto', ProductName as 'Nombre Producto', UnitsInStock as 'Existencia', UnitPrice as 'Precio',
(UnitPrice * UnitsInStock) as 'Importe' FROM Products

select max((UnitPrice * UnitsInStock)) as 'Importe maximo' from Products

--Seleccionar las primeras 10 ordenes 
SELECT top 10 *  FROM Orders;

-- Seleccionar todos los clientes ordenados de forma ascendente por el pais
SELECT CustomerID as 'Numero de cliente', 
CompanyName as 'Nombre del Cliente',
[Address]  as 'Ciudad',
City as 'Ciudad',
Country as 'Pais'
 FROM Customers
 Order by Country;

 SELECT CustomerID as 'Numero de cliente', 
CompanyName as 'Nombre del Cliente',
[Address]  as 'Ciudad',
City as 'Ciudad',
Country as 'Pais'
 FROM Customers
 Order by 5 ASC;

 SELECT CustomerID as 'Numero de cliente', 
CompanyName as 'Nombre del Cliente',
[Address]  as 'Ciudad',
City as 'Ciudad',
Country as 'Pais'
 FROM Customers
 Order by 'Pais' ASC;


-- Seleccinar todos los clientes ordenados por pais de forma descendente 
SELECT CustomerID as 'Numero de cliente', 
CompanyName as 'Nombre del Cliente',
[Address]  as 'Ciudad',
City as 'Ciudad',
Country as 'Pais'
 FROM Customers
 Order by Country desc;

 SELECT CustomerID as 'Numero de cliente', 
CompanyName as 'Nombre del Cliente',
[Address]  as 'Ciudad',
City as 'Ciudad',
Country as 'Pais'
 FROM Customers
 Order by 5 desc;

 SELECT CustomerID as 'Numero de cliente', 
CompanyName as 'Nombre del Cliente',
[Address]  as 'Ciudad',
City as 'Ciudad',
Country as 'Pais'
 FROM Customers
 Order by 'Pais' desc;

 -- Sellecina todos los clientes ordenados de forma ascendente por pais y dentro de 
 -- cada pais ordenadp pro ciudad de forma descedente 

 SELECT CustomerID, CompanyName, Country, City 
 from Customers
ORDER BY Country, City DESC;


-- Operadores Relacinales 
-- <,> <=, >=, ==, <>, !=

-- Seleccinar todos los paises a los cuales se les han enviado las ordenes 
SELECT DISTINCT ShipCountry  FROM Orders
ORDER BY 1

-- Selecinar las ordenes enviadas a francia 
SELECT * FROM Orders
WHERE ShipCountry = 'France';

-- Seleccinaer todas las ordenes realizadas a francia, mostrando
-- el numero de orden, cliente al que se le vendio, empleado que lo realizo, 
-- el pais al que se envio, ciudad a la que se envio 

SELECT OrderID as 'Numero de orden',
CustomerID as 'Cliente',
EmployeeID as 'Empleado',
ShipCity as 'Pais de envio',
ShipCountry as 'Ciudad'
FROM Orders
WHERE ShipCountry = 'France';

-- Seleccinar las ordenes en donde no se ha asignado una region de envio
SELECT OrderID as 'Numero de orden',
CustomerID as 'Cliente',
EmployeeID as 'Empleado',
ShipCity as 'Pais de envio',
ShipCountry as 'Ciudad',
ShipRegion as 'Region'
FROM Orders
WHERE ShipRegion is null;

-- Seleccinar las ordenes en donde si se ha asignado una region de envio
SELECT OrderID as 'Numero de orden',
CustomerID as 'Cliente',
EmployeeID as 'Empleado',
ShipCity as 'Pais de envio',
ShipCountry as 'Ciudad',
ShipRegion as 'Region'
FROM Orders
WHERE ShipRegion is NOT null;

-- Sellecinar los productos con un precio mayor a 50 dollar
SELECT * FROM Products
WHERE UnitPrice > 50


-- Seleccianr los empleados contratados despues del primero de enero de 1990
SELECT * from Employees
WHERE HireDate > '1990-01-01';

-- Seleccinar los clientes cuya ciudad sea germany
SELECT * FROM Customers
WHERE Country = 'Germany'

-- mostar los productos con una cantidad menor o iaguala a 100
SELECT * FROM Products
WHERE UnitsInStock <= 100

-- Seleccianr todas lar ordenes realizadas antes del primero de enero de 1998
SELECT * FROM Orders
WHERE OrderDate < '1998-01-01';

-- Seleccionar todas las ordenes realizadas por el empleado Fuller
SELECT * FROM Orders
WHERE EmployeeID = 2

-- Seleccinar todas las ordenes, mostrando el numero de orden, el cliente 
-- y la fecha orden dividida en año, mes y dia 
select OrderID as 'Numero de Orden',
CustomerID as 'Cliente',
OrderDate, YEAR(OrderDate) as 'Año',
MONTH(OrderDate) as 'Mes', DAY(OrderDate) as 'Dia'
 FROM Orders


-- Operadores logicos
-- Seleccianr los producto scon un precio mayor a 50 y con una cantidad menor o igual a 100
SELECT * FROM Products 
WHERE UnitPrice > 50 AND UnitsInStock <= 100


-- Seleccianr todas las ordenes para francia y alemania 
SELECT * FROM Orders
WHERE ShipCountry in ('France', 'Germany') 

SELECT * FROM Orders
WHERE ShipCountry = 'France' or ShipCountry = 'Germany'

-- Seleccianr todas las ordenes para francia, alemania y mexico 
SELECT * FROM Orders
WHERE ShipCountry = 'France'
or ShipCountry = 'Germany'
or ShipCountry = 'Mexico'

SELECT * FROM Orders
WHERE ShipCountry in ('France', 'Germany','Mexico') 
ORDER BY ShipCountry ASC
-- 