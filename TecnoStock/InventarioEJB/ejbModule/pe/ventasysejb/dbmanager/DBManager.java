package pe.ventasysejb.dbmanager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {
	
	private static DBManager instancia;
	private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=BD_TecnoStock;user=sa;password=sa;Encrypt=True;TrustServerCertificate=True";
	
	private DBManager() {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static DBManager getInstancia() {
		if (instancia == null) {
			instancia = new DBManager();
		}
		return instancia;
	}
	
	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL);
	}
}
