package pe.ventasysejb.businesslogic;

import java.util.List;
import pe.ventasysejb.entity.Venta;

public interface IVentaBL {
    void registrar(Venta venta);
    void actualizar(Venta venta);
    void eliminar(int id);
    Venta buscar(int id);
    List<Venta> listarVentasConNamedQueryJPQL();
    List<Venta> listarVentasSinNamedQuery();
    List<Venta> listarVentasConNamedQuerySQL();
    List<Venta> buscarxCliente(int id);
}
