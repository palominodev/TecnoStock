<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>VENTAPLUS - Panel Principal</title>

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap"
            rel="stylesheet">

        <!-- Tailwind CSS v4 CDN -->
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>

        <!-- Custom CSS Animations for Antigravity Theme -->
        <style type="text/css">
            body {
                font-family: 'Inter', sans-serif;
                background-color: #050508;
            }

            h1,
            h2,
            h3,
            a,
            button {
                font-family: 'Outfit', sans-serif;
            }

            /* Floating animations matching login */
            @keyframes float-orb-1 {

                0%,
                100% {
                    transform: translate(0, 0) scale(1);
                }

                33% {
                    transform: translate(40px, -60px) scale(1.1);
                }

                66% {
                    transform: translate(-30px, 30px) scale(0.95);
                }
            }

            @keyframes float-orb-2 {

                0%,
                100% {
                    transform: translate(0, 0) scale(1);
                }

                50% {
                    transform: translate(-60px, 50px) scale(1.05);
                }
            }

            .animate-float-orb-1 {
                animation: float-orb-1 25s ease-in-out infinite;
            }

            .animate-float-orb-2 {
                animation: float-orb-2 30s ease-in-out infinite;
            }
        </style>
    </head>

    <body class="min-h-screen overflow-x-hidden relative text-zinc-100 flex flex-col justify-between">

        <!-- Ambient background graphics -->
        <div class="fixed inset-0 w-full h-full -z-10 overflow-hidden pointer-events-none">
            <!-- Grid Overlay -->
            <div
                class="absolute inset-0 w-full h-full bg-[linear-gradient(rgba(255,255,255,0.012)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.012)_1px,transparent_1px)] bg-[size:40px_40px] bg-center [mask-image:radial-gradient(circle_at_center,black,transparent_75%)]">
            </div>

            <!-- Nebula Orbs -->
            <div
                class="absolute top-[10%] left-[10%] w-[500px] h-[500px] rounded-full filter blur-[130px] opacity-40 mix-blend-screen animate-float-orb-1 pointer-events-none bg-[radial-gradient(circle,rgba(139,92,246,0.5)_0%,transparent_70%)]">
            </div>
            <div
                class="absolute bottom-[10%] right-[10%] w-[550px] h-[550px] rounded-full filter blur-[130px] opacity-40 mix-blend-screen animate-float-orb-2 pointer-events-none bg-[radial-gradient(circle,rgba(6,182,212,0.45)_0%,transparent_70%)]">
            </div>
        </div>

        <!-- Top Navbar -->
        <header class="border-b border-white/5 bg-zinc-950/30 backdrop-blur-md sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-6 h-20 flex items-center justify-between">
                <!-- Brand Logo -->
                <div class="flex items-center gap-3">
                    <div
                        class="w-10 h-10 bg-gradient-to-br from-violet-500/15 to-cyan-500/15 border border-violet-500/30 rounded-xl flex items-center justify-center shadow-[0_0_15px_rgba(139,92,246,0.15)]">
                        <svg class="w-5 h-5 stroke-violet-400 stroke-[2.2] fill-none" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z" />
                        </svg>
                    </div>
                    <span
                        class="text-xl font-black tracking-widest bg-gradient-to-r from-white via-indigo-100 to-cyan-300 bg-clip-text text-transparent">
                        VENTAPLUS
                    </span>
                </div>

                <!-- Navigation & Profile info -->
                <div class="flex items-center gap-4">
                    <span
                        class="text-xs text-zinc-400 hidden sm:inline-block px-3 py-1.5 bg-white/5 border border-white/10 rounded-full font-medium">
                        Módulo Principal
                    </span>
                    <a href="HomeController?opcion=cerrarSesion"
                        class="text-xs text-red-400 hover:text-red-300 font-semibold px-4 py-2 border border-red-500/20 hover:border-red-500/40 rounded-xl bg-red-500/5 transition-all duration-300">
                        Cerrar Sesión
                    </a>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="flex-grow flex flex-col justify-center items-center px-6 py-16">
            <div class="max-w-4xl w-full text-center mb-12">
                <h1
                    class="text-4xl sm:text-5xl font-extrabold tracking-tight bg-gradient-to-r from-white via-zinc-100 to-zinc-400 bg-clip-text text-transparent mb-4">
                    Panel de Control Principal
                </h1>
                <p class="text-sm sm:text-base text-zinc-400 max-w-lg mx-auto leading-relaxed">
                    Plataforma inteligente de ventas y administración. Seleccione uno de los módulos de gestión para
                    iniciar operaciones.
                </p>
            </div>

            <!-- Cards Grid -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-4xl w-full">

                <!-- Card: GESTIÓN DE CLIENTES -->
                <div
                    class="group relative bg-zinc-950/45 border border-white/8 rounded-3xl p-8 backdrop-blur-xl transition-all duration-500 hover:border-violet-500/30 hover:-translate-y-1 hover:shadow-[0_15px_30px_rgba(139,92,246,0.1)] flex flex-col justify-between min-h-[320px]">
                    <div>
                        <!-- Icon -->
                        <div
                            class="w-14 h-14 bg-violet-500/10 border border-violet-500/20 rounded-2xl flex items-center justify-center mb-6 shadow-[0_0_15px_rgba(139,92,246,0.1)] group-hover:scale-110 group-hover:border-violet-500/40 transition-all duration-300">
                            <svg class="w-7 h-7 text-violet-400 stroke-[2] fill-none" stroke="currentColor"
                                viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.109A11.386 11.386 0 0110.089 20c-2.202 0-4.218-.627-5.918-1.714m14.017-3.07a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0zM6.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zm-.901 8.114A7.5 7.5 0 004.5 20.118a17.93 17.93 0 0012 1.632 7.5 7.5 0 00-10.65-7.636z" />
                            </svg>
                        </div>
                        <!-- Title -->
                        <h2
                            class="text-2xl font-bold tracking-wide text-zinc-100 mb-3 group-hover:text-violet-400 transition-colors duration-300">
                            GESTIÓN DE CLIENTES
                        </h2>
                        <!-- Description -->
                        <p class="text-sm text-zinc-400 leading-relaxed">
                            Administre el registro integral de clientes, historiales de compra, actualización de datos
                            de contacto y estado comercial.
                        </p>
                    </div>
                    <!-- Link/Action -->
                    <div class="mt-8">
                        <a href="ClienteController?opcion=listarClientes"
                            class="inline-flex items-center gap-2 text-sm font-semibold text-violet-400 group-hover:text-violet-300 transition-all duration-300">
                            <span>Abrir Módulo de Clientes</span>
                            <svg class="w-4 h-4 transition-transform duration-300 group-hover:translate-x-1" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />
                            </svg>
                        </a>
                    </div>
                </div>

                <!-- Card: GESTIÓN DE PRODUCTOS -->
                <div
                    class="group relative bg-zinc-950/45 border border-white/5 rounded-3xl p-8 backdrop-blur-xl transition-all duration-500 overflow-hidden flex flex-col justify-between min-h-[320px] select-none">
                    <div class="opacity-30 pointer-events-none transition-all duration-500">
                        <!-- Icon -->
                        <div
                            class="w-14 h-14 bg-cyan-500/10 border border-cyan-500/20 rounded-2xl flex items-center justify-center mb-6 shadow-[0_0_15px_rgba(6,182,212,0.1)]">
                            <svg class="w-7 h-7 text-cyan-400 stroke-[2] fill-none" stroke="currentColor"
                                viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125H3.375c-.621 0-1.125.504-1.125 1.125z" />
                            </svg>
                        </div>
                        <!-- Title -->
                        <h2 class="text-2xl font-bold tracking-wide text-zinc-100 mb-3">
                            GESTIÓN DE PRODUCTOS
                        </h2>
                        <!-- Description -->
                        <p class="text-sm text-zinc-400 leading-relaxed">
                            Gestione el catálogo de inventario, actualización de stock, control de precios, categorías y
                            estados de productos.
                        </p>
                    </div>
                    <!-- Link/Action -->
                    <div class="mt-8 opacity-30 pointer-events-none transition-all duration-500">
                        <span class="inline-flex items-center gap-2 text-sm font-semibold text-cyan-400">
                            <span>Abrir Módulo de Productos</span>
                            <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                                stroke-width="2.5">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />
                            </svg>
                        </span>
                    </div>

                    <!-- Ambient locked badge overlay -->
                    <div
                        class="absolute inset-0 bg-zinc-950/60 backdrop-blur-[2px] flex items-center justify-center p-6 transition-all duration-500">
                        <div
                            class="px-5 py-2.5 bg-gradient-to-r from-cyan-500/10 to-violet-500/10 border border-cyan-500/30 rounded-full text-cyan-400 text-xs font-bold tracking-widest uppercase shadow-[0_0_20px_rgba(6,182,212,0.15)] flex items-center gap-2 hover:scale-105 transition-all duration-300">
                            <span class="relative flex h-2 w-2 mr-1">
                                <span
                                    class="animate-ping absolute inline-flex h-full w-full rounded-full bg-cyan-400 opacity-75"></span>
                                <span
                                    class="relative inline-flex rounded-full h-2 w-2 bg-cyan-400 shadow-[0_0_8px_rgba(34,211,238,0.5)]"></span>
                            </span>
                            <span>Próximamente</span>
                        </div>
                    </div>

                    <!-- Card: GESTIÓN DE CATEGORÍAS -->
                    <div
                        class="group relative bg-zinc-950/45 border border-white/8 rounded-3xl p-8 backdrop-blur-xl transition-all duration-500 hover:border-emerald-500/30 hover:-translate-y-1 hover:shadow-[0_15px_30px_rgba(16,185,129,0.1)] flex flex-col justify-between min-h-[320px]">
                        <div>
                            <!-- Icon -->
                            <div
                                class="w-14 h-14 bg-emerald-500/10 border border-emerald-500/20 rounded-2xl flex items-center justify-center mb-6 shadow-[0_0_15px_rgba(16,185,129,0.1)] group-hover:scale-110 group-hover:border-emerald-500/40 transition-all duration-300">
                                <svg class="w-7 h-7 text-emerald-400 stroke-[2] fill-none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M9.568 3H5.25A2.25 2.25 0 003 5.25v4.318c0 .597.237 1.17.659 1.591l9.581 9.581c.699.699 1.78.872 2.607.33a18.095 18.095 0 005.223-5.223c.542-.827.369-1.908-.33-2.607L11.16 3.66A2.25 2.25 0 009.568 3z" />
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M6 6h.008v.008H6V6z" />
                                </svg>
                            </div>
                            <!-- Title -->
                            <h2
                                class="text-2xl font-bold tracking-wide text-zinc-100 mb-3 group-hover:text-emerald-400 transition-colors duration-300">
                                GESTIÓN DE CATEGORÍAS
                            </h2>
                            <!-- Description -->
                            <p class="text-sm text-zinc-400 leading-relaxed">
                                Administre el catálogo de categorías de productos, organice la jerarquía
                                comercial y mantenga actualizados los estados del registro.
                            </p>
                        </div>
                        <!-- Link/Action -->
                        <div class="mt-8">
                            <a href="CategoriaController?opcion=listar"
                                class="inline-flex items-center gap-2 text-sm font-semibold text-emerald-400 group-hover:text-emerald-300 transition-all duration-300">
                                <span>Abrir Módulo de Categorías</span>
                                <svg class="w-4 h-4 transition-transform duration-300 group-hover:translate-x-1" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />
                                </svg>
                            </a>
                        </div>
                    </div>

                </div>

            </div>
        </main>

        <!-- Footer -->
        <footer class="border-t border-white/5 py-6 bg-zinc-950/20 text-center">
            <span class="text-xs text-zinc-600 font-medium">
                &copy; 2026 VENTAPLUS. Todos los derechos reservados.
            </span>
        </footer>

    </body>

    </html>