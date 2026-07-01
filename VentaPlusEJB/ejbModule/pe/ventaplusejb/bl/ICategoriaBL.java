package pe.ventaplusejb.bl;

import java.util.List;

import pe.ventaplusejb.entity.Categoria;

public interface ICategoriaBL {

	void registrarCategoria(Categoria categoria) throws Exception;

	void actualizarCategoria(Categoria categoria) throws Exception;

	void eliminarCategoria(Integer id) throws Exception;

	Categoria obtenerCategoriaPorId(Integer id) throws Exception;

	List<Categoria> buscarCategoriaPorNombre(String nombre) throws Exception;

	List<Categoria> listarCategorias() throws Exception;
}
