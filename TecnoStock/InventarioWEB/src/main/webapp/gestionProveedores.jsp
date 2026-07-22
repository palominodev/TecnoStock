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
                <h1 class="text-3xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-amber-400 to-orange-400">
                    Gestión de Proveedores
                </h1>
                <p class="text-xs sm:text-sm text-slate-400 mt-1">Búsqueda instantánea y administración de proveedores vía AJAX.</p>
            </div>
            <div class="flex flex-wrap items-center gap-3">
                <a href="proveedor?opcion=nuevo" class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-emerald-600 hover:bg-emerald-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Nuevo Proveedor
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
                <input type="text" id="txtBuscar" placeholder="Búsqueda instantánea por RUC, razón social, dirección o contacto..." autocomplete="off"
                       class="w-full pl-12 pr-4 py-3.5 bg-slate-900/60 border border-slate-700/60 rounded-2xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 transition-all shadow-inner">
            </div>
        </div>

        <!-- Proveedores Data Table -->
        <div class="overflow-x-auto rounded-2xl border border-slate-700/60 shadow-xl bg-slate-900/40">
            <table class="w-full text-left border-collapse" aria-busy="true">
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
                <tbody id="tbodyProveedores" class="divide-y divide-slate-700/40">
                    <!-- AJAX-populated via proveedorAjax.js -->
                </tbody>
            </table>
        </div>
    </div>

    <script src="js/ui.js"></script>
    <script src="js/proveedorAjax.js"></script>
</body>
</html>
