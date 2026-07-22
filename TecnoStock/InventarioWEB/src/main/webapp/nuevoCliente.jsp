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
            Registrar Nuevo Cliente
        </h2>

        <form id="formCliente" action="cliente" method="POST" class="space-y-5">
            <input type="hidden" name="opcion" value="registrar">

            <div>
                <label for="nombres" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Nombres</label>
                <input type="text" id="nombres" name="nombres" required placeholder="Ingresá los nombres del cliente"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label for="apellidoPaterno" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Apellido Paterno</label>
                    <input type="text" id="apellidoPaterno" name="apellidoPaterno" required placeholder="Ingresá el apellido paterno"
                           class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                </div>

                <div>
                    <label for="apellidoMaterno" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Apellido Materno</label>
                    <input type="text" id="apellidoMaterno" name="apellidoMaterno" required placeholder="Ingresá el apellido materno"
                           class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
                </div>
            </div>

            <div>
                <label for="dni" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">DNI</label>
                <input type="text" id="dni" name="dni" required placeholder="Ingresá el DNI (8 dígitos)" maxlength="8" pattern="\d{8}"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm font-mono focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>

            <div>
                <label for="direccion" class="block text-xs font-semibold uppercase tracking-wider text-slate-400 mb-2">Dirección</label>
                <input type="text" id="direccion" name="direccion" required placeholder="Ingresá la dirección del cliente"
                       class="w-full px-4 py-3 bg-slate-900/60 border border-slate-700/60 rounded-xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all">
            </div>

            <div class="flex items-center gap-4 pt-4">
                <button type="submit" 
                        class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-white bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                    Grabar Cliente
                </button>
                <a href="cliente?opcion=gestionar" 
                   class="flex-1 py-3 px-6 rounded-xl text-sm font-semibold text-center text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 transition-all">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
    <script src="js/ui.js"></script>
    <script>
        document.getElementById('formCliente').addEventListener('submit', function(e) {
            if (typeof fetch === 'undefined') return; // fallback to normal POST
            e.preventDefault();
            var form = e.target;
            fetch('cliente?opcion=registrar', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'fetch' },
                body: new URLSearchParams(new FormData(form))
            })
            .then(function(r) { return r.json(); })
            .then(function(res) {
                if (res.ok) {
                    ui.toast({ type: 'success', message: res.msg || 'Cliente guardado' });
                    setTimeout(function() { window.location.href = 'gestionClientesAjax.jsp'; }, 800);
                } else {
                    var errMsg = (res.errors && res.errors.length) ? res.errors.join(', ') : 'Error al guardar';
                    ui.toast({ type: 'error', message: errMsg });
                }
            })
            .catch(function(err) {
                ui.toast({ type: 'error', message: err.message || 'Error de conexión' });
            });
        });
    </script>
</body>
</html>
