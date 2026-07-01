<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>VENTAPLUS - Nueva Categoría</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

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

<body class="min-h-screen text-zinc-100 relative overflow-x-hidden selection:bg-emerald-500/30 selection:text-white pb-12 flex items-center justify-center">

    <!-- Ambient / Background Effects -->
    <div class="fixed inset-0 w-full h-full -z-10 overflow-hidden pointer-events-none">
        <!-- Tech Grid Overlay -->
        <div class="absolute inset-0 w-full h-full bg-[linear-gradient(rgba(255,255,255,0.012)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.012)_1px,transparent_1px)] bg-[size:50px_50px] bg-center [mask-image:radial-gradient(circle_at_center,black,transparent_90%)]">
        </div>

        <!-- Nebula Orbs matching Categoria emerald accent -->
        <div class="absolute top-[-10%] left-[-10%] w-[600px] h-[600px] rounded-full filter blur-[150px] opacity-30 mix-blend-screen animate-float-orb-1 bg-[radial-gradient(circle,rgba(16,185,129,0.45)_0%,transparent_70%)]">
        </div>
        <div class="absolute bottom-[-10%] right-[-10%] w-[600px] h-[600px] rounded-full filter blur-[150px] opacity-25 mix-blend-screen animate-float-orb-2 bg-[radial-gradient(circle,rgba(6,182,212,0.4)_0%,transparent_70%)]">
        </div>
    </div>

    <!-- Container Card -->
    <main class="w-full max-w-2xl px-4 sm:px-6 py-10 relative z-10">

        <!-- Header / Navigation Back -->
        <div class="mb-6 flex items-center justify-between">
            <a href="principal.jsp" class="inline-flex items-center gap-2 text-xs font-semibold text-zinc-400 hover:text-emerald-300 transition-colors py-2 px-3.5 bg-white/5 border border-white/8 rounded-xl backdrop-blur-md no-underline">
                <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5" />
                </svg>
                Volver al menú principal
            </a>
            <a href="gestionCategorias.jsp" class="inline-flex items-center gap-2 text-xs font-semibold text-zinc-400 hover:text-white transition-colors py-2 px-3.5 bg-white/5 border border-white/8 rounded-xl backdrop-blur-md no-underline">
                <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 12h16.5m-16.5 3.75h16.5M3.75 19.5h16.5M5.625 4.5h12.75a1.875 1.875 0 010 3.75H5.625a1.875 1.875 0 010-3.75z" />
                </svg>
                Ver listado
            </a>
        </div>

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

        <!-- Main Form Card -->
        <div class="bg-zinc-950/45 border border-white/8 rounded-3xl p-6 sm:p-8 backdrop-blur-xl hover:border-white/10 transition-all duration-300 shadow-2xl">

            <div class="border-b border-white/8 pb-5 mb-6">
                <h1 class="text-2xl sm:text-3xl font-extrabold tracking-tight bg-gradient-to-r from-white via-zinc-100 to-zinc-400 bg-clip-text text-transparent">
                    Nueva Categoría
                </h1>
                <p class="text-xs text-zinc-400 mt-1">
                    Complete el formulario para registrar una nueva categoría en el sistema.
                </p>
            </div>

            <!-- Form -->
            <form id="categoriaForm" action="CategoriaController" method="POST" class="space-y-5" onsubmit="return validarFormulario()">
                <!-- Hidden inputs for opcion (REQ-CAT-3.2 — POST to ?opcion=registrar) -->
                <input type="hidden" name="opcion" value="registrar">
                <input type="hidden" name="estado" value="A">

                <!-- Nombre (REQ-CAT-3.2: text, required, maxlength=50) -->
                <div class="relative">
                    <div class="group relative flex items-center bg-white/[0.02] border border-white/8 rounded-2xl transition-all duration-300 hover:bg-white/[0.04] hover:border-emerald-500/35 focus-within:bg-zinc-950/70 focus-within:border-emerald-500 focus-within:ring-2 focus-within:ring-emerald-500/25">
                        <span class="absolute left-4 text-zinc-500 pointer-events-none transition-colors duration-300 group-focus-within:text-emerald-500">
                            <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9.568 3H5.25A2.25 2.25 0 003 5.25v4.318c0 .597.237 1.17.659 1.591l9.581 9.581c.699.699 1.78.872 2.607.33a18.095 18.095 0 005.223-5.223c.542-.827.369-1.908-.33-2.607L11.16 3.66A2.25 2.25 0 009.568 3z" />
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 6h.008v.008H6V6z" />
                            </svg>
                        </span>
                        <input type="text" id="nombre" name="nombre" value=""
                            class="peer w-full py-4 pl-12 pr-4 bg-transparent border-none outline-none text-sm text-zinc-100 placeholder-transparent"
                            placeholder="Nombre" maxlength="50" required />
                        <label for="nombre" class="absolute left-12 top-1/2 -translate-y-1/2 text-sm text-zinc-400 pointer-events-none transition-all duration-300 origin-left peer-focus:-translate-y-6 peer-focus:scale-80 peer-focus:text-emerald-400 peer-[:not(:placeholder-shown)]:-translate-y-6 peer-[:not(:placeholder-shown)]:scale-80">
                            Nombre de la categoría (máx. 50 caracteres)
                        </label>
                    </div>
                </div>

                <!-- Descripción (REQ-CAT-3.2: textarea, maxlength=200) -->
                <div class="relative">
                    <div class="group relative bg-white/[0.02] border border-white/8 rounded-2xl transition-all duration-300 hover:bg-white/[0.04] hover:border-emerald-500/35 focus-within:bg-zinc-950/70 focus-within:border-emerald-500 focus-within:ring-2 focus-within:ring-emerald-500/25">
                        <span class="absolute left-4 top-4 text-zinc-500 pointer-events-none transition-colors duration-300 group-focus-within:text-emerald-500">
                            <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m2.25 0H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
                            </svg>
                        </span>
                        <textarea id="descripcion" name="descripcion" rows="4" maxlength="200"
                            class="w-full py-4 pl-12 pr-4 bg-transparent border-none outline-none text-sm text-zinc-100 placeholder-transparent resize-none"
                            placeholder="Descripción (opcional)"></textarea>
                        <label for="descripcion" class="absolute left-12 top-4 text-sm text-zinc-400 pointer-events-none transition-all duration-300 origin-left peer-focus:-translate-y-3 peer-focus:scale-80 peer-focus:text-emerald-400 peer-[:not(:placeholder-shown)]:-translate-y-3 peer-[:not(:placeholder-shown)]:scale-80">
                            Descripción (opcional, máx. 200 caracteres)
                        </label>
                    </div>
                </div>

                <!-- Info note: estado defaults to 'A' on create (REQ-CAT-3.2) -->
                <div class="flex items-start gap-2 p-3 rounded-xl bg-emerald-500/5 border border-emerald-500/15 text-xs text-zinc-400">
                    <svg class="w-4 h-4 text-emerald-400 flex-shrink-0 mt-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z" />
                    </svg>
                    <span>La nueva categoría se creará con estado <strong class="text-emerald-300">Activo</strong>. Puede modificar el estado más tarde desde la edición.</span>
                </div>

                <!-- Submit / Cancel Buttons Row -->
                <div class="flex flex-col sm:flex-row gap-4 pt-4 border-t border-white/5">
                    <button type="submit" class="w-full sm:flex-1 py-4 bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 rounded-2xl text-white font-semibold text-sm tracking-wide transition-all duration-300 transform hover:-translate-y-0.5 shadow-[0_4px_15px_rgba(16,185,129,0.25)] hover:shadow-[0_6px_20px_rgba(16,185,129,0.35)] cursor-pointer flex items-center justify-center gap-2">
                        <svg class="w-4.5 h-4.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                        </svg>
                        Registrar
                    </button>
                    <a href="gestionCategorias.jsp" class="w-full sm:w-auto px-6 py-4 bg-white/5 hover:bg-white/10 border border-white/8 rounded-2xl text-zinc-300 hover:text-white font-semibold text-sm transition-all duration-300 flex items-center justify-center gap-2 no-underline">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </main>

    <!-- Client-side form validations -->
    <script type="text/javascript">
        function validarFormulario() {
            var nombre = document.getElementById("nombre").value.trim();
            var descripcion = document.getElementById("descripcion").value.trim();

            if (nombre === "") {
                alert("Por favor, ingrese el nombre de la categoría.");
                return false;
            }

            if (nombre.length > 50) {
                alert("El nombre de la categoría no puede tener más de 50 caracteres.");
                return false;
            }

            if (descripcion.length > 200) {
                alert("La descripción no puede tener más de 200 caracteres.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
