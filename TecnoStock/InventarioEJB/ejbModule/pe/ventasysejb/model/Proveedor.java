package pe.ventasysejb.model;

import java.io.Serializable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Proveedor")
public class Proveedor implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "ruc", nullable = false, unique = true, length = 20)
    private String ruc;

    @Column(name = "razonSocial", nullable = false, length = 150)
    private String razonSocial;

    @Column(name = "direccion", length = 200)
    private String direccion;

    @Column(name = "telefono", length = 20)
    private String telefono;

    @Column(name = "nombreContacto", length = 100)
    private String nombreContacto;

    @Column(name = "estado", nullable = false, length = 20)
    private String estado;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getRuc() {
        return ruc;
    }
    public void setRuc(String ruc) {
        this.ruc = ruc;
    }
    public String getRazonSocial() {
        return razonSocial;
    }
    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }
    public String getDireccion() {
        return direccion;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public String getTelefono() {
        return telefono;
    }
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    public String getNombreContacto() {
        return nombreContacto;
    }
    public void setNombreContacto(String nombreContacto) {
        this.nombreContacto = nombreContacto;
    }
    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }
}
