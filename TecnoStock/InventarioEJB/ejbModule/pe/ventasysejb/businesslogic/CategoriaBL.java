package pe.ventasysejb.businesslogic;

import pe.ventasysejb.dao.CategoriaDAO;
import pe.ventasysejb.entity.Categoria;
import java.util.List;
public class CategoriaBL implements ICategoriaBL {

    private CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    public List<Categoria> listarCategorias() {
        return categoriaDAO.listarTodo();
    }

    @Override
    public Categoria obtenerCategoriaPorId(int id) {
        return categoriaDAO.obtenerPorId(id);
    }
}
