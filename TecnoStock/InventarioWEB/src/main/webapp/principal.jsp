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

        <!-- Header content -->
        <div class="text-center max-w-2xl mx-auto mb-12">
            <h1 class="text-3xl sm:text-4xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-200 via-indigo-400 to-violet-400 mb-3">
                Panel Principal de Inventario
            </h1>
            <p class="text-sm sm:text-base text-slate-400 font-normal">
                Seleccioná una de las opciones del sistema para gestionar sucursales, productos, clientes y ventas.
            </p>
        </div>

        <!-- Dashboard Cards Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Card 1: Sucursales -->
            <a href="home?opcion=gestionarSucursales" 
               class="group relative overflow-hidden rounded-2xl p-6 bg-slate-800/40 hover:bg-slate-800/80 border border-slate-700/60 hover:border-indigo-500/50 shadow-lg hover:shadow-indigo-500/10 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-xl bg-indigo-500/10 border border-indigo-500/20 text-indigo-400 flex items-center justify-center group-hover:scale-110 transition-transform">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5m3 0h4M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5"/>
                        </svg>
                    </div>
                    <span class="text-xs font-bold text-indigo-400 uppercase tracking-wider bg-indigo-500/10 px-2.5 py-1 rounded-full border border-indigo-500/20">RF-01</span>
                </div>
                <h3 class="text-xl font-bold text-white group-hover:text-indigo-300 transition-colors mb-2">Gestión de Sucursales</h3>
                <p class="text-xs text-slate-400 leading-relaxed">Administrá sucursales, direcciones, teléfonos y estado con búsquedas asíncronas AJAX.</p>
            </a>

            <!-- Card 2: Productos -->
            <a href="ProductoController?accion=nuevo" 
               class="group relative overflow-hidden rounded-2xl p-6 bg-slate-800/40 hover:bg-slate-800/80 border border-slate-700/60 hover:border-emerald-500/50 shadow-lg hover:shadow-emerald-500/10 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-xl bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 flex items-center justify-center group-hover:scale-110 transition-transform">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                        </svg>
                    </div>
                    <span class="text-xs font-bold text-emerald-400 uppercase tracking-wider bg-emerald-500/10 px-2.5 py-1 rounded-full border border-emerald-500/20">RF-02</span>
                </div>
                <h3 class="text-xl font-bold text-white group-hover:text-emerald-300 transition-colors mb-2">Nuevo Producto</h3>
                <p class="text-xs text-slate-400 leading-relaxed">Registrá productos vinculándolos dinámicamente con categorías desde la BD.</p>
            </a>

            <!-- Card 3: Clientes -->
            <a href="home?opcion=gestionarClientes" 
               class="group relative overflow-hidden rounded-2xl p-6 bg-slate-800/40 hover:bg-slate-800/80 border border-slate-700/60 hover:border-cyan-500/50 shadow-lg hover:shadow-cyan-500/10 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-xl bg-cyan-500/10 border border-cyan-500/20 text-cyan-400 flex items-center justify-center group-hover:scale-110 transition-transform">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5 5 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                    </div>
                    <span class="text-xs font-bold text-cyan-400 uppercase tracking-wider bg-cyan-500/10 px-2.5 py-1 rounded-full border border-cyan-500/20">JPA</span>
                </div>
                <h3 class="text-xl font-bold text-white group-hover:text-cyan-300 transition-colors mb-2">Gestión de Clientes</h3>
                <p class="text-xs text-slate-400 leading-relaxed">Registrá, editá y filtrá clientes con operaciones de persistencia JPA.</p>
            </a>

            <!-- Card 4: Clientes (AJAX) -->
            <a href="gestionClientesAjax.jsp" 
               class="group relative overflow-hidden rounded-2xl p-6 bg-slate-800/40 hover:bg-slate-800/80 border border-slate-700/60 hover:border-purple-500/50 shadow-lg hover:shadow-purple-500/10 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-xl bg-purple-500/10 border border-purple-500/20 text-purple-400 flex items-center justify-center group-hover:scale-110 transition-transform">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                        </svg>
                    </div>
                    <span class="text-xs font-bold text-purple-400 uppercase tracking-wider bg-purple-500/10 px-2.5 py-1 rounded-full border border-purple-500/20">JSON</span>
                </div>
                <h3 class="text-xl font-bold text-white group-hover:text-purple-300 transition-colors mb-2">Clientes (AJAX)</h3>
                <p class="text-xs text-slate-400 leading-relaxed">Listado y filtrado reactivo asíncrono con formato JSON.</p>
            </a>

            <!-- Card 5: Proveedores -->
            <a href="home?opcion=gestionarProveedores" 
               class="group relative overflow-hidden rounded-2xl p-6 bg-slate-800/40 hover:bg-slate-800/80 border border-slate-700/60 hover:border-amber-500/50 shadow-lg hover:shadow-amber-500/10 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-xl bg-amber-500/10 border border-amber-500/20 text-amber-400 flex items-center justify-center group-hover:scale-110 transition-transform">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z"/>
                        </svg>
                    </div>
                    <span class="text-xs font-bold text-amber-400 uppercase tracking-wider bg-amber-500/10 px-2.5 py-1 rounded-full border border-amber-500/20">Proveedores</span>
                </div>
                <h3 class="text-xl font-bold text-white group-hover:text-amber-300 transition-colors mb-2">Gestión de Proveedores</h3>
                <p class="text-xs text-slate-400 leading-relaxed">Administrá razones sociales, RUC y contactos de proveedores.</p>
            </a>

            <!-- Card 6: Ventas -->
            <a href="home?opcion=gestionarVentas" 
               class="group relative overflow-hidden rounded-2xl p-6 bg-slate-800/40 hover:bg-slate-800/80 border border-slate-700/60 hover:border-pink-500/50 shadow-lg hover:shadow-pink-500/10 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-xl bg-pink-500/10 border border-pink-500/20 text-pink-400 flex items-center justify-center group-hover:scale-110 transition-transform">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                    </div>
                    <span class="text-xs font-bold text-pink-400 uppercase tracking-wider bg-pink-500/10 px-2.5 py-1 rounded-full border border-pink-500/20">Ventas</span>
                </div>
                <h3 class="text-xl font-bold text-white group-hover:text-pink-300 transition-colors mb-2">Gestión de Ventas</h3>
                <p class="text-xs text-slate-400 leading-relaxed">Control de transacciones de ventas y filtros detallados por cliente.</p>
            </a>
        </div>
    </div>
</body>
</html>
