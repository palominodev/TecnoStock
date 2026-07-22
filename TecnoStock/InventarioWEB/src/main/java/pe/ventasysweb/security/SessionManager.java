package pe.ventasysweb.security;

import pe.ventasysejb.entity.Usuario;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionManager {

    private static final String USER_SESSION_KEY = "usuarioLogueado";

    public static void iniciarSesion(HttpServletRequest request, Usuario usuario) {
        HttpSession session = request.getSession(true);
        session.setAttribute(USER_SESSION_KEY, usuario);
        session.setMaxInactiveInterval(1800);
    }

    public static boolean existeSesionActiva(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute(USER_SESSION_KEY) != null;
    }

    public static Usuario obtenerUsuario(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Usuario) session.getAttribute(USER_SESSION_KEY);
        }
        return null;
    }

    public static void cerrarSesion(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(USER_SESSION_KEY);
            session.invalidate();
        }
    }
}
