package pe.ventasysejb.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import pe.ventasysejb.model.Proveedor;

public class ProveedorDAO {
			
	private EntityManagerFactory emf;

	public ProveedorDAO() {
		emf = Persistence.createEntityManagerFactory("BD_TecnoStockPU");
	}

	public void save(Proveedor proveedor) {
		EntityManager em = emf.createEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(proveedor);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw e;
		} finally {
			em.close();
		}
	}
	
	public void update(Proveedor proveedor) {
		EntityManager em = emf.createEntityManager();
		try {
			em.getTransaction().begin();
			em.merge(proveedor);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw e;
		} finally {
			em.close();
		}
	}
	
	public void removeLogic(int id) {
		EntityManager em = emf.createEntityManager();
		try {
			em.getTransaction().begin();
			Proveedor proveedor = em.find(Proveedor.class, id);
			if (proveedor != null) {
				proveedor.setEstado("Inactivo");
				em.merge(proveedor);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw e;
		} finally {
			em.close();
		}
	}
	
	public Proveedor load(int id) {
		EntityManager em = emf.createEntityManager();
		try {
			return em.find(Proveedor.class, id);
		} finally {
			em.close();
		}
	}
	
	public List<Proveedor> listAll() {
		EntityManager em = emf.createEntityManager();
		try {
			TypedQuery<Proveedor> query = em.createQuery("SELECT p FROM Proveedor p", Proveedor.class);
			return query.getResultList();
		} finally {
			em.close();
		}
	}
}
