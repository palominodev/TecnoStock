<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <%@ include file="includes/head.jspf" %>
</head>
<body class="p-4 sm:p-8 flex justify-center items-start min-h-screen">
    <div class="w-full max-w-xl glass-panel rounded-3xl p-6 sm:p-10 shadow-2xl my-6">
        <jsp:include page="includes/topbar.jsp" />

        <h2 class="text-2xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-300 via-indigo-400 to-violet-400 mb-6">
            Registrar Nuevo Producto
        </h2>

        <!-- Operations status alerts -->
        <c:if test="${not empty mensajeExito}">
            <div class="mb-6 p-4 rounded-xl bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-sm flex items-center gap-3">
                <svg class="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <span>${mensajeExito}</span>
            </div>
        </c:if>
        <c:if test="${not empty mensajeError}">
            <div class="mb-6 p-4 rounded-xl bg-rose-500/10 border border-rose-500/20 text-rose-400 text-sm flex items-center gap-3">
                <svg class="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <span>${mensajeError}</span>
            </div>
        </c:if>

        <form action="ProductoController" method="POST" class="space-y-5">
            <input type="hidden" name="accion" value="registrar">
            
            <div>
                <label for="nombre" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Nombre del Producto</label>
                <input type="text" id="nombre" name="nombre" required placeholder="Ej: Laptop ASUS ZenBook"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label for="precio" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Precio (S/.)</label>
                    <input type="number" id="precio" name="precio" step="0.01" min="0.01" required placeholder="Ej: 3499.90"
                           class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                </div>
                
                <div>
                    <label for="stock" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Stock Inicial</label>
                    <input type="number" id="stock" name="stock" min="1" required placeholder="Ej: 15"
                           class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                </div>
            </div>
            
            <div>
                <label for="idCategoria" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Categoría (Cargada Dinámicamente)</label>
                <select id="idCategoria" name="idCategoria" required
                        class="w-full px-4 py-3 bg-slate-900/90 border border-slate-700/60 rounded-xl text-white text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                    <option value="" disabled selected>-- Seleccioná una Categoría --</option>
                    <c:forEach var="categoria" items="${listaCategorias}">
                        <option value="${categoria.idCategoria}">${categoria.nombre}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="flex items-center gap-4 pt-4">
                <button type="submit" 
                        class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-white bg-gradient-to-r from-indigo-600 to-violet-600 hover:from-indigo-500 hover:to-violet-500 shadow-lg shadow-indigo-600/30 hover:shadow-indigo-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                    Registrar Producto
                </button>
                <a href="SucursalController?accion=listar" 
                   class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-center text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 transition-all">
                    Volver al Inicio
                </a>
            </div>
        </form>
    </div>
</body>
</html>
