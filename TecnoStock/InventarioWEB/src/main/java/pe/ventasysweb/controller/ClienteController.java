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
import java.util.List;
import com.google.gson.Gson;

@WebServlet("/cliente")
public class ClienteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IClienteBL clienteBL = new ClienteBL();
    
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
        request.setAttribute("listaClientes", listaClientes);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/gestionClientes.jsp");
        dispatcher.forward(request, response);
    }

    private void buscarClientesTodos(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Cliente> listaClientes = clienteBL.buscarTodos();
        Gson gson = new Gson();
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
        clienteBL.eliminarFisico(idCliente);
        response.sendRedirect("cliente?opcion=gestionar");
    }
    
    private void buscarxApellidoPaterno(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String apellidoPaterno = request.getParameter("apellidoPaterno");
        List<Cliente> listaClientes = clienteBL.buscarporApellidoPaterno(apellidoPaterno);
        request.setAttribute("listaClientes", listaClientes);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/gestionClientes.jsp");
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
        }
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
}
