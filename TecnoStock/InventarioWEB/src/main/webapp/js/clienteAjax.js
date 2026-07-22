/**
 * clienteAjax.js — Cliente list AJAX with in-memory filter, ui.confirmDelete, ui.toast.
 * Depends on window.ui (js/ui.js). One-shot fetch + client-side filter pattern.
 */
(function () {
  'use strict';

  var clienteAjax = {};

  // ── State ────────────────────────────────────────────────────────────

  var allClientes = [];
  var showInactivos = false;

  // ── Init ─────────────────────────────────────────────────────────────

  clienteAjax.init = function () {
    showInactivos = new URLSearchParams(window.location.search).get('inactivos') === 'true';

    var chkToggle = document.getElementById('chkInactivos');
    if (chkToggle) {
      chkToggle.checked = showInactivos;
      chkToggle.addEventListener('change', function () {
        showInactivos = chkToggle.checked;
        renderTable(allClientes);
      });
    }

    loadClientes();
    wireSearch();
    wireActions();
  };

  // ── Load ─────────────────────────────────────────────────────────────

  function loadClientes() {
    var tbody = document.getElementById('tbodyClientes');
    tbody.innerHTML = ui.skeletonRow(6);

    fetch('cliente?opcion=buscarClientesTodos')
      .then(function (r) { return r.json(); })
      .then(function (data) {
        allClientes = data;
        renderTable(data);
      })
      .catch(function (err) {
        tbody.innerHTML = '<tr><td colspan="6" class="px-6 py-10 text-center text-rose-400 text-sm">Error al cargar datos: ' + err.message + '</td></tr>';
      });
  }

  // ── Render ───────────────────────────────────────────────────────────

  function renderTable(data) {
    var tbody = document.getElementById('tbodyClientes');
    tbody.innerHTML = '';

    var filtered = !showInactivos
      ? data.filter(function (c) { return c.estado && c.estado.toUpperCase() === 'A'; })
      : data;

    if (filtered.length === 0) {
      tbody.innerHTML = '<tr><td colspan="6" class="px-6 py-10 text-center text-slate-400 text-sm">No se encontraron clientes.</td></tr>';
      return;
    }

    filtered.forEach(function (cliente) {
      var tr = document.createElement('tr');
      tr.className = 'hover:bg-indigo-500/10 transition-colors border-b border-slate-700/40';
      var esActivo = cliente.estado && cliente.estado.toUpperCase() === 'A';
      var badgeClass = esActivo
        ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30'
        : 'bg-rose-500/10 text-rose-400 border border-rose-500/30';
      var badgeLabel = esActivo ? 'Activo' : 'Inactivo';

      var actions = '';
      actions += '<a href="cliente?opcion=editar&id=' + cliente.id + '" class="px-3 py-1.5 text-xs font-medium text-indigo-300 hover:text-white bg-indigo-500/10 hover:bg-indigo-600/30 border border-indigo-500/30 rounded-lg transition-all shadow-sm">Editar</a>';

      if (esActivo) {
        actions += '<button data-action="eliminar" data-id="' + cliente.id + '" data-nombre="' + escapeHtml(cliente.nombre) + ' ' + escapeHtml(cliente.apellidoPaterno) + '" class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm cursor-pointer">Desactivar</button>';
      } else {
        actions += '<button data-action="reactivar" data-id="' + cliente.id + '" data-nombre="' + escapeHtml(cliente.nombre) + ' ' + escapeHtml(cliente.apellidoPaterno) + '" class="px-3 py-1.5 text-xs font-medium text-emerald-300 hover:text-white bg-emerald-500/10 hover:bg-emerald-600/30 border border-emerald-500/30 rounded-lg transition-all shadow-sm cursor-pointer">Reactivar</button>';
      }

      tr.innerHTML =
        '<td class="px-6 py-4 text-sm text-slate-300 font-medium">' + cliente.id + '</td>' +
        '<td class="px-6 py-4 text-sm font-semibold text-white">' + escapeHtml(cliente.nombre) + '</td>' +
        '<td class="px-6 py-4 text-sm text-slate-300">' + escapeHtml(cliente.apellidoPaterno) + ' ' + escapeHtml(cliente.apellidoMaterno) + '</td>' +
        '<td class="px-6 py-4 text-sm text-slate-300 font-mono">' + escapeHtml(cliente.dni) + '</td>' +
        '<td class="px-6 py-4 text-sm">' +
          '<span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ' + badgeClass + '">' + badgeLabel + '</span>' +
        '</td>' +
        '<td class="px-6 py-4 text-sm">' +
          '<div class="flex items-center justify-center gap-2">' + actions + '</div>' +
        '</td>';
      tbody.appendChild(tr);
    });
  }

  // ── Search ───────────────────────────────────────────────────────────

  function wireSearch() {
    var input = document.getElementById('txtBuscar');
    if (!input) return;
    input.addEventListener('input', function () {
      var query = this.value.toLowerCase();
      if (!allClientes.length) return;
      var filtered = allClientes.filter(function (c) {
        return (c.nombre && c.nombre.toLowerCase().includes(query)) ||
               (c.apellidoPaterno && c.apellidoPaterno.toLowerCase().includes(query)) ||
               (c.apellidoMaterno && c.apellidoMaterno.toLowerCase().includes(query)) ||
               (c.dni && c.dni.toLowerCase().includes(query));
      });
      renderTable(filtered);
    });
  }

  // ── Actions ──────────────────────────────────────────────────────────

  function wireActions() {
    document.addEventListener('click', function (e) {
      var btn = e.target.closest('[data-action]');
      if (!btn) return;

      var action = btn.getAttribute('data-action');
      var id = btn.getAttribute('data-id');
      var nombre = btn.getAttribute('data-nombre');

      if (action === 'eliminar') {
        ui.confirmDelete({
          title: 'Desactivar cliente',
          body: '¿Desactivar al cliente "' + nombre + '"?',
          confirmLabel: 'Desactivar'
        }).then(function (confirmed) {
          if (!confirmed) return;
          ui.postJson('cliente?opcion=eliminar&id=' + id, { id: id })
            .then(function (res) {
              if (res.ok) {
                ui.toast({ type: 'success', message: res.msg || 'Cliente desactivado' });
                loadClientes();
              } else {
                var errMsg = (res.errors && res.errors.length) ? res.errors.join(', ') : 'Error al desactivar';
                ui.toast({ type: 'error', message: errMsg });
              }
            })
            .catch(function (err) {
              var msg = (err && err.errors) ? err.errors.join(', ') : (err.message || 'Error de conexión');
              ui.toast({ type: 'error', message: msg });
            });
        });
      } else if (action === 'reactivar') {
        ui.confirmDelete({
          title: 'Reactivar cliente',
          body: '¿Reactivar al cliente "' + nombre + '"?',
          confirmLabel: 'Reactivar'
        }).then(function (confirmed) {
          if (!confirmed) return;
          ui.postJson('cliente?opcion=reactivar&id=' + id, { id: id })
            .then(function (res) {
              if (res.ok) {
                ui.toast({ type: 'success', message: res.msg || 'Cliente reactivado' });
                loadClientes();
              } else {
                var errMsg = (res.errors && res.errors.length) ? res.errors.join(', ') : 'Error al reactivar';
                ui.toast({ type: 'error', message: errMsg });
              }
            })
            .catch(function (err) {
              var msg = (err && err.errors) ? err.errors.join(', ') : (err.message || 'Error de conexión');
              ui.toast({ type: 'error', message: msg });
            });
        });
      }
    });
  }

  // ── Helper ───────────────────────────────────────────────────────────

  function escapeHtml(str) {
    if (!str) return '';
    var div = document.createElement('div');
    div.appendChild(document.createTextNode(str));
    return div.innerHTML;
  }

  // ── Export ───────────────────────────────────────────────────────────
  window.clienteAjax = clienteAjax;
})();
