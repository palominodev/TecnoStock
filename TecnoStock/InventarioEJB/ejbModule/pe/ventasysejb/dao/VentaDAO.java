package pe.ventasysejb.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import pe.ventasysejb.entity.Venta;

public class VentaDAO {

    private EntityManagerFactory emf;

    public VentaDAO() {
        emf = Persistence.createEntityManagerFactory("BD_TecnoStockPU");
    }

    public void insertar(Venta venta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(venta);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void actualizar(Venta venta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(venta);
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
            Venta venta = em.find(Venta.class, id);
            if (venta != null) {
                em.remove(venta);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Venta buscar(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Venta.class, id);
        } finally {
            em.close();
        }
    }

    public List<Venta> listarVentasConNamedQueryJPQL() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Venta> query = em.createNamedQuery("Venta.listarConCliente", Venta.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Venta> listarVentasSinNamedQuery() {
        EntityManager em = emf.createEntityManager();
        try {
            String queryJPQL = "Select v FROM Venta v JOIN FETCH v.cliente";
            TypedQuery<Venta> query = em.createQuery(queryJPQL, Venta.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Venta> listarVentasConNamedQuerySQL() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Venta> query = em.createNamedQuery("Venta.listarSQL", Venta.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Venta> buscarxCliente(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT v FROM Venta v WHERE v.cliente.id = :id";
            TypedQuery<Venta> query = em.createQuery(jpql, Venta.class);
            query.setParameter("id", id);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
