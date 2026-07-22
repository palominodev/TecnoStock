<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStock - Nueva Sucursal</title>
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
            <a href="UsuarioController?accion=logout" class="px-3 py-1.5 text-xs font-semibold text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 rounded-xl transition-all">
                Cerrar Sesión
            </a>
        </div>

        <h2 class="text-2xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-300 via-indigo-400 to-violet-400 mb-6">
            Registrar Nueva Sucursal
        </h2>
        
        <form action="SucursalController" method="POST" class="space-y-5">
            <input type="hidden" name="accion" value="registrar">
            
            <div>
                <label for="nombre" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Nombre de la Sucursal</label>
                <input type="text" id="nombre" name="nombre" required placeholder="Ej: Sucursal Centro"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div>
                <label for="direccion" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Dirección</label>
                <input type="text" id="direccion" name="direccion" required placeholder="Ej: Av. Arequipa 1234"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div>
                <label for="telefono" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Teléfono</label>
                <input type="text" id="telefono" name="telefono" placeholder="Ej: (01) 456-7890"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div>
                <label for="estado" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Estado</label>
                <select id="estado" name="estado" required
                        class="w-full px-4 py-3 bg-slate-900/90 border border-slate-700/60 rounded-xl text-white text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                    <option value="Activo">Activo</option>
                    <option value="Inactivo">Inactivo</option>
                </select>
            </div>
            
            <div class="flex items-center gap-4 pt-4">
                <button type="submit" 
                        class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-white bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                    Registrar Sucursal
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
