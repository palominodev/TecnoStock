package pe.ventasysweb.controller;

import pe.ventasysejb.businesslogic.IUsuarioBL;
import pe.ventasysejb.entity.Usuario;
import java.io.IOException;
import pe.ventasysejb.businesslogic.UsuarioBL;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.ventasysweb.security.SessionManager;

@WebServlet(name = "UsuarioController", urlPatterns = {"/UsuarioController"})
public class UsuarioController extends HttpServlet {

    private IUsuarioBL usuarioBL = new UsuarioBL();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "login";
        }

        switch (accion) {
            case "login":
                login(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                break;
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasenha = request.getParameter("contrasenha");

        if (correo == null || correo.trim().isEmpty() || contrasenha == null || contrasenha.isEmpty()) {
            request.setAttribute("mensajeError", "El correo y la contraseña son requeridos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Usuario usuario = usuarioBL.validarUsuario(correo.trim(), contrasenha);
        if (usuario != null) {
            SessionManager.iniciarSesion(request, usuario);
            response.sendRedirect(request.getContextPath() + "/home?opcion=principal");
        } else {
            request.setAttribute("mensajeError", "El correo o la contraseña son incorrectos, o el usuario está inactivo.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SessionManager.cerrarSesion(request);
        response.sendRedirect(request.getContextPath() + "/login.jsp");
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
