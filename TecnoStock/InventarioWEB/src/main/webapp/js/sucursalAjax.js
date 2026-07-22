document.addEventListener("DOMContentLoaded", () => {
    const txtBuscar = document.getElementById("txtBuscar");
    const tbodySucursales = document.getElementById("tbodySucursales");

    if (txtBuscar && tbodySucursales) {
        txtBuscar.addEventListener("input", (e) => {
            const query = e.target.value.trim();
            buscarSucursales(query);
        });
    }
});

/**
 * Realiza la llamada asíncrona al Servlet
 */
function buscarSucursales(query) {
    const url = `SucursalController?accion=buscar&nombre=${encodeURIComponent(query)}`;
    
    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error("Error en la respuesta del servidor");
            }
            return response.json();
        })
        .then(data => {
            renderizarTabla(data);
        })
        .catch(error => {
            console.error("Error al buscar sucursales:", error);
        });
}

/**
 * Reconstruye el DOM del cuerpo de la tabla con los resultados obtenidos
 */
function renderizarTabla(sucursales) {
    const tbody = document.getElementById("tbodySucursales");
    tbody.innerHTML = ""; // Limpiar filas anteriores

    if (sucursales.length === 0) {
        const row = document.createElement("tr");
        const cell = document.createElement("td");
        cell.colSpan = 5;
        cell.className = "px-6 py-10 text-center text-slate-400 text-sm";
        cell.innerText = "No se encontraron sucursales con ese nombre.";
        row.appendChild(cell);
        tbody.appendChild(row);
        return;
    }

    sucursales.forEach(s => {
        const row = document.createElement("tr");
        row.className = "border-b border-slate-700/50 hover:bg-indigo-500/10 transition-colors";

        // 1. Código
        const cellId = document.createElement("td");
        cellId.className = "px-6 py-4 text-sm text-slate-300 font-medium";
        cellId.innerText = s.idSucursal;
        row.appendChild(cellId);

        // 2. Nombre
        const cellNombre = document.createElement("td");
        cellNombre.className = "px-6 py-4 text-sm font-semibold text-white";
        cellNombre.innerText = s.nombre;
        row.appendChild(cellNombre);

        // 3. Dirección
        const cellDireccion = document.createElement("td");
        cellDireccion.className = "px-6 py-4 text-sm text-slate-300";
        cellDireccion.innerText = s.direccion;
        row.appendChild(cellDireccion);

        // 4. Estado (con Badge dinámico)
        const cellEstado = document.createElement("td");
        cellEstado.className = "px-6 py-4 text-sm";
        const badge = document.createElement("span");
        const esActivo = s.estado.toLowerCase() === "activo";
        badge.className = `inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${
            esActivo ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30' : 'bg-rose-500/10 text-rose-400 border border-rose-500/30'
        }`;
        badge.innerText = s.estado;
        cellEstado.appendChild(badge);
        row.appendChild(cellEstado);

        // 5. Acciones (Editar/Eliminar)
        const cellAcciones = document.createElement("td");
        cellAcciones.className = "px-6 py-4 text-sm";
        
        const containerAcciones = document.createElement("div");
        containerAcciones.className = "flex items-center gap-2";

        // Link Editar
        const linkEditar = document.createElement("a");
        linkEditar.href = `SucursalController?accion=editar&id=${s.idSucursal}`;
        linkEditar.className = "px-3 py-1.5 text-xs font-medium text-indigo-300 hover:text-white bg-indigo-500/10 hover:bg-indigo-600/30 border border-indigo-500/30 rounded-lg transition-all shadow-sm";
        linkEditar.innerText = "Editar";
        containerAcciones.appendChild(linkEditar);

        // Botón Eliminar
        const linkEliminar = document.createElement("a");
        linkEliminar.href = `SucursalController?accion=eliminar&id=${s.idSucursal}`;
        linkEliminar.className = "px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm";
        linkEliminar.innerText = "Eliminar";
        linkEliminar.onclick = (e) => {
            if (!confirm(`¿Estás seguro de que querés eliminar la sucursal "${s.nombre}"?`)) {
                e.preventDefault();
            }
        };
        containerAcciones.appendChild(linkEliminar);

        cellAcciones.appendChild(containerAcciones);
        row.appendChild(cellAcciones);
        tbody.appendChild(row);
    });
}
