package pe.ventasysejb.dao;

import pe.ventasysejb.entity.Categoria;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class CategoriaDAO {

    private EntityManagerFactory emf;

    public CategoriaDAO() {
        emf = Persistence.createEntityManagerFactory("BD_TecnoStockPU");
    }

    public List<Categoria> listarTodo() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Categoria> query = em.createQuery("SELECT c FROM Categoria c", Categoria.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Categoria obtenerPorId(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Categoria.class, id);
        } finally {
            em.close();
        }
    }
}
