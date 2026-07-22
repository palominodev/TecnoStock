<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStock - Editar Proveedor</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body class="p-4 sm:p-8 flex justify-center items-start min-h-screen">
    <div class="w-full max-w-xl glass-panel rounded-3xl p-6 sm:p-10 shadow-2xl my-6">
        <!-- User Topbar -->
        <div class="flex items-center justify-between gap-4 mb-6 pb-4 border-b border-slate-700/50">
            <span class="text-xs sm:text-sm text-slate-400 font-medium">
                Bienvenido, <strong class="text-white">${usuarioLogueado.nombres} ${usuarioLogueado.apellidos}</strong>
            </span>
            <a href="proveedor?opcion=listar" class="px-3 py-1.5 text-xs font-semibold text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 rounded-xl transition-all">
                Volver al Listado
            </a>
        </div>

        <h2 class="text-2xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-amber-400 to-orange-400 mb-6">
            Editar Proveedor <span class="text-xs text-amber-400 font-medium font-mono">(ID: ${proveedor.id})</span>
        </h2>

        <form action="proveedor" method="POST" class="space-y-5">
            <input type="hidden" name="opcion" value="guardar">
            <input type="hidden" name="id" value="${proveedor.id}">

            <div>
                <label for="ruc" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">RUC</label>
                <input type="text" id="ruc" name="ruc" required value="${proveedor.ruc}" maxlength="11" pattern="\d{11}"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm font-mono focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 transition-all">
            </div>

            <div>
                <label for="razonSocial" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Razón Social</label>
                <input type="text" id="razonSocial" name="razonSocial" required value="${proveedor.razonSocial}"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 transition-all">
            </div>

            <div>
                <label for="direccion" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Dirección</label>
                <input type="text" id="direccion" name="direccion" required value="${proveedor.direccion}"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 transition-all">
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label for="telefono" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Teléfono</label>
                    <input type="text" id="telefono" name="telefono" value="${proveedor.telefono}"
                           class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm font-mono focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 transition-all">
                </div>

                <div>
                    <label for="nombreContacto" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Nombre de Contacto</label>
                    <input type="text" id="nombreContacto" name="nombreContacto" value="${proveedor.nombreContacto}"
                           class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 transition-all">
                </div>
            </div>

            <div>
                <label for="estado" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Estado</label>
                <select id="estado" name="estado"
                        class="w-full px-4 py-3 bg-slate-900/90 border border-slate-700/60 rounded-xl text-white text-sm focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 transition-all">
                    <option value="Activo" ${proveedor.estado == 'Activo' ? 'selected' : ''}>Activo</option>
                    <option value="Inactivo" ${proveedor.estado == 'Inactivo' ? 'selected' : ''}>Inactivo</option>
                </select>
            </div>

            <div class="flex items-center gap-4 pt-4">
                <button type="submit" 
                        class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-white bg-gradient-to-r from-amber-600 to-orange-600 hover:from-amber-500 hover:to-orange-500 shadow-lg shadow-amber-600/30 hover:shadow-amber-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                    Guardar Cambios
                </button>
                <a href="proveedor?opcion=listar" 
                   class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-center text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 transition-all">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
</body>
</html>
