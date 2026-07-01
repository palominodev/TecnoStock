package pe.ventaplusejb.bl;

import java.util.List;

import pe.ventaplusejb.dao.CategoriaDAO;
import pe.ventaplusejb.entity.Categoria;

public class CategoriaBL implements ICategoriaBL {

	private static final int MAX_NOMBRE_LENGTH = 50;
	private static final int MAX_DESCRIPCION_LENGTH = 200;

	private CategoriaDAO dao = new CategoriaDAO();

	private void validarCategoria(Categoria c, boolean requiereId) {
		if (c == null) {
			throw new IllegalArgumentException("La categoría no puede ser nula.");
		}
		if (c.getNombre() == null || c.getNombre().isBlank()) {
			throw new IllegalArgumentException("El nombre de la categoría es obligatorio.");
		}
		if (c.getNombre().length() > MAX_NOMBRE_LENGTH) {
			throw new IllegalArgumentException("El nombre no puede superar los " + MAX_NOMBRE_LENGTH + " caracteres.");
		}
		if (c.getDescripcion() != null && c.getDescripcion().length() > MAX_DESCRIPCION_LENGTH) {
			throw new IllegalArgumentException("La descripción no puede superar los " + MAX_DESCRIPCION_LENGTH + " caracteres.");
		}
		if (requiereId && c.getId() == null) {
			throw new IllegalArgumentException("El id de la categoría es obligatorio.");
		}
	}

	@Override
	public void registrarCategoria(Categoria categoria) throws Exception {
		validarCategoria(categoria, false);
		dao.insertar(categoria);
	}

	@Override
	public void actualizarCategoria(Categoria categoria) throws Exception {
		validarCategoria(categoria, true);
		dao.actualizar(categoria);
	}

	@Override
	public void eliminarCategoria(Integer id) throws Exception {
		if (id == null || id <= 0) {
			throw new IllegalArgumentException("El id debe ser un valor positivo.");
		}
		dao.eliminarLogico(id);
	}

	@Override
	public Categoria obtenerCategoriaPorId(Integer id) throws Exception {
		if (id == null || id <= 0) {
			throw new IllegalArgumentException("El id debe ser un valor positivo.");
		}
		return dao.buscarPorId(id);
	}

	@Override
	public List<Categoria> buscarCategoriaPorNombre(String nombre) throws Exception {
		if (nombre == null || nombre.isBlank()) {
			throw new IllegalArgumentException("El nombre es obligatorio para la búsqueda.");
		}
		return dao.buscarPorNombre(nombre);
	}

	@Override
	public List<Categoria> listarCategoriasActivas() throws Exception {
		return dao.listarActivas();
	}
}
