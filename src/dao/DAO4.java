package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO4 {
    protected Connection con;

    public DAO4() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String username = requiredEnv("CINEMAN_DB_USER");
            String password = requiredEnv("CINEMAN_DB_PASSWORD");
            con = DriverManager.getConnection(
                    System.getenv().getOrDefault(
                            "CINEMAN_DB_URL",
                            "jdbc:mysql://localhost:3306/cineman?characterEncoding=UTF-8"),
                    username, password);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException("Khong the ket noi CSDL cineman", e);
        }
    }

    private String requiredEnv(String name) {
        String value = System.getenv(name);
        if (value == null || value.isBlank()) {
            throw new IllegalStateException("Missing required environment variable: " + name);
        }
        return value;
    }

    public void close() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
