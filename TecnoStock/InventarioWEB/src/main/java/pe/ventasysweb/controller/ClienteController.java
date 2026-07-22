package pe.ventasysweb.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.ventasysejb.businesslogic.IClienteBL;
import pe.ventasysejb.businesslogic.ClienteBL;
import pe.ventasysejb.entity.Cliente;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.google.gson.Gson;

@WebServlet("/cliente")
public class ClienteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IClienteBL clienteBL = new ClienteBL();
    private Gson gson = new Gson();
    
    public ClienteController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String opcion = request.getParameter("opcion");
        if (opcion == null) {
            opcion = "gestionar";
        }
        switch (opcion) {
            case "buscarxApellidoPaterno":
                buscarxApellidoPaterno(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "editar":
                editar(request, response);
                break;
            case "reactivar":
                reactivar(request, response);
                break;
            case "buscarClientesTodos":
                buscarClientesTodos(request, response);
                break;
            case "gestionar":
            default:
                gestionar(request, response);
                break;
        }
    }

    private void gestionar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Cliente> listaClientes = clienteBL.buscarTodos();
        String inactivos = request.getParameter("inactivos");
        if (!"true".equalsIgnoreCase(inactivos)) {
            listaClientes = listaClientes.stream()
                .filter(c -> "A".equalsIgnoreCase(c.getEstado()))
                .collect(Collectors.toList());
        }
        request.setAttribute("listaClientes", listaClientes);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/gestionClientesAjax.jsp");
        dispatcher.forward(request, response);
    }

    private void buscarClientesTodos(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Cliente> listaClientes = clienteBL.buscarTodos();
        String inactivos = request.getParameter("inactivos");
        if (!"true".equalsIgnoreCase(inactivos)) {
            listaClientes = listaClientes.stream()
                .filter(c -> "A".equalsIgnoreCase(c.getEstado()))
                .collect(Collectors.toList());
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().print(gson.toJson(listaClientes));
    }
    
    private void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCliente = Integer.parseInt(request.getParameter("id"));
        Cliente cliente = clienteBL.buscarporId(idCliente);
        request.setAttribute("cliente", cliente);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/editarCliente.jsp");
        dispatcher.forward(request, response);
    }
    
    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCliente = Integer.parseInt(request.getParameter("id"));
        if (isFetchRequest(request)) {
            try {
                clienteBL.eliminarLogico(idCliente);
                writeJson(response, true, "Cliente desactivado", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }
        // Legacy flow
        clienteBL.eliminarLogico(idCliente);
        response.sendRedirect("cliente?opcion=gestionar");
    }
    
    private void buscarxApellidoPaterno(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String apellidoPaterno = request.getParameter("apellidoPaterno");
        List<Cliente> listaClientes = clienteBL.buscarporApellidoPaterno(apellidoPaterno);
        String inactivos = request.getParameter("inactivos");
        if (!"true".equalsIgnoreCase(inactivos)) {
            listaClientes = listaClientes.stream()
                .filter(c -> "A".equalsIgnoreCase(c.getEstado()))
                .collect(Collectors.toList());
        }
        request.setAttribute("listaClientes", listaClientes);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/gestionClientesAjax.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String opcion = request.getParameter("opcion");
        switch (opcion) {
            case "nuevo":
                nuevo(request, response);
                break;
            case "registrar":
                registrar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
        }
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (isFetchRequest(request)) {
            try {
                String idStr = request.getParameter("id");
                String nombre = request.getParameter("nombres");
                String apellidoPaterno = request.getParameter("apellidoPaterno");
                String apellidoMaterno = request.getParameter("apellidoMaterno");
                String dni = request.getParameter("dni");
                String direccion = request.getParameter("direccion");
                String estado = "A";

                Cliente cliente = new Cliente();
                cliente.setApellidoMaterno(apellidoMaterno);
                cliente.setApellidoPaterno(apellidoPaterno);
                cliente.setDireccion(direccion);
                cliente.setDni(dni);
                cliente.setEstado(estado);
                cliente.setNombre(nombre);

                if (idStr != null && !idStr.trim().isEmpty()) {
                    cliente.setId(Integer.parseInt(idStr));
                    clienteBL.actualizarCliente(cliente);
                } else {
                    clienteBL.registrarCliente(cliente);
                }

                writeJson(response, true, "Cliente guardado", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }
        // Legacy flow
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombres");
        String apellidoPaterno = request.getParameter("apellidoPaterno");
        String apellidoMaterno = request.getParameter("apellidoMaterno");
        String dni = request.getParameter("dni");
        String direccion = request.getParameter("direccion");
        String estado = "A";

        Cliente cliente = new Cliente();
        cliente.setApellidoMaterno(apellidoMaterno);
        cliente.setApellidoPaterno(apellidoPaterno);
        cliente.setDireccion(direccion);
        cliente.setDni(dni);
        cliente.setEstado(estado);
        cliente.setNombre(nombre);

        if (idStr != null && !idStr.trim().isEmpty()) {
            cliente.setId(Integer.parseInt(idStr));
            clienteBL.actualizarCliente(cliente);
        } else {
            clienteBL.registrarCliente(cliente);
        }
        
        response.sendRedirect("cliente?opcion=gestionar");
    }
    
    private void nuevo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/nuevoCliente.jsp");
        dispatcher.forward(request, response);
    }

    private void reactivar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCliente = Integer.parseInt(request.getParameter("id"));
        if (isFetchRequest(request)) {
            try {
                Cliente cliente = clienteBL.buscarporId(idCliente);
                if (cliente != null) {
                    cliente.setEstado("A");
                    clienteBL.actualizarCliente(cliente);
                }
                writeJson(response, true, "Cliente reactivado", null);
            } catch (Exception e) {
                List<String> errors = new ArrayList<>();
                errors.add("Error: " + e.getMessage());
                writeJson(response, false, null, errors);
            }
            return;
        }
        // Legacy flow
        Cliente cliente = clienteBL.buscarporId(idCliente);
        if (cliente != null) {
            cliente.setEstado("A");
            clienteBL.actualizarCliente(cliente);
        }
        response.sendRedirect("cliente?opcion=gestionar");
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
