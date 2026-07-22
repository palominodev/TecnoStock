package pe.ventasysejb.businesslogic;

import pe.ventasysejb.dao.SucursalDAO;
import pe.ventasysejb.entity.Sucursal;
import java.util.List;
public class SucursalBL implements ISucursalBL {

    private SucursalDAO sucursalDAO = new SucursalDAO();

    @Override
    public void registrarSucursal(Sucursal sucursal) {
        sucursalDAO.insertar(sucursal);
    }

    @Override
    public void actualizarSucursal(Sucursal sucursal) {
        sucursalDAO.actualizar(sucursal);
    }

    @Override
    public void eliminarSucursal(int id) {
        sucursalDAO.eliminar(id);
    }

    @Override
    public Sucursal obtenerSucursalPorId(int id) {
        return sucursalDAO.obtenerPorId(id);
    }

    @Override
    public List<Sucursal> listarSucursales() {
        return sucursalDAO.listarTodo();
    }

    @Override
    public List<Sucursal> buscarSucursalesPorNombre(String nombre) {
        return sucursalDAO.buscarPorNombre(nombre);
    }
}
