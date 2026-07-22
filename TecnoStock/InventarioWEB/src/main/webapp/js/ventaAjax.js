/**
 * ventaAjax.js — Venta list AJAX with single fetch + cliente dropdown filter.
 * Depends on window.ui (js/ui.js).
 *
 * Pattern: single fetch on DOMContentLoaded, store in window.ventasData,
 * filter in-memory on #selCliente change (NO per-keystroke network calls).
 * Hard delete only — Venta has no estado field.
 */
(function () {
  'use strict';

  var tbody = document.getElementById('tbodyVentas');
  var clienteSelect = document.getElementById('selCliente');
  var allVentas = [];

  // ── Single fetch on load ──────────────────────────────────────────────

  function cargarVentas() {
    tbody.innerHTML = ui.skeletonRow(5);

    fetch('venta?opcion=listarVentasJson')
      .then(function (r) {
        if (!r.ok) throw new Error('Error en la respuesta del servidor');
        return r.json();
      })
      .then(function (data) {
        allVentas = data;
        renderTable(data);
      })
      .catch(function (err) {
        tbody.innerHTML = '<tr><td colspan="5" class="px-6 py-10 text-center text-rose-400 text-sm">Error al cargar datos: ' + err.message + '</td></tr>';
      });
  }

  // ── Load cliente dropdown ────────────────────────────────────────────

  function cargarClientes() {
    fetch('cliente?opcion=buscarClientesTodos')
      .then(function (r) { return r.json(); })
      .then(function (clientes) {
        clientes.forEach(function (c) {
          var opt = document.createElement('option');
          opt.value = c.id;
          opt.textContent = c.nombre + ' ' + c.apellidoPaterno + ' ' + c.apellidoMaterno + ' (DNI: ' + c.dni + ')';
          clienteSelect.appendChild(opt);
        });
      })
      .catch(function () { /* dropdown stays empty, full list shown */ });
  }

  // ── Render table ─────────────────────────────────────────────────────

  function renderTable(data) {
    tbody.innerHTML = '';
    if (!data || data.length === 0) {
      tbody.innerHTML = '<tr><td colspan="5" class="px-6 py-10 text-center text-slate-400 text-sm">No se encontraron ventas registradas.</td></tr>';
      return;
    }
    data.forEach(function (v) {
      var tr = document.createElement('tr');
      tr.className = 'hover:bg-pink-500/10 transition-colors border-b border-slate-700/40';
      tr.innerHTML =
        '<td class="px-6 py-4 text-sm text-slate-300 font-medium">' + v.id + '</td>' +
        '<td class="px-6 py-4 text-sm text-slate-300 font-mono">' + escapeHtml(v.fecha) + '</td>' +
        '<td class="px-6 py-4 text-sm font-semibold text-white">' + escapeHtml(v.clienteNombre) + '</td>' +
        '<td class="px-6 py-4 text-sm font-bold text-emerald-400 font-mono">S/ ' + v.total + '</td>' +
        '<td class="px-6 py-4 text-sm">' +
          '<div class="flex items-center justify-center gap-2">' +
            '<a href="venta?opcion=editar&id=' + v.id + '" ' +
               'class="px-3 py-1.5 text-xs font-medium text-indigo-300 hover:text-white bg-indigo-500/10 hover:bg-indigo-600/30 border border-indigo-500/30 rounded-lg transition-all shadow-sm">Editar</a>' +
            '<button data-action="eliminar" data-id="' + v.id + '" ' +
                    'class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm cursor-pointer">Eliminar</button>' +
          '</div>' +
        '</td>';
      tbody.appendChild(tr);
    });
  }

  // ── Client-side filter by cliente ────────────────────────────────────

  function filterByCliente(clienteId) {
    if (!clienteId) {
      renderTable(allVentas);
      return;
    }
    var filtered = allVentas.filter(function (v) {
      return String(v.clienteId) === String(clienteId);
    });
    renderTable(filtered);
  }

  // ── Event delegation (delete action) ────────────────────────────────

  document.addEventListener('click', function (e) {
    var btn = e.target.closest('[data-action="eliminar"]');
    if (!btn) return;

    var id = btn.getAttribute('data-id');

    ui.confirmDelete({
      title: 'Eliminar venta',
      body: '¿Eliminar la venta ID ' + id + '?',
      confirmLabel: 'Eliminar'
    }).then(function (confirmed) {
      if (!confirmed) return;

      ui.postJson('venta?opcion=eliminar&id=' + id, { id: id })
        .then(function (res) {
          if (res.ok) {
            ui.toast({ type: 'success', message: res.msg || 'Venta eliminada' });
            cargarVentas();
          } else {
            var errMsg = (res.errors && res.errors.length) ? res.errors.join(', ') : 'Error en la operaci\u00f3n';
            ui.toast({ type: 'error', message: errMsg });
          }
        })
        .catch(function (err) {
          var msg = (err && err.errors) ? err.errors.join(', ') : (err.message || 'Error de conexi\u00f3n');
          ui.toast({ type: 'error', message: msg });
        });
    });
  });

  // ── Init ─────────────────────────────────────────────────────────────

  document.addEventListener('DOMContentLoaded', function () {
    cargarClientes();
    cargarVentas();

    if (clienteSelect) {
      clienteSelect.addEventListener('change', function (e) {
        filterByCliente(e.target.value);
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
