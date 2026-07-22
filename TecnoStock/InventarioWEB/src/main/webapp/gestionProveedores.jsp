<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStock - Gestión de Proveedores</title>
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
                <h1 class="text-3xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-amber-400 to-orange-400">
                    Gestión de Proveedores
                </h1>
                <p class="text-xs sm:text-sm text-slate-400 mt-1">Administración de datos de contacto y RUC de proveedores.</p>
            </div>
            <div>
                <a href="proveedor?opcion=nuevo" class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-emerald-600 hover:bg-emerald-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Nuevo Proveedor
                </a>
            </div>
        </div>

        <!-- Proveedores Data Table -->
        <div class="overflow-x-auto rounded-2xl border border-slate-700/60 shadow-xl bg-slate-900/40">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-indigo-950/40 border-b border-slate-700/80 text-amber-300 uppercase tracking-wider text-xs font-semibold">
                        <th class="px-6 py-4">ID</th>
                        <th class="px-6 py-4">RUC</th>
                        <th class="px-6 py-4">Razón Social</th>
                        <th class="px-6 py-4">Dirección</th>
                        <th class="px-6 py-4">Teléfono</th>
                        <th class="px-6 py-4">Contacto</th>
                        <th class="px-6 py-4 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-700/40">
                    <c:choose>
                        <c:when test="${not empty listaProveedores}">
                            <c:forEach var="prov" items="${listaProveedores}">
                                <tr class="hover:bg-amber-500/10 transition-colors">
                                    <td class="px-6 py-4 text-sm text-slate-300 font-medium">${prov.id}</td>
                                    <td class="px-6 py-4 text-sm font-mono text-amber-300 font-medium">${prov.ruc}</td>
                                    <td class="px-6 py-4 text-sm font-semibold text-white">${prov.razonSocial}</td>
                                    <td class="px-6 py-4 text-sm text-slate-300">${prov.direccion}</td>
                                    <td class="px-6 py-4 text-sm text-slate-300 font-mono">${prov.telefono}</td>
                                    <td class="px-6 py-4 text-sm text-slate-300">${prov.nombreContacto}</td>
                                    <td class="px-6 py-4 text-sm">
                                        <div class="flex items-center justify-center gap-2">
                                            <a href="proveedor?opcion=editar&id=${prov.id}" 
                                               class="px-3 py-1.5 text-xs font-medium text-amber-300 hover:text-white bg-amber-500/10 hover:bg-amber-600/30 border border-amber-500/30 rounded-lg transition-all shadow-sm">
                                                Editar
                                            </a>
                                            <a href="proveedor?opcion=eliminar&id=${prov.id}" 
                                               class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm"
                                               onclick="return confirm('¿Estás seguro de que querés eliminar al proveedor \'${prov.razonSocial}\'?');">
                                                Eliminar
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="px-6 py-10 text-center text-slate-400 text-sm">
                                    No se encontraron proveedores registrados.
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
