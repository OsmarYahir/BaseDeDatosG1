--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE

USE NORTHWND;
GO

create DATABASE mergeEscuelita;
GO

use mergeEscuelita;
GO


CREATE TABLE StudentsC1
(
    StudentID INT
    ,
    StudentName VARCHAR(50)
    ,
    StudentStatus BIT
);
GO

INSERT INTO StudentsC1
    (StudentID, StudentName, StudentStatus)
VALUES(1, 'Axel Romero', 1)
INSERT INTO StudentsC1
    (StudentID, StudentName, StudentStatus)
VALUES(2, 'Sofía Mora', 1)
INSERT INTO StudentsC1
    (StudentID, StudentName, StudentStatus)
VALUES(3, 'Rogelio Rojas', 0)
INSERT INTO StudentsC1
    (StudentID, StudentName, StudentStatus)
VALUES(4, 'Mariana Rosas', 1)
INSERT INTO StudentsC1
    (StudentID, StudentName, StudentStatus)
VALUES(5, 'Roman Zavaleta', 1)

CREATE TABLE StudentsC2
(
    StudentID INT
    ,
    StudentName VARCHAR(50)
    ,
    StudentStatus BIT
);
go


SELECT *
from StudentsC1;
go
SELECT *
FROM StudentsC2;
go


select *
FROM
    StudentsC1 as c1
    INNER JOIN
    StudentsC2 as c2
    on c1.StudentID = c2.StudentID
go

select c1.StudentID, c1.StudentName, c1.StudentStatus
FROM
    StudentsC1 as c1
    LEFT JOIN
    StudentsC2 as c2
    on c1.StudentID = c2.StudentID
where c2.StudentID IS NULL
go


INSERT into StudentsC2
values
    (1, 'Axel Romero', 0);
GO

TRUNCATE TABLE StudentsC2 
go
------------------------------- Store proc
-- Store proc que agrega y actualiza los registros nuevos y registros modificados
-- de la tabla studentsc1 a studetdc2 utilizando consultas join y left 

create or ALTER PROC spu_carga_delta_c1_c2
as
BEGIN
    --programacion del store 
    begin TRANSACTION;
    BEGIN TRY
    --procdimiento exitosa
    --insertar nuevos registros de la tabla c1 a c2
    INSERT into StudentsC2
        (StudentID,StudentName,StudentStatus)
    select c1.StudentID, c1.StudentName, c1.StudentStatus
    FROM
        StudentsC1 as c1
        LEFT JOIN
        StudentsC2 as c2
        on c1.StudentID = c2.StudentID
    where c2.StudentID IS NULL

    --Se actualizan los registros que han tenido algun cambio en la tabla source(Studentc1)
    --se cambian en la tabla target(Studentc2)
    UPDATE c2 
    set c2.StudentName = c1.StudentName,
    c2.StudentStatus = c1.StudentStatus
    FROM
        StudentsC1 as c1
        INNER JOIN
        StudentsC2 as c2
        on c1.StudentID = c2.StudentID

    --confirmar la transaccion 
    commit transaction;

end TRY
    BEGIN CATCH
        DECLARE @mensajeError VARCHAR(100);
        set @mensajeError = ERROR_MESSAGE();
        PRINT @mensajeError;
end CATCH;
END;
go


exec spu_carga_delta_c1_c2



select *
FROM
    StudentsC1 as c1
    INNER JOIN
    StudentsC2 as c2
    on c1.StudentID = c2.StudentID
go

select c1.StudentID, c1.StudentName, c1.StudentStatus
FROM
    StudentsC1 as c1
    LEFT JOIN
    StudentsC2 as c2
    on c1.StudentID = c2.StudentID
where c2.StudentID IS NULL
go


select * FROM StudentsC1
SELECT * FROM StudentsC2


UPDATE StudentsC1
set StudentName = 'Axel ramera'
WHERE StudentID = 1;
GO

UPDATE StudentsC1
set StudentStatus = 1
WHERE StudentID = 3;
GO

UPDATE StudentsC1
set StudentStatus = 0
WHERE StudentID in (1,4,5);
GO

INSERT into StudentsC1
VALUES (6,'Monico Herrea',0);
GO

------------------------------- Store proc
-- Store proc que agrega y actualiza los registros nuevos y registros modificados
-- de la tabla studentsc1 a studetdc2 utilizando consultas join y left 
-- utilizando la funcion marge 

----------------------SP--------------


--Store porcedure que agraga y actualiza los registros nuevos y resgistros modificados de la tabla studentsc1 a studentsc2
--utilizando la funcion merge
go

create or alter proc spu_cargaDelta_s1_s2_merge
as
begin 

  begin transaction;
    begin try;
	    merge into  studentsc2 as TGT
		using (
		 select studentID, Studentname,StudentStatus 
		 from StudentsC1
		) as SRC
		on(
         TGT.studentid = SRC.studentid		
		)
		--Para actualizar
		when matched then 
		update set TGT.StudentName= SRC.studentname, 
		           TGT.studentStatus = SRC.studentstatus
		--Para insertar 
		when not matched then
		insert (studentid,studentname,studentstatus)
		values (SRC.studentid, SRC.studentname,SRC.studentstatus);


	  --Confirmar la transacion
	  commit transaction;
	end try

	begin catch;
	  declare @mensaError varchar (100);
	  set @mensaError = ERROR_MESSAGE();
	  print @mensaError;
	end catch;
end;
go

truncate table Studentsc2

select * from StudentsC1
select * from StudentsC2

exec spu_cargaDelta_s1_s2_merge

update StudentsC1 
set StudentName = 'Juana de Armas'
where StudentID = 2

GO

---delete 

CREATE OR ALTER PROCEDURE spu_carga_delete
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus)
        SELECT c1.StudentID, c1.StudentName, c1.StudentStatus
        FROM StudentsC1 AS c1
        LEFT JOIN StudentsC2 AS c2
        ON c1.StudentID = c2.StudentID 
        WHERE c2.StudentID IS NULL;

        UPDATE c2
        SET c2.StudentName = c1.StudentName,
            c2.StudentStatus = c1.StudentStatus
        FROM StudentsC1 AS c1
        INNER JOIN StudentsC2 AS c2
        ON c1.StudentID = c2.StudentID;

        DELETE c2
        FROM StudentsC2 AS c2
        LEFT JOIN StudentsC1 AS c1
        ON c2.StudentID = c1.StudentID
        WHERE c1.StudentID IS NULL;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @mensajeError VARCHAR(100);
        SET @mensajeError = ERROR_MESSAGE();
        PRINT @mensajeError;
    END CATCH;
END;

EXEC spu_carga_delete;

select*from StudentsC1;
select*from StudentsC2;
GO

create or alter PROC spu_limpiar_tablas
@nombretabla NVARCHAR(50)
as
BEGIN
    declare @sql NVARCHAR(50)
    set @sql = 'truncate table '+@nombretabla
    exec(@sql)
END
go