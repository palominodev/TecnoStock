package pe.ventasysejb.businesslogic;

import pe.ventasysejb.entity.Usuario;
public interface IUsuarioBL {
    Usuario validarUsuario(String correo, String contrasenha);
}
