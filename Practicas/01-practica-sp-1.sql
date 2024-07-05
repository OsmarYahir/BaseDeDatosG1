-- Crear un sp que solicite un id de una categoria y debuelva el promedio de los precios de sus productos 

use NORTHWND;
go

create or alter proc sp_solicitar_promedio_prod
@catego int --parametro de entrada
as
begin
select AVG(UnitPrice) as 'Promedio de precio de los productos'
from Products
where CategoryID = @catego;
end;
go

exec sp_solicitar_promedio_prod  2
go

exec sp_solicitar_promedio_prod @catego = 5