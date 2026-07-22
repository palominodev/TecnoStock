package pe.ventasysejb.businesslogic;

import pe.ventasysejb.entity.Sucursal;
import java.util.List;
public interface ISucursalBL {
    void registrarSucursal(Sucursal sucursal);
    void actualizarSucursal(Sucursal sucursal);
    void eliminarSucursal(int id);
    Sucursal obtenerSucursalPorId(int id);
    List<Sucursal> listarSucursales();
    List<Sucursal> buscarSucursalesPorNombre(String nombre);
}
