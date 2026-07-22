DOCUMENTO DE REQUERIMIENTOS DE SOFTWARE (SRS)SISTEMA WEB DE GESTIÓN DE INVENTARIO - TECNOSTOCKEvaluación Integral | Desarrollo de Aplicaciones Empresariales Básico (2026-10)I. INFORMACIÓN GENERAL Y DE CONTROL| Campo | Detalle || Institución | ISIL || Curso | Desarrollo de Aplicaciones Empresariales Básico || Periodo Académico | 2026-10 || Estudiante | Palomino Fernandez, Jerimi Scott || Correo Electrónico | 70602959@mail.isil.pe || Docente | $$Nombre del Docente$$ || Fecha de Entrega | Octubre, 2026 |II. OBJETIVOS DEL PROYECTO1. Objetivo GeneralDesarrollar una aplicación web empresarial robusta y escalable para la empresa TecnoStock, que resuelva el desorden operativo causado por el registro manual de datos en archivos Excel. El sistema automatizará el control de sucursales y productos, asegurando la consistencia de la información mediante una arquitectura distribuida por capas.2. Objetivos EspecíficosImplementar una arquitectura desacoplada utilizando dos componentes principales: un proyecto EJB (para backend, persistencia y lógica de negocio) y un proyecto WEB (para interfaz de usuario y control de peticiones).Garantizar la persistencia de datos mediante JPA (Java Persistence API) y el mapeo de relaciones relacionales de tipo muchos a uno ($N:1$).Diseñar una interfaz web interactiva que use AJAX para realizar consultas asíncronas de datos sin la necesidad de recargar la página por completo.Conectar el sistema a una base de datos relacional sobre Microsoft SQL Server.III. ARQUITECTURA Y FLUJO DEL SISTEMALa solución se divide estrictamente en dos proyectos independientes para separar las responsabilidades de persistencia/negocio de las responsabilidades de presentación.1. Flujo de Comunicación MulticapaEl flujo de ejecución de datos sigue el siguiente patrón unidireccional:$$\text{JSP (Cliente) + AJAX} \longrightarrow \text{Servlet (Controlador)} \longrightarrow \text{Capa BL (Lógica)} \longrightarrow \text{Capa DAO (Datos)} \longrightarrow \text{JPA (EntityManager)} \longrightarrow \text{SQL Server}$$Restricción Crítica: Queda estrictamente prohibido que los archivos JSP o los Servlets accedan directamente a los DAOs o a la base de datos. Toda petición de datos debe transitar obligatoriamente a través de la capa de Lógica de Negocio (BL).2. Estructura de Paquetes (Proyectos)De acuerdo con las pautas de arquitectura y la referencia de image_69b368.png (excluyendo la capa dbmanager y simplificando los DAOs a clases directas sin interfaz, según indicación explícita del docente):├── [Proyecto 1] InventarioEJB
│   ├── src/main/java
│   │   ├── entity
│   │   │   ├── Sucursal.java
│   │   │   ├── Categoria.java
│   │   │   └── Producto.java
│   │   ├── dao
│   │   │   ├── SucursalDAO.java   (Implementación directa con EntityManager)
│   │   │   ├── CategoriaDAO.java  (Implementación directa con EntityManager)
│   │   │   └── ProductoDAO.java   (Implementación directa con EntityManager)
│   │   └── bl
│   │       ├── SucursalBL.java
│   │       ├── SucursalBLImpl.java
│   │       ├── CategoriaBL.java
│   │       ├── CategoriaBLImpl.java
│   │       ├── ProductoBL.java
│   │       └── ProductoBLImpl.java
│   └── src/main/resources
│       └── META-INF
│           └── persistence.xml    (Configuración de conexión SQL Server)
│
└── [Proyecto 2] InventarioWEB
    ├── src/main/java
    │   └── controller
    │       ├── SucursalController.java
    │       └── ProductoController.java
    └── src/main/webapp
        ├── gestionSucursales.jsp   (Filtro de búsqueda e interfaz principal)
        ├── nuevaSucursal.jsp      (Formulario de registro)
        ├── actualizarSucursal.jsp (Formulario de edición)
        ├── nuevoProducto.jsp      (Formulario de registro con combo de categorías)
        └── js/
            └── sucursalAjax.js    (Lógica para las llamadas asíncronas)

IV. REQUERIMIENTOS FUNCIONALES (RF)RF-01: Mantenimiento Completo (CRUD) de SucursalesEl sistema debe permitir gestionar de manera integral la información de las sucursales físicas de la empresa.RF-01.1: Registrar SucursalPermitir la inserción de una nueva sucursal con los atributos: Nombre, Dirección, Teléfono y Estado (Activo/Inactivo).RF-01.2: Listar y Filtrar Sucursales (Búsqueda AJAX)La pantalla principal de gestión de sucursales debe contener una barra de búsqueda para filtrar por Nombre de Sucursal.Al ingresar texto en el filtro, la lista de sucursales que cumpla el criterio debe cargarse asíncronamente vía AJAX sobre una tabla HTML. No se permite la recarga total del navegador.La tabla de resultados mostrará los campos: Código, Nombre, Dirección, Estado y las Acciones para Editar/Eliminar.RF-01.3: Actualizar SucursalPermitir modificar los datos de una sucursal existente (Nombre, Dirección, Teléfono, Estado) a través de un identificador único (ID).RF-01.4: Eliminar SucursalHabilitar la remoción física o lógica del registro de una sucursal de la base de datos a través de su identificador.RF-02: Registro de Productos Asociados a CategoríaEl sistema debe permitir la catalogación de nuevos productos enlazándolos de manera lógica y física con su respectiva categoría.RF-02.1: Renderizado Dinámico de CategoríasEn el formulario de creación de productos, el campo Categoría se representará mediante un menú desplegable (combo/select). Este debe cargarse dinámicamente con las categorías registradas en la base de datos.RF-02.2: Registrar ProductoPermitir guardar los atributos del producto: Nombre, Precio, Stock y la Categoría seleccionada.La persistencia guardará correctamente la clave foránea id_categoria del producto.Nota: No se requiere implementar búsqueda, edición ni eliminación para productos ni categorías.V. MODELO DE DATOS Y PERSISTENCIAA partir de los requerimientos y el flujo del sistema, se define el siguiente esquema de base de datos relacional para SQL Server:-- SCRIPT DE CREACIÓN DE BASE DE DATOS Y TABLAS (SQL SERVER)
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

Relaciones de Entidades (JPA)La relación entre las clases de entidad se define mediante JPA utilizando anotaciones para el mapeo relacional:Entidad Sucursal: Entidad aislada (sin @OneToMany ni @ManyToOne).Relación $N:1$ (Producto a Categoria):En Producto.java:@ManyToOne
@JoinColumn(name = "id_categoria")
private Categoria categoria;

En Categoria.java: (Opcional, relación bidireccional si se requiere):@OneToMany(mappedBy = "categoria")
private List<Producto> productos;

VI. REQUERIMIENTOS NO FUNCIONALES (RNF)RNF-01: Framework de PersistenciaEl motor de persistencia debe ser exclusivamente JPA a través de su especificación estándar. Queda restringido el uso de consultas JDBC nativas dentro de las implementaciones DAO. Se emplearán preferentemente consultas con @NamedQuery o JPQL estructurado.RNF-02: Gestión de EntidadesLa manipulación de los registros de la base de datos se realizará exclusivamente con las APIs EntityManager y EntityManagerFactory.RNF-03: Tecnología de Servidores e InterfazBackend: Implementado en Java Enterprise Edition (Java EE / Jakarta EE) utilizando contenedores EJB.Frontend: Construido con JSP (JavaServer Pages), HTML5, CSS estilizador y JavaScript nativo para la manipulación del DOM y peticiones asíncronas (fetch API o XMLHttpRequest).RNF-04: Motor de Base de DatosEl motor de almacenamiento relacional para todas las pruebas de desarrollo, QA y producción debe ser Microsoft SQL Server.VII. CHECKLIST DE ENTREGABLES Y EVIDENCIASPara la aprobación y evaluación de este proyecto con una nota sobre un máximo de 20 puntos, el estudiante Jerimi Palomino Fernandez deberá adjuntar un único archivo comprimido en formato .zip llamado Palomino.zip con los siguientes componentes:$$ $$ Código Fuente Completo del proyecto EJB (InventarioEJB) sin la carpeta dbmanager y sin interfaces en la capa DAO.$$ $$ Código Fuente Completo del proyecto Web (InventarioWEB).$$ $$ Script SQL estructurado (.sql) con la creación de la base de datos BD_TecnoStock, las tablas con relaciones e inserción de datos de prueba.$$ $$ Documento de Evidencias (incorporado en informe final o adjunto en PDF) con las siguientes capturas obligatorias:Pantalla de gestión de sucursales (CRUD principal).Funcionamiento del filtro de búsqueda asíncrono en tiempo real (AJAX) sin refresco de página.Formulario de registro de productos con el menú desplegable cargando dinámicamente las categorías existentes.Captura de la base de datos SQL Server que certifique que los registros se guardan correctamente de manera relacional.Explicación conceptual por escrito sobre el flujo de comunicación y la arquitectura $N:1$.
