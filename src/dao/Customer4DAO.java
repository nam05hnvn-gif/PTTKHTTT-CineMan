package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Customer4;
import model.MemberCard4;

public class Customer4DAO extends DAO4 {

    public Customer4DAO() {
        super();
    }

    public Customer4 getCustomerByUsernamePassword(String username, String password) {
        String sql = "SELECT u.id, u.username, u.password, u.fullName, u.dateOfBirth, u.gender, "
            + "u.phoneNumber, u.email, u.role, u.accountStatus, "
            + "m.membershipCode, m.membershipRegistrationDate, m.rewardPoints "
            + "FROM tblUser4 u "
            + "JOIN tblCustomer4 c ON c.tblUser4id = u.id "
            + "LEFT JOIN tblMemberCard4 m ON m.membershipCode = c.tblMemberCard4membershipCode "
            + "WHERE u.username = ? AND u.password = ? AND u.role = 'customer' AND u.accountStatus = 'active'";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                Customer4 customer = new Customer4();
                customer.setId(rs.getInt("id"));
                customer.setUsername(rs.getString("username"));
                customer.setPassword(rs.getString("password"));
                customer.setFullName(rs.getString("fullName"));
                customer.setDateOfBirth(rs.getDate("dateOfBirth").toLocalDate());
                customer.setGender(rs.getString("gender"));
                customer.setPhoneNumber(rs.getString("phoneNumber"));
                customer.setEmail(rs.getString("email"));
                customer.setRole(rs.getString("role"));
                customer.setAccountStatus(rs.getString("accountStatus"));
                String code = rs.getString("membershipCode");
                if (code != null) {
                    MemberCard4 card = new MemberCard4();
                    card.setMembershipCode(code);
                    card.setMembershipRegistrationDate(rs.getDate("membershipRegistrationDate").toLocalDate());
                    card.setRewardPoints(rs.getInt("rewardPoints"));
                    customer.setMemberCard(card);
                }
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public Customer4 getCustomerInfo(String membershipCode) {
        String sql = "SELECT u.id, u.username, u.password, u.fullName, u.dateOfBirth, u.gender, "
            + "u.phoneNumber, u.email, u.role, u.accountStatus, "
            + "m.membershipCode, m.membershipRegistrationDate, m.rewardPoints "
            + "FROM tblUser4 u "
            + "JOIN tblCustomer4 c ON c.tblUser4id = u.id "
            + "LEFT JOIN tblMemberCard4 m ON m.membershipCode = c.tblMemberCard4membershipCode "
            + "WHERE m.membershipCode = ? AND u.role = 'customer' AND u.accountStatus = 'active'";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, membershipCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                Customer4 customer = new Customer4();
                customer.setId(rs.getInt("id"));
                customer.setUsername(rs.getString("username"));
                customer.setPassword(rs.getString("password"));
                customer.setFullName(rs.getString("fullName"));
                customer.setDateOfBirth(rs.getDate("dateOfBirth").toLocalDate());
                customer.setGender(rs.getString("gender"));
                customer.setPhoneNumber(rs.getString("phoneNumber"));
                customer.setEmail(rs.getString("email"));
                customer.setRole(rs.getString("role"));
                customer.setAccountStatus(rs.getString("accountStatus"));
                MemberCard4 card = new MemberCard4();
                card.setMembershipCode(rs.getString("membershipCode"));
                card.setMembershipRegistrationDate(rs.getDate("membershipRegistrationDate").toLocalDate());
                card.setRewardPoints(rs.getInt("rewardPoints"));
                customer.setMemberCard(card);
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean checkDuplicateCustomer(Customer4 customer) {
        // SĐT/email đã bị TÀI KHOẢN KHÁC dùng -> trung (loai tru chinh khach hang dang dang nhap)
        String sql = "SELECT id FROM tblUser4 WHERE (phoneNumber = ? OR (email IS NOT NULL AND email = ?)) AND id <> ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, customer.getPhoneNumber());
            ps.setString(2, customer.getEmail());
            ps.setInt(3, customer.getId());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return true;
        }
    }

    public boolean saveCustomer(Customer4 customer) {
        // cap nhat thong tin user hien co + tao the thanh vien + gan the vao khach hang (1 transaction)
        String sqlCard = "INSERT INTO tblMemberCard4(membershipCode, membershipRegistrationDate, rewardPoints) VALUES (?, ?, ?)";
        String sqlUser = "UPDATE tblUser4 SET fullName = ?, dateOfBirth = ?, gender = ?, phoneNumber = ?, email = ? WHERE id = ?";
        String sqlCustomer = "UPDATE tblCustomer4 SET tblMemberCard4membershipCode = ? WHERE tblUser4id = ?";
        try {
            con.setAutoCommit(false);

            try (PreparedStatement psCard = con.prepareStatement(sqlCard)) {
                psCard.setString(1, customer.getMemberCard().getMembershipCode());
                psCard.setDate(2, Date.valueOf(customer.getMemberCard().getMembershipRegistrationDate()));
                psCard.setInt(3, customer.getMemberCard().getRewardPoints());
                psCard.executeUpdate();
            }

            try (PreparedStatement psUser = con.prepareStatement(sqlUser)) {
                psUser.setString(1, customer.getFullName());
                psUser.setDate(2, Date.valueOf(customer.getDateOfBirth()));
                psUser.setString(3, customer.getGender());
                psUser.setString(4, customer.getPhoneNumber());
                psUser.setString(5, customer.getEmail());
                psUser.setInt(6, customer.getId());
                psUser.executeUpdate();
            }

            try (PreparedStatement psCustomer = con.prepareStatement(sqlCustomer)) {
                psCustomer.setString(1, customer.getMemberCard().getMembershipCode());
                psCustomer.setInt(2, customer.getId());
                psCustomer.executeUpdate();
            }

            con.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
