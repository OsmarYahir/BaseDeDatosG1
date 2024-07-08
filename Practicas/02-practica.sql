use NORTHWND;

-- crear un store procedure que reciba dos fechas y reciba una lista de empleados con  que fueron contratados dentro de esa fecha

select * FROM Employees

SELECT EmployeeID as 'Empleado id',  CONCAT(FirstName, ' ', LastName) as 'Nombre completo', BirthDate  as 'Fecha' FROM Employees 
WHERE BirthDate BETWEEN '1940-12-08' and '1960-12-25';

create or alter PROC sp_primer_dia
 @primerr DATE,
 @segunr date
as 
BEGIN
SELECT EmployeeID as 'Empleado id',  CONCAT(FirstName, ' ', LastName) as 'Nombre completo', BirthDate  as 'Fecha' 
FROM Employees 
WHERE BirthDate BETWEEN @primerr and @segunr;
END
go

EXEC sp_primer_dia @primerr = '1940-12-08', @segunr ='1960-12-25';

--procedimiento almacenado para actualizar el precio de unproducto y registrar los cambios
--1.-crear un prodedimiento almacenado que se llame actualizarPrecioProducto
--2.-crear una tabla que se llame cambioDePrecios
-- CambioID int identity primary key,
-- productoId int not null,
-- precioAnterior money not nu
-- precioNuevo money
-- fecha de cambio dateDay (getDatec)
-- paso n.3 -> debe haceptar 2 parametros, el producto a cambiar y el nuevo precio
--paso n.4 -> el procedimiento debe actualizar el precio del producto a la tabla products
--paso n.5 -> el procedimiento debe insertar un registro en la tabla cambio de precios con los detalles del cambio