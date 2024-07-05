
use NORTHWND

-- vistas (objeto de la base de datos SQL)

create or ALTER view vista_ventas 
as 
select c.CustomerID as 'ClaveDelCliente', c.CompanyName as 'Cliente',
CONCAT(e.FirstName,' ',e.LastName) as 'Nombre',
o.OrderDate as 'FechaDeOrden', DATEPART(YEAR, o.OrderDate) as 'Añocompra',
DATENAME (mm,o.OrderDate) as 'Mesdecompra',
DATEPART(QUARTER,o.OrderDate) as 'Trimestre',
UPPER(p.ProductName) as 'Nombredelproducto',
od.Quantity as 'CantidadVendida',
od.UnitPrice as 'PrecioDeVenta',
p.SupplierID as 'ProvedorId'
 FROM
Orders as o
INNER JOIN Customers as c 
on o.CustomerID = c.CustomerID
inner JOIN Employees as e 
on e.EmployeeID = o.EmployeeID
inner JOIN [Order Details] as od 
on od.OrderID = o.OrderID
inner JOIN Products as p 
on p.ProductID = od.ProductID;

SELECT ClaveDelCliente, Nombre, Nombredelproducto,FechaDeOrden, (CantidadVendida * PrecioDeVenta) as 'Importe'
FROM vista_ventas
WHERE Nombredelproducto = 'CHAI'
AND (CantidadVendida * PrecioDeVenta) > 600
AND DATEPART(YEAR,FechaDeOrden) = 1995


-- inner join vista con supliers 

SELECT * FROM vista_ventas as vv 
INNER JOIN Suppliers as s 
on s.SupplierID = vv.ProvedorId


SELECT ProductName, UnitPrice, UnitsInStock, Discontinued, 
Disponibilodad = case Discontinued
when 0 THEN 'No disponible'
when 1 THEN 'Disponible'
else 'No existente'
END
FROM Products


SELECT ProductName, UnitsInStock, UnitPrice,
case 
when UnitPrice >=1 and UnitPrice <18 then 'Prducto barato'
when UnitPrice >= 10 and UnitPrice <200 then 'Producto medio barato'
when UnitPrice between 51 and 100 then 'Producto Caro'
else 'Carisimo'
end as 'Categoria Precios'
 FROM Products
 WHERE ProductID in (29,28)