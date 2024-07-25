
use NORTHWND;

--transaccion: Las transacciones en sql server son fundanmentales
--  para asegurar la consistencia y la integirdad de los datos,
-- en una base de datos


-- Una transaccion es una unidad de trabajo que se ejecuta de maneera 
-- completamemnte exitosa o no se ejecuta en absoluto 

-- Sigue el principio ACID 
	--Atomicidad: Toda la transaccion se completa o no se realiza nada 
	--Consistencia:La transaccion lleva la base de datos de un estado valido a otro 
	--Aislamiento: las transacciones cocurrentes no intervienen entre si 
	--Durabilidad: Una vez que una transaccion se completa los cambios son permanentes 

	--Comandos a utilizar 
		--Begin transaction: Inicia una nueva transaccion
		--Comiit Transaction: confirma todos los cambios realizado durante la transaccion
		--Rollback Transaction: Revierte todos los cambios realizados durante la transaccion 

	select * from Categories;
	go

	--delete from Categories
	--where CategoryID in (10,12)

	begin transaction;

	insert into Categories(CategoryName, Description)
	values('Los remedilaes','Estara muy bien');
	go

	delete from Categories
	where CategoryID = 10

	rollback transaction;


	commit transaction;


	create database prueba_transacciones;
	go

	use prueba_transacciones;
	go

	create table empleado(
	emplid int not null,
	nombre varchar(30) not null,
	salario money not null,
	constraint pk_empleado
	primary key (emplid),
	constraint chk_salario
	check(salario>0.0 and salario<=50000)
	);


create or alter proc spu_agregar_empleado
    -- parámetros de entrada
    @emplid int,
    @nombre varchar(30),
    @salario money
as
begin
    begin try
        begin transaction;

        insert into empleado (emplid, nombre, salario)
        values (@emplid, @nombre, @salario);
        
        -- Confirma la transacción
        commit transaction;
    end try
    begin catch
        -- Deshace la transacción en caso de error
        rollback transaction;

        -- Obtener el error 
        declare @mensajeError nvarchar(4000);
        set @mensajeError = ERROR_MESSAGE();
        print @mensajeError;
    end catch
end;
go


exec spu_agregar_empleado 1, 'Monico',2100.00;
go 

exec spu_agregar_empleado 2, 'Toribio',-60000.00;
go 


select * from empleado;
go

