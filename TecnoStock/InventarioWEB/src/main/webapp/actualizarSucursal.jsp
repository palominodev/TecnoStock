<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <%@ include file="includes/head.jspf" %>
</head>
<body class="p-4 sm:p-8 flex justify-center items-start min-h-screen">
    <div class="w-full max-w-xl glass-panel rounded-3xl p-6 sm:p-10 shadow-2xl my-6">
        <jsp:include page="includes/topbar.jsp" />

        <h2 class="text-2xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-300 via-indigo-400 to-violet-400 mb-6">
            Editar Sucursal <span class="text-xs text-indigo-400 font-medium font-mono">(Código: ${sucursal.idSucursal})</span>
        </h2>
        
        <form action="SucursalController" method="POST" class="space-y-5">
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" name="id" value="${sucursal.idSucursal}">
            
            <div>
                <label for="nombre" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Nombre de la Sucursal</label>
                <input type="text" id="nombre" name="nombre" value="${sucursal.nombre}" required placeholder="Ej: Sucursal Centro"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div>
                <label for="direccion" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Dirección</label>
                <input type="text" id="direccion" name="direccion" value="${sucursal.direccion}" required placeholder="Ej: Av. Arequipa 1234"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div>
                <label for="telefono" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Teléfono</label>
                <input type="text" id="telefono" name="telefono" value="${sucursal.telefono}" placeholder="Ej: (01) 456-7890"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div>
                <label for="estado" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Estado</label>
                <select id="estado" name="estado" required
                        class="w-full px-4 py-3 bg-slate-900/90 border border-slate-700/60 rounded-xl text-white text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                    <option value="Activo" ${sucursal.estado == 'Activo' ? 'selected' : ''}>Activo</option>
                    <option value="Inactivo" ${sucursal.estado == 'Inactivo' ? 'selected' : ''}>Inactivo</option>
                </select>
            </div>
            
            <div class="flex items-center gap-4 pt-4">
                <button type="submit" 
                        class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-white bg-gradient-to-r from-indigo-600 to-violet-600 hover:from-indigo-500 hover:to-violet-500 shadow-lg shadow-indigo-600/30 hover:shadow-indigo-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                    Actualizar Cambios
                </button>
                <a href="SucursalController?accion=listar" 
                   class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-center text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 transition-all">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
</body>
</html>
