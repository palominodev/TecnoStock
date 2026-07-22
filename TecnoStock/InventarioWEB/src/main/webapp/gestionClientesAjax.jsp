<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStock - Gestión de Clientes (AJAX)</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="css/estilos.css">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            cargarClientes();

            document.getElementById("txtBuscar").addEventListener("input", function(e) {
                var query = e.target.value.toLowerCase();
                filterTable(query);
            });
        });

        function cargarClientes() {
            var tbody = document.getElementById("tbodyClientes");
            tbody.innerHTML = '<tr><td colspan="6" class="px-6 py-10 text-center text-slate-400 text-sm">Cargando clientes...</td></tr>';
            
            fetch("cliente?opcion=buscarClientesTodos")
                .then(response => response.json())
                .then(data => {
                    window.clientesData = data;
                    renderTable(data);
                })
                .catch(error => {
                    tbody.innerHTML = '<tr><td colspan="6" class="px-6 py-10 text-center text-rose-400 text-sm">Error al cargar datos: ' + error + '</td></tr>';
                });
        }

        function renderTable(data) {
            var tbody = document.getElementById("tbodyClientes");
            tbody.innerHTML = "";
            if (data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6" class="px-6 py-10 text-center text-slate-400 text-sm">No se encontraron clientes.</td></tr>';
                return;
            }
            data.forEach(cliente => {
                var tr = document.createElement("tr");
                tr.className = "hover:bg-indigo-500/10 transition-colors border-b border-slate-700/40";
                var esActivo = cliente.estado && cliente.estado.toLowerCase() === 'a';
                var badgeClass = esActivo ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30' : 'bg-rose-500/10 text-rose-400 border border-rose-500/30';
                var badgeLabel = esActivo ? 'Activo' : 'Inactivo';
                tr.innerHTML = `
                    <td class="px-6 py-4 text-sm text-slate-300 font-medium">${cliente.id}</td>
                    <td class="px-6 py-4 text-sm font-semibold text-white">${cliente.nombre}</td>
                    <td class="px-6 py-4 text-sm text-slate-300">${cliente.apellidoPaterno} ${cliente.apellidoMaterno}</td>
                    <td class="px-6 py-4 text-sm text-slate-300 font-mono">${cliente.dni}</td>
                    <td class="px-6 py-4 text-sm">
                        <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${badgeClass}">
                            ${badgeLabel}
                        </span>
                    </td>
                    <td class="px-6 py-4 text-sm">
                        <div class="flex items-center justify-center gap-2">
                            <a href="cliente?opcion=editar&id=${cliente.id}" class="px-3 py-1.5 text-xs font-medium text-indigo-300 hover:text-white bg-indigo-500/10 hover:bg-indigo-600/30 border border-indigo-500/30 rounded-lg transition-all shadow-sm">Editar</a>
                            <a href="cliente?opcion=eliminar&id=${cliente.id}" class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm" onclick="return confirm('¿Estás seguro de que deseas eliminar este cliente?');">Eliminar</a>
                        </div>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }

        function filterTable(query) {
            if (!window.clientesData) return;
            var filtered = window.clientesData.filter(cliente => {
                var matchesNombre = cliente.nombre && cliente.nombre.toLowerCase().includes(query);
                var matchesPaterno = cliente.apellidoPaterno && cliente.apellidoPaterno.toLowerCase().includes(query);
                var matchesMaterno = cliente.apellidoMaterno && cliente.apellidoMaterno.toLowerCase().includes(query);
                var matchesDni = cliente.dni && cliente.dni.includes(query);
                return matchesNombre || matchesPaterno || matchesMaterno || matchesDni;
            });
            renderTable(filtered);
        }
    </script>
</head>
<body class="p-4 sm:p-8 flex justify-center items-start min-h-screen">
    <div class="w-full max-w-6xl glass-panel rounded-3xl p-6 sm:p-10 shadow-2xl my-6">
        <!-- User Topbar -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8 pb-6 border-b border-slate-700/50">
            <span class="text-sm text-slate-400 font-medium">
                Bienvenido, <strong class="text-white">${usuarioLogueado.nombres} ${usuarioLogueado.apellidos}</strong>
            </span>
            <div class="flex items-center gap-3">
                <a href="home?opcion=principal" class="px-4 py-2 text-xs font-semibold text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 rounded-xl transition-all shadow-sm">
                    Inicio
                </a>
                <a href="UsuarioController?accion=logout" class="px-4 py-2 text-xs font-semibold text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 rounded-xl transition-all shadow-sm">
                    Cerrar Sesión
                </a>
            </div>
        </div>

        <!-- Header Title & Action Buttons -->
        <div class="flex flex-col md:flex-row justify-between md:items-center gap-4 mb-8">
            <div>
                <h1 class="text-3xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-300 via-indigo-400 to-violet-400">
                    Clientes AJAX
                </h1>
                <p class="text-xs sm:text-sm text-slate-400 mt-1">Gestión asíncrona y filtrado reactivo de clientes vía JSON.</p>
            </div>
            <div>
                <form action="cliente" method="POST" class="m-0">
                    <input type="hidden" name="opcion" value="nuevo">
                    <button type="submit" class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-emerald-600 hover:bg-emerald-500 shadow-lg shadow-emerald-600/30 hover:shadow-emerald-600/50 hover:-translate-y-0.5 transition-all cursor-pointer">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                        Nuevo Cliente
                    </button>
                </form>
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
                <input type="text" id="txtBuscar" placeholder="Búsqueda instantánea por nombre, apellido o DNI..." autocomplete="off"
                       class="w-full pl-12 pr-4 py-3.5 bg-slate-900/60 border border-slate-700/60 rounded-2xl text-white placeholder-slate-500 text-sm focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all shadow-inner">
            </div>
        </div>

        <!-- Table -->
        <div class="overflow-x-auto rounded-2xl border border-slate-700/60 shadow-xl bg-slate-900/40">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-indigo-950/40 border-b border-slate-700/80 text-indigo-300 uppercase tracking-wider text-xs font-semibold">
                        <th class="px-6 py-4">ID</th>
                        <th class="px-6 py-4">Nombres</th>
                        <th class="px-6 py-4">Apellidos</th>
                        <th class="px-6 py-4">DNI</th>
                        <th class="px-6 py-4">Estado</th>
                        <th class="px-6 py-4 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tbodyClientes" class="divide-y divide-slate-700/40">
                    <!-- Carga vía AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
