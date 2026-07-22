<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStock - Iniciar Sesión</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body class="flex items-center justify-center p-4">
    <div class="w-full max-width-md max-w-md glass-panel rounded-2xl p-8 shadow-2xl my-12 transition-all">
        <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-14 h-14 rounded-2xl bg-indigo-600/20 border border-indigo-500/30 text-indigo-400 mb-4 shadow-lg shadow-indigo-500/10">
                <svg class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                </svg>
            </div>
            <h2 class="text-3xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-300 via-indigo-400 to-violet-400">
                TecnoStock
            </h2>
            <p class="text-sm text-slate-400 mt-1 font-medium">Gestión Integral de Inventarios</p>
        </div>
        
        <c:if test="${not empty mensajeError}">
            <div class="mb-6 p-4 rounded-xl bg-rose-500/10 border border-rose-500/20 text-rose-400 text-sm flex items-center gap-3">
                <svg class="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <span>${mensajeError}</span>
            </div>
        </c:if>

        <form action="UsuarioController" method="POST" class="space-y-5">
            <input type="hidden" name="accion" value="login">
            
            <div>
                <label for="correo" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Correo Electrónico</label>
                <input type="email" id="correo" name="correo" required placeholder="correo@ejemplo.com" autocomplete="username"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div>
                <label for="contrasenha" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Contraseña</label>
                <input type="password" id="contrasenha" name="contrasenha" required placeholder="••••••••" autocomplete="current-password"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>
            
            <div class="pt-2">
                <button type="submit" 
                        class="w-full py-3.5 px-6 rounded-xl text-sm font-semibold text-white bg-gradient-to-r from-indigo-600 to-violet-600 hover:from-indigo-500 hover:to-violet-500 shadow-lg shadow-indigo-600/30 hover:shadow-indigo-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                    Iniciar Sesión
                </button>
            </div>
        </form>
    </div>
</body>
</html>
