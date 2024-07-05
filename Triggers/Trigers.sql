CREATE DATABASE Pruebatriggers;
GO

use Pruebatriggers;
GO

CREATE TABLE Empleado
(
    idempleado int not null PRIMARY KEY,
    nombreEmpleado VARCHAR(30) not null,
    apellido1 VARCHAR(15) not null,
    apellido2 VARCHAR(15),
    salario money not null
);
go


create or ALTER TRIGGER tg_1
on Empleado
after INSERT
as 
BEGIN
    print 'Se ejecuto el trigger tg_1, en el evento insert'
end;
go


SELECT *
FROM Empleado


insert into Empleado
values
    (2, 'Rocio', 'Cruz', 'Cervo', 80000);
GO


drop TRIGGER tg_1
go

create or alter TRIGGER tg_2
on Empleado
after INSERT
as
BEGIN
    SELECT *
    FROM inserted;
    SELECT *
    FROM deleted;
end;
GO

create or alter TRIGGER tg_3
on Empleado
after delete
as
BEGIN
    SELECT *
    FROM inserted;
    SELECT *
    FROM deleted;
end;
GO

DELETE Empleado
WHERE idempleado = 2;
go


create or alter TRIGGER tg_4
on Empleado
after update
as
BEGIN
    SELECT *
    FROM inserted;
    SELECT *
    FROM deleted;
end;
GO

UPDATE Empleado
set apellido2 = 'Vazquez',
where idempleado = 1;
GO


create or alter TRIGGER tg_5
on Empleado
after insert, delete
as
BEGIN
    if exists (select 1
    from inserted)
        BEGIN
        PRINT 'Se realizo un insert'
    END
        else if exists (SELECT 1
        from deleted) and
        not exists (SELECT 1
        from inserted)
        BEGIN
        PRINT 'Se realizo un delete'
    end
end;
GO

insert into Empleado
values
    (2, 'Lesly', 'Jimenez', 'Nery', 100000);
GO


DELETE from Empleado
WHERE idempleado = 2
go

