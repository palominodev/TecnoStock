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
            Editar Cliente <span class="text-xs text-indigo-400 font-medium font-mono">(ID: ${cliente.id})</span>
        </h2>

        <form action="cliente" method="POST" class="space-y-5">
            <input type="hidden" name="opcion" value="registrar">
            <input type="hidden" name="id" value="${cliente.id}">

            <div>
                <label for="nombres" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Nombres</label>
                <input type="text" id="nombres" name="nombres" required value="${cliente.nombre}"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label for="apellidoPaterno" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Apellido Paterno</label>
                    <input type="text" id="apellidoPaterno" name="apellidoPaterno" required value="${cliente.apellidoPaterno}"
                           class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                </div>

                <div>
                    <label for="apellidoMaterno" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Apellido Materno</label>
                    <input type="text" id="apellidoMaterno" name="apellidoMaterno" required value="${cliente.apellidoMaterno}"
                           class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                </div>
            </div>

            <div>
                <label for="dni" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">DNI</label>
                <input type="text" id="dni" name="dni" required value="${cliente.dni}" maxlength="8" pattern="\d{8}"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm font-mono focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>

            <div>
                <label for="direccion" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Dirección</label>
                <input type="text" id="direccion" name="direccion" required value="${cliente.direccion}"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>

            <div class="flex items-center gap-4 pt-4">
                <button type="submit" 
                        class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-white bg-gradient-to-r from-indigo-600 to-violet-600 hover:from-indigo-500 hover:to-violet-500 shadow-lg shadow-indigo-600/30 hover:shadow-indigo-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                    Guardar Cambios
                </button>
                <a href="cliente?opcion=gestionar" 
                   class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-center text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 transition-all">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
</body>
</html>
