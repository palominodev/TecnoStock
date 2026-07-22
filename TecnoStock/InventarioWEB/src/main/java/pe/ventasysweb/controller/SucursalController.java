package pe.ventasysweb.controller;

import pe.ventasysejb.businesslogic.ISucursalBL;
import pe.ventasysejb.entity.Sucursal;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import pe.ventasysejb.businesslogic.SucursalBL;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SucursalController", urlPatterns = {"/SucursalController"})
public class SucursalController extends HttpServlet {

    private ISucursalBL sucursalBL = new SucursalBL();
    private Gson gson = new Gson();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listar(request, response);
                break;
            case "buscar":
                buscar(request, response);
                break;
            case "registrar":
                registrar(request, response);
                break;
            case "editar":
                editar(request, response);
                break;
            case "actualizar":
                actualizar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                listar(request, response);
                break;
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Sucursal> lista = sucursalBL.listarSucursales();
        request.setAttribute("listaSucursales", lista);
        request.getRequestDispatcher("gestionSucursales.jsp").forward(request, response);
    }

    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        List<Sucursal> lista = sucursalBL.buscarSucursalesPorNombre(nombre);
        
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(toJson(lista));
        }
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isFetchRequest(request)) {
            try {
                String nombre = request.getParameter("nombre");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String estado = request.getParameter("estado");

                Sucursal nueva = new Sucursal(nombre, direccion, telefono, estado);
                sucursalBL.registrarSucursal(nueva);

                writeJson(response, true, "Sucursal registrada", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }
        // Legacy flow
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String estado = request.getParameter("estado");

        Sucursal nueva = new Sucursal(nombre, direccion, telefono, estado);
        sucursalBL.registrarSucursal(nueva);

        response.sendRedirect("SucursalController?accion=listar");
    }

    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Sucursal sucursal = sucursalBL.obtenerSucursalPorId(id);
        request.setAttribute("sucursal", sucursal);
        request.getRequestDispatcher("actualizarSucursal.jsp").forward(request, response);
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isFetchRequest(request)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String nombre = request.getParameter("nombre");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String estado = request.getParameter("estado");

                Sucursal sucursal = sucursalBL.obtenerSucursalPorId(id);
                if (sucursal != null) {
                    sucursal.setNombre(nombre);
                    sucursal.setDireccion(direccion);
                    sucursal.setTelefono(telefono);
                    sucursal.setEstado(estado);
                    sucursalBL.actualizarSucursal(sucursal);
                }

                writeJson(response, true, "Sucursal actualizada", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }
        // Legacy flow
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String estado = request.getParameter("estado");

        Sucursal sucursal = sucursalBL.obtenerSucursalPorId(id);
        if (sucursal != null) {
            sucursal.setNombre(nombre);
            sucursal.setDireccion(direccion);
            sucursal.setTelefono(telefono);
            sucursal.setEstado(estado);
            sucursalBL.actualizarSucursal(sucursal);
        }

        response.sendRedirect("SucursalController?accion=listar");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isFetchRequest(request)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                // Hard delete in slice 1a (soft delete comes in slice 1b)
                sucursalBL.eliminarSucursal(id);

                writeJson(response, true, "Sucursal eliminada", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }
        // Legacy flow
        int id = Integer.parseInt(request.getParameter("id"));
        sucursalBL.eliminarSucursal(id);
        response.sendRedirect("SucursalController?accion=listar");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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

    // ── Legacy hand-rolled JSON for buscar (preserved, ADR-2) ────────────

    private String toJson(List<Sucursal> lista) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < lista.size(); i++) {
            Sucursal s = lista.get(i);
            sb.append("{");
            sb.append("\"idSucursal\":").append(s.getIdSucursal()).append(",");
            sb.append("\"nombre\":\"").append(escapeJson(s.getNombre())).append("\",");
            sb.append("\"direccion\":\"").append(escapeJson(s.getDireccion())).append("\",");
            sb.append("\"telefono\":\"").append(escapeJson(s.getTelefono())).append("\",");
            sb.append("\"estado\":\"").append(escapeJson(s.getEstado())).append("\"");
            sb.append("}");
            if (i < lista.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString();
    }

    private String escapeJson(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
