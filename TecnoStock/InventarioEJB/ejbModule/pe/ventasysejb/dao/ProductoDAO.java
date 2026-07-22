package pe.ventasysejb.dao;

import pe.ventasysejb.entity.Producto;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class ProductoDAO {

    private EntityManagerFactory emf;

    public ProductoDAO() {
        emf = Persistence.createEntityManagerFactory("BD_TecnoStockPU");
    }

    public void insertar(Producto producto) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(producto);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
