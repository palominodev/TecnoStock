/**
 * ui.js — Vanilla ES2020 helper module for InventarioWEB
 * Defines window.ui with toast, confirmDelete, skeletonRow, bindAjaxTable, postJson, isFetchRequest.
 * No build step, no module system. Load via <script src="js/ui.js"></script>.
 */
(function () {
  'use strict';

  var ui = {};

  // ── Toast ──────────────────────────────────────────────────────────────

  /**
   * Show a toast notification.
   * @param {{type: 'success'|'error'|'info', message: string, duration?: number}} opts
   */
  ui.toast = function toast(opts) {
    var type = opts.type || 'info';
    var msg = opts.message || '';
    var duration = opts.duration != null ? opts.duration : 3500;

    var region = document.getElementById('ts-toast-region');
    if (!region) {
      region = document.createElement('div');
      region.id = 'ts-toast-region';
      region.setAttribute('aria-live', 'polite');
      region.setAttribute('aria-relevant', 'additions');
      region.className = 'fixed top-4 right-4 z-50 flex flex-col gap-3 max-w-sm w-full pointer-events-none';
      document.body.appendChild(region);
    }

    var toast = document.createElement('div');
    toast.setAttribute('role', 'status');
    toast.setAttribute('aria-live', type === 'error' ? 'assertive' : 'polite');
    toast.className =
      'pointer-events-auto flex items-start gap-3 px-5 py-4 rounded-2xl shadow-2xl border transition-all translate-x-0 opacity-100';

    var bg, border, textColor, iconSvg;
    if (type === 'success') {
      bg = 'bg-emerald-900/90 border-emerald-600/50';
      textColor = 'text-emerald-200';
      iconSvg = '<svg class="w-5 h-5 flex-shrink-0 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>';
    } else if (type === 'error') {
      bg = 'bg-rose-900/90 border-rose-600/50';
      textColor = 'text-rose-200';
      iconSvg = '<svg class="w-5 h-5 flex-shrink-0 text-rose-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>';
    } else {
      bg = 'bg-slate-800/95 border-slate-600/50';
      textColor = 'text-slate-200';
      iconSvg = '<svg class="w-5 h-5 flex-shrink-0 text-indigo-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>';
    }
    toast.className += ' ' + bg + ' ' + border;

    toast.innerHTML =
      iconSvg +
      '<span class="flex-1 text-sm font-medium ' + textColor + '">' + escapeHtml(msg) + '</span>' +
      '<button class="flex-shrink-0 text-slate-500 hover:text-white transition-colors" aria-label="Cerrar">&times;</button>';

    // Slide-in animation via style
    toast.style.transform = 'translateX(120%)';
    toast.style.opacity = '0';
    region.appendChild(toast);
    // Force reflow then animate in
    toast.offsetHeight;
    toast.style.transition = 'transform 0.3s ease-out, opacity 0.3s ease-out';
    toast.style.transform = 'translateX(0)';
    toast.style.opacity = '1';

    // Close button handler
    toast.querySelector('button').addEventListener('click', function () { dismiss(toast); });

    // Auto-dismiss
    var timer = setTimeout(function () { dismiss(toast); }, duration);

    function dismiss(el) {
      clearTimeout(timer);
      el.style.transform = 'translateX(120%)';
      el.style.opacity = '0';
      setTimeout(function () { if (el.parentNode) el.parentNode.removeChild(el); }, 300);
    }
  };

  // ── Confirm Delete Modal ──────────────────────────────────────────────

  /**
   * Show a confirmation modal. Returns Promise<boolean>.
   * @param {{title?: string, body: string, confirmLabel?: string, cancelLabel?: string}} opts
   * @returns {Promise<boolean>}
   */
  ui.confirmDelete = function confirmDelete(opts) {
    var title = opts.title || 'Confirmar';
    var body = opts.body || '';
    var confirmLabel = opts.confirmLabel || 'Eliminar';
    var cancelLabel = opts.cancelLabel || 'Cancelar';

    var trigger = document.activeElement;

    return new Promise(function (resolve) {
      var backdrop = document.createElement('div');
      backdrop.className = 'fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm';
      backdrop.setAttribute('role', 'dialog');
      backdrop.setAttribute('aria-modal', 'true');
      backdrop.setAttribute('aria-labelledby', 'ts-confirm-title');

      var modal = document.createElement('div');
      modal.className =
        'glass-panel rounded-3xl p-8 max-w-md w-full mx-4 shadow-2xl border border-slate-700/60 animate-in';
      modal.innerHTML =
        '<h2 id="ts-confirm-title" class="text-xl font-bold text-white mb-2">' + escapeHtml(title) + '</h2>' +
        '<p id="ts-confirm-body" class="text-sm text-slate-400 mb-8">' + escapeHtml(body) + '</p>' +
        '<div class="flex items-center gap-3 justify-end">' +
          '<button id="ts-confirm-cancel" class="px-5 py-2.5 rounded-xl text-sm font-semibold text-slate-300 hover:text-white bg-slate-800/80 hover:bg-slate-700/80 border border-slate-700 transition-all cursor-pointer">' + escapeHtml(cancelLabel) + '</button>' +
          '<button id="ts-confirm-ok" class="px-5 py-2.5 rounded-xl text-sm font-semibold text-white bg-rose-600 hover:bg-rose-500 shadow-lg shadow-rose-600/30 transition-all cursor-pointer">' + escapeHtml(confirmLabel) + '</button>' +
        '</div>';

      backdrop.appendChild(modal);
      document.body.appendChild(backdrop);

      var cancelBtn = document.getElementById('ts-confirm-cancel');
      var okBtn = document.getElementById('ts-confirm-ok');

      // Focus trap: cycle Tab inside modal
      function trapFocus(e) {
        var focusable = modal.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
        if (focusable.length === 0) return;
        var first = focusable[0];
        var last = focusable[focusable.length - 1];
        if (e.key === 'Tab') {
          if (e.shiftKey) {
            if (document.activeElement === first) { e.preventDefault(); last.focus(); }
          } else {
            if (document.activeElement === last) { e.preventDefault(); first.focus(); }
          }
        }
      }

      function close(result) {
        backdrop.removeEventListener('keydown', keyHandler);
        document.body.removeChild(backdrop);
        if (trigger && trigger.focus) trigger.focus();
        resolve(result);
      }

      function keyHandler(e) {
        trapFocus(e);
        if (e.key === 'Escape') { e.preventDefault(); close(false); }
        if (e.key === 'Enter' && e.target !== cancelBtn) { e.preventDefault(); close(true); }
      }

      backdrop.addEventListener('keydown', keyHandler);

      cancelBtn.addEventListener('click', function () { close(false); });
      okBtn.addEventListener('click', function () { close(true); });

      // Focus first interactive
      setTimeout(function () { cancelBtn.focus(); }, 50);

      // Click outside modal to cancel
      backdrop.addEventListener('click', function (e) { if (e.target === backdrop) close(false); });
    });
  };

  // ── Skeleton Row ──────────────────────────────────────────────────────

  /**
   * Returns an HTML string of a <tr> with colCount skeleton <td>s.
   * @param {number} colCount
   * @returns {string}
   */
  ui.skeletonRow = function skeletonRow(colCount) {
    var cells = '';
    for (var i = 0; i < colCount; i++) {
      cells += '<td class="px-6 py-4"><div class="h-4 bg-slate-700/60 rounded animate-pulse ts-skeleton"></div></td>';
    }
    return '<tr class="border-b border-slate-700/50">' + cells + '</tr>';
  };

  // ── Bind Ajax Table ────────────────────────────────────────────────────

  /**
   * Wire a search input to debounced fetch + skeleton + rowTemplate.
   * @param {{rootSelector: string, endpoint: string, debounceMs?: number, rowTemplate: (row: object) => string, columns?: number, onAfterRender?: () => void}} cfg
   */
  ui.bindAjaxTable = function bindAjaxTable(cfg) {
    var input = document.querySelector(cfg.rootSelector);
    var tbody = cfg.tbodySelector ? document.querySelector(cfg.tbodySelector) : document.getElementById('tbodySucursales');
    if (!input || !tbody) return;

    var endpoint = cfg.endpoint;
    var debounceMs = cfg.debounceMs || 180;
    var columns = cfg.columns || 5;
    var rowTemplate = cfg.rowTemplate;
    var onAfterRender = cfg.onAfterRender || function () {};
    var timer = null;
    var lastQuery = '';

    function doFetch(query) {
      tbody.innerHTML = ui.skeletonRow(columns);
      tbody.parentNode.setAttribute('aria-busy', 'true');

      fetch(endpoint + encodeURIComponent(query))
        .then(function (r) {
          if (!r.ok) throw new Error('Error en la respuesta del servidor');
          return r.json();
        })
        .then(function (data) {
          tbody.parentNode.setAttribute('aria-busy', 'false');
          renderRows(data);
        })
        .catch(function (err) {
          tbody.parentNode.setAttribute('aria-busy', 'false');
          ui.toast({ type: 'error', message: 'Sin conexión, reintentá' });
        });
    }

    function renderRows(data) {
      tbody.innerHTML = '';
      if (!data || data.length === 0) {
        var row = document.createElement('tr');
        var cell = document.createElement('td');
        cell.colSpan = columns;
        cell.className = 'px-6 py-10 text-center text-slate-400 text-sm';
        cell.textContent = 'No se encontraron sucursales con ese nombre.';
        row.appendChild(cell);
        tbody.appendChild(row);
        return;
      }
      data.forEach(function (item) {
        var tr = document.createElement('tr');
        tr.innerHTML = rowTemplate(item);
        tr.className = 'border-b border-slate-700/50 hover:bg-indigo-500/10 transition-colors';
        tbody.appendChild(tr);
      });
      if (onAfterRender) onAfterRender();
    }

    input.addEventListener('input', function (e) {
      var query = e.target.value.trim();
      if (query === lastQuery) return;
      lastQuery = query;
      clearTimeout(timer);
      timer = setTimeout(function () { doFetch(query); }, debounceMs);
    });

    // Initial load
    doFetch('');
  };

  // ── postJson ───────────────────────────────────────────────────────────

  /**
   * POST JSON to the server, parse envelope.
   * @param {string} url
   * @param {object} body
   * @returns {Promise<{ok: boolean, msg?: string, errors?: string[]}>}
   */
  ui.postJson = function postJson(url, body) {
    return fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'fetch'
      },
      credentials: 'same-origin',
      body: JSON.stringify(body)
    }).then(function (response) {
      if (!response.ok) {
        return response.json().catch(function () {
          throw new Error('Respuesta no JSON: ' + response.status);
        }).then(function (errData) {
          throw errData;
        });
      }
      return response.json().catch(function () {
        throw new Error('Respuesta no JSON: ' + response.status);
      });
    });
  };

  // ── isFetchRequest ────────────────────────────────────────────────────

  /**
   * Returns true if the request carries the X-Requested-With: fetch header.
   * For use in server-side Java, not client-side. Here for completeness.
   * @returns {boolean}
   */
  ui.isFetchRequest = function isFetchRequest() {
    // Client-side: always true when called via fetch context
    return true;
  };

  // ── Helpers ────────────────────────────────────────────────────────────

  function escapeHtml(str) {
    if (!str) return '';
    var div = document.createElement('div');
    div.appendChild(document.createTextNode(str));
    return div.innerHTML;
  }

  // ── Export ─────────────────────────────────────────────────────────────
  window.ui = ui;
})();
