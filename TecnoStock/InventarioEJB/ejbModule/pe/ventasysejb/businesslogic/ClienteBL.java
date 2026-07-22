package pe.ventasysejb.businesslogic;

import java.util.List;
import pe.ventasysejb.dao.ClienteDAO;
import pe.ventasysejb.entity.Cliente;

public class ClienteBL implements IClienteBL {

    private ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    public void registrarCliente(Cliente cliente) {
        clienteDAO.registrar(cliente);
    }

    @Override
    public Cliente buscarporId(int id) {
        return clienteDAO.buscarporId(id);
    }

    @Override
    public List<Cliente> buscarTodos() {
        return clienteDAO.buscarTodos();
    }

    @Override
    public List<Cliente> buscarporApellidoPaterno(String apellidoPaterno) {
        return clienteDAO.buscarPorApellidoPaterno(apellidoPaterno);
    }

    @Override
    public void actualizarCliente(Cliente cliente) {
        clienteDAO.actualizar(cliente);
    }

    @Override
    public void eliminarLogico(int id) {
        clienteDAO.eliminarLogico(id);
    }

    @Override
    public void eliminarFisico(int id) {
        clienteDAO.eliminarFisico(id);
    }
}
