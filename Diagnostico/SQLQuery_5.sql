CREATE DATABASE pruebacargadinamica

use pruebacargadinamica;

SELECT employeid, firstname, LastName, [Address], nomephone, Country
INTO pruebacargadinamica.dbo.empleado
FROM northwnd.dbo.Employees


insert into pruebacargadinamica.dbo.empleado (FirstName,LastName,[Address], homePhone, Country)
select FirstName, LastName [Address], HomePhone, Country
FROM northwnd.dbo.Employees
