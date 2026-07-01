package pe.ventaplusweb.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import pe.ventaplusejb.bl.CategoriaBL;
import pe.ventaplusejb.bl.ICategoriaBL;
import pe.ventaplusejb.entity.Categoria;


@WebServlet("/CategoriaController")
public class CategoriaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String JSP_LISTAR = "gestionCategorias.jsp";
	private static final String JSP_NUEVO = "nuevaCategoria.jsp";
	private static final String JSP_ACTUALIZAR = "actualizarCategoria.jsp";
	private static final String REDIRECT_LISTAR = "CategoriaController?opcion=listar";

	
	public CategoriaController() {
		super();
	}

	
	private boolean sesionInvalida(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("usuarioSesion") == null) {
			response.sendRedirect("index.jsp");
			return true;
		}
		return false;
	}

	private void forwardError(HttpServletRequest request, HttpServletResponse response, String jsp, String message)
			throws ServletException, IOException {
		request.setAttribute("error", message);
		RequestDispatcher dispatcher = request.getRequestDispatcher(jsp);
		dispatcher.forward(request, response);
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (sesionInvalida(request, response)) {
			return;
		}
		String opcion = request.getParameter("opcion");
		if (opcion == null) {
			opcion = "listar";
		}
		try {
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
				case "buscar":
					buscar(request, response);
					break;
				case "obtener":
					obtener(request, response);
					break;
				case "listar":
				default:
					listar(request, response);
					break;
			}
		} catch (NumberFormatException e) {
			forwardError(request, response, JSP_LISTAR, "Identificador inválido.");
		} catch (IllegalArgumentException e) {
			forwardError(request, response, JSP_LISTAR, e.getMessage());
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (sesionInvalida(request, response)) {
			return;
		}
		String opcion = request.getParameter("opcion");
		try {
			switch (opcion) {
				case "registrar":
					registrar(request, response);
					break;
				case "actualizar":
					actualizar(request, response);
					break;
				default:
					response.sendRedirect(REDIRECT_LISTAR);
					break;
			}
		} catch (NumberFormatException e) {
			forwardError(request, response, JSP_ACTUALIZAR, "Identificador inválido.");
		} catch (IllegalArgumentException e) {
			forwardError(request, response, JSP_ACTUALIZAR, e.getMessage());
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}

	protected void listar(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ICategoriaBL categoriaBL = new CategoriaBL();
		List<Categoria> listaCategorias = categoriaBL.listarCategorias();
		request.setAttribute("listaCategorias", listaCategorias);
		RequestDispatcher dispatcher = request.getRequestDispatcher(JSP_LISTAR);
		dispatcher.forward(request, response);
	}

	protected void nuevo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("categoria", null);
		RequestDispatcher dispatcher = request.getRequestDispatcher(JSP_NUEVO);
		dispatcher.forward(request, response);
	}

	protected void editar(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Integer id = Integer.parseInt(request.getParameter("id"));
		ICategoriaBL categoriaBL = new CategoriaBL();
		Categoria categoria = categoriaBL.obtenerCategoriaPorId(id);
		request.setAttribute("categoria", categoria);
		RequestDispatcher dispatcher = request.getRequestDispatcher(JSP_ACTUALIZAR);
		dispatcher.forward(request, response);
	}

	protected void eliminar(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Integer id = Integer.parseInt(request.getParameter("id"));
		ICategoriaBL categoriaBL = new CategoriaBL();
		categoriaBL.eliminarCategoria(id);
		response.sendRedirect(REDIRECT_LISTAR);
	}

	protected void buscar(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String nombre = request.getParameter("nombre");
		ICategoriaBL categoriaBL = new CategoriaBL();
		List<Categoria> listaCategorias = categoriaBL.buscarCategoriaPorNombre(nombre);
		request.setAttribute("listaCategorias", listaCategorias);
		RequestDispatcher dispatcher = request.getRequestDispatcher(JSP_LISTAR);
		dispatcher.forward(request, response);
	}

	protected void obtener(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		Integer id = Integer.parseInt(request.getParameter("id"));
		ICategoriaBL categoriaBL = new CategoriaBL();
		Categoria categoria = categoriaBL.obtenerCategoriaPorId(id);
		request.setAttribute("categoria", categoria);
		RequestDispatcher dispatcher = request.getRequestDispatcher(JSP_ACTUALIZAR);
		dispatcher.forward(request, response);
	}

	protected void registrar(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String nombre = request.getParameter("nombre");
		String descripcion = request.getParameter("descripcion");
		String estado = request.getParameter("estado");
		if (estado == null || estado.isBlank()) {
			estado = "A";
		}
		Categoria categoria = new Categoria();
		categoria.setNombre(nombre);
		categoria.setDescripcion(descripcion);
		categoria.setEstado(estado);
		ICategoriaBL categoriaBL = new CategoriaBL();
		categoriaBL.registrarCategoria(categoria);
		response.sendRedirect(REDIRECT_LISTAR);
	}

	protected void actualizar(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Integer id = Integer.parseInt(request.getParameter("id"));
		String nombre = request.getParameter("nombre");
		String descripcion = request.getParameter("descripcion");
		String estado = request.getParameter("estado");
		Categoria categoria = new Categoria();
		categoria.setId(id);
		categoria.setNombre(nombre);
		categoria.setDescripcion(descripcion);
		categoria.setEstado(estado);
		ICategoriaBL categoriaBL = new CategoriaBL();
		categoriaBL.actualizarCategoria(categoria);
		response.sendRedirect(REDIRECT_LISTAR);
	}
}
