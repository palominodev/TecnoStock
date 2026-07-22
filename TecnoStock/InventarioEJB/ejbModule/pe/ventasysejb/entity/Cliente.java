package pe.ventasysejb.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedNativeQueries;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import java.io.Serializable;

@Entity
@NamedQueries({
    @NamedQuery(
        name = "Cliente.listarTodos",
        query = "SELECT c FROM Cliente c"
    ),
    @NamedQuery(
        name = "Cliente.buscarPorId",
        query = "SELECT c FROM Cliente c WHERE c.id = :id"
    ),
    @NamedQuery(
        name = "Cliente.buscarxApellidoPaterno",
        query = "SELECT c FROM Cliente c WHERE c.apellidoPaterno like CONCAT('%', :apellidoPaterno, '%')"
    ),
    @NamedQuery(
        name = "Cliente.actualizar",
        query = "UPDATE Cliente c SET c.nombre = :nombre, c.apellidoPaterno = :apellidoPaterno, c.apellidoMaterno = :apellidoMaterno, c.dni = :dni, c.direccion = :direccion where c.id = :id"
    ),
    @NamedQuery(
        name = "Cliente.eliminarFisico",
        query = "DELETE FROM Cliente c WHERE c.id = :id"
    ),
    @NamedQuery(
        name = "Cliente.eliminarLogico",
        query = "UPDATE Cliente c SET c.estado = 'I' WHERE c.id = :id"
    )   
})

@NamedNativeQueries({
    @NamedNativeQuery(
        name = "Cliente.insertar",
        query = "INSERT Cliente(nombre,apellidoPaterno,apellidoMaterno,dni,direccion,estado) VALUES(?,?,?,?,?,?)"
    )
})
public class Cliente implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String nombre;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String dni;
    private String direccion;
    private String estado;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getApellidoPaterno() {
        return apellidoPaterno;
    }
    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }
    public String getApellidoMaterno() {
        return apellidoMaterno;
    }
    public void setApellidoMaterno(String apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }
    public String getDni() {
        return dni;
    }
    public void setDni(String dni) {
        this.dni = dni;
    }
    public String getDireccion() {
        return direccion;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }
}
