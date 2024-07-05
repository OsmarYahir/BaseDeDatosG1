create DATABASE pruebacargadinamica

 use pruebacargadinamica

 SELECT top 0 EmployeeID,FirstName,LastName,[Address],HomePhone,Country 
 INTO pruebacargadinamica.dbo.empleado
 FROM NORTHWND.dbo.Employees

Delete pruebacargadinamica.dbo.empleado(FirstName,LastName,[Address],HomePhone,Country)
 SELECT  FirstName,LastName,[Address],HomePhone,Country 
 FROM NORTHWND.dbo.Employees

SELECT top 0 EmployeeID,CONCAT(FirstName,' ',LastName) as 'Nombre Completo',[Address],HomePhone,Country 
INTO pruebacargadinamica.dbo.dim_empleados
FROM pruebacargadinamica.dbo.empleado

INSERT into pruebacargadinamica.dbo.dim_empleados([Nombre Completo],[Address],HomePhone,Country)
SELECT CONCAT(e.FirstName,' ',e.LastName) as 'Nombre Completo',e.Address,e.HomePhone,e.Country 
FROM pruebacargadinamica.dbo.empleado as E
LEFT JOIN dim_empleados as dim
on e.EmployeeID =dim.EmployeeID
WHERE dim.EmployeeID is null

 INSERT INTO empleado(FirstName,LastName,Address,HomePhone,Country)
 VALUES
 ('Diego','Waifu','VenustianoCerrada','7721120086','ARG')

truncate table dim_empleados

 SELECT * FROM empleado

use NORTHWND
use pruebacargadinamica

drop TABLE dim_empleados

SELECt * FROM dim_empleados

SELECT * FROM empleado



-- consultas con inner join

SELECT * FROM categoria as c
INNER JOIN Producto as p 