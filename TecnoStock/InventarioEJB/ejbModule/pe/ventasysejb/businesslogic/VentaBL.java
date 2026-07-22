package pe.ventasysejb.businesslogic;

import java.util.List;
import pe.ventasysejb.dao.VentaDAO;
import pe.ventasysejb.entity.Venta;

public class VentaBL implements IVentaBL {

    private VentaDAO ventaDAO = new VentaDAO();

    @Override
    public void registrar(Venta venta) {
        ventaDAO.insertar(venta);
    }

    @Override
    public void actualizar(Venta venta) {
        ventaDAO.actualizar(venta);
    }

    @Override
    public void eliminar(int id) {
        ventaDAO.eliminar(id);
    }

    @Override
    public Venta buscar(int id) {
        return ventaDAO.buscar(id);
    }

    @Override
    public List<Venta> listarVentasConNamedQueryJPQL() {
        return ventaDAO.listarVentasConNamedQueryJPQL();
    }

    @Override
    public List<Venta> listarVentasSinNamedQuery() {
        return ventaDAO.listarVentasSinNamedQuery();
    }

    @Override
    public List<Venta> listarVentasConNamedQuerySQL() {
        return ventaDAO.listarVentasConNamedQuerySQL();
    }

    @Override
    public List<Venta> buscarxCliente(int id) {
        return ventaDAO.buscarxCliente(id);
    }
}
