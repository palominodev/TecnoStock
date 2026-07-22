package pe.ventasysweb.controller;

import pe.ventasysejb.businesslogic.ICategoriaBL;
import pe.ventasysejb.businesslogic.IProductoBL;
import pe.ventasysejb.entity.Categoria;
import pe.ventasysejb.entity.Producto;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.ventasysejb.businesslogic.ProductoBL;
import pe.ventasysejb.businesslogic.CategoriaBL;

@WebServlet(name = "ProductoController", urlPatterns = {"/ProductoController"})
public class ProductoController extends HttpServlet {

    private IProductoBL productoBL = new ProductoBL();

    private ICategoriaBL categoriaBL = new CategoriaBL();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "nuevo";
        }

        switch (accion) {
            case "nuevo":
                nuevo(request, response);
                break;
            case "registrar":
                registrar(request, response);
                break;
            default:
                nuevo(request, response);
                break;
        }
    }

    private void nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Categoria> categorias = categoriaBL.listarCategorias();
        request.setAttribute("listaCategorias", categorias);
        request.getRequestDispatcher("nuevoProducto.jsp").forward(request, response);
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");
        String idCategoriaStr = request.getParameter("idCategoria");

        try {
            BigDecimal precio = new BigDecimal(precioStr);
            int stock = Integer.parseInt(stockStr);
            int idCategoria = Integer.parseInt(idCategoriaStr);

            Categoria cat = categoriaBL.obtenerCategoriaPorId(idCategoria);
            if (cat != null) {
                Producto nuevo = new Producto(nombre, precio, stock, cat);
                productoBL.registrarProducto(nuevo);
                
                request.setAttribute("mensajeExito", "Producto registrado exitosamente.");
            } else {
                request.setAttribute("mensajeError", "La categoría seleccionada no existe.");
            }
        } catch (Exception e) {
            request.setAttribute("mensajeError", "Error en los datos ingresados: " + e.getMessage());
        }

        List<Categoria> categorias = categoriaBL.listarCategorias();
        request.setAttribute("listaCategorias", categorias);
        request.getRequestDispatcher("nuevoProducto.jsp").forward(request, response);
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
}
