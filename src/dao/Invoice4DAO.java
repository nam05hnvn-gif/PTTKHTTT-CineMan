package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import model.Invoice4;
import model.MovieTicket4;

public class Invoice4DAO extends DAO4 {

    public Invoice4DAO() {
        super();
    }

    public boolean saveInvoice(Invoice4 invoice) {
        String sqlInvoice = "INSERT INTO tblInvoice4(paymentMethod, tblCustomer4tblUser4id, tblSalesStaff4tblUser4id) VALUES (?, ?, ?)";
        String sqlTicket = "INSERT INTO tblMovieTicket4(price, tblShowtime4id, tblSeat4id, tblInvoice4id) VALUES (?, ?, ?, ?)";
        try {
            con.setAutoCommit(false);

            try (PreparedStatement ps = con.prepareStatement(sqlInvoice, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, invoice.getPaymentMethod());
                if (invoice.getCustomer() != null) {
                    ps.setInt(2, invoice.getCustomer().getId());
                } else {
                    ps.setNull(2, Types.INTEGER);
                }
                if (invoice.getSalesStaff() != null) {
                    ps.setInt(3, invoice.getSalesStaff().getId());
                } else {
                    ps.setNull(3, Types.INTEGER);
                }
                ps.executeUpdate();
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        invoice.setId(keys.getInt(1));
                    }
                }
            }

            try (PreparedStatement ps = con.prepareStatement(sqlTicket)) {
                for (MovieTicket4 ticket : invoice.getMovieTickets()) {
                    ps.setBigDecimal(1, ticket.getPrice());
                    ps.setInt(2, ticket.getShowtime().getId());
                    ps.setInt(3, ticket.getSeat().getId());
                    ps.setInt(4, invoice.getId());
                    ps.addBatch();
                }
                ps.executeBatch();
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
