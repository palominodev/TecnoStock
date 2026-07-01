package pe.ventaplusweb.security;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//Paginas a las  que quiero que se les aplique el filter
@WebFilter(urlPatterns =
	{
			"/principal.jsp",
			"/gestionClientes.jsp",
			"/actualizarCliente.jsp",
			"/nuevoCliente.jsp",
			"/HomeController",
			"/CategoriaController",
	}
)
public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		String uri = httpRequest.getRequestURI();
		String opcion = httpRequest.getParameter("opcion");

		boolean esLogin = uri.endsWith("/HomeController") && "validarUsuario".equals(opcion);
		boolean tieneSesion = SessionManager.existeSesionActiva(httpRequest);

		if (esLogin || tieneSesion) {
			chain.doFilter(request, response);
		} else {
			httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
		}
	}
}