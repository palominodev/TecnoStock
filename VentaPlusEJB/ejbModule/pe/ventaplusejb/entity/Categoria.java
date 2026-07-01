package pe.ventaplusejb.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedNativeQueries;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name = "Categoria")
@NamedQueries({
	@NamedQuery(
			name = "Categoria.listarActivas",
			query = "SELECT c FROM Categoria c WHERE c.estado = 'A' ORDER BY c.nombre"
			),
	@NamedQuery(
			name = "Categoria.buscarPorId",
			query = "SELECT c FROM Categoria c WHERE c.id = :id"
			),
	@NamedQuery(
			name = "Categoria.buscarPorNombre",
			query = "SELECT c FROM Categoria c WHERE c.nombre = :nombre"
			)
})
@NamedNativeQueries({
	@NamedNativeQuery(
			name = "Categoria.insertCategoria",
			query = "INSERT INTO categoria (nombre, descripcion, estado) VALUES (:nombre, :descripcion, :estado)"
			),
	@NamedNativeQuery(
			name = "Categoria.updateCategoria",
			query = "UPDATE categoria SET nombre = :nombre, descripcion = :descripcion WHERE id = :id"
			),
	@NamedNativeQuery(
			name = "Categoria.eliminarLogicoCategoria",
			query = "UPDATE categoria SET estado = 'I' WHERE id = :id"
			)
})
public class Categoria {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(nullable = false, length = 50)
	private String nombre;

	@Column(length = 200)
	private String descripcion;

	@Column(nullable = false, length = 1)
	private String estado = "A";

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (!(o instanceof Categoria)) return false;
		Categoria other = (Categoria) o;
		return id != null && id.equals(other.id);
	}

	@Override
	public int hashCode() {
		return id != null ? id.hashCode() : 0;
	}

	@Override
	public String toString() {
		return "Categoria[id=" + id + ", nombre=" + nombre + ", estado=" + estado + "]";
	}
}
