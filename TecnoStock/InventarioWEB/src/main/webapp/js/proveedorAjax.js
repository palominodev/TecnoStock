/**
 * proveedorAjax.js — Proveedor list AJAX with single fetch + client-side filter.
 * Depends on window.ui (js/ui.js).
 *
 * Pattern: single fetch on DOMContentLoaded, store in window.proveedoresData,
 * filter in-memory on #txtBuscar input (NO per-keystroke network calls).
 */
(function () {
  'use strict';

  var tbody = document.getElementById('tbodyProveedores');

  // ── Single fetch on load ──────────────────────────────────────────────

  function cargarProveedores(incluirInactivos) {
    var endpoint = 'proveedor?opcion=buscarProveedoresTodos';
    tbody.innerHTML = ui.skeletonRow(7);

    fetch(endpoint)
      .then(function (r) {
        if (!r.ok) throw new Error('Error en la respuesta del servidor');
        return r.json();
      })
      .then(function (data) {
        window.proveedoresData = data;
        renderTable(data);
      })
      .catch(function (err) {
        tbody.innerHTML = '<tr><td colspan="7" class="px-6 py-10 text-center text-rose-400 text-sm">Error al cargar datos: ' + err.message + '</td></tr>';
      });
  }

  // ── Render table ─────────────────────────────────────────────────────

  function renderTable(data) {
    tbody.innerHTML = '';
    if (!data || data.length === 0) {
      tbody.innerHTML = '<tr><td colspan="7" class="px-6 py-10 text-center text-slate-400 text-sm">No se encontraron proveedores.</td></tr>';
      return;
    }
    data.forEach(function (p) {
      var tr = document.createElement('tr');
      tr.className = 'hover:bg-amber-500/10 transition-colors border-b border-slate-700/40';

      var esActivo = p.estado && p.estado.toLowerCase() === 'activo';
      var badgeClass = esActivo
        ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30'
        : 'bg-rose-500/10 text-rose-400 border border-rose-500/30';
      var badgeLabel = esActivo ? 'Activo' : 'Inactivo';

      tr.innerHTML =
        '<td class="px-6 py-4 text-sm text-slate-300 font-medium">' + p.id + '</td>' +
        '<td class="px-6 py-4 text-sm font-mono text-amber-300 font-medium">' + escapeHtml(p.ruc) + '</td>' +
        '<td class="px-6 py-4 text-sm font-semibold text-white">' + escapeHtml(p.razonSocial) + '</td>' +
        '<td class="px-6 py-4 text-sm text-slate-300">' + escapeHtml(p.direccion || '') + '</td>' +
        '<td class="px-6 py-4 text-sm text-slate-300 font-mono">' + escapeHtml(p.telefono || '') + '</td>' +
        '<td class="px-6 py-4 text-sm text-slate-300">' + escapeHtml(p.nombreContacto || '') + '</td>' +
        '<td class="px-6 py-4 text-sm">' +
          '<div class="flex items-center justify-center gap-2">' +
            '<a href="proveedor?opcion=editar&id=' + p.id + '" ' +
               'class="px-3 py-1.5 text-xs font-medium text-amber-300 hover:text-white bg-amber-500/10 hover:bg-amber-600/30 border border-amber-500/30 rounded-lg transition-all shadow-sm">Editar</a>' +
            (esActivo
              ? '<button data-action="eliminar" data-id="' + p.id + '" data-nombre="' + escapeHtml(p.razonSocial) + '" ' +
                      'class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm cursor-pointer">Desactivar</button>'
              : '<button data-action="reactivar" data-id="' + p.id + '" data-nombre="' + escapeHtml(p.razonSocial) + '" ' +
                      'class="px-3 py-1.5 text-xs font-medium text-emerald-300 hover:text-white bg-emerald-500/10 hover:bg-emerald-600/30 border border-emerald-500/30 rounded-lg transition-all shadow-sm cursor-pointer">Reactivar</button>') +
          '</div>' +
        '</td>';
      tbody.appendChild(tr);
    });
  }

  // ── Client-side filter ───────────────────────────────────────────────

  function filterTable(query) {
    if (!window.proveedoresData) return;
    var q = query.toLowerCase();
    var filtered = window.proveedoresData.filter(function (p) {
      return (p.ruc && p.ruc.toLowerCase().includes(q)) ||
             (p.razonSocial && p.razonSocial.toLowerCase().includes(q)) ||
             (p.direccion && p.direccion.toLowerCase().includes(q)) ||
             (p.telefono && p.telefono.includes(q)) ||
             (p.nombreContacto && p.nombreContacto.toLowerCase().includes(q));
    });
    renderTable(filtered);
  }

  // ── Event delegation (CUD actions) ───────────────────────────────────

  document.addEventListener('click', function (e) {
    var btn = e.target.closest('[data-action="eliminar"], [data-action="reactivar"]');
    if (!btn) return;

    var action = btn.getAttribute('data-action');
    var id = btn.getAttribute('data-id');
    var nombre = btn.getAttribute('data-nombre');

    if (action === 'eliminar') {
      ui.confirmDelete({
        title: 'Desactivar proveedor',
        body: '¿Desactivar al proveedor "' + nombre + '"?',
        confirmLabel: 'Desactivar'
      }).then(function (confirmed) {
        if (!confirmed) return;
        doAction('eliminar', id, 'Proveedor desactivado');
      });
    } else if (action === 'reactivar') {
      ui.confirmDelete({
        title: 'Reactivar proveedor',
        body: '¿Reactivar al proveedor "' + nombre + '"?',
        confirmLabel: 'Reactivar'
      }).then(function (confirmed) {
        if (!confirmed) return;
        doAction('reactivar', id, 'Proveedor reactivado');
      });
    }
  });

  function doAction(opcion, id, successMsg) {
    ui.postJson('proveedor?opcion=' + opcion + '&id=' + id, { id: id })
      .then(function (res) {
        if (res.ok) {
          ui.toast({ type: 'success', message: res.msg || successMsg });
          cargarProveedores();
        } else {
          var errMsg = (res.errors && res.errors.length) ? res.errors.join(', ') : 'Error en la operación';
          ui.toast({ type: 'error', message: errMsg });
        }
      })
      .catch(function (err) {
        var msg = (err && err.errors) ? err.errors.join(', ') : (err.message || 'Error de conexión');
        ui.toast({ type: 'error', message: msg });
      });
  }

  // ── Search input (client-side filter, no network) ────────────────────

  document.addEventListener('DOMContentLoaded', function () {
    cargarProveedores();

    var input = document.getElementById('txtBuscar');
    if (input) {
      input.addEventListener('input', function (e) {
        filterTable(e.target.value);
      });
    }
  });

  // ── Helper ───────────────────────────────────────────────────────────

  function escapeHtml(str) {
    if (!str) return '';
    var div = document.createElement('div');
    div.appendChild(document.createTextNode(str));
    return div.innerHTML;
  }
})();
