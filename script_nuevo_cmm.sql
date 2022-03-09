USE [master]
GO

create database db_cmm
go

use db_cmm
go



create table historico
(
	id_historico int identity(1,1) primary key,
	id_departamento int,
	id_proceso int,
	accion varchar(100),
	fecha datetime,
	id_empleado int
)
go







--Creacion de tabla PROCESOS
 create table procesos
	(
		id_proceso int identity(1,1) primary key,
		nombre varchar(100),
		descripcion varchar(250) not null,
		id_departamento int,
		id_nivel int,
		inicial varchar(250),
		repetible varchar(250),
		definido varchar(250),
		gestionado varchar(250),
		optimizado varchar(250),
		id_empleado int,
		fecha_creacion date,
		estado int  --estado 1 'activo' estado 0 'archivado'

	)
go

--Creacion tabla de niveles
create table niveles
(
	id_nivel int primary key,
	descripcion varchar(500) not null,

)
go

--creatacion table Departamento
create table Departamentos
(
	id_departamento int identity(1,1) primary key,
	nombre varchar(50) not null,
	codigo varchar(50) not null
)
go


--Creacion de la tabla de Puestos
create table perfil
(
  id_perfil int identity(1,1) primary key,
  nombre varchar(50),
  
)
go


--creacion Tabla Auditorias
create table auditorias
(
	
	id_auditoria int identity(1,1) primary key,
	usuario varchar(20) not null,
	codigo_departamento varchar (50) not null,
	id_proceso int not null,
	hallazgos varchar(256) not null,
	recomendaciones varchar(256) not null,
	fecha_limite date, 
	fecha_auditoria date	
) 
go





create table Empleados
(
	id_empleado int identity(1,1) primary key not null,
	nombre varchar(50) not null,
	apellido1 varchar(50) not null,
	apellido2 varchar(50) not null,
	cedula varchar(50) not null,
    telefono varchar(20) not null,
    correo varchar(100) not null,
	usuario varchar(20) not null,
	pass varchar(20) not null,
	id_perfil int not null,
	id_departamento int not null,

)
go

--Creacion de procedimientos 
 

 
CREATE PROCEDURE [dbo].[CONSULTAEMPLEADOPERFIL]
as
SELECT E.nombre, E.apellido1,E.apellido2,E.usuario,E.pass ,P.nombre
FROM Empleados AS E
JOIN perfil AS P
ON E.id_perfil = P.id_perfil
WHERE usuario = E.usuario AND pass = E.pass
GO


 
CREATE PROCEDURE [dbo].[CONSULTA_EMPLEADOS]
(
       @id_empleado INT
      ,@nombre VARCHAR(50)
      ,@apellido1 VARCHAR(50)
      ,@apellido2 VARCHAR(50)
      ,@cedula VARCHAR(50)
      ,@telefono VARCHAR(50)
      ,@correo VARCHAR(100)
      ,@usuario VARCHAR(20)
      ,@pass VARCHAR(20)
      ,@id_perfil INT
      ,@id_departamento INT
)
AS
BEGIN 
SELECT [id_empleado]
      ,[nombre]
      ,[apellido1]
      ,[apellido2]
      ,[cedula]
      ,[telefono]
      ,[correo]
      ,[usuario]
      ,[pass]
      ,[id_perfil]
      ,[id_departamento]
  FROM [dbo].[Empleados]
  END
  go




CREATE PROCEDURE [dbo].[SP_FILTRAR_Departamentos]
(
@nombre varchar(50)
)
as
begin
SELECT  E.id_departamento AS [Número Departamento],E.nombre AS [Nombre Departamento], E.codigo AS Codigo
FROM Departamentos AS E
WHERE e.nombre LIKE '%'+@Nombre+'%' or LEN(ISNULL(@nombre, '')) = 0
END
GO



CREATE PROCEDURE [dbo].[sp_INSERTAR_DEPARTAMENTOS]

@nombre varchar(50),
@codigo varchar(50)


as insert into Departamentos(nombre,codigo)
values (@nombre,@codigo)
GO
 
 CREATE PROCEDURE CONSULTA_PERFILES
AS
BEGIN
SELECT [nombre]
  FROM [dbo].[perfil]
  END 
GO

CREATE PROCEDURE CONSULTA_DEPARTAMENTOS
AS
BEGIN
SELECT [nombre]
  FROM [dbo].[Departamentos]
  END 
GO


CREATE PROCEDURE [dbo].[SP_FILTRAR_EMPLEADOS]
(
@nombre varchar(50)
)
as
begin
SELECT E.id_empleado AS [Número Usuario], E.nombre AS Nombre, E.apellido1 AS [Primer Apellido],E.apellido2 AS [Segundo Apellido],E.cedula AS Cédula,E.telefono AS Teléfono,E.correo AS Correo,E.usuario AS Usuario,P.nombre as Perfil, D.nombre as Departamento 
FROM Empleados AS E
INNER JOIN perfil AS P ON P.id_perfil = E.id_perfil
INNER JOIN Departamentos as D on D.id_departamento = E.id_departamento
WHERE e.nombre LIKE '%'+@Nombre+'%' or LEN(ISNULL(@nombre, '')) = 0

END
GO



CREATE PROCEDURE CONSULTA_DEPARTAMENTO_CODIGOS
AS
BEGIN
SELECT [codigo]
  FROM [dbo].[Departamentos]
  END
GO

CREATE PROCEDURE [dbo].[sp_insertar_empleados]

@nombre varchar(50),
@apellido1 varchar(50),
@apellido2 varchar(50),
@cedula varchar(50),
@telefono varchar(20),
@correo varchar(100),
@usuario varchar(20),
@pass varchar(20),
@perfil int,
@departamento int
AS
BEGIN
insert into Empleados(nombre,apellido1,apellido2,cedula,telefono,correo,usuario,pass,id_perfil,id_departamento)
values (@nombre,@apellido1,@apellido2,@cedula,@telefono,@correo,@usuario,@pass,@perfil,@departamento)
END
GO


CREATE PROCEDURE [dbo].[sp_Agregar_empleados]

@nombre varchar(50),
@apellido1 varchar(50),
@apellido2 varchar(50),
@cedula varchar(50),
@telefono varchar(20),
@correo varchar(100),
@usuario varchar(20),
@perfil int,
@departamento int
AS
BEGIN
insert into Empleados(nombre,apellido1,apellido2,cedula,telefono,correo,usuario,id_perfil,id_departamento)
values (@nombre,@apellido1,@apellido2,@cedula,@telefono,@correo,@usuario,@perfil,@departamento)
END
GO


CREATE PROCEDURE sp_actualizar_empleado
@id_empleado int,
@nombre varchar(50),
@apellido1 varchar(50),
@apellido2 varchar(50),
@cedula varchar(50),
@telefono varchar(20),
@correo varchar(100),
@usuario varchar(20),
@perfil int,
@departamento int
AS
BEGIN
UPDATE [dbo].[Empleados]
   SET [nombre] = @nombre 
      ,[apellido1] = @apellido1
      ,[apellido2] =@apellido2
      ,[cedula] = @cedula
      ,[telefono] =@telefono
      ,[correo] = @correo
      ,[usuario] = @usuario      
      ,[id_perfil] =@perfil
      ,[id_departamento] = @departamento
 WHERE  id_empleado = @id_empleado
 END
GO




-------



CREATE PROCEDURE [dbo].[sp_login]
@usuario varchar(20),
@pass varchar(20)

AS
BEGIN

SELECT * FROM  Empleados 
WHERE usuario = @usuario COLLATE SQL_Latin1_General_CP1_CS_AS AND pass = @pass COLLATE SQL_Latin1_General_CP1_CS_AS

END
GO


-----
CREATE PROCEDURE [dbo].[SP_MODIFICAR_DEPARTAMENTOS] 
(
@id_departamento int,
@nombre varchar(50),
@codigo varchar(50)
)
AS
BEGIN
UPDATE [dbo].[Departamentos]
   SET [nombre] = @nombre
      ,[codigo] = @codigo
 WHERE id_departamento = @id_departamento
 END

GO



create procedure  [dbo].[SP_olvido_passwor]
(
@userRequesting varchar(20)
)
as
begin
select nombre,correo,cedula  from Empleados e where e.usuario=@userRequesting or e.correo=@userRequesting
end
go


create procedure [dbo].[SP_cambio_password]
(
@cedula varchar(50),
@pass varchar(20)
)
as 
begin
UPDATE [dbo].[Empleados]
   SET [pass] = @pass
      
 WHERE cedula = @cedula
 END
 go



 

CREATE PROCEDURE [dbo].[SP_CONSULTA_PROCESOS_descripcion]
(
@descripcion varchar(50)

)
as
begin
SELECT p.nombre AS Nombre,p.id_proceso AS [Número Proceso],p.descripcion AS Descripción,p.id_nivel as [Valor Actual],p.inicial AS Inicial,p.repetible AS Repetible,p.definido AS Definido,p.gestionado AS Gestionado,
p.optimizado AS Optimizado,e.usuario AS Usuario,p.fecha_creacion AS [Fecha Creación]
FROM procesos p
INNER JOIN Empleados e ON p.id_empleado= e.id_empleado 
INNER JOIN Departamentos d on p.id_departamento = d.id_departamento
WHERE (p.descripcion LIKE '%'+@descripcion+'%' or LEN(ISNULL(@descripcion, '')) = 0) AND  p.estado=1
END
GO





CREATE PROCEDURE [dbo].[SP_CONSULTA_PROCESOS_niveles]
(
@nivel int

)
as
begin
SELECT p.nombre AS Nombre,p.id_proceso AS [Número Proceso],p.descripcion AS Descripción,p.id_nivel as [Valor Actual],p.inicial AS Inicial,p.repetible AS Repetible,p.definido AS Definido,p.gestionado AS Gestionado,
p.optimizado AS Optimizado,e.usuario AS Usuario,p.fecha_creacion AS [Fecha Creación]
FROM procesos p
INNER JOIN Empleados e ON p.id_empleado= e.id_empleado 
INNER JOIN Departamentos d on p.id_departamento = d.id_departamento
WHERE p.id_nivel =@nivel AND  p.estado=1 
END
GO




CREATE PROCEDURE [dbo].[SP_CONSULTA_PROCESOS]
as
begin
SELECT p.nombre as [Código Departamento] ,p.id_proceso AS [Número Proceso],p.descripcion AS Descripción ,p.id_nivel as [Valor Actual],p.inicial AS Inicial ,p.repetible AS Repetible,p.definido AS Definido,p.gestionado AS Gestionado,
p.optimizado AS Optimizado,e.usuario AS Usuario,p.fecha_creacion AS [Fecha Creación]
FROM procesos p
INNER JOIN Empleados e ON p.id_empleado= e.id_empleado 
INNER JOIN Departamentos d on p.id_departamento = d.id_departamento
 WHERE p.estado=1
END
GO




create PROCEDURE [dbo].[SP_CONSULTA_NIVELES]

as
begin
SELECT * FROM niveles
END
GO



CREATE PROCEDURE  [dbo].[SP_AGREGAR_AUDITORIAS]
(
@usuario varchar(20),
@codigo_departamento varchar(50),
@id_proceso int,
@hallazgos varchar(256),
@recomendaciones varchar(256),
@fecha_limite date,
@fecha_auditoria date
)
AS
BEGIN
INSERT INTO [dbo].[auditorias]
           ([usuario]
           ,[codigo_departamento]
           ,[id_proceso]
           ,[hallazgos]
           ,[recomendaciones]
           ,[fecha_limite]
           ,[fecha_auditoria])
     VALUES
           (@usuario, 
            @codigo_departamento ,
			@id_proceso ,
			@hallazgos,
			@recomendaciones ,
			@fecha_limite ,
			@fecha_auditoria )
END

GO
CREATE PROCEDURE SP_EDITAR_NIVELES
(
@id_nivel int,
@descripcion varchar(50)
)
AS
BEGIN
UPDATE [dbo].[niveles]
   SET [descripcion] = @descripcion
 WHERE id_nivel =@id_nivel
 end
GO


CREATE PROCEDURE [dbo].[AGREGAR_PROCESOS]
(
@nombre varchar(100),
@descripcion varchar(250),
@id_departamento int,
@id_nivel int,
@inicial varchar(250),
@repetible varchar(250),
@definido varchar(250),
@gestionado varchar(250),
@optimizado varchar(250),
@id_empleado int,
@fecha_creacion date,
@estado int

)
AS
BEGIN
INSERT INTO [dbo].[procesos]
           ([nombre]
           ,[descripcion]  
		   ,[id_departamento]
           ,[id_nivel]
           ,[inicial]
           ,[repetible]
           ,[definido]
           ,[gestionado]
           ,[optimizado]
           ,[id_empleado]
           ,[fecha_creacion]
           ,[estado])
     VALUES
           (@nombre
           ,@descripcion
		   ,@id_departamento
           ,@id_nivel
           ,@inicial
           ,@repetible
           ,@definido
           ,@gestionado
           ,@optimizado
           ,@id_empleado
           ,GETDATE()
           ,@estado
		   )
		   END
GO

CREATE PROCEDURE [dbo].[MODIFICAR_PROCESO]
(
@id_proceso int,
@id_nivel int,
@estado int
)
AS
BEGIN
UPDATE [dbo].[procesos]
   SET [id_nivel] = @id_nivel      
      ,[estado] = @estado
 WHERE id_proceso = @id_proceso
 END 
 GO



CREATE PROCEDURE CANTIDAD_PROCESOS
as
begin
SELECT COUNT(id_proceso) from procesos
  END
GO

CREATE PROCEDURE CANTIDAD_PROCESOS_ACTIVOS
as
begin
SELECT COUNT(estado) from procesos where estado=1
  END
GO


CREATE PROCEDURE CANTIDAD_PROCESOS_ARCHIVADOS
as
begin
SELECT COUNT(estado) from procesos where estado=0
  END
  go


  CREATE PROCEDURE [dbo].[SP_CONSULTA_PROCESOS_ARCHIVADOS]

as
begin
SELECT p.nombre AS [Código Departamento],p.id_proceso AS [Número Proceso],p.descripcion AS Descripción,p.id_nivel AS [Valor Actual],p.inicial AS Inicial,p.repetible AS Repetible,p.definido AS Definido,p.gestionado AS Gestionado,
p.optimizado AS Optimizado,e.usuario AS Usuario,p.fecha_creacion AS [Fecha Creación]
FROM procesos p
INNER JOIN Empleados e ON p.id_empleado= e.id_empleado 
INNER JOIN Departamentos d on p.id_departamento = d.id_departamento
 WHERE p.estado=0
END
GO




create PROCEDURE [dbo].[SP_CONSULTA_AUDITORIAS]
as
begin
select A.id_auditoria AS Número, A.usuario AS Usuario, A.codigo_departamento AS [Codigo Departamento], A.id_proceso AS [Número Proceso], A.hallazgos AS Hallazgos, A.recomendaciones AS Recomendaciones, A.fecha_limite AS [Fecha Límite],
A.fecha_auditoria AS [Fecha Auditoria]
from auditorias A
END
GO




CREATE PROCEDURE [dbo].[SP_CONSULTA_AUDITORIAS_CODIGO]
(
@codigo VARCHAR(50)
)
as
begin
select a.id_auditoria AS Número, a.usuario AS Usuario, a.codigo_departamento AS [Código Departamento],a.id_proceso AS [Número Proceso],a.hallazgos AS Hallazgos, a.recomendaciones AS Recomendaciones,
a.fecha_limite AS [Fecha Límite], a.fecha_auditoria AS [Fecha Auditoría] FROM auditorias a
WHERE a.codigo_departamento = @codigo 
END
go


CREATE PROCEDURE [dbo].[SP_CONSULTA_PROCESOS_ARCHIVADOS_DESCRIPCION]
(
@descripcion varchar(250)
)
as
begin
SELECT p.nombre AS [Código Departamento],p.id_proceso AS [Número Proceso],p.descripcion AS Descripción,p.id_nivel as [Valor Actual],p.inicial AS Inicial,p.repetible AS Repetible,p.definido AS Definido,p.gestionado AS Gestionado,
p.optimizado AS Optimizado,e.usuario AS Optimizado,p.fecha_creacion AS [Fecha Creación]
FROM procesos p
INNER JOIN Empleados e ON p.id_empleado= e.id_empleado 
INNER JOIN Departamentos d on p.id_departamento = d.id_departamento
 WHERE p.estado=0 and p.descripcion LIKE '%'+@descripcion+'%' or  p.estado=0 and LEN(ISNULL(@descripcion, '')) = 0
 
END
go



CREATE PROCEDURE [dbo].[CONSULTA_CORREOS]

AS
BEGIN 
SELECT E.correo
       FROM Empleados E
  WHERE E.id_perfil=3 
  END
  GO




  
CREATE PROCEDURE [dbo].[SP_CONSULTA_AUDITORIAS_POR_IDPROCESO]
(
@idProceso int
)
as
begin
select a.id_auditoria AS Número, a.usuario AS Usuario, a.codigo_departamento AS [Código Departamento],a.id_proceso AS[ Número Proceso],a.hallazgos AS Hallazgos, a.recomendaciones AS Recomendaciones,
a.fecha_limite AS [Fecha Límite], a.fecha_auditoria AS [Fecha Auditoría] FROM auditorias a
WHERE a.id_proceso = @idProceso 
END
go



--Creacion de Llaves foraneas/relaciones entre tablas.

--alter table procesos
--add constraint FK_empleado_procesos
--foreign key (id_empleado) references empleados(id_empleado)

--go


--alter table procesos
--add constraint FK_nivel_proceso
--foreign key (id_nivel) references niveles(id_nivel)
--go




--alter table procesos
--add constraint FK_idDepartamento_proceso
--foreign key (id_departamento) references DEPARTAMENTOS (id_departamento)
--go




alter table empleados
add constraint FK_detalle_puesto_empleado
foreign key (id_perfil) references perfil(id_perfil)
on update cascade
on delete cascade
go

alter table empleados
add constraint FK_detalle_departamento
foreign key (id_departamento) references departamentos(id_departamento)
on update cascade
on delete cascade
go

alter table auditorias
add constraint FK_detalle_proceso
foreign key (id_proceso) references procesos(id_proceso)
--on update cascade
--on delete cascade
go

--inserts

INSERT INTO [dbo].[perfil]
           ([nombre])
     VALUES
           ('Administrador')
GO

INSERT INTO [dbo].[perfil]
           ([nombre])
     VALUES
           ('Auditor')
GO

INSERT INTO [dbo].[perfil]
           ([nombre])
     VALUES
           ('Usuario')
GO


INSERT INTO [dbo].[Departamentos]
           ([nombre]
           ,[codigo])
     VALUES
           ('Soporte','SPT')
GO



INSERT INTO [dbo].[Departamentos]
           ([nombre]
           ,[codigo])
     VALUES
           ('Auditoria',
           'ADT')
GO



INSERT INTO [dbo].[niveles]
           ([id_nivel]
           ,[descripcion])
     VALUES
           (1,'1-Inicial: No existe ningun modelo y no se emplea ningun proceso definido.')
GO

INSERT INTO [dbo].[niveles]
           ([id_nivel]
           ,[descripcion])
     VALUES
           (2,'2-Repetible: Existe planificación y seguimiento de proyectos y está implementada su gestión.')
GO

INSERT INTO [dbo].[niveles]
           ([id_nivel]
           ,[descripcion])
     VALUES
           (3,'3-Definido: Documenta y normaliza los procesos a nivel organizativo.')
GO

INSERT INTO [dbo].[niveles]
           ([id_nivel]
           ,[descripcion])
     VALUES
           (4,'4-Gestionado: Enfocado en la gestión de calidad del proceso y del producto.')
GO



INSERT INTO [dbo].[niveles]
           ([id_nivel]
           ,[descripcion])
     VALUES
           (5,'5-Optimizado: Proceso continuo de mejora.')
GO


exec dbo.sp_insertar_empleados 'Geiner','Sánchez','Barboza','114260597','60205084','geinersb20@gmail.com','Admin','Admin',1,1
exec dbo.sp_insertar_empleados 'Pedro','Oporta','Solis','785961274','85253614','cavaal93@gmail.com','pedro','pedro00',2,2
exec dbo.sp_insertar_empleados 'Lucia','Guerra','Baez','526347817','81524748','cavu93@hotmail.com','lucia','lucia00',3,1
exec dbo.sp_insertar_empleados 'Juan','Zamora','Solis','401457841','85259371','cavaal93@gmail.com','juan','juan00',3,2



INSERT INTO [dbo].[procesos]
           ([nombre]
           ,[descripcion]
           ,[id_departamento]
           ,[id_nivel]
           ,[inicial]
           ,[repetible]
           ,[definido]
           ,[gestionado]
           ,[optimizado]
           ,[id_empleado]
           ,[fecha_creacion]
           ,[estado])
     VALUES
           ('SPT','Lista de tickets',1,4,'No hay lista de tickets asignados',
		   'Se tiene una lista obsoleta de tickets','Se tiene una lista actualizada de los tickets',
		   'Se tiene en board todos los tickets asignados','en la aplicacion jira estan los tickets para cada usuario',1,  GETDATE()  ,1)
GO



INSERT INTO [dbo].[procesos]
           ([nombre]
           ,[descripcion]
           ,[id_departamento]
           ,[id_nivel]
           ,[inicial]
           ,[repetible]
           ,[definido]
           ,[gestionado]
           ,[optimizado]
           ,[id_empleado]
           ,[fecha_creacion]
           ,[estado])
     VALUES
           ('ADT','Gestion de usuarios',2,2,'No hay lista de usuarios ni gestionamineto centralizado',
		   'Se tiene una lista obsoleta de usuarios locales','Se tiene una lista actualizada de los usuarios',
		   'Se tiene Active Directory con todos los usuarios','Se tiene usuarios,grupos,en un AD FS',1,  GETDATE()  ,1)
GO
