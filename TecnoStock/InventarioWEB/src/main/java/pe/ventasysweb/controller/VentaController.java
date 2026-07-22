package pe.ventasysweb.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.ventasysejb.businesslogic.IClienteBL;
import pe.ventasysejb.businesslogic.IVentaBL;
import pe.ventasysejb.businesslogic.ClienteBL;
import pe.ventasysejb.businesslogic.VentaBL;
import pe.ventasysejb.entity.Cliente;
import pe.ventasysejb.entity.Venta;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

@WebServlet("/venta")
public class VentaController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVentaBL ventaBL = new VentaBL();

    private IClienteBL clienteBL = new ClienteBL();

    private Gson gson = new Gson();

    public VentaController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String opcion = request.getParameter("opcion");
        if (opcion == null) {
            opcion = "listar";
        }

        switch (opcion) {
            case "buscarxCliente":
                buscarxCliente(request, response);
                break;
            case "listarVentasJson":
                listarVentasJson(request, response);
                break;
            default:
                listar(request, response);
                break;
        }
    }

    private void buscarxCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idClienteStr = request.getParameter("idCliente");
        if (idClienteStr != null && !idClienteStr.trim().isEmpty()) {
            int idCliente = Integer.parseInt(idClienteStr);
            List<Venta> listaVentas = ventaBL.buscarxCliente(idCliente);
            List<Cliente> listaClientes = clienteBL.buscarTodos();
            request.setAttribute("listaVentas", listaVentas);
            request.setAttribute("listaClientes", listaClientes);
        } else {
            listar(request, response);
            return;
        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/gestionVentas.jsp");
        dispatcher.forward(request, response);
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Cliente> listaClientes = clienteBL.buscarTodos();
        List<Venta> listaVentas = ventaBL.listarVentasConNamedQueryJPQL();
        request.setAttribute("listaClientes", listaClientes);
        request.setAttribute("listaVentas", listaVentas);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/gestionVentas.jsp");
        dispatcher.forward(request, response);
    }

    private void listarVentasJson(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Venta> lista = ventaBL.listarVentasConNamedQueryJPQL();
        List<Map<String, Object>> jsonList = new ArrayList<>();
        for (Venta v : lista) {
            Map<String, Object> map = new LinkedHashMap<>();
            map.put("id", v.getId());
            map.put("fecha", v.getFecha() != null ? v.getFecha().toString() : null);
            map.put("total", v.getTotal());
            Cliente c = v.getCliente();
            if (c != null) {
                map.put("clienteId", c.getId());
                map.put("clienteNombre", c.getNombre() + " " + c.getApellidoPaterno() + " " + c.getApellidoMaterno());
            } else {
                map.put("clienteId", null);
                map.put("clienteNombre", "");
            }
            jsonList.add(map);
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().print(gson.toJson(jsonList));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String opcion = request.getParameter("opcion");
        if (opcion == null) {
            doGet(request, response);
            return;
        }
        switch (opcion) {
            case "registrar":
                registrar(request, response);
                break;
            case "editar":
                editar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idClienteStr = request.getParameter("idCliente");
        String fechaStr = request.getParameter("fecha");
        String totalStr = request.getParameter("total");

        if (isFetchRequest(request)) {
            try {
                Venta venta = new Venta();
                if (idClienteStr != null && !idClienteStr.trim().isEmpty()) {
                    Cliente c = clienteBL.buscarporId(Integer.parseInt(idClienteStr));
                    venta.setCliente(c);
                }
                if (fechaStr != null && !fechaStr.trim().isEmpty()) {
                    venta.setFecha(java.sql.Date.valueOf(fechaStr));
                }
                if (totalStr != null && !totalStr.trim().isEmpty()) {
                    venta.setTotal(Double.parseDouble(totalStr));
                }
                ventaBL.registrar(venta);
                writeJson(response, true, "Venta registrada", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }

        // Legacy flow
        Venta venta = new Venta();
        if (idClienteStr != null && !idClienteStr.trim().isEmpty()) {
            Cliente c = clienteBL.buscarporId(Integer.parseInt(idClienteStr));
            venta.setCliente(c);
        }
        if (fechaStr != null && !fechaStr.trim().isEmpty()) {
            venta.setFecha(java.sql.Date.valueOf(fechaStr));
        }
        if (totalStr != null && !totalStr.trim().isEmpty()) {
            venta.setTotal(Double.parseDouble(totalStr));
        }
        ventaBL.registrar(venta);
        response.sendRedirect("venta?opcion=listar");
    }

    private void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String idClienteStr = request.getParameter("idCliente");
        String fechaStr = request.getParameter("fecha");
        String totalStr = request.getParameter("total");

        if (isFetchRequest(request)) {
            try {
                Venta venta = ventaBL.buscar(Integer.parseInt(idStr));
                if (venta == null) {
                    List<String> errors = new ArrayList<>();
                    errors.add("Venta no encontrada");
                    writeJson(response, false, null, errors);
                    return;
                }
                if (idClienteStr != null && !idClienteStr.trim().isEmpty()) {
                    Cliente c = clienteBL.buscarporId(Integer.parseInt(idClienteStr));
                    venta.setCliente(c);
                }
                if (fechaStr != null && !fechaStr.trim().isEmpty()) {
                    venta.setFecha(java.sql.Date.valueOf(fechaStr));
                }
                if (totalStr != null && !totalStr.trim().isEmpty()) {
                    venta.setTotal(Double.parseDouble(totalStr));
                }
                ventaBL.actualizar(venta);
                writeJson(response, true, "Venta actualizada", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }

        // Legacy flow
        Venta venta = ventaBL.buscar(Integer.parseInt(idStr));
        if (venta != null) {
            if (idClienteStr != null && !idClienteStr.trim().isEmpty()) {
                Cliente c = clienteBL.buscarporId(Integer.parseInt(idClienteStr));
                venta.setCliente(c);
            }
            if (fechaStr != null && !fechaStr.trim().isEmpty()) {
                venta.setFecha(java.sql.Date.valueOf(fechaStr));
            }
            if (totalStr != null && !totalStr.trim().isEmpty()) {
                venta.setTotal(Double.parseDouble(totalStr));
            }
            ventaBL.actualizar(venta);
        }
        response.sendRedirect("venta?opcion=listar");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        if (isFetchRequest(request)) {
            try {
                ventaBL.eliminar(id);
                writeJson(response, true, "Venta eliminada", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }

        // Legacy flow — hard delete (Venta has no estado field)
        ventaBL.eliminar(id);
        response.sendRedirect("venta?opcion=listar");
    }

    // ── JSON helpers ─────────────────────────────────────────────────────

    private boolean isFetchRequest(HttpServletRequest req) {
        String header = req.getHeader("X-Requested-With");
        return "fetch".equalsIgnoreCase(header);
    }

    private void writeJson(HttpServletResponse resp, boolean ok, String msg, List<String> errors)
            throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        Map<String, Object> env = new LinkedHashMap<>();
        env.put("ok", ok);
        if (msg != null) {
            env.put("msg", msg);
        }
        if (errors != null) {
            env.put("errors", errors);
        }
        resp.getWriter().print(gson.toJson(env));
    }
}
