-- Lenguaje de definicion de datos (SQL-LDD)
-- crear base de datos 
create database tiendadigital;
 go

-- cambiar de base de datos
use tiendadigital;
 go

-- crear tabla provedor

create table provedor(
	provedorid int not null identity(1,1),
    numcontrol varchar(30) not null,
    nombreempresa varchar(50) not null,
    cp int not null,
    calle varchar(50) not null,
    colonia varchar(50) not null,
    numero int,
    estado varchar(50) not null ,
    telefono varchar(20),
    paginaweb varchar(30),
    constraint pk_provedor
    primary key(provedorid),
    constraint unico_numcontrol
    unique(numcontrol),
    constraint unico_nombreempresa
    unique(nombreempresa)
    
    
);
go

-- crear tabla categoria
create table categoria(
	categoriaid int not null, 
    descripcion varchar(100) not null,
    constraint ok_categoria
    primary key (categoriaid),
    constraint unico_descripcion
    unique(descripcion)
);
go


-- crear tabla producto

create table producto(
	productoid int not null identity(1,1),
    numerocontrol varchar(30) not null,
    descripcion varchar(50) not null,
    precio money not null,
    existencia int not null,
    [status] int not null,
    categoria int not null,
    constraint pk_producto
    primary key (productoid),
    constraint unico_numerocontrol
    unique (numerocontrol),
    constraint unico_descripcion_producto
    unique (descripcion),
    constraint chk_precio
    check (precio>0.0),
    constraint chk_existencia
	-- check (existencia between 1 and 2000)
    check (existencia >= 1 and existencia <=2000),
    constraint chk_status
    -- check ([status]=0 or status =1)
    check ([status] in (0,1)),
    constraint fk_producto
    foreign key (categoria)
    references categoria(categoriaid)
);
go


create table cliente(
	clienteid int not null identity(1,1),
	numerocontrol varchar(20) not null,
	nombrempresa varchar(50) not null default 'Mostrador',
	rfc varchar(20) not null,
	descripcionfiscal Varchar(100) not null,
	limitecredito money,
	constraint pk_cliente
	primary key(clienteid),
	constraint unico_numerocontrol_cliente
	unique (numerocontrol),
	constraint inico_rfc
	unique (rfc),
	constraint chk_limite_credito
	check (limitecredito >= 0 and limitecredito <=100000)
);
go

create table empleado(
	empleadoid int not null identity(1,1),
	numeronomina int not null,
	nombrecompleto varchar(50) not null,
	apellido1 varchar(20) not null,
	apellido2 varchar(20) null,
	rfc varchar(20) not null,
	curp varchar(20) not null,
	salario money not null,
	constraint pk_empleado
	primary key (empleadoid),
	constraint unico_numero
	unique (numeronomina),
	constraint unico_rfc
	unique (rfc),
	constraint inco_curp
	unique (curp),
	constraint chk_salario
	check (salario >0.0)
);
go

-- crear tabla 
create table ordencompra(
	compraid int not null identity (1,1),
	fechaorden date not null,
	fechaentrega date not null,
	clienteid int not null,
	empleadoid int not null,
	constraint pk_ordencompra
	primary key (compraid),
	constraint fk_ordencompra_cliente
	foreign key (clienteid)
	references cliente(clienteid),
	constraint fk_ordencompra_empleado
	foreign key (empleadoid)
	references empleado(empleadoid)
);
go


create table detalleorden(
	ordenid int not null,
	productoid int not null,
	cantidad int not null,
	preciocompra money not null,
	constraint pk_detalleorden
	primary key (ordenid, productoid),
	constraint fk_detalleorden_compra
	foreign key (ordenid)
	references ordencompra(compraid),
	constraint fk_detalleorden_producto
	foreign key (productoid)
	references producto(productoid)
);
go

create table contactoprovedor(
	contactoid int not null,
	provedorid int not null,
	nombrecompleto varchar(50) not null,
	apallido1 varchar(20) not null,
	apellido2 varchar(20),
	constraint pk_contacto_provedor
	primary key (contactoid, provedorid),
	constraint fk_contactoprovedor_prov
	foreign key (provedorid)
	references provedor(provedorid)
);
go


create table telefonocontacto(
	telefonoid int not null,
	contactoid int not null,
	provedorid int not null,
	numerotelefono varchar(20) not null

);
go

alter table telefonocontacto
add constraint pk_telefonocontacto
primary key (telefonoid)

alter table telefonocontacto
add constraint fk_telefonocontacto_contactoprovedor
foreign key (contactoid,provedorid)
references contactoprovedor(contactoid

alter table producto
add provedorid int not null


alter table producto
add constraint fk_producto_provedor
foreign key (provedorid)
references provedor (provedorid)

-- elimina un constraint 
--alter table telefonocontacto
--drop pk_telefonocontacto


