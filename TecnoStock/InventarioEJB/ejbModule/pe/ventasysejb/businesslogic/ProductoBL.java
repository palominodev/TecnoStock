package pe.ventasysejb.businesslogic;

import pe.ventasysejb.dao.ProductoDAO;
import pe.ventasysejb.entity.Producto;
public class ProductoBL implements IProductoBL {

    private ProductoDAO productoDAO = new ProductoDAO();

    @Override
    public void registrarProducto(Producto producto) {
        productoDAO.insertar(producto);
    }
}
