<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>VENTAPLUS - Gestión de Categorías</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap"
        rel="stylesheet">

    <!-- Tailwind CSS v4 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>

    <!-- Custom Styles & Animations (Premium Aesthetic) -->
    <style type="text/css">
        body {
            font-family: 'Inter', sans-serif;
            background-color: #050508;
        }

        h1,
        h2,
        h3,
        button,
        .font-display {
            font-family: 'Outfit', sans-serif;
        }

        /* Ambient float animations */
        @keyframes float-orb-1 {
            0%, 100% {
                transform: translate(0, 0) scale(1);
            }
            33% {
                transform: translate(30px, -40px) scale(1.08);
            }
            66% {
                transform: translate(-20px, 20px) scale(0.96);
            }
        }

        @keyframes float-orb-2 {
            0%, 100% {
                transform: translate(0, 0) scale(1);
            }
            50% {
                transform: translate(-40px, 40px) scale(1.04);
            }
        }

        .animate-float-orb-1 {
            animation: float-orb-1 22s ease-in-out infinite;
        }

        .animate-float-orb-2 {
            animation: float-orb-2 26s ease-in-out infinite;
        }

        /* Custom scrollbars */
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.02);
        }

        ::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 9999px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: rgba(16, 185, 129, 0.3);
        }
    </style>
</head>

<body
    class="min-h-screen text-zinc-100 relative overflow-x-hidden selection:bg-emerald-500/30 selection:text-white pb-12">

    <!-- Ambient / Background Effects -->
    <div class="fixed inset-0 w-full h-full -z-10 overflow-hidden pointer-events-none">
        <!-- Tech Grid Overlay -->
        <div
            class="absolute inset-0 w-full h-full bg-[linear-gradient(rgba(255,255,255,0.012)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.012)_1px,transparent_1px)] bg-[size:50px_50px] bg-center [mask-image:radial-gradient(circle_at_center,black,transparent_90%)]">
        </div>

        <!-- Nebula Orbs (emerald accent matching Categoria card) -->
        <div
            class="absolute top-[-10%] left-[-10%] w-[600px] h-[600px] rounded-full filter blur-[150px] opacity-30 mix-blend-screen animate-float-orb-1 bg-[radial-gradient(circle,rgba(16,185,129,0.45)_0%,transparent_70%)]">
        </div>
        <div
            class="absolute bottom-[-10%] right-[-10%] w-[600px] h-[600px] rounded-full filter blur-[150px] opacity-25 mix-blend-screen animate-float-orb-2 bg-[radial-gradient(circle,rgba(6,182,212,0.4)_0%,transparent_70%)]">
        </div>
    </div>

    <!-- Main Content Wrapper -->
    <main class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-10 relative z-10">

        <!-- Success / Error Message Banners (REQ-CAT-3.5) -->
        <c:if test="${not empty sessionScope.mensaje}">
            <div role="alert" class="mb-6 flex items-center gap-3 p-4 rounded-2xl border border-emerald-500/30 bg-emerald-500/10 text-emerald-200 backdrop-blur-xl">
                <svg class="w-5 h-5 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span class="text-sm font-medium flex-grow"><c:out value="${sessionScope.mensaje}" escapeXml="true"/></span>
                <button type="button" onclick="this.parentElement.remove()" class="text-emerald-300 hover:text-white transition-colors" aria-label="Cerrar">
                    <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <% session.removeAttribute("mensaje"); %>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div role="alert" class="mb-6 flex items-center gap-3 p-4 rounded-2xl border border-rose-500/30 bg-rose-500/10 text-rose-200 backdrop-blur-xl">
                <svg class="w-5 h-5 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
                </svg>
                <span class="text-sm font-medium flex-grow"><c:out value="${sessionScope.error}" escapeXml="true"/></span>
                <button type="button" onclick="this.parentElement.remove()" class="text-rose-300 hover:text-white transition-colors" aria-label="Cerrar">
                    <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <% session.removeAttribute("error"); %>
        </c:if>

        <!-- Page Header & Volver link + Registrar Categoría Button -->
        <div
            class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8 pb-6 border-b border-white/5">
            <div>
                <a href="principal.jsp"
                    class="inline-flex items-center gap-1.5 text-[10px] font-semibold text-zinc-500 hover:text-emerald-300 transition-colors tracking-wider uppercase mb-2 no-underline">
                    <svg class="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5" />
                    </svg>
                    Volver al menú principal
                </a>
                <h1
                    class="text-3xl font-extrabold tracking-tight bg-gradient-to-r from-white via-zinc-100 to-zinc-400 bg-clip-text text-transparent">
                    Gestión de Categorías
                </h1>
                <p class="text-xs text-zinc-400 mt-1">Busque y administre las categorías de productos del sistema.</p>
            </div>
            <!-- Registrar Categoría Button -->
            <div>
                <a href="CategoriaController?opcion=nuevo"
                    class="w-full sm:w-auto px-5 py-3.5 bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 rounded-2xl text-white font-semibold text-sm tracking-wide transition-all duration-300 transform hover:-translate-y-0.5 shadow-[0_4px_15px_rgba(16,185,129,0.3)] hover:shadow-[0_6px_20px_rgba(16,185,129,0.45)] cursor-pointer flex items-center justify-center gap-2 no-underline">
                    <svg class="w-4.5 h-4.5" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                        stroke-width="2.5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                    </svg>
                    Registrar Categoría
                </a>
            </div>
        </div>

        <!-- Búsqueda Rápida de Categorías (Search Section) -->
        <section
            class="bg-zinc-950/45 border border-white/8 rounded-2xl p-6 backdrop-blur-xl mb-8 hover:border-white/12 transition-all duration-300 shadow-xl">
            <div class="flex flex-col gap-4">
                <div class="flex items-center justify-between">
                    <h2 class="text-base font-bold text-zinc-200 flex items-center gap-2">
                        <svg class="w-5 h-5 text-emerald-400" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                        Búsqueda Rápida de Categorías
                    </h2>
                    <span
                        class="text-[10px] text-zinc-500 font-semibold tracking-wider uppercase bg-white/5 px-2.5 py-1 rounded-md border border-white/5">Filtro
                        por nombre</span>
                </div>

                <!-- Search Input Form -->
                <form action="CategoriaController" method="GET" class="flex flex-col sm:flex-row gap-3">
                    <input type="hidden" name="opcion" value="buscar">
                    <div class="relative flex-grow">
                        <div
                            class="group relative flex items-center bg-white/[0.02] border border-white/8 rounded-2xl transition-all duration-300 hover:bg-white/[0.04] hover:border-emerald-500/35 focus-within:bg-zinc-950/70 focus-within:border-emerald-500 focus-within:ring-2 focus-within:ring-emerald-500/25">
                            <!-- Search Icon -->
                            <svg class="absolute left-4 text-zinc-500 w-5 h-5 transition-colors duration-300 group-focus-within:text-emerald-500 pointer-events-none"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                            <!-- Search Field -->
                            <input type="text" id="searchNombre" name="nombre"
                                class="peer w-full py-4 pl-12 pr-4 bg-transparent border-none outline-none text-sm text-zinc-100 placeholder-transparent"
                                placeholder="Ingrese nombre de la categoría" maxlength="50" />
                            <label for="searchNombre"
                                class="absolute left-12 top-1/2 -translate-y-1/2 text-sm text-zinc-400 pointer-events-none transition-all duration-300 origin-left peer-focus:-translate-y-6 peer-focus:scale-80 peer-focus:text-emerald-400 peer-[:not(:placeholder-shown)]:-translate-y-6 peer-[:not(:placeholder-shown)]:scale-80">
                                Ingrese nombre de la categoría
                            </label>
                        </div>
                    </div>
                    <div class="flex gap-2">
                        <button type="submit"
                            class="flex-grow sm:flex-none px-6 py-4 bg-gradient-to-r from-emerald-600 to-cyan-600 hover:from-emerald-500 hover:to-cyan-500 text-white font-semibold text-sm rounded-2xl transition-all duration-300 transform hover:-translate-y-0.5 shadow-lg shadow-emerald-500/10 cursor-pointer flex items-center justify-center gap-2">
                            <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                                stroke-width="2.5">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                            Buscar
                        </button>
                    </div>
                </form>
            </div>
        </section>

        <!-- Lista de Categorías Registradas (Table Container) -->
        <section
            class="bg-zinc-950/45 border border-white/8 rounded-2xl backdrop-blur-xl overflow-hidden shadow-2xl relative hover:border-white/10 transition-all duration-300">
            <!-- Table Top Toolbar -->
            <div class="p-6 border-b border-white/8 flex items-center justify-between gap-4">
                <div>
                    <h2 class="text-base font-bold text-zinc-100 flex items-center gap-2">
                        <svg class="w-5 h-5 text-cyan-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                            stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M4 6h16M4 10h16M4 14h16M4 18h16" />
                        </svg>
                        Lista de Categorías Registradas
                    </h2>
                </div>
                <div>
                    <span
                        class="text-xs font-semibold bg-emerald-500/10 text-emerald-300 border border-emerald-500/25 px-3 py-1.5 rounded-full flex items-center gap-1.5">
                        <span><c:out value="${listaCategorias.size()}" escapeXml="true"/> Registradas</span>
                    </span>
                </div>
            </div>

            <!-- Table Scrollable Area -->
            <div class="overflow-x-auto w-full">
                <c:choose>
                    <c:when test="${empty listaCategorias}">
                        <!-- Empty state (REQ-CAT-3.1) -->
                        <div class="p-12 text-center">
                            <svg class="w-12 h-12 mx-auto text-zinc-700 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9.568 3H5.25A2.25 2.25 0 003 5.25v4.318c0 .597.237 1.17.659 1.591l9.581 9.581c.699.699 1.78.872 2.607.33a18.095 18.095 0 005.223-5.223c.542-.827.369-1.908-.33-2.607L11.16 3.66A2.25 2.25 0 009.568 3z" />
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 6h.008v.008H6V6z" />
                            </svg>
                            <p class="text-zinc-400 text-sm">No hay categorías registradas.</p>
                            <p class="text-zinc-600 text-xs mt-1">Cree una nueva categoría usando el botón "Registrar Categoría".</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="w-full text-left border-collapse" id="categoriasTable">
                            <thead>
                                <tr
                                    class="bg-white/[0.02] border-b border-white/8 text-[10px] font-bold text-zinc-400 uppercase tracking-widest">
                                    <th class="py-4.5 px-6">ID</th>
                                    <th class="py-4.5 px-6">Nombre</th>
                                    <th class="py-4.5 px-6">Descripción</th>
                                    <th class="py-4.5 px-6 text-center">Estado</th>
                                    <th class="py-4.5 px-6 text-right">Acciones</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-white/4 text-sm" id="tableBody">
                                <c:forEach var="c" items="${listaCategorias}">
                                    <tr>
                                        <td class="px-6 py-4 font-medium text-zinc-100">
                                            <c:out value="${c.id}" escapeXml="true"/>
                                        </td>
                                        <td class="px-6 py-4 text-zinc-300 font-medium">
                                            <c:out value="${c.nombre}" escapeXml="true"/>
                                        </td>
                                        <td class="px-6 py-4 text-zinc-400 text-xs max-w-xs truncate">
                                            <c:out value="${c.descripcion}" escapeXml="true"/>
                                        </td>
                                        <td class="px-6 py-4 text-center">
                                            <c:choose>
                                                <c:when test="${c.estado == 'A'}">
                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                                        Activo
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-rose-500/10 text-rose-400 border border-rose-500/20">
                                                        Inactivo
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <!-- Editar (GET link, safe — id is server-controlled) -->
                                            <a href="CategoriaController?opcion=editar&id=<c:out value='${c.id}'/>"
                                                class="inline-flex items-center gap-1 px-3 py-2 text-xs font-semibold text-emerald-300 bg-emerald-500/10 border border-emerald-500/25 rounded-xl hover:bg-emerald-500/20 hover:text-emerald-200 transition-colors no-underline">
                                                <svg class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor" stroke-width="2">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                                </svg>
                                                Editar
                                            </a>
                                            <!-- Eliminar (data-* + addEventListener — XSS hardened, no inline JS template-literal) -->
                                            <button type="button"
                                                data-id="<c:out value='${c.id}'/>"
                                                data-nombre="<c:out value='${c.nombre}'/>"
                                                class="btn-eliminar inline-flex items-center gap-1 px-3 py-2 text-xs font-semibold text-rose-300 bg-rose-500/10 border border-rose-500/25 rounded-xl hover:bg-rose-500/20 hover:text-rose-200 transition-colors ml-2 cursor-pointer">
                                                <svg class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor" stroke-width="2">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                </svg>
                                                Eliminar
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Table Footer / Count Info -->
            <div class="p-6 border-t border-white/8 flex items-center justify-between text-xs text-zinc-400">
                <span>Mostrando <strong class="text-zinc-200"><c:out value="${listaCategorias.size()}" escapeXml="true"/></strong> de <strong
                        class="text-zinc-200"><c:out value="${listaCategorias.size()}" escapeXml="true"/></strong>
                    categorías</span>
                <span class="text-[10px] text-zinc-500 font-medium font-mono">VentaPlus Categorías Engine</span>
            </div>
        </section>

    </main>

    <!-- JavaScript: XSS-hardened delete confirm (REQ-CAT-3.6) -->
    <!-- Uses event delegation on document + data-* attributes (c:out escapeXml).        -->
    <!-- Replaces the inline onclick="confirmarEliminar(...)" pattern from               -->
    <!-- gestionClientes.jsp:267 which has a single-quote XSS injection vector.         -->
    <script type="text/javascript">
        document.addEventListener('click', function (e) {
            const btn = e.target.closest('.btn-eliminar');
            if (!btn) return;
            const id = btn.dataset.id;
            const nombre = btn.dataset.nombre;
            if (confirm('¿Está seguro que desea desactivar la categoría "' + nombre + '"? (Se cambiará su estado a inactivo)')) {
                window.location.href = 'CategoriaController?opcion=eliminar&id=' + encodeURIComponent(id);
            }
        });
    </script>
</body>
</html>
