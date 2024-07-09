--Parametros de salida 

create or alter procedure calcular_area
--Parametros de entrada
@radio float,
--Parametros de salida
@area float output
AS 
begin 
	SET @area =PI() * @radio * @radio
 end

 GO

 DECLARE @resp float
 exec calcular_area @radio = 22.3, @area = @resp
 print 'El area es:' + cast(@resp as varchar)

 use NORTHWND;
 GO
 create or alter proc sp_obtenerdatosempleado
 @numeroEmpleado int,
 @fullname nvarchar(35) output
AS
begin
	select @fullname=CONCAT(FirstName, ' ', LastName)
	from
	Employees
	where EmployeeID = @numeroEmpleado;
end;
GO

declare  @nombrecompleto nvarchar(35)
exec sp_obtenerdatosempleado @numeroEmpleado = 3, @fullname = @nombrecompleto output
print @nombrecompleto  
GO

CREATE OR ALTER PROCEDURE sp_obtenerdatosempleado_buscar
    @numeroEmpleado INT,
    @fullname NVARCHAR(35) OUTPUT
AS
BEGIN
    SELECT @fullname = CONCAT(FirstName, ' ', LastName)
    FROM Employees
    WHERE EmployeeID = @numeroEmpleado;
    IF @fullname IS NULL
    BEGIN
        SET @fullname = 'ID no existente';
    END
END;

DECLARE @fullname NVARCHAR(35);
EXEC sp_obtenerdatosempleado_buscar @numeroEmpleado = 2, @fullname = @fullname OUTPUT;
PRINT @fullname;

select*from Customers;

create database etlempresa;
 
use NORTHWND;
select * from Customers

create table Cliente (
	clienteid int not null identity (1,1),
	clientebk nchar(5) not null,
	empresa nvarchar(40) not null,
	ciudad nvarchar(15) not null,
	region nvarchar (15) not null,
	pais nvarchar(15) not null,
	constraint pk_cliente
	primary key (clienteid)
);
GO
select * from Cliente

select CustomerID, UPPER(CompanyName) as 'Nombre', UPPER(City) as 'Ciudad', ISNULL(Region, 'SIN REGION') as Region,UPPER(Country) as 'Pais'
from NORTHWND.dbo.Customers as nc
GO
--Cargar registros tabla Cliente
create proc sp_etl_carga_cliente
as
begin
insert into etlempresa.dbo.Cliente
select CustomerID, UPPER(CompanyName) as 'Nombre', UPPER(City) as 'Ciudad', 
ISNULL(nc.Region, 'SIN REGION') as Region,UPPER(Country) as 'Pais' 
from NORTHWND.dbo.Customers as nc
left join etlempresa.dbo.Cliente etle
on nc.CustomerID = etle.clientebk
where etle.clientebk is null;

update cl
set
cl.Empresa = UPPER(c.CompanyName),
cl.Ciudad = upper(c.City),
cl.Pais = upper(c.Country),
cl.Region = upper(isnull(c.Region, 'Sin region'))
from NORTHWND.dbo.Customers as c
inner join etlempresa.dbo.Cliente as cl
on c.CustomerID = cl.clientebk
end

--Añadir o cambiar un registro
select * from NORTHWND.dbo.Customers
where CustomerID = 'CLIB1'

update NORTHWND.dbo.Customers
set CompanyName = 'pepsi'
where CustomerID = 'CLIB1'

truncate table etlempresa.dbo.Cliente
select * from NORTHWND.dbo.Products
GO
drop table Producto;
GO
--Tabla Producto
create table Producto (
	productoid int not null identity(1,1),
	productobk int not null,
	nombreProducto nchar(40) not null,
	categoria int not null,
	precio money not null,
	existencia smallint not null,
	descontinuado bit not null,
	constraint pk_producto
	primary key(productoid)
);
go

select * from Producto
go
-- introducir datos de northwind 
select np.ProductID as 'productoid', np.ProductName as 'nombreProducto', np.CategoryID as 'categoria',
np.UnitPrice as 'precio', np.UnitsInStock as 'existencia', np.Discontinued as 'descontinuado'
from NORTHWND.dbo.Products as np
left join etlempresa.dbo.Producto as etlp
on np.CategoryID = etlp.productobk


select pl.categoria, p.CategoryID, 
pl.descontinuado, p.Discontinued, 
pl.existencia, p.UnitsInStock, 
pl.nombreProducto, p.ProductName,
pl.precio, p.UnitPrice
from NORTHWND.dbo.Products as p
inner join etlempresa.dbo.Producto as pl
on p.ProductID = pl.productobk
go

--Cargar registros tabla Producto o Storage Procedure
create or alter proc sp_etl_carga_producto
as 
begin 
insert into etlempresa.dbo.Producto
select np.ProductID as 'productoid', np.ProductName as 'nombreProducto', np.CategoryID as 'categoria',
np.UnitPrice as 'precio', np.UnitsInStock as 'existencia', np.Discontinued as 'descontinuado'
from NORTHWND.dbo.Products as np
left join etlempresa.dbo.Producto as etlp
on np.CategoryID = etlp.productobk
update pl
set 
pl.categoria = p.CategoryID, 
pl.descontinuado =p.Discontinued, 
pl.existencia = p.UnitsInStock, 
pl.nombreProducto = p.ProductName,
pl.precio = p.UnitPrice
from etlempresa.dbo.Producto as pl
left join NORTHWND.dbo.Products as p
on p.ProductID = pl.productobk
end;
go

exec sp_etl_carga_producto
select * from Producto


--Tabla empleado
create table Empleado (
	empleadoid int not null identity(1,1),
	empleadobk nchar(5) not null, 
	nombreCompleto nvarchar(30) not null,
	ciudad nvarchar(15) not null,
	region nvarchar(15) not null,
	pais nvarchar(15) not null,
	constraint pk_empleado
	primary key(empleadoid)
);
go

select * from NORTHWND.dbo.Employees

select ne.EmployeeID as 'empleadoid', CONCAT(ne.FirstName, ' ', ne.LastName) as 'nombreCompleto',
ne.City as 'ciudad', ISNULL(ne.Region, 'SIN REGION') as 'region', ne.Country as 'pais'
from NORTHWND.dbo.Employees as ne
left join etlempresa.dbo.Empleado as etle
on ne.EmployeeID = etle.empleadoid
where etle.empleadobk is null
go


select el.ciudad, e.City,
el.nombreCompleto, CONCAT(e.FirstName, ' ', e.LastName),
el.pais, e.Country,
el.region, ISNULL(e.Region, 'SIN REGION')
from NORTHWND.dbo.Employees as e
inner join etlempresa.dbo.Empleado as el
on e.EmployeeID = el.empleadobk
go

create or alter proc sp_etl_carga_empleado
as 
begin
insert into etlempresa.dbo.Empleado
select ne.EmployeeID as 'empleadoid', CONCAT(ne.FirstName, ' ', ne.LastName) as 'nombreCompleto',
ne.City as 'ciudad', ISNULL(ne.Region, 'SIN REGION') as 'region', ne.Country as 'pais'
from NORTHWND.dbo.Employees as ne
left join etlempresa.dbo.Empleado as etle
on ne.EmployeeID = etle.empleadoid
where etle.empleadobk is null
update el
set 
el.ciudad = e.City,
el.nombreCompleto = CONCAT(e.FirstName, ' ', e.LastName),
el.pais = e.Country,
el.region = ISNULL(e.Region, 'SIN REGION')
from NORTHWND.dbo.Employees as e
inner join etlempresa.dbo.Empleado as el
on e.EmployeeID = el.empleadobk
end;
go

exec sp_etl_carga_empleado
select * from Empleado


--Tabla Proveedor
create table Proveedor (
	proveedorid int not null identity(1,1),
	proveedorbk nvarchar(5) not null,
	empresa nvarchar(40) not null,
	city nvarchar(15) not null,
	region nvarchar(15) not null,
	country nvarchar(15) not null,
	homePage ntext not null,
	constraint pk_proveedor
	primary key(proveedorid)
);

select * from NORTHWND.dbo.Suppliers

select ns.SupplierID as 'proveedorid', ns.CompanyName as 'empresa', ns.City, ISNULL(ns.Region, 'SIN REGION') as 'region',
ns.Country, ISNULL(ns.HomePage, 'Sin pagina Web') as 'homePage'
from NORTHWND.dbo.Suppliers as ns
left join etlempresa.dbo.Proveedor as etlp
on ns.SupplierID = etlp.proveedorid


select pl.city, s.City,
pl.country, s.Country,
pl.empresa, s.CompanyName,
pl.homePage, ISNULL(s.HomePage, 'Sin pagina Web'),
pl.region, ISNULL(s.Region, 'SIN REGION')
from NORTHWND.dbo.Suppliers as s
inner join etlempresa.dbo.Proveedor as pl
on s.SupplierID = pl.proveedorbk
go

create or alter proc sp_etl_carga_proveedor
as 
begin 
insert into etlempresa.dbo.Proveedor
select ns.SupplierID as 'proveedorid', ns.CompanyName as 'empresa', ns.City, ISNULL(ns.Region, 'SIN REGION') as 'region',
ns.Country, ISNULL(ns.HomePage, 'Sin pagina Web') as 'homePage'
from NORTHWND.dbo.Suppliers as ns
left join etlempresa.dbo.Proveedor as etlp
on ns.SupplierID = etlp.proveedorid
update pl
set
pl.city = s.City,
pl.country = s.Country,
pl.empresa = s.CompanyName,
pl.homePage = ISNULL(s.HomePage, 'Sin pagina Web'),
pl.region = ISNULL(s.Region, 'SIN REGION')
from NORTHWND.dbo.Suppliers as s
inner join etlempresa.dbo.Proveedor as pl
on s.SupplierID = pl.proveedorbk
end;

exec sp_etl_carga_proveedor;
select * from Proveedor


--Tabla Ventas 

drop table Ventas
go

-- Crear tabla Ventas 
CREATE TABLE Ventas (
    clienteid INT NOT NULL,
    productoid INT NOT NULL,
    empleadoid INT NOT NULL,
    proveedorid INT NOT NULL,
    cantidad INT NOT NULL,
    precio INT NOT NULL,
    CONSTRAINT fk_cliente_ventas 
	FOREIGN KEY (clienteid) 
	REFERENCES Cliente(clienteid),
    CONSTRAINT fk_producto_ventas 
	FOREIGN KEY (productoid) 
	REFERENCES Producto(productoid),
    CONSTRAINT fk_empleado_ventas 
	FOREIGN KEY (empleadoid) 
	REFERENCES Empleado(empleadoid),
    CONSTRAINT fk_proveedor_ventas 
	FOREIGN KEY (proveedorid) 
	REFERENCES Proveedor(proveedorid)
);


select * from NORTHWND.dbo.[Order Details]
select * from Ventas

select ns.SupplierID as 'proveedorid', ns.CompanyName as 'empresa', ns.City, ISNULL(ns.Region, 'SIN REGION') as 'region',
ns.Country, ISNULL(ns.HomePage, 'Sin pagina Web') as 'homePage'
from NORTHWND.dbo.Suppliers as ns
left join etlempresa.dbo.Proveedor as etlp
on ns.SupplierID = etlp.proveedorid

select v.productoid, v.clienteid, v.empleadoid, v.proveedorid
from Cliente as c
left join Ventas as v
on c.clienteid = v.clienteid
left join etlempresa.dbo.Producto as p 
on p.productoid = v.productoid
left join Empleado as e
on v.empleadoid = e.empleadoid
left join Proveedor as pv
on v.proveedorid = pv.proveedorid


select e.empleadoid, c.clienteid 
from Empleado as e
left join Ventas as v
on e.empleadoid = v.empleadoid
left join Cliente as c
on c.clienteid = v.clienteid


use NORTHWND;