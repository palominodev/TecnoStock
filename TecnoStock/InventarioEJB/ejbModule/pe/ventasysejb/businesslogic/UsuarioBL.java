package pe.ventasysejb.businesslogic;

import pe.ventasysejb.dao.UsuarioDAO;
import pe.ventasysejb.entity.Usuario;
public class UsuarioBL implements IUsuarioBL {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    public Usuario validarUsuario(String correo, String contrasenha) {
        if (correo == null || contrasenha == null) {
            return null;
        }
        return usuarioDAO.obtenerUsuarioLogin(correo.trim(), contrasenha);
    }
}
