package pe.ventasysweb.security;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {
    "/gestionSucursales.jsp",
    "/nuevaSucursal.jsp",
    "/actualizarSucursal.jsp",
    "/nuevoProducto.jsp",
    "/SucursalController",
    "/ProductoController",
    "/cliente",
    "/proveedor",
    "/gestionClientesAjax.jsp",
    "/nuevoCliente.jsp",
    "/editarCliente.jsp",
    "/gestionProveedores.jsp",
    "/gestionVentas.jsp",
    "/venta"
})
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);

        if (!SessionManager.existeSesionActiva(httpRequest)) {
            String uri = httpRequest.getRequestURI();
            boolean isLoginJsp = uri.endsWith("login.jsp");
            boolean isLoginController = uri.contains("UsuarioController");

            if (!isLoginJsp && !isLoginController) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
