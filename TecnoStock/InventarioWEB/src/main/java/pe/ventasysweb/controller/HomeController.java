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
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVentaBL ventaBL = new VentaBL();

    private IClienteBL clienteBL = new ClienteBL();

    public HomeController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String opcion = request.getParameter("opcion");
        if (opcion == null) {
            opcion = "principal";
        }

        switch (opcion) {
            case "gestionarSucursales":
                response.sendRedirect(request.getContextPath() + "/SucursalController?accion=listar");
                break;
            case "gestionarClientes":
                response.sendRedirect(request.getContextPath() + "/cliente?opcion=gestionar");
                break;
            case "gestionarProveedores":
                response.sendRedirect(request.getContextPath() + "/proveedor?opcion=listar");
                break;
            case "gestionarVentas": {
                List<Cliente> listaClientes = clienteBL.buscarTodos();
                List<Venta> listaVentas = ventaBL.listarVentasConNamedQueryJPQL();
                request.setAttribute("listaClientes", listaClientes);
                request.setAttribute("listaVentas", listaVentas);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/gestionVentas.jsp");
                dispatcher.forward(request, response);
                break;
            }
            case "principal":
            default:
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/principal.jsp");
                dispatcher.forward(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
