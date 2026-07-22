-- SCRIPT DE CREACIÓN DE BASE DE DATOS Y TABLAS (SQL SERVER)
CREATE DATABASE BD_TecnoStock;
GO

USE BD_TecnoStock;
GO

-- 1. Tabla Sucursal (Entidad Independiente)
CREATE TABLE Sucursal (
    id_sucursal INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    direccion VARCHAR(250) NOT NULL,
    telefono VARCHAR(20) NULL,
    estado VARCHAR(20) NOT NULL -- Ej: 'Activo', 'Inactivo'
);
GO

-- 2. Tabla Categoria
CREATE TABLE Categoria (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
GO

-- 3. Tabla Producto (Relación Muchos a Uno con Categoria)
CREATE TABLE Producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT FK_Producto_Categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);
GO

-- Poblado de prueba obligatorio para Categorías
INSERT INTO Categoria (nombre) VALUES ('Tecnología'), ('Hogar'), ('Línea Blanca'), ('Accesorios');
GO

-- 4. Tabla Usuario
CREATE TABLE Usuario (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasenha VARCHAR(150) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    nombres VARCHAR(150) NOT NULL,
    apellidos VARCHAR(150) NOT NULL
);
GO

-- Poblado de prueba obligatorio para Usuarios
INSERT INTO Usuario (correo, contrasenha, estado, nombres, apellidos)
VALUES ('admin@tecnostock.com', 'admin123', 'Activo', 'Administrador', 'TecnoStock');
GO

-- 5. Tabla Cliente
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cliente]') AND type in (N'U'))
BEGIN
    CREATE TABLE Cliente (
        id INT IDENTITY(1,1) PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        apellidoPaterno VARCHAR(100) NOT NULL,
        apellidoMaterno VARCHAR(100) NOT NULL,
        dni VARCHAR(15) NOT NULL UNIQUE,
        direccion VARCHAR(250) NULL,
        estado VARCHAR(20) NOT NULL DEFAULT 'A'
    );
END
GO

-- Poblado de prueba para Clientes
INSERT INTO Cliente (nombre, apellidoPaterno, apellidoMaterno, dni, direccion, estado)
VALUES ('Juan', 'Perez', 'Gomez', '12345678', 'Av. Larco 123, Miraflores', 'A');
INSERT INTO Cliente (nombre, apellidoPaterno, apellidoMaterno, dni, direccion, estado)
VALUES ('Maria', 'Rodriguez', 'Lopez', '87654321', 'Calle San Martin 456, San Isidro', 'A');
GO

-- 6. Tabla Proveedor
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Proveedor]') AND type in (N'U'))
BEGIN
    CREATE TABLE Proveedor (
        id INT IDENTITY(1,1) PRIMARY KEY,
        ruc VARCHAR(20) NOT NULL UNIQUE,
        razonSocial VARCHAR(150) NOT NULL,
        direccion VARCHAR(200) NULL,
        telefono VARCHAR(20) NULL,
        nombreContacto VARCHAR(100) NULL,
        estado VARCHAR(20) NOT NULL DEFAULT 'Activo'
    );
END
GO

-- Poblado de prueba para Proveedores
INSERT INTO Proveedor (ruc, razonSocial, direccion, telefono, nombreContacto, estado)
VALUES ('20100200301', 'Distribuidora Tecno S.A.C.', 'Av. Industrial 890, Ate', '999888777', 'Carlos Torres', 'Activo');
INSERT INTO Proveedor (ruc, razonSocial, direccion, telefono, nombreContacto, estado)
VALUES ('20500600702', 'Importaciones Stock Global', 'Jr. Arica 432, Lima', '988777666', 'Ana Ramirez', 'Activo');
GO

-- 7. Tabla Venta (Relación Muchos a Uno con Cliente)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Venta]') AND type in (N'U'))
BEGIN
    CREATE TABLE Venta (
        id INT IDENTITY(1,1) PRIMARY KEY,
        fecha DATETIME DEFAULT GETDATE(),
        total DECIMAL(10,2) NOT NULL,
        idCliente INT NOT NULL,
        CONSTRAINT FK_Venta_Cliente FOREIGN KEY (idCliente) REFERENCES Cliente(id)
    );
END
GO

-- Poblado de prueba para Ventas
INSERT INTO Venta (fecha, total, idCliente) VALUES (GETDATE(), 1500.50, 1);
INSERT INTO Venta (fecha, total, idCliente) VALUES (GETDATE(), 850.00, 2);
GO

