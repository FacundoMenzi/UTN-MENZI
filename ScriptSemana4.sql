USE [master]
GO
/****** Object:  Database [Carreras]    Script Date: 05/09/2022 19:39:26 ******/
CREATE DATABASE [Carreras]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Carreras', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Carreras.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Carreras_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Carreras_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Carreras] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Carreras].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Carreras] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Carreras] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Carreras] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Carreras] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Carreras] SET ARITHABORT OFF 
GO
ALTER DATABASE [Carreras] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Carreras] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Carreras] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Carreras] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Carreras] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Carreras] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Carreras] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Carreras] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Carreras] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Carreras] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Carreras] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Carreras] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Carreras] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Carreras] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Carreras] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Carreras] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Carreras] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Carreras] SET RECOVERY FULL 
GO
ALTER DATABASE [Carreras] SET  MULTI_USER 
GO
ALTER DATABASE [Carreras] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Carreras] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Carreras] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Carreras] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Carreras] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Carreras] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Carreras', N'ON'
GO
ALTER DATABASE [Carreras] SET QUERY_STORE = OFF
GO
USE [Carreras]
GO
/****** Object:  Table [dbo].[Asignaturas]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asignaturas](
	[id_asignatura] [int] IDENTITY(1,1) NOT NULL,
	[asignatura] [varchar](60) NULL,
 CONSTRAINT [pk_asignatura] PRIMARY KEY CLUSTERED 
(
	[id_asignatura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carreras]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carreras](
	[id_carrera] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](60) NULL,
	[titulo] [varchar](60) NULL,
	[estado] [int] NOT NULL,
 CONSTRAINT [pk_carrera] PRIMARY KEY CLUSTERED 
(
	[id_carrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleCarreras]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleCarreras](
	[id_carrera] [int] NOT NULL,
	[anioCursado] [int] NULL,
	[cuatrimestre] [int] NULL,
	[id_asignatura] [int] NULL,
	[id_detalle] [int] NOT NULL,
 CONSTRAINT [pk_detalle] PRIMARY KEY CLUSTERED 
(
	[id_detalle] ASC,
	[id_carrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DetalleCarreras]  WITH CHECK ADD  CONSTRAINT [fk_asignatura] FOREIGN KEY([id_asignatura])
REFERENCES [dbo].[Asignaturas] ([id_asignatura])
GO
ALTER TABLE [dbo].[DetalleCarreras] CHECK CONSTRAINT [fk_asignatura]
GO
/****** Object:  StoredProcedure [dbo].[pa_ver_asignaturas]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[pa_ver_asignaturas]
as
select * from Asignaturas ORDER BY asignatura

GO
/****** Object:  StoredProcedure [dbo].[SP_BAJA_CARRERA]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_BAJA_CARRERA]
@id_carrera int,
@estado int
as
delete from DetalleCarreras where id_carrera=@id_carrera

update Carreras set estado=@estado where id_carrera=@id_carrera

GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_CARRERA]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_BORRAR_CARRERA]
@id_carrera int
as
delete from DetalleCarreras where id_carrera=@id_carrera

delete from Carreras where id_carrera=@id_carrera

GO
/****** Object:  StoredProcedure [dbo].[SP_CANTIDAD_CARRERAS]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_CANTIDAD_CARRERAS]
@cant int output as

set @cant = (select count(id_carrera) from Carreras where estado=1)

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTAR_DETALLE]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INSERTAR_DETALLE] 
	@id_carrera int,
	@anioCursado int, 
	@cuatrimestre int, 
	@id_asignatura int,
	@id_detalle int
AS
BEGIN
	INSERT INTO DetalleCarreras(id_detalle,id_Carrera,anioCursado, cuatrimestre, id_asignatura)
    VALUES (@id_Detalle,@id_carrera, @anioCursado, @cuatrimestre, @id_asignatura);
  
END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTAR_MAESTRO]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INSERTAR_MAESTRO] 
	@nombre varchar(60),
	@titulo varchar(60),
	@id_carrera int OUTPUT
AS
BEGIN
	INSERT INTO Carreras(nombre,titulo,estado)
    VALUES (@nombre,@titulo,1);
    --Asignamos el valor del último ID autogenerado (obtenido --  
    --mediante la función SCOPE_IDENTITY() de SQLServer)	
    SET @id_carrera = SCOPE_IDENTITY();

END

GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICAR_CARRERAS]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_MODIFICAR_CARRERAS]
@id_carrera int,
@nombre varchar(60),
@titulo varchar(60)
as
UPDATE Carreras SET nombre=@nombre,titulo=@titulo where id_carrera=@id_carrera

delete from DetalleCarreras where id_carrera=@id_carrera

GO
/****** Object:  StoredProcedure [dbo].[SP_VER_CARRERAS]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_VER_CARRERAS]
as
Select * from carreras c 

GO
/****** Object:  StoredProcedure [dbo].[SP_VER_DETALLES]    Script Date: 05/09/2022 19:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_VER_DETALLES]
@idCarrera int 
as
select d.id_carrera,id_detalle,anioCursado,cuatrimestre,d.id_asignatura,a.asignatura from DetalleCarreras d join Asignaturas a on
d.id_asignatura=a.id_asignatura

where id_carrera=@idCarrera

GO
USE [master]
GO
ALTER DATABASE [Carreras] SET  READ_WRITE 
GO
