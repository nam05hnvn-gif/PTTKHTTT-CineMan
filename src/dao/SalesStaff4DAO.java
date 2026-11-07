package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.SalesStaff4;

public class SalesStaff4DAO extends DAO4 {

    public SalesStaff4DAO() {
        super();
    }

    public SalesStaff4 getSalesStaffByUsernamePassword(String username, String password) {
        String sql = "SELECT u.id, u.username, u.password, u.fullName, u.dateOfBirth, u.gender, "
                + "u.phoneNumber, u.email, u.role, u.accountStatus, "
                + "s.position, s.workShift "
                + "FROM tblUser4 u "
                + "JOIN tblSalesStaff4 s ON s.tblUser4id = u.id "
                + "WHERE u.username = ? AND u.password = ? AND u.role = 'sales_staff' AND u.accountStatus = 'active'";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                SalesStaff4 staff = new SalesStaff4();
                staff.setId(rs.getInt("id"));
                staff.setUsername(rs.getString("username"));
                staff.setPassword(rs.getString("password"));
                staff.setFullName(rs.getString("fullName"));
                staff.setDateOfBirth(rs.getDate("dateOfBirth").toLocalDate());
                staff.setGender(rs.getString("gender"));
                staff.setPhoneNumber(rs.getString("phoneNumber"));
                staff.setEmail(rs.getString("email"));
                staff.setRole(rs.getString("role"));
                staff.setAccountStatus(rs.getString("accountStatus"));
                staff.setPosition(rs.getString("position"));
                staff.setWorkShift(rs.getString("workShift"));
                return staff;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
