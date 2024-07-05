use NORTHWND;

-- selecionar todas las ordenes que fueron imitidas por los empleados Nancy, Davolio, Ana Dodswork y Andrew Fuller
SELECT * FROM Orders
WHERE EmployeeID = 1
OR EmployeeID = 9
OR EmployeeID = 2;

SELECT * FROM Orders
WHERE EmployeeID in(1,9,2);

SELECT OrderDate as 'Fecha de orden' ,
year(OrderDate) as 'año',
MONTH (OrderDate) as 'Mes',
DAY(OrderDate) as 'Dia'
FROM Orders


--seleccionar todos los nombre de los empleados 
SELECT CONCAT(FirstName,'',LastName) as 'Nombre completo' FROM Employees


--seleccionar todos los productos donde la existencia sea mayor o igual a 40
-- y el precio sea mayor a 19
SELECT ProductName as 'Nombre del producto', UnitPrice as 'Precio', UnitsInStock as 'Existecnia' FROM Products
WHERE UnitsInStock >= 40 
and UnitPrice < 19

-- seleccionar todas las ordenes realizadas de abril - agosto 1996
SELECT OrderID, CustomerID, EmployeeID, OrderDate FROM Orders
WHERE OrderDate = '1996-04-01' and OrderDate = '1996-08-31'

SELECT OrderID, CustomerID, EmployeeID, OrderDate FROM Orders
WHERE OrderDate BETWEEN '1996-04-01' and  '1996-08-31'

--Selleccionar todas las ordenes 1996 y 1998
SELECT * FROM Orders
WHERE YEAR(OrderDate) BETWEEN '1996' and '1998'

SELECT OrderID, CustomerID, EmployeeID, OrderDate FROM Orders
WHERE OrderDate BETWEEN '1996-01-01' and  '1998-12-31'

--Selleccionar todas las ordenes 1996 y 1999
SELECT * FROM Orders
WHERE YEAR(OrderDate) in ('1996','1999')

SELECT OrderID, CustomerID, EmployeeID, OrderDate FROM Orders
WHERE OrderDate BETWEEN '1996-01-01' and  '1999-12-31'


--Seleccionar todos los productos que contienen con c
SELECT * FROM Products
WHERE ProductName  LIKE 'C%';

SELECT * FROM Products
WHERE ProductName  LIKE 'Ca%';

--seleccioanr todos los productos que terminen con s
SELECT * FROM Products
WHERE ProductName  LIKE 'S%'; 


--Seleccionar todos los productos que el nombre de producto contenga la palabra no 
SELECT * FROM Products
WHERE ProductName  LIKE '%No%'; 

-- seleccionar todos los productos que contengan las letras a o n 
SELECT * FROM Products
WHERE ProductName  LIKE '%[AN]%'

SELECT * FROM Products
WHERE ProductName  LIKE '%a%' or ProductName LIKE '%n%'; 

--Seleccionar todos los productos que comiensen entre la letra a y N
SELECT * FROM Products
WHERE ProductName  LIKE '[A-N]%'


-- selecionar todas las ordenes que fueron imitidas por los empleados Nancy, Davolio, Ana Dodswork y Andrew Fuller
SELECT * FROM Employees as e
INNER JOIN 
ORDER as o
on e.

-- crear base de datos
create database pruebaxyz;
use pruebaxyz;

-- crear una tabla a partir de una consulta  con cero registros 
SELECT top 0 *
into pruebaxyz.dbo.products2
FROM Northwnd.dbo.Products;

alter table products2 
add CONSTRAINT pk_products2
PRIMARY KEY(productid) identity (1,1);

ALTER TABLE
DROP CONSTRAINT pk_products2;


-- llenar una tabla a partir de una consulta
INSERT into pruebaxyz.dbo.products2 (ProductName,SupplierID,
CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,
ReorderLevel,Discontinued)
SELECT ProductName,SupplierID,
CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,
ReorderLevel,Discontinued FROM northwnd.dbo.Products;


-- Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado
-- del representante de ventas de cada pedido.
use NORTHWND;
SELECT o.CustomerID, o.EmployeeID, o.OrderID, o.OrderDate  FROM Orders as o;

SELECT c.CompanyName as 'Nombre del cliente', CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre del empleado', o.OrderID as 'Orden id', o.OrderDate as 'Fecha',
(od.Quantity * od.UnitPrice) as 'Importe'
FROM Customers as c
INNER JOIN Orders as o on o.CustomerID = c.CustomerID
INNER JOIN Employees as e on o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] as od
on od.OrderID = o.OrderID
WHERE YEAR(OrderDate) in ('1996','1998');

--seleccionar cuantas ordenes se han realizado en 1996 y 1998
SELECT COUNT(*) as 'Total de ordenes'
FROM Customers as c
INNER JOIN Orders as o on o.CustomerID = c.CustomerID
INNER JOIN Employees as e on o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] as od
on od.OrderID = o.OrderID
--WHERE YEAR(OrderDate) in ('1996','1998');
WHERE YEAR(OrderDate) = '1996' OR
YEAR(OrderDate) = '1998';

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.

SELECT p.ProductName as 'Nombre del producto', s.CompanyName as 'Nombre Provedor', p.UnitPrice as 'Precio' FROM Products as p
INNER join Suppliers as s on s.SupplierID = p.SupplierID

--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
SELECT c.ContactName, o.OrderID, o.OrderDate FROM Customers as c
INNER JOIN Orders as o on o.CustomerID = c.CustomerID

--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
SELECT  FROM Employees

SELECT * FROM Employees

--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.
--Ejercicio 11: Seleñcionar el total de ordenes hechas por cada uno de los provedores 
SELECT s.CompanyName as 'Provedor',  COUNT(od.OrderID) as 'Total de ordenes' FROM Suppliers as s
INNER JOIN Products as p on s.SupplierID = p.SupplierID
INNER JOIN [Order Details] as od on od.ProductID = p.SupplierID
GROUP BY s.CompanyName


--Ejercicio 12: Seleccionar el total del dinero que he vendidido por provedor del ultimo trimestre de 1996
SELECT s.CompanyName as 'Provedor', SUM(od.Quantity * od.UnitPrice) as 'Total de ventas' FROM [Order Details] as od
INNER JOIN Products as p on od.ProductID = p.ProductID
INNER JOIN Suppliers as s on p.SupplierID = p.SupplierID
INNER JOIN Orders as o on od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1996-01-01' and '1996-03-31'
GROUP BY s.CompanyName;


SELECT s.CompanyName as 'Provedor', SUM(od.Quantity * od.UnitPrice) as 'Total de ventas' FROM [Order Details] as od
INNER JOIN Products as p on od.ProductID = p.ProductID
INNER JOIN [Suppliers] as s on od.ProductID = p.SupplierID
INNER JOIN Orders as o on od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1996-09-01' and '1996-12-31' 
GROUP BY s.CompanyName
ORDER by 'Total de ventas' DESC;

use NORTHWND;

SELECT s.CompanyName as 'Provedor', SUM(od.UnitPrice * od.Quantity) as 'Total de venta'
FROM Suppliers as s
INNER JOIN Products as p on s.SupplierID = p.SupplierID
INNER JOIN [Order Details] as od on od.ProductID = p.ProductID
INNER JOIN Orders as o on o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1996-09-01' and '1996-12-31'
GROUP BY s.CompanyName

SELECT s.CompanyName as 'Provedor', SUM(od.UnitPrice * od.Quantity) as 'Total de venta'
FROM Suppliers as s
INNER JOIN Products as p on s.SupplierID = p.SupplierID
INNER JOIN [Order Details] as od on od.ProductID = p.ProductID
INNER JOIN Orders as o on o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1996-09-01' and '1996-12-31'
GROUP BY s.CompanyName
ORDER by 'Total de venta' DESC

SELECT s.CompanyName as 'Provedor', SUM(od.UnitPrice * od.Quantity) as 'Total de venta'
FROM Suppliers as s
INNER JOIN Products as p on s.SupplierID = p.SupplierID
INNER JOIN [Order Details] as od on od.ProductID = p.ProductID
INNER JOIN Orders as o on o.OrderID = od.OrderID
GROUP BY s.CompanyName
ORDER by 2 DESC

SELECT s.CompanyName as 'Provedor', SUM(od.UnitPrice * od.Quantity) as 'Total de venta'
FROM Suppliers as s
INNER JOIN Products as p on s.SupplierID = p.SupplierID
INNER JOIN [Order Details] as od on od.ProductID = p.ProductID
INNER JOIN Orders as o on o.OrderID = od.OrderID
GROUP BY s.CompanyName
ORDER by SUM(od.UnitPrice * od.Quantity) DESC

SELECT s.CompanyName as 'Provedor', SUM(od.UnitPrice * od.Quantity) as 'Total de venta'
FROM Suppliers as s
INNER JOIN Products as p on s.SupplierID = p.SupplierID
INNER JOIN [Order Details] as od on od.ProductID = p.ProductID
INNER JOIN Orders as o on o.OrderID = od.OrderID
GROUP BY s.CompanyName
ORDER by 'Total de venta' DESC


SELECT c.CategoryName, p.ProductName, p.UnitsInStock , p.UnitPrice ,p.Discontinued FROM (
    select CategoryName, CategoryID FROM Categories
) as c 
INNER JOIN (select ProductName, UnitsInStock, CategoryID, UnitPrice, Discontinued FROM Products ) as p 
on c.CategoryID = p.CategoryID

-- left join 
SELECT s.CompanyName as 'Provedor', SUM(od.UnitPrice * od.Quantity) as 'Total de venta'
FROM (select CompanyName , SupplierID from Suppliers) as s
INNER JOIN (select SupplierID , ProductID from Products) as p on s.SupplierID = p.SupplierID
INNER JOIN (select ProductID, UnitPrice, Quantity, OrderID from [Order Details]) as od on od.ProductID = p.ProductID
INNER JOIN (select OrderID from Orders) as o on o.OrderID = od.OrderID
GROUP BY s.CompanyName
ORDER by 'Total de venta' DESC


-- Ejercicio 14 seleccionar el total de dinero vendido por categoria 

use NORTHWND;

SELECT c.CategoryName as 'Nombre de la categoria',
p.ProductName as 'Producto',
 SUM(od.Quantity * od.UnitPrice) as 'Total'
FROM [Order Details] as [od]
INNER JOIN Products as p 
on od.ProductID = p.ProductID
INNER JOIN Categories as c 
on c.CategoryID = p.CategoryID
GROUP BY c.CategoryName , p.ProductName
ORDER BY 1 ASC

