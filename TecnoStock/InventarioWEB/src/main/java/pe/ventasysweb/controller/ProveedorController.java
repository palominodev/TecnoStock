package pe.ventasysweb.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.ventasysejb.businesslogic.IProveedorBL;
import pe.ventasysejb.businesslogic.ProveedorBL;
import pe.ventasysejb.model.Proveedor;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet("/proveedor")
public class ProveedorController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProveedorBL proveedorBL = new ProveedorBL();
    private Gson gson = new Gson();

    // ── Estado value convention ───────────────────────────────────────────
    // Proveedor uses "Activo" / "Inactivo" (capitalized words).
    // Same pattern as Sucursal ("activo"/"inactivo"). Verified from
    // ProveedorController.guardar() default: estado = "Activo" (line 90).
    // Cliente uses "A"/"I" — per-entity convention, see ADR-3 in design.
    private static final String ESTADO_ACTIVO = "Activo";
    private static final String ESTADO_INACTIVO = "Inactivo";

    public ProveedorController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String opcion = request.getParameter("opcion");
        if (opcion == null) {
            opcion = "listar";
        }
        switch (opcion) {
            case "nuevo":
                nuevo(request, response);
                break;
            case "editar":
                editar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "listar":
            default:
                listar(request, response);
                break;
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Proveedor> lista = proveedorBL.listarProveedores();
        request.setAttribute("listaProveedores", lista);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/gestionProveedores.jsp");
        dispatcher.forward(request, response);
    }

    private void nuevo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/nuevoProveedor.jsp");
        dispatcher.forward(request, response);
    }

    private void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Proveedor proveedor = proveedorBL.obtenerProveedorPorId(id);
        request.setAttribute("proveedor", proveedor);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/editarProveedor.jsp");
        dispatcher.forward(request, response);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        proveedorBL.eliminarProveedor(id);
        response.sendRedirect("proveedor?opcion=listar");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String opcion = request.getParameter("opcion");
        if ("guardar".equals(opcion)) {
            guardar(request, response);
        }
    }

    private void guardar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String ruc = request.getParameter("ruc");
        String razonSocial = request.getParameter("razonSocial");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String nombreContacto = request.getParameter("nombreContacto");
        String estado = request.getParameter("estado");
        if (estado == null) {
            estado = "Activo";
        }

        Proveedor p = new Proveedor();
        p.setRuc(ruc);
        p.setRazonSocial(razonSocial);
        p.setDireccion(direccion);
        p.setTelefono(telefono);
        p.setNombreContacto(nombreContacto);
        p.setEstado(estado);

        if (idStr != null && !idStr.trim().isEmpty()) {
            p.setId(Integer.parseInt(idStr));
            proveedorBL.actualizarProveedor(p);
        } else {
            proveedorBL.registrarProveedor(p);
        }

        response.sendRedirect("proveedor?opcion=listar");
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
