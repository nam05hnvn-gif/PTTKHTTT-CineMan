package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.User4;

public class User4DAO extends DAO4 {

    public User4DAO() {
        super();
    }

    public User4 getUserByUsernamePassword(String username, String password) {
        String sql = "SELECT id, username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus "
                + "FROM tblUser4 WHERE username = ? AND password = ? AND accountStatus = 'active'";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                User4 user = new User4();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("fullName"));
                user.setDateOfBirth(rs.getDate("dateOfBirth").toLocalDate());
                user.setGender(rs.getString("gender"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setAccountStatus(rs.getString("accountStatus"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
