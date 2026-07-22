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
                <h1 class="text-3xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-pink-300 via-pink-400 to-rose-400">
                    Gestión de Ventas
                </h1>
                <p class="text-xs sm:text-sm text-slate-400 mt-1">Control de operaciones comerciales y consultas filtradas por cliente.</p>
            </div>
            <div>
                <a href="#" onclick="return false;"
                   class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-emerald-600 hover:bg-emerald-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all opacity-50 cursor-not-allowed"
                   title="Funcionalidad pendiente — formulario de venta no implementado">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Nueva Venta
                </a>
            </div>
        </div>

        <!-- AJAX Cliente Filter -->
        <div class="mb-8 p-4 bg-slate-900/60 border border-slate-700/60 rounded-2xl shadow-inner">
            <div class="flex flex-col sm:flex-row gap-4 items-center">
                <label for="selCliente" class="text-xs font-semibold uppercase tracking-wider text-slate-400 sm:min-w-[70px]">Cliente:</label>
                <select id="selCliente"
                        class="flex-1 w-full px-4 py-2.5 bg-slate-950/70 border border-slate-700/80 rounded-xl text-white text-sm focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-500/20 transition-all">
                    <option value="">Todos los clientes</option>
                </select>
            </div>
        </div>

        <!-- Ventas Data Table -->
        <div class="overflow-x-auto rounded-2xl border border-slate-700/60 shadow-xl bg-slate-900/40">
            <table class="w-full text-left border-collapse" aria-busy="true">
                <thead>
                    <tr class="bg-indigo-950/40 border-b border-slate-700/80 text-pink-300 uppercase tracking-wider text-xs font-semibold">
                        <th class="px-6 py-4">ID</th>
                        <th class="px-6 py-4">Fecha</th>
                        <th class="px-6 py-4">Cliente</th>
                        <th class="px-6 py-4">Total</th>
                        <th class="px-6 py-4 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tbodyVentas" class="divide-y divide-slate-700/40">
                    <!-- AJAX-populated via ventaAjax.js -->
                </tbody>
            </table>
        </div>
    </div>

    <script src="js/ui.js"></script>
    <script src="js/ventaAjax.js"></script>
</body>
</html>
