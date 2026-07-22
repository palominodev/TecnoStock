# TecnoStock - Sistema de Gestión de Inventario (multicapa)

Este es el proyecto desarrollado para la evaluación de **Desarrollo de Aplicaciones Empresariales Básico (ISIL)** por el estudiante **Jerimi Scott Palomino Fernandez**.

## 1. Arquitectura del Sistema
El sistema implementa una arquitectura desacoplada en dos componentes principales:
- **`InventarioEJB` (Backend)**: Encargado de la persistencia de datos (JPA + Hibernate/EclipseLink) y la lógica de negocio.
- **`InventarioWEB` (Frontend)**: Interfaz de usuario basada en JSPs, hojas de estilo CSS modernas, y JavaScript asíncrono (AJAX via Fetch API) para peticiones directas al Servlet controlador.

### Flujo de Comunicación
El flujo de datos sigue un recorrido estrictamente unidireccional:
$$\text{JSP (Cliente) + AJAX} \longrightarrow \text{Servlet (Controlador)} \longrightarrow \text{Capa BL (Lógica)} \longrightarrow \text{Capa DAO (Datos)} \longrightarrow \text{JPA (EntityManager)} \longrightarrow \text{SQL Server}$$

---

## 2. Estructura detallada de Archivos

```
C:\DEV\TecnoStock
├── BD_TecnoStock.sql             # Script SQL de base de datos
├── README.md                     # Este archivo de guía
│
├── InventarioEJB                 # Módulo de Negocio y Persistencia
│   ├── pom.xml                   # Archivo POM de configuración Maven (EJB/JAR)
│   ├── src/main/java
│   │   ├── entity
│   │   │   ├── Sucursal.java     # Entidad Sucursal
│   │   │   ├── Categoria.java    # Entidad Categoría (Relación 1:N)
│   │   │   └── Producto.java     # Entidad Producto (Relación N:1)
│   │   ├── dao
│   │   │   ├── SucursalDAO.java  # Operaciones CRUD sobre Sucursal con EntityManager
│   │   │   ├── CategoriaDAO.java # Operaciones de lectura sobre Categoría
│   │   │   └── ProductoDAO.java  # Inserción de Producto
│   │   └── bl
│   │       ├── SucursalBL.java / SucursalBLImpl.java
│   │       ├── CategoriaBL.java / CategoriaBLImpl.java
│   │       └── ProductoBL.java / ProductoBLImpl.java
│   └── src/main/resources
│       └── META-INF
│           └── persistence.xml   # Configuración de unidad de persistencia (BD_TecnoStockPU)
│
└── InventarioWEB                 # Módulo Web de Presentación
    ├── pom.xml                   # Archivo POM de configuración Maven (WAR)
    ├── src/main/java
    │   └── controller
    │       ├── SucursalController.java # Servlet controlador para sucursales (Soporte AJAX JSON)
    │       └── ProductoController.java # Servlet controlador para registro de productos
    └── src/main/webapp
        ├── gestionSucursales.jsp # Interfaz de búsqueda y tabla principal (AJAX)
        ├── nuevaSucursal.jsp     # Formulario de registro de sucursal
        ├── actualizarSucursal.jsp# Formulario de edición de sucursal
        ├── nuevoProducto.jsp     # Formulario de registro de producto con combo dinámico
        ├── css
        │   └── estilos.css       # Estilos CSS premium (Modo oscuro y glassmorphism)
        └── js
            └── sucursalAjax.js   # Script para llamadas AJAX (Fetch API) y manipulación del DOM
```

---

## 3. Configuración de Base de Datos e Infraestructura

1. Ejecutá el archivo [BD_TecnoStock.sql](file:///C:/DEV/TecnoStock/BD_TecnoStock.sql) en tu instancia de **Microsoft SQL Server**.
2. En tu servidor de aplicaciones (GlassFish, Payara, WildFly o TomEE):
   - Creá un **Connection Pool** apuntando a tu base de datos `BD_TecnoStock` usando el driver JDBC de SQL Server (`com.microsoft.sqlserver.jdbc.SQLServerDriver`).
   - Registrá un recurso JDBC (**JDBC Resource**) con el nombre JNDI `jdbc/BD_TecnoStock` apuntando al Connection Pool creado.
3. Compilá los proyectos con Maven (por ejemplo, importándolos en IntelliJ IDEA, Eclipse o NetBeans).
4. Desplegá el artefacto `InventarioWEB.war` en tu servidor de aplicaciones y accedé al navegador en la dirección asignada (usualmente `http://localhost:8080/InventarioWEB/SucursalController`).
