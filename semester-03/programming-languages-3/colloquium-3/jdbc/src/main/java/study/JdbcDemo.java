package study;

import java.sql.*;

public class JdbcDemo {
    public static void main(String[] args) throws SQLException {
        try (Connection connection = DriverManager.getConnection("jdbc:h2:mem:library", "sa", "")) {
            try (Statement statement = connection.createStatement()) {
                statement.executeUpdate("CREATE TABLE book(id INT PRIMARY KEY, title VARCHAR(100), copies INT CHECK(copies >= 0))");
                statement.executeUpdate("INSERT INTO book VALUES(1, 'Java', 2)");
            }
            connection.setAutoCommit(false);
            try (PreparedStatement statement = connection.prepareStatement("UPDATE book SET copies = copies - 1 WHERE id=? AND copies > 0")) {
                statement.setInt(1, 1);
                if (statement.executeUpdate() != 1) throw new SQLException("Unavailable");
                connection.commit();
            } catch (SQLException e) {
                connection.rollback();
                throw e;
            } finally {
                connection.setAutoCommit(true);
            }
            try (PreparedStatement query = connection.prepareStatement("SELECT title,copies FROM book WHERE id=?")) {
                query.setInt(1, 1);
                try (ResultSet rows = query.executeQuery()) {
                    while (rows.next()) System.out.println(rows.getString("title") + ": " + rows.getInt("copies"));
                }
            }
        }
    }
}
