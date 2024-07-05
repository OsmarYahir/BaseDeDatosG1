CREATE DATABASE pruebacargadinamica

use pruebacargadinamica;

SELECT EmployeeID, FirstName, LastName, [Address], HomePhone, Country
INTO pruebacargadinamica.dbo.empleado
FROM northwnd.dbo.Employees


insert into pruebacargadinamica.dbo.empleado (FirstName,LastName,[Address], HomePhone, Country)
select FirstName, LastName, [Address], HomePhone, Country
FROM northwnd.dbo.Employees


SELECT EmployeeID as 'idempleado', CONCAT(FirstName, ' ', LastName) as 'nombre completo', [Address] as 'Direccion', HomePhone as 'telefono', Country as 'Continente' FROM empleado

SELECT EmployeeID as 'idempleado', CONCAT(FirstName, ' ', LastName) as 'nombre completo', [Address] as 'Direccion', HomePhone as 'telefono', Country as 'Continente' 
INTO pruebacargadinamica.dbo.dim_empleado
FROM pruebacargadinamica.dbo.empleado

SELECT * FROM dim_empleado