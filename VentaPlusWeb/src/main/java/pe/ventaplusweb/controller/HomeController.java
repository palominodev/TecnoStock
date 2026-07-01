package pe.ventaplusweb.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.ventaplusejb.bl.IUsuarioBL;
import pe.ventaplusejb.bl.UsuarioBL;
import pe.ventaplusejb.model.Usuario;
import pe.ventaplusweb.security.SessionManager;

import java.io.IOException;
import java.sql.SQLException;



@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	public HomeController() {
		super();
		
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String opcion = request.getParameter("opcion");
			System.out.println(opcion);
			switch (opcion) {
				case "cerrarSesion": {
					cerrarSesion(request, response);
					break;
				}
				default:
					break;
			}
		} catch (Exception e) {
			
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		System.out.println(opcion);
		switch (opcion) {
			case "validarUsuario":
				try {
					validarUsuario(request, response);
				} catch (SQLException | ServletException | IOException e) {
					e.printStackTrace();
				}
				break;
		}
	}

	private void validarUsuario(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		String pagina;
		String correo = request.getParameter("email");
		String contrasenha = request.getParameter("password");

		IUsuarioBL usuarioBL = new UsuarioBL();
		Usuario usuario = usuarioBL.validarUsuario(correo, contrasenha);
		System.out.println(correo);
		System.out.println(contrasenha);
		if (usuario !=null) {
			SessionManager.iniciarSesion(request, usuario);
			pagina = "/principal.jsp";
		} else {
			pagina = "/index.jsp";
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(pagina);
		dispatcher.forward(request, response);
	}
	
	private void cerrarSesion (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pagina = "/index.jsp";
		System.out.print("Cerrar Sesión");
		SessionManager.cerrarSesion(request);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(pagina);
		dispatcher.forward(request, response);
	}

}
