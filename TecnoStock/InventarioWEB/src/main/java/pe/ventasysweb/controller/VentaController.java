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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
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
