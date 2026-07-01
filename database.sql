USE master;
GO

-- 1. Creamos la base de datos si no existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DBVentas')
BEGIN
    CREATE DATABASE DBVentas;
END
GO

USE DBVentas;
GO

-- 2. Tabla Cliente
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cliente]') AND type in (N'U'))
BEGIN
    CREATE TABLE Cliente (
        id INT IDENTITY(1,1) PRIMARY KEY,
        dni VARCHAR(10) NOT NULL UNIQUE,
        nombres VARCHAR(50) NOT NULL,
        apellidoPaterno VARCHAR(50) NOT NULL,
        apellidoMaterno VARCHAR(50) NOT NULL,
        telefono VARCHAR(10),
        correo VARCHAR(50),
        estado CHAR(1) DEFAULT 'A' -- 'A' de Activo, 'I' de Inactivo
    );
END
GO

-- 3. Tabla Producto
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Producto]') AND type in (N'U'))
BEGIN
    CREATE TABLE Producto (
        id INT IDENTITY(1,1) PRIMARY KEY,
        codigoSKU VARCHAR(20) NOT NULL UNIQUE,
        nombre VARCHAR(50) NOT NULL,
        descripcion VARCHAR(200),
        stock INT NOT NULL DEFAULT 0,
        precio DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
        estado CHAR(1) DEFAULT 'A' -- 'A' de Activo, 'I' de Inactivo
    );
END
GO

-- 4. Tabla Categoria
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categoria]') AND type in (N'U'))
BEGIN
    CREATE TABLE Categoria (
        id            INT IDENTITY(1,1) PRIMARY KEY,
        nombre        VARCHAR(50)  NOT NULL UNIQUE,
        descripcion   VARCHAR(200) NULL,
        estado        CHAR(1)      NOT NULL DEFAULT 'A' CHECK (estado IN ('A', 'I'))
    );
END
GO
