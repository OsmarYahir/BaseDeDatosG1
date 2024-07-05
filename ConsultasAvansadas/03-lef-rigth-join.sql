CREATE DATABASE pruebajoinsg1;

DROP DATABASE pruebajoinsg;

use pruebajoinsg

CREATE table provedor
(
    provid int not null IDENTITY(1,1),
    nombre VARCHAR(50) not null,
    limite_credito money not NULL
        CONSTRAINT pk_provedor
    PRIMARY KEY(provid),
    CONSTRAINT unico_nombrepro
    unique (nombre)
)

create table productos
(
    productid int not null identity(1,1),
    nombre varchar(50) not null,
    precio money not null,
    existencia int not null,
    provedor int,
    constraint pk_producto
 primary key(productid),
    constraint unico_nombre_provedor
 unique (nombre),
    constraint fk_provedor_producto
 foreign key(provedor)
 references provedor(provid)
);

DROP TABLE productos;

-- agregar registro 
INSERT into provedor (nombre, limite_credito)
VALUES
( 'Provedor1', 5000),
( 'Provedor2', 5500),
( 'Provedor3', 4000),
( 'Provedor4', 3500),
( 'Provedor5', 2000);


INSERT into productos (nombre, precio, existencia, provedor)
VALUES
( 'Producto1', 56,34,1),
( 'Producto2', 80,20,2),
( 'Producto3', 58,47,3),
( 'Producto4', 40,10,1),
( 'Producto5', 39,69,3);

SELECT * FROM 
provedor as p 
INNER JOIN productos as pr 
on pr.provedor = p.provid

SELECT p.nombre, p.provid FROM 
 provedor as p 
LEFT JOIN productos as pr 
on pr.provedor = p.provid
WHERE provedor in (3,5)


-- 1: Crear dos tablas, Empleados y Dmi_Empleados 