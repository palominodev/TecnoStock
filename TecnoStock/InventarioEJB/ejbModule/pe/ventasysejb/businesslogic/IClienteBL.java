package pe.ventasysejb.businesslogic;

import java.util.List;
import pe.ventasysejb.entity.Cliente;

public interface IClienteBL {
    void registrarCliente(Cliente cliente);
    Cliente buscarporId(int id);
    List<Cliente> buscarTodos();
    List<Cliente> buscarporApellidoPaterno(String apellidoPaterno);
    void actualizarCliente(Cliente cliente);
    void eliminarLogico(int id);
    void eliminarFisico(int id);
}
