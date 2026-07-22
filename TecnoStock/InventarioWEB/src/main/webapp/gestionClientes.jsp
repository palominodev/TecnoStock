<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <%@ include file="includes/head.jspf" %>
</head>
<body class="p-4 sm:p-8 flex justify-center items-start min-h-screen">
    <div class="w-full max-w-6xl glass-panel rounded-3xl p-6 sm:p-10 shadow-2xl my-6">
        <jsp:include page="includes/topbar.jsp" />

        <!-- Header Title & Action Buttons -->
        <div class="flex flex-col md:flex-row justify-between md:items-center gap-4 mb-8">
            <div>
                <h1 class="text-3xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-300 via-indigo-400 to-violet-400">
                    Gestión de Clientes
                </h1>
                <p class="text-xs sm:text-sm text-slate-400 mt-1">Mantenimiento de clientes registrados mediante JPA.</p>
            </div>
            <div>
                <form action="cliente" method="POST" class="m-0">
                    <input type="hidden" name="opcion" value="nuevo">
                    <button type="submit" class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-emerald-600 hover:bg-emerald-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                        Nuevo Cliente
                    </button>
                </form>
            </div>
        </div>

        <!-- Search Bar -->
        <div class="mb-8 p-4 bg-slate-900/60 border border-slate-700/60 rounded-2xl shadow-inner">
            <form action="cliente" method="GET" class="flex flex-col sm:flex-row gap-3 items-center m-0">
                <input type="hidden" name="opcion" value="buscarxApellidoPaterno">
                <div class="relative flex-1 w-full">
                    <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                    </div>
                    <input type="text" name="apellidoPaterno" placeholder="Buscar por apellido paterno..." value="${param.apellidoPaterno}"
                           class="w-full pl-10 pr-4 py-2.5 bg-slate-950/70 border border-slate-700/80 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                </div>
                <div class="flex gap-2 w-full sm:w-auto">
                    <button type="submit" class="flex-1 sm:flex-initial px-5 py-2.5 bg-indigo-600 hover:bg-indigo-500 text-white rounded-xl text-xs font-semibold shadow-md shadow-indigo-600/30 transition-all cursor-pointer">
                        Buscar
                    </button>
                    <a href="cliente?opcion=gestionar" class="flex-1 sm:flex-initial px-5 py-2.5 bg-slate-800 hover:bg-slate-700 text-slate-300 hover:text-white rounded-xl text-xs font-semibold border border-slate-700 transition-all text-center">
                        Limpiar
                    </a>
                </div>
            </form>
        </div>

        <!-- Clientes Data Table -->
        <div class="overflow-x-auto rounded-2xl border border-slate-700/60 shadow-xl bg-slate-900/40">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-indigo-950/40 border-b border-slate-700/80 text-indigo-300 uppercase tracking-wider text-xs font-semibold">
                        <th class="px-6 py-4">ID</th>
                        <th class="px-6 py-4">Nombres</th>
                        <th class="px-6 py-4">Apellidos</th>
                        <th class="px-6 py-4">DNI</th>
                        <th class="px-6 py-4">Estado</th>
                        <th class="px-6 py-4 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-700/40">
                    <c:choose>
                        <c:when test="${not empty listaClientes}">
                            <c:forEach var="cliente" items="${listaClientes}">
                                <tr class="hover:bg-indigo-500/10 transition-colors">
                                    <td class="px-6 py-4 text-sm text-slate-300 font-medium">${cliente.id}</td>
                                    <td class="px-6 py-4 text-sm font-semibold text-white">${cliente.nombre}</td>
                                    <td class="px-6 py-4 text-sm text-slate-300">${cliente.apellidoPaterno} ${cliente.apellidoMaterno}</td>
                                    <td class="px-6 py-4 text-sm text-slate-300 font-mono">${cliente.dni}</td>
                                    <td class="px-6 py-4 text-sm">
                                        <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${cliente.estado.toLowerCase() == 'a' ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30' : 'bg-rose-500/10 text-rose-400 border border-rose-500/30'}">
                                            ${cliente.estado == 'A' ? 'Activo' : 'Inactivo'}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-sm">
                                        <div class="flex items-center justify-center gap-2">
                                            <a href="cliente?opcion=editar&id=${cliente.id}" 
                                               class="px-3 py-1.5 text-xs font-medium text-indigo-300 hover:text-white bg-indigo-500/10 hover:bg-indigo-600/30 border border-indigo-500/30 rounded-lg transition-all shadow-sm">
                                                Editar
                                            </a>
                                            <a href="cliente?opcion=eliminar&id=${cliente.id}" 
                                               class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm"
                                               onclick="return confirm('¿Estás seguro de que querés eliminar al cliente \'${cliente.nombre} ${cliente.apellidoPaterno}\'?');">
                                                Eliminar
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="px-6 py-10 text-center text-slate-400 text-sm">
                                    No se encontraron clientes registrados.
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
