package pe.ventasysejb.dao;

import pe.ventasysejb.entity.Sucursal;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class SucursalDAO {

    private EntityManagerFactory emf;

    public SucursalDAO() {
        emf = Persistence.createEntityManagerFactory("BD_TecnoStockPU");
    }

    public void insertar(Sucursal sucursal) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(sucursal);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void actualizar(Sucursal sucursal) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(sucursal);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void eliminar(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Sucursal sucursal = em.find(Sucursal.class, id);
            if (sucursal != null) {
                em.remove(sucursal);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Sucursal obtenerPorId(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Sucursal.class, id);
        } finally {
            em.close();
        }
    }

    public List<Sucursal> listarTodo() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Sucursal> query = em.createQuery("SELECT s FROM Sucursal s", Sucursal.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Sucursal> buscarPorNombre(String nombre) {
        EntityManager em = emf.createEntityManager();
        try {
            if (nombre == null || nombre.trim().isEmpty()) {
                TypedQuery<Sucursal> query = em.createQuery("SELECT s FROM Sucursal s", Sucursal.class);
                return query.getResultList();
            }
            TypedQuery<Sucursal> query = em.createQuery(
                "SELECT s FROM Sucursal s WHERE s.nombre LIKE :nombre", Sucursal.class);
            query.setParameter("nombre", "%" + nombre + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
