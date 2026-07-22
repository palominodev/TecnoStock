package pe.ventasysejb.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import pe.ventasysejb.entity.Cliente;

public class ClienteDAO {
	
	private EntityManagerFactory emf;
	
	public ClienteDAO() {
		emf = Persistence.createEntityManagerFactory("BD_TecnoStockPU");
	}
	
	public void registrar(Cliente cliente) {
		EntityManager em = emf.createEntityManager();
		try {
			em.getTransaction().begin();
			Query query = em.createNamedQuery("Cliente.insertar");
			query.setParameter(1, cliente.getNombre());
			query.setParameter(2, cliente.getApellidoPaterno());
			query.setParameter(3, cliente.getApellidoMaterno());
			query.setParameter(4, cliente.getDni());
			query.setParameter(5, cliente.getDireccion());
			query.setParameter(6, cliente.getEstado());
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw e;
		} finally {
			em.close();
		}
	}
	
	public Cliente buscarporId(int id) {
		EntityManager em = emf.createEntityManager();
		try {
			TypedQuery<Cliente> query = em.createNamedQuery("Cliente.buscarPorId", Cliente.class);
			query.setParameter("id", id);
			return query.getSingleResult();			
		} catch (Exception e) {
			return null;
		} finally {
			em.close();
		}
	}
	
	public List<Cliente> buscarTodos() {
		EntityManager em = emf.createEntityManager();
		try {
			TypedQuery<Cliente> query = em.createNamedQuery("Cliente.listarTodos", Cliente.class);
			return query.getResultList();			
		} finally {
			em.close();
		}
	}
	
	public List<Cliente> buscarPorApellidoPaterno(String apellidoPaterno) {
		EntityManager em = emf.createEntityManager();
		try {
			TypedQuery<Cliente> query = em.createNamedQuery("Cliente.buscarxApellidoPaterno", Cliente.class);
			query.setParameter("apellidoPaterno", apellidoPaterno);
			return query.getResultList();			
		} finally {
			em.close();
		}
	}
	
	public void actualizar(Cliente cliente) {
		EntityManager em = emf.createEntityManager();
		try {
			em.getTransaction().begin();
			Query query = em.createNamedQuery("Cliente.actualizar");
			query.setParameter("nombre", cliente.getNombre());
			query.setParameter("apellidoPaterno", cliente.getApellidoPaterno());
			query.setParameter("apellidoMaterno", cliente.getApellidoMaterno());
			query.setParameter("dni", cliente.getDni());
			query.setParameter("direccion", cliente.getDireccion());
			query.setParameter("id", cliente.getId());
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw e;
		} finally {
			em.close();
		}
	}
	
	public void eliminarLogico(int id) {
		EntityManager em = emf.createEntityManager();
		try {
			em.getTransaction().begin();
			Query query = em.createNamedQuery("Cliente.eliminarLogico");
			query.setParameter("id", id);
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw e;
		} finally {
			em.close();
		}
	}
	
	public void eliminarFisico(int id) {
		EntityManager em = emf.createEntityManager();
		try {
			em.getTransaction().begin();
			Query query = em.createNamedQuery("Cliente.eliminarFisico");
			query.setParameter("id", id);
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw e;
		} finally {
			em.close();
		}
	}
}
