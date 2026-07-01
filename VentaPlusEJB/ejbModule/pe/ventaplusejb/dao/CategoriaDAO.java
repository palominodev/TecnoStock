package pe.ventaplusejb.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

import pe.ventaplusejb.entity.Categoria;

public class CategoriaDAO {

	private static volatile EntityManagerFactory EMF;

	public CategoriaDAO() {
	}

	private static EntityManagerFactory getEMF() {
		if (EMF == null) {
			synchronized (CategoriaDAO.class) {
				if (EMF == null) {
					EMF = Persistence.createEntityManagerFactory("VentaplusPU");
				}
			}
		}
		return EMF;
	}

	public List<Categoria> listarTodas() {
		try (EntityManager em = getEMF().createEntityManager()) {
			TypedQuery<Categoria> query = em.createNamedQuery("Categoria.listarTodas", Categoria.class);
			return query.getResultList();
		}
	}

	public Categoria buscarPorId(Integer id) {
		try (EntityManager em = getEMF().createEntityManager()) {
			TypedQuery<Categoria> query = em.createNamedQuery("Categoria.buscarPorId", Categoria.class);
			query.setParameter("id", id);
			return query.getSingleResult();
		}
	}

	public List<Categoria> buscarPorNombre(String nombre) {
		try (EntityManager em = getEMF().createEntityManager()) {
			TypedQuery<Categoria> query = em.createNamedQuery("Categoria.buscarPorNombre", Categoria.class);
			query.setParameter("nombre", nombre);
			return query.getResultList();
		}
	}

	public void insertar(Categoria c) {
		try (EntityManager em = getEMF().createEntityManager()) {
			em.getTransaction().begin();
			Query query = em.createNamedQuery("Categoria.insertCategoria");
			query.setParameter("nombre", c.getNombre());
			query.setParameter("descripcion", c.getDescripcion());
			query.setParameter("estado", c.getEstado() != null ? c.getEstado() : "A");
			query.executeUpdate();
			em.getTransaction().commit();
		}
	}

	public void actualizar(Categoria c) {
		try (EntityManager em = getEMF().createEntityManager()) {
			em.getTransaction().begin();
			Query query = em.createNamedQuery("Categoria.updateCategoria");
			query.setParameter("nombre", c.getNombre());
			query.setParameter("descripcion", c.getDescripcion());
			query.setParameter("estado", c.getEstado() != null ? c.getEstado() : "A");
			query.setParameter("id", c.getId());
			query.executeUpdate();
			em.getTransaction().commit();
		}
	}

	public void eliminarLogico(Integer id) {
		try (EntityManager em = getEMF().createEntityManager()) {
			em.getTransaction().begin();
			Query query = em.createNamedQuery("Categoria.eliminarLogicoCategoria");
			query.setParameter("id", id);
			query.executeUpdate();
			em.getTransaction().commit();
		}
	}
}
