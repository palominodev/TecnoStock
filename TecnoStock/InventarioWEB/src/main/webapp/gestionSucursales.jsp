<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStock - Gestión de Sucursales</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body class="p-4 sm:p-8 flex justify-center items-start min-h-screen">
    <div class="w-full max-w-6xl glass-panel rounded-3xl p-6 sm:p-10 shadow-2xl my-6">
        <!-- User Topbar -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8 pb-6 border-b border-slate-700/50">
            <span class="text-sm text-slate-400 font-medium">
                Bienvenido, <strong class="text-white">${usuarioLogueado.nombres} ${usuarioLogueado.apellidos}</strong>
            </span>
            <div class="flex items-center gap-3">
                <a href="home?opcion=principal" class="px-4 py-2 text-xs font-semibold text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 rounded-xl transition-all shadow-sm">
                    Inicio
                </a>
                <a href="UsuarioController?accion=logout" class="px-4 py-2 text-xs font-semibold text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 rounded-xl transition-all shadow-sm">
                    Cerrar Sesión
                </a>
            </div>
        </div>

        <!-- Header Title & Action Buttons -->
        <div class="flex flex-col md:flex-row justify-between md:items-center gap-4 mb-8">
            <div>
                <h1 class="text-3xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-300 via-indigo-400 to-violet-400">
                    Gestión de Sucursales
                </h1>
                <p class="text-xs sm:text-sm text-slate-400 mt-1">Control de sucursales físicas y consulta en tiempo real vía AJAX.</p>
            </div>
            <div class="flex flex-wrap items-center gap-3">
                <a href="nuevaSucursal.jsp" class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-emerald-600 hover:bg-emerald-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Nueva Sucursal
                </a>
                <a href="ProductoController?accion=nuevo" class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-indigo-600 hover:bg-indigo-500 shadow-lg shadow-indigo-600/30 hover:shadow-indigo-600/50 hover:-translate-y-0.5 transition-all">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Nuevo Producto
                </a>
            </div>
        </div>

        <!-- AJAX Search Bar -->
        <div class="mb-8">
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-slate-400">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>
                <input type="text" id="txtBuscar" placeholder="Escribí el nombre de la sucursal para buscar en tiempo real (AJAX)..." autocomplete="off"
                       class="w-full pl-12 pr-4 py-3.5 bg-slate-900/60 border border-slate-700/60 rounded-2xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all shadow-inner">
            </div>
        </div>

        <!-- Sucursales Data Table -->
        <div class="overflow-x-auto rounded-2xl border border-slate-700/60 shadow-xl bg-slate-900/40">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-indigo-950/40 border-b border-slate-700/80 text-indigo-300 uppercase tracking-wider text-xs font-semibold">
                        <th class="px-6 py-4">Código</th>
                        <th class="px-6 py-4">Nombre</th>
                        <th class="px-6 py-4">Dirección</th>
                        <th class="px-6 py-4">Estado</th>
                        <th class="px-6 py-4">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tbodySucursales" class="divide-y divide-slate-700/40">
                    <c:choose>
                        <c:when test="${not empty listaSucursales}">
                            <c:forEach var="sucursal" items="${listaSucursales}">
                                <tr class="hover:bg-indigo-500/10 transition-colors">
                                    <td class="px-6 py-4 text-sm text-slate-300 font-medium">${sucursal.idSucursal}</td>
                                    <td class="px-6 py-4 text-sm font-semibold text-white">${sucursal.nombre}</td>
                                    <td class="px-6 py-4 text-sm text-slate-300">${sucursal.direccion}</td>
                                    <td class="px-6 py-4 text-sm">
                                        <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${sucursal.estado.toLowerCase() == 'activo' ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30' : 'bg-rose-500/10 text-rose-400 border border-rose-500/30'}">
                                            ${sucursal.estado}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-sm">
                                        <div class="flex items-center gap-2">
                                            <a href="SucursalController?accion=editar&id=${sucursal.idSucursal}" 
                                               class="px-3 py-1.5 text-xs font-medium text-indigo-300 hover:text-white bg-indigo-500/10 hover:bg-indigo-600/30 border border-indigo-500/30 rounded-lg transition-all shadow-sm">
                                                Editar
                                            </a>
                                            <a href="SucursalController?accion=eliminar&id=${sucursal.idSucursal}" 
                                               class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm"
                                               onclick="return confirm('¿Estás seguro de que querés eliminar la sucursal \'${sucursal.nombre}\'?');">
                                                Eliminar
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="px-6 py-10 text-center text-slate-400 text-sm">
                                    No hay sucursales registradas. Hacé click en "+ Nueva Sucursal" para registrar una.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- AJAX Script -->
    <script src="js/sucursalAjax.js"></script>
</body>
</html>
