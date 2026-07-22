package pe.ventasysejb.businesslogic;

import pe.ventasysejb.entity.Categoria;
import java.util.List;
public interface ICategoriaBL {
    List<Categoria> listarCategorias();
    Categoria obtenerCategoriaPorId(int id);
}
