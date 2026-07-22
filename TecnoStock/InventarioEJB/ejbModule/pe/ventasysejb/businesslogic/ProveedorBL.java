package pe.ventasysejb.businesslogic;

import java.util.List;
import pe.ventasysejb.dao.ProveedorDAO;
import pe.ventasysejb.model.Proveedor;

public class ProveedorBL implements IProveedorBL {

    private ProveedorDAO proveedorDAO = new ProveedorDAO();

    @Override
    public void registrarProveedor(Proveedor proveedor) {
        proveedorDAO.save(proveedor);
    }

    @Override
    public Proveedor obtenerProveedorPorId(int id) {
        return proveedorDAO.load(id);
    }

    @Override
    public List<Proveedor> listarProveedores() {
        return proveedorDAO.listAll();
    }

    @Override
    public void actualizarProveedor(Proveedor proveedor) {
        proveedorDAO.update(proveedor);
    }

    @Override
    public void eliminarProveedor(int id) {
        proveedorDAO.removeLogic(id);
    }
}
