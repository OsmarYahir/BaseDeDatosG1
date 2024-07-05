-- funciones de agregado
-- seleccionar el numero total de ordenes de  compra 

use NORTHWND;
SELECT COUNT(*) as 'Numero de ordenbes' FROM Orders

SELECT COUNT(*) FROM Customers


--count (campo)

SELECT COUNT(Region) FROM Customers

--seleccionar el maximo numero de productos pedido

SELECT MAX(Quantity) as 'Cantidad' FROM [Order Details]

-- sleccionar el total de la cantidad de los productos pedidos 
SELECT SUM(UnitPrice) FROM [Order Details];


-- seleccionar el total de dinero 
SELECT SUM(Quantity * od.UnitPrice) as total FROM [Order Details] as od 
INNER JOIN Products as p on od.ProductID = p.ProductID
WHERE p.ProductName = 'Aniseed Syrup'


-- seleccionar el promedio de las ventas del producto 3
SELECT avg(Quantity * od.UnitPrice) as 'Promedio ventas' FROM [Order Details] as od 
INNER JOIN Products as p on od.ProductID = p.ProductID
WHERE p.ProductName = 'Aniseed Syrup'


-- seleccionar el numero de productos por categoria 
SELECT avg(CategoryID), COUNT(*) as 'Numero de productos'
FROM Products

SELECT CategoryID FROM Products

SELECT COUNT(*)
FROM Products


SELECT CategoryID, COUNT(*) as 'Total de Productos' 
FROM Products
GROUP BY CategoryID

--seleccionar el numero de productos por nombre de categoria 
SELECT c.CategoryName, COUNT(ProductID) as 'Total de productos' 
FROM Products as p 
INNER JOIN Categories as c  on p.CategoryID = c.CategoryID
GROUP BY c.CategoryName


SELECT c.CategoryName, COUNT(ProductID) as 'Total de productos' 
FROM Products as p 
INNER JOIN Categories as c  on p.CategoryID = c.CategoryID
WHERE c.CategoryName in ('Beverages', 'Confections')
GROUP BY c.CategoryName

SELECT * FROM Products



