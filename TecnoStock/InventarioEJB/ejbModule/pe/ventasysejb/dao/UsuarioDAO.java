package pe.ventasysejb.dao;

import pe.ventasysejb.entity.Usuario;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class UsuarioDAO {

    private EntityManagerFactory emf;

    public UsuarioDAO() {
        emf = Persistence.createEntityManagerFactory("BD_TecnoStockPU");
    }

    public void insertar(Usuario usuario) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(usuario);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void actualizar(Usuario usuario) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(usuario);
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
            Usuario usuario = em.find(Usuario.class, id);
            if (usuario != null) {
                em.remove(usuario);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Usuario obtenerPorId(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Usuario.class, id);
        } finally {
            em.close();
        }
    }

    public Usuario obtenerUsuarioLogin(String correo, String contrasenha) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Usuario> query = em.createQuery(
                "SELECT u FROM Usuario u WHERE u.correo = :correo AND u.contrasenha = :contrasenha AND u.estado = 'Activo'",
                Usuario.class);
            query.setParameter("correo", correo);
            query.setParameter("contrasenha", contrasenha);
            List<Usuario> resultList = query.getResultList();
            if (resultList != null && !resultList.isEmpty()) {
                return resultList.get(0);
            }
        } catch (Exception e) {
            // Return null
        } finally {
            em.close();
        }
        return null;
    }
}
