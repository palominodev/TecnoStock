<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStock - Gestión de Ventas</title>
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
                <h1 class="text-3xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-pink-300 via-pink-400 to-rose-400">
                    Gestión de Ventas
                </h1>
                <p class="text-xs sm:text-sm text-slate-400 mt-1">Control de operaciones comerciales y consultas filtradas por cliente.</p>
            </div>
            <div>
                <form action="venta" method="POST" class="m-0">
                    <input type="hidden" name="opcion" value="nuevo">
                    <button type="submit" class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-emerald-600 hover:bg-emerald-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                        Nueva Venta
                    </button>
                </form>
            </div>
        </div>

        <!-- Search / Filter Bar -->
        <div class="mb-8 p-4 bg-slate-900/60 border border-slate-700/60 rounded-2xl shadow-inner">
            <form action="venta" method="GET" class="flex flex-col sm:flex-row gap-4 items-center m-0">
                <input type="hidden" name="opcion" value="buscarxCliente">
                <label class="text-xs font-semibold uppercase tracking-wider text-slate-400 sm:min-w-[70px]">Cliente:</label>
                <select name="idCliente" 
                        class="flex-1 w-full px-4 py-2.5 bg-slate-950/70 border border-slate-700/80 rounded-xl text-white text-sm focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-500/20 transition-all">
                    <c:forEach items="${listaClientes}" var="cliente">
                        <option value="${cliente.id}" ${param.idCliente == cliente.id ? 'selected' : ''}>
                            ${cliente.nombre} ${cliente.apellidoPaterno} ${cliente.apellidoMaterno} (DNI: ${cliente.dni})
                        </option>
                    </c:forEach>
                </select>
                <div class="flex gap-2 w-full sm:w-auto">
                    <button type="submit" class="flex-1 sm:flex-initial px-5 py-2.5 bg-indigo-600 hover:bg-indigo-500 text-white rounded-xl text-xs font-semibold shadow-md shadow-indigo-600/30 transition-all cursor-pointer">
                        Buscar
                    </button>
                    <a href="home?opcion=gestionarVentas" class="flex-1 sm:flex-initial px-5 py-2.5 bg-slate-800 hover:bg-slate-700 text-slate-300 hover:text-white rounded-xl text-xs font-semibold border border-slate-700 transition-all text-center">
                        Limpiar
                    </a>
                </div>
            </form>
        </div>

        <!-- Ventas Data Table -->
        <div class="overflow-x-auto rounded-2xl border border-slate-700/60 shadow-xl bg-slate-900/40">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-indigo-950/40 border-b border-slate-700/80 text-pink-300 uppercase tracking-wider text-xs font-semibold">
                        <th class="px-6 py-4">ID</th>
                        <th class="px-6 py-4">Fecha</th>
                        <th class="px-6 py-4">Cliente</th>
                        <th class="px-6 py-4">Total</th>
                        <th class="px-6 py-4 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-700/40">
                    <c:choose>
                        <c:when test="${not empty listaVentas}">
                            <c:forEach var="venta" items="${listaVentas}">
                                <tr class="hover:bg-pink-500/10 transition-colors">
                                    <td class="px-6 py-4 text-sm text-slate-300 font-medium">${venta.id}</td>
                                    <td class="px-6 py-4 text-sm text-slate-300 font-mono">${venta.fecha}</td>
                                    <td class="px-6 py-4 text-sm font-semibold text-white">${venta.cliente.nombre} ${venta.cliente.apellidoPaterno} ${venta.cliente.apellidoMaterno}</td>
                                    <td class="px-6 py-4 text-sm font-bold text-emerald-400 font-mono">S/ ${venta.total}</td>
                                    <td class="px-6 py-4 text-sm">
                                        <div class="flex items-center justify-center gap-2">
                                            <a href="venta?opcion=editar&id=${venta.id}" 
                                               class="px-3 py-1.5 text-xs font-medium text-indigo-300 hover:text-white bg-indigo-500/10 hover:bg-indigo-600/30 border border-indigo-500/30 rounded-lg transition-all shadow-sm">
                                                Editar
                                            </a>
                                            <a href="venta?opcion=eliminar&id=${venta.id}" 
                                               class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm"
                                               onclick="return confirm('¿Estás seguro de que deseas eliminar esta venta ID ${venta.id}?');">
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
                                    No se encontraron ventas registradas.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
