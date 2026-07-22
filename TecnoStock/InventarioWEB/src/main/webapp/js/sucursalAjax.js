/**
 * sucursalAjax.js — Sucursal list AJAX with debounce, modal confirm, toasts.
 * Depends on window.ui (js/ui.js).
 *
 * Slice 1b: supports Desactivar (soft delete) and Reactivar actions;
 * reads ?inactivos=true from URL to show inactive rows.
 */
(function () {
  'use strict';

  // ── Read ?inactivos=true from URL ────────────────────────────────────

  var urlParams = new URLSearchParams(window.location.search);
  var showInactivos = urlParams.get('inactivos') === 'true';

  // ── Build endpoint URL ───────────────────────────────────────────────

  var endpoint = 'SucursalController?accion=buscar&nombre=';
  if (showInactivos) {
    endpoint += '&inactivos=true';
  }

  // ── Live search ──────────────────────────────────────────────────────

  ui.bindAjaxTable({
    rootSelector: '#txtBuscar',
    endpoint: endpoint,
    debounceMs: 180,
    columns: 5,
    rowTemplate: function (s) {
      var esActivo = s.estado && s.estado.toLowerCase() === 'activo';
      var badgeClass = esActivo
        ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30'
        : 'bg-rose-500/10 text-rose-400 border border-rose-500/30';

      var actionBtn;
      if (esActivo) {
        actionBtn = '<button data-action="eliminar" data-id="' + s.idSucursal + '" data-nombre="' + escapeHtml(s.nombre) + '" ' +
                        'class="px-3 py-1.5 text-xs font-medium text-rose-300 hover:text-white bg-rose-500/10 hover:bg-rose-600/30 border border-rose-500/30 rounded-lg transition-all shadow-sm cursor-pointer">Desactivar</button>';
      } else {
        actionBtn = '<button data-action="reactivar" data-id="' + s.idSucursal + '" data-nombre="' + escapeHtml(s.nombre) + '" ' +
                        'class="px-3 py-1.5 text-xs font-medium text-emerald-300 hover:text-white bg-emerald-500/10 hover:bg-emerald-600/30 border border-emerald-500/30 rounded-lg transition-all shadow-sm cursor-pointer">Reactivar</button>';
      }

      return (
        '<td class="px-6 py-4 text-sm text-slate-300 font-medium">' + s.idSucursal + '</td>' +
        '<td class="px-6 py-4 text-sm font-semibold text-white">' + escapeHtml(s.nombre) + '</td>' +
        '<td class="px-6 py-4 text-sm text-slate-300">' + escapeHtml(s.direccion) + '</td>' +
        '<td class="px-6 py-4 text-sm">' +
          '<span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ' + badgeClass + '">' +
            escapeHtml(s.estado) +
          '</span>' +
        '</td>' +
        '<td class="px-6 py-4 text-sm">' +
          '<div class="flex items-center gap-2">' +
            '<a href="SucursalController?accion=editar&id=' + s.idSucursal + '" ' +
               'class="px-3 py-1.5 text-xs font-medium text-indigo-300 hover:text-white bg-indigo-500/10 hover:bg-indigo-600/30 border border-indigo-500/30 rounded-lg transition-all shadow-sm">Editar</a>' +
            actionBtn +
          '</div>' +
        '</td>'
      );
    }
  });

  // ── Action handlers (event delegation) ───────────────────────────────

  document.addEventListener('click', function (e) {
    var btn = e.target.closest('[data-action="eliminar"], [data-action="reactivar"]');
    if (!btn) return;

    var action = btn.getAttribute('data-action');
    var id = btn.getAttribute('data-id');
    var nombre = btn.getAttribute('data-nombre');

    var esDesactivar = action === 'eliminar';
    var title = esDesactivar ? 'Desactivar sucursal' : 'Reactivar sucursal';
    var bodyText = esDesactivar
      ? '¿Desactivar la sucursal "' + nombre + '"?'
      : '¿Reactivar la sucursal "' + nombre + '"?';
    var label = esDesactivar ? 'Desactivar' : 'Reactivar';
    var accionParam = esDesactivar ? 'eliminar' : 'reactivar';
    var successMsg = esDesactivar ? 'Sucursal desactivada' : 'Sucursal reactivada';

    ui.confirmDelete({
      title: title,
      body: bodyText,
      confirmLabel: label
    }).then(function (confirmed) {
      if (!confirmed) return;

      ui.postJson('SucursalController?accion=' + accionParam + '&id=' + id, { id: id })
        .then(function (res) {
          if (res.ok) {
            ui.toast({ type: 'success', message: res.msg || successMsg });
            // Re-trigger the search to refresh the list
            var input = document.getElementById('txtBuscar');
            if (input) {
              var evt = new Event('input');
              input.dispatchEvent(evt);
            }
          } else {
            var errMsg = (res.errors && res.errors.length) ? res.errors.join(', ') : 'Error al procesar';
            ui.toast({ type: 'error', message: errMsg });
          }
        })
        .catch(function (err) {
          var msg = (err && err.errors) ? err.errors.join(', ') : (err.message || 'Error de conexión');
          ui.toast({ type: 'error', message: msg });
        });
    });
  });

  // ── Helper ───────────────────────────────────────────────────────────

  function escapeHtml(str) {
    if (!str) return '';
    var div = document.createElement('div');
    div.appendChild(document.createTextNode(str));
    return div.innerHTML;
  }
})();
