package pe.ventasysejb.businesslogic;

import java.util.List;
import pe.ventasysejb.model.Proveedor;

public interface IProveedorBL {
    void registrarProveedor(Proveedor proveedor);
    Proveedor obtenerProveedorPorId(int id);
    List<Proveedor> listarProveedores();
    void actualizarProveedor(Proveedor proveedor);
    void eliminarProveedor(int id);
}
